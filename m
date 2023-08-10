Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 100097773FA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjHJJPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjHJJPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:15:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B2630CF;
        Thu, 10 Aug 2023 02:15:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FC09612F0;
        Thu, 10 Aug 2023 09:15:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7402C433C7;
        Thu, 10 Aug 2023 09:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691658913;
        bh=5PKtYgrRjs6mBcBmT57eNVD5r07unjmFtUNS6mNZRiM=;
        h=From:To:Cc:Subject:Date:From;
        b=Kxzh5UYD/Hn2Zualua8K8clcHPFYjVIPqxx9VSaBjJFG6+vviHg5l8GTtMWVU1FSV
         ish8GkUkqJM1NO4Wts9fM2TPd+N+V7OueiWFIwCJUN2hbJDfyB3PVTX5chT+KSnVFu
         /nI5yaJQfgqkFeROZA9lQDJxKpPM6C1WXAjJjpuQc+QqIqjkf2Jc77K91vu7FrZ0hn
         5oSivc6Roj5cA2MN8U0PZP6Sxkd9ekiBvA8OxNVpJHKAVcfFqvnkCLxXLFcqWURqdH
         CAeNMGiV4O6PFw9I1tjQk3v1MXuqgYLiBJqYY/TRDYE1rx6Jijigwb95cTt7JOrA1P
         6utwf5GggOHhw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 00/36] tty: type unifications -- part I.
Date:   Thu, 10 Aug 2023 11:14:34 +0200
Message-ID: <20230810091510.13006-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the tty layer ops and functions use various types for same
things:
* characters and flags: unsigned char, char are used on a random basis,
* counts: int, unsigned int, size_t are used, again more-or-less
  randomly.

This makes it rather hard to remember where each type is required and it
also makes the code harder to follow. Also the code has to do min_t() on
many places simply because the variables hold the same kind of data, but
of different type.

This is the first part of the series to unify the types:
* make characters and flags 'u8'. This is what the hardware expects and
  what feeds the tty layer with. Since we compile with -funsigned-char,
  char and unsigned char are the same types on all platforms. So there
  is no actual change in type.
* make sizes/counts 'size_t'. This is what comes from the VFS layer and
  some tty functions already operate on this. So instead of using
  "shorter" (in term of bytes on 64bit) unsigned int, stick to size_t
  and promote it to most places.

More cleanup and spreading will be done in tty_buffer, n_tty, and
likely other places later.

Patches 1-8 are cleanups only. The rest (the real switch) depends on
those.

Jiri Slaby (SUSE) (36):
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

 arch/alpha/kernel/srmcons.c               |  5 +-
 arch/m68k/emu/nfcon.c                     |  8 +--
 arch/sparc/include/asm/vio.h              |  2 +-
 arch/um/drivers/line.c                    |  2 +-
 arch/um/drivers/line.h                    |  3 +-
 arch/xtensa/platforms/iss/console.c       | 27 +--------
 drivers/accessibility/speakup/spk_ttyio.c |  5 +-
 drivers/bluetooth/hci_ldisc.c             | 15 ++---
 drivers/char/ttyprintk.c                  |  5 +-
 drivers/input/serio/serport.c             |  8 +--
 drivers/ipack/devices/ipoctal.c           |  7 +--
 drivers/isdn/capi/capi.c                  |  8 +--
 drivers/misc/bcm-vk/bcm_vk_tty.c          |  5 +-
 drivers/misc/ti-st/st_core.c              | 11 ++--
 drivers/misc/ti-st/st_kim.c               |  6 +-
 drivers/mmc/core/sdio_uart.c              |  4 +-
 drivers/net/caif/caif_serial.c            |  2 +-
 drivers/net/can/can327.c                  | 39 ++++++-------
 drivers/net/can/slcan/slcan-core.c        |  5 +-
 drivers/net/hamradio/6pack.c              |  4 +-
 drivers/net/hamradio/mkiss.c              |  4 +-
 drivers/net/mctp/mctp-serial.c            |  5 +-
 drivers/net/ppp/ppp_async.c               | 26 +++------
 drivers/net/ppp/ppp_synctty.c             | 26 +++------
 drivers/net/slip/slip.c                   |  4 +-
 drivers/net/usb/hso.c                     | 20 +++----
 drivers/s390/char/con3215.c               |  6 +-
 drivers/s390/char/con3270.c               |  6 +-
 drivers/s390/char/sclp_tty.c              | 10 ++--
 drivers/s390/char/sclp_vt220.c            |  6 +-
 drivers/staging/gdm724x/gdm_tty.c         | 14 ++---
 drivers/staging/greybus/uart.c            |  3 +-
 drivers/tty/amiserial.c                   |  4 +-
 drivers/tty/ehv_bytechan.c                |  4 +-
 drivers/tty/goldfish.c                    |  7 +--
 drivers/tty/hvc/hvc_console.c             |  4 +-
 drivers/tty/hvc/hvcs.c                    | 10 ++--
 drivers/tty/hvc/hvsi.c                    | 14 ++---
 drivers/tty/ipwireless/hardware.c         |  2 +-
 drivers/tty/ipwireless/tty.c              |  4 +-
 drivers/tty/mips_ejtag_fdc.c              |  6 +-
 drivers/tty/moxa.c                        |  8 +--
 drivers/tty/mxser.c                       |  4 +-
 drivers/tty/n_gsm.c                       | 14 ++---
 drivers/tty/n_hdlc.c                      | 12 ++--
 drivers/tty/n_null.c                      | 25 +--------
 drivers/tty/n_tty.c                       | 59 ++++++++++----------
 drivers/tty/nozomi.c                      |  6 +-
 drivers/tty/pty.c                         |  2 +-
 drivers/tty/rpmsg_tty.c                   |  5 +-
 drivers/tty/serdev/serdev-ttyport.c       |  4 +-
 drivers/tty/serial/kgdb_nmi.c             |  3 +-
 drivers/tty/serial/serial_core.c          |  5 +-
 drivers/tty/synclink_gt.c                 | 13 ++---
 drivers/tty/tty.h                         |  8 +--
 drivers/tty/tty_audit.c                   |  6 +-
 drivers/tty/tty_buffer.c                  | 35 ++++++------
 drivers/tty/tty_io.c                      | 46 +++++++---------
 drivers/tty/tty_ioctl.c                   | 18 ++----
 drivers/tty/tty_port.c                    | 34 ++++++------
 drivers/tty/ttynull.c                     |  4 +-
 drivers/tty/vcc.c                         | 18 +++---
 drivers/tty/vt/selection.c                |  2 +-
 drivers/tty/vt/vt.c                       |  6 +-
 drivers/usb/class/cdc-acm.c               |  8 +--
 drivers/usb/gadget/function/u_serial.c    |  6 +-
 drivers/usb/host/xhci-dbgtty.c            |  7 +--
 drivers/usb/serial/usb-serial.c           |  5 +-
 include/linux/ti_wilink_st.h              |  2 +-
 include/linux/tty_buffer.h                | 18 +++---
 include/linux/tty_driver.h                |  9 ++-
 include/linux/tty_flip.h                  | 22 ++++----
 include/linux/tty_ldisc.h                 | 67 +++++++++++++++--------
 include/linux/tty_port.h                  |  7 ++-
 net/bluetooth/rfcomm/tty.c                |  9 +--
 net/nfc/nci/uart.c                        | 15 ++---
 sound/soc/codecs/cx20442.c                |  4 +-
 sound/soc/ti/ams-delta.c                  |  2 +-
 78 files changed, 381 insertions(+), 493 deletions(-)

-- 
2.41.0

