Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 750D97A0D55
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242087AbjINSm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241802AbjINSlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:41:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC912D5E;
        Thu, 14 Sep 2023 11:39:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKeNVbVjwksjd/VmSoAQYxVaHBv/5OG3sedFCpkRsng=;
        b=Zok7KIO1sf2sQrUBxCpReXcwNgovJJo3TQk9Va9ngMmNG3AryHhetikJI0GCmiS+5HryWM
        AQHRLPaFun5eJ+1hJABISNGyFPW2fywbBD7kfDu3ve3eTRBPmNoqKRqO3OAWanzuGraGk5
        9bGD1E29Dfc/2gwzF1I2fyHss5YgnYj8SKem1Pj/SBu7hP7Zg96e19xdHVz+vobiJbb7Bw
        VwFXMtIbnnB4ROptIVv0X+93m71RN4tqVNHSBSdqPq1h73JiN2aMmBfhsQ+sdplfVWA+df
        vz/jdhf3G3YrtGlW4K4ySs6U9U1ncrkzc+y+SH2Yx2xLPu/osSaFASFu0J3OIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKeNVbVjwksjd/VmSoAQYxVaHBv/5OG3sedFCpkRsng=;
        b=o/uWRXq66VfgPaYRNsiMb5R1jUXjAc5caA9+Borc2nbah4BDfr9H2FCygUY0QSd0kIIvbX
        gzCljlqN20TtNfAg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Valentin Caron <valentin.caron@foss.st.com>,
        Marek Vasut <marex@denx.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Lukas Wunner <lukas@wunner.de>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 64/74] serial: stm32: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:21 +0206
Message-Id: <20230914183831.587273-65-john.ogness@linutronix.de>
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
 drivers/tty/serial/stm32-usart.c | 38 ++++++++++++++++----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/stm32-usart.c b/drivers/tty/serial/stm32-usart.c
index 5e9cf0c48813..8c51ec9433d6 100644
--- a/drivers/tty/serial/stm32-usart.c
+++ b/drivers/tty/serial/stm32-usart.c
@@ -537,7 +537,7 @@ static void stm32_usart_rx_dma_complete(void *arg)
 	unsigned int size;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	size = stm32_usart_receive_chars(port, false);
 	uart_unlock_and_check_sysrq_irqrestore(port, flags);
 	if (size)
@@ -643,9 +643,9 @@ static void stm32_usart_tx_dma_complete(void *arg)
 	stm32_usart_tx_dma_terminate(stm32port);
 
 	/* Let's see if we have pending data to send */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	stm32_usart_transmit_chars(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void stm32_usart_tx_interrupt_enable(struct uart_port *port)
@@ -889,7 +889,7 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	if (!stm32_port->throttled) {
 		if (((sr & USART_SR_RXNE) && !stm32_usart_rx_dma_started(stm32_port)) ||
 		    ((sr & USART_SR_ERR_MASK) && stm32_usart_rx_dma_started(stm32_port))) {
-			spin_lock(&port->lock);
+			uart_port_lock(port);
 			size = stm32_usart_receive_chars(port, false);
 			uart_unlock_and_check_sysrq(port);
 			if (size)
@@ -898,14 +898,14 @@ static irqreturn_t stm32_usart_interrupt(int irq, void *ptr)
 	}
 
 	if ((sr & USART_SR_TXE) && !(stm32_port->tx_ch)) {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		stm32_usart_transmit_chars(port);
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 	}
 
 	/* Receiver timeout irq for DMA RX */
 	if (stm32_usart_rx_dma_started(stm32_port) && !stm32_port->throttled) {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		size = stm32_usart_receive_chars(port, false);
 		uart_unlock_and_check_sysrq(port);
 		if (size)
@@ -993,7 +993,7 @@ static void stm32_usart_throttle(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Pause DMA transfer, so the RX data gets queued into the FIFO.
@@ -1006,7 +1006,7 @@ static void stm32_usart_throttle(struct uart_port *port)
 		stm32_usart_clr_bits(port, ofs->cr3, stm32_port->cr3_irq);
 
 	stm32_port->throttled = true;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* Unthrottle the remote, the input buffer can now accept data. */
@@ -1016,7 +1016,7 @@ static void stm32_usart_unthrottle(struct uart_port *port)
 	const struct stm32_usart_offsets *ofs = &stm32_port->info->ofs;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	stm32_usart_set_bits(port, ofs->cr1, stm32_port->cr1_irq);
 	if (stm32_port->cr3_irq)
 		stm32_usart_set_bits(port, ofs->cr3, stm32_port->cr3_irq);
@@ -1030,7 +1030,7 @@ static void stm32_usart_unthrottle(struct uart_port *port)
 	if (stm32_port->rx_ch)
 		stm32_usart_rx_dma_start_or_resume(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /* Receive stop */
@@ -1158,7 +1158,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 8);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ret = readl_relaxed_poll_timeout_atomic(port->membase + ofs->isr,
 						isr,
@@ -1349,7 +1349,7 @@ static void stm32_usart_set_termios(struct uart_port *port,
 	writel_relaxed(cr1, port->membase + ofs->cr1);
 
 	stm32_usart_set_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Handle modem control interrupts */
 	if (UART_ENABLE_MS(port, termios->c_cflag))
@@ -1399,9 +1399,9 @@ static void stm32_usart_pm(struct uart_port *port, unsigned int state,
 		pm_runtime_get_sync(port->dev);
 		break;
 	case UART_PM_STATE_OFF:
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		stm32_usart_clr_bits(port, ofs->cr1, BIT(cfg->uart_enable_bit));
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		pm_runtime_put_sync(port->dev);
 		break;
 	}
@@ -1884,9 +1884,9 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	/* Save and disable interrupts, enable the transmitter */
 	old_cr1 = readl_relaxed(port->membase + ofs->cr1);
@@ -1900,7 +1900,7 @@ static void stm32_usart_console_write(struct console *co, const char *s,
 	writel_relaxed(old_cr1, port->membase + ofs->cr1);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static int stm32_usart_console_setup(struct console *co, char *options)
@@ -2035,7 +2035,7 @@ static int __maybe_unused stm32_usart_serial_en_wakeup(struct uart_port *port,
 		 * low-power mode.
 		 */
 		if (stm32_port->rx_ch) {
-			spin_lock_irqsave(&port->lock, flags);
+			uart_port_lock_irqsave(port, &flags);
 			/* Poll data from DMA RX buffer if any */
 			if (!stm32_usart_rx_dma_pause(stm32_port))
 				size += stm32_usart_receive_chars(port, true);
-- 
2.39.2

