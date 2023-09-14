Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743457A0CE8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241776AbjINSjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237837AbjINSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8AE1FD7;
        Thu, 14 Sep 2023 11:38:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTxTld72jsbFLwbI2RprxpQt/WT5K9+FgFLsAE2902M=;
        b=n0C85JkbazQQQqk994zwcXCFNCkWtviypeikAhkD4Peur7hNh9TfMzWdACRHIotOkc73y3
        MM9dC2UwjT1uNPUSJ1rX/Wg0/KwQnC3OMYmWzI7QSX+ZyfRbJighMJm3ZK/4ER/3rdWuEz
        jJ+onkk8n4sltcqsJWtLI7/f7QQ7htklwmMl+vR3WK9yYr9e8uc6femPGqYMrr0TAnadFl
        01okjELZl/Wt7n3p0koa/2v+3GAcCvIWvqe360+k7kYIf8JmcOpOvnLhBVNGFXKwtm7j37
        yoI/UzcG03SZzeMS9ChkZZJQnWAGa44qb6a+iCaCrbovxd7HbrXSOCW5lqSfMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lTxTld72jsbFLwbI2RprxpQt/WT5K9+FgFLsAE2902M=;
        b=4bDoaa+QazP1WDXkaSwXU2eQvkxKWr9YgMinglGoyPJplI2ioNYKHDKVT/2ieODghymWrW
        eZzEP+yP2UuKguBg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH tty v1 06/74] serial: 8250: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:23 +0206
Message-Id: <20230914183831.587273-7-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_core.c |  12 ++--
 drivers/tty/serial/8250/8250_port.c | 100 ++++++++++++++--------------
 2 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 3449f8790e46..904e319e6b4a 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -259,7 +259,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	unsigned int iir, ier = 0, lsr;
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 * Must disable interrupts or else we risk racing with the interrupt
@@ -292,7 +292,7 @@ static void serial8250_backup_timeout(struct timer_list *t)
 	if (up->port.irq)
 		serial_out(up, UART_IER, ier);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	/* Standard timer interval plus 0.2s to keep the port running */
 	mod_timer(&up->timer,
@@ -992,11 +992,11 @@ static void serial_8250_overrun_backoff_work(struct work_struct *work)
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	up->port.read_status_mask |= UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /**
@@ -1194,9 +1194,9 @@ void serial8250_unregister_port(int line)
 	if (uart->em485) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&uart->port.lock, flags);
+		uart_port_lock_irqsave(&uart->port, &flags);
 		serial8250_em485_destroy(uart);
-		spin_unlock_irqrestore(&uart->port.lock, flags);
+		uart_port_unlock_irqrestore(&uart->port, flags);
 	}
 
 	uart_remove_one_port(&serial8250_reg, &uart->port);
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index fb891b67968f..cd82bf7dd4f5 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -689,7 +689,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 
 	if (p->capabilities & UART_CAP_SLEEP) {
 		/* Synchronize UART_IER access against the console. */
-		spin_lock_irq(&p->port.lock);
+		uart_port_lock_irq(&p->port);
 		if (p->capabilities & UART_CAP_EFR) {
 			lcr = serial_in(p, UART_LCR);
 			efr = serial_in(p, UART_EFR);
@@ -703,7 +703,7 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 			serial_out(p, UART_EFR, efr);
 			serial_out(p, UART_LCR, lcr);
 		}
-		spin_unlock_irq(&p->port.lock);
+		uart_port_unlock_irq(&p->port);
 	}
 
 	serial8250_rpm_put(p);
@@ -746,9 +746,9 @@ static void enable_rsa(struct uart_8250_port *up)
 {
 	if (up->port.type == PORT_RSA) {
 		if (up->port.uartclk != SERIAL_RSA_BAUD_BASE * 16) {
-			spin_lock_irq(&up->port.lock);
+			uart_port_lock_irq(&up->port);
 			__enable_rsa(up);
-			spin_unlock_irq(&up->port.lock);
+			uart_port_unlock_irq(&up->port);
 		}
 		if (up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16)
 			serial_out(up, UART_RSA_FRR, 0);
@@ -768,7 +768,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 	if (up->port.type == PORT_RSA &&
 	    up->port.uartclk == SERIAL_RSA_BAUD_BASE * 16) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port);
 
 		mode = serial_in(up, UART_RSA_MSR);
 		result = !(mode & UART_RSA_MSR_FIFO);
@@ -781,7 +781,7 @@ static void disable_rsa(struct uart_8250_port *up)
 
 		if (result)
 			up->port.uartclk = SERIAL_RSA_BAUD_BASE_LO * 16;
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port);
 	}
 }
 #endif /* CONFIG_SERIAL_8250_RSA */
