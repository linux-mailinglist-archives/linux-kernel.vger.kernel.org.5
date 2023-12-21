Return-Path: <linux-kernel+bounces-9167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A12281C1CC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC69F1F22696
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D396F7BF01;
	Thu, 21 Dec 2023 23:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="V5h8PKkc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1E7948F;
	Thu, 21 Dec 2023 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=NqyaA+da2u2LMAkVhsOx0NUe18UOdygrK1MLZ2OBgRY=; b=V5h8PKkc85RTZfJ5IhPCC9oz6j
	YBWoG+wqv9zw+zlALSXf4wx1n/P0k+dwMLwRMZYUWyR575Oazb9RUQ7dYu8y6iBXrzAOAalY04KL5
	xB6waXC1vIc/aLu0IylvmtfpnBehkxPJuUOEbKNTn86MNCZDfPGptD9GvFpEfFoovvto=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:52484 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rGSJI-00025W-WC; Thu, 21 Dec 2023 18:18:37 -0500
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
	stable@vger.kernel.org,
	Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 21 Dec 2023 18:18:11 -0500
Message-Id: <20231221231823.2327894-5-hugo@hugovil.com>
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
Subject: [PATCH v2 04/16] serial: sc16is7xx: remove obsolete loop in sc16is7xx_port_irq()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Commit 834449872105 ("sc16is7xx: Fix for multi-channel stall") changed
sc16is7xx_port_irq() from looping multiple times when there was still
interrupts to serve. It simply changed the do {} while(1) loop to a
do {} while(0) loop, which makes the loop itself now obsolete.

Clean the code by removing this obsolete do {} while(0) loop.

Fixes: 834449872105 ("sc16is7xx: Fix for multi-channel stall")
Cc: stable@vger.kernel.org
Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 81 ++++++++++++++++------------------
 1 file changed, 39 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index ced2446909a2..44a11c89c949 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -725,58 +725,55 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 {
 	bool rc = true;
+	unsigned int iir, rxlen;
 	struct uart_port *port = &s->p[portno].port;
 	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
 
 	mutex_lock(&one->efr_lock);
 
-	do {
-		unsigned int iir, rxlen;
+	iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
+	if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
+		rc = false;
+		goto out_port_irq;
+	}
 
-		iir = sc16is7xx_port_read(port, SC16IS7XX_IIR_REG);
-		if (iir & SC16IS7XX_IIR_NO_INT_BIT) {
-			rc = false;
-			goto out_port_irq;
-		}
+	iir &= SC16IS7XX_IIR_ID_MASK;
 
-		iir &= SC16IS7XX_IIR_ID_MASK;
+	switch (iir) {
+	case SC16IS7XX_IIR_RDI_SRC:
+	case SC16IS7XX_IIR_RLSE_SRC:
+	case SC16IS7XX_IIR_RTOI_SRC:
+	case SC16IS7XX_IIR_XOFFI_SRC:
+		rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
 
-		switch (iir) {
-		case SC16IS7XX_IIR_RDI_SRC:
-		case SC16IS7XX_IIR_RLSE_SRC:
-		case SC16IS7XX_IIR_RTOI_SRC:
-		case SC16IS7XX_IIR_XOFFI_SRC:
-			rxlen = sc16is7xx_port_read(port, SC16IS7XX_RXLVL_REG);
+		/*
+		 * There is a silicon bug that makes the chip report a
+		 * time-out interrupt but no data in the FIFO. This is
+		 * described in errata section 18.1.4.
+		 *
+		 * When this happens, read one byte from the FIFO to
+		 * clear the interrupt.
+		 */
+		if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
+			rxlen = 1;
 
-			/*
-			 * There is a silicon bug that makes the chip report a
-			 * time-out interrupt but no data in the FIFO. This is
-			 * described in errata section 18.1.4.
-			 *
-			 * When this happens, read one byte from the FIFO to
-			 * clear the interrupt.
-			 */
-			if (iir == SC16IS7XX_IIR_RTOI_SRC && !rxlen)
-				rxlen = 1;
-
-			if (rxlen)
-				sc16is7xx_handle_rx(port, rxlen, iir);
-			break;
+		if (rxlen)
+			sc16is7xx_handle_rx(port, rxlen, iir);
+		break;
 		/* CTSRTS interrupt comes only when CTS goes inactive */
-		case SC16IS7XX_IIR_CTSRTS_SRC:
-		case SC16IS7XX_IIR_MSI_SRC:
-			sc16is7xx_update_mlines(one);
-			break;
-		case SC16IS7XX_IIR_THRI_SRC:
-			sc16is7xx_handle_tx(port);
-			break;
-		default:
-			dev_err_ratelimited(port->dev,
-					    "ttySC%i: Unexpected interrupt: %x",
-					    port->line, iir);
-			break;
-		}
-	} while (0);
+	case SC16IS7XX_IIR_CTSRTS_SRC:
+	case SC16IS7XX_IIR_MSI_SRC:
+		sc16is7xx_update_mlines(one);
+		break;
+	case SC16IS7XX_IIR_THRI_SRC:
+		sc16is7xx_handle_tx(port);
+		break;
+	default:
+		dev_err_ratelimited(port->dev,
+				    "ttySC%i: Unexpected interrupt: %x",
+				    port->line, iir);
+		break;
+	}
 
 out_port_irq:
 	mutex_unlock(&one->efr_lock);
-- 
2.39.2


