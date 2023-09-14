Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77A2B7A0D09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbjINSjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A441FFD;
        Thu, 14 Sep 2023 11:38:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAQMyCFi9PO4xpR/WPWLi4jhKKcsg8hehn8chVaaTl0=;
        b=n2xCF/DUjDRzahmUSJxlSWtqGEYnXikTuRJGO0brUgFo2xy+azTzwwyTkZQNjo2UtThea7
        6Bj6FHVBCQWeV2ZRasFqBo0ev16KuZO4Z/2Dmh9F+/Uiy4YQqcvXCUKI9WXIJWy13kiOFV
        njJOY6stZWqb3FId6kBIv374vYa8WlyJvXiRxupEVrKfVO6HmihZfrUwaYlElGK8Avws4a
        KRYBVPxog9AXlkbsxYS+nBFZ3qtL5FhcNCgQXfqgfplsxw+PQ6yXHjleI2Ixi4sl/t+RFV
        vYvVuQKs//wBKHK7pFppuYNN0V74DEvdof27v/pzsUV1rUhJe6hwLZjED2PO+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bAQMyCFi9PO4xpR/WPWLi4jhKKcsg8hehn8chVaaTl0=;
        b=KdZ4Z6jUDDh6cAqCYOcEnIuqTngw9Nw3VLNS+kOfej1f0HNVUKkr2RbnSjsqky7RxWlaNt
        7pOCpZiPfAabqLDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH tty v1 25/74] serial: dz: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:42 +0206
Message-Id: <20230914183831.587273-26-john.ogness@linutronix.de>
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
 drivers/tty/serial/dz.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index 667f52e83277..6df7af9edc1c 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -268,9 +268,9 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 	}
 	/* If nothing to do or stopped or hardware stopped. */
 	if (uart_circ_empty(xmit) || uart_tx_stopped(&dport->port)) {
-		spin_lock(&dport->port.lock);
+		uart_port_lock(&dport->port);
 		dz_stop_tx(&dport->port);
-		spin_unlock(&dport->port.lock);
+		uart_port_unlock(&dport->port);
 		return;
 	}
 
@@ -287,9 +287,9 @@ static inline void dz_transmit_chars(struct dz_mux *mux)
 
 	/* Are we are done. */
 	if (uart_circ_empty(xmit)) {
-		spin_lock(&dport->port.lock);
+		uart_port_lock(&dport->port);
 		dz_stop_tx(&dport->port);
-		spin_unlock(&dport->port.lock);
+		uart_port_unlock(&dport->port);
 	}
 }
 
@@ -415,14 +415,14 @@ static int dz_startup(struct uart_port *uport)
 		return ret;
 	}
 
-	spin_lock_irqsave(&dport->port.lock, flags);
+	uart_port_lock_irqsave(&dport->port, &flags);
 
 	/* Enable interrupts.  */
 	tmp = dz_in(dport, DZ_CSR);
 	tmp |= DZ_RIE | DZ_TIE;
 	dz_out(dport, DZ_CSR, tmp);
 
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	uart_port_unlock_irqrestore(&dport->port, flags);
 
 	return 0;
 }
@@ -443,9 +443,9 @@ static void dz_shutdown(struct uart_port *uport)
 	int irq_guard;
 	u16 tmp;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
+	uart_port_lock_irqsave(&dport->port, &flags);
 	dz_stop_tx(&dport->port);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	uart_port_unlock_irqrestore(&dport->port, flags);
 
 	irq_guard = atomic_add_return(-1, &mux->irq_guard);
 	if (!irq_guard) {
@@ -491,14 +491,14 @@ static void dz_break_ctl(struct uart_port *uport, int break_state)
 	unsigned long flags;
 	unsigned short tmp, mask = 1 << dport->port.line;
 
-	spin_lock_irqsave(&uport->lock, flags);
+	uart_port_lock_irqsave(uport, &flags);
 	tmp = dz_in(dport, DZ_TCR);
 	if (break_state)
 		tmp |= mask;
 	else
 		tmp &= ~mask;
 	dz_out(dport, DZ_TCR, tmp);
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_port_unlock_irqrestore(uport, flags);
 }
 
 static int dz_encode_baud_rate(unsigned int baud)
@@ -608,7 +608,7 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 	if (termios->c_cflag & CREAD)
 		cflag |= DZ_RXENAB;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
+	uart_port_lock_irqsave(&dport->port, &flags);
 
 	uart_update_timeout(uport, termios->c_cflag, baud);
 
@@ -631,7 +631,7 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 	if (termios->c_iflag & IGNBRK)
 		dport->port.ignore_status_mask |= DZ_BREAK;
 
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	uart_port_unlock_irqrestore(&dport->port, flags);
 }
 
 /*
@@ -645,12 +645,12 @@ static void dz_pm(struct uart_port *uport, unsigned int state,
 	struct dz_port *dport = to_dport(uport);
 	unsigned long flags;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
+	uart_port_lock_irqsave(&dport->port, &flags);
 	if (state < 3)
 		dz_start_tx(&dport->port);
 	else
 		dz_stop_tx(&dport->port);
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	uart_port_unlock_irqrestore(&dport->port, flags);
 }
 
 
@@ -811,7 +811,7 @@ static void dz_console_putchar(struct uart_port *uport, unsigned char ch)
 	unsigned short csr, tcr, trdy, mask;
 	int loops = 10000;
 
-	spin_lock_irqsave(&dport->port.lock, flags);
+	uart_port_lock_irqsave(&dport->port, &flags);
 	csr = dz_in(dport, DZ_CSR);
 	dz_out(dport, DZ_CSR, csr & ~DZ_TIE);
 	tcr = dz_in(dport, DZ_TCR);
@@ -819,7 +819,7 @@ static void dz_console_putchar(struct uart_port *uport, unsigned char ch)
 	mask = tcr;
 	dz_out(dport, DZ_TCR, mask);
 	iob();
-	spin_unlock_irqrestore(&dport->port.lock, flags);
+	uart_port_unlock_irqrestore(&dport->port, flags);
 
 	do {
 		trdy = dz_in(dport, DZ_CSR);
-- 
2.39.2

