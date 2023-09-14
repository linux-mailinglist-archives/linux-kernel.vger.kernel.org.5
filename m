Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF3F7A0D65
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242154AbjINSn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241107AbjINSl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:41:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F12C30CF;
        Thu, 14 Sep 2023 11:39:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfmijAtC3g1oYJPusPmN4eARviwbFrdwcagGmP/zuzk=;
        b=R2v6uaMQ7CS6ZYHIZPSM59WMeA2cANUhi9CnTM0Q+Duf7YKQNnN2wOKSAsfEbnMWavbWDP
        Jb/eDeirjaQ1SF+YR+/rwnARnLUtPdjYWm0WQ3Z9y8oGIidSsdYMJQ1jL5Bzkc9+c9PrhJ
        Uec7tsI8SR8BZsy6G6Ntr48hN4RwmS5nRSZQMmcBKXUsEEBR1kABDz/PNircItNuiFC9Qw
        M+2Fz5V0TZYL5dV7wEdsX9ZAQwnYC5Yu87oebcBbKUZBJdG4kibVw51vb6T8Ze13MzAX7M
        RuK4JzT9fQ9xOR9hXdeFwQqP2NFtFJ5Z9HckO+QC+G0xaRLlWuu7LkgDQMc4hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZfmijAtC3g1oYJPusPmN4eARviwbFrdwcagGmP/zuzk=;
        b=Pm8yyxP5/5v8PDUy4f7SgJldp6MTI6kgWYYQfNDw+CSvuHHQOu92wjI/bymXTaAvCPlf9d
        1EX+IZ/ElO3HZ3BA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH tty v1 69/74] serial: sunzilog: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:26 +0206
Message-Id: <20230914183831.587273-70-john.ogness@linutronix.de>
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
 drivers/tty/serial/sunzilog.c | 42 +++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index c8c71c56264c..d3b5e864b727 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -531,7 +531,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 		struct tty_port *port;
 		unsigned char r3;
 
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 		r3 = read_zsreg(channel, R3);
 
 		/* Channel A */
@@ -548,7 +548,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 			if (r3 & CHATxIP)
 				sunzilog_transmit_chars(up, channel);
 		}
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 		if (port)
 			tty_flip_buffer_push(port);
@@ -557,7 +557,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 		up = up->next;
 		channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 		port = NULL;
 		if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 			writeb(RES_H_IUS, &channel->control);
@@ -571,7 +571,7 @@ static irqreturn_t sunzilog_interrupt(int irq, void *dev_id)
 			if (r3 & CHBTxIP)
 				sunzilog_transmit_chars(up, channel);
 		}
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 		if (port)
 			tty_flip_buffer_push(port);
@@ -604,11 +604,11 @@ static unsigned int sunzilog_tx_empty(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	status = sunzilog_read_channel_status(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (status & Tx_BUF_EMP)
 		ret = TIOCSER_TEMT;
@@ -764,7 +764,7 @@ static void sunzilog_break_ctl(struct uart_port *port, int break_state)
 	else
 		clear_bits |= SND_BRK;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	new_reg = (up->curregs[R5] | set_bits) & ~clear_bits;
 	if (new_reg != up->curregs[R5]) {
@@ -774,7 +774,7 @@ static void sunzilog_break_ctl(struct uart_port *port, int break_state)
 		write_zsreg(channel, R5, up->curregs[R5]);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __sunzilog_startup(struct uart_sunzilog_port *up)
@@ -800,9 +800,9 @@ static int sunzilog_startup(struct uart_port *port)
 	if (ZS_IS_CONS(up))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	__sunzilog_startup(up);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	return 0;
 }
 
@@ -840,7 +840,7 @@ static void sunzilog_shutdown(struct uart_port *port)
 	if (ZS_IS_CONS(up))
 		return;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 
@@ -853,7 +853,7 @@ static void sunzilog_shutdown(struct uart_port *port)
 	up->curregs[R5] &= ~SND_BRK;
 	sunzilog_maybe_update_regs(up, channel);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* Shared by TTY driver and serial console setup.  The port lock is held
@@ -945,7 +945,7 @@ sunzilog_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	baud = uart_get_baud_rate(port, termios, old, 1200, 76800);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 
@@ -962,7 +962,7 @@ sunzilog_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static const char *sunzilog_type(struct uart_port *port)
@@ -1201,15 +1201,15 @@ sunzilog_console_write(struct console *con, const char *s, unsigned int count)
 	int locked = 1;
 
 	if (up->port.sysrq || oops_in_progress)
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		spin_lock_irqsave(&up->port.lock, flags);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	uart_console_write(&up->port, s, count, sunzilog_putchar);
 	udelay(2);
 
 	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int __init sunzilog_console_setup(struct console *con, char *options)
@@ -1244,7 +1244,7 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 
 	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	up->curregs[R15] |= BRKIE;
 	sunzilog_convert_to_zs(up, con->cflag, 0, brg);
@@ -1252,7 +1252,7 @@ static int __init sunzilog_console_setup(struct console *con, char *options)
 	sunzilog_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
 	__sunzilog_startup(up);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return 0;
 }
@@ -1333,7 +1333,7 @@ static void sunzilog_init_hw(struct uart_sunzilog_port *up)
 
 	channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	if (ZS_IS_CHANNEL_A(up)) {
 		write_zsreg(channel, R9, FHWRES);
 		ZSDELAY_LONG();
@@ -1383,7 +1383,7 @@ static void sunzilog_init_hw(struct uart_sunzilog_port *up)
 		write_zsreg(channel, R9, up->curregs[R9]);
 	}
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 #ifdef CONFIG_SERIO
 	if (up->flags & (SUNZILOG_FLAG_CONS_KEYB |
-- 
2.39.2

