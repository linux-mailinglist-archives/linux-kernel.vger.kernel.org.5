Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577C27A0D20
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242052AbjINSk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241819AbjINSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F673211E;
        Thu, 14 Sep 2023 11:38:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9wzJpM/hTGvGG40vNbVTUQjpkMtUAUxayMtXjZuHUE=;
        b=u8PiurzFnDC29q45800AqAXE7kZ5IcrLh5PgFkXFWnEqN2WMaBEoxskCMMi9QcukzjXvo8
        zxNMY05yrq8L33TVpXER2JxgNUc1E/xhYJMwu4sd4HpsDc0MKIuaWzFMfoPsnme259Cobp
        iFCIpRAsH76Pf0EeGsYgvm7fR3aWBRfh1G80WueS2pdN+4BoyuaGhYWLdUKqmAySZCqsP5
        xXwV5U0TC7WQVjC1oTM9nmcHz5iVLKEzG8NsdnzS8r8t1UW1grEEDkSSsaHK9ioYWVbh1d
        cPSA2ZtEx9keDZud6890yVfuNfEzSbJ1Ewwhyu4E/NT7s9FAi1m0qLuQ3yqVLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E9wzJpM/hTGvGG40vNbVTUQjpkMtUAUxayMtXjZuHUE=;
        b=Z1W6hSbtxnVWbn5OWCbxj/FFJw4sMBXi9W6Yl6ggduNuUlI6W1LsbgMRHOWu1h1acXbZjn
        dfA/izrV71PNwOAw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Thierry Reding <treding@nvidia.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 38/74] serial: milbeaut_usio: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:55 +0206
Message-Id: <20230914183831.587273-39-john.ogness@linutronix.de>
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
 drivers/tty/serial/milbeaut_usio.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/milbeaut_usio.c b/drivers/tty/serial/milbeaut_usio.c
index 70a910085e93..db3b81f2aa57 100644
--- a/drivers/tty/serial/milbeaut_usio.c
+++ b/drivers/tty/serial/milbeaut_usio.c
@@ -207,9 +207,9 @@ static irqreturn_t mlb_usio_rx_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	mlb_usio_rx_chars(port);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -218,10 +218,10 @@ static irqreturn_t mlb_usio_tx_irq(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	if (readb(port->membase + MLB_USIO_REG_SSR) & MLB_USIO_SSR_TBI)
 		mlb_usio_tx_chars(port);
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -267,7 +267,7 @@ static int mlb_usio_startup(struct uart_port *port)
 	escr = readb(port->membase + MLB_USIO_REG_ESCR);
 	if (of_property_read_bool(port->dev->of_node, "auto-flow-control"))
 		escr |= MLB_USIO_ESCR_FLWEN;
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	writeb(0, port->membase + MLB_USIO_REG_SCR);
 	writeb(escr, port->membase + MLB_USIO_REG_ESCR);
 	writeb(MLB_USIO_SCR_UPCL, port->membase + MLB_USIO_REG_SCR);
@@ -282,7 +282,7 @@ static int mlb_usio_startup(struct uart_port *port)
 
 	writeb(MLB_USIO_SCR_TXE  | MLB_USIO_SCR_RIE | MLB_USIO_SCR_TBIE |
 	       MLB_USIO_SCR_RXE, port->membase + MLB_USIO_REG_SCR);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -337,7 +337,7 @@ static void mlb_usio_set_termios(struct uart_port *port,
 	else
 		quot = 0;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_update_timeout(port, termios->c_cflag, baud);
 	port->read_status_mask = MLB_USIO_SSR_ORE | MLB_USIO_SSR_RDRF |
 				 MLB_USIO_SSR_TDRE;
@@ -367,7 +367,7 @@ static void mlb_usio_set_termios(struct uart_port *port,
 	writew(BIT(12), port->membase + MLB_USIO_REG_FBYTE);
 	writeb(MLB_USIO_SCR_RIE | MLB_USIO_SCR_RXE | MLB_USIO_SCR_TBIE |
 	       MLB_USIO_SCR_TXE, port->membase + MLB_USIO_REG_SCR);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *mlb_usio_type(struct uart_port *port)
-- 
2.39.2

