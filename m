Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAA078FFD7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 17:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjIAPUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 11:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242639AbjIAPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:20:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDB6E65;
        Fri,  1 Sep 2023 08:20:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D76D463072;
        Fri,  1 Sep 2023 15:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7E3BC433C8;
        Fri,  1 Sep 2023 15:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693581622;
        bh=TtfeJdvrs8lsD8tKiVlOFiSI0YNVb58TFRZJuus9JB8=;
        h=Date:From:To:Cc:Subject:From;
        b=SADyyjSqGb0TpQaR1ExjJmUBg0YGYnaL9GyH0x+ZkaPTddgaoyU0NGSzwzwsU9AWQ
         gw9Hzm61xk9JgThwSl0uEWfZd8RPPCLrsZfGfdtPNvtd9YLhzB0LZ/5RFIl0AnV9It
         HepqpvZ4t+G4imi1k7X5gWTgKQbbdlHIMKzZG+Uc=
Date:   Fri, 1 Sep 2023 17:20:19 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Slaby <jslaby@suse.cz>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [GIT PULL] TTY/Serial driver changes for 6.6-rc1
Message-ID: <ZPIBMzDL-iw24DFI@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b320441c04c9bea76cbee1196ae55c20288fd7a6:

  Merge tag 'tty-6.5-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty (2023-08-20 08:26:51 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tags/tty-6.6-rc1

for you to fetch changes up to ebf05c7dc92c11b0355aaa0e94064beadaa4b05c:

  tty: shrink the size of struct tty_struct by 40 bytes (2023-08-27 11:47:44 +0200)

----------------------------------------------------------------
TTY/Serial driver changes for 6.6-rc1

Here is the big set of tty and serial driver changes for 6.6-rc1.

Lots of cleanups in here this cycle, and some driver updates.  Short
summary is:
  - Jiri's continued work to make the tty code and apis be a bit more
    sane with regards to modern kernel coding style and types
  - cpm_uart driver updates
  - n_gsm updates and fixes
  - meson driver updates
  - sc16is7xx driver updates
  - 8250 driver updates for different hardware types
  - qcom-geni driver fixes
  - tegra serial driver change
  - stm32 driver updates
  - synclink_gt driver cleanups
  - tty structure size reduction

All of these have been in linux-next this week with no reported issues.
The last bit of cleanups from Jiri and the tty structure size reduction
came in last week, a bit late but as they were just style changes and
size reductions, I figured they should get into this merge cycle so that
others can work on top of them with no merge conflicts.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Amelie Delaunay (1):
      serial: stm32: synchronize RX DMA channel in shutdown

Andy Shevchenko (1):
      serial: core: Remove unused PORT_* definitions

Anton Eliasson (1):
      tty: serial: samsung: Set missing PM ops for hibernation support

Chengfeng Ye (1):
      tty: synclink_gt: Fix potential deadlock on &info->lock

Christophe Leroy (15):
      serial: cpm_uart: Avoid suspicious locking
      serial: cpm_uart: Remove stale prototypes and table and macros
      serial: cpm_uart: Stop using fs_uart_id enum
      serial: cpm_uart: Use get_baudrate() instead of uart_baudrate()
      serial: cpm_uart: Deduplicate cpm_set_{brg/smc_fcr/scc_fcr}()
      serial: cpm_uart: Deduplicate cpm_line_cr_cmd()
      serial: cpm_uart: Refactor cpm_uart_allocbuf()/cpm_uart_freebuf()
      serial: cpm_uart: Refactor cpm_uart_[un]map_pram()
      serial: cpm_uart: Remove cpm_uart/ subdirectory
      serial: cpm_uart: Remove stale prototype in powerpc/fsl_soc.c
      serial: cpm_uart: Don't include fs_uart_pd.h when not needed
      serial: cpm_uart: Remove linux/fs_uart_pd.h
      Documentation: devices.txt: Remove ttyIOC*
      Documentation: devices.txt: Remove ttySIOC*
      Documentation: devices.txt: Fix minors for ttyCPM*

Chunyan Zhang (2):
      serial: sprd: Assign sprd_port after initialized to avoid wrong access
      serial: sprd: Fix DMA buffer leak issue

