Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3227A0D18
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbjINSkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241724AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8532682;
        Thu, 14 Sep 2023 11:38:54 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ljKUwev2UkcA8WCxS5wHB4jucft9QaueReQAnJLBgA=;
        b=4LBDpTPLhp3Mhhl4pVyJop8/w8YO125vIGMHFDGAc829iCRLFSl6X0mnCu86Xp0DKlykZQ
        MXfUoGbOklo8kZ7vno2kF6WSkEIFFIvGBTcq82frPQ1vcXYDd6OP7vg6a7cB6OoKGCAkfw
        fKDP6Ajv8OLwdQ319atwJb34QtjDpof9v9S7t56NLpZyAZyZJnQuNrxE05l8/g1GJoesLm
        lwGEKRQpPcSrqp5lU/Qczo2PqcPpFrhhih2JjfhMpnvo2acScgXq2FMPoFFKDsSCyfuCZw
        ocpglMKMTGaf/tHVHULGAUC4UImI8D22JCJD7t3sASdeP7gHPu23CWH7OKLk0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ljKUwev2UkcA8WCxS5wHB4jucft9QaueReQAnJLBgA=;
        b=DU48W/75T7f5tMYhQEpupILmuQfJztsBNWC4FVQumidZDa1Kg7GZ2XZ8GARLh976Uuhd0Q
        AFsq08hjfv2Li5Cg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH tty v1 35/74] serial: mcf: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:52 +0206
Message-Id: <20230914183831.587273-36-john.ogness@linutronix.de>
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
 drivers/tty/serial/mcf.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index 1666ce012e5e..91b15243f6c6 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -135,12 +135,12 @@ static void mcf_break_ctl(struct uart_port *port, int break_state)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (break_state == -1)
 		writeb(MCFUART_UCR_CMDBREAKSTART, port->membase + MCFUART_UCR);
 	else
 		writeb(MCFUART_UCR_CMDBREAKSTOP, port->membase + MCFUART_UCR);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /****************************************************************************/
@@ -150,7 +150,7 @@ static int mcf_startup(struct uart_port *port)
 	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Reset UART, get it into known state... */
 	writeb(MCFUART_UCR_CMDRESETRX, port->membase + MCFUART_UCR);
@@ -164,7 +164,7 @@ static int mcf_startup(struct uart_port *port)
 	pp->imr = MCFUART_UIR_RXREADY;
 	writeb(pp->imr, port->membase + MCFUART_UIMR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -176,7 +176,7 @@ static void mcf_shutdown(struct uart_port *port)
 	struct mcf_uart *pp = container_of(port, struct mcf_uart, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable all interrupts now */
 	pp->imr = 0;
@@ -186,7 +186,7 @@ static void mcf_shutdown(struct uart_port *port)
 	writeb(MCFUART_UCR_CMDRESETRX, port->membase + MCFUART_UCR);
 	writeb(MCFUART_UCR_CMDRESETTX, port->membase + MCFUART_UCR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /****************************************************************************/
@@ -252,7 +252,7 @@ static void mcf_set_termios(struct uart_port *port, struct ktermios *termios,
 		mr2 |= MCFUART_MR2_TXCTS;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (port->rs485.flags & SER_RS485_ENABLED) {
 		dev_dbg(port->dev, "Setting UART to RS485\n");
 		mr2 |= MCFUART_MR2_TXRTS;
@@ -273,7 +273,7 @@ static void mcf_set_termios(struct uart_port *port, struct ktermios *termios,
 		port->membase + MCFUART_UCSR);
 	writeb(MCFUART_UCR_RXENABLE | MCFUART_UCR_TXENABLE,
 		port->membase + MCFUART_UCR);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /****************************************************************************/
@@ -350,7 +350,7 @@ static irqreturn_t mcf_interrupt(int irq, void *data)
 
 	isr = readb(port->membase + MCFUART_UISR) & pp->imr;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	if (isr & MCFUART_UIR_RXREADY) {
 		mcf_rx_chars(pp);
 		ret = IRQ_HANDLED;
@@ -359,7 +359,7 @@ static irqreturn_t mcf_interrupt(int irq, void *data)
 		mcf_tx_chars(pp);
 		ret = IRQ_HANDLED;
 	}
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return ret;
 }
-- 
2.39.2

