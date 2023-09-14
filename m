Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDE57A0D00
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241929AbjINSjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241654AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2902F2109;
        Thu, 14 Sep 2023 11:38:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGc9UCfp+vVEkunrrx4DZaVv0r5LexBlmCt7ramoht0=;
        b=hQSifniX2fTAxMhCkE1pqXlYGBR1xVgb9R+ito3n5qonTdAPSIFcljagweqMvuukvEvtV3
        YQTpN5HAzEyJ/qRDAMcvlisf03CQJKG6vMxvuW71b0W7VlYumBJWpuiYm0jjmOBMekvkR8
        dS7bP5XzSohOLnPeOdBxYbH/MQsT6QIm4T/D1BnoY+YFl7ZAcRRFvfS7+EhYdzGdOhtjma
        s2wmPcEtsF/CsNktfd4GvN3VrlUodBPcU13rWoDuvMj+zZFUFti0vJYaDWYIAVluSvmdAO
        gp0/YuV2L55Wf4fdfjw+yWbJ4QxFtHJo4B5azRKXtNz0sJIbWQkHgtzGTh+bjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cGc9UCfp+vVEkunrrx4DZaVv0r5LexBlmCt7ramoht0=;
        b=8k/J+MqCVQhlhcnsuAIy5Q0/bh0afZbT4cuh43shtvv5GLvAolZfZlDw+CxZtsMBCHHS/I
        xWimy30q+dXLKpAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hongyu Xie <xiehongyu1@kylinos.cn>,
        Jiamei Xie <jiamei.xie@arm.com>,
        Tobias Klauser <tklauser@distanz.ch>,
        Rob Herring <robh@kernel.org>, delisun <delisun@pateo.com.cn>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH tty v1 17/74] serial: amba-pl011: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:34 +0206
Message-Id: <20230914183831.587273-18-john.ogness@linutronix.de>
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
 drivers/tty/serial/amba-pl011.c | 72 ++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 3dc9b0fcab1c..41eabad4c94b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -345,9 +345,9 @@ static int pl011_fifo_to_tty(struct uart_amba_port *uap)
 				flag = TTY_FRAME;
 		}
 
-		spin_unlock(&uap->port.lock);
+		uart_port_unlock(&uap->port);
 		sysrq = uart_handle_sysrq_char(&uap->port, ch & 255);
-		spin_lock(&uap->port.lock);
+		uart_port_lock(&uap->port);
 
 		if (!sysrq)
 			uart_insert_char(&uap->port, ch, UART011_DR_OE, ch, flag);
@@ -550,7 +550,7 @@ static void pl011_dma_tx_callback(void *data)
 	unsigned long flags;
 	u16 dmacr;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	if (uap->dmatx.queued)
 		dma_unmap_sg(dmatx->chan->device->dev, &dmatx->sg, 1,
 			     DMA_TO_DEVICE);
@@ -571,7 +571,7 @@ static void pl011_dma_tx_callback(void *data)
 	if (!(dmacr & UART011_TXDMAE) || uart_tx_stopped(&uap->port) ||
 	    uart_circ_empty(&uap->port.state->xmit)) {
 		uap->dmatx.queued = false;
-		spin_unlock_irqrestore(&uap->port.lock, flags);
+		uart_port_unlock_irqrestore(&uap->port, flags);
 		return;
 	}
 
@@ -582,7 +582,7 @@ static void pl011_dma_tx_callback(void *data)
 		 */
 		pl011_start_tx_pio(uap);
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 /*
@@ -1009,7 +1009,7 @@ static void pl011_dma_rx_callback(void *data)
 	 * routine to flush out the secondary DMA buffer while
 	 * we immediately trigger the next DMA job.
 	 */
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	/*
 	 * Rx data can be taken by the UART interrupts during
 	 * the DMA irq handler. So we check the residue here.
@@ -1025,7 +1025,7 @@ static void pl011_dma_rx_callback(void *data)
 	ret = pl011_dma_rx_trigger_dma(uap);
 
 	pl011_dma_rx_chars(uap, pending, lastbuf, false);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 	/*
 	 * Do this check after we picked the DMA chars so we don't
 	 * get some IRQ immediately from RX.
@@ -1091,11 +1091,11 @@ static void pl011_dma_rx_poll(struct timer_list *t)
 	if (jiffies_to_msecs(jiffies - dmarx->last_jiffies)
 			> uap->dmarx.poll_timeout) {
 
-		spin_lock_irqsave(&uap->port.lock, flags);
+		uart_port_lock_irqsave(&uap->port, &flags);
 		pl011_dma_rx_stop(uap);
 		uap->im |= UART011_RXIM;
 		pl011_write(uap->im, uap, REG_IMSC);
-		spin_unlock_irqrestore(&uap->port.lock, flags);
+		uart_port_unlock_irqrestore(&uap->port, flags);
 
 		uap->dmarx.running = false;
 		dmaengine_terminate_all(rxchan);
@@ -1191,10 +1191,10 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
 		cpu_relax();
 
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	uap->dmacr &= ~(UART011_DMAONERR | UART011_RXDMAE | UART011_TXDMAE);
 	pl011_write(uap->dmacr, uap, REG_DMACR);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	if (uap->using_tx_dma) {
 		/* In theory, this should already be done by pl011_dma_flush_buffer */