Daniel Starke (8):
      tty: n_gsm: add restart flag to DLC specific ioctl config
      tty: n_gsm: add missing description to structs in gsmmux.h
      tty: n_gsm: remove unneeded initialization of ret in gsm_dlci_config
      tty: n_gsm: add open_error counter to gsm_mux
      tty: n_gsm: increase malformed counter for malformed control frames
      tty: n_gsm: increase gsm_mux unsupported counted where appropriate
      tty: n_gsm: cleanup gsm_control_command and gsm_control_reply
      tty: n_gsm: add restart flag to extended ioctl config

Dmitry Rokosov (8):
      tty: serial: meson: use dev_err_probe
      tty: serial: meson: redesign the module to platform_driver
      tty: serial: meson: apply ttyS devname instead of ttyAML for new SoCs
      tty: serial: meson: introduce separate uart_data for S4 SoC family
      tty: serial: meson: add independent uart_data for A1 SoC family
      dt-bindings: serial: amlogic,meson-uart: support Amlogic A1
      arm64: dts: meson: a1: change uart compatible string
      tty: serial: meson: refactor objects definition for different devnames

Duje Mihanović (1):
      tty: serial: 8250: Define earlycon for mrvl,mmp-uart

Greg Kroah-Hartman (3):
      Merge 6.5-rc4 into tty-next
      Merge commit b320441c04c9 ("Merge tag 'tty-6.5-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty") into tty-next
      tty: shrink the size of struct tty_struct by 40 bytes

Hugo Villeneuve (8):
      serial: max310x: add comments for membase address workaround
      serial: max310x: fix typos in comments
      serial: sc16is7xx: fix broken port 0 uart init
      serial: sc16is7xx: remove obsolete out_thread label
      dt-bindings: sc16is7xx: Add property to change GPIO function
      serial: sc16is7xx: fix regression with GPIO configuration
      serial: sc16is7xx: fix bug when first setting GPIO direction
      serial: sc16is7xx: add missing support for rs485 devicetree properties

Hui Wang (1):
      serial: sc16is7xx: Put IOControl register into regmap_volatile

Jiapeng Chong (1):
      8250_men_mcb: Fix unsigned comparison with less than zero

Jiaqing Zhao (4):
      can: ems_pci: remove PCI_SUBVENDOR_ID_ASIX definition
      can: ems_pci: move ASIX AX99100 ids to pci_ids.h
      serial: 8250_pci: add support for ASIX AX99100
      parport_pc: add support for ASIX AX99100

Jiri Slaby (34):
      tty: make check_tty_count() void
      n_tty: drop fp from n_tty_receive_buf_real_raw()
      n_tty: simplify and sanitize zero_buffer()
      n_tty: pass ldata to canon_skip_eof() directly
      n_tty: make many tty parameters const
      tty: sysrq: rename and re-type i in sysrq_handle_loglevel()
      tty: sysrq: switch sysrq handlers from int to u8
      tty: sysrq: switch the rest of keys to u8
      tty: sysrq: use switch in sysrq_key_table_key2index()
      serial: convert uart sysrq handling to u8
      serial: make uart_insert_char() accept u8s
      serial: pass state to __uart_start() directly
      serial: arc_uart: simplify flags handling in arc_serial_rx_chars()
      serial: omap-serial: remove flag from serial_omap_rdi()
      serial: drivers: switch ch and flag to u8
      serial: move WARN_ON() in uart_write() to the condition
      Bluetooth: rfcomm: remove casts from tty->driver_data
      tty: hvsi: remove an extra variable from hvsi_write()
      input: serport: remove casts from tty->disc_data
      can: slcan: remove casts from tty->disc_data
      serial: altera_jtaguart: switch status to u32
      speakup: switch to unsigned iterator in spk_ttyio_receive_buf2()
      misc: ti-st: remove forward declarations and make st_int_recv() static
      misc: ti-st: remove ptr from recv functions
      misc: ti-st: don't check for tty data == NULL
      tty: synclink_gt: convert CALC_REGADDR() macro to an inline
      tty: synclink_gt: drop global slgt_driver_name array
      tty: synclink_gt: define global strings as const strings
      tty: synclink_gt: drop info messages from init/exit functions
      tty: synclink_gt: use PCI_VDEVICE
      tty: synclink_gt: make default_params const
      tty: synclink_gt: mark as BROKEN
      can: can327: remove casts from tty->disc_data
      net: nfc: remove casts from tty->disc_data

