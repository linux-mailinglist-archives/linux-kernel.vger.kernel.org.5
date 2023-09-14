Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C527A0D07
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241962AbjINSjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241675AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03E72115;
        Thu, 14 Sep 2023 11:38:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7D9LsjqZuZo5dBqqfv/ExL4revQqVd4yA1Xdog29cQ=;
        b=eDObBDkcYp97Vikc2x/bBgVaipIN82wI+Nuxdvnn0VQ5FmGbVViHzrJviSZS3c25s+4h+o
        642QV53qKfKLNBrjn6a+eNzVD1LPnjU0sW39bfdFCMwBwgBG9fdOCZLCzKcUriqCWjqwbh
        BeAHFIXIldQIEPNy4vHBC7/h1V5LisXKjDGO7I7VdtzhYYL0/AP/0QLTq+Qj2bsqtwFyLJ
        suFwkXQ1A9qFxfCbgIf48XqyuByw4g2nBe3DgYMzSq/d1c2xLHltB1I4pvoIqhnS8q4uRL
        bl3KL8ZDICk/1vUnGDd5JyRcfmjFCl+COv8nMyQDWl1p0/6ty60eHiJGbo99Vw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k7D9LsjqZuZo5dBqqfv/ExL4revQqVd4yA1Xdog29cQ=;
        b=wahnM7I+mOzIehgyY6oKhLre/DDgS5f9aweqXQAddREo15iBbFTZTQIhhZSzWLdmRNpBEN
        ZOE1ovRXuOSTwVCQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 21/74] serial: atmel: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:38 +0206
Message-Id: <20230914183831.587273-22-john.ogness@linutronix.de>
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
 drivers/tty/serial/atmel_serial.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 88cdafa5ac54..1946fafc3f3e 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -861,7 +861,7 @@ static void atmel_complete_tx_dma(void *arg)
 	struct dma_chan *chan = atmel_port->chan_tx;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (chan)
 		dmaengine_terminate_all(chan);
@@ -893,7 +893,7 @@ static void atmel_complete_tx_dma(void *arg)
 				  atmel_port->tx_done_mask);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void atmel_release_tx_dma(struct uart_port *port)
@@ -1711,9 +1711,9 @@ static void atmel_tasklet_rx_func(struct tasklet_struct *t)
 	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	atmel_port->schedule_rx(port);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 }
 
 static void atmel_tasklet_tx_func(struct tasklet_struct *t)
@@ -1723,9 +1723,9 @@ static void atmel_tasklet_tx_func(struct tasklet_struct *t)
 	struct uart_port *port = &atmel_port->uart;
 
 	/* The interrupt handler does not take the lock */
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	atmel_port->schedule_tx(port);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 }
 
 static void atmel_init_property(struct atmel_uart_port *atmel_port,
@@ -2175,7 +2175,7 @@ static void atmel_set_termios(struct uart_port *port,
 	} else
 		mode |= ATMEL_US_PAR_NONE;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	port->read_status_mask = ATMEL_US_OVRE;
 	if (termios->c_iflag & INPCK)
@@ -2377,22 +2377,22 @@ static void atmel_set_termios(struct uart_port *port,
 	else
 		atmel_disable_ms(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void atmel_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		atmel_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(port);
 			atmel_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(port);
 		}
 	}
 }
-- 
2.39.2

