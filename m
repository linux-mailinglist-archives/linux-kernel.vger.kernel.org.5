Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE67A0D12
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242009AbjINSkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241762AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0C212C;
        Thu, 14 Sep 2023 11:38:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dWyZArXLuwNKhH3CiBToeEwUY+mI4MenFw8MF0ZHBA=;
        b=dwibDkJFXaxKsHlR3xKkhSnaJoDgHloNqLwJEaLzC/cnrsjxq+xIqruqJYuP3abMSNz0eh
        RIY8pcnT6W4HfUqBYbtt8hwyCoKVeaw8s9E/ZwBGVBw0tfFs/KNvxv2uztBXsCDcmXJAjl
        /SYQAJbo03EtwRvsx0OQrtpmIyz8UIsdf5YfHIuaVM2UtQ8ZHn95pMSo+n5VZwpwnFkaBT
        W3mLESyGzLi5sVxhuw35O5IEmKjPDHipy/ZDxZnLaveZkDPLmWMR2ghF/KLcfGEC5XQUOl
        rp1tAOnNFKZfWu1GSZAz3Oo9bDlrVngtvFnEKPe9gVDaNB1yIWm6kL1hzrdzIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4dWyZArXLuwNKhH3CiBToeEwUY+mI4MenFw8MF0ZHBA=;
        b=JYpK0GSMLil3n6UtKftZcBhEKcmdJ1fNm1J1w7ztTpLwyI8T87WVSx51TsAbU0REBQtwWN
        vnsygyVjzlBPLkDw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Tom Rix <trix@redhat.com>,
        Marek Vasut <marex@denx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 29/74] serial: imx: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:46 +0206
Message-Id: <20230914183831.587273-30-john.ogness@linutronix.de>
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
 drivers/tty/serial/imx.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 42 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13cb78340709..0fb679cdb15e 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -575,7 +575,7 @@ static void imx_uart_dma_tx_callback(void *data)
 	unsigned long flags;
 	u32 ucr1;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
 
@@ -600,7 +600,7 @@ static void imx_uart_dma_tx_callback(void *data)
 		imx_uart_writel(sport, ucr4, UCR4);
 	}
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 /* called with port.lock taken and irqs off */
@@ -766,11 +766,11 @@ static irqreturn_t imx_uart_rtsint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	irqreturn_t ret;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 
 	ret = __imx_uart_rtsint(irq, dev_id);
 
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 
 	return ret;
 }
@@ -779,9 +779,9 @@ static irqreturn_t imx_uart_txint(int irq, void *dev_id)
 {
 	struct imx_port *sport = dev_id;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 	imx_uart_transmit_buffer(sport);
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 	return IRQ_HANDLED;
 }
 
@@ -895,11 +895,11 @@ static irqreturn_t imx_uart_rxint(int irq, void *dev_id)
 	struct imx_port *sport = dev_id;
 	irqreturn_t ret;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 
 	ret = __imx_uart_rxint(irq, dev_id);
 
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 
 	return ret;
 }
@@ -962,7 +962,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 	unsigned int usr1, usr2, ucr1, ucr2, ucr3, ucr4;
 	irqreturn_t ret = IRQ_NONE;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 
 	usr1 = imx_uart_readl(sport, USR1);
 	usr2 = imx_uart_readl(sport, USR2);
@@ -1032,7 +1032,7 @@ static irqreturn_t imx_uart_int(int irq, void *dev_id)
 		ret = IRQ_HANDLED;
 	}
 
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 
 	return ret;
 }
@@ -1115,7 +1115,7 @@ static void imx_uart_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	u32 ucr1;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	ucr1 = imx_uart_readl(sport, UCR1) & ~UCR1_SNDBRK;
 
@@ -1124,7 +1124,7 @@ static void imx_uart_break_ctl(struct uart_port *port, int break_state)
 
 	imx_uart_writel(sport, ucr1, UCR1);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 /*
@@ -1137,9 +1137,9 @@ static void imx_uart_timeout(struct timer_list *t)
 	unsigned long flags;
 
 	if (sport->port.state) {
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 		imx_uart_mctrl_check(sport);
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 
 		mod_timer(&sport->timer, jiffies + MCTRL_TIMEOUT);
 	}
@@ -1169,9 +1169,9 @@ static void imx_uart_dma_rx_callback(void *data)
 	status = dmaengine_tx_status(chan, sport->rx_cookie, &state);
 
 	if (status == DMA_ERROR) {
-		spin_lock(&sport->port.lock);
+		uart_port_lock(&sport->port);
 		imx_uart_clear_rx_errors(sport);
-		spin_unlock(&sport->port.lock);
+		uart_port_unlock(&sport->port);
 		return;
 	}
 
@@ -1200,9 +1200,9 @@ static void imx_uart_dma_rx_callback(void *data)
 		r_bytes = rx_ring->head - rx_ring->tail;
 
 		/* If we received something, check for 0xff flood */
-		spin_lock(&sport->port.lock);
+		uart_port_lock(&sport->port);
 		imx_uart_check_flood(sport, imx_uart_readl(sport, USR2));
