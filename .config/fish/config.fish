set PATH ~/bin $PATH
set -x LC_CTYPE en_US.UTF-8
set -x LC_ALL en_US.UTF-8

fish_vi_key_bindings

# key bindings
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
  bind \c] peco_select_ghq_repository
  bind \cx\cr peco_recentd
end

# prompts

# function fish_prompt --description 'Write out the prompt'
#     set_color green
#     printf '%s' (whoami)
#     set_color white
#     printf '@'
#     set_color yellow
#     printf '%s ' (prompt_hostname)
#     set_color green
#     printf '%s' (prompt_pwd)
#     set_color white
#     printf '> '
# end
# 
# function fish_right_prompt 
#     date +"[%H:%m:%S]"
# end

function fish_mode_prompt
    # NOOP - Disable vim mode indicator
end

# alias
alias g='git'
alias vim='nvim'
alias be='bundle exec'

# rbenv
status --is-interactive; and rbenv init - | source

# tmux
function attach_tmux_session_if_needed
    set ID (tmux list-sessions)
    if test -z "$ID"
        tmux new-session
        return
    end

    set new_session "Create New Session" 
    set ID (echo $ID\n$new_session | peco --on-cancel=error | cut -d: -f1)
    if test "$ID" = "$new_session"
        tmux new-session
    else if test -n "$ID"
        tmux attach-session -t "$ID"
    end
end

if test -z $TMUX && status --is-login
    attach_tmux_session_if_needed
end
