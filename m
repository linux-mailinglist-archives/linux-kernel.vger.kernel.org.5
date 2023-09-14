Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0519B7A0D48
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbjINSmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241998AbjINSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A0CF2719;
        Thu, 14 Sep 2023 11:39:04 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOwhgnLO7hOBwv7Kh3brBH5G3zRUgo+W3NYhrK110nQ=;
        b=MQF5Uzr7EmKQx14r1E/RhX/umHkyltViumcqQtzYlRu/cdZA5N1RelnJ4iu3xdbYGsublf
        AesvLXS2l1vgjY/3lJjgy3oS9Fa9CNIR9FdCDxd3xGmG0PqFn6mYkcJSIXcskbHkN10xH7
        fjf6/nHuFw7FFrO4gx/WSOB8n7ykjp9NGoMsoeoOBZCgXHT+OEqemMupp1sBuPMJwRsuxf
        nU/nGrLUIfKTsfa4sHRdVUDDytrxtrfa0bYiOJQclsPYDWetbS6woG0hXVe80c083ykC0o
        LnHq5GziKgk/yioSaLz/v2WQTMBmpy3Te2MAeI6u0OokLmagDAUK+U749FyAYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xOwhgnLO7hOBwv7Kh3brBH5G3zRUgo+W3NYhrK110nQ=;
        b=y4UPC3ayiwCpK2wUuae2l5tlzv/vgSHZnGxCpQZEdOHfUE6peDdmI2DaPnIbsoJ+GKOrLW
        l/Me65oUdGiBduAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org
Subject: [PATCH tty v1 56/74] serial: tegra: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:13 +0206
Message-Id: <20230914183831.587273-57-john.ogness@linutronix.de>
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
 drivers/tty/serial/serial-tegra.c | 32 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index d4ec943cb8e9..6d4006b41975 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -411,7 +411,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 		divisor = DIV_ROUND_CLOSEST(rate, baud * 16);
 	}
 
-	spin_lock_irqsave(&tup->uport.lock, flags);
+	uart_port_lock_irqsave(&tup->uport, &flags);
 	lcr = tup->lcr_shadow;
 	lcr |= UART_LCR_DLAB;
 	tegra_uart_write(tup, lcr, UART_LCR);
@@ -424,7 +424,7 @@ static int tegra_set_baudrate(struct tegra_uart_port *tup, unsigned int baud)
 
 	/* Dummy read to ensure the write is posted */
 	tegra_uart_read(tup, UART_SCR);
-	spin_unlock_irqrestore(&tup->uport.lock, flags);
+	uart_port_unlock_irqrestore(&tup->uport, flags);
 
 	tup->current_baud = baud;
 
@@ -522,13 +522,13 @@ static void tegra_uart_tx_dma_complete(void *args)
 	dmaengine_tx_status(tup->tx_dma_chan, tup->tx_cookie, &state);
 	count = tup->tx_bytes_requested - state.residue;
 	async_tx_ack(tup->tx_dma_desc);
-	spin_lock_irqsave(&tup->uport.lock, flags);
+	uart_port_lock_irqsave(&tup->uport, &flags);
 	uart_xmit_advance(&tup->uport, count);
 	tup->tx_in_progress = 0;
 	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
 		uart_write_wakeup(&tup->uport);
 	tegra_uart_start_next_tx(tup);
-	spin_unlock_irqrestore(&tup->uport.lock, flags);
+	uart_port_unlock_irqrestore(&tup->uport, flags);
 }
 
 static int tegra_uart_start_tx_dma(struct tegra_uart_port *tup,
@@ -598,13 +598,13 @@ static unsigned int tegra_uart_tx_empty(struct uart_port *u)
 	unsigned int ret = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&u->lock, flags);