-		spin_unlock(&sport->port.lock);
+		uart_port_unlock(&sport->port);
 
 		if (!(sport->port.ignore_status_mask & URXD_DUMMY_READ)) {
 
@@ -1460,7 +1460,7 @@ static int imx_uart_startup(struct uart_port *port)
 	if (!uart_console(port) && imx_uart_dma_init(sport) == 0)
 		dma_is_inited = 1;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	/* Reset fifo's and state machines */
 	imx_uart_soft_reset(sport);
@@ -1533,7 +1533,7 @@ static int imx_uart_startup(struct uart_port *port)
 
 	imx_uart_disable_loopback_rs485(sport);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return 0;
 }
@@ -1558,21 +1558,21 @@ static void imx_uart_shutdown(struct uart_port *port)
 			sport->dma_is_rxing = 0;
 		}
 
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 		imx_uart_stop_tx(port);
 		imx_uart_stop_rx(port);
 		imx_uart_disable_dma(sport);
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 		imx_uart_dma_exit(sport);
 	}
 
 	mctrl_gpio_disable_ms(sport->gpios);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	ucr2 = imx_uart_readl(sport, UCR2);
 	ucr2 &= ~(UCR2_TXEN | UCR2_ATEN);
 	imx_uart_writel(sport, ucr2, UCR2);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	/*
 	 * Stop our timer.
@@ -1583,7 +1583,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	 * Disable all interrupts, port and break condition.
 	 */
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	ucr1 = imx_uart_readl(sport, UCR1);
 	ucr1 &= ~(UCR1_TRDYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_RXDMAEN |
@@ -1605,7 +1605,7 @@ static void imx_uart_shutdown(struct uart_port *port)
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	clk_disable_unprepare(sport->clk_per);
 	clk_disable_unprepare(sport->clk_ipg);
@@ -1668,7 +1668,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 50, port->uartclk / 16);
 	quot = uart_get_divisor(port, baud);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	/*
 	 * Read current UCR2 and save it for future use, then clear all the bits
@@ -1796,7 +1796,7 @@ imx_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		imx_uart_enable_ms(&sport->port);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static const char *imx_uart_type(struct uart_port *port)
@@ -1858,7 +1858,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 
 	imx_uart_setup_ufcr(sport, TXTL_DEFAULT, RXTL_DEFAULT);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	/*
 	 * Be careful about the order of enabling bits here. First enable the
@@ -1886,7 +1886,7 @@ static int imx_uart_poll_init(struct uart_port *port)
 	imx_uart_writel(sport, ucr1 | UCR1_RRDYEN, UCR1);
 	imx_uart_writel(sport, ucr2 | UCR2_ATEN, UCR2);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return 0;
 }
@@ -2005,9 +2005,9 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	if (sport->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&sport->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&sport->port, &flags);
 	else
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 
 	/*
 	 *	First, save UCR1/2/3 and then disable interrupts
@@ -2035,7 +2035,7 @@ imx_uart_console_write(struct console *co, const char *s, unsigned int count)
 	imx_uart_ucrs_restore(sport, &old_ucr);
 
 	if (locked)
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 /*
@@ -2193,10 +2193,10 @@ static enum hrtimer_restart imx_trigger_start_tx(struct hrtimer *t)
 	struct imx_port *sport = container_of(t, struct imx_port, trigger_start_tx);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	if (sport->tx_state == WAIT_AFTER_RTS)
 		imx_uart_start_tx(&sport->port);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -2206,10 +2206,10 @@ static enum hrtimer_restart imx_trigger_stop_tx(struct hrtimer *t)
 	struct imx_port *sport = container_of(t, struct imx_port, trigger_stop_tx);
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	if (sport->tx_state == WAIT_AFTER_SEND)
 		imx_uart_stop_tx(&sport->port);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 
 	return HRTIMER_NORESTART;
 }
@@ -2482,9 +2482,9 @@ static void imx_uart_restore_context(struct imx_port *sport)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	if (!sport->context_saved) {
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 		return;
 	}
 
@@ -2499,7 +2499,7 @@ static void imx_uart_restore_context(struct imx_port *sport)
 	imx_uart_writel(sport, sport->saved_reg[2], UCR3);
 	imx_uart_writel(sport, sport->saved_reg[3], UCR4);
 	sport->context_saved = false;
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static void imx_uart_save_context(struct imx_port *sport)
@@ -2507,7 +2507,7 @@ static void imx_uart_save_context(struct imx_port *sport)
 	unsigned long flags;
 
 	/* Save necessary regs */
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	sport->saved_reg[0] = imx_uart_readl(sport, UCR1);
 	sport->saved_reg[1] = imx_uart_readl(sport, UCR2);
 	sport->saved_reg[2] = imx_uart_readl(sport, UCR3);
@@ -2519,7 +2519,7 @@ static void imx_uart_save_context(struct imx_port *sport)
 	sport->saved_reg[8] = imx_uart_readl(sport, UBMR);
 	sport->saved_reg[9] = imx_uart_readl(sport, IMX21_UTS);
 	sport->context_saved = true;
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static void imx_uart_enable_wakeup(struct imx_port *sport, bool on)
-- 
2.39.2

