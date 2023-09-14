Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FA17A0CFC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbjINSjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241612AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E76262103;
        Thu, 14 Sep 2023 11:38:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtioS1TmKY7HP/T4E5ia6bLpeGsG2aqw7oKrLcODTps=;
        b=KzR11aI9gMRB+jNxh73zf08f5zfu/h94i8WcA/3/y5qkyCNVrXvChwPbdJM9x207DuYSdm
        5TnoMRJFSM0tSm8kxtFH60dMK6ATrKgzPAOqhAs/T5VKADPi7G0F8X0rcZWIPSN7uXsNMf
        xSeERMiAJPhFGYUXTISrHOmpAwvkN4GxihRhtbV/aBe2bqoUhBydbMagg2zV6sBnhZsm8o
        9VQ3VavmlDH64IhR4lxTvzRanxQk1621jItnGZdIz7FBiyYLIrfZMG5X73rfXfrAZyaA4O
        0tNytbsl8jFu9CQaJmYt4hcEHUm3VIWtDCl7OqYda7AOsn2bA/cDl9csUv19dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtioS1TmKY7HP/T4E5ia6bLpeGsG2aqw7oKrLcODTps=;
        b=r8qMy4Di9mr9YJgshOb2oXJhJVt0iIfP10UKioSN1o0mLawjFrtLrNOaRqGeDH1l6nHA1q
        UsuEvV98gwDm4PAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH tty v1 14/74] serial: altera_jtaguart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:31 +0206
Message-Id: <20230914183831.587273-15-john.ogness@linutronix.de>
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
 drivers/tty/serial/altera_jtaguart.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 5fab4c978891..7090b251dd4d 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -147,14 +147,14 @@ static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
 	isr = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) >>
 	       ALTERA_JTAGUART_CONTROL_RI_OFF) & port->read_status_mask;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	if (isr & ALTERA_JTAGUART_CONTROL_RE_MSK)
 		altera_jtaguart_rx_chars(port);
 	if (isr & ALTERA_JTAGUART_CONTROL_WE_MSK)
 		altera_jtaguart_tx_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_RETVAL(isr);
 }
@@ -180,14 +180,14 @@ static int altera_jtaguart_startup(struct uart_port *port)
 		return ret;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Enable RX interrupts now */
 	port->read_status_mask = ALTERA_JTAGUART_CONTROL_RE_MSK;
 	writel(port->read_status_mask,
 			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -196,14 +196,14 @@ static void altera_jtaguart_shutdown(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable all interrupts now */
 	port->read_status_mask = 0;
 	writel(port->read_status_mask,
 			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
 }
@@ -264,33 +264,33 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
 	unsigned long flags;
 	u32 status;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	while (!altera_jtaguart_tx_space(port, &status)) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		if ((status & ALTERA_JTAGUART_CONTROL_AC_MSK) == 0) {
 			return;	/* no connection activity */
 		}
 
 		cpu_relax();
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 	}
 	writel(c, port->membase + ALTERA_JTAGUART_DATA_REG);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 #else
 static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	while (!altera_jtaguart_tx_space(port, NULL)) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		cpu_relax();
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 	}
 	writel(c, port->membase + ALTERA_JTAGUART_DATA_REG);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 #endif
 
-- 
2.39.2

