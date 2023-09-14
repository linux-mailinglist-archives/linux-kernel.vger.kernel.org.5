Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C707A0D05
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241958AbjINSjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241655AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F11E2107;
        Thu, 14 Sep 2023 11:38:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzsn2wLYsWS44Gbs24avQ4nqhzEXcoHpcp6KNR2u0GE=;
        b=PiJR5jMN7CVVZo8siH35FwnJFoSDfXaB7ytFHSQkwHRaQ+jVGAS45QDRTXT05uk0ubuWUR
        ypRaqKU5MiNEmIar0/k6pnSjYR7UZoP3tLOl1SWRLlPtvMAvuA2EWhBaxYg2PPa7frbNrq
        iW0FlJ1UVo03/8eHUfNsbc5INW1VgtLIFpmHtgZ5vzGMJSZfkGO+MrxULFEJ34hYUJqKPP
        IWsAFHssQ38VQeZn6VIF6MBsLqdxCWEQdJe5UHPrRiZtnI9mkk0TMLw7XyDWxJNc8IVj9X
        wTdog0tqfcGozCm07toBOvFNKPAaLuWTD75SD+cXvZr7wlaBeU/4eQMmdGpITA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vzsn2wLYsWS44Gbs24avQ4nqhzEXcoHpcp6KNR2u0GE=;
        b=MiF9n5qv0YK7IdQjzTI3Kbo1xwtqPynXg98RvBsu+Hr3Twlm6rN65Op6DLiw2hKFzDWYz1
        gBCFTmnSTbNPWfAw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
Subject: [PATCH tty v1 20/74] serial: arc_uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:37 +0206
Message-Id: <20230914183831.587273-21-john.ogness@linutronix.de>
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
 drivers/tty/serial/arc_uart.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/arc_uart.c b/drivers/tty/serial/arc_uart.c
index ad4ae19b6ce3..1aa5b2b49c26 100644
--- a/drivers/tty/serial/arc_uart.c
+++ b/drivers/tty/serial/arc_uart.c
@@ -279,9 +279,9 @@ static irqreturn_t arc_serial_isr(int irq, void *dev_id)
 	if (status & RXIENB) {
 
 		/* already in ISR, no need of xx_irqsave */
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		arc_serial_rx_chars(port, status);
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 	}
 
 	if ((status & TXIENB) && (status & TXEMPTY)) {
@@ -291,12 +291,12 @@ static irqreturn_t arc_serial_isr(int irq, void *dev_id)
 		 */
 		UART_TX_IRQ_DISABLE(port);
 
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 
 		if (!uart_tx_stopped(port))
 			arc_serial_tx_chars(port);
 
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 	}
 
 	return IRQ_HANDLED;
@@ -366,7 +366,7 @@ arc_serial_set_termios(struct uart_port *port, struct ktermios *new,
 	uartl = hw_val & 0xFF;
 	uarth = (hw_val >> 8) & 0xFF;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	UART_ALL_IRQ_DISABLE(port);
 
@@ -391,7 +391,7 @@ arc_serial_set_termios(struct uart_port *port, struct ktermios *new,
 
 	uart_update_timeout(port, new->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *arc_serial_type(struct uart_port *port)
@@ -521,9 +521,9 @@ static void arc_serial_console_write(struct console *co, const char *s,
 	struct uart_port *port = &arc_uart_ports[co->index].port;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	uart_console_write(port, s, count, arc_serial_console_putchar);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static struct console arc_console = {
-- 
2.39.2

