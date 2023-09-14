Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D05E7A0D38
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbjINSli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241918AbjINSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92DB2701;
        Thu, 14 Sep 2023 11:39:01 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEqDaVJQVqGX9YVn2BD87JacVQ7J8Oaoh/OqCs9R0Bw=;
        b=M8E4l2ZSQCM+fzelBT40soSJQ49RE94oh76LR7unQ9Qr0D1BTamTJxsfaxIOrIyKsXqM4Q
        TZnzsgOR+e4jrE3czEBVY62d/bvRppdl/gMx1sZMzfhbJGm8ZD99i9YBq2wUB1FEMKug58
        yEx4CnYWkntZEq66h9/jYqXVrpAOIVAAAFH2813wX+XmjlPWeQLOsmD29taNXz8+KmOS8y
        nKkXYxhsFzW9HpzVfZfzZ3huMy2RbFAb9ulGkycMpoOGPsUKY9rLN8sI+2PmvU1oxhglLy
        xttwahzwecqnnG5T4YCPFNyQucl9GVL7HK9hol4BmmUg5u7QjTwjiQZH1IRxnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEqDaVJQVqGX9YVn2BD87JacVQ7J8Oaoh/OqCs9R0Bw=;
        b=481xDhaTxt22pkHVkWf5eB+vMa1cJVph7J/xdQcvkLU87hhOwi8Og7JNujmxumwgWas9+5
        p8Uaq4O5e8uTatBA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Kevin Cernekee <cernekee@gmail.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Thierry Reding <treding@nvidia.com>,
        Richard GENOUD <richard.genoud@gmail.com>
Subject: [PATCH tty v1 51/74] serial: rp2: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:08 +0206
Message-Id: <20230914183831.587273-52-john.ogness@linutronix.de>
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
 drivers/tty/serial/rp2.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index de220ac8ca54..d46a81cddfcd 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -276,9 +276,9 @@ static unsigned int rp2_uart_tx_empty(struct uart_port *port)
 	 * But the TXEMPTY bit doesn't seem to work unless the TX IRQ is
 	 * enabled.
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	tx_fifo_bytes = readw(up->base + RP2_TX_FIFO_COUNT);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return tx_fifo_bytes ? 0 : TIOCSER_TEMT;
 }
@@ -323,10 +323,10 @@ static void rp2_uart_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	rp2_rmw(port_to_up(port), RP2_TXRX_CTL, RP2_TXRX_CTL_BREAK_m,
 		break_state ? RP2_TXRX_CTL_BREAK_m : 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void rp2_uart_enable_ms(struct uart_port *port)
@@ -383,7 +383,7 @@ static void rp2_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	if (tty_termios_baud_rate(new))
 		tty_termios_encode_baud_rate(new, baud, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* ignore all characters if CREAD is not set */
 	port->ignore_status_mask = (new->c_cflag & CREAD) ? 0 : RP2_DUMMY_READ;
@@ -391,7 +391,7 @@ static void rp2_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	__rp2_uart_set_termios(up, new->c_cflag, new->c_iflag, baud_div);
 	uart_update_timeout(port, new->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void rp2_rx_chars(struct rp2_uart_port *up)
@@ -440,7 +440,7 @@ static void rp2_ch_interrupt(struct rp2_uart_port *up)
 {
 	u32 status;
 
-	spin_lock(&up->port.lock);
+	uart_port_lock(&up->port);
 
 	/*
 	 * The IRQ status bits are clear-on-write.  Other status bits in
@@ -456,7 +456,7 @@ static void rp2_ch_interrupt(struct rp2_uart_port *up)
 	if (status & RP2_CHAN_STAT_MS_CHANGED_MASK)
 		wake_up_interruptible(&up->port.state->port.delta_msr_wait);
 
-	spin_unlock(&up->port.lock);
+	uart_port_unlock(&up->port);
 }
 
 static int rp2_asic_interrupt(struct rp2_card *card, unsigned int asic_id)
@@ -516,10 +516,10 @@ static void rp2_uart_shutdown(struct uart_port *port)
 
 	rp2_uart_break_ctl(port, 0);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	rp2_mask_ch_irq(up, up->idx, 0);
 	rp2_rmw(up, RP2_CHAN_STAT, 0, 0);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *rp2_uart_type(struct uart_port *port)
-- 
2.39.2

