Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBA7A0CEE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241854AbjINSjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241583AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355011FFF;
        Thu, 14 Sep 2023 11:38:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAr+aerifH023DidMwRy+ZYEUlrEnoz+OKihpPaW8nY=;
        b=ZBWN6bAoEsMIvv5W/jJ4EDfSl1dAC/OB5iblurdwDq8y0V7TbVWjf2XA/c934aAhcqz7bX
        byZ8vNKtfniaAThga7tGBMzSrYDGGxOGBuFoWsEsm218ceQFjCnQlOg9F5FilAX/+nj4Gk
        CEPinnAsgI3jlIaNd6DqHAROHBxgMbSGy61tdtrcgGThrUN4Bcvwc2I0/qgghDnUkBdBsb
        pjAJ84TurSEF2Oa6YZKazyE1OFY+s4LDvJxNBJQT+/IQ28IDBHdznoZ0gvqeaXTK99iy79
        y/U/R2d49md0291fX9gxXYTKFP+5gHzfokS3EyeEfD7K2mEJ7A0mD+0VRtD5Ig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAr+aerifH023DidMwRy+ZYEUlrEnoz+OKihpPaW8nY=;
        b=vZunDEtB8skEixyIq4H1PIQQ1sq3NsaEoWeGUy3NEJjvv7DKOIq0BFIRwXGuDj/yi5iiPY
        I/fydBcCbGkj14Ag==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH tty v1 12/74] serial: 8250_omap: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:29 +0206
Message-Id: <20230914183831.587273-13-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_omap.c | 52 ++++++++++++++---------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
index 26dd089d8e82..9ea38e2a6e23 100644
--- a/drivers/tty/serial/8250/8250_omap.c
+++ b/drivers/tty/serial/8250/8250_omap.c
@@ -401,7 +401,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	 * interrupts disabled.
 	 */
 	pm_runtime_get_sync(port->dev);
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 
 	/*
 	 * Update the per-port timeout.
@@ -504,7 +504,7 @@ static void omap_8250_set_termios(struct uart_port *port,
 	}
 	omap8250_restore_regs(up);
 
-	spin_unlock_irq(&up->port.lock);
+	uart_port_unlock_irq(&up->port);
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
 
@@ -529,7 +529,7 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	pm_runtime_get_sync(port->dev);
 
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 
 	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
 	efr = serial_in(up, UART_EFR);
@@ -541,7 +541,7 @@ static void omap_8250_pm(struct uart_port *port, unsigned int state,
 	serial_out(up, UART_EFR, efr);
 	serial_out(up, UART_LCR, 0);
 
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
@@ -660,7 +660,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 		unsigned long delay;
 
 		/* Synchronize UART_IER access against the console. */
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		up->ier = port->serial_in(port, UART_IER);
 		if (up->ier & (UART_IER_RLSI | UART_IER_RDI)) {
 			port->ops->stop_rx(port);
@@ -670,7 +670,7 @@ static irqreturn_t omap8250_irq(int irq, void *dev_id)
 			 */
 			cancel_delayed_work(&up->overrun_backoff);
 		}
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 		delay = msecs_to_jiffies(up->overrun_backoff_time_ms);
 		schedule_delayed_work(&up->overrun_backoff, delay);
@@ -717,10 +717,10 @@ static int omap_8250_startup(struct uart_port *port)
 	}
 
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	up->ier = UART_IER_RLSI | UART_IER_RDI;
 	serial_out(up, UART_IER, up->ier);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 
 #ifdef CONFIG_PM
 	up->capabilities |= UART_CAP_RPM;
@@ -733,9 +733,9 @@ static int omap_8250_startup(struct uart_port *port)
 	serial_out(up, UART_OMAP_WER, priv->wer);
 
 	if (up->dma && !(priv->habit & UART_HAS_EFR2)) {
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		up->dma->rx_dma(up);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	}
 
 	enable_irq(up->port.irq);
@@ -761,10 +761,10 @@ static void omap_8250_shutdown(struct uart_port *port)
 		serial_out(up, UART_OMAP_EFR2, 0x0);
 
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	up->ier = 0;
 	serial_out(up, UART_IER, 0);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 	disable_irq_nosync(up->port.irq);
 	dev_pm_clear_wake_irq(port->dev);
 
@@ -789,10 +789,10 @@ static void omap_8250_throttle(struct uart_port *port)
 
 	pm_runtime_get_sync(port->dev);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	port->ops->stop_rx(port);
 	priv->throttled = true;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
@@ -807,14 +807,14 @@ static void omap_8250_unthrottle(struct uart_port *port)
 	pm_runtime_get_sync(port->dev);
 
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	priv->throttled = false;
 	if (up->dma)
 		up->dma->rx_dma(up);
 	up->ier |= UART_IER_RLSI | UART_IER_RDI;
 	port->read_status_mask |= UART_LSR_DR;
 	serial_out(up, UART_IER, up->ier);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	pm_runtime_mark_last_busy(port->dev);
 	pm_runtime_put_autosuspend(port->dev);
@@ -958,7 +958,7 @@ static void __dma_rx_complete(void *param)
 	unsigned long flags;
 
 	/* Synchronize UART_IER access against the console. */
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 
 	/*
 	 * If the tx status is not DMA_COMPLETE, then this is a delayed
@@ -967,7 +967,7 @@ static void __dma_rx_complete(void *param)
 	 */
 	if (dmaengine_tx_status(dma->rxchan, dma->rx_cookie, &state) !=
 			DMA_COMPLETE) {
-		spin_unlock_irqrestore(&p->port.lock, flags);
+		uart_port_unlock_irqrestore(&p->port, flags);
 		return;
 	}
 	__dma_rx_do_complete(p);
@@ -978,7 +978,7 @@ static void __dma_rx_complete(void *param)
 			omap_8250_rx_dma(p);
 	}
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static void omap_8250_rx_dma_flush(struct uart_8250_port *p)
@@ -1083,7 +1083,7 @@ static void omap_8250_dma_tx_complete(void *param)
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 
 	dma->tx_running = 0;
 
@@ -1112,7 +1112,7 @@ static void omap_8250_dma_tx_complete(void *param)
 		serial8250_set_THRI(p);
 	}
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static int omap_8250_tx_dma(struct uart_8250_port *p)
@@ -1278,7 +1278,7 @@ static int omap_8250_dma_handle_irq(struct uart_port *port)
 		return IRQ_HANDLED;
 	}
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	status = serial_port_in(port, UART_LSR);
 
@@ -1761,15 +1761,15 @@ static int omap8250_runtime_resume(struct device *dev)
 		up = serial8250_get_port(priv->line);
 
 	if (up && omap8250_lost_context(up)) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port);
 		omap8250_restore_regs(up);
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port);
 	}
 
 	if (up && up->dma && up->dma->rxchan && !(priv->habit & UART_HAS_EFR2)) {
-		spin_lock_irq(&up->port.lock);
+		uart_port_lock_irq(&up->port);
 		omap_8250_rx_dma(up);
-		spin_unlock_irq(&up->port.lock);
+		uart_port_unlock_irq(&up->port);
 	}
 
 	priv->latency = priv->calc_latency;
-- 
2.39.2

