Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B62EB800F9F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 17:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378379AbjLAQE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:04:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjLAQEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:04:54 -0500
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B880C10DE;
        Fri,  1 Dec 2023 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
        s=office2-2020; t=1701446167;
        bh=blRPznuOYE6dlUwmDgzSjq7L6S7lteGDmHiIree5W48=;
        h=Resent-Date:Resent-From:Resent-To:Resent-Cc:From:Date:Subject:To:
         Cc;
        b=JjnSq3c7EFDb23S/ooLBoxbz1GriUiNYNUKyInR+sjqTwN8lkfScKTfE/jmc92yCD
         MNPd8cwrwaEsxjdkzn2MJeYsDGC9iJs8srQ9CwZ2Pv1YHXaJnxE0ebuYRre2tcIQ7g
         GpXmhxNHmam96JNpFEF2ZpMNlkShE/SXNZeyxHDebyB8uH05uwAAdGCi0/tYerFNQ5
         0oEF/U8fz/H/zbdZeCi+Y2N+pbgrwQ6ZzplWBmzKtQKuczIY1t4Sa3fzyBpW7dvZoF
         Fki0AmrINOxvYymW45fCPmf1TAxDw3SvgfG4MOXlv2VrggcurscfmAS5/E8wQG9h7b
         +a/ybtA/Bvu8w==
Received: from localhost (tlha232.cesnet.cz [IPv6:2001:718:1:6::134:232])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by office2.cesnet.cz (Postfix) with ESMTPSA id 06C501180072;
        Fri,  1 Dec 2023 16:56:04 +0100 (CET)
Message-ID: <bd91db46c50615bc1d1d62beb659fa7f62386446.1701446070.git.jan.kundrat@cesnet.cz>
From:   =?UTF-8?q?Jan=20Kundr=C3=A1t?= <jan.kundrat@cesnet.cz>
Date:   Fri, 1 Dec 2023 15:51:51 +0100
Subject: [PATCH] tty: max310x: work around regmap->regcache data corruption
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Mark Brown <broonie@kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-serial@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TL;DR summary is that the regmap_noinc_write spills over the data
that are correctly written to the HW also to the following registers in
the regcache. As a result, regcache then contains user-controlled
garbage which will be used later for bit updates on unrelated registers.

This patch is a "wrong" fix; a real fix would involve fixing regmap
and/or regcache, but that code has too many indirections for my little
mind.

I was investigating a regression that happened somewhere between 5.12.4
(plus 14 of our patches) and v6.5.9 (plus 7 of our patches). Our
MAX14830 UART would work fine the first time, but when our application
opens the UART the second time it just wouldn't send anything over the
physical TX pin. With the help of a logical analyzer, I found out that
the kernel was sending value 0xcd to the MODE1 register, which on this
chip is a request to set the UART's TX pin to the Hi-Z mode and to
switch off RX completely. That's certainly not the intention of the
code, but that's what I was seeing on the physical SPI bus, and also in
the log when I instrumented the regmap layer.

It turned out that one of the *data* bytes which were sent over the UART
was 0xdd, and that this *data byte* somehow ended up in the regcache's
idea about the value within the MODE1 register. When the UART is opened
up the next time and max310x_startup updates a single unrelated bit in
MODE1, that code consults the regcache, notices the 0xdd data byte in
there, and ends up sending 0xcd over SPI.

Here's what dump_stack() shows:

 max310x spi1.2: regcache_write: reg 0x9 value 0xdd
 max310x spi1.2: PWNED
 CPU: 1 PID: 26 Comm: kworker/1:1 Not tainted 6.5.9-7-g9e090fe75fd8 #7
 Hardware name: Marvell Armada 380/385 (Device Tree)
 Workqueue: events max310x_tx_proc
  unwind_backtrace from show_stack+0x10/0x14
  show_stack from dump_stack_lvl+0x40/0x4c
  dump_stack_lvl from regcache_write+0xc0/0xc4
  regcache_write from _regmap_raw_write_impl+0x178/0x828
  _regmap_raw_write_impl from _regmap_raw_write+0xb8/0x134
  _regmap_raw_write from regmap_noinc_write+0x130/0x178
  regmap_noinc_write from max310x_tx_proc+0xd4/0x1a4
  max310x_tx_proc from process_one_work+0x21c/0x4e4
  process_one_work from worker_thread+0x50/0x54c
  worker_thread from kthread+0xe0/0xfc
  kthread from ret_from_fork+0x14/0x28

Clearly, regmap_noinc_write of a register 0x00 (that's the TX FIFO on
this chip) has no business updating register 0x09, but that's what was
happening here. The regmap_config is already set up in a way that
register 0x00 is marked precious and volatile, so it has no business
going through the cache at all. Also, the documentation for
regmap_noinc_write suggests that this driver was using the regmap
infrastructure correctly, and that the real bug is somewhere in
regmap/regcache where a call to regmap_noinc_write end up updating an
unrelated register in regcache.

Until regmap/regcache is fixed, let's just use an adapted version of the
old code that bypasses regmap altogether, and just sends out an SPI
transaction.

This is related to my commit 3f42b142ea1171967e40e10e4b0241c0d6d28d41
("serial: max310x: fix IO data corruption in batched operations") which
introduced usage of regmap_noinc_write() to this driver. That commit is
a fixup of commit 285e76fc049c4d32c772eea9460a7ef28a193802 ("serial:
max310x: use regmap methods for SPI batch operations") which started
using regmap_raw_write(), which was however also a wrong function.

Fixes: 3f42b142ea11 ("serial: max310x: fix IO data corruption in batched operations")
Fixes: 285e76fc049c ("serial: max310x: use regmap methods for SPI batch operations")
Signed-off-by: Jan Kundrát <jan.kundrat@cesnet.cz>
To: Mark Brown <broonie@kernel.org>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>
To: linux-serial@vger.kernel.org
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org
---
 drivers/tty/serial/max310x.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index c44237470bee..79797b573723 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -663,16 +663,34 @@ static u32 max310x_set_ref_clk(struct device *dev, struct max310x_port *s,
 
 static void max310x_batch_write(struct uart_port *port, u8 *txbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-
-	regmap_noinc_write(one->regmap, MAX310X_THR_REG, txbuf, len);
+	const u8 header = (port->iobase * 0x20 + MAX310X_THR_REG) | MAX310X_WRITE_BIT;
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &header,
+			.len = 1,
+		},
+		{
+			.tx_buf = txbuf,
+			.len = len,
+		},
+	};
+	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
 }
 
 static void max310x_batch_read(struct uart_port *port, u8 *rxbuf, unsigned int len)
 {
-	struct max310x_one *one = to_max310x_port(port);
-
-	regmap_noinc_read(one->regmap, MAX310X_RHR_REG, rxbuf, len);
+	const u8 header = port->iobase * 0x20 + MAX310X_RHR_REG;
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = &header,
+			.len = 1,
+		},
+		{
+			.rx_buf = rxbuf,
+			.len = len,
+		},
+	};
+	spi_sync_transfer(to_spi_device(port->dev), xfer, ARRAY_SIZE(xfer));
 }
 
 static void max310x_handle_rx(struct uart_port *port, unsigned int rxlen)
-- 
2.42.0


