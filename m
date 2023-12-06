Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E567806889
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbjLFHhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjLFHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:37:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FA122
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE83C433C7;
        Wed,  6 Dec 2023 07:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848241;
        bh=4VW8X1jOwmko0gg2sXMWQxFcUR2o/UbpfTeUI9q7Edo=;
        h=From:To:Cc:Subject:Date:From;
        b=bu8z34iM5zyJFdBt4mnT5Fe71rAi1pTj3uxvkl7m4It8cG5IPQ5cELCU7Hcyn9bm0
         YrPH7+t4kqO++IK8ThPph+TjEI34rKJ1F78saK85cyEmSkhpvlt/MXuM2MexzBGDvc
         LsLxprvg/HFtnhazX0pH5FyoIjCKa9mV0mpNSjDjs239qWtZgAdt4zTf5n2o0n6jcu
         4NfBuoUBma+NeCmmW1TvUg2oNwowx685wy89kabVlac8zAa2vZSC56u4LOC3aC7Gt4
         OX8RdnvhwCgyl2wbllNV/ud4wLPk7k6KK4Q3+ymzQS8XOOuKILOU1aeZovOUVq/0oH
         ss5dPs9ljBi8g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Amit Shah <amit@kernel.org>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Chris Zankel <chris@zankel.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Karsten Keil <isdn@linux-pingi.de>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Matt Turner <mattst88@gmail.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 00/27] tty: type unifications -- the last part
Date:   Wed,  6 Dec 2023 08:36:45 +0100
Message-ID: <20231206073712.17776-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a continuation of the previous cleanups in the tty layer.
Especially those in the character and size types. As this patchset
propagates the unified u8 and size_t to most of the drivers, this is the
last part of this very rework.

If people still see char or unsigned char for a character (or flag),
please fix. The same holds for signed ints used as sizes.

Note that the first two patches are mostly preparatory cleanup. The rest
is switch to u8 and size_t of the tx paths in drivers.

Cc: Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Amit Shah <amit@kernel.org>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Chris Zankel <chris@zankel.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Jens Taprogge <jens.taprogge@taprogge.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: Karsten Keil <isdn@linux-pingi.de>
Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>
Cc: Matt Turner <mattst88@gmail.com>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Richard Weinberger <richard@nod.at>
Cc: Rob Herring <robh@kernel.org>
Cc: Scott Branden <scott.branden@broadcom.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>

Jiri Slaby (SUSE) (27):
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

 arch/alpha/kernel/srmcons.c                   |  6 ++---
 arch/m68k/emu/nfcon.c                         |  4 ++--
 arch/powerpc/include/asm/hvconsole.h          |  4 ++--
 arch/powerpc/include/asm/hvsi.h               | 18 +++++++-------
 arch/powerpc/include/asm/opal.h               |  8 ++++---
 arch/powerpc/platforms/powernv/opal.c         | 14 ++++++-----
 arch/powerpc/platforms/pseries/hvconsole.c    |  4 ++--
 arch/um/drivers/chan.h                        |  2 +-
 arch/um/drivers/chan_kern.c                   |  9 ++++---
 arch/um/drivers/chan_user.c                   |  4 ++--
 arch/um/drivers/chan_user.h                   |  9 +++----
 arch/um/drivers/line.c                        |  2 +-
 arch/um/drivers/line.h                        |  6 ++---
 arch/um/drivers/null.c                        |  2 +-
 arch/xtensa/platforms/iss/console.c           |  2 +-
 drivers/bluetooth/btmtkuart.c                 |  4 ++--
 drivers/bluetooth/btnxpuart.c                 |  4 ++--
 drivers/bluetooth/hci_serdev.c                |  4 ++--
 drivers/char/ttyprintk.c                      |  6 ++---
 drivers/char/virtio_console.c                 | 10 ++++----
 drivers/gnss/serial.c                         |  4 ++--
 drivers/gnss/sirf.c                           |  4 ++--
 drivers/greybus/gb-beagleplay.c               |  5 ++--
 drivers/iio/chemical/pms7003.c                |  6 ++---
 drivers/iio/chemical/scd30_serial.c           |  6 ++---
 drivers/iio/chemical/sps30_serial.c           | 18 +++++++-------
 drivers/iio/imu/bno055/bno055_ser_core.c      |  6 ++---
 drivers/ipack/devices/ipoctal.c               | 14 +++++------
 drivers/isdn/capi/capi.c                      |  4 ++--
 drivers/mfd/rave-sp.c                         | 10 ++++----
 drivers/misc/bcm-vk/bcm_vk_tty.c              |  4 ++--
 drivers/mmc/core/sdio_uart.c                  | 22 +++++++----------
 drivers/net/ethernet/qualcomm/qca_uart.c      |  5 ++--
 drivers/nfc/pn533/uart.c                      |  4 ++--
 drivers/nfc/s3fwrn5/uart.c                    |  5 ++--
 drivers/platform/chrome/cros_ec_uart.c        |  5 ++--
 .../platform/surface/aggregator/controller.h  |  4 ++--
 drivers/platform/surface/aggregator/core.c    |  4 ++--
 .../surface/aggregator/ssh_packet_layer.c     |  4 ++--
 .../surface/aggregator/ssh_packet_layer.h     |  2 +-
 drivers/s390/char/con3215.c                   | 24 +++++++++----------
 drivers/s390/char/con3270.c                   | 12 +++++-----
 drivers/tty/amiserial.c                       |  6 ++---
 drivers/tty/ehv_bytechan.c                    | 11 ++++-----
 drivers/tty/goldfish.c                        | 20 +++++++---------
 drivers/tty/hvc/hvc_console.h                 |  4 ++--
 drivers/tty/hvc/hvc_dcc.c                     | 24 +++++++++----------
 drivers/tty/hvc/hvc_iucv.c                    | 18 +++++++-------
 drivers/tty/hvc/hvc_opal.c                    |  5 ++--
 drivers/tty/hvc/hvc_riscv_sbi.c               |  9 +++----
 drivers/tty/hvc/hvc_rtas.c                    | 11 +++++----
 drivers/tty/hvc/hvc_udbg.c                    |  9 +++----
 drivers/tty/hvc/hvc_vio.c                     | 18 +++++++-------
 drivers/tty/hvc/hvc_xen.c                     | 23 +++++++++---------
 drivers/tty/hvc/hvsi_lib.c                    | 20 +++++++++-------
 drivers/tty/mips_ejtag_fdc.c                  | 10 ++++----
 drivers/tty/moxa.c                            | 15 ++++++------
 drivers/tty/mxser.c                           |  8 +++----
 drivers/tty/n_gsm.c                           | 17 +++++++------
 drivers/tty/n_hdlc.c                          | 10 ++++----
 drivers/tty/nozomi.c                          |  9 ++++---
 drivers/tty/serdev/core.c                     | 12 ++++------
 drivers/tty/serdev/serdev-ttyport.c           |  2 +-
 drivers/tty/serial/serial_core.c              |  2 +-
 drivers/tty/tty_io.c                          | 12 +++++-----
 drivers/tty/tty_port.c                        |  2 +-
 include/linux/serdev.h                        | 21 ++++++++--------
 include/linux/tty.h                           |  6 ++---
 include/linux/tty_driver.h                    |  4 ++--
 include/linux/tty_port.h                      |  4 ++--
 net/bluetooth/rfcomm/tty.c                    |  2 +-
 sound/drivers/serial-generic.c                |  4 ++--
 72 files changed, 306 insertions(+), 306 deletions(-)

-- 
2.43.0

