$tempPath = $env:path + ';'
cat $($env:Box_ROOT + "\psconfig\path.config") | foreach { 
    $tempPath += ( (iex $_) + ';' )
}
$env:path = $tempPath
$tempPath= ""
$env:HOME = $env:BOX_ROOT + "\HOME"
Set-Alias -Name "ec" -Value "runemacs"
Set-Alias -Name "time" -Value "Measure-Command"
Set-Alias -Name "grep" -Value "Select-String"
Set-Alias -Name "e." -Value "explorer"
# if $(git branch)
function prompt {
    $USER = "vtheno"
    Write-Host "$USER" -NoNewLine -ForegroundColor "Red"
    Write-Host "@" -NoNewLine -ForegroundColor "Red"
    Write-Host "{ $pwd } " -NoNewLine -ForegroundColor "Magenta"
    
    # ## is branch name , ?? is +, D is - ,M is ~ change
    $git_branch_name=""
    $git_mod_count=0
    $git_del_count=0
    $git_new_count=0
    $(git status --short --branch --porcelain) | foreach {
	if ($_.StartsWith("##")) {
	    $git_branch_name = $_.Split("...")[0].Substring(3)
	}
	if ($_.StartsWith(" M")){
	    $git_mod_count += 1
	}
	if ($_.StartsWith(" D")) {
	    $git_del_count += 1
	}
	if ($_.StartsWith("RD")) {
	    $git_del_count += 1
	}
	if ($_.StartsWith("??")) {
	    $git_new_count += 1
	}
    }
    if ($git_branch_name) {
	Write-Host "[ " -NoNewLine -ForegroundColor "DarkBlue"
	Write-Host "$git_branch_name " -NoNewLine -ForegroundColor "DarkCyan"
	Write-Host "+$git_new_count " -NoNewLine -ForegroundColor "Green"
	Write-Host "~$git_mod_count " -NoNewLine -ForegroundColor "DarkMagenta"
	Write-Host "-$git_del_count " -NoNewLine -ForegroundColor "Red"
	Write-Host "] " -NoNewLine -ForegroundColor "DarkBlue"
    }
    Write-Host "=> " -NoNewLine -ForegroundColor "DarkGreen"
    return " "
}
# show env => ls env: 
cd E:
