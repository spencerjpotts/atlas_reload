; File: atals_reload_1080p
; Author: Spencer J Potts
; Description: Automates / performs click actions in the mini games provided in 'Atlas' survival.
; Date: 1/12/2019
; Game: playatlas / atlas survival


;;TODO
;; add playatlas window handler.

#include %A_ScriptDir%\includes\console_include.ahk
global console = new BensConsole()

global i := 0


; a function to perform logs for debugging.. IF debuging is enabled.
global debug := false ; true= enabled, false = disabled.
debuglog(message) {
  if (debug = true) {
    console.log(message)
  }
}



F6::
  i := 1
  debuglog("[!] Action performed: - F6 pressed. Script stopped.")
  return

F5::
  ; debugging information.
  ; debug - initiate script prompt.
  debuglog("[*] Scanning started waiting for reload action.")

  ; Check if image exists, if it doesn't close loop and return for script shutdown.
  ; ;
  imagePattern = %A_ScriptDir%\images_1920x1080\pattern1080p.png
  IfNotExist, %imagePattern%
    debuglog("[!] Image file doesn't exist. Ensure that the correct image/icon exits in the correct directory.")

  ; Start the scan with a loop, loop breaks when user clicks F6 what will stop the script.
  while (%i% = 0) {

    ; Loop over the position where the dialog box the mini game boundaries are, once the black pixel is found,
    ; it will start to scan for the red pin object.
    loop {
      PixelSearch, px, py, 759, 888, 759, 888, 0x000000, 3, Fast
      if (ErrorLevel = 0) {
        debuglog("[*] found mini game boundaries. exiting loop 1.")
        break
      }
    }


    ;; Enter the new loop below, this loop will scan and automate the action of clicks 'left click'
    ;; when the red marker is aligned / overlayed with the white horizontal line.
    ;; perform click and reset to first loop above to detect the mini game dialog pop.
    loop {
      ;
      ImageSearch, outputX, outputY, 748, 874, 1173, 911, %imagePattern%
      ; ImageSearch, outputX, outputY, imgAnchorXy[0], imgAnchorXy[1], imgAnchorYx[0], imgAnchorYx[1], %imagePattern%
      if (ErrorLevel = 1) {
        Click
        ; Check if the click registered in time by checking the colour of the pixel,
        PixelSearch, px, py, 748, 874, 748, 874, 0x00FF00, 3, Fast
        if (ErrorLevel = 0) {
          ; debug information; if green pixel is found promt user in debug mode that 'left click' was successful.
          debuglog("Loaded Successfully.")
        }

        break
      }

    }
  }
return
