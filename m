Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C78EA7A0D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbjINSjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241763AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F209212E;
        Thu, 14 Sep 2023 11:38:52 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MhPKCrB1dOunNZkyVt5zeAFdISPvOBlSvfyFnl5/7k=;
        b=YLqoO2CmXARRUlFLHeB2M6ukd+zU/nFFgFSlVGTgtOrax7oXV7pPL8cSmw/pZDAElhtrfi
        tg+qdkkRjdfFcje2e6txYb3BMdaIg9i7e0Mh+YxmElDly4kDa3NAjK/0UG6MgVfELywhT2
        V8orxiw3OetQDrZZDTQXxy5+hqdFeJ1HEll+tEKleM5gcgTzDHcNQToDDydnseVBtkUdYG
        gytRSgchp+eOFJON+5pvNC6JQu0C+5Da8EUAAMJ6Xa4aUQIiDLgBOmaNvJOGFL+X0eB7l+
        ajIq4J62gfzDnlJBiRb8IMfsMmRoi6quQ96kG6szLXiQ26KdUa+1MgJWGskI1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7MhPKCrB1dOunNZkyVt5zeAFdISPvOBlSvfyFnl5/7k=;
        b=3ww4vlg4w6dOUA/vLaMXWEJhpTPQP9RtHU84xi6hn3BhuNTqmvAXu3TlTrY1SAXMKgY3m8
        pzcqy8Uf8lJvCrBg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH tty v1 30/74] serial: ip22zilog: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:47 +0206
Message-Id: <20230914183831.587273-31-john.ogness@linutronix.de>
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
 drivers/tty/serial/ip22zilog.c | 36 +++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/serial/ip22zilog.c b/drivers/tty/serial/ip22zilog.c
index 845ff706bc59..320b29cd4683 100644
--- a/drivers/tty/serial/ip22zilog.c
+++ b/drivers/tty/serial/ip22zilog.c
@@ -432,7 +432,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		unsigned char r3;
 		bool push = false;
 
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 		r3 = read_zsreg(channel, R3);
 
 		/* Channel A */
@@ -448,7 +448,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 			if (r3 & CHATxIP)
 				ip22zilog_transmit_chars(up, channel);
 		}
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 		if (push)
 			tty_flip_buffer_push(&up->port.state->port);
@@ -458,7 +458,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 		channel = ZILOG_CHANNEL_FROM_PORT(&up->port);
 		push = false;
 
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 		if (r3 & (CHBEXT | CHBTxIP | CHBRxIP)) {
 			writeb(RES_H_IUS, &channel->control);
 			ZSDELAY();
@@ -471,7 +471,7 @@ static irqreturn_t ip22zilog_interrupt(int irq, void *dev_id)
 			if (r3 & CHBTxIP)
 				ip22zilog_transmit_chars(up, channel);
 		}
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 		if (push)
 			tty_flip_buffer_push(&up->port.state->port);
@@ -504,11 +504,11 @@ static unsigned int ip22zilog_tx_empty(struct uart_port *port)
 	unsigned char status;
 	unsigned int ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	status = ip22zilog_read_channel_status(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (status & Tx_BUF_EMP)
 		ret = TIOCSER_TEMT;
@@ -664,7 +664,7 @@ static void ip22zilog_break_ctl(struct uart_port *port, int break_state)
 	else
 		clear_bits |= SND_BRK;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	new_reg = (up->curregs[R5] | set_bits) & ~clear_bits;
 	if (new_reg != up->curregs[R5]) {
@@ -674,7 +674,7 @@ static void ip22zilog_break_ctl(struct uart_port *port, int break_state)
 		write_zsreg(channel, R5, up->curregs[R5]);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void __ip22zilog_reset(struct uart_ip22zilog_port *up)
@@ -735,9 +735,9 @@ static int ip22zilog_startup(struct uart_port *port)
 	if (ZS_IS_CONS(up))
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	__ip22zilog_startup(up);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	return 0;
 }
 
@@ -775,7 +775,7 @@ static void ip22zilog_shutdown(struct uart_port *port)
 	if (ZS_IS_CONS(up))
 		return;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	channel = ZILOG_CHANNEL_FROM_PORT(port);
 
@@ -788,7 +788,7 @@ static void ip22zilog_shutdown(struct uart_port *port)
 	up->curregs[R5] &= ~SND_BRK;
 	ip22zilog_maybe_update_regs(up, channel);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* Shared by TTY driver and serial console setup.  The port lock is held
@@ -880,7 +880,7 @@ ip22zilog_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	baud = uart_get_baud_rate(port, termios, old, 1200, 76800);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	brg = BPS_TO_BRG(baud, ZS_CLOCK / ZS_CLOCK_DIVISOR);
 
@@ -894,7 +894,7 @@ ip22zilog_set_termios(struct uart_port *port, struct ktermios *termios,
 	ip22zilog_maybe_update_regs(up, ZILOG_CHANNEL_FROM_PORT(port));
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static const char *ip22zilog_type(struct uart_port *port)
@@ -1016,10 +1016,10 @@ ip22zilog_console_write(struct console *con, const char *s, unsigned int count)
 	struct uart_ip22zilog_port *up = &ip22zilog_port_table[con->index];
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	uart_console_write(&up->port, s, count, ip22zilog_put_char);
 	udelay(2);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int __init ip22zilog_console_setup(struct console *con, char *options)
@@ -1034,13 +1034,13 @@ static int __init ip22zilog_console_setup(struct console *con, char *options)
 
 	printk(KERN_INFO "Console: ttyS%d (IP22-Zilog)\n", con->index);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	up->curregs[R15] |= BRKIE;
 
 	__ip22zilog_startup(up);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
2.39.2

