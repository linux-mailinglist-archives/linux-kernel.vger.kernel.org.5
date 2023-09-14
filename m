Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE3B7A0D2D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbjINSlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241928AbjINSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7E26AA;
        Thu, 14 Sep 2023 11:38:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V78gGTZqe9KNWC/CUJ6BLfJKVWn9CLRyUjSZ92RtJpw=;
        b=fGBpIGbVvU41G3c3jH4uC9Kf+WPal9GfMOGSjtwHx8pj9VJkIf2jyS2qhjqyY2kvBIBH2a
        fJFBS4YRD4Lec7LT3jdT4I6kAJ/XD/tDkVF28js99byvGT2pRvWDPsdFkwjQ1mAJ2VAZA+
        EzO3qZ4gXT0E0izX1mgdRcP2ygi4Xc2SPKFkge93tAEbuM8rZsCdpNah8q+pEn4Q6kcHPh
        u4IQU7Eg50kEm8HBo9jV2p/b+Rp8BwRYxPR4be+6knxEFs4pn+cA9RtkuCQWx1/ECriMmr
        NutZwKIvWabi11rCBM14Bx0/uufKRaHTI1dw6s5xeYXKn8cYJiB5ib7oNx8Zdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V78gGTZqe9KNWC/CUJ6BLfJKVWn9CLRyUjSZ92RtJpw=;
        b=UIKwNx3A/uOpnCQiUHjam24Sbl8xyJL+e1/nJr3ID5X44/dR8Oj36CbNDo2MMHYK8AZ/oJ
        Ahe3LqbJSguKWJBA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yuan Can <yuancan@huawei.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH tty v1 46/74] serial: pic32: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:03 +0206
Message-Id: <20230914183831.587273-47-john.ogness@linutronix.de>
In-Reply-To: <20230914183831.587273-1-john.ogness@linutronix.de>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When a serial port is used for kernel console output, then all
modifications to the UART registers which are done from other contexts,
e.g. getty, termios, are interference points for the kernel console.

So far this has been ignored and the printk output is based on the
principle of hope. The rework of the console infrastructure which aims to
support threaded and atomic consoles, requires to mark sections which
modify the UART registers as unsafe. This allows the atomic write function
to make informed decisions and eventually to restore operational state. It
also allows to prevent the regular UART code from modifying UART registers
while printk output is in progress.

All modifications of UART registers are guarded by the UART port lock,
which provides an obvious synchronization point with the console
infrastructure.

To avoid adding this functionality to all UART drivers, wrap the
spin_[un]lock*() invocations for uart_port::lock into helper functions
which just contain the spin_[un]lock*() invocations for now. In a
subsequent step these helpers will gain the console synchronization
mechanisms.

Converted with coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/tty/serial/pic32_uart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
index e308d5022b3f..3a95bf5d55d3 100644
--- a/drivers/tty/serial/pic32_uart.c
+++ b/drivers/tty/serial/pic32_uart.c
@@ -243,7 +243,7 @@ static void pic32_uart_break_ctl(struct uart_port *port, int ctl)
 	struct pic32_sport *sport = to_pic32_sport(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (ctl)
 		pic32_uart_writel(sport, PIC32_SET(PIC32_UART_STA),
@@ -252,7 +252,7 @@ static void pic32_uart_break_ctl(struct uart_port *port, int ctl)
 		pic32_uart_writel(sport, PIC32_CLR(PIC32_UART_STA),
 					PIC32_UART_STA_UTXBRK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* get port type in string format */
@@ -274,7 +274,7 @@ static void pic32_uart_do_rx(struct uart_port *port)
 	 */
 	max_count = PIC32_UART_RX_FIFO_DEPTH;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	tty = &port->state->port;
 
@@ -331,7 +331,7 @@ static void pic32_uart_do_rx(struct uart_port *port)
 
 	} while (--max_count);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	tty_flip_buffer_push(tty);
 }
@@ -410,9 +410,9 @@ static irqreturn_t pic32_uart_tx_interrupt(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	pic32_uart_do_tx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -580,9 +580,9 @@ static void pic32_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 
 	/* disable uart */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	pic32_uart_dsbl_and_mask(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	clk_disable_unprepare(sport->clk);
 
 	/* free all 3 interrupts for this UART */
@@ -604,7 +604,7 @@ static void pic32_uart_set_termios(struct uart_port *port,
 	unsigned int quot;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* disable uart and mask all interrupts while changing speed */
 	pic32_uart_dsbl_and_mask(port);
@@ -672,7 +672,7 @@ static void pic32_uart_set_termios(struct uart_port *port,
 	/* enable uart */
 	pic32_uart_en_and_unmask(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* serial core request to claim uart iomem */
-- 
2.39.2

