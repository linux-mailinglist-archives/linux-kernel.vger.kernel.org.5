Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28197A0D14
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242017AbjINSkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148E8213A;
        Thu, 14 Sep 2023 11:38:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlpF/H9lKMDrxmXTuNUKsAvkYnpqtMAZIidKoYfk2m8=;
        b=OvnQvp6FrSEUwDayVfCSyaTaDBzuc0qDHdbES+H9OAPO6Ha87bRKvDnKy+aUS4pdZFLLmB
        jDxwD/L3qDChRCkKs0q+jzzmJmJZiwqpSy8A1vQM9uRhSkNw2idhoRuvvgsJxrK+wZx4QG
        XqxrNYbAK6u7sE1Tzcyz/LRQvnyD2tzuxG6rvJL6EQObHJpanuV55slsCsY84hl6Zyio/3
        pQD3+PfXQ3qkNC9MvbiF4uH2PApwczoZNDT9+YaqQDJfAN6RMTd8Q0wfobK08utaA6SImc
        QzGgZlJy1nebH8t5hloy88cBPuR+IEjxhUWo45LfVr3WtSj7eG3UDcwTb/G12w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UlpF/H9lKMDrxmXTuNUKsAvkYnpqtMAZIidKoYfk2m8=;
        b=NkoS64+YSQlVmh/kcYnHAvKRouOJW5bYLm3LDjq5+uZbRS0+LZRledqxXPhj4J2guP/ZOw
        dmliYWM9jDfA5hBA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Karol Gugala <kgugala@antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Gabriel Somlo <gsomlo@gmail.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH tty v1 32/74] serial: liteuart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:49 +0206
Message-Id: <20230914183831.587273-33-john.ogness@linutronix.de>
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
 drivers/tty/serial/liteuart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index d881cdd2a58f..a25ab1efe38f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -139,13 +139,13 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 	 * if polling, the context would be "in_serving_softirq", so use
 	 * irq[save|restore] spin_lock variants to cover all possibilities
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
 	if (isr & EV_TX)
 		liteuart_tx_chars(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_RETVAL(isr);
 }
@@ -195,10 +195,10 @@ static int liteuart_startup(struct uart_port *port)
 		}
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	/* only enabling rx irqs during startup */
 	liteuart_update_irq_reg(port, true, EV_RX);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (!port->irq) {
 		timer_setup(&uart->timer, liteuart_timer, 0);
@@ -213,9 +213,9 @@ static void liteuart_shutdown(struct uart_port *port)
 	struct liteuart_port *uart = to_liteuart_port(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (port->irq)
 		free_irq(port->irq, port);
@@ -229,13 +229,13 @@ static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
 	unsigned int baud;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* update baudrate */
 	baud = uart_get_baud_rate(port, new, old, 0, 460800);
 	uart_update_timeout(port, new->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *liteuart_type(struct uart_port *port)
@@ -382,9 +382,9 @@ static void liteuart_console_write(struct console *co, const char *s,
 	uart = (struct liteuart_port *)xa_load(&liteuart_array, co->index);
 	port = &uart->port;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_console_write(port, s, count, liteuart_putchar);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int liteuart_console_setup(struct console *co, char *options)
-- 
2.39.2

