Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75DEC7A0D5F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbjINSnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242137AbjINSlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:41:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A5D2D79;
        Thu, 14 Sep 2023 11:39:09 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmN9t/TOdcgFZ+bmPfvXJ91pUl/2gBg4MuuLLO43TiA=;
        b=lZZMwROiXF7iHdvpNl7+JZXd8JHRJxlrJO/O2a6l7jlyYnndDS3tbJpaC3zOhAM71f9XrS
        kcepKr8jfbkARy8zvIO9bEET/k6xLgj2yLmNwyxHjkw2RvlXdoPKqQXnONb/aNnxgpPan+
        9Xz/tRfiwxPA68mPgAGrVkTc+Tl4Fm4VNmw4Nn121e+n9hfCQj9x2IovyO/S2ZS4O7csnI
        wefbsvV230d8cvWK6HUe27OS7SVPRrn5o38LxRhS//3ha/xyhCazNacRZKLxK7JvVihT5r
        EPUApL/yX8DGaPnkiSmvn9GiANGQlCO0f0Q0IKmp1Z1vnA+Jz6FDNtHHFKUT1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716748;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZmN9t/TOdcgFZ+bmPfvXJ91pUl/2gBg4MuuLLO43TiA=;
        b=W6elDBkcls6Us2UZ8xmu8+vQvXuShUMOnWGdO6CyEEv3LDCbm3pFnjCa1k2m7TDXeaA0rL
        zJhp0dPySNVny4Dg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH tty v1 67/74] serial: sunsab: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:24 +0206
Message-Id: <20230914183831.587273-68-john.ogness@linutronix.de>
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
 drivers/tty/serial/sunsab.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 40eeaf835bba..6aa51a6f8063 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -310,7 +310,7 @@ static irqreturn_t sunsab_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	unsigned char gis;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	status.stat = 0;
 	gis = readb(&up->regs->r.gis) >> up->gis_shift;
@@ -331,7 +331,7 @@ static irqreturn_t sunsab_interrupt(int irq, void *dev_id)
 			transmit_chars(up, &status);
 	}
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	if (port)
 		tty_flip_buffer_push(port);
@@ -473,12 +473,12 @@ static void sunsab_send_xchar(struct uart_port *port, char ch)
 	if (ch == __DISABLED_CHAR)
 		return;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	sunsab_tec_wait(up);
 	writeb(ch, &up->regs->w.tic);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 /* port->lock held by caller.  */
@@ -499,7 +499,7 @@ static void sunsab_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned char val;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	val = up->cached_dafo;
 	if (break_state)
@@ -512,7 +512,7 @@ static void sunsab_break_ctl(struct uart_port *port, int break_state)
 	if (test_bit(SAB82532_XPR, &up->irqflags))
 		sunsab_tx_idle(up);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 /* port->lock is not held.  */
@@ -527,7 +527,7 @@ static int sunsab_startup(struct uart_port *port)
 	if (err)
 		return err;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 * Wait for any commands or immediate characters
@@ -582,7 +582,7 @@ static int sunsab_startup(struct uart_port *port)
 	set_bit(SAB82532_ALLS, &up->irqflags);
 	set_bit(SAB82532_XPR, &up->irqflags);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return 0;
 }
@@ -594,7 +594,7 @@ static void sunsab_shutdown(struct uart_port *port)
 		container_of(port, struct uart_sunsab_port, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/* Disable Interrupts */
 	up->interrupt_mask0 = 0xff;
@@ -628,7 +628,7 @@ static void sunsab_shutdown(struct uart_port *port)
 	writeb(tmp, &up->regs->rw.ccr0);
 #endif
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 	free_irq(up->port.irq, up);
 }
 
@@ -779,9 +779,9 @@ static void sunsab_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned int baud = uart_get_baud_rate(port, termios, old, 0, 4000000);
 	unsigned int quot = uart_get_divisor(port, baud);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	sunsab_convert_to_sab(up, termios->c_cflag, termios->c_iflag, baud, quot);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static const char *sunsab_type(struct uart_port *port)
@@ -857,15 +857,15 @@ static void sunsab_console_write(struct console *con, const char *s, unsigned n)
 	int locked = 1;
 
 	if (up->port.sysrq || oops_in_progress)
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		spin_lock_irqsave(&up->port.lock, flags);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	uart_console_write(&up->port, s, n, sunsab_console_putchar);
 	sunsab_tec_wait(up);
 
 	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int sunsab_console_setup(struct console *con, char *options)
@@ -914,7 +914,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	 */
 	sunsab_startup(&up->port);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 * Finally, enable interrupts
@@ -932,7 +932,7 @@ static int sunsab_console_setup(struct console *con, char *options)
 	sunsab_convert_to_sab(up, con->cflag, 0, baud, quot);
 	sunsab_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 	
 	return 0;
 }
-- 
2.39.2

