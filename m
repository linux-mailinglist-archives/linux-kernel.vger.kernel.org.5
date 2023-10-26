Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176E47D80FF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 12:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344724AbjJZKmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 06:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjJZKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 06:41:56 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 759E31BD;
        Thu, 26 Oct 2023 03:41:52 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 855CA24000D;
        Thu, 26 Oct 2023 10:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698316911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hVod6oNiG11GXpztqB+xvcbr1ITB2qvCBfLGkbgxP1s=;
        b=FHVBnzHBl6cS3sHlfkO6uP8WUr0CoL0aVeX17e4kt0qowHlTNtS7jNa3O/aFtuwyOq2S9c
        /BrV7GNVIOn5QmPjoM7NdQdKddcTlQR7owhr7ulzyEON/lwGnL65CbSdmC4hTBX8q+NmkX
        xBu8i59WDW4DCAlzJ6p+PB6RgJuEXCFALqeY6lEV+bqbW43KVuRVkBO2dRZS8/J8MI20Ok
        UbTSA+r3TnNKAhiKveqUqGigOcjzAA8xZ8vAc9vh9klSpMNQoHjn0QF0XK+XaQX8QzGpxP
        Px2g7jHy1aZJg7NVa55gi4/GRUqu2myUYs56gZnun9EZ46gLPbnAjb6EV3blEQ==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 26 Oct 2023 12:41:21 +0200
Subject: [PATCH 4/6] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231026-mbly-uart-v1-4-9258eea297d3@bootlin.com>
References: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
In-Reply-To: <20231026-mbly-uart-v1-0-9258eea297d3@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.3
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver uses two TIOCMBIT macros inside pl011_{get,set}_mctrl to
simplify the logic. Those look scary to checkpatch because they contain
ifs without do-while loops.

Avoid the macros by creating small equivalent static functions; that
lets the compiler do its type checking & avoids checkpatch errors.

For the second instance __assign_bit is not usable because it deals with
unsigned long pointers whereas we have an unsigned int in
pl011_set_mctrl.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 46 +++++++++++++++++++++--------------------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 0d53973374de..bb3082c4d35c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1087,7 +1087,6 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	 */
 	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
 			> uap->dmarx.poll_timeout) {
-
 		spin_lock_irqsave(&uap->port.lock, flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
@@ -1595,6 +1594,12 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 							0 : TIOCSER_TEMT;
 }
 
+static void pl011_maybe_set_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+}
+
 static unsigned int pl011_get_mctrl(struct uart_port *port)
 {
 	struct uart_amba_port *uap =
@@ -1602,18 +1607,22 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 	unsigned int result = 0;
 	unsigned int status = pl011_read(uap, REG_FR);
 
-#define TIOCMBIT(uartbit, tiocmbit)	\
-	if (status & uartbit)		\
-		result |= tiocmbit
+	pl011_maybe_set_bit(status & UART01x_FR_DCD, &result, TIOCM_CAR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_dsr, &result, TIOCM_DSR);
+	pl011_maybe_set_bit(status & uap->vendor->fr_cts, &result, TIOCM_CTS);
+	pl011_maybe_set_bit(status & uap->vendor->fr_ri, &result, TIOCM_RNG);
 
-	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
-	TIOCMBIT(uap->vendor->fr_dsr, TIOCM_DSR);
-	TIOCMBIT(uap->vendor->fr_cts, TIOCM_CTS);
-	TIOCMBIT(uap->vendor->fr_ri, TIOCM_RNG);
-#undef TIOCMBIT
 	return result;
 }
 
+static void pl011_assign_bit(bool cond, unsigned int *ptr, unsigned int mask)
+{
+	if (cond)
+		*ptr |= mask;
+	else
+		*ptr &= ~mask;
+}
+
 static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
 	struct uart_amba_port *uap =
@@ -1622,23 +1631,16 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
 	cr = pl011_read(uap, REG_CR);
 
-#define	TIOCMBIT(tiocmbit, uartbit)		\
-	if (mctrl & tiocmbit)		\
-		cr |= uartbit;		\
-	else				\
-		cr &= ~uartbit
-
-	TIOCMBIT(TIOCM_RTS, UART011_CR_RTS);
-	TIOCMBIT(TIOCM_DTR, UART011_CR_DTR);
-	TIOCMBIT(TIOCM_OUT1, UART011_CR_OUT1);
-	TIOCMBIT(TIOCM_OUT2, UART011_CR_OUT2);
-	TIOCMBIT(TIOCM_LOOP, UART011_CR_LBE);
+	pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTS);
+	pl011_assign_bit(mctrl & TIOCM_DTR, &cr, UART011_CR_DTR);
+	pl011_assign_bit(mctrl & TIOCM_OUT1, &cr, UART011_CR_OUT1);
+	pl011_assign_bit(mctrl & TIOCM_OUT2, &cr, UART011_CR_OUT2);
+	pl011_assign_bit(mctrl & TIOCM_LOOP, &cr, UART011_CR_LBE);
 
 	if (port->status & UPSTAT_AUTORTS) {
 		/* We need to disable auto-RTS if we want to turn RTS off */
-		TIOCMBIT(TIOCM_RTS, UART011_CR_RTSEN);
+		pl011_assign_bit(mctrl & TIOCM_RTS, &cr, UART011_CR_RTSEN);
 	}
-#undef TIOCMBIT
 
 	pl011_write(cr, uap, REG_CR);
 }

-- 
2.41.0

