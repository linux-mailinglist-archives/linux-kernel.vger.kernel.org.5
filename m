Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 902C07A0CDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbjINSi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241396AbjINSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951AF1FEB;
        Thu, 14 Sep 2023 11:38:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lt5U7bhcPdg54ZjyRgBGpBHomTbVhANlcjrKnJ+8kPw=;
        b=EjjUZZFHZ6JEVqxq3P4LuSHl7TGqgTOROKasaPekDARF8A49stqUSFmsqni7LyXpfAdYK7
        CoqFh/m07XeKuCogjjsrSKzMDMa3snkU3tYDlm6BmNA45xZftvuf8O7GdAeNdLHnAaMyNC
        V9xtj2T6cQeDpuVnLeJbj+CYAOKwAxm526w1yemc7zGSgHftG8j4v2NuhwIBAdhjqXu+uM
        CgE+auOclmQkeboCagqSRFMlYyGQHm46H8sVsqHqWUshGt7HEpGNqRJIbFSEbEScEdjXpG
        A/htA9D3DQtniUYGBpEkCaKVP+IunLMmmA4wQMQzA1BVjwdYi1OZ7wyVrBA3bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lt5U7bhcPdg54ZjyRgBGpBHomTbVhANlcjrKnJ+8kPw=;
        b=EPAqhJ+RFWjFNq1J0uytEfmWnzRpERI45y4ct0hHAnM0cAa51LiN2tTTwocLooVVKkTvuu
        +nWAe6xeREHBzkBw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Al Cooper <alcooperx@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Subject: [PATCH tty v1 05/74] serial: 8250_bcm7271: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:22 +0206
Message-Id: <20230914183831.587273-6-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_bcm7271.c | 28 +++++++++++++-------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_bcm7271.c b/drivers/tty/serial/8250/8250_bcm7271.c
index aa5aff046756..ff0662c68725 100644
--- a/drivers/tty/serial/8250/8250_bcm7271.c
+++ b/drivers/tty/serial/8250/8250_bcm7271.c
@@ -567,7 +567,7 @@ static irqreturn_t brcmuart_isr(int irq, void *dev_id)
 	if (interrupts == 0)
 		return IRQ_NONE;
 
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 
 	/* Clear all interrupts */
 	udma_writel(priv, REGS_DMA_ISR, UDMA_INTR_CLEAR, interrupts);
@@ -581,7 +581,7 @@ static irqreturn_t brcmuart_isr(int irq, void *dev_id)
 	if ((rval | tval) == 0)
 		dev_warn(dev, "Spurious interrupt: 0x%x\n", interrupts);
 
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 	return IRQ_HANDLED;
 }
 
@@ -608,10 +608,10 @@ static int brcmuart_startup(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	up->ier &= ~UART_IER_RDI;
 	serial_port_out(port, UART_IER, up->ier);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 
 	priv->tx_running = false;
 	priv->dma.rx_dma = NULL;
@@ -629,7 +629,7 @@ static void brcmuart_shutdown(struct uart_port *port)
 	struct brcmuart_priv *priv = up->port.private_data;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	priv->shutdown = true;
 	if (priv->dma_enabled) {
 		stop_rx_dma(up);
@@ -645,7 +645,7 @@ static void brcmuart_shutdown(struct uart_port *port)
 	 */
 	up->dma = NULL;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	serial8250_do_shutdown(port);
 }
 
@@ -788,7 +788,7 @@ static int brcmuart_handle_irq(struct uart_port *p)
 	 * interrupt but there is no data ready.
 	 */
 	if (((iir & UART_IIR_ID) == UART_IIR_RX_TIMEOUT) && !(priv->shutdown)) {
-		spin_lock_irqsave(&p->lock, flags);
+		uart_port_lock_irqsave(p, &flags);
 		status = serial_port_in(p, UART_LSR);
 		if ((status & UART_LSR_DR) == 0) {
 
@@ -813,7 +813,7 @@ static int brcmuart_handle_irq(struct uart_port *p)
 
 			handled = 1;
 		}
-		spin_unlock_irqrestore(&p->lock, flags);
+		uart_port_unlock_irqrestore(p, flags);
 		if (handled)
 			return 1;
 	}
@@ -831,7 +831,7 @@ static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
 	if (priv->shutdown)
 		return HRTIMER_NORESTART;
 
-	spin_lock_irqsave(&p->lock, flags);
+	uart_port_lock_irqsave(p, &flags);
 	status = serial_port_in(p, UART_LSR);
 
 	/*
@@ -855,7 +855,7 @@ static enum hrtimer_restart brcmuart_hrtimer_func(struct hrtimer *t)
 		status |= UART_MCR_RTS;
 		serial_port_out(p, UART_MCR, status);
 	}
-	spin_unlock_irqrestore(&p->lock, flags);
+	uart_port_unlock_irqrestore(p, flags);
 	return HRTIMER_NORESTART;
 }
 
@@ -1154,10 +1154,10 @@ static int __maybe_unused brcmuart_suspend(struct device *dev)
 	 * This will prevent resume from enabling RTS before the
 	 *  baud rate has been restored.
 	 */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	priv->saved_mctrl = port->mctrl;
 	port->mctrl &= ~TIOCM_RTS;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	serial8250_suspend_port(priv->line);
 	clk_disable_unprepare(priv->baud_mux_clk);
@@ -1196,10 +1196,10 @@ static int __maybe_unused brcmuart_resume(struct device *dev)
 
 	if (priv->saved_mctrl & TIOCM_RTS) {
 		/* Restore RTS */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		port->mctrl |= TIOCM_RTS;
 		port->ops->set_mctrl(port, port->mctrl);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 
 	return 0;
-- 
2.39.2

