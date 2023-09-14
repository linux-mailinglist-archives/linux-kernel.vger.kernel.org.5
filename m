Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ADD7A0D13
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbjINSkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241712AbjINSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F101FFC;
        Thu, 14 Sep 2023 11:38:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6B6UlYTFshG6RUwUjgz7+c8nYTltsRlBFw4dXdDaIc=;
        b=Ulo9afi/9JwAEtpEl3ZUs1+lGIMenRJFVgszhjNu6L2spjSDEOPQF8zwCH+5xN/11PJVc9
        5xLX2VcVEITFFRc+mDSGZlyFSgGLSqRK2aZLwxuasSiRx8Fx7tefLvk2Ni6p9Kore8cTEL
        xPDiSOmddfwYTuU5a6p70NG6MdamMY3t4Ij4lcaEL7SRV8ANbX1qlixeyx3hB1MVZflFKl
        5Mh/WiwwX41im6JXk6zVQQDS7rsDtZudzrbNkAwlMvUOM2xKdOowv1Hvp9z5AlXZX5FGXq
        cu43KLeiEpRDwU4gIYXRgOTKGKf4GZ9CkfByUJpYb3ECvOrZoY9CmEW8jCCFEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W6B6UlYTFshG6RUwUjgz7+c8nYTltsRlBFw4dXdDaIc=;
        b=47jTyQrFEv1pP3sGvbZ8+7jaCouF0JKrnaWNtL6wtqAU1mfLoyiSVAJB5t6TTsdox9Y3VB
        G02+bnfuCsTBI3CQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Yangtao Li <frank.li@vivo.com>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Subject: [PATCH tty v1 22/74] serial: bcm63xx-uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:39 +0206
Message-Id: <20230914183831.587273-23-john.ogness@linutronix.de>
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
 drivers/tty/serial/bcm63xx_uart.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 0dd8cceb837c..4a08fd5ee61b 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -201,7 +201,7 @@ static void bcm_uart_break_ctl(struct uart_port *port, int ctl)
 	unsigned long flags;
 	unsigned int val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = bcm_uart_readl(port, UART_CTL_REG);
 	if (ctl)
@@ -210,7 +210,7 @@ static void bcm_uart_break_ctl(struct uart_port *port, int ctl)
 		val &= ~UART_CTL_XMITBRK_MASK;
 	bcm_uart_writel(port, val, UART_CTL_REG);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /*
@@ -332,7 +332,7 @@ static irqreturn_t bcm_uart_interrupt(int irq, void *dev_id)
 	unsigned int irqstat;
 
 	port = dev_id;
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	irqstat = bcm_uart_readl(port, UART_IR_REG);
 	if (irqstat & UART_RX_INT_STAT)
@@ -353,7 +353,7 @@ static irqreturn_t bcm_uart_interrupt(int irq, void *dev_id)
 					       estat & UART_EXTINP_DCD_MASK);
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 	return IRQ_HANDLED;
 }
 
@@ -451,9 +451,9 @@ static void bcm_uart_shutdown(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	bcm_uart_writel(port, 0, UART_IR_REG);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	bcm_uart_disable(port);
 	bcm_uart_flush(port);
@@ -470,7 +470,7 @@ static void bcm_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	unsigned long flags;
 	int tries;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Drain the hot tub fully before we power it off for the winter. */
 	for (tries = 3; !bcm_uart_tx_empty(port) && tries; tries--)
@@ -546,7 +546,7 @@ static void bcm_uart_set_termios(struct uart_port *port, struct ktermios *new,
 
 	uart_update_timeout(port, new->c_cflag, baud);
 	bcm_uart_enable(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /*
@@ -712,9 +712,9 @@ static void bcm_console_write(struct console *co, const char *s,
 		/* bcm_uart_interrupt() already took the lock */
 		locked = 0;
 	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
+		locked = uart_port_trylock(port);
 	} else {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		locked = 1;
 	}
 
@@ -725,7 +725,7 @@ static void bcm_console_write(struct console *co, const char *s,
 	wait_for_xmitr(port);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 	local_irq_restore(flags);
 }
 
-- 
2.39.2

