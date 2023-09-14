Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71CEB7A0D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbjINSju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241752AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E37E2101;
        Thu, 14 Sep 2023 11:38:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipnrMGkMfXtAucrTg6CNX21I0VKKw9iDIsUZ6VX3lJI=;
        b=Ed/45K1nO5d/fubvArMFTb1KutTN1nRYHACbAPYM3Xj4T51JiSNUyJaRFVQcBV4QIlcJnl
        6FnhpRQ7p39bvhQyw3gWpNyrlm3unBsMyAwA6asobEoqwxL37DohvDnbA4ivv0sNayq2ks
        2Lr/YHUWMVsDTX3kcbnvhOwC8/QZhyePSKS5hCGlATYgy5YloC1v3q6YTja3eCwZ+m8I4B
        a0AMwtU/eoeztf4qYLK/u39BBCQPtSGRnNffhTaoJcfIL/Z/1ODMSH0BDOUqhDfZPKn65Z
        6xupq9kNMpQ/lpNRm/ruhaLQkA51iJj+dxMc0p9L3DcNAQcYGJIcJRbmcda91A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ipnrMGkMfXtAucrTg6CNX21I0VKKw9iDIsUZ6VX3lJI=;
        b=R7eynNqc+WyUKnxgyl7XrqPIGm/keP6PNu5EwVQypQAK9lNq2RnhFkMTAZgRpQhA75BVpD
        UdMq3pk4m7IJprDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Shenwei Wang <shenwei.wang@nxp.com>
Subject: [PATCH tty v1 27/74] serial: fsl_lpuart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:44 +0206
Message-Id: <20230914183831.587273-28-john.ogness@linutronix.de>
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
 drivers/tty/serial/fsl_lpuart.c | 88 ++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f72e1340b47d..6d0cfb2e86b4 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -532,9 +532,9 @@ static void lpuart_dma_tx_complete(void *arg)
 	struct dma_chan *chan = sport->dma_tx_chan;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	if (!sport->dma_tx_in_progress) {
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 		return;
 	}
 
@@ -543,7 +543,7 @@ static void lpuart_dma_tx_complete(void *arg)
 
 	uart_xmit_advance(&sport->port, sport->dma_tx_bytes);
 	sport->dma_tx_in_progress = false;
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&sport->port);
@@ -553,12 +553,12 @@ static void lpuart_dma_tx_complete(void *arg)
 		return;
 	}
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	if (!lpuart_stopped_or_empty(&sport->port))
 		lpuart_dma_tx(sport);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static dma_addr_t lpuart_dma_datareg_addr(struct lpuart_port *sport)
@@ -651,7 +651,7 @@ static int lpuart_poll_init(struct uart_port *port)
 
 	sport->port.fifosize = 0;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	/* Disable Rx & Tx */
 	writeb(0, sport->port.membase + UARTCR2);
 
@@ -675,7 +675,7 @@ static int lpuart_poll_init(struct uart_port *port)
 
 	/* Enable Rx and Tx */
 	writeb(UARTCR2_RE | UARTCR2_TE, sport->port.membase + UARTCR2);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return 0;
 }
@@ -703,7 +703,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 	sport->port.fifosize = 0;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	/* Disable Rx & Tx */
 	lpuart32_write(&sport->port, 0, UARTCTRL);
@@ -724,7 +724,7 @@ static int lpuart32_poll_init(struct uart_port *port)
 
 	/* Enable Rx and Tx */
 	lpuart32_write(&sport->port, UARTCTRL_RE | UARTCTRL_TE, UARTCTRL);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return 0;
 }
@@ -879,9 +879,9 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
 static void lpuart_txint(struct lpuart_port *sport)
 {
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 	lpuart_transmit_buffer(sport);
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 }
 
 static void lpuart_rxint(struct lpuart_port *sport)
@@ -890,7 +890,7 @@ static void lpuart_rxint(struct lpuart_port *sport)
 	struct tty_port *port = &sport->port.state->port;
 	unsigned char rx, sr;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 
 	while (!(readb(sport->port.membase + UARTSFIFO) & UARTSFIFO_RXEMPT)) {
 		flg = TTY_NORMAL;
@@ -956,9 +956,9 @@ static void lpuart_rxint(struct lpuart_port *sport)
 
 static void lpuart32_txint(struct lpuart_port *sport)
 {
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 	lpuart32_transmit_buffer(sport);
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 }
 
 static void lpuart32_rxint(struct lpuart_port *sport)
@@ -968,7 +968,7 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 	unsigned long rx, sr;
 	bool is_break;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 
 	while (!(lpuart32_read(&sport->port, UARTFIFO) & UARTFIFO_RXEMPT)) {
 		flg = TTY_NORMAL;
@@ -1170,12 +1170,12 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 
 	async_tx_ack(sport->dma_rx_desc);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	dmastat = dmaengine_tx_status(chan, sport->dma_rx_cookie, &state);
 	if (dmastat == DMA_ERROR) {
 		dev_err(sport->port.dev, "Rx DMA transfer failed!\n");
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 		return;
 	}
 
@@ -1244,7 +1244,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	dma_sync_sg_for_device(chan->device->dev, &sport->rx_sgl, 1,
 			       DMA_FROM_DEVICE);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	tty_flip_buffer_push(port);
 	if (!sport->dma_idle_int)
@@ -1335,9 +1335,9 @@ static void lpuart_timer_func(struct timer_list *t)
 		mod_timer(&sport->lpuart_timer,
 			  jiffies + sport->dma_rx_timeout);
 
-	if (spin_trylock_irqsave(&sport->port.lock, flags)) {
+	if (uart_port_trylock_irqsave(&sport->port, &flags)) {
 		sport->last_residue = state.residue;
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 	}
 }
 
@@ -1802,14 +1802,14 @@ static void lpuart_hw_setup(struct lpuart_port *sport)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	lpuart_setup_watermark_enable(sport);
 
 	lpuart_rx_dma_startup(sport);
 	lpuart_tx_dma_startup(sport);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static int lpuart_startup(struct uart_port *port)
@@ -1859,7 +1859,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	lpuart32_hw_disable(sport);
 
@@ -1869,7 +1869,7 @@ static void lpuart32_hw_setup(struct lpuart_port *sport)
 	lpuart32_setup_watermark_enable(sport);
 	lpuart32_configure(sport);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static int lpuart32_startup(struct uart_port *port)
@@ -1932,7 +1932,7 @@ static void lpuart_shutdown(struct uart_port *port)
 	unsigned char temp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* disable Rx/Tx and interrupts */
 	temp = readb(port->membase + UARTCR2);
@@ -1940,7 +1940,7 @@ static void lpuart_shutdown(struct uart_port *port)
 			UARTCR2_TIE | UARTCR2_TCIE | UARTCR2_RIE);
 	writeb(temp, port->membase + UARTCR2);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	lpuart_dma_shutdown(sport);
 }
