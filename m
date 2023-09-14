Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24A7A0D22
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242058AbjINSke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241847AbjINSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D3F268C;
        Thu, 14 Sep 2023 11:38:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1APoFz57Q+j1ahdXqu2UFCMnpKF7KLxKqz0dVY4BD4=;
        b=LoSvbJvi7dssW2JKc94oMsZAFLXfAK/Rb1sCC2mWK8uh+9ZYV9D/a5kEfaoYUhCM020t3X
        8VAk6PTMhH0fR6ef9sdetkn5Rqlk5QbJJ/jdge77vprEsMTZ8+yCwcWCQxV0J9AzRMeUaJ
        D+ThnuUYare4lYf6qM8fctIlDCe4pTsb8o9eKaPzbWWunoT7IhhM7FLW5c8SFDamCGSQMT
        JTi3NWz8DPT6NEPGCON9uNujqjQV0CABaoCbXRpGU4jnNBAAjhzPodJHV4Ed0Fx+SJy+07
        YWpPrcbAHN0XaVZwf8W0lVylPa+2PjKpK05v2Y+0L4fi6puG3z/2PDpnwCQNlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1APoFz57Q+j1ahdXqu2UFCMnpKF7KLxKqz0dVY4BD4=;
        b=Sb3SseUkX2HguEt15WIpJgUWSaMG0vIbUQVv2UPnfIKeR+vVRbukPUTkHE8yvXjgc/A8KT
        hP5ARzkh26e3p1Bg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Yangtao Li <frank.li@vivo.com>,
        Rob Herring <robh@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 40/74] serial: mps2-uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:57 +0206
Message-Id: <20230914183831.587273-41-john.ogness@linutronix.de>
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
 drivers/tty/serial/mps2-uart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index ea5a7911cb15..2a4c09f3a834 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -188,12 +188,12 @@ static irqreturn_t mps2_uart_rxirq(int irq, void *data)
 	if (unlikely(!(irqflag & UARTn_INT_RX)))
 		return IRQ_NONE;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	mps2_uart_write8(port, UARTn_INT_RX, UARTn_INT);
 	mps2_uart_rx_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -206,12 +206,12 @@ static irqreturn_t mps2_uart_txirq(int irq, void *data)
 	if (unlikely(!(irqflag & UARTn_INT_TX)))
 		return IRQ_NONE;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	mps2_uart_write8(port, UARTn_INT_TX, UARTn_INT);
 	mps2_uart_tx_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -222,7 +222,7 @@ static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 	struct uart_port *port = data;
 	u8 irqflag = mps2_uart_read8(port, UARTn_INT);
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	if (irqflag & UARTn_INT_RX_OVERRUN) {
 		struct tty_port *tport = &port->state->port;
@@ -244,7 +244,7 @@ static irqreturn_t mps2_uart_oerrirq(int irq, void *data)
 		handled = IRQ_HANDLED;
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return handled;
 }
@@ -356,12 +356,12 @@ mps2_uart_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	bauddiv = DIV_ROUND_CLOSEST(port->uartclk, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 	mps2_uart_write32(port, bauddiv, UARTn_BAUDDIV);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
-- 
2.39.2

