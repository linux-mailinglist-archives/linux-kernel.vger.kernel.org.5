Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6DDF7A0D58
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241981AbjINSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241825AbjINSlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:41:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F192D65;
        Thu, 14 Sep 2023 11:39:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rtu6oqE59dzKnOzbdNG30qc4om/oIgRr8S/zbKifFdc=;
        b=Ox3AVx2dzryq88igCiD0iP3QWgUJkXiwaPj9FFyKP5obEHwDkRSJvaC6guX/ZIVT17C1E/
        DqC8IIdrncfuOFDGqdJq/a9VZI5Mad2edRRgfFXaVbO1a1hiDFoXWWmzXdBEo/uxsv8TGu
        FcY7848+U1ZX0AyaqwTnxAoHCDuuAgmHLdiycdUBGHZxt/t/eS30/NVCfzcASGe/PyxnYy
        NVor/6R/yuNdiyuduDI+Uz7FEHRJWR5D9n4feEQHHvbp0QMFDRfJwnx/UK/skKtekEyZ7e
        kImmOywWdtYt3DZ6JsbdBGn9PPp91Snbi6gKxhaA89uomCON3arVYZsMhQGvOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rtu6oqE59dzKnOzbdNG30qc4om/oIgRr8S/zbKifFdc=;
        b=NXJ+yaujVO6y/IuJtIGgaAgB0JGAz6vau/jQZ0o0D/rAnYe2xp0P7vUQxS89WFZpnZ3hlv
        8pezu6YWNex7nZBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH tty v1 65/74] serial: sunhv: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:22 +0206
Message-Id: <20230914183831.587273-66-john.ogness@linutronix.de>
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
 drivers/tty/serial/sunhv.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index c671d674bce4..5bfc0040f17b 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -217,10 +217,10 @@ static irqreturn_t sunhv_interrupt(int irq, void *dev_id)
 	struct tty_port *tport;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	tport = receive_chars(port);
 	transmit_chars(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (tport)
 		tty_flip_buffer_push(tport);
@@ -271,7 +271,7 @@ static void sunhv_send_xchar(struct uart_port *port, char ch)
 	if (ch == __DISABLED_CHAR)
 		return;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	while (limit-- > 0) {
 		long status = sun4v_con_putchar(ch);
@@ -280,7 +280,7 @@ static void sunhv_send_xchar(struct uart_port *port, char ch)
 		udelay(1);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* port->lock held by caller.  */
@@ -295,7 +295,7 @@ static void sunhv_break_ctl(struct uart_port *port, int break_state)
 		unsigned long flags;
 		int limit = 10000;
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 		while (limit-- > 0) {
 			long status = sun4v_con_putchar(CON_BREAK);
@@ -304,7 +304,7 @@ static void sunhv_break_ctl(struct uart_port *port, int break_state)
 			udelay(1);
 		}
 
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 }
 
@@ -328,7 +328,7 @@ static void sunhv_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int iflag, cflag;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	iflag = termios->c_iflag;
 	cflag = termios->c_cflag;
@@ -343,7 +343,7 @@ static void sunhv_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, cflag,
 			    (port->uartclk / (16 * quot)));
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *sunhv_type(struct uart_port *port)
@@ -437,9 +437,9 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
 	int locked = 1;
 
 	if (port->sysrq || oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	while (n > 0) {
 		unsigned long ra = __pa(con_write_page);
@@ -470,7 +470,7 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
 	}
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static inline void sunhv_console_putchar(struct uart_port *port, char c)
@@ -492,9 +492,9 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 	int i, locked = 1;
 
 	if (port->sysrq || oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	for (i = 0; i < n; i++) {
 		if (*s == '\n')
@@ -503,7 +503,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 	}
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static struct console sunhv_console = {
-- 
2.39.2