@@ -1952,7 +1952,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 	unsigned long temp;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* clear status */
 	temp = lpuart32_read(&sport->port, UARTSTAT);
@@ -1969,7 +1969,7 @@ static void lpuart32_shutdown(struct uart_port *port)
 			UARTCTRL_TIE | UARTCTRL_TCIE | UARTCTRL_RIE | UARTCTRL_SBK);
 	lpuart32_write(port, temp, UARTCTRL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	lpuart_dma_shutdown(sport);
 }
@@ -2069,7 +2069,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(&sport->port);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
@@ -2124,7 +2124,7 @@ lpuart_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static void __lpuart32_serial_setbrg(struct uart_port *port,
@@ -2304,7 +2304,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (old && sport->lpuart_dma_rx_use)
 		lpuart_dma_rx_free(&sport->port);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	sport->port.read_status_mask = 0;
 	if (termios->c_iflag & INPCK)
@@ -2359,7 +2359,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 			sport->lpuart_dma_rx_use = false;
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static const char *lpuart_type(struct uart_port *port)
@@ -2477,9 +2477,9 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&sport->port, &flags);
 	else
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 
 	/* first save CR2 and then disable interrupts */
 	cr2 = old_cr2 = readb(sport->port.membase + UARTCR2);
@@ -2495,7 +2495,7 @@ lpuart_console_write(struct console *co, const char *s, unsigned int count)
 	writeb(old_cr2, sport->port.membase + UARTCR2);
 
 	if (locked)
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static void
@@ -2507,9 +2507,9 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&sport->port, &flags);
 	else
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 
 	/* first save CR2 and then disable interrupts */
 	cr = old_cr = lpuart32_read(&sport->port, UARTCTRL);
@@ -2525,7 +2525,7 @@ lpuart32_console_write(struct console *co, const char *s, unsigned int count)
 	lpuart32_write(&sport->port, old_cr, UARTCTRL);
 
 	if (locked)
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 /*
@@ -3089,7 +3089,7 @@ static int lpuart_suspend(struct device *dev)
 	uart_suspend_port(&lpuart_reg, &sport->port);
 
 	if (lpuart_uport_is_active(sport)) {
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 		if (lpuart_is_32(sport)) {
 			/* disable Rx/Tx and interrupts */
 			temp = lpuart32_read(&sport->port, UARTCTRL);
@@ -3101,7 +3101,7 @@ static int lpuart_suspend(struct device *dev)
 			temp &= ~(UARTCR2_TE | UARTCR2_TIE | UARTCR2_TCIE);
 			writeb(temp, sport->port.membase + UARTCR2);
 		}
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 
 		if (sport->lpuart_dma_rx_use) {
 			/*
@@ -3114,7 +3114,7 @@ static int lpuart_suspend(struct device *dev)
 			lpuart_dma_rx_free(&sport->port);
 
 			/* Disable Rx DMA to use UART port as wakeup source */
-			spin_lock_irqsave(&sport->port.lock, flags);
+			uart_port_lock_irqsave(&sport->port, &flags);
 			if (lpuart_is_32(sport)) {
 				temp = lpuart32_read(&sport->port, UARTBAUD);
 				lpuart32_write(&sport->port, temp & ~UARTBAUD_RDMAE,
@@ -3123,11 +3123,11 @@ static int lpuart_suspend(struct device *dev)
 				writeb(readb(sport->port.membase + UARTCR5) &
 				       ~UARTCR5_RDMAS, sport->port.membase + UARTCR5);
 			}
-			spin_unlock_irqrestore(&sport->port.lock, flags);
+			uart_port_unlock_irqrestore(&sport->port, flags);
 		}
 
 		if (sport->lpuart_dma_tx_use) {
-			spin_lock_irqsave(&sport->port.lock, flags);
+			uart_port_lock_irqsave(&sport->port, &flags);
 			if (lpuart_is_32(sport)) {
 				temp = lpuart32_read(&sport->port, UARTBAUD);
 				temp &= ~UARTBAUD_TDMAE;
@@ -3137,7 +3137,7 @@ static int lpuart_suspend(struct device *dev)
 				temp &= ~UARTCR5_TDMAS;
 				writeb(temp, sport->port.membase + UARTCR5);
 			}
-			spin_unlock_irqrestore(&sport->port.lock, flags);
+			uart_port_unlock_irqrestore(&sport->port, flags);
 			sport->dma_tx_in_progress = false;
 			dmaengine_terminate_sync(sport->dma_tx_chan);
 		}
-- 
2.39.2

