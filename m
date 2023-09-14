Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F67A0D27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242073AbjINSkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbjINSjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB3F2699;
        Thu, 14 Sep 2023 11:38:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM2lMzc0PZnA/sY8/z8U7YuTZ4e1IcuDY2kIfWsOpyQ=;
        b=FICjtyvsmwVqj44DyW1kMBUfwf68fgwbh15x8MwU/aTDMRJPKm4BZUOBzG0XBA7jWlIB+0
        YKFyTSq8o42fJ/COoOhYyMT7EBDEP97Eb6JRrudzQyA7+zX61wXKdASBue+PapJhSE6S5j
        RyQm2yrliGyEaATky/kriWEYTuCbWCJWrVQFzrQMKRJOxSWrnl2GB/GqOVR7cyy1u1WfgD
        umlRMhKtB2vbUqECyRnuRE1iDF+5I1rOVDP2d3U+dh1+4IBfv72B5AHE98/jTuB+Eqh7D2
        vEPkNs0ajk3mvU+NMgH2yAkiglQdHGWn1u7hIgFNTKx3qFP1cWqpPw3he5z/IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TM2lMzc0PZnA/sY8/z8U7YuTZ4e1IcuDY2kIfWsOpyQ=;
        b=3mUyA4mjX/1njeJwzdLso8SNIMRFMezSZkikPVg02+JHQf5a1CWunGcOHq+55yvoNpG3we
        sREi4ItmDB13/HDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>, Yangtao Li <frank.li@vivo.com>
Subject: [PATCH tty v1 43/74] serial: omap: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:00 +0206
Message-Id: <20230914183831.587273-44-john.ogness@linutronix.de>
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
 drivers/tty/serial/omap-serial.c | 38 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 0ead88c5a19a..ad4c1c5d0a7f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -390,10 +390,10 @@ static void serial_omap_throttle(struct uart_port *port)
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	up->ier &= ~(UART_IER_RLSI | UART_IER_RDI);
 	serial_out(up, UART_IER, up->ier);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static void serial_omap_unthrottle(struct uart_port *port)
@@ -401,10 +401,10 @@ static void serial_omap_unthrottle(struct uart_port *port)
 	struct uart_omap_port *up = to_uart_omap_port(port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static unsigned int check_modem_status(struct uart_omap_port *up)
@@ -527,7 +527,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 	irqreturn_t ret = IRQ_NONE;
 	int max_count = 256;
 
-	spin_lock(&up->port.lock);
+	uart_port_lock(&up->port);
 
 	do {
 		iir = serial_in(up, UART_IIR);
@@ -563,7 +563,7 @@ static irqreturn_t serial_omap_irq(int irq, void *dev_id)
 		}
 	} while (max_count--);
 
-	spin_unlock(&up->port.lock);
+	uart_port_unlock(&up->port);
 
 	tty_flip_buffer_push(&up->port.state->port);
 
@@ -579,9 +579,9 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
 	unsigned int ret = 0;
 
 	dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->port.line);
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return ret;
 }
@@ -647,13 +647,13 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 
 	dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->port.line);
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_out(up, UART_LCR, up->lcr);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int serial_omap_startup(struct uart_port *port)
@@ -701,13 +701,13 @@ static int serial_omap_startup(struct uart_port *port)
 	 * Now, initialize the UART
 	 */
 	serial_out(up, UART_LCR, UART_LCR_WLEN8);
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	/*
 	 * Most PC uarts need OUT2 raised to enable interrupts.
 	 */
 	up->port.mctrl |= TIOCM_OUT2;
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	up->msr_saved_flags = 0;
 	/*
@@ -742,10 +742,10 @@ static void serial_omap_shutdown(struct uart_port *port)
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	up->port.mctrl &= ~TIOCM_OUT2;
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -815,7 +815,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -1013,7 +1013,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	serial_omap_set_mctrl(&up->port, up->port.mctrl);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 	dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->port.line);
 }
 
@@ -1216,9 +1216,9 @@ serial_omap_console_write(struct console *co, const char *s,
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+		locked = uart_port_trylock(&up->port);
 	else
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -1245,7 +1245,7 @@ serial_omap_console_write(struct console *co, const char *s,
 		check_modem_status(up);
 
 	if (locked)
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 	local_irq_restore(flags);
 }
 
-- 
2.39.2

