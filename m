Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32BE87A0D2C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbjINSlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241792AbjINSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33BC526A9;
        Thu, 14 Sep 2023 11:38:59 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIgEmBRygWlWYq6zDaryhqi8PdqWfUxAJ5u9Q//8KAY=;
        b=gRO2s7joD8nbugkWdaI7LOhIYz5xn3GZfDZuZpvpZ6MHdZJ26/SJzt0szg/AQ6E1v2+VAo
        Zoo3d7o/Jp5IxIBA7XGqE4dDWci3vhmUxUzNY5QIkkh99LwTRVQGyW7uKuF37sb9DIgawL
        Km/1GYpDRxXg7sjjee87eZP+FRGj139SDmrHpCy4VU8lQ0bskpyf8zKEUkpOKvMyoK7uw3
        BkCLCALtZw3Beh9T69HF/g81VorzF918kB8WHO6wGYfRxfrCqFYpAKXSx0HvK9ZnS9sBZo
        wlBfbeAlYbSBWApl9lPqVUT1GkCHGAvS1BT80LcIbX12e+fGvVnusblf+94v3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LIgEmBRygWlWYq6zDaryhqi8PdqWfUxAJ5u9Q//8KAY=;
        b=bK0I4A7t7020RZDbb5VCqF9wJQeobL5ue1tpocpk3N+yVYK2sg6AikqLjJrb9YGlY4lfZ0
        ITrmNhRMS4dEwhDQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH tty v1 45/74] serial: pch: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:02 +0206
Message-Id: <20230914183831.587273-46-john.ogness@linutronix.de>
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
 drivers/tty/serial/pch_uart.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/pch_uart.c b/drivers/tty/serial/pch_uart.c
index cc83b772b7ca..436cc6d52a11 100644
--- a/drivers/tty/serial/pch_uart.c
+++ b/drivers/tty/serial/pch_uart.c
@@ -1347,7 +1347,7 @@ static void pch_uart_set_termios(struct uart_port *port,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 
 	spin_lock_irqsave(&priv->lock, flags);
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 	rtn = pch_uart_hal_set_line(priv, baud, parity, bits, stb);
@@ -1360,7 +1360,7 @@ static void pch_uart_set_termios(struct uart_port *port,
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
 out:
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
@@ -1581,10 +1581,10 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 		port_locked = 0;
 	} else if (oops_in_progress) {
 		priv_locked = spin_trylock(&priv->lock);
-		port_locked = spin_trylock(&priv->port.lock);
+		port_locked = uart_port_trylock(&priv->port);
 	} else {
 		spin_lock(&priv->lock);
-		spin_lock(&priv->port.lock);
+		uart_port_lock(&priv->port);
 	}
 
 	/*
@@ -1604,7 +1604,7 @@ pch_console_write(struct console *co, const char *s, unsigned int count)
 	iowrite8(ier, priv->membase + UART_IER);
 
 	if (port_locked)
-		spin_unlock(&priv->port.lock);
+		uart_port_unlock(&priv->port);
 	if (priv_locked)
 		spin_unlock(&priv->lock);
 	local_irq_restore(flags);
-- 
2.39.2

