Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D7C7A0D51
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242049AbjINSmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbjINSkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:40:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1A273D;
        Thu, 14 Sep 2023 11:39:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl11dTCkNk9kJggQh18JDsFl9A3lJFdd+BsLFdknlKk=;
        b=rgWz1kP9jIWFi9w2kzGEWAnzKj4zW/p6BeYFI6vujEJ8TJ+n/nI6IcOom31t9SmV3DLIdx
        WH1k4F1QdvyO3cYrSyG04gVzITEWqZP47DwOPix0IdrWKedVLvFYMOp+IgggV9qDydlDob
        tckpucfIskKXLw4JcAWxdbmkSGKvjV4n2VWUGFzFQcv1UGDsrX35tvYAbeNdBWzlmLr+ii
        Bj8YzlbiNrjR5ii9fBhhQhBvUEIWJIRi96nXLCAYEMzDT0B1KxstSgEJiwzYq5SbEv+C0/
        Fc4472IVK1SWMV47S+zt3VCr021TIv7AVPUbfWlXN/kszSxIBA3zoJ4AB7A6Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sl11dTCkNk9kJggQh18JDsFl9A3lJFdd+BsLFdknlKk=;
        b=FZ3tW60IrPICJ5oIIy/x5vlFhq4Em5jHfdSQaSC7grPVsyzX3HcfRr0P3977F4qGUqlY+H
        2iWhKQjmXHTjfiAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Yangtao Li <frank.li@vivo.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH tty v1 62/74] serial: sprd: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:19 +0206
Message-Id: <20230914183831.587273-63-john.ogness@linutronix.de>
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
 drivers/tty/serial/sprd_serial.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index f328fa57231f..f257525f9299 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -247,7 +247,7 @@ static void sprd_complete_tx_dma(void *data)
 	struct circ_buf *xmit = &port->state->xmit;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	dma_unmap_single(port->dev, sp->tx_dma.phys_addr,
 			 sp->tx_dma.trans_len, DMA_TO_DEVICE);
 
@@ -260,7 +260,7 @@ static void sprd_complete_tx_dma(void *data)
 	    sprd_tx_dma_config(port))
 		sp->tx_dma.trans_len = 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int sprd_uart_dma_submit(struct uart_port *port,
@@ -429,13 +429,13 @@ static void sprd_complete_rx_dma(void *data)
 	enum dma_status status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	status = dmaengine_tx_status(sp->rx_dma.chn,
 				     sp->rx_dma.cookie, &state);
 	if (status != DMA_COMPLETE) {
 		sprd_stop_rx(port);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		return;
 	}
 
@@ -449,7 +449,7 @@ static void sprd_complete_rx_dma(void *data)
 	if (sprd_start_dma_rx(port))
 		sprd_stop_rx(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int sprd_start_dma_rx(struct uart_port *port)
@@ -638,12 +638,12 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned int ims;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	ims = serial_in(port, SPRD_IMSR);
 
 	if (!ims) {
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 		return IRQ_NONE;
 	}
 
@@ -660,7 +660,7 @@ static irqreturn_t sprd_handle_irq(int irq, void *dev_id)
 	if (ims & SPRD_IMSR_TX_FIFO_EMPTY)
 		sprd_tx(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -727,13 +727,13 @@ static int sprd_startup(struct uart_port *port)
 	serial_out(port, SPRD_CTL1, fc);
 
 	/* enable interrupt */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	ien = serial_in(port, SPRD_IEN);
 	ien |= SPRD_IEN_BREAK_DETECT | SPRD_IEN_TIMEOUT;
 	if (!sp->rx_dma.enable)
 		ien |= SPRD_IEN_RX_FULL;
 	serial_out(port, SPRD_IEN, ien);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -793,7 +793,7 @@ static void sprd_set_termios(struct uart_port *port, struct ktermios *termios,
 			lcr |= SPRD_LCR_EVEN_PAR;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -837,7 +837,7 @@ static void sprd_set_termios(struct uart_port *port, struct ktermios *termios,
 	fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
 	serial_out(port, SPRD_CTL1, fc);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/* Don't rewrite B0 */
 	if (tty_termios_baud_rate(termios))
@@ -974,9 +974,9 @@ static void sprd_console_write(struct console *co, const char *s,
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	uart_console_write(port, s, count, sprd_console_putchar);
 
@@ -984,7 +984,7 @@ static void sprd_console_write(struct console *co, const char *s,
 	wait_for_xmitr(port);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static int sprd_console_setup(struct console *co, char *options)
-- 
2.39.2

