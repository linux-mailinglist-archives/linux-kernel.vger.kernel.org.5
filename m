Return-Path: <linux-kernel+bounces-9172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5AE81C1D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 976E91F21CAA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F2487D89E;
	Thu, 21 Dec 2023 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="xv+4JDp8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0ED97BEF3;
	Thu, 21 Dec 2023 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=AO8Y/K+LTRewIk9jrkA5Toqk8u/5mxe04ppS5FmxaBY=; b=xv+4JDp8bpQ8M3Rmc9bF0Zp+0k
	y564OEcE2hCkBgOzxTJ1wAwmDaAntzkRSZptvC4NbSfDHFU60oAD28IBvYYhO3ZZK/5Qe6DmrEbM6
	MDunfjrQey1UbWLwWSHWLKo+gULKqRcg3JZwfnlk9GK1UHKQxpQprGGQ4GvM0kK2YvX4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJW-00025W-1m; Thu, 21 Dec 2023 18:18:50 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 21 Dec 2023 18:18:22 -0500
Message-Id: <20231221231823.2327894-16-hugo@hugovil.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221231823.2327894-1-hugo@hugovil.com>
References: <20231221231823.2327894-1-hugo@hugovil.com>
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
Subject: [PATCH v2 15/16] serial: sc16is7xx: reorder code to remove prototype declarations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move/reorder some functions to remove sc16is7xx_ier_set() and
sc16is7xx_stop_tx() prototypes declarations.

No functional change.

sc16is7xx_ier_set() was introduced in
commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop").

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 75 ++++++++++++++++------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 26bc595a6ca7..15a46c164821 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -357,9 +357,6 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
-static void sc16is7xx_stop_tx(struct uart_port *port);
-
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
@@ -415,6 +412,42 @@ static void sc16is7xx_power(struct uart_port *port, int on)
 			      on ? 0 : SC16IS7XX_IER_SLEEP_BIT);
 }
 
+static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val &= ~bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
+{
+	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	lockdep_assert_held_once(&port->lock);
+
+	one->config.flags |= SC16IS7XX_RECONF_IER;
+	one->config.ier_mask |= bit;
+	one->config.ier_val |= bit;
+	kthread_queue_work(&s->kworker, &one->reg_work);
+}
+
+static void sc16is7xx_stop_tx(struct uart_port *port)
+{
+	sc16is7xx_ier_clear(port, SC16IS7XX_IER_THRI_BIT);
+}
+
+static void sc16is7xx_stop_rx(struct uart_port *port)
+{
+	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
+}
+
 static const struct sc16is7xx_devtype sc16is74x_devtype = {
 	.name		= "SC16IS74X",
 	.nr_gpio	= 0,
@@ -867,42 +900,6 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 		sc16is7xx_reconf_rs485(&one->port);
 }
 
-static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
-{
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-
-	lockdep_assert_held_once(&port->lock);
-
-	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_mask |= bit;
-	one->config.ier_val &= ~bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
-}
-
-static void sc16is7xx_ier_set(struct uart_port *port, u8 bit)
-{
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
-	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
-
-	lockdep_assert_held_once(&port->lock);
-
-	one->config.flags |= SC16IS7XX_RECONF_IER;
-	one->config.ier_mask |= bit;
-	one->config.ier_val |= bit;
-	kthread_queue_work(&s->kworker, &one->reg_work);
-}
-
-static void sc16is7xx_stop_tx(struct uart_port *port)
-{
-	sc16is7xx_ier_clear(port, SC16IS7XX_IER_THRI_BIT);
-}
-
-static void sc16is7xx_stop_rx(struct uart_port *port)
-{
-	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
-}
-
 static void sc16is7xx_ms_proc(struct kthread_work *ws)
 {
 	struct sc16is7xx_one *one = to_sc16is7xx_one(ws, ms_work.work);
-- 
2.39.2