+	uart_port_lock_irqsave(u, &flags);
 	if (!tup->tx_in_progress) {
 		unsigned long lsr = tegra_uart_read(tup, UART_LSR);
 		if ((lsr & TX_EMPTY_STATUS) == TX_EMPTY_STATUS)
 			ret = TIOCSER_TEMT;
 	}
-	spin_unlock_irqrestore(&u->lock, flags);
+	uart_port_unlock_irqrestore(u, flags);
 	return ret;
 }
 
@@ -727,7 +727,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 	struct dma_tx_state state;
 	enum dma_status status;
 
-	spin_lock_irqsave(&u->lock, flags);
+	uart_port_lock_irqsave(u, &flags);
 
 	status = dmaengine_tx_status(tup->rx_dma_chan, tup->rx_cookie, &state);
 
@@ -749,7 +749,7 @@ static void tegra_uart_rx_dma_complete(void *args)
 		set_rts(tup, true);
 
 done:
-	spin_unlock_irqrestore(&u->lock, flags);
+	uart_port_unlock_irqrestore(u, flags);
 }
 
 static void tegra_uart_terminate_rx_dma(struct tegra_uart_port *tup)
@@ -836,7 +836,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 	bool is_rx_int = false;
 	unsigned long flags;
 
-	spin_lock_irqsave(&u->lock, flags);
+	uart_port_lock_irqsave(u, &flags);
 	while (1) {
 		iir = tegra_uart_read(tup, UART_IIR);
 		if (iir & UART_IIR_NO_INT) {
@@ -852,7 +852,7 @@ static irqreturn_t tegra_uart_isr(int irq, void *data)
 			} else if (is_rx_start) {
 				tegra_uart_start_rx_dma(tup);
 			}
-			spin_unlock_irqrestore(&u->lock, flags);
+			uart_port_unlock_irqrestore(u, flags);
 			return IRQ_HANDLED;
 		}
 
@@ -969,11 +969,11 @@ static void tegra_uart_hw_deinit(struct tegra_uart_port *tup)
 		}
 	}
 
-	spin_lock_irqsave(&tup->uport.lock, flags);
+	uart_port_lock_irqsave(&tup->uport, &flags);
 	/* Reset the Rx and Tx FIFOs */
 	tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_XMIT | UART_FCR_CLEAR_RCVR);
 	tup->current_baud = 0;
-	spin_unlock_irqrestore(&tup->uport.lock, flags);
+	uart_port_unlock_irqrestore(&tup->uport, flags);
 
 	tup->rx_in_progress = 0;
 	tup->tx_in_progress = 0;
@@ -1292,7 +1292,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	int ret;
 
 	max_divider *= 16;
-	spin_lock_irqsave(&u->lock, flags);
+	uart_port_lock_irqsave(u, &flags);
 
 	/* Changing configuration, it is safe to stop any rx now */
 	if (tup->rts_active)
@@ -1341,7 +1341,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	baud = uart_get_baud_rate(u, termios, oldtermios,
 			parent_clk_rate/max_divider,
 			parent_clk_rate/16);
-	spin_unlock_irqrestore(&u->lock, flags);
+	uart_port_unlock_irqrestore(u, flags);
 	ret = tegra_set_baudrate(tup, baud);
 	if (ret < 0) {
 		dev_err(tup->uport.dev, "Failed to set baud rate\n");
@@ -1349,7 +1349,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	}
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
-	spin_lock_irqsave(&u->lock, flags);
+	uart_port_lock_irqsave(u, &flags);
 
 	/* Flow control */
 	if (termios->c_cflag & CRTSCTS)	{
@@ -1382,7 +1382,7 @@ static void tegra_uart_set_termios(struct uart_port *u,
 	if (termios->c_iflag & IGNBRK)
 		tup->uport.ignore_status_mask |= UART_LSR_BI;
 
-	spin_unlock_irqrestore(&u->lock, flags);
+	uart_port_unlock_irqrestore(u, flags);
 }
 
 static const char *tegra_uart_type(struct uart_port *u)
-- 
2.39.2