@@ -1172,7 +1172,7 @@ static void autoconfig(struct uart_8250_port *up)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	up->capabilities = 0;
 	up->bugs = 0;
@@ -1211,7 +1211,7 @@ static void autoconfig(struct uart_8250_port *up)
 			/*
 			 * We failed; there's nothing here
 			 */
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("IER test failed (%02x, %02x) ",
 				       scratch2, scratch3);
 			goto out;
@@ -1235,7 +1235,7 @@ static void autoconfig(struct uart_8250_port *up)
 		status1 = serial_in(up, UART_MSR) & UART_MSR_STATUS_BITS;
 		serial8250_out_MCR(up, save_mcr);
 		if (status1 != (UART_MSR_DCD | UART_MSR_CTS)) {
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			DEBUG_AUTOCONF("LOOP test failed (%02x) ",
 				       status1);
 			goto out;
@@ -1304,7 +1304,7 @@ static void autoconfig(struct uart_8250_port *up)
 	serial8250_clear_IER(up);
 
 out_unlock:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Check if the device is a Fintek F81216A
@@ -1344,9 +1344,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
 	probe_irq_off(probe_irq_on());
 	save_mcr = serial8250_in_MCR(up);
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	save_ier = serial_in(up, UART_IER);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 	serial8250_out_MCR(up, UART_MCR_OUT1 | UART_MCR_OUT2);
 
 	irqs = probe_irq_on();
@@ -1359,9 +1359,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
 			UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2);
 	}
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, UART_IER_ALL_INTR);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 	serial_in(up, UART_LSR);
 	serial_in(up, UART_RX);
 	serial_in(up, UART_IIR);
@@ -1372,9 +1372,9 @@ static void autoconfig_irq(struct uart_8250_port *up)
 
 	serial8250_out_MCR(up, save_mcr);
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	serial_out(up, UART_IER, save_ier);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 
 	if (port->flags & UPF_FOURPORT)
 		outb_p(save_ICP, ICP);
