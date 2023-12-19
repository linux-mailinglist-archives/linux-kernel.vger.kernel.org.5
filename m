Return-Path: <linux-kernel+bounces-5667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4DA818DDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEFF1C213E4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CE731A77;
	Tue, 19 Dec 2023 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="ANj4Jjg4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150FB37142;
	Tue, 19 Dec 2023 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=rcIhJ0kSFRXFUqlpgMlBLBoMnyaUvKyVyUcSYmShbS8=; b=ANj4Jjg44+HlSkwnUCOx+b+JKG
	F8EE2tsJBGCsaIQTuYxz54VRJD7ZRrf+RyiXgaA0pPhuZBBXMbPXmpg7EjvwrhQ6A/A3Mj9l78gVz
	P6Os8z9R8BmkvQ9zH3AoZgXb2sO9Jcc6KHF2kNGVQlMa8YX050iB9355q6dFMGsm6cVY=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkK-0007Ao-Bn; Tue, 19 Dec 2023 12:19:08 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	jringle@gridpoint.com,
	kubakici@wp.pl,
	phil@raspberrypi.org,
	bo.svangard@embeddedart.se
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Date: Tue, 19 Dec 2023 12:18:46 -0500
Message-Id: <20231219171903.3530985-3-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219171903.3530985-1-hugo@hugovil.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Level: 
X-Spam-Report: 
	* -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
	* -0.0 T_SCC_BODY_TEXT_LINE No description available.
Subject: [PATCH 02/18] serial: sc16is7xx: fix invalid sc16is7xx_lines bitfield in case of probe error
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

If an error occurs during probing, the sc16is7xx_lines bitfield may be left
in a state that doesn't represent the correct state of lines allocation.

For example, in a system with two SC16 devices, if an error occurs only
during probing of channel (port) B of the second device, sc16is7xx_lines
final state will be 00001011b instead of the expected 00000011b.

This is caused in part because of the "i--" in the for/loop located in
the out_ports: error path.

Fix this by checking the return value of uart_add_one_port() and set line
allocation bit only if this was successful. This allows the refactor of
the obfuscated for(i--...) loop in the error path, and properly call
uart_remove_one_port() only when needed, and properly unset line allocation
bits.

Also use same mechanism in remove() when calling uart_remove_one_port().

Fixes: c64349722d14 ("sc16is7xx: support multiple devices")
Cc: stable@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
There is already a patch by Yury Norov <yury.norov@gmail.com> to simplify
sc16is7xx_alloc_line():
https://lore.kernel.org/all/20231212022749.625238-30-yury.norov@gmail.com/

Since my patch gets rid of sc16is7xx_alloc_line() entirely, it would make
Yury's patch unnecessary.
---
 drivers/tty/serial/sc16is7xx.c | 44 ++++++++++++++--------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index b585663c1e6e..b92fd01cfeec 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -407,19 +407,6 @@ static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
 	regmap_update_bits(one->regmap, reg, mask, val);
 }
 
-static int sc16is7xx_alloc_line(void)
-{
-	int i;
-
-	BUILD_BUG_ON(SC16IS7XX_MAX_DEVS > BITS_PER_LONG);
-
-	for (i = 0; i < SC16IS7XX_MAX_DEVS; i++)
-		if (!test_and_set_bit(i, &sc16is7xx_lines))
-			break;
-
-	return i;
-}
-
 static void sc16is7xx_power(struct uart_port *port, int on)
 {
 	sc16is7xx_port_update(port, SC16IS7XX_IER_REG,
@@ -1550,6 +1537,13 @@ static int sc16is7xx_probe(struct device *dev,
 		     SC16IS7XX_IOCONTROL_SRESET_BIT);
 
 	for (i = 0; i < devtype->nr_uart; ++i) {
+		s->p[i].port.line = find_first_zero_bit(&sc16is7xx_lines,
+							SC16IS7XX_MAX_DEVS);
+		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
+			ret = -ERANGE;
+			goto out_ports;
+		}
+
 		/* Initialize port data */
 		s->p[i].port.dev	= dev;
 		s->p[i].port.irq	= irq;
@@ -1569,14 +1563,8 @@ static int sc16is7xx_probe(struct device *dev,
 		s->p[i].port.rs485_supported = sc16is7xx_rs485_supported;
 		s->p[i].port.ops	= &sc16is7xx_ops;
 		s->p[i].old_mctrl	= 0;
-		s->p[i].port.line	= sc16is7xx_alloc_line();
 		s->p[i].regmap		= regmaps[i];
 
-		if (s->p[i].port.line >= SC16IS7XX_MAX_DEVS) {
-			ret = -ENOMEM;
-			goto out_ports;
-		}
-
 		mutex_init(&s->p[i].efr_lock);
 
 		ret = uart_get_rs485_mode(&s->p[i].port);
@@ -1594,8 +1582,13 @@ static int sc16is7xx_probe(struct device *dev,
 		kthread_init_work(&s->p[i].tx_work, sc16is7xx_tx_proc);
 		kthread_init_work(&s->p[i].reg_work, sc16is7xx_reg_proc);
 		kthread_init_delayed_work(&s->p[i].ms_work, sc16is7xx_ms_proc);
+
 		/* Register port */
-		uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
+		ret = uart_add_one_port(&sc16is7xx_uart, &s->p[i].port);
+		if (ret)
+			goto out_ports;
+
+		set_bit(s->p[i].port.line, &sc16is7xx_lines);
 
 		/* Enable EFR */
 		sc16is7xx_port_write(&s->p[i].port, SC16IS7XX_LCR_REG,
@@ -1653,10 +1646,9 @@ static int sc16is7xx_probe(struct device *dev,
 #endif
 
 out_ports:
-	for (i--; i >= 0; i--) {
-		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
-	}
+	for (i = 0; i < devtype->nr_uart; i++)
+		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 
 	kthread_stop(s->kworker_task);
 
@@ -1683,8 +1675,8 @@ static void sc16is7xx_remove(struct device *dev)
 
 	for (i = 0; i < s->devtype->nr_uart; i++) {
 		kthread_cancel_delayed_work_sync(&s->p[i].ms_work);
-		uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
-		clear_bit(s->p[i].port.line, &sc16is7xx_lines);
+		if (test_and_clear_bit(s->p[i].port.line, &sc16is7xx_lines))
+			uart_remove_one_port(&sc16is7xx_uart, &s->p[i].port);
 		sc16is7xx_power(&s->p[i].port, 0);
 	}
 
-- 
2.39.2