Jiri Slaby (SUSE) (62):
      tty: xtensa/iss: drop unneeded tty_operations hooks
      tty: ldisc: document that ldops are optional
      tty: remove dummy tty_ldisc_ops::poll() implementations
      tty: n_null: remove optional ldops
      tty: change tty_write_lock()'s ndelay parameter to bool
      tty: tty_port: rename 'disc' to 'ld'
      tty: drop tty_debug_wait_until_sent()
      tty: make tty_change_softcar() more understandable
      tty: make tty_port_client_operations operate with u8
      tty: make counts in tty_port_client_operations hooks size_t
      tty: switch receive_buf() counts to size_t
      tty: switch count in tty_ldisc_receive_buf() to size_t
      tty: can327: unify error paths in can327_ldisc_rx()
      tty: can327, move overflow test inside can327_ldisc_rx()'s loop
      tty: make tty_ldisc_ops::*buf*() hooks operate on size_t
      tty: use u8 for chars
      tty: use u8 for flags
      misc: ti-st: make st_recv() conforming to tty_ldisc_ops::receive_buf()
      tty: make char_buf_ptr()/flag_buf_ptr()'s offset unsigned
      tty: tty_buffer: make all offsets unsigned
      tty: don't pass write() to do_tty_write()
      tty: rename and de-inline do_tty_write()
      tty: use min() in iterate_tty_write()
      tty: use ssize_t for iterate_tty_read() returned type
      tty: switch size and count types in iterate_tty_read() to size_t
      tty: use min() for size computation in iterate_tty_read()
      tty: propagate u8 data to tty_operations::write()
      tty: propagate u8 data to tty_operations::put_char()
      tty: make tty_operations::write()'s count size_t
      tty: audit: unify to u8
      tty: ldops: unify to u8
      tty: hvc: convert counts to size_t
      tty: vcc: convert counts to size_t
      tty: gdm724x: convert counts to size_t
      tty: hso: simplify hso_serial_write()
      tty: rfcomm: convert counts to size_t
      tty: gdm724x: simplify gdm_tty_write()
      tty: gdm724x: use min_t() for size_t varable and a constant
      tty: tty_buffer: switch data type to u8
      tty: tty_buffer: use struct_size() in tty_buffer_alloc()
      tty: tty_buffer: unify tty_insert_flip_string_{fixed_flag,flags}()
      tty: tty_buffer: warn if losing flags in __tty_insert_flip_string_flags()
      tty: tty_buffer: switch insert functions to size_t
      tty: tty_buffer: let tty_prepare_flip_string() return size_t
      tty: tty_buffer: use __tty_insert_flip_string_flags() in tty_insert_flip_char()
      tty: tty_buffer: better types in __tty_buffer_request_room()
      tty: tty_buffer: initialize variables in initializers already
      tty: tty_buffer: invert conditions in __tty_buffer_request_room()
      tty: n_tty: make flow of n_tty_receive_buf_common() a bool
      tty: n_tty: use output character directly
      tty: n_tty: use 'num' for writes' counts
      tty: n_tty: use time_is_before_jiffies() in n_tty_receive_overrun()
      tty: n_tty: make n_tty_data::num_overrun unsigned
      tty: n_tty: use MASK() for masking out size bits
      tty: n_tty: move canon handling to a separate function
      tty: n_tty: move newline handling to a separate function
      tty: n_tty: remove unsigned char casts from character constants
      tty: n_tty: simplify chars_in_buffer()
      tty: n_tty: use u8 for chars and flags
      tty: n_tty: unify counts to size_t
      tty: n_tty: extract ECHO_OP processing to a separate function
      tty: n_tty: deduplicate copy code in n_tty_receive_buf_real_raw()

Jisheng Zhang (2):
      dt-bindings: serial: snps-dw-apb-uart: make interrupt optional
      serial: 8250_dw: fall back to poll if there's no interrupt

Johan Hovold (3):
      serial: qcom-geni: use icc tag defines
      serial: qcom-geni: fix opp vote on shutdown
      serial: qcom-geni: clean up clock-rate debug printk

