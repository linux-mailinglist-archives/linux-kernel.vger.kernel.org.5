Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECF297A0D37
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbjINSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241950AbjINSjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C32E26BB;
        Thu, 14 Sep 2023 11:39:01 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xbi6ZcqJKE3YV+23Qffw0pLz0RYvkutvE/pwCYcIpIU=;
        b=guscnvbH3xPwbP+aL/7s3SwmMOkW0zx82BWDQybOxwIoh5gxBCtzLIYRBPTU0J4ImsDnpw
        GCm9uxnJFnABZoJYWtcbcfS+vXjyYR69JgXDNNGeheTxL1KVVYbKARF8yIOPy09GlAmDIZ
        /q3e0pBeZijD4pzizelWQ10mScK0Fg1SM/85C+6j3dm8/gLnsoviyUvU3+SX+mIUUVvT0g
        4saz5zi3uUwuPeiTtz6rsD6Xgklcb3HHCcOX8dk8Wskvk9TA0YlqXf+EVueVOqqj+Lmfsq
        k2Af4BW/P/zw+2ToyhhbsD04/LUKNXzkzNNNpaRGAnC+1+j5zHVZ7CjYWaR9rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xbi6ZcqJKE3YV+23Qffw0pLz0RYvkutvE/pwCYcIpIU=;
        b=tYIvkFmNZnd02WfkkyrFWmB5h3JaSqh5akiZaq7FS7IXkXS/Q5AlBjqElEdr+dGcTigG2f
        nMeUnymk1/5FtFCw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-unisoc@lists.infradead.org
Subject: [PATCH tty v1 50/74] serial: rda: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:07 +0206
Message-Id: <20230914183831.587273-51-john.ogness@linutronix.de>
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
 drivers/tty/serial/rda-uart.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/rda-uart.c b/drivers/tty/serial/rda-uart.c
index be5c842b5ba9..d824c8318f33 100644
--- a/drivers/tty/serial/rda-uart.c
+++ b/drivers/tty/serial/rda-uart.c
@@ -139,12 +139,12 @@ static unsigned int rda_uart_tx_empty(struct uart_port *port)
 	unsigned int ret;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = rda_uart_read(port, RDA_UART_STATUS);
 	ret = (val & RDA_UART_TX_FIFO_MASK) ? TIOCSER_TEMT : 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return ret;
 }
@@ -246,7 +246,7 @@ static void rda_uart_set_termios(struct uart_port *port,
 	unsigned int baud;
 	u32 irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	baud = uart_get_baud_rate(port, termios, old, 9600, port->uartclk / 4);
 	rda_uart_change_baudrate(rda_port, baud);
@@ -325,7 +325,7 @@ static void rda_uart_set_termios(struct uart_port *port,
 	/* update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void rda_uart_send_chars(struct uart_port *port)
@@ -408,7 +408,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 	unsigned long flags;
 	u32 val, irq_mask;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Clear IRQ cause */
 	val = rda_uart_read(port, RDA_UART_IRQ_CAUSE);
@@ -425,7 +425,7 @@ static irqreturn_t rda_interrupt(int irq, void *dev_id)
 		rda_uart_send_chars(port);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -436,16 +436,16 @@ static int rda_uart_startup(struct uart_port *port)
 	int ret;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	ret = request_irq(port->irq, rda_interrupt, IRQF_NO_SUSPEND,
 			  "rda-uart", port);
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = rda_uart_read(port, RDA_UART_CTRL);
 	val |= RDA_UART_ENABLE;
@@ -456,7 +456,7 @@ static int rda_uart_startup(struct uart_port *port)
 	val |= (RDA_UART_RX_DATA_AVAILABLE | RDA_UART_RX_TIMEOUT);
 	rda_uart_write(port, val, RDA_UART_IRQ_MASK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -466,7 +466,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	rda_uart_stop_tx(port);
 	rda_uart_stop_rx(port);
@@ -475,7 +475,7 @@ static void rda_uart_shutdown(struct uart_port *port)
 	val &= ~RDA_UART_ENABLE;
 	rda_uart_write(port, val, RDA_UART_CTRL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *rda_uart_type(struct uart_port *port)
@@ -515,7 +515,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 		rda_uart_request_port(port);
 	}
 
-	spin_lock_irqsave(&port->lock, irq_flags);
+	uart_port_lock_irqsave(port, &irq_flags);
 
 	/* Clear mask, so no surprise interrupts. */
 	rda_uart_write(port, 0, RDA_UART_IRQ_MASK);
@@ -523,7 +523,7 @@ static void rda_uart_config_port(struct uart_port *port, int flags)
 	/* Clear status register */
 	rda_uart_write(port, 0, RDA_UART_STATUS);
 
-	spin_unlock_irqrestore(&port->lock, irq_flags);
+	uart_port_unlock_irqrestore(port, irq_flags);
 }
 
 static void rda_uart_release_port(struct uart_port *port)
@@ -597,9 +597,9 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	if (port->sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
+		locked = uart_port_trylock(port);
 	} else {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		locked = 1;
 	}
 
@@ -615,7 +615,7 @@ static void rda_uart_port_write(struct uart_port *port, const char *s,
 	rda_uart_write(port, old_irq_mask, RDA_UART_IRQ_MASK);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.39.2

