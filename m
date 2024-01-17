Return-Path: <linux-kernel+bounces-28897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BE830452
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:13:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 334191C21722
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536141DDC8;
	Wed, 17 Jan 2024 11:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NpYcqiL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97611DFC7;
	Wed, 17 Jan 2024 11:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705490025; cv=none; b=hj9LWE3bX+UxhLCZ/A3JYDXU1eGzJpvP5xRqUsacz6RsjgpLUJp+Z43DiiwCl8goZxzlw9ZS5jAO25d/2YtntYrtKyw2S6XytW5ps2we/wFead2x9cytk5J52XSF6Yz1vey4MskgXiE6PNr1S+RSuxiZ/B6mlLIFaxvfgZAAtNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705490025; c=relaxed/simple;
	bh=UGVODyBn33R7G+FbslOUaq6vzcirR0PVlhocPyssfWo=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding; b=cD7g1ROBUqqh+54Lnlns4YuXh1SF+MKfLGf05l26yfYftFrS90zAOvc08fzjyVm5SEUdAKaahQv9R/GR/5o/KbklzfkCpOZyF2p3VnY/nFLO3MgzSTxH7rgrBmD8b6Hq8hJ14/e3pFV4QEGBraTunra0Yfbz1EzYkjw8GsS0bgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NpYcqiL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D84C43390;
	Wed, 17 Jan 2024 11:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705490025;
	bh=UGVODyBn33R7G+FbslOUaq6vzcirR0PVlhocPyssfWo=;
	h=Date:From:To:Cc:Subject:From;
	b=NpYcqiL4fjb9ZH5vctoEj+ge7sUIVB6xI55dy+MB/iv3DFIUAK/qFz/xiU08IZj3x
	 aAJ/6rdoRjrugEMR266o1KM4X1aA6MYBRIvJMVHQU1UpooC8yMZfz3lcf3GUji4BYD
	 I1suOX4lgDRYv+1y+r2YyJi8qiLUb/ll+jHJy4Wk=
Date: Wed, 17 Jan 2024 12:13:42 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, Stephen Rothwell <sfr@canb.auug.org.au>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.8-rc1
Message-ID: <Zae2ZrJthYx0tVSd@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bffe9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.8-rc1

for you to fetch changes up to 0c84bea0cabc4e2b98a3de88eeb4ff798931f056:

  serial: sc16is7xx: refactor EFR lock (2024-01-04 16:30:05 +0100)

----------------------------------------------------------------
TTY/Serial changes for 6.8-rc1

Here is the big set of tty and serial driver changes for 6.8-rc1.

As usual, Jiri has a bunch of refactoring and cleanups for the tty core
and drivers in here, along with the usual set of rs485 updates (someday
this might work properly...)  Along with those, in here are changes for:
  - sc16is7xx serial driver updates
  - platform driver removal api updates
  - amba-pl011 driver updates
  - tty driver binding updates
  - other small tty/serial driver updates and changes

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Adrian Reber (1):
      tty: allow TIOCSLCKTRMIOS with CAP_CHECKPOINT_RESTORE

Antony Pavlov (1):
      tty/serial: altera_uart: use more informative labels in /proc/interrupts

Ayan Kumar Halder (1):
      tty: hvc: dcc: Check for TXfull condition while setting up early console

Chester Lin (1):
      dt-bindings: serial: fsl-linflexuart: change the maintainer email address

Christoph Niedermaier (2):
      serial: imx: Correct clock error message in function probe()
      serial: imx: Ensure that imx_uart_rs485_config() is called with enabled clock

Christophe JAILLET (6):
      serial: atmel: convert not to use dma_request_slave_channel()
      serial: imx: convert not to use dma_request_slave_channel()
      serial: amba-pl011: convert not to use dma_request_slave_channel()
      serial: mxs-auart: convert not to use dma_request_slave_channel()
      serial: sh-sci: convert not to use dma_request_slave_channel()
      serdev: Remove usage of the deprecated ida_simple_xx() API

