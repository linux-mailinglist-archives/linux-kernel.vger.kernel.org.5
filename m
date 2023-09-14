Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8737A0D16
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241832AbjINSkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241785AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78948213D;
        Thu, 14 Sep 2023 11:38:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sKB+PLTgb55D62jcsgEwGhi+y+KWY1sggt5DCPfvKw=;
        b=CAomZRAW4ioAoHdhdXE1bVpyrGKaTnvn8Cq29md8PRBiDOnSBUbDSiMq137oB3HKlxwNEf
        R8HRvdEP5f14bu6O2Rr5/iz88OJF6VlrhJOlwQLCKLxm86UMAktCYEZ7bMUdHclHpVcZRs
        2Qnrpu4EipFdUOiXbQdiJazGtYSUbNtN5CSQwHRnnFwq+0v1r5Uzl1fkRNB9eQzve1ZQmf
        0tt4KFBW2Cj6a+XeqF+AQvrQWlwjnwqsjvlq4BRWMB//MDfRrDUYKiQlfW9Xb9IFwQkyVb
        qJZaZ3tQBAkXdIf3q2qdS75F933SGK3oPvdZexLcDwbHhA6yE8pDCVXMQAZIkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6sKB+PLTgb55D62jcsgEwGhi+y+KWY1sggt5DCPfvKw=;
        b=omvzL+BfuAFX72SI72UqLTsm+PZORhrEQrnn9HysvZwhKfsA5pjsOE1v/su7/IqFmFA67i
        mfMeFlZPH2SMzoCA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Vladimir Zapolskiy <vz@mleia.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 33/74] serial: lpc32xx_hs: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:50 +0206
Message-Id: <20230914183831.587273-34-john.ogness@linutronix.de>
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
 drivers/tty/serial/lpc32xx_hs.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index b38fe4728c26..5149a947b7fe 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -140,15 +140,15 @@ static void lpc32xx_hsuart_console_write(struct console *co, const char *s,
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+		locked = uart_port_trylock(&up->port);
 	else
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 
 	uart_console_write(&up->port, s, count, lpc32xx_hsuart_console_putchar);
 	wait_for_xmit_empty(&up->port);
 
 	if (locked)
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 	local_irq_restore(flags);
 }
 
@@ -298,7 +298,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 	struct tty_port *tport = &port->state->port;
 	u32 status;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	/* Read UART status and clear latched interrupts */
 	status = readl(LPC32XX_HSUART_IIR(port->membase));
@@ -333,7 +333,7 @@ static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
 		__serial_lpc32xx_tx(port);
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -404,14 +404,14 @@ static void serial_lpc32xx_break_ctl(struct uart_port *port,
 	unsigned long flags;
 	u32 tmp;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	tmp = readl(LPC32XX_HSUART_CTRL(port->membase));
 	if (break_state != 0)
 		tmp |= LPC32XX_HSU_BREAK;
 	else
 		tmp &= ~LPC32XX_HSU_BREAK;
 	writel(tmp, LPC32XX_HSUART_CTRL(port->membase));
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* port->lock is not held.  */
@@ -421,7 +421,7 @@ static int serial_lpc32xx_startup(struct uart_port *port)
 	unsigned long flags;
 	u32 tmp;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	__serial_uart_flush(port);
 
@@ -441,7 +441,7 @@ static int serial_lpc32xx_startup(struct uart_port *port)
 
 	lpc32xx_loopback_set(port->mapbase, 0); /* get out of loopback mode */
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	retval = request_irq(port->irq, serial_lpc32xx_interrupt,
 			     0, MODNAME, port);
@@ -458,7 +458,7 @@ static void serial_lpc32xx_shutdown(struct uart_port *port)
 	u32 tmp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	tmp = LPC32XX_HSU_TX_TL8B | LPC32XX_HSU_RX_TL32B |
 		LPC32XX_HSU_OFFSET(20) | LPC32XX_HSU_TMO_INACT_4B;
@@ -466,7 +466,7 @@ static void serial_lpc32xx_shutdown(struct uart_port *port)
 
 	lpc32xx_loopback_set(port->mapbase, 1); /* go to loopback mode */
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
 }
@@ -491,7 +491,7 @@ static void serial_lpc32xx_set_termios(struct uart_port *port,
 
 	quot = __serial_get_clock_div(port->uartclk, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Ignore characters? */
 	tmp = readl(LPC32XX_HSUART_CTRL(port->membase));
@@ -505,7 +505,7 @@ static void serial_lpc32xx_set_termios(struct uart_port *port,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
-- 
2.39.2

