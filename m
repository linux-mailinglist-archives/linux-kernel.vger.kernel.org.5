Return-Path: <linux-kernel+bounces-5679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17750818DF1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EEBB1C21A1A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C238FAF;
	Tue, 19 Dec 2023 17:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hugovil.com header.i=@hugovil.com header.b="e0LaW7Jh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490883174A;
	Tue, 19 Dec 2023 17:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hugovil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hugovil.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
	; s=x; h=Subject:Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To
	:From:subject:date:message-id:reply-to;
	bh=LAV8Eb91u5nlbXGPc815zHrr0Ju+hS+JN2T1893nUM8=; b=e0LaW7JhHDksgVwwyJ4Yd66n+l
	mqFLQiKhpfZkxoPR0QOtmN+s5ErFGa+Eny4aoJAatOrHmUCTr9BtldN2hl6mmTjFPLRc4qZ1P9DpM
	wRgYikjhiS6iyRbucVmmDpXiHFyoDq+tyo7d49czu0KzPeiwIvT29bZDp/RS/4pl3EoQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:40128 helo=pettiford.lan)
	by mail.hugovil.com with esmtpa (Exim 4.92)
	(envelope-from <hugo@hugovil.com>)
	id 1rFdka-0007Ao-Ic; Tue, 19 Dec 2023 12:19:25 -0500
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
Date: Tue, 19 Dec 2023 12:19:01 -0500
Message-Id: <20231219171903.3530985-18-hugo@hugovil.com>
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
Subject: [PATCH 17/18] serial: sc16is7xx: refactor EFR lock
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Move common code for EFR lock/unlock of mutex into functions for code reuse
and clarity.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
---
 drivers/tty/serial/sc16is7xx.c | 104 ++++++++++++++++++---------------
 1 file changed, 56 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 9154fd75134a..ab68ee346ec6 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -333,6 +333,7 @@ struct sc16is7xx_one {
 	struct sc16is7xx_one_config	config;
 	bool				irda_mode;
 	unsigned int			old_mctrl;
+	u8				old_lcr; /* Value before EFR access. */
 };
 
 struct sc16is7xx_port {
@@ -413,6 +414,49 @@ static void sc16is7xx_power(struct uart_port *port, int on)
 			      on ? 0 : SC16IS7XX_IER_SLEEP_BIT);
 }
 
+/* In an amazing feat of design, the Enhanced Features Register (EFR)
+ * shares the address of the Interrupt Identification Register (IIR).
+ * Access to EFR is switched on by writing a magic value (0xbf) to the
+ * Line Control Register (LCR). Any interrupt firing during this time will
+ * see the EFR where it expects the IIR to be, leading to
+ * "Unexpected interrupt" messages.
+ *
+ * Prevent this possibility by claiming a mutex while accessing the EFR,
+ * and claiming the same mutex from within the interrupt handler. This is
+ * similar to disabling the interrupt, but that doesn't work because the
+ * bulk of the interrupt processing is run as a workqueue job in thread
+ * context.
+ */
+static void sc16is7xx_efr_lock(struct uart_port *port)
+{
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	mutex_lock(&one->efr_lock);
+
+	/* Backup content of LCR. */
+	one->old_lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
+
+	/* Enable access to Enhanced register set */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
+			     SC16IS7XX_LCR_CONF_MODE_B);
+
+	/* Disable cache updates when writing to EFR registers */
+	regcache_cache_bypass(one->regmap, true);
+}
+
+static void sc16is7xx_efr_unlock(struct uart_port *port)
+{
+	struct sc16is7xx_one *one = to_sc16is7xx_one(port, port);
+
+	/* Re-enable cache updates when writing to normal registers */
+	regcache_cache_bypass(one->regmap, false);
+
+	/* Restore original content of LCR */
+	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, one->old_lcr);
+
+	mutex_unlock(&one->efr_lock);
+}
+
 static void sc16is7xx_ier_clear(struct uart_port *port, u8 bit)
 {
 	struct sc16is7xx_port *s = dev_get_drvdata(port->dev);
@@ -523,45 +567,19 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 		div /= 4;
 	}
 
