Return-Path: <linux-kernel+bounces-5673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2336818DE6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:20:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED151C20F83
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C7374D7;
	Tue, 19 Dec 2023 17:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="EYi+AuJ7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DD237173;
	Tue, 19 Dec 2023 17:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=cw/24HY4C5acblk8eliNCiZBV+lvTJ+0DUIF2TU1lJQ=; b=EYi+AuJ7sy0TuMj/AGsWiYqOKy
	pJeatye9iSP5hmCO7cWlO0Zi+0JIxROIkdm6Y1tfrfjLeQH8p2NXvLet1bJ1/3Bub478g9JLiBMe+
	6R24eaeBzY5FQh/rnhm5RYvTFWLMtHgirIuvpSPBt3v+OnPgWlPJReQeExq34jL2bAeo=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdkY-0007Ao-56; Tue, 19 Dec 2023 12:19:22 -0500
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
	stable@vger.kernel.org
Date: Tue, 19 Dec 2023 12:18:59 -0500
Message-Id: <20231219171903.3530985-16-hugo@hugovil.com>
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
Subject: [PATCH 15/18] serial: sc16is7xx: pass R/W buffer in FIFO functions
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

To simplify function by avoiding cast.

This is similar to what is done in max310x driver.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
If deemed appropriate for stable kernel backporting:
Fixes: dec273ecc116 ("sc16is7xx: fix FIFO address of secondary UART")
Cc: stable@vger.kernel.org
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index a9e44e5ef713..3322507ab18e 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -380,17 +380,15 @@ static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
 	regmap_write(one->regmap, reg, val);
 }
 
-static void sc16is7xx_fifo_read(struct uart_port *port, unsigned int rxlen)
+static void sc16is7xx_fifo_read(struct uart_port *port, u8 *rxbuf, unsigned int rxlen)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
-	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, s->buf, rxlen);
+	regmap_noinc_read(one->regmap, SC16IS7XX_RHR_REG, rxbuf, rxlen);
 }
 
-static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
+static void sc16is7xx_fifo_write(struct uart_port *port, u8 *txbuf, u8 to_send)
 {
-	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	/*
@@ -400,7 +398,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
+	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, txbuf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -576,7 +574,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 			s->buf[0] = sc16is7xx_port_read(port, SC16IS7XX_RHR_REG);
 			bytes_read = 1;
 		} else {
-			sc16is7xx_fifo_read(port, rxlen);
+			sc16is7xx_fifo_read(port, s->buf, rxlen);
 			bytes_read = rxlen;
 		}
 
@@ -665,7 +663,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 			uart_xmit_advance(port, 1);
 		}
 
-		sc16is7xx_fifo_write(port, to_send);
+		sc16is7xx_fifo_write(port, s->buf, to_send);
 	}
 
 	uart_port_lock_irqsave(port, &flags);
-- 
2.39.2