Jon Hunter (1):
      serial: tegra: Don't print error on probe deferral

Justin Chen (1):
      serial: 8250_bcm7271: improve bcm7271 8250 port

Li Zetao (3):
      tty: serial: Remove redundant initialization for ma35d1serial_driver
      8250_men_mcb: Fix unsigned expression compared with zero
      8250_men_mcb: Remove redundant initialization owner in mcb_driver

Lucas Tanure (3):
      dt-bindings: serial: amlogic,meson-uart: Add compatible string for T7
      tty: serial: meson: Add a earlycon for the T7 SoC
      Revert "tty: serial: meson: Add a earlycon for the T7 SoC"

Nick Hu (1):
      serial: sifive: Add suspend and resume operations

Rob Herring (1):
      tty: Explicitly include correct DT includes

Rodríguez Barbarin, José Javier (3):
      8250_men_mcb: Add clockrate speed for G215/F215 boards
      8250_men_mcb: Read num ports from register data.
      8250_men_mcb: Make UART config auto configurable

Ruan Jinjie (2):
      tty: serial: xilinx_uartps: Do not check for 0 return after calling platform_get_irq()
      serial: sifive: Remove redundant of_match_ptr()

Sanjuán García, Jorge (1):
      8250_men_mcb: remove unnecessary cast when reading register

Sherry Sun (3):
      dt-bindings: serial: fsl-lpuart: correct imx93-lpuart dt-binding item
      tty: serial: fsl_lpuart: move the lpuart32_int() below
      tty: serial: fsl_lpuart: add IDLE interrupt support for rx_dma on imx7ulp/imx8ulp/imx8qxp

Thadeu Lima de Souza Cascardo (1):
      tty: n_gsm: require CAP_NET_ADMIN to attach N_GSM0710 ldisc

Valentin Caron (5):
      serial: stm32: avoid clearing DMAT bit during transfer
      serial: stm32: use DMAT as a configuration bit
      serial: stm32: modify parameter and rename stm32_usart_rx_dma_enabled
      serial: stm32: group dma pause/resume error handling into single function
      serial: stm32: replace access to DMAR bit by dmaengine_pause/resume

Vijaya Krishna Nivarthi (1):
      tty: serial: qcom-geni-serial: Poll primary sequencer irq status after cancel_tx

Yang Yingliang (1):
      8250_men_mcb: fix error handling in read_uarts_available_from_reg()

Yangtao Li (15):
      serial: ar933x: Use devm_platform_get_and_ioremap_resource()
      serial: bcm63xx-uart: Use devm_platform_get_and_ioremap_resource()
      serial: clps711x: Use devm_platform_get_and_ioremap_resource()
      serial: linflexuart: Use devm_platform_get_and_ioremap_resource()
      serial: tegra: Use devm_platform_get_and_ioremap_resource()
      serial: omap: Use devm_platform_get_and_ioremap_resource()
      serial: fsl_lpuart: Use devm_platform_get_and_ioremap_resource()
      serial: vt8500: Use devm_platform_get_and_ioremap_resource()
      serial: mps2-uart: Use devm_platform_get_and_ioremap_resource()
      serial: sprd: Use devm_platform_get_and_ioremap_resource()
      serial: sccnxp: Use devm_platform_get_and_ioremap_resource()
      serial: mvebu-uart: Use devm_platform_get_and_ioremap_resource()
      serial: sifive: Use devm_platform_get_and_ioremap_resource()
      serial: imx: Use devm_platform_get_and_ioremap_resource()
      serial: st-asc: Use devm_platform_get_and_ioremap_resource()

Yi Yang (1):
      serial: tegra: handle clk prepare error in tegra_uart_hw_init()

Yuanjun Gong (1):
      drivers:tty: fix return value check in asc_init_port

