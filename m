Return-Path: <linux-kernel+bounces-9170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178EB81C1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78E76B25DF4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A8D7C67C;
	Thu, 21 Dec 2023 23:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="GPwbhRva"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D507B3A5;
	Thu, 21 Dec 2023 23:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=O33SuElMyMhi7Xm2MmazMXI7ODmF5cXxahS2czWEZzU=; b=GPwbhRvaUzMuoWnaZkDd7JvGNZ
	29SV8uLnekInKZ3LQvCrFUKzqmiiJyhbUEKWqGvIhs6wxlLHBD4CVfWx4QFckTczqxTTV+NEI6zui
	sJgh2DBE7TBt64hkbIT83h+2VMStSL7sL5adGywKiSCc3MAdKDTJ83bVDc+j8AAjugro=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJU-00025W-Ue; Thu, 21 Dec 2023 18:18:49 -0500
From: Hugo Villeneuve <hugo@hugovil.com>
To: gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	kubakici@wp.pl,
	indrakanti_ram@hotmail.com,
	phil@raspberrypi.org
Cc: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	hugo@hugovil.com,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Date: Thu, 21 Dec 2023 18:18:21 -0500
Message-Id: <20231221231823.2327894-15-hugo@hugovil.com>
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
Subject: [PATCH v2 14/16] serial: sc16is7xx: refactor FIFO access functions to increase commonality
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Simplify FIFO access functions by avoiding to declare
a struct sc16is7xx_port *s variable within each function.

This is mainly done to have more commonality between the max310x and
sc16is7xx drivers.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 1037a2802360..26bc595a6ca7 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -379,17 +379,15 @@ static void sc16is7xx_port_write(struct uart_port *port, u8 reg, u8 val)
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
@@ -399,7 +397,7 @@ static void sc16is7xx_fifo_write(struct uart_port *port, u8 to_send)
 	if (unlikely(!to_send))
 		return;
 
-	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, s->buf, to_send);
+	regmap_noinc_write(one->regmap, SC16IS7XX_THR_REG, txbuf, to_send);
 }
 
 static void sc16is7xx_port_update(struct uart_port *port, u8 reg,
@@ -575,7 +573,7 @@ static void sc16is7xx_handle_rx(struct uart_port *port, unsigned int rxlen,
 			s->buf[0] = sc16is7xx_port_read(port, SC16IS7XX_RHR_REG);
 			bytes_read = 1;
 		} else {
-			sc16is7xx_fifo_read(port, rxlen);
+			sc16is7xx_fifo_read(port, s->buf, rxlen);
 			bytes_read = rxlen;
 		}
 
@@ -664,7 +662,7 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 			uart_xmit_advance(port, 1);
 		}
 
-		sc16is7xx_fifo_write(port, to_send);
+		sc16is7xx_fifo_write(port, s->buf, to_send);
 	}
 
 	uart_port_lock_irqsave(port, &flags);
-- 
2.39.2


