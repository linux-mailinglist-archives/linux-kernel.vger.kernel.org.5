Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311467A0D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241964AbjINSjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241739AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1BFB1FFB;
        Thu, 14 Sep 2023 11:38:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSEvjVL+BxuTqhoV6y++5iFzUZwHV0OnCUueADVyxEA=;
        b=IVquxk0Z+ro6LFHKJw51lwIPigfWCMfmclUU2+JcehI3LOaX5BkNwJRLblrY0cbagILQic
        RqiElXu91Wnj1AhvgvDxpBl8H4wZs16fjHk6JDxf7RHlZytj1RGhivPhRjLqRbQGhMxpEy
        vg/kQ1k3mVm1xZnPUIn7+mrqPqddMnw5g3lnvkbYeAfM5GK9kjiAKhJJO1cRKYHo3CMe2D
        bbcknb4FzDKQZjdNHh8XHtx01Lip0J/J3MtvXpgDJScQb8lF5ZDAXULO+IUJr1FN+XgeG5
        WasYgGIMC0IPIVLI1Q5P/xd2hLixAvMXU+m/Fa8R6mu0GRkyln7ivVnmHKqBqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lSEvjVL+BxuTqhoV6y++5iFzUZwHV0OnCUueADVyxEA=;
        b=r6+fh09oHfENkWCN4lF8MffdwEGUKNIjvSkxoPrQxnv1rhnu/nekiAEHappQ9NFpa+bmJT
        nA9poxy/eDhflsDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Baruch Siach <baruch@tkos.co.il>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard GENOUD <richard.genoud@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 24/74] serial: digicolor: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:41 +0206
Message-Id: <20230914183831.587273-25-john.ogness@linutronix.de>
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
 drivers/tty/serial/digicolor-usart.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/digicolor-usart.c b/drivers/tty/serial/digicolor-usart.c
index 128b5479e813..5004125f3045 100644
--- a/drivers/tty/serial/digicolor-usart.c
+++ b/drivers/tty/serial/digicolor-usart.c
@@ -133,7 +133,7 @@ static void digicolor_uart_rx(struct uart_port *port)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	while (1) {
 		u8 status, ch, ch_flag;
@@ -172,7 +172,7 @@ static void digicolor_uart_rx(struct uart_port *port)
 				 ch_flag);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	tty_flip_buffer_push(&port->state->port);
 }
@@ -185,7 +185,7 @@ static void digicolor_uart_tx(struct uart_port *port)
 	if (digicolor_uart_tx_full(port))
 		return;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (port->x_char) {
 		writeb_relaxed(port->x_char, port->membase + UA_EMI_REC);
@@ -211,7 +211,7 @@ static void digicolor_uart_tx(struct uart_port *port)
 		uart_write_wakeup(port);
 
 out:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static irqreturn_t digicolor_uart_int(int irq, void *dev_id)
@@ -333,7 +333,7 @@ static void digicolor_uart_set_termios(struct uart_port *port,
 		port->ignore_status_mask |= UA_STATUS_OVERRUN_ERR
 			| UA_STATUS_PARITY_ERR | UA_STATUS_FRAME_ERR;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
@@ -341,7 +341,7 @@ static void digicolor_uart_set_termios(struct uart_port *port,
 	writeb_relaxed(divisor & 0xff, port->membase + UA_HBAUD_LO);
 	writeb_relaxed(divisor >> 8, port->membase + UA_HBAUD_HI);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *digicolor_uart_type(struct uart_port *port)
@@ -398,14 +398,14 @@ static void digicolor_uart_console_write(struct console *co, const char *c,
 	int locked = 1;
 
 	if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	uart_console_write(port, c, n, digicolor_uart_console_putchar);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 	/* Wait for transmitter to become empty */
 	do {
-- 
2.39.2

