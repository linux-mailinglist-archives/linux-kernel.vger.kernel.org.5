Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385B7A0D15
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242022AbjINSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241789AbjINSi7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D780D2109;
        Thu, 14 Sep 2023 11:38:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/YEVP6mWwFo6/xhfhUTWYtdghju7JIkgzq7NY/TOjo=;
        b=0HDJH4mxjCm5HX8gWyLjpF6KeeBvYaaN9tDWvnW/Td7Yvq3ytL5x42DJcRx0Y3de7ueaod
        87Eeu/kJ8jzEzJRQ8D3fpXGIz1xPrQr15ZVGFZxSgw/G/abw68XswubNUM/aSoimMwisDQ
        HbCWUM9OSAFllmMopxC5SzBqN0E6R57WC0fmxKib3z76SMx1H/xp2r8P/HgmrI3aSsXyxe
        Z1HCcW9uGLSaTMjd2ByXAb927zjGJDJFf4wrxXH6bTJ1l0+pJzrgKMw2aGVMqCJOOMqrfs
        Y/oUqNG7RbkeE+tnFDQkunt8PJjYDAXBmGZTgEa+WKxrTnYRF84EmJLDGU26PA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B/YEVP6mWwFo6/xhfhUTWYtdghju7JIkgzq7NY/TOjo=;
        b=THdCdqmkDOMQ6RV/8UcNabNFfW7AqzyKAXtxCI78QFQRSlvdfobIL3mXavhPEkaw7SKFQQ
        Q0MfUPqE9lVT2wCg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jacky Huang <ychuang3@nuvoton.com>,
        Shan-Chun Hung <schung@nuvoton.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 34/74] serial: ma35d1: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:51 +0206
Message-Id: <20230914183831.587273-35-john.ogness@linutronix.de>
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
 drivers/tty/serial/ma35d1_serial.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
index 465b1def9e11..6fac924f7c12 100644
--- a/drivers/tty/serial/ma35d1_serial.c
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -269,16 +269,16 @@ static void receive_chars(struct uart_ma35d1_port *up)
 		if (uart_handle_sysrq_char(&up->port, ch))
 			continue;
 
-		spin_lock(&up->port.lock);
+		uart_port_lock(&up->port);
 		uart_insert_char(&up->port, fsr, MA35_FSR_RX_OVER_IF, ch, flag);
-		spin_unlock(&up->port.lock);
+		uart_port_unlock(&up->port);
 
 		fsr = serial_in(up, MA35_FSR_REG);
 	} while (!(fsr & MA35_FSR_RX_EMPTY) && (max_count-- > 0));
 
-	spin_lock(&up->port.lock);
+	uart_port_lock(&up->port);
 	tty_flip_buffer_push(&up->port.state->port);
-	spin_unlock(&up->port.lock);
+	uart_port_unlock(&up->port);
 }
 
 static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
@@ -364,14 +364,14 @@ static void ma35d1serial_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	u32 lcr;
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 	lcr = serial_in(up, MA35_LCR_REG);
 	if (break_state != 0)
 		lcr |= MA35_LCR_BREAK;
 	else
 		lcr &= ~MA35_LCR_BREAK;
 	serial_out(up, MA35_LCR_REG, lcr);
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int ma35d1serial_startup(struct uart_port *port)
@@ -441,7 +441,7 @@ static void ma35d1serial_set_termios(struct uart_port *port,
 	 * Ok, we're now changing the port state.  Do it with
 	 * interrupts disabled.
 	 */
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	up->port.read_status_mask = MA35_FSR_RX_OVER_IF;
 	if (termios->c_iflag & INPCK)
@@ -475,7 +475,7 @@ static void ma35d1serial_set_termios(struct uart_port *port,
 
 	serial_out(up, MA35_LCR_REG, lcr);
 
-	spin_unlock_irqrestore(&up->port.lock, flags);
+	uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static const char *ma35d1serial_type(struct uart_port *port)
@@ -560,9 +560,9 @@ static void ma35d1serial_console_write(struct console *co, const char *s, u32 co
 	if (up->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&up->port.lock, flags);
+		locked = uart_port_trylock_irqsave(&up->port, &flags);
 	else
-		spin_lock_irqsave(&up->port.lock, flags);
+		uart_port_lock_irqsave(&up->port, &flags);
 
 	/*
 	 *  First save the IER then disable the interrupts
@@ -576,7 +576,7 @@ static void ma35d1serial_console_write(struct console *co, const char *s, u32 co
 	serial_out(up, MA35_IER_REG, ier);
 
 	if (locked)
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 }
 
 static int __init ma35d1serial_console_setup(struct console *co, char *options)
-- 
2.39.2