Christophe Leroy (1):
      serial: ucc_uart: Fix multiple address space type errors

Chunyan Zhang (1):
      dt-bindings: serial: Add a new compatible string for UMS9620

Colin Ian King (1):
      serial: ma35d1: Fix spelling mistake "ononsole" -> "console"

Crescent CY Hsieh (4):
      tty: serial: 8250: Set RS422 interface by default to fix Moxa RS422/RS485 PCIe boards
      tty: serial: Cleanup the bit shift with macro
      tty: serial: Add RS422 flag to struct serial_rs485
      tty: serial: 8250: Set RS232 as default for Moxa PCIe board initialization

Fabio Estevam (1):
      dt-bindings: serial: imx: Properly describe the i.MX1 interrupts

Greg Kroah-Hartman (1):
      Merge 6.7-rc5 into tty-next

Heiko Stuebner (1):
      dt-bindings: serial: snps-dw-apb-uart: include rs485 schema

Hugo Villeneuve (26):
      serial: sunsab: remove trailing whitespaces
      serial: sc16is7xx: improve regmap debugfs by using one regmap per port
      serial: sc16is7xx: change confusing comment about Tx FIFO
      serial: max310x: change confusing comment about Tx FIFO
      serial: sc16is7xx: remove wasteful static buffer in sc16is7xx_regmap_name()
      serial: sc16is7xx: remove global regmap from struct sc16is7xx_port
      serial: sc16is7xx: remove unused line structure member
      serial: sc16is7xx: change EFR lock to operate on each channels
      serial: sc16is7xx: convert from _raw_ to _noinc_ regmap functions for FIFO
      serial: sc16is7xx: fix unconditional activation of THRI interrupt
      serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error
      serial: sc16is7xx: add check for unsupported SPI modes during probe
      serial: sc16is7xx: set safe default SPI clock frequency
      serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
      serial: sc16is7xx: improve do/while loop in sc16is7xx_irq()
      serial: sc16is7xx: use DECLARE_BITMAP for sc16is7xx_lines bitfield
      serial: sc16is7xx: use spi_get_device_match_data()
      serial: sc16is7xx: use i2c_get_match_data()
      serial: sc16is7xx: add driver name to struct uart_driver
      serial: sc16is7xx: add macro for max number of UART ports
      serial: sc16is7xx: add explicit return for some switch default cases
      serial: sc16is7xx: replace hardcoded divisor value with BIT() macro
      serial: sc16is7xx: drop unneeded MODULE_ALIAS
      serial: sc16is7xx: refactor FIFO access functions to increase commonality
      serial: sc16is7xx: reorder code to remove prototype declarations
      serial: sc16is7xx: refactor EFR lock

