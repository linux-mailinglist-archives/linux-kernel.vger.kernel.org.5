Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 089F07A0D02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241677AbjINSje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241649AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6B2210C;
        Thu, 14 Sep 2023 11:38:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEd2RSJzhntSqK11XG0KTVZ8R/Gb2qOWG3w4Nfiax6M=;
        b=F7L7IR2eKfSOVFtuX4pQzhKiSs62AY/3etTgDhxEVqQIBaQVBBD+jnWGxhvpj3j/8Ufb5y
        uDdZnKOiQoUL/Kw8C3ieYB4aP2IFqldUQzXjM/wZhl7CEu8PqftaSW2pfakgw9azzENni4
        CQeznE9cVGPo350Gj5199BAJ150xLfDJcvEWx1xkItuMkLrBywJDLYn0Dxm9cp4W6Dkd/Q
        Mnnm9LhFV4Of+kbmHSAuztVeAk31dfX+ESOSmQ8q60q6Euxy4CWDXMPBVtz7vMHvohQeZI
        8sn/dvHyoYaee8iHprsz+iesZmucTBZjtDtFsWfcmJ4TN0FF/EoQkI3HJgIjZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XEd2RSJzhntSqK11XG0KTVZ8R/Gb2qOWG3w4Nfiax6M=;
        b=NKcbiC3CuQI7grUBjp9Qs9w9XdzcJTBkNz781YXADwy6HZ43g3o02oPyyFKranKsUoRIwK
        ZyT+Wy/WXLcs/dAw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Yangtao Li <frank.li@vivo.com>, Lukas Wunner <lukas@wunner.de>
Subject: [PATCH tty v1 19/74] serial: ar933x: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:36 +0206
Message-Id: <20230914183831.587273-20-john.ogness@linutronix.de>
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
 drivers/tty/serial/ar933x_uart.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index 924c1a89347c..ffd234673177 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -133,9 +133,9 @@ static unsigned int ar933x_uart_tx_empty(struct uart_port *port)
 	unsigned long flags;
 	unsigned int rdata;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	rdata = ar933x_uart_read(up, AR933X_UART_DATA_REG);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return (rdata & AR933X_UART_DATA_TX_CSR) ? 0 : TIOCSER_TEMT;
 }
@@ -220,14 +220,14 @@ static void ar933x_uart_break_ctl(struct uart_port *port, int break_state)
 		container_of(port, struct ar933x_uart_port, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	if (break_state == -1)
 		ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
 				    AR933X_UART_CS_TX_BREAK);
 	else
 		ar933x_uart_rmw_clear(up, AR933X_UART_CS_REG,
 				      AR933X_UART_CS_TX_BREAK);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 /*
@@ -318,7 +318,7 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 	 * Ok, we're now changing the port state. Do it with
 	 * interrupts disabled.
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/* disable the UART */
 	ar933x_uart_rmw_clear(up, AR933X_UART_CS_REG,
@@ -352,7 +352,7 @@ static void ar933x_uart_set_termios(struct uart_port *port,
 			AR933X_UART_CS_IF_MODE_M << AR933X_UART_CS_IF_MODE_S,
 			AR933X_UART_CS_IF_MODE_DCE << AR933X_UART_CS_IF_MODE_S);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	if (tty_termios_baud_rate(new))
 		tty_termios_encode_baud_rate(new, baud, baud);
@@ -450,7 +450,7 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void *dev_id)
 	if ((status & AR933X_UART_CS_HOST_INT) == 0)
 		return IRQ_NONE;
 
-	spin_lock(&up->port.lock);
+	uart_port_lock(&up->port);
 
 	status = ar933x_uart_read(up, AR933X_UART_INT_REG);
 	status &= ar933x_uart_read(up, AR933X_UART_INT_EN_REG);
@@ -468,7 +468,7 @@ static irqreturn_t ar933x_uart_interrupt(int irq, void *dev_id)
 		ar933x_uart_tx_chars(up);
 	}
 
-	spin_unlock(&up->port.lock);
+	uart_port_unlock(&up->port);
 
 	return IRQ_HANDLED;
 }
@@ -485,7 +485,7 @@ static int ar933x_uart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	/* Enable HOST interrupts */
 	ar933x_uart_rmw_set(up, AR933X_UART_CS_REG,
@@ -498,7 +498,7 @@ static int ar933x_uart_startup(struct uart_port *port)
 	/* Enable RX interrupts */
 	ar933x_uart_start_rx_interrupt(up);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 
 	return 0;
 }
@@ -632,9 +632,9 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&up->port.lock);
+		locked = uart_port_trylock(&up->port);
 	else
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 
 	/*
 	 * First save the IER then disable the interrupts
@@ -654,7 +654,7 @@ static void ar933x_uart_console_write(struct console *co, const char *s,
 	ar933x_uart_write(up, AR933X_UART_INT_REG, AR933X_UART_INT_ALLINTS);
 
 	if (locked)
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 	local_irq_restore(flags);
 }
-- 
2.39.2

