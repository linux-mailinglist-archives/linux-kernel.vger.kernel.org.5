Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73D827A0D42
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242161AbjINSlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241993AbjINSj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03EE2713;
        Thu, 14 Sep 2023 11:39:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy6q0L16Kf/KS6E7GOqWz6KYdIr63xhUHPEN74PlZEE=;
        b=O92aHgkVbGKPJl2oWelrZRGt1hi4ABLEooGQ4nQ9fCBmHNvENAraqDtpqPzxFMlxHv2SYg
        vs16YS6VAZvUSjTum3CqnCHtjaiEHzehqMRfoTA8QZ8++r/yGaNP6Xb4+h+8T9WDfggheH
        10H0J/LPuz9H4l1GiMulPxSc+OfDZycHKF+O10GVr9ypv2MGkwGIMmPn0GdBRRoGNpqDrT
        MVKX86GnRPFOPvsNuCxNN0KyYuuBiy8f/fxQHcRsFMI3GCUp+faWu11v4RJJ8MibW5K9+s
        ypVwnSHBmyq5LmbgpSg/l/Ek0mCkFRnVTV9T3t2z/cB7BbWlvkf8//sARgINeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zy6q0L16Kf/KS6E7GOqWz6KYdIr63xhUHPEN74PlZEE=;
        b=xq0a3lU7Ye8KLD0iDn7GDbg27VseXJ6HbyT3vmZtU5JRykbFWRlis6URvJgMHHS34BCNDL
        YMeQ8ccCDr68/WDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Isaac True <isaac.true@canonical.com>
Subject: [PATCH tty v1 55/74] serial: sc16is7xx: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:12 +0206
Message-Id: <20230914183831.587273-56-john.ogness@linutronix.de>
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
 drivers/tty/serial/sc16is7xx.c | 40 +++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index f61d98e09dc3..9d8307f5fc36 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -667,9 +667,9 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 	}
 
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		sc16is7xx_stop_tx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		return;
 	}
 
@@ -695,13 +695,13 @@ static void sc16is7xx_handle_tx(struct uart_port *port)
 		sc16is7xx_fifo_write(port, to_send);
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(port);
 
 	if (uart_circ_empty(xmit))
 		sc16is7xx_stop_tx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static unsigned int sc16is7xx_get_hwmctrl(struct uart_port *port)
@@ -733,7 +733,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 
 	one->old_mctrl = status;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if ((changed & TIOCM_RNG) && (status & TIOCM_RNG))
 		port->icount.rng++;
 	if (changed & TIOCM_DSR)
@@ -744,7 +744,7 @@ static void sc16is7xx_update_mlines(struct sc16is7xx_one *one)
 		uart_handle_cts_change(port, status & TIOCM_CTS);
 
 	wake_up_interruptible(&port->state->port.delta_msr_wait);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static bool sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
@@ -823,9 +823,9 @@ static void sc16is7xx_tx_proc(struct kthread_work *ws)
 	sc16is7xx_handle_tx(port);
 	mutex_unlock(&s->efr_lock);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_ier_set(port, SC16IS7XX_IER_THRI_BIT);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void sc16is7xx_reconf_rs485(struct uart_port *port)
@@ -836,14 +836,14 @@ static void sc16is7xx_reconf_rs485(struct uart_port *port)
 	struct serial_rs485 *rs485 = &port->rs485;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&port->lock, irqflags);
+	uart_port_lock_irqsave(port, &irqflags);
 	if (rs485->flags & SER_RS485_ENABLED) {
 		efcr |=	SC16IS7XX_EFCR_AUTO_RS485_BIT;
 
 		if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
 			efcr |= SC16IS7XX_EFCR_RTS_INVERT_BIT;
 	}
-	spin_unlock_irqrestore(&port->lock, irqflags);
+	uart_port_unlock_irqrestore(port, irqflags);
 
 	sc16is7xx_port_update(port, SC16IS7XX_EFCR_REG, mask, efcr);
 }
@@ -854,10 +854,10 @@ static void sc16is7xx_reg_proc(struct kthread_work *ws)
 	struct sc16is7xx_one_config config;
 	unsigned long irqflags;
 
-	spin_lock_irqsave(&one->port.lock, irqflags);
+	uart_port_lock_irqsave(&one->port, &irqflags);
 	config = one->config;
 	memset(&one->config, 0, sizeof(one->config));
-	spin_unlock_irqrestore(&one->port.lock, irqflags);
+	uart_port_unlock_irqrestore(&one->port, irqflags);
 
 	if (config.flags & SC16IS7XX_RECONF_MD) {
 		u8 mcr = 0;
@@ -963,18 +963,18 @@ static void sc16is7xx_throttle(struct uart_port *port)
 	 * value set in MCR register. Stop reading data from RX FIFO so the
 	 * AutoRTS feature will de-activate RTS output.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_ier_clear(port, SC16IS7XX_IER_RDI_BIT);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void sc16is7xx_unthrottle(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_ier_set(port, SC16IS7XX_IER_RDI_BIT);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static unsigned int sc16is7xx_tx_empty(struct uart_port *port)
@@ -1113,7 +1113,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	/* Setup baudrate generator */
 	baud = sc16is7xx_set_baud(port, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Update timeout according to new baud rate */
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -1121,7 +1121,7 @@ static void sc16is7xx_set_termios(struct uart_port *port,
 	if (UART_ENABLE_MS(port, termios->c_cflag))
 		sc16is7xx_enable_ms(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int sc16is7xx_config_rs485(struct uart_port *port, struct ktermios *termios,
@@ -1208,9 +1208,9 @@ static int sc16is7xx_startup(struct uart_port *port)
 	sc16is7xx_port_write(port, SC16IS7XX_IER_REG, val);
 
 	/* Enable modem status polling */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	sc16is7xx_enable_ms(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
-- 
2.39.2