Jiri Slaby (SUSE) (52):
      tty: con3215: drop raw3215_info::ubuffer
      tty: ipwireless: remove unused ipw_dev::attribute_memory
      tty: jsm: remove unused members from struct board_ops
      tty: jsm: remove unused struct jsm_board members
      tty: rp2: remove unused rp2_uart_port::ignore_rx
      tty: serial_cs: remove unused struct serial_cfg_mem
      tty: fix tty_operations types in documentation
      tty: deprecate tty_write_message()
      tty: remove unneeded mbz from tiocsti()
      tty: move locking docs out of Returns for functions in tty.h
      tty: amiserial: return from receive_chars() without goto
      tty: amiserial: use bool and rename overrun flag in receive_chars()
      tty: ehv_bytecha: use memcpy_and_pad() in local_ev_byte_channel_send()
      tty: goldfish: drop unneeded temporary variables
      tty: hso: don't emit load/unload info to the log
      tty: hso: don't initialize global serial_table
      tty: hvc_console: use flexible array for outbuf
      tty: nozomi: remove unused debugging DUMP()
      tty: srmcons: use 'buf' directly in srmcons_do_write()
      tty: make tty const in tty_get_baud_rate()
      tty: srmcons: make srmcons_do_write() return void
      tty: srmcons: use 'count' directly in srmcons_do_write()
      tty: srmcons: switch need_cr to bool
      tty: srmcons: remove 'str_cr' and use string directly
      tty: virtio: drop virtio_cons_early_init()
      tty: goldfish: use bool for is_write parameter
      tty: mmc: sdio_uart: switch sdio_in() to return u8
      tty: switch tty_port::xmit_* to u8
      tty: make tty_operations::send_xchar accept u8 char
      tty: core: the rest to u8
      tty: ami: use u8 for characters and flag
      tty: bcm: convert to u8 and size_t
      tty: con3215: convert to u8 and size_t
      tty: con3270: convert to u8 and size_t
      tty: ehv_bytechan: convert to u8 and size_t
      tty: goldfish: convert to u8 and size_t
      tty: hvc: convert to u8 and size_t
      tty: ipoctal: convert to u8 and size_t
      tty: m68k: nfcon: convert to u8 and size_t
      tty: mips_ejtag_fdc: use u8 for character pointers
      tty: mmc: sdio: use u8 for flag
      tty: moxa: convert to u8 and size_t
      tty: mxser: convert to u8 and size_t
      tty: n_gsm: convert to u8 and size_t
      tty: n_hdlc: convert to u8 and size_t
      tty: nozomi: convert to u8 and size_t
      tty: serdev: convert to u8 and size_t in serdev_controller_ops
      tty: serdev: convert to u8 and size_t
      tty: srmcons: convert to u8 and size_t
      tty: ttyprintk: convert to u8 and size_t
      tty: um: convert to u8/__u8 and size_t
      tty: xtensa/iss: use u8

Lad Prabhakar (1):
      dt-bindings: serial: renesas,sci: Document RZ/Five SoC

Lino Sanfilippo (7):
      serial: Do not hold the port lock when setting rx-during-tx GPIO
      serial: core: set missing supported flag for RX during TX GPIO
      serial: core: fix sanitizing check for RTS settings
      serial: core: make sure RS485 cannot be enabled when it is not supported
      serial: core, imx: do not set RS485 enabled if it is not supported
      serial: omap: do not override settings for RS485 support
      serial: 8250_exar: Set missing rs485_supported flag

Manikanta Guntupalli (2):
      Documentation: devices.txt: Update ttyUL major number allocation details
      serial: uartlite: Use dynamic allocation for major number when uart ports > 4

Michael Trimarchi (1):
      tty: serial: kgdboc: Fix 8250_* kgdb over serial

Michal Simek (1):
      dt-bindings: serial: Describe ARM dcc interface

Paul Geurts (1):
      serial: imx: fix tx statemachine deadlock

Philipp Stanner (1):
      drivers/tty/vt: use standard array-copy-functions

Raag Jadav (1):
      serial: 8250_lpss: copy dma_param using devm_kmemdup()

Rengarajan S (3):
      8250: microchip: pci1xxxx: Rearranging the structure declarations
      8250: microchip: pci1xxxx: Add Syslock support for reading UART system registers
      8250: microchip: pci1xxxx: Add Burst mode reception support in uart driver for writing into FIFO

Rob Herring (2):
      serial: esp32_acm: Add explicit platform_device.h include
      serial: esp32_uart: Use device_get_match_data()

Sam Ravnborg (1):
      serial: apbuart: fix console prompt on qemu

Samuel Holland (1):
      serial: sifive: Declare PM operations as static

Sean Anderson (1):
      tty: serial: uartlite: Document uartlite_data in kernel-doc style

Stefan Wahren (1):
      serial: 8250_bcm2835aux: Restore clock error handling

Stephan Gerhold (2):
      dt-bindings: serial: qcom,msm-uartdm: Vote for shared resources
      serial: msm: Use OPP table for DVFS support

