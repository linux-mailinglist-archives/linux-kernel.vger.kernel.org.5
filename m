Return-Path: <linux-kernel+bounces-5676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81CE818DEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 064961C24E74
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB2A37175;
	Tue, 19 Dec 2023 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="m1RSSwty"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE98374C8;
	Tue, 19 Dec 2023 17:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=nLa/JOHCB+NVf/gTGPWED+N7sittkLrVaca+Po1a3K0=; b=m1RSSwtyeAOGky3TxFfrc8rLA+
	K5+uM+NJIpBbnGXzBzZj4mCBq399To/bKfEmq+fsRq9TlOOUlfs55JhZp3OBkCiAFyrWEYw5/ex7O
	Stubz5czDs9H+wtPhaMONys+sZtN1LhhEo+kUNg6okf8enQiLuznpul5GFgEDkWFX0W4=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkZ-0007Ao-8V; Tue, 19 Dec 2023 12:19:23 -0500
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
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Tue, 19 Dec 2023 12:19:00 -0500
Message-Id: <20231219171903.3530985-17-hugo@hugovil.com>
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
Subject: [PATCH 16/18] serial: sc16is7xx: reorder code to remove prototype declarations
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move/reorder some functions to remove sc16is7xx_ier_set() and
sc16is7xx_stop_tx() prototypes declarations.

No functional change.

sc16is7xx_ier_set() was introduced in
commit cc4c1d05eb10 ("sc16is7xx: Properly resume TX after stop")

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 75 ++++++++++++++++------------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 3322507ab18e..9154fd75134a 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -358,9 +358,6 @@ static struct uart_driver sc16is7xx_uart = {
 	.nr		= SC16IS7XX_MAX_DEVS,
 };
 
-static void sc16is7xx_ier_set(struct uart_port *port, u8 bit);
-static void sc16is7xx_stop_tx(struct uart_port *port);
-
 #define to_sc16is7xx_one(p,e)	((container_of((p), struct sc16is7xx_one, e)))
 
 static u8 sc16is7xx_port_read(struct uart_port *port, u8 reg)
@@ -416,6 +413,42 @@ static void sc16is7xx_power(struct uart_port *port, int on)
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


