Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576677E0287
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346571AbjKCMGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346467AbjKCMGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:06:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48571BC;
        Fri,  3 Nov 2023 05:06:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFFD5C433C8;
        Fri,  3 Nov 2023 12:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699013191;
        bh=l8la88+WIRco7bNmYSw5aIS4j73NGdDemhYyZdVP1A8=;
        h=Date:From:To:Cc:Subject:From;
        b=rB6DdT6t5D5wfHA3gEdGLwrXeFb18HXJvuCSIZAOEBJv4Fn9o6Ixicf5S4EV7Fcqg
         ST4KtWJ8ojtsQL14ricYBharunNHX/96Gmx/tyF1K3w1QtKW3azeFAcd3yBxmlCeuP
         KNzC+FBxE+yJYM8cISSoLp9+Y/CQvvKU8sc8AkaU=
Date:   Fri, 3 Nov 2023 13:06:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver updates for 6.7-rc1
Message-ID: <ZUTiQ-zSU7oE1BhJ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 58720809f52779dc0f08e53e54b014209d13eebb:

  Linux 6.6-rc6 (2023-10-15 13:34:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.7-rc1

for you to fetch changes up to 64ebf8797249e792af2143eb9e4bd404d10a022e:

  serdev: Replace custom code with device_match_acpi_handle() (2023-10-27 13:04:11 +0200)

----------------------------------------------------------------
TTY/Serial changes for 6.7-rc1

Here is the big set of tty/serial driver changes for 6.7-rc1.  Included
in here are:
  - console/vgacon cleanups and removals from Arnd
  - tty core and n_tty cleanups from Jiri
  - lots of 8250 driver updates and cleanups
  - sc16is7xx serial driver updates
  - dt binding updates
  - first set of port lock wrapers from Thomas for the printk fixes
    coming in future releases
  - other small serial and tty core cleanups and updates

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alexey Dobriyan (1):
      serial: initialize retinfo in uart_get_info()

André Draszik (3):
      tty: serial: samsung_tty: remove dead code
      tty: serial: samsung: drop earlycon support for unsupported platforms
      dt-bindings: serial: drop unsupported samsung bindings

Andy Shevchenko (12):
      serial: 8250_port: Introduce UART_IIR_FIFO_ENABLED_16750
      serial: 8250_aspeed_vuart: Use dev_err_probe() instead of dev_err()
      serial: 8250_of: Use dev_err_probe() instead of dev_warn()
      serial: 8250_bcm7271: Use dev_err_probe() instead of dev_err()
      serial: 8250_aspeed_vuart: Use devm_clk_get_enabled()
      serial: 8250_of: Use devm_clk_get_enabled()
      serial: 8250_dw: Use devm_clk_get_optional_enabled()
      serial: core: Simplify uart_get_rs485_mode()
      serial: 8250_bcm7271: Use devm_clk_get_optional_enabled()
      serdev: Make use of device_set_node()
      serdev: Simplify devm_serdev_device_open() function
      serdev: Replace custom code with device_match_acpi_handle()

Arnd Bergmann (11):
      vgacon: rework Kconfig dependencies
      vgacon: rework screen_info #ifdef checks
      dummycon: limit Arm console size hack to footbridge
      vgacon, arch/*: remove unused screen_info definitions
      vgacon: remove screen_info dependency
      vgacon: clean up global screen_info instances
      vga16fb: drop powerpc support
      hyperv: avoid dependency on screen_info
      efi: move screen_info into efi init code
      console: fix up ARM screen_info reference
      vgacon: fix mips/sibyte build regression

Azeem Shaikh (1):
      vt: Replace strlcpy with strscpy

Bo Liu (1):
      tty: hvc: remove set but unused variable

Cameron Williams (11):
      tty: 8250: Remove UC-257 and UC-431
      tty: 8250: Add support for additional Brainboxes UC cards
      tty: 8250: Add support for Brainboxes UP cards
      tty: 8250: Add support for Intashield IS-100
      tty: 8250: Fix port count of PX-257
      tty: 8250: Fix up PX-803/PX-857
      tty: 8250: Add support for additional Brainboxes PX cards
      tty: 8250: Add support for Intashield IX cards
      tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks
      tty: 8250: Fix IS-200 PCI ID comment
      tty: 8250: Add note for PX-835

Chen Ni (1):
      tty: serial: ma35d1_serial: Add missing check for ioremap

Claudiu Beznea (1):
      dt-bindings: serial: renesas,scif: document r9a08g045 support

Crescent CY Hsieh (4):
      tty: serial: 8250: Modify MOXA enum name within 8250_pci.c
      tty: serial: 8250: Cleanup MOXA configurations
      tty: serial: 8250: Relocate macros within 8250_pci.c
      tty: serial: 8250: Add support for MOXA Mini PCIe boards

Daniel Starke (2):
      tty: n_gsm: fix race condition in status line change on dead connections
      tty: n_gsm: add copyright Siemens Mobility GmbH

David Woodhouse (3):
      hvc/xen: fix event channel handling for secondary consoles
      hvc/xen: fix error path in xen_hvc_init() to always register frontend driver
      hvc/xen: fix console unplug

Erwan Le Ray (1):
      serial: stm32: add support for break control

Fabio Estevam (2):
      dt-bindings: serial: mxs: Fix compatible list
      serial: amba-pl011: Do not complain when DMA is absent

Florian Eckert (1):
      tty: whitespaces in descriptions corrected by replacing tabs with spaces

Francesco Dolcini (1):
      dt-bindings: serial: rs485: Add rs485-rts-active-high

Greg Kroah-Hartman (4):
      Merge 6.6-rc4 into tty-next
      tty: vt: make vtconsole_class constant
      tty: vc_screen: make vc_class constant
      Merge 6.6-rc6 into tty-next

Hanno Böck (1):
      tty: Restrict access to TIOCLINUX' copy-and-paste subcommands

Hugo Villeneuve (7):
      serial: sc16is7xx: remove unused to_sc16is7xx_port macro
      serial: sc16is7xx: improve comments about variants
      serial: sc16is7xx: use device_property APIs when configuring irda mode
      dt-bindings: sc16is7xx: convert to YAML
      dt-bindings: serial: max310x: convert to YAML
      dt-bindings: serial: sc16is7xx: move 'allOf' block after 'required'
      serial: max310x: remove trailing whitespaces

Ilpo Järvinen (4):
      serial: 8250_mid: Remove 8250_pci usage
      tty: serial: 8250_exar: Does not use anything from 8250_pci
      tty/serial: Sort drivers in makefile
      tty/serial: 8250: Sort drivers in Makefile

Jiri Slaby (SUSE) (15):
      tty: n_tty: use 'retval' instead of 'c'
      tty: n_tty: rename and retype 'retval' in n_tty_ioctl()
      tty: n_tty: use min3() in copy_from_read_buf()
      tty: n_tty: invert the condition in copy_from_read_buf()
      tty: n_tty: use do-while in n_tty_check_{,un}throttle()
      tty: switch tty_{,un}throttle_safe() to return a bool
      tty: invert return values of tty_{,un}throttle_safe()
      tty: fix up and plug in tty_ioctl kernel-doc
      tty: fix kernel-doc for functions in tty.h
      tty: stop using ndash in kernel-doc
      tty: tty_buffer: use bool for 'restart' in tty_buffer_unlock_exclusive()
      tty: convert THROTTLE constants into enum
      tty: early return from send_break() on TTY_DRIVER_HARDWARE_BREAK
      tty: don't check for signal_pending() in send_break()
      tty: use 'if' in send_break() instead of 'goto'

Julien Malik (1):
      serial: xilinx_uartps: unset STOPBRK when setting STARTBRK

Kees Cook (2):
      mxser: Annotate struct mxser_board with __counted_by
      serial: 8250_pci1xxxx: Annotate struct pci1xxxx_8250 with __counted_by

Krzysztof Kozlowski (3):
      dt-bindings: serial: fix regex pattern for matching serial node children
      dt-bindings: serial: allow naming of Bluetooth with GPS children
      dt-bindings: serial: re-order entries to match coding convention

Lucas Tanure (1):
      tty: serial: meson: Add a earlycon for the S4 SoC

Marek Vasut (1):
      dt-bindings: serial: imx: Document wakeup-source property

Matthew Howell (2):
      serial: exar: Revert "serial: exar: Add support for Sealevel 7xxxC serial cards"
      serial: exar: Add RS-485 support for Sealevel XR17V35X based cards

Max Filippov (7):
      serial: add PORT_GENERIC definition
      serial: core: tidy invalid baudrate handling in uart_get_baud_rate
      dt-bindings: serial: document esp32-uart
      drivers/tty/serial: add driver for the ESP32 UART
      dt-bindings: serial: document esp32s3-acm
      drivers/tty/serial: add ESP32S3 ACM gadget driver
      serial/esp32_uart: use prescaler when available

Muhammad Usama Anjum (1):
      tty/sysrq: replace smp_processor_id() with get_cpu()

Pavel Krasavin (1):
      tty: serial: meson: fix hard LOCKUP on crtscts mode

Randy Dunlap (1):
      serial: core: fix kernel-doc for uart_port_unlock_irqrestore()

Sascha Hauer (1):
      serial: imx: Put DMA enabled UART in separate lock subclass

Simon Arlott (1):
      docs: ABI: sysfs-tty: close times are in centiseconds

Thomas Gleixner (74):
      serial: core: Provide port lock wrappers
      serial: core: Use lock wrappers
      serial: 21285: Use port lock wrappers
      serial: 8250_aspeed_vuart: Use port lock wrappers
      serial: 8250_bcm7271: Use port lock wrappers
      serial: 8250: Use port lock wrappers
      serial: 8250_dma: Use port lock wrappers
      serial: 8250_dw: Use port lock wrappers
      serial: 8250_exar: Use port lock wrappers
      serial: 8250_fsl: Use port lock wrappers
      serial: 8250_mtk: Use port lock wrappers
      serial: 8250_omap: Use port lock wrappers
      serial: 8250_pci1xxxx: Use port lock wrappers
      serial: altera_jtaguart: Use port lock wrappers
      serial: altera_uart: Use port lock wrappers
      serial: amba-pl010: Use port lock wrappers
      serial: amba-pl011: Use port lock wrappers
      serial: apb: Use port lock wrappers
      serial: ar933x: Use port lock wrappers
      serial: arc_uart: Use port lock wrappers
      serial: atmel: Use port lock wrappers
      serial: bcm63xx-uart: Use port lock wrappers
      serial: cpm_uart: Use port lock wrappers
      serial: digicolor: Use port lock wrappers
      serial: dz: Use port lock wrappers
      serial: linflexuart: Use port lock wrappers
      serial: fsl_lpuart: Use port lock wrappers
      serial: icom: Use port lock wrappers
      serial: imx: Use port lock wrappers
      serial: ip22zilog: Use port lock wrappers
      serial: jsm: Use port lock wrappers
      serial: liteuart: Use port lock wrappers
      serial: lpc32xx_hs: Use port lock wrappers
      serial: ma35d1: Use port lock wrappers
      serial: mcf: Use port lock wrappers
      serial: men_z135_uart: Use port lock wrappers
      serial: meson: Use port lock wrappers
      serial: milbeaut_usio: Use port lock wrappers
      serial: mpc52xx: Use port lock wrappers
      serial: mps2-uart: Use port lock wrappers
      serial: msm: Use port lock wrappers
      serial: mvebu-uart: Use port lock wrappers
      serial: omap: Use port lock wrappers
      serial: owl: Use port lock wrappers
      serial: pch: Use port lock wrappers
      serial: pic32: Use port lock wrappers
      serial: pmac_zilog: Use port lock wrappers
      serial: pxa: Use port lock wrappers
      serial: qcom-geni: Use port lock wrappers
      serial: rda: Use port lock wrappers
      serial: rp2: Use port lock wrappers
      serial: sa1100: Use port lock wrappers
      serial: samsung_tty: Use port lock wrappers
      serial: sb1250-duart: Use port lock wrappers
      serial: sc16is7xx: Use port lock wrappers
      serial: tegra: Use port lock wrappers
      serial: core: Use port lock wrappers
      serial: mctrl_gpio: Use port lock wrappers
      serial: txx9: Use port lock wrappers
      serial: sh-sci: Use port lock wrappers
      serial: sifive: Use port lock wrappers
      serial: sprd: Use port lock wrappers
      serial: st-asc: Use port lock wrappers
      serial: stm32: Use port lock wrappers
      serial: sunhv: Use port lock wrappers
      serial: sunplus-uart: Use port lock wrappers
      serial: sunsab: Use port lock wrappers
      serial: sunsu: Use port lock wrappers
      serial: sunzilog: Use port lock wrappers
      serial: timbuart: Use port lock wrappers
      serial: uartlite: Use port lock wrappers
      serial: ucc_uart: Use port lock wrappers
      serial: vt8500: Use port lock wrappers
      serial: xilinx_uartps: Use port lock wrappers

Thomas Richard (1):
      serial: 8250_omap: Set the console genpd always on if no console suspend

Tony Lindgren (5):
      serial: 8250: Check for valid console index
      serial: 8250_omap: Drop pm_runtime_irq_safe()
      printk: Check valid console index for preferred console
      printk: Constify name for add_preferred_console()
      serial: core: Fix runtime PM handling for pending tx

Uwe Kleine-König (1):
      serial: imx: Simplify compatibility handling

Wolfram Sang (2):
      serial: core: remove cruft from uapi header
      serial: core: add comment about definitely used port types

Yi Yang (2):
      tty: vcc: Add check for kstrdup() in vcc_probe()
      tty: tty_jobctrl: fix pid memleak in disassociate_ctty()

Zhang Shurong (1):
      tty: serial: linflexuart: Fix to check return value of platform_get_irq() in linflex_probe()

 Documentation/ABI/testing/sysfs-tty                |  15 +-
 .../devicetree/bindings/serial/esp,esp32-acm.yaml  |  42 ++
 .../devicetree/bindings/serial/esp,esp32-uart.yaml |  51 ++
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |   2 +
 .../devicetree/bindings/serial/fsl-mxs-auart.yaml  |  13 +-
 .../devicetree/bindings/serial/maxim,max310x.txt   |  48 --
 .../devicetree/bindings/serial/maxim,max310x.yaml  |  74 ++
 .../bindings/serial/nvidia,tegra20-hsuart.yaml     |  10 +-
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   | 118 ----
 .../devicetree/bindings/serial/nxp,sc16is7xx.yaml  | 127 ++++
 .../devicetree/bindings/serial/qcom,msm-uart.yaml  |   4 +-
 .../bindings/serial/qcom,msm-uartdm.yaml           |   4 +-
 .../bindings/serial/renesas,em-uart.yaml           |  14 +-
 .../devicetree/bindings/serial/renesas,hscif.yaml  |   4 +-
 .../devicetree/bindings/serial/renesas,scif.yaml   |   1 +
 .../devicetree/bindings/serial/renesas,scifa.yaml  |   4 +-
 .../devicetree/bindings/serial/renesas,scifb.yaml  |   4 +-
 .../devicetree/bindings/serial/rs485.yaml          |   4 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   8 +-
 .../devicetree/bindings/serial/serial.yaml         |  18 +-
 Documentation/driver-api/tty/index.rst             |   1 +
 Documentation/driver-api/tty/tty_ioctl.rst         |  10 +
 arch/alpha/kernel/proto.h                          |   2 +
 arch/alpha/kernel/setup.c                          |   8 +-
 arch/alpha/kernel/sys_sio.c                        |   8 +-
 arch/arm/include/asm/setup.h                       |   5 +
 arch/arm/include/asm/vga.h                         |   1 +
 arch/arm/kernel/atags_parse.c                      |  20 +-
 arch/arm/kernel/efi.c                              |   6 -
 arch/arm/kernel/setup.c                            |   7 +-
 arch/arm64/kernel/efi.c                            |   4 -
 arch/arm64/kernel/image-vars.h                     |   2 +
 arch/csky/kernel/setup.c                           |  12 -
 arch/hexagon/kernel/Makefile                       |   2 -
 arch/hexagon/kernel/screen_info.c                  |   3 -
 arch/ia64/kernel/setup.c                           |  53 +-
 arch/loongarch/kernel/efi.c                        |   8 +-
 arch/loongarch/kernel/image-vars.h                 |   2 +
 arch/loongarch/kernel/setup.c                      |   3 -
 arch/mips/jazz/setup.c                             |   9 -
 arch/mips/kernel/setup.c                           |  11 -
 arch/mips/mti-malta/malta-setup.c                  |   4 +-
 arch/mips/sibyte/swarm/setup.c                     |  27 +-
 arch/mips/sni/setup.c                              |  18 +-
 arch/nios2/kernel/setup.c                          |   5 -
 arch/powerpc/kernel/setup-common.c                 |  16 -
 arch/riscv/kernel/image-vars.h                     |   2 +
 arch/riscv/kernel/setup.c                          |  12 -
 arch/sh/kernel/setup.c                             |   5 -
 arch/sparc/kernel/setup_32.c                       |  13 -
 arch/sparc/kernel/setup_64.c                       |  13 -
 arch/x86/kernel/setup.c                            |   2 +-
 arch/xtensa/kernel/setup.c                         |  12 -
 drivers/firmware/efi/efi-init.c                    |  14 +-
 drivers/firmware/efi/libstub/efi-stub-entry.c      |   8 +-
 drivers/firmware/pcdp.c                            |   1 -
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c            |   7 +-
 drivers/hv/vmbus_drv.c                             |   6 +-
 drivers/tty/hvc/hvc_xen.c                          |  39 +-
 drivers/tty/hvc/hvcs.c                             |   2 -
 drivers/tty/mxser.c                                |   2 +-
 drivers/tty/n_gsm.c                                |   3 +
 drivers/tty/n_tty.c                                |  75 +-
 drivers/tty/serdev/core.c                          |  24 +-
 drivers/tty/serial/21285.c                         |   8 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |  33 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |  69 +-
 drivers/tty/serial/8250/8250_core.c                |  14 +-
 drivers/tty/serial/8250/8250_dma.c                 |   8 +-
 drivers/tty/serial/8250/8250_dw.c                  |  35 +-
 drivers/tty/serial/8250/8250_exar.c                |  63 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   6 +-
 drivers/tty/serial/8250/8250_mid.c                 |  18 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   8 +-
 drivers/tty/serial/8250/8250_of.c                  |  44 +-
 drivers/tty/serial/8250/8250_omap.c                | 114 ++-
 drivers/tty/serial/8250/8250_pci.c                 | 597 ++++++++++++----
 drivers/tty/serial/8250/8250_pci1xxxx.c            |  10 +-
 drivers/tty/serial/8250/8250_port.c                | 111 ++-
 drivers/tty/serial/8250/Kconfig                    |   2 +-
 drivers/tty/serial/8250/Makefile                   |  44 +-
 drivers/tty/serial/Kconfig                         |  26 +
 drivers/tty/serial/Makefile                        | 126 ++--
 drivers/tty/serial/altera_jtaguart.c               |  28 +-
 drivers/tty/serial/altera_uart.c                   |  20 +-
 drivers/tty/serial/amba-pl010.c                    |  20 +-
 drivers/tty/serial/amba-pl011.c                    |  74 +-
 drivers/tty/serial/apbuart.c                       |   8 +-
 drivers/tty/serial/ar933x_uart.c                   |  26 +-
 drivers/tty/serial/arc_uart.c                      |  16 +-
 drivers/tty/serial/atmel_serial.c                  |  24 +-
 drivers/tty/serial/bcm63xx_uart.c                  |  22 +-
 drivers/tty/serial/cpm_uart.c                      |   8 +-
 drivers/tty/serial/digicolor-usart.c               |  18 +-
 drivers/tty/serial/dz.c                            |  32 +-
 drivers/tty/serial/esp32_acm.c                     | 459 ++++++++++++
 drivers/tty/serial/esp32_uart.c                    | 784 +++++++++++++++++++++
 drivers/tty/serial/fsl_linflexuart.c               |  32 +-
 drivers/tty/serial/fsl_lpuart.c                    |  88 +--
 drivers/tty/serial/icom.c                          |  26 +-
 drivers/tty/serial/imx.c                           | 128 ++--
 drivers/tty/serial/ip22zilog.c                     |  36 +-
 drivers/tty/serial/jsm/jsm_neo.c                   |   4 +-
 drivers/tty/serial/jsm/jsm_tty.c                   |  16 +-
 drivers/tty/serial/liteuart.c                      |  20 +-
 drivers/tty/serial/lpc32xx_hs.c                    |  26 +-
 drivers/tty/serial/ma35d1_serial.c                 |  25 +-
 drivers/tty/serial/max310x.c                       |   2 +-
 drivers/tty/serial/mcf.c                           |  20 +-
 drivers/tty/serial/men_z135_uart.c                 |   8 +-
 drivers/tty/serial/meson_uart.c                    |  48 +-
 drivers/tty/serial/milbeaut_usio.c                 |  16 +-
 drivers/tty/serial/mpc52xx_uart.c                  |  12 +-
 drivers/tty/serial/mps2-uart.c                     |  16 +-
 drivers/tty/serial/msm_serial.c                    |  38 +-
 drivers/tty/serial/mvebu-uart.c                    |  18 +-
 drivers/tty/serial/omap-serial.c                   |  38 +-
 drivers/tty/serial/owl-uart.c                      |  26 +-
 drivers/tty/serial/pch_uart.c                      |  10 +-
 drivers/tty/serial/pic32_uart.c                    |  20 +-
 drivers/tty/serial/pmac_zilog.c                    |  52 +-
 drivers/tty/serial/pxa.c                           |  30 +-
 drivers/tty/serial/qcom_geni_serial.c              |   8 +-
 drivers/tty/serial/rda-uart.c                      |  34 +-
 drivers/tty/serial/rp2.c                           |  20 +-
 drivers/tty/serial/sa1100.c                        |  20 +-
 drivers/tty/serial/samsung_tty.c                   | 171 +----
 drivers/tty/serial/sb1250-duart.c                  |  12 +-
 drivers/tty/serial/sc16is7xx.c                     |  83 ++-
 drivers/tty/serial/serial-tegra.c                  |  32 +-
 drivers/tty/serial/serial_core.c                   | 131 ++--
 drivers/tty/serial/serial_mctrl_gpio.c             |   4 +-
 drivers/tty/serial/serial_port.c                   |   4 +-
 drivers/tty/serial/serial_txx9.c                   |  26 +-
 drivers/tty/serial/sh-sci.c                        |  68 +-
 drivers/tty/serial/sifive.c                        |  16 +-
 drivers/tty/serial/sprd_serial.c                   |  30 +-
 drivers/tty/serial/st-asc.c                        |  18 +-
 drivers/tty/serial/stm32-usart.c                   |  51 +-
 drivers/tty/serial/sunhv.c                         |  28 +-
 drivers/tty/serial/sunplus-uart.c                  |  26 +-
 drivers/tty/serial/sunsab.c                        |  34 +-
 drivers/tty/serial/sunsu.c                         |  46 +-
 drivers/tty/serial/sunzilog.c                      |  42 +-
 drivers/tty/serial/timbuart.c                      |   8 +-
 drivers/tty/serial/uartlite.c                      |  18 +-
 drivers/tty/serial/ucc_uart.c                      |   4 +-
 drivers/tty/serial/vt8500_serial.c                 |   8 +-
 drivers/tty/serial/xilinx_uartps.c                 |  58 +-
 drivers/tty/sysrq.c                                |   3 +-
 drivers/tty/tty.h                                  |  13 +-
 drivers/tty/tty_buffer.c                           |   5 +-
 drivers/tty/tty_io.c                               | 130 ++--
 drivers/tty/tty_ioctl.c                            | 234 +++---
 drivers/tty/tty_jobctrl.c                          |  17 +-
 drivers/tty/tty_port.c                             |   6 +-
 drivers/tty/vcc.c                                  |  16 +-
 drivers/tty/vt/consolemap.c                        |   2 +-
 drivers/tty/vt/keyboard.c                          |   7 +-
 drivers/tty/vt/vc_screen.c                         |  32 +-
 drivers/tty/vt/vt.c                                |  29 +-
 drivers/video/console/Kconfig                      |  11 +-
 drivers/video/console/dummycon.c                   |   7 +-
 drivers/video/console/vgacon.c                     |  68 +-
 drivers/video/fbdev/Kconfig                        |   2 +-
 drivers/video/fbdev/hyperv_fb.c                    |   8 +-
 drivers/video/fbdev/vga16fb.c                      |   9 +-
 include/linux/console.h                            |   9 +-
 include/linux/serial_core.h                        |  91 ++-
 include/linux/tty.h                                |  25 +-
 include/uapi/linux/gsmmux.h                        |   1 +
 include/uapi/linux/serial_core.h                   |  21 +-
 include/uapi/linux/serial_reg.h                    |   1 +
 kernel/printk/printk.c                             |  12 +-
 174 files changed, 4087 insertions(+), 2354 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-acm.yaml
 create mode 100644 Documentation/devicetree/bindings/serial/esp,esp32-uart.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.txt
 create mode 100644 Documentation/devicetree/bindings/serial/maxim,max310x.yaml
 delete mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.txt
 create mode 100644 Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
 create mode 100644 Documentation/driver-api/tty/tty_ioctl.rst
 delete mode 100644 arch/hexagon/kernel/screen_info.c
 create mode 100644 drivers/tty/serial/esp32_acm.c
 create mode 100644 drivers/tty/serial/esp32_uart.c