Théo Lebrun (9):
      tty: serial: amba: cleanup whitespace
      tty: serial: amba: Use linux/{bits,bitfield}.h macros
      tty: serial: amba-pl011: fix whitespace formatting
      tty: serial: amba-pl011: replace TIOCMBIT macros by static functions
      tty: serial: amba-pl011: avoid quoted string split across lines
      tty: serial: amba-pl011: fix formatting of conditions
      tty: serial: amba-pl011: fix miscellaneous checkpatch warnings
      tty: serial: amba-pl011: unindent pl011_console_get_options function body
      tty: serial: amba-pl011: factor QDF2400 SoC erratum 44 out of probe

Tomas Mudrunka (1):
      /proc/sysrq-trigger: accept multiple keys at once

Tony Lindgren (2):
      serial: core: Move tty and serdev to be children of serial core port device
      serial: core: Revert checks for tx runtime PM state

Uwe Kleine-König (56):
      serial: 8250: omap: Don't skip resource freeing if pm_runtime_resume_and_get() failed
      serial: sccnxp: Improve error message if regulator_disable() fails
      serial: 8250: Convert to platform remove callback returning void
      serial: altera_jtaguart: Convert to platform remove callback returning void
      serial: altera: Convert to platform remove callback returning void
      serial: amba-pl011: Convert to platform remove callback returning void
      serial: ar933x: Convert to platform remove callback returning void
      serial: atmel: Convert to platform remove callback returning void
      serial: bcm63xx: Convert to platform remove callback returning void
      serial: clps711x: Convert to platform remove callback returning void
      serial: cpm: Convert to platform remove callback returning void
      serial: digicolor: Convert to platform remove callback returning void
      serial: esp32_acm: Convert to platform remove callback returning void
      serial: esp32: Convert to platform remove callback returning void
      serial: fsl_linflexuart: Convert to platform remove callback returning void
      serial: fsl_lpuart: Convert to platform remove callback returning void
      serial: imx: Convert to platform remove callback returning void
      serial: lantiq: Convert to platform remove callback returning void
      serial: liteuart: Convert to platform remove callback returning void
      serial: lpc32xx_hs: Convert to platform remove callback returning void
      serial: ma35d1: Convert to platform remove callback returning void
      serial: mcf: Convert to platform remove callback returning void
      serial: meson: Convert to platform remove callback returning void
      serial: milbeaut_usio: Convert to platform remove callback returning void
      serial: mpc52xx: Convert to platform remove callback returning void
      serial: msm: Convert to platform remove callback returning void
      serial: mxs-auart: Convert to platform remove callback returning void
      serial: omap: Convert to platform remove callback returning void
      serial: owl: Convert to platform remove callback returning void
      serial: pic32: Convert to platform remove callback returning void
      serial: qcom_geni: Convert to platform remove callback returning void
      serial: rda: Convert to platform remove callback returning void
      serial: sa1100: Convert to platform remove callback returning void
      serial: samsung: Convert to platform remove callback returning void
      serial: sccnxp: Convert to platform remove callback returning void
      serial: tegra: Convert to platform remove callback returning void
      serial: txx9: Convert to platform remove callback returning void
      serial: sh-sci: Convert to platform remove callback returning void
      serial: sifive: Convert to platform remove callback returning void
      serial: sprd: Convert to platform remove callback returning void
      serial: st-asc: Convert to platform remove callback returning void
      serial: stm32: Convert to platform remove callback returning void
      serial: sunhv: Convert to platform remove callback returning void
      serial: sunplus: Convert to platform remove callback returning void
      serial: sunsab: Convert to platform remove callback returning void
      serial: sunsu: Convert to platform remove callback returning void
      serial: sunzilog: Convert to platform remove callback returning void
      serial: tegra-tcu: Convert to platform remove callback returning void
      serial: timbuart: Convert to platform remove callback returning void
      serial: uartlite: Convert to platform remove callback returning void
      serial: ucc: Convert to platform remove callback returning void
      serial: xilinx_uartps: Convert to platform remove callback returning void
      tty: hvc: Make hvc_remove() return no value
      tty: hvc: hvc_opal: Convert to platform remove callback returning void
      serial: xilinx_uartps: Fix kernel doc about .remove()'s return code
      serial: 8250-fsl: Only do the break workaround if IIR signals RLSI

