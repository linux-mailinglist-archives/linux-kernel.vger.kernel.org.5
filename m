Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CA67A0D5A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242200AbjINSnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242020AbjINSla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:41:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E992D6A;
        Thu, 14 Sep 2023 11:39:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rrbJT9gAkuxqhBetlwX4STkcn6NRVLcBqG1WOPdKag=;
        b=Hy4pmQwrWiTg/Sk0lCuQa1kxE8/nB3RMmlGgMlxSI4lXcb0kwyeuXW11S9xZyynbrGkP2i
        Kq157hQUg26F3mY45MSuS3gyTKwdGM+jOio00+H3bLYvmtG+KVEAuOsqaTaU9oloO/9SoT
        SCJYc97+M10VosKuPvrsTUISMdLr8tHwQWTBvEZhR+nJJvPgLsCK4EHWOXX4bn+cL3FGkL
        nkok45hZinNMFOON6+PzIsZ5/KAr0WUiF9nIVBoLFbxOj2oFhnvxc4lVAAkdIKq2fwUGgA
        DDd2T+3IkSyjLZAMwmLxpwZNWvytbf8ep+qgUcriMPH/X0jWRW9TgOeRHv2VXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6rrbJT9gAkuxqhBetlwX4STkcn6NRVLcBqG1WOPdKag=;
        b=ufFE+TzqR1c1IghPpzdGrNrWlVOJW647t33n4zmoZiZkEaPOPWGTffgRmUipOkFmFsuWv2
        iFh50QKCm7tCSWAw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Hammer Hsieh <hammerh0314@gmail.com>
Subject: [PATCH tty v1 66/74] serial: sunplus-uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:23 +0206
Message-Id: <20230914183831.587273-67-john.ogness@linutronix.de>
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
 drivers/tty/serial/sunplus-uart.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/sunplus-uart.c b/drivers/tty/serial/sunplus-uart.c
index 3aacd5eb414c..4251f4e1ba99 100644
--- a/drivers/tty/serial/sunplus-uart.c
+++ b/drivers/tty/serial/sunplus-uart.c
@@ -184,7 +184,7 @@ static void sunplus_break_ctl(struct uart_port *port, int ctl)
 	unsigned long flags;
 	unsigned int lcr;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	lcr = readl(port->membase + SUP_UART_LCR);
 
@@ -195,7 +195,7 @@ static void sunplus_break_ctl(struct uart_port *port, int ctl)
 
 	writel(lcr, port->membase + SUP_UART_LCR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void transmit_chars(struct uart_port *port)
@@ -277,7 +277,7 @@ static irqreturn_t sunplus_uart_irq(int irq, void *args)
 	struct uart_port *port = args;
 	unsigned int isc;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	isc = readl(port->membase + SUP_UART_ISC);
 
@@ -287,7 +287,7 @@ static irqreturn_t sunplus_uart_irq(int irq, void *args)
 	if (isc & SUP_UART_ISC_TX)
 		transmit_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -302,14 +302,14 @@ static int sunplus_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	/* isc define Bit[7:4] int setting, Bit[3:0] int status
 	 * isc register will clean Bit[3:0] int status after read
 	 * only do a write to Bit[7:4] int setting
 	 */
 	isc |= SUP_UART_ISC_RXM;
 	writel(isc, port->membase + SUP_UART_ISC);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -318,13 +318,13 @@ static void sunplus_shutdown(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	/* isc define Bit[7:4] int setting, Bit[3:0] int status
 	 * isc register will clean Bit[3:0] int status after read
 	 * only do a write to Bit[7:4] int setting
 	 */
 	writel(0, port->membase + SUP_UART_ISC); /* disable all interrupt */
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
 }
@@ -372,7 +372,7 @@ static void sunplus_set_termios(struct uart_port *port,
 			lcr |= UART_LCR_EPAR;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
@@ -407,7 +407,7 @@ static void sunplus_set_termios(struct uart_port *port,
 	writel(div_l, port->membase + SUP_UART_DIV_L);
 	writel(lcr, port->membase + SUP_UART_LCR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void sunplus_set_ldisc(struct uart_port *port, struct ktermios *termios)
@@ -517,15 +517,15 @@ static void sunplus_console_write(struct console *co,
 	if (sunplus_console_ports[co->index]->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&sunplus_console_ports[co->index]->port.lock);
+		locked = uart_port_trylock(&sunplus_console_ports[co->index]->port);
 	else
-		spin_lock(&sunplus_console_ports[co->index]->port.lock);
+		uart_port_lock(&sunplus_console_ports[co->index]->port);
 
 	uart_console_write(&sunplus_console_ports[co->index]->port, s, count,
 			   sunplus_uart_console_putchar);
 
 	if (locked)
-		spin_unlock(&sunplus_console_ports[co->index]->port.lock);
+		uart_port_unlock(&sunplus_console_ports[co->index]->port);
 
 	local_irq_restore(flags);
 }
-- 
2.39.2