@@ -1374,9 +1374,9 @@ static void pl011_throttle_rx(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	pl011_stop_rx(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void pl011_enable_ms(struct uart_port *port)
@@ -1394,7 +1394,7 @@ __acquires(&uap->port.lock)
 {
 	pl011_fifo_to_tty(uap);
 
-	spin_unlock(&uap->port.lock);
+	uart_port_unlock(&uap->port);
 	tty_flip_buffer_push(&uap->port.state->port);
 	/*
 	 * If we were temporarily out of DMA mode for a while,
@@ -1419,7 +1419,7 @@ __acquires(&uap->port.lock)
 #endif
 		}
 	}
-	spin_lock(&uap->port.lock);
+	uart_port_lock(&uap->port);
 }
 
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c,
@@ -1555,7 +1555,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	status = pl011_read(uap, REG_RIS) & uap->im;
 	if (status) {
 		do {
@@ -1585,7 +1585,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		handled = 1;
 	}
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 
 	return IRQ_RETVAL(handled);
 }
@@ -1657,14 +1657,14 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int lcr_h;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 	lcr_h = pl011_read(uap, REG_LCRH_TX);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
 	pl011_write(lcr_h, uap, REG_LCRH_TX);
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -1803,7 +1803,7 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	unsigned long flags;
 	unsigned int i;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
@@ -1825,7 +1825,7 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
 	pl011_write(uap->im, uap, REG_IMSC);
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 static void pl011_unthrottle_rx(struct uart_port *port)
@@ -1833,7 +1833,7 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 	struct uart_amba_port *uap = container_of(port, struct uart_amba_port, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&uap->port.lock, flags);
+	uart_port_lock_irqsave(&uap->port, &flags);
 
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
@@ -1841,7 +1841,7 @@ static void pl011_unthrottle_rx(struct uart_port *port)
 
 	pl011_write(uap->im, uap, REG_IMSC);
 
-	spin_unlock_irqrestore(&uap->port.lock, flags);
+	uart_port_unlock_irqrestore(&uap->port, flags);
 }
 
 static int pl011_startup(struct uart_port *port)
@@ -1861,7 +1861,7 @@ static int pl011_startup(struct uart_port *port)
 
 	pl011_write(uap->vendor->ifls, uap, REG_IFLS);
 
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 
 	cr = pl011_read(uap, REG_CR);
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
@@ -1872,7 +1872,7 @@ static int pl011_startup(struct uart_port *port)
 
 	pl011_write(cr, uap, REG_CR);
 
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	/*
 	 * initialise the old status of the modem signals
@@ -1933,12 +1933,12 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 	unsigned int cr;
 
 	uap->port.status &= ~(UPSTAT_AUTOCTS | UPSTAT_AUTORTS);
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 	cr = pl011_read(uap, REG_CR);
 	cr &= UART011_CR_RTS | UART011_CR_DTR;
 	cr |= UART01x_CR_UARTEN | UART011_CR_TXE;
 	pl011_write(cr, uap, REG_CR);
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 
 	/*
 	 * disable break condition and fifos
@@ -1950,14 +1950,14 @@ static void pl011_disable_uart(struct uart_amba_port *uap)
 
 static void pl011_disable_interrupts(struct uart_amba_port *uap)
 {
-	spin_lock_irq(&uap->port.lock);
+	uart_port_lock_irq(&uap->port);
 
 	/* mask all interrupts and clear all pending ones */
 	uap->im = 0;
 	pl011_write(uap->im, uap, REG_IMSC);
 	pl011_write(0xffff, uap, REG_ICR);
 
-	spin_unlock_irq(&uap->port.lock);
+	uart_port_unlock_irq(&uap->port);
 }
 
 static void pl011_shutdown(struct uart_port *port)
@@ -2102,7 +2102,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	bits = tty_get_frame_size(termios->c_cflag);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -2176,7 +2176,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	old_cr |= UART011_CR_RXE;
 	pl011_write(old_cr, uap, REG_CR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void
@@ -2194,10 +2194,10 @@ sbsa_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	termios->c_cflag &= ~(CMSPAR | CRTSCTS);
 	termios->c_cflag |= CS8 | CLOCAL;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_update_timeout(port, CS8, uap->fixed_baud);
 	pl011_setup_status_masks(port, termios);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *pl011_type(struct uart_port *port)
@@ -2336,9 +2336,9 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	if (uap->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&uap->port.lock);
+		locked = uart_port_trylock(&uap->port);
 	else
-		spin_lock(&uap->port.lock);
+		uart_port_lock(&uap->port);
 
 	/*
 	 *	First save the CR then disable the interrupts
@@ -2364,7 +2364,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 		pl011_write(old_cr, uap, REG_CR);
 
 	if (locked)
-		spin_unlock(&uap->port.lock);
+		uart_port_unlock(&uap->port);
 	local_irq_restore(flags);
 
 	clk_disable(uap->clk);
-- 
2.39.2

