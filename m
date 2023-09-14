Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F5DC7A0D69
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbjINSo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241678AbjINSmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:42:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BB530E9;
        Thu, 14 Sep 2023 11:39:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hVBmOc1UZslIEApH7wM7XsxUFX5t/MGHE6BhKB/8dE=;
        b=AIzFnxKF/HftpM563b/45gzbyhppoKPbb3WOngQIYKnzlm7KcT5/Vybf6MzS/v4xTyrK12
        JvVsV7QJKVZmGnUgn0nEsruFmzmI0iHzv7T2p4MUocmRSBeVYG0ELH8B4/txM0fw4T+ixV
        lkebqhdVNlhxQEUzcC9685DeWUMGTAQWYHU1B7EL33hSjhmbOCzOgPg5i3t7KZYO9xzrGu
        tF96nxkf7bokQ+mLuVNIw5VGKvd/PFRAs5YqLSiPIqp3L5gD3+RzL7IoTCUsow58bfI95o
        5BXOs9LfStTFfZ5nqYktxvrhIK4e39BAV9k56VfuHOgNduxbcOg1LoRWWgPLwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/hVBmOc1UZslIEApH7wM7XsxUFX5t/MGHE6BhKB/8dE=;
        b=niG5LYzVOKr5LrHsGiYGWQ9Up9n4rYw0JaYgiLqr+u7qKMNYRJ0vmgV8KfsJV9UMV9dgdQ
        1ddFUyocepCE1YAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Peter Korsgaard <jacmet@sunsite.dk>
Subject: [PATCH tty v1 71/74] serial: uartlite: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:28 +0206
Message-Id: <20230914183831.587273-72-john.ogness@linutronix.de>
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
 drivers/tty/serial/uartlite.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index b225a78f6175..404c14acafa5 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -216,11 +216,11 @@ static irqreturn_t ulite_isr(int irq, void *dev_id)
 	unsigned long flags;
 
 	do {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		stat = uart_in32(ULITE_STATUS, port);
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		n++;
 	} while (busy);
 
@@ -238,9 +238,9 @@ static unsigned int ulite_tx_empty(struct uart_port *port)
 	unsigned long flags;
 	unsigned int ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	ret = uart_in32(ULITE_STATUS, port);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
 }
@@ -323,7 +323,7 @@ static void ulite_set_termios(struct uart_port *port,
 	termios->c_cflag |= pdata->cflags & (PARENB | PARODD | CSIZE);
 	tty_termios_encode_baud_rate(termios, pdata->baud, pdata->baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	port->read_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
 		| ULITE_STATUS_TXFULL;
@@ -346,7 +346,7 @@ static void ulite_set_termios(struct uart_port *port,
 	/* update timeout */
 	uart_update_timeout(port, termios->c_cflag, pdata->baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *ulite_type(struct uart_port *port)
@@ -495,9 +495,9 @@ static void ulite_console_write(struct console *co, const char *s,
 	int locked = 1;
 
 	if (oops_in_progress) {
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	} else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	/* save and disable interrupt */
 	ier = uart_in32(ULITE_STATUS, port) & ULITE_STATUS_IE;
@@ -512,7 +512,7 @@ static void ulite_console_write(struct console *co, const char *s,
 		uart_out32(ULITE_CONTROL_IE, ULITE_CONTROL, port);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static int ulite_console_setup(struct console *co, char *options)
-- 
2.39.2