oushixiong (1):
      tty: vt: Remove some repetitive initialization

 Documentation/admin-guide/devices.txt              |  16 +-
 .../bindings/serial/amlogic,meson-uart.yaml        |   6 +
 .../devicetree/bindings/serial/fsl-lpuart.yaml     |   6 +-
 .../devicetree/bindings/serial/nxp,sc16is7xx.txt   |  46 ++
 .../bindings/serial/snps-dw-apb-uart.yaml          |   1 -
 Documentation/driver-api/tty/tty_buffer.rst        |   7 +-
 arch/alpha/kernel/setup.c                          |   2 +-
 arch/alpha/kernel/srmcons.c                        |   5 +-
 arch/arm64/boot/dts/amlogic/meson-a1.dtsi          |   4 +-
 arch/loongarch/kernel/sysrq.c                      |   2 +-
 arch/m68k/emu/nfcon.c                              |   8 +-
 arch/mips/kernel/sysrq.c                           |   2 +-
 arch/powerpc/include/asm/fs_pd.h                   |  10 -
 arch/powerpc/platforms/8xx/mpc885ads_setup.c       |   1 -
 arch/powerpc/platforms/8xx/tqm8xx_setup.c          |   1 -
 arch/powerpc/sysdev/fsl_soc.c                      |   2 -
 arch/powerpc/xmon/xmon.c                           |   2 +-
 arch/sparc/include/asm/vio.h                       |   2 +-
 arch/sparc/kernel/process_64.c                     |   4 +-
 arch/um/drivers/line.c                             |   2 +-
 arch/um/drivers/line.h                             |   3 +-
 arch/xtensa/platforms/iss/console.c                |  27 +-
 drivers/accessibility/speakup/spk_ttyio.c          |   7 +-
 drivers/bluetooth/hci_ldisc.c                      |  15 +-
 drivers/char/ttyprintk.c                           |   5 +-
 drivers/gpu/drm/drm_fb_helper.c                    |   2 +-
 drivers/input/serio/serport.c                      |  18 +-
 drivers/ipack/devices/ipoctal.c                    |   7 +-
 drivers/isdn/capi/capi.c                           |   8 +-
 drivers/misc/bcm-vk/bcm_vk_tty.c                   |   5 +-
 drivers/misc/ti-st/st_core.c                       |  18 +-
 drivers/misc/ti-st/st_kim.c                        |  13 +-
 drivers/mmc/core/sdio_uart.c                       |   4 +-
 drivers/net/caif/caif_serial.c                     |   2 +-
 drivers/net/can/can327.c                           |  47 +-
 drivers/net/can/sja1000/ems_pci.c                  |   7 +-
 drivers/net/can/slcan/slcan-core.c                 |  13 +-
 drivers/net/hamradio/6pack.c                       |   4 +-
 drivers/net/hamradio/mkiss.c                       |   4 +-
 drivers/net/mctp/mctp-serial.c                     |   5 +-
 drivers/net/ppp/ppp_async.c                        |  26 +-
 drivers/net/ppp/ppp_synctty.c                      |  26 +-
 drivers/net/slip/slip.c                            |   4 +-
 drivers/net/usb/hso.c                              |  20 +-
 drivers/parport/parport_pc.c                       |   5 +
 drivers/s390/char/con3215.c                        |   6 +-
 drivers/s390/char/con3270.c                        |   6 +-
 drivers/s390/char/sclp_tty.c                       |  10 +-
 drivers/s390/char/sclp_vt220.c                     |   6 +-
 drivers/staging/gdm724x/gdm_tty.c                  |  17 +-
 drivers/staging/greybus/uart.c                     |   3 +-
 drivers/tty/Kconfig                                |   1 +
 drivers/tty/amiserial.c                            |   4 +-
 drivers/tty/ehv_bytechan.c                         |   4 +-
 drivers/tty/goldfish.c                             |   7 +-
 drivers/tty/hvc/hvc_console.c                      |   4 +-
 drivers/tty/hvc/hvc_opal.c                         |   2 +-
 drivers/tty/hvc/hvcs.c                             |  10 +-
 drivers/tty/hvc/hvsi.c                             |  15 +-
 drivers/tty/ipwireless/hardware.c                  |   2 +-
 drivers/tty/ipwireless/tty.c                       |   4 +-
 drivers/tty/mips_ejtag_fdc.c                       |   6 +-
 drivers/tty/moxa.c                                 |   8 +-
 drivers/tty/mxser.c                                |   4 +-
 drivers/tty/n_gsm.c                                |  89 ++-
 drivers/tty/n_hdlc.c                               |  12 +-
 drivers/tty/n_null.c                               |  25 +-
 drivers/tty/n_tty.c                                | 613 +++++++++++----------
 drivers/tty/nozomi.c                               |   6 +-
 drivers/tty/pty.c                                  |   2 +-
 drivers/tty/rpmsg_tty.c                            |   5 +-
 drivers/tty/serdev/serdev-ttyport.c                |   4 +-
 drivers/tty/serial/21285.c                         |   3 +-
 drivers/tty/serial/8250/8250_bcm7271.c             |   4 +-
 drivers/tty/serial/8250/8250_dw.c                  |   5 +-
 drivers/tty/serial/8250/8250_early.c               |   1 -
 drivers/tty/serial/8250/8250_ingenic.c             |   1 -
 drivers/tty/serial/8250/8250_men_mcb.c             | 210 +++++--
 drivers/tty/serial/8250/8250_omap.c                |   1 -
 drivers/tty/serial/8250/8250_pci.c                 |  10 +
 drivers/tty/serial/8250/8250_port.c                |  11 +-
 drivers/tty/serial/8250/8250_pxa.c                 |   1 +
 drivers/tty/serial/Makefile                        |   2 +-
 drivers/tty/serial/altera_jtaguart.c               |   4 +-
 drivers/tty/serial/altera_uart.c                   |   2 +-
 drivers/tty/serial/amba-pl010.c                    |   3 +-
 drivers/tty/serial/amba-pl011.c                    |   5 +-
 drivers/tty/serial/apbuart.c                       |   6 +-
 drivers/tty/serial/ar933x_uart.c                   |   3 +-
 drivers/tty/serial/arc_uart.c                      |  27 +-
 drivers/tty/serial/atmel_serial.c                  |   3 +-
 drivers/tty/serial/bcm63xx_uart.c                  |   8 +-
 drivers/tty/serial/clps711x.c                      |   6 +-
 .../{cpm_uart/cpm_uart_core.c => cpm_uart.c}       | 157 +++++-
 drivers/tty/serial/{cpm_uart => }/cpm_uart.h       |  38 +-
 drivers/tty/serial/cpm_uart/Makefile               |  12 -
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c        | 122 ----
 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h        |  33 --
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c        | 156 ------
 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h        |  33 --
 drivers/tty/serial/digicolor-usart.c               |   3 +-
 drivers/tty/serial/dz.c                            |   2 +-
 drivers/tty/serial/fsl_linflexuart.c               |  10 +-
 drivers/tty/serial/fsl_lpuart.c                    |  88 ++-
 drivers/tty/serial/imx.c                           |   4 +-
 drivers/tty/serial/ip22zilog.c                     |   2 +-
 drivers/tty/serial/kgdb_nmi.c                      |   3 +-
 drivers/tty/serial/lantiq.c                        |   3 +-
 drivers/tty/serial/liteuart.c                      |   3 +-
 drivers/tty/serial/ma35d1_serial.c                 |   3 +-
 drivers/tty/serial/max3100.c                       |   3 +-
 drivers/tty/serial/max310x.c                       |  10 +-
 drivers/tty/serial/mcf.c                           |   2 +-
 drivers/tty/serial/meson_uart.c                    | 138 +++--
 drivers/tty/serial/milbeaut_usio.c                 |   3 +-
 drivers/tty/serial/mpc52xx_uart.c                  |   2 +-
 drivers/tty/serial/mps2-uart.c                     |   4 +-
 drivers/tty/serial/mvebu-uart.c                    |  11 +-
 drivers/tty/serial/mxs-auart.c                     |   5 +-
 drivers/tty/serial/omap-serial.c                   |  11 +-
 drivers/tty/serial/pic32_uart.c                    |   1 -
 drivers/tty/serial/pxa.c                           |   2 +-
 drivers/tty/serial/qcom_geni_serial.c              |  17 +-
 drivers/tty/serial/rp2.c                           |   4 +-
 drivers/tty/serial/sa1100.c                        |   3 +-
 drivers/tty/serial/samsung_tty.c                   |   8 +-
 drivers/tty/serial/sb1250-duart.c                  |   3 +-
 drivers/tty/serial/sc16is7xx.c                     | 170 ++++--
 drivers/tty/serial/sccnxp.c                        |   7 +-
 drivers/tty/serial/serial-tegra.c                  |  29 +-
 drivers/tty/serial/serial_core.c                   |  28 +-
 drivers/tty/serial/serial_txx9.c                   |   3 +-
 drivers/tty/serial/sh-sci.c                        |   1 -
 drivers/tty/serial/sifive.c                        |  29 +-
 drivers/tty/serial/sprd_serial.c                   |  38 +-
 drivers/tty/serial/st-asc.c                        |   9 +-
 drivers/tty/serial/stm32-usart.c                   | 312 ++++++-----
 drivers/tty/serial/stm32-usart.h                   |   1 +
 drivers/tty/serial/sunhv.c                         |   4 +-
 drivers/tty/serial/sunplus-uart.c                  |   2 +-
 drivers/tty/serial/sunsab.c                        |   3 +-
 drivers/tty/serial/sunsu.c                         |   4 +-
 drivers/tty/serial/sunzilog.c                      |   4 +-
 drivers/tty/serial/tegra-tcu.c                     |   1 -
 drivers/tty/serial/uartlite.c                      |   3 -
 drivers/tty/serial/ucc_uart.c                      |   4 +-
 drivers/tty/serial/vt8500_serial.c                 |   8 +-
 drivers/tty/serial/xilinx_uartps.c                 |   4 +-
 drivers/tty/serial/zs.c                            |   3 +-
 drivers/tty/synclink_gt.c                          |  83 ++-
 drivers/tty/sysrq.c                                |  84 ++-
 drivers/tty/tty.h                                  |   8 +-
 drivers/tty/tty_audit.c                            |   6 +-
 drivers/tty/tty_buffer.c                           | 192 ++-----
 drivers/tty/tty_io.c                               |  50 +-
 drivers/tty/tty_ioctl.c                            |  18 +-
 drivers/tty/tty_port.c                             |  34 +-
 drivers/tty/ttynull.c                              |   4 +-
 drivers/tty/vcc.c                                  |  18 +-
 drivers/tty/vt/selection.c                         |   2 +-
 drivers/tty/vt/vt.c                                |  22 +-
 drivers/usb/class/cdc-acm.c                        |   8 +-
 drivers/usb/gadget/function/u_serial.c             |   6 +-
 drivers/usb/host/xhci-dbgtty.c                     |   7 +-
 drivers/usb/serial/usb-serial.c                    |   5 +-
 include/linux/fs_uart_pd.h                         |  71 ---
 include/linux/pci_ids.h                            |   4 +
 include/linux/serial_core.h                        |  18 +-
 include/linux/sysrq.h                              |  18 +-
 include/linux/ti_wilink_st.h                       |   2 +-
 include/linux/tty.h                                |  18 +-
 include/linux/tty_buffer.h                         |  20 +-
 include/linux/tty_driver.h                         |   9 +-
 include/linux/tty_flip.h                           |  70 ++-
 include/linux/tty_ldisc.h                          |  67 ++-
 include/linux/tty_port.h                           |   7 +-
 include/uapi/linux/gsmmux.h                        | 118 +++-
 include/uapi/linux/serial_core.h                   |  44 +-
 kernel/debug/debug_core.c                          |   2 +-
 kernel/power/poweroff.c                            |   2 +-
 kernel/rcu/tree_stall.h                            |   2 +-
 net/bluetooth/rfcomm/tty.c                         |  31 +-
 net/nfc/nci/uart.c                                 |  23 +-
 sound/soc/codecs/cx20442.c                         |   4 +-
 sound/soc/ti/ams-delta.c                           |   2 +-
 185 files changed, 2104 insertions(+), 2156 deletions(-)
 rename drivers/tty/serial/{cpm_uart/cpm_uart_core.c => cpm_uart.c} (90%)
 rename drivers/tty/serial/{cpm_uart => }/cpm_uart.h (64%)
 delete mode 100644 drivers/tty/serial/cpm_uart/Makefile
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm1.h
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.c
 delete mode 100644 drivers/tty/serial/cpm_uart/cpm_uart_cpm2.h
 delete mode 100644 include/linux/fs_uart_pd.h
