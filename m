Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601A57A0CFF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbjINSj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241638AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EC52106;
        Thu, 14 Sep 2023 11:38:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEsVj/D77ms6nq6XAzujZvjYPk4w6pPMN5gfYUu1uwE=;
        b=LA7fdwe+El9NWhgb0luA7qJcYedEH/jJ1J2ruvAn2QzhkX4ENhknKvcPfr6zsEzFKubTgS
        iV5QrvnCSUdmtnD1W3B1XpkzrL/5Ux7xf8qCJoQg9MGxwOwPwY73PV0oU1Ns5etfhEM7dN
        22kvwKonDlSZiYUYffSMW2qcBg7eIs7r2Gbbvk4iyFNlfV+FqWI7eVvy4Tvlvq9EBEpuRl
        wAeVw2ocXlPOx5PkyCFcOKKZNe392UAjcjG8H0phFiTuw6JgoETyzNdCEi1EslSBrjjAX5
        qW1lxJLPjZIhtUzmOG4rxi75fV/2TPwIIL2tlZ+fKhkF2P29vQY/7DKenK7/TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EEsVj/D77ms6nq6XAzujZvjYPk4w6pPMN5gfYUu1uwE=;
        b=YwwhM9vN6g8+vsx/509OyoWLuq7JDeBCPnJ3cH+n7xiLAvO6j//gLDZ3bji5emR8fH05j1
        UY8ZKgukj15DJdBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH tty v1 15/74] serial: altera_uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:32 +0206
Message-Id: <20230914183831.587273-16-john.ogness@linutronix.de>
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
 drivers/tty/serial/altera_uart.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index a9c41942190c..77835ac68df2 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -164,13 +164,13 @@ static void altera_uart_break_ctl(struct uart_port *port, int break_state)
 	struct altera_uart *pp = container_of(port, struct altera_uart, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (break_state == -1)
 		pp->imr |= ALTERA_UART_CONTROL_TRBK_MSK;
 	else
 		pp->imr &= ~ALTERA_UART_CONTROL_TRBK_MSK;
 	altera_uart_update_ctrl_reg(pp);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void altera_uart_set_termios(struct uart_port *port,
@@ -187,10 +187,10 @@ static void altera_uart_set_termios(struct uart_port *port,
 		tty_termios_copy_hw(termios, old);
 	tty_termios_encode_baud_rate(termios, baud, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_update_timeout(port, termios->c_cflag, baud);
 	altera_uart_writel(port, baudclk, ALTERA_UART_DIVISOR_REG);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	/*
 	 * FIXME: port->read_status_mask and port->ignore_status_mask
@@ -264,12 +264,12 @@ static irqreturn_t altera_uart_interrupt(int irq, void *data)
 
 	isr = altera_uart_readl(port, ALTERA_UART_STATUS_REG) & pp->imr;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (isr & ALTERA_UART_STATUS_RRDY_MSK)
 		altera_uart_rx_chars(port);
 	if (isr & ALTERA_UART_STATUS_TRDY_MSK)
 		altera_uart_tx_chars(port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_RETVAL(isr);
 }
@@ -313,13 +313,13 @@ static int altera_uart_startup(struct uart_port *port)
 		}
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Enable RX interrupts now */
 	pp->imr = ALTERA_UART_CONTROL_RRDY_MSK;
 	altera_uart_update_ctrl_reg(pp);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -329,13 +329,13 @@ static void altera_uart_shutdown(struct uart_port *port)
 	struct altera_uart *pp = container_of(port, struct altera_uart, port);
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Disable all interrupts now */
 	pp->imr = 0;
 	altera_uart_update_ctrl_reg(pp);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (port->irq)
 		free_irq(port->irq, port);
-- 
2.39.2

