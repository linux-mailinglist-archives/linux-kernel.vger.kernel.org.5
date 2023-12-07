Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E114808F4A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 19:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443628AbjLGR4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 12:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbjLGR4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 12:56:24 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5C31709;
        Thu,  7 Dec 2023 09:56:29 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA79DE0006;
        Thu,  7 Dec 2023 17:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701971788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q7vbdl0phWxmXqUNa5odOWDQ5PiPNBLg4EXYyhdyx1Q=;
        b=TZKz1GzNave4arE2A83b+flRAQGJctomR1AxxeoyNYax7BbNEY6xXNpxn7pXJs6+IxhBcp
        Ywiwpc7nru7OhQh+39qHnKgx3G/3mg6dyGTvqctOBMwEtG3gJHgatbo7+VR4dnIZ2fBD7n
        u/0IhmLCghfULyTw5SxlpBlA7MjpRtdQVroP+2lbpBmp8qgSFKhzUpc8cySX0v9y8WK6SL
        K9Mj3rHCAfkc0rgKBHXbERRJdYhs1tjnCxy9Q+qTZr5g2/UBQ16wa0UbforWl4XkA3wSA3
        DKiSyP4oP4De2Mvuukwyi2ZhXRnn3eIxQ/x7WKAx9G9wL2uIGi0pXdRtPKrhVw==
From:   =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Date:   Thu, 07 Dec 2023 18:56:08 +0100
Subject: [PATCH v6 3/8] tty: serial: amba-pl011: replace TIOCMBIT macros by
 static functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231207-mbly-uart-v6-3-e384afa5e78c@bootlin.com>
References: <20231207-mbly-uart-v6-0-e384afa5e78c@bootlin.com>
In-Reply-To: <20231207-mbly-uart-v6-0-e384afa5e78c@bootlin.com>
To:     Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?utf-8?q?Gr=C3=A9gory_Clement?= <gregory.clement@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: b4 0.12.4
X-GND-Sasl: theo.lebrun@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

This addresses the following checkpatch warnings:

    $ ./scripts/checkpatch.pl --strict --file \
        drivers/tty/serial/amba-pl011.c

    ERROR: Macros starting with if should be enclosed by a do -
           while loop to avoid possible if/else logic defects

    CHECK: Macro argument 'uartbit' may be better as '(uartbit)' to
           avoid precedence issues

    ERROR: Macros starting with if should be enclosed by a do - while
           loop to avoid possible if/else logic defects

    CHECK: Macro argument 'tiocmbit' may be better as '(tiocmbit)' to
           avoid precedence issues

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
---
 drivers/tty/serial/amba-pl011.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 7bd0b68ef92f..743dee75c68b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1589,6 +1589,12 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
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
@@ -1596,18 +1602,22 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
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
@@ -1616,23 +1626,16 @@ static void pl011_set_mctrl(struct uart_port *port, unsigned int mctrl)
 
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
2.43.0