Vamshi Gajjela (4):
      serial: 8250_dw: Decouple DLF register check from UCV
      serial: core: Update uart_poll_timeout() function to return unsigned long
      serial: core: Clean up uart_update_timeout() function
      serial: 8250_dw: Do not bailout on UCV read returning zero

 Documentation/admin-guide/devices.txt              |   3 +
 Documentation/admin-guide/sysrq.rst                |  11 +-
 .../devicetree/bindings/serial/arm,dcc.yaml        |  30 ++
 .../bindings/serial/fsl,s32-linflexuart.yaml       |   2 +-
 .../devicetree/bindings/serial/fsl-imx-uart.yaml   |  29 +-
 .../bindings/serial/qcom,msm-uartdm.yaml           |  13 +
 .../devicetree/bindings/serial/renesas,sci.yaml    |   2 +-
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 +
 .../devicetree/bindings/serial/sprd-uart.yaml      |   1 +
 MAINTAINERS                                        |   1 -
 arch/alpha/kernel/srmcons.c                        |  34 +-
 arch/m68k/emu/nfcon.c                              |   4 +-
 arch/powerpc/include/asm/hvconsole.h               |   4 +-
 arch/powerpc/include/asm/hvsi.h                    |  18 +-
 arch/powerpc/include/asm/opal.h                    |   8 +-
 arch/powerpc/platforms/powernv/opal.c              |  14 +-
 arch/powerpc/platforms/pseries/hvconsole.c         |   4 +-
 arch/um/drivers/chan.h                             |   2 +-
 arch/um/drivers/chan_kern.c                        |   9 +-
 arch/um/drivers/chan_user.c                        |   4 +-
 arch/um/drivers/chan_user.h                        |   9 +-
 arch/um/drivers/line.c                             |   2 +-
 arch/um/drivers/line.h                             |   6 +-
 arch/um/drivers/null.c                             |   2 +-
 arch/xtensa/platforms/iss/console.c                |   2 +-
 drivers/bluetooth/btmtkuart.c                      |   4 +-
 drivers/bluetooth/btnxpuart.c                      |   4 +-
 drivers/bluetooth/hci_serdev.c                     |   4 +-
 drivers/char/ttyprintk.c                           |   6 +-
 drivers/char/virtio_console.c                      |  58 +--
 drivers/gnss/serial.c                              |   4 +-
 drivers/gnss/sirf.c                                |   4 +-
 drivers/greybus/gb-beagleplay.c                    |   5 +-
 drivers/iio/chemical/pms7003.c                     |   6 +-
 drivers/iio/chemical/scd30_serial.c                |   6 +-
 drivers/iio/chemical/sps30_serial.c                |  18 +-
 drivers/iio/imu/bno055/bno055_ser_core.c           |   6 +-
 drivers/ipack/devices/ipoctal.c                    |  14 +-
 drivers/isdn/capi/capi.c                           |   4 +-
 drivers/mfd/rave-sp.c                              |  10 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |   4 +-
 drivers/mmc/core/sdio_uart.c                       |  22 +-
 drivers/net/ethernet/qualcomm/qca_uart.c           |   5 +-
 drivers/net/usb/hso.c                              |  11 -
 drivers/nfc/pn533/uart.c                           |   4 +-
 drivers/nfc/s3fwrn5/uart.c                         |   5 +-
 drivers/platform/chrome/cros_ec_uart.c             |   5 +-
 drivers/platform/surface/aggregator/controller.h   |   4 +-
 drivers/platform/surface/aggregator/core.c         |   4 +-
 .../platform/surface/aggregator/ssh_packet_layer.c |   4 +-
 .../platform/surface/aggregator/ssh_packet_layer.h |   2 +-
 drivers/s390/char/con3215.c                        |  25 +-
 drivers/s390/char/con3270.c                        |  12 +-
 drivers/tty/amiserial.c                            |  16 +-
 drivers/tty/ehv_bytechan.c                         |  18 +-
 drivers/tty/goldfish.c                             |  23 +-
 drivers/tty/hvc/hvc_console.c                      |   7 +-
 drivers/tty/hvc/hvc_console.h                      |   8 +-
 drivers/tty/hvc/hvc_dcc.c                          |  32 +-
 drivers/tty/hvc/hvc_iucv.c                         |  18 +-
 drivers/tty/hvc/hvc_opal.c                         |  22 +-
 drivers/tty/hvc/hvc_riscv_sbi.c                    |   9 +-
 drivers/tty/hvc/hvc_rtas.c                         |  11 +-
 drivers/tty/hvc/hvc_udbg.c                         |   9 +-
 drivers/tty/hvc/hvc_vio.c                          |  18 +-
 drivers/tty/hvc/hvc_xen.c                          |  23 +-
 drivers/tty/hvc/hvsi_lib.c                         |  20 +-
 drivers/tty/ipwireless/main.h                      |   3 -
 drivers/tty/mips_ejtag_fdc.c                       |  10 +-
 drivers/tty/moxa.c                                 |  15 +-
 drivers/tty/mxser.c                                |   8 +-
 drivers/tty/n_gsm.c                                |  17 +-
 drivers/tty/n_hdlc.c                               |  10 +-
 drivers/tty/nozomi.c                               |  27 +-
 drivers/tty/serdev/core.c                          |  31 +-
 drivers/tty/serdev/serdev-ttyport.c                |   5 +-
 drivers/tty/serial/8250/8250_aspeed_vuart.c        |   6 +-
 drivers/tty/serial/8250/8250_bcm2835aux.c          |   8 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   5 +-
 drivers/tty/serial/8250/8250_core.c                |   5 +-
 drivers/tty/serial/8250/8250_dw.c                  |   6 +-
 drivers/tty/serial/8250/8250_dwlib.c               |  16 +-
 drivers/tty/serial/8250/8250_em.c                  |   5 +-
 drivers/tty/serial/8250/8250_exar.c                |   5 +-
 drivers/tty/serial/8250/8250_fsl.c                 |   8 +-
 drivers/tty/serial/8250/8250_ingenic.c             |   5 +-
 drivers/tty/serial/8250/8250_ioc3.c                |   5 +-
 drivers/tty/serial/8250/8250_lpc18xx.c             |   6 +-
 drivers/tty/serial/8250/8250_lpss.c                |   7 +-
 drivers/tty/serial/8250/8250_mtk.c                 |   6 +-
 drivers/tty/serial/8250/8250_of.c                  |   5 +-
 drivers/tty/serial/8250/8250_omap.c                |   7 +-
 drivers/tty/serial/8250/8250_pci.c                 |  61 ++-
 drivers/tty/serial/8250/8250_pci1xxxx.c            | 210 +++++++-
 drivers/tty/serial/8250/8250_pxa.c                 |   6 +-
 drivers/tty/serial/8250/8250_tegra.c               |   6 +-
 drivers/tty/serial/8250/8250_uniphier.c            |   6 +-
 drivers/tty/serial/8250/serial_cs.c                |   6 -
 drivers/tty/serial/Kconfig                         |   3 +
 drivers/tty/serial/altera_jtaguart.c               |   6 +-
 drivers/tty/serial/altera_uart.c                   |   8 +-
 drivers/tty/serial/amba-pl011.c                    | 276 +++++-----
 drivers/tty/serial/apbuart.c                       |   2 +-
 drivers/tty/serial/ar933x_uart.c                   |   6 +-
 drivers/tty/serial/atmel_serial.c                  |  22 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   5 +-
 drivers/tty/serial/clps711x.c                      |   6 +-
 drivers/tty/serial/cpm_uart.c                      |   6 +-
 drivers/tty/serial/digicolor-usart.c               |   6 +-
 drivers/tty/serial/esp32_acm.c                     |   7 +-
 drivers/tty/serial/esp32_uart.c                    |  16 +-
 drivers/tty/serial/fsl_linflexuart.c               |   6 +-
 drivers/tty/serial/fsl_lpuart.c                    |   5 +-
 drivers/tty/serial/imx.c                           |  63 +--
 drivers/tty/serial/jsm/jsm.h                       |   5 -
 drivers/tty/serial/jsm/jsm_cls.c                   |  36 --
 drivers/tty/serial/jsm/jsm_neo.c                   |  40 --
 drivers/tty/serial/lantiq.c                        |   6 +-
 drivers/tty/serial/liteuart.c                      |   6 +-
 drivers/tty/serial/lpc32xx_hs.c                    |   6 +-
 drivers/tty/serial/ma35d1_serial.c                 |   7 +-
 drivers/tty/serial/max310x.c                       |   2 +-
 drivers/tty/serial/mcf.c                           |   6 +-
 drivers/tty/serial/meson_uart.c                    |   8 +-
 drivers/tty/serial/milbeaut_usio.c                 |   6 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   7 +-
 drivers/tty/serial/msm_serial.c                    |  25 +-
 drivers/tty/serial/mxs-auart.c                     |  20 +-
 drivers/tty/serial/omap-serial.c                   |  33 +-
 drivers/tty/serial/owl-uart.c                      |   6 +-
 drivers/tty/serial/pic32_uart.c                    |   7 +-
 drivers/tty/serial/qcom_geni_serial.c              |   6 +-
 drivers/tty/serial/rda-uart.c                      |   6 +-
 drivers/tty/serial/rp2.c                           |   1 -
 drivers/tty/serial/sa1100.c                        |   6 +-
 drivers/tty/serial/samsung_tty.c                   |   6 +-
 drivers/tty/serial/sc16is7xx.c                     | 567 +++++++++++----------
 drivers/tty/serial/sccnxp.c                        |  13 +-
 drivers/tty/serial/serial-tegra.c                  |   5 +-
 drivers/tty/serial/serial_core.c                   |  88 +++-
 drivers/tty/serial/serial_txx9.c                   |   5 +-
 drivers/tty/serial/sh-sci.c                        |  13 +-
 drivers/tty/serial/sifive.c                        |  10 +-
 drivers/tty/serial/sprd_serial.c                   |   6 +-
 drivers/tty/serial/st-asc.c                        |   6 +-
 drivers/tty/serial/stm32-usart.c                   |  14 +-
 drivers/tty/serial/sunhv.c                         |   6 +-
 drivers/tty/serial/sunplus-uart.c                  |   6 +-
 drivers/tty/serial/sunsab.c                        |  22 +-
 drivers/tty/serial/sunsu.c                         |   6 +-
 drivers/tty/serial/sunzilog.c                      |   6 +-
 drivers/tty/serial/tegra-tcu.c                     |   6 +-
 drivers/tty/serial/timbuart.c                      |   6 +-
 drivers/tty/serial/uartlite.c                      |  20 +-
 drivers/tty/serial/ucc_uart.c                      |  34 +-
 drivers/tty/serial/xilinx_uartps.c                 |   7 +-
 drivers/tty/sysrq.c                                |  19 +-
 drivers/tty/tty_io.c                               |  18 +-
 drivers/tty/tty_ioctl.c                            |   4 +-
 drivers/tty/tty_port.c                             |  18 +-
 drivers/tty/vt/consolemap.c                        |   2 +-
 drivers/tty/vt/keyboard.c                          |  10 +-
 include/linux/amba/serial.h                        | 239 ++++-----
 include/linux/serdev.h                             |  29 +-
 include/linux/serial_core.h                        |   4 +-
 include/linux/tty.h                                |  19 +-
 include/linux/tty_driver.h                         |   9 +-
 include/linux/tty_port.h                           |   8 +-
 include/linux/virtio_console.h                     |  38 --
 include/uapi/linux/serial.h                        |  19 +-
 net/bluetooth/rfcomm/tty.c                         |   2 +-
 sound/drivers/serial-generic.c                     |   4 +-
 172 files changed, 1661 insertions(+), 1556 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/serial/arm,dcc.yaml
 delete mode 100644 include/linux/virtio_console.h