@@ -1442,13 +1442,13 @@ static enum hrtimer_restart serial8250_em485_handle_stop_tx(struct hrtimer *t)
 	unsigned long flags;
 
 	serial8250_rpm_get(p);
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 	if (em485->active_timer == &em485->stop_tx_timer) {
 		p->rs485_stop_tx(p);
 		em485->active_timer = NULL;
 		em485->tx_stopped = true;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 	serial8250_rpm_put(p);
 
 	return HRTIMER_NORESTART;
@@ -1630,12 +1630,12 @@ static enum hrtimer_restart serial8250_em485_handle_start_tx(struct hrtimer *t)
 	struct uart_8250_port *p = em485->port;
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 	if (em485->active_timer == &em485->start_tx_timer) {
 		__start_tx(&p->port);
 		em485->active_timer = NULL;
 	}
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -1918,7 +1918,7 @@ int serial8250_handle_irq(struct uart_port *port, unsigned int iir)
 	if (iir & UART_IIR_NO_INT)
 		return 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	status = serial_lsr_in(up);
 
@@ -1985,9 +1985,9 @@ static int serial8250_tx_threshold_handle_irq(struct uart_port *port)
 	if ((iir & UART_IIR_ID) == UART_IIR_THRI) {
 		struct uart_8250_port *up = up_to_u8250p(port);
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		serial8250_tx_chars(up);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	iir = serial_port_in(port, UART_IIR);
@@ -2002,10 +2002,10 @@ static unsigned int serial8250_tx_empty(struct uart_port *port)
 
 	serial8250_rpm_get(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (!serial8250_tx_dma_running(up) && uart_lsr_tx_empty(serial_lsr_in(up)))
 		result = TIOCSER_TEMT;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	serial8250_rpm_put(up);
 
@@ -2067,13 +2067,13 @@ static void serial8250_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (break_state == -1)
 		up->lcr |= UART_LCR_SBC;
 	else
 		up->lcr &= ~UART_LCR_SBC;
 	serial_port_out(port, UART_LCR, up->lcr);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 }
 
@@ -2208,7 +2208,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 *
 		 * Synchronize UART_IER access against the console.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		up->acr = 0;
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
@@ -2218,7 +2218,7 @@ int serial8250_do_startup(struct uart_port *port)
 		serial_port_out(port, UART_LCR, UART_LCR_CONF_MODE_B);
 		serial_port_out(port, UART_EFR, UART_EFR_ECB);
 		serial_port_out(port, UART_LCR, 0);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	if (port->type == PORT_DA830) {
@@ -2227,10 +2227,10 @@ int serial8250_do_startup(struct uart_port *port)
 		 *
 		 * Synchronize UART_IER access against the console.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		serial_port_out(port, UART_IER, 0);
 		serial_port_out(port, UART_DA830_PWREMU_MGMT, 0);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		mdelay(10);
 
 		/* Enable Tx, Rx and free run mode */
@@ -2344,7 +2344,7 @@ int serial8250_do_startup(struct uart_port *port)
 		 *
 		 * Synchronize UART_IER access against the console.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 		wait_for_xmitr(up, UART_LSR_THRE);
 		serial_port_out_sync(port, UART_IER, UART_IER_THRI);
@@ -2356,7 +2356,7 @@ int serial8250_do_startup(struct uart_port *port)
 		iir = serial_port_in(port, UART_IIR);
 		serial_port_out(port, UART_IER, 0);
 
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		if (port->irqflags & IRQF_SHARED)
 			enable_irq(port->irq);
@@ -2379,7 +2379,7 @@ int serial8250_do_startup(struct uart_port *port)
 	 */
 	serial_port_out(port, UART_LCR, UART_LCR_WLEN8);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (up->port.flags & UPF_FOURPORT) {
 		if (!up->port.irq)
 			up->port.mctrl |= TIOCM_OUT1;
@@ -2425,7 +2425,7 @@ int serial8250_do_startup(struct uart_port *port)
 	}
 
 dont_test_tx_en:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Clear the interrupt registers again for luck, and clear the
@@ -2496,17 +2496,17 @@ void serial8250_do_shutdown(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	up->ier = 0;
 	serial_port_out(port, UART_IER, 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	synchronize_irq(port->irq);
 
 	if (up->dma)
 		serial8250_release_dma(up);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (port->flags & UPF_FOURPORT) {
 		/* reset interrupts on the AST Fourport board */
 		inb((port->iobase & 0xfe0) | 0x1f);
@@ -2515,7 +2515,7 @@ void serial8250_do_shutdown(struct uart_port *port)
 		port->mctrl &= ~TIOCM_OUT2;
 
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * Disable break condition and FIFOs
@@ -2751,14 +2751,14 @@ void serial8250_update_uartclk(struct uart_port *port, unsigned int uartclk)
 	quot = serial8250_get_divisor(port, baud, &frac);
 
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	serial8250_set_divisor(port, baud, quot, frac);
 	serial_port_out(port, UART_LCR, up->lcr);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 out_unlock:
@@ -2795,7 +2795,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * Synchronize UART_IER access against the console.
 	 */
 	serial8250_rpm_get(up);
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	up->lcr = cval;					/* Save computed LCR */
 
@@ -2898,7 +2898,7 @@ serial8250_do_set_termios(struct uart_port *port, struct ktermios *termios,
 		serial_port_out(port, UART_FCR, up->fcr);	/* set fcr */
 	}
 	serial8250_set_mctrl(port, port->mctrl);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_rpm_put(up);
 
 	/* Don't rewrite B0 */
@@ -2921,15 +2921,15 @@ void serial8250_do_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		serial8250_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(port);
 			serial8250_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(port);
 		}
 	}
 }
@@ -3403,9 +3403,9 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	touch_nmi_watchdog();
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
@@ -3475,7 +3475,7 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 		serial8250_modem_status(up);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static unsigned int probe_baud(struct uart_port *port)
-- 
2.39.2