-	/* In an amazing feat of design, the Enhanced Features Register shares
-	 * the address of the Interrupt Identification Register, and is
-	 * switched in by writing a magic value (0xbf) to the Line Control
-	 * Register. Any interrupt firing during this time will see the EFR
-	 * where it expects the IIR to be, leading to "Unexpected interrupt"
-	 * messages.
-	 *
-	 * Prevent this possibility by claiming a mutex while accessing the
-	 * EFR, and claiming the same mutex from within the interrupt handler.
-	 * This is similar to disabling the interrupt, but that doesn't work
-	 * because the bulk of the interrupt processing is run as a workqueue
-	 * job in thread context.
-	 */
-	mutex_lock(&one->efr_lock);
-
-	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
-
-	/* Open the LCR divisors for configuration */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
 	/* Enable enhanced features */
-	regcache_cache_bypass(one->regmap, true);
+	sc16is7xx_efr_lock(port);
 	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
 			      SC16IS7XX_EFR_ENABLE_BIT,
 			      SC16IS7XX_EFR_ENABLE_BIT);
-
-	regcache_cache_bypass(one->regmap, false);
-
-	/* Put LCR back to the normal mode */
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
-
-	mutex_unlock(&one->efr_lock);
+	sc16is7xx_efr_unlock(port);
 
 	sc16is7xx_port_update(port, SC16IS7XX_MCR_REG,
 			      SC16IS7XX_MCR_CLKSEL_BIT,
 			      prescaler);
 
-	/* Open the LCR divisors for configuration */
+	/* Backup LCR and access special register set (DLL/DLH) */
+	lcr = sc16is7xx_port_read(port, SC16IS7XX_LCR_REG);
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
 			     SC16IS7XX_LCR_CONF_MODE_A);
 
@@ -571,7 +589,7 @@ static int sc16is7xx_set_baud(struct uart_port *port, int baud)
 	sc16is7xx_port_write(port, SC16IS7XX_DLL_REG, div % 256);
 	regcache_cache_bypass(one->regmap, false);
 
-	/* Put LCR back to the normal mode */
+	/* Restore LCR and access to general register set */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
 	return DIV_ROUND_CLOSEST(clk / 16, div);
@@ -1049,17 +1067,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (!(termios->c_cflag & CREAD))
 		port->ignore_status_mask |= SC16IS7XX_LSR_BRK_ERROR_MASK;
 
-	/* As above, claim the mutex while accessing the EFR. */
-	mutex_lock(&one->efr_lock);
-
-	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG,
-			     SC16IS7XX_LCR_CONF_MODE_B);
-
 	/* Configure flow control */
-	regcache_cache_bypass(one->regmap, true);
-	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
-	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
-
 	port->status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
 	if (termios->c_cflag & CRTSCTS) {
 		flow |= SC16IS7XX_EFR_AUTOCTS_BIT |
@@ -1071,16 +1079,16 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (termios->c_iflag & IXOFF)
 		flow |= SC16IS7XX_EFR_SWFLOW1_BIT;
 
-	sc16is7xx_port_update(port,
-			      SC16IS7XX_EFR_REG,
-			      SC16IS7XX_EFR_FLOWCTRL_BITS,
-			      flow);
-	regcache_cache_bypass(one->regmap, false);
-
 	/* Update LCR register */
 	sc16is7xx_port_write(port, SC16IS7XX_LCR_REG, lcr);
 
-	mutex_unlock(&one->efr_lock);
+	/* Update EFR registers */
+	sc16is7xx_efr_lock(port);
+	sc16is7xx_port_write(port, SC16IS7XX_XON1_REG, termios->c_cc[VSTART]);
+	sc16is7xx_port_write(port, SC16IS7XX_XOFF1_REG, termios->c_cc[VSTOP]);
+	sc16is7xx_port_update(port, SC16IS7XX_EFR_REG,
+			      SC16IS7XX_EFR_FLOWCTRL_BITS, flow);
+	sc16is7xx_efr_unlock(port);
 
 	/* Get baud rate generator configuration */
 	baud = uart_get_baud_rate(port, termios, old,
-- 
2.39.2


