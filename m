Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 993F07A0D26
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242069AbjINSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbjINSjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FBB212F;
        Thu, 14 Sep 2023 11:38:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6vrAwcgKz7ylA3cRQUQRd1w5cbqa1m8ev1xxDaRFwE=;
        b=muqVm7X9tP6ID051yVCBhDgrs0kev7wg4hEKEteDt08L0usIg1siioIaPv90x2ZGm6h2Ws
        9QNQtenqdH5eij4RXmczrpWLR3MO1arWnlxoaIcPFCBWxUJWODNMvZb4pStGZ/atT4IKMD
        R/jazeHrX+uwyAaX506eQogR4DJHMHYAUEiz9sF8/DHk1zMGBlJW3jqm3/KS/EWNEvWY4q
        zcFyZJjZ1YUu3uwJDQ2d+YN/ToDi5Hgo7t4Bya6+31CNsDGafDAe7q8ln0ZKHAGyrJ2n8y
        Cf9VmNeBu5MM7RNL6Y8TakEVktDuc99B3g2VRBGPPFCb4wmdkgAGeGBpqyjd1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H6vrAwcgKz7ylA3cRQUQRd1w5cbqa1m8ev1xxDaRFwE=;
        b=qZFEim1mhdloYTQZZVPN8NbdSh3Tzog/vMVwwhRyGWfxWi+4OVib5huct2BIqmF6Z3N2gP
        mEZ/wxnI0iXWryBA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
Subject: [PATCH tty v1 42/74] serial: mvebu-uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:59 +0206
Message-Id: <20230914183831.587273-43-john.ogness@linutronix.de>
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
 drivers/tty/serial/mvebu-uart.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ea924e9b913b..0255646bc175 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -187,9 +187,9 @@ static unsigned int mvebu_uart_tx_empty(struct uart_port *port)
 	unsigned long flags;
 	unsigned int st;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	st = readl(port->membase + UART_STAT);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return (st & STAT_TX_EMP) ? TIOCSER_TEMT : 0;
 }
@@ -249,14 +249,14 @@ static void mvebu_uart_break_ctl(struct uart_port *port, int brk)
 	unsigned int ctl;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	ctl = readl(port->membase + UART_CTRL(port));
 	if (brk == -1)
 		ctl |= CTRL_SND_BRK_SEQ;
 	else
 		ctl &= ~CTRL_SND_BRK_SEQ;
 	writel(ctl, port->membase + UART_CTRL(port));
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
@@ -540,7 +540,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 	unsigned long flags;
 	unsigned int baud, min_baud, max_baud;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	port->read_status_mask = STAT_RX_RDY(port) | STAT_OVR_ERR |
 		STAT_TX_RDY(port) | STAT_TX_FIFO_FUL;
@@ -589,7 +589,7 @@ static void mvebu_uart_set_termios(struct uart_port *port,
 		uart_update_timeout(port, termios->c_cflag, baud);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *mvebu_uart_type(struct uart_port *port)
@@ -735,9 +735,9 @@ static void mvebu_uart_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	ier = readl(port->membase + UART_CTRL(port)) & CTRL_BRK_INT;
 	intr = readl(port->membase + UART_INTR(port)) &
@@ -758,7 +758,7 @@ static void mvebu_uart_console_write(struct console *co, const char *s,
 	}
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static int mvebu_uart_console_setup(struct console *co, char *options)
-- 
2.39.2

