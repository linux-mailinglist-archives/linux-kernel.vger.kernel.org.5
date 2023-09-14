Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E713C7A0D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242040AbjINSkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241740AbjINSjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997702683;
        Thu, 14 Sep 2023 11:38:54 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xu+MA3nvAGpQibJHqwBXfavhwazXxpOBvYT7SUXxurg=;
        b=VNedMCHdngMxNzKkI4Tk3e/Scyd10wBR9UsJz4Nv9l3mO40AvsIaYB5UO8o6dA/4/jwD5J
        iOCuPIyDf16h72BERJcVXy0VZ8a6A3zmwzjMPFpuLjj9OyfkzzeRQXOKaPMUpDV2fULhy8
        cGnJl0BWhMxtQC9bl5QNvRo0WWzmM/QKhUAxbsaRPX/uxVCjwzMn6eCyLOAR9nnTZBLmGF
        VQD1UySg+AtbVJpq2cc+vjZB4BINNtIEFjbBtzLV5e4b7IH+k1u/ONNntwWMv8CEHhCQ7w
        s+awbpMjvgek91Sh+gVYrmY3I8Bui727eu0LEcRwRdJMrrXD97PtfYhQv0hLOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716733;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xu+MA3nvAGpQibJHqwBXfavhwazXxpOBvYT7SUXxurg=;
        b=BDeS7WcDlvoxrWV5nRJyybaIh6Ix6LKXdIjVcLazyjC0Pcx+K4Imt04CGw4/ALxm62UPmZ
        PGHFzBpNpEyz6ECQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH tty v1 36/74] serial: men_z135_uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:53 +0206
Message-Id: <20230914183831.587273-37-john.ogness@linutronix.de>
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
 drivers/tty/serial/men_z135_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/men_z135_uart.c b/drivers/tty/serial/men_z135_uart.c
index d2502aaa3e8c..8048fa542fc4 100644
--- a/drivers/tty/serial/men_z135_uart.c
+++ b/drivers/tty/serial/men_z135_uart.c
@@ -392,7 +392,7 @@ static irqreturn_t men_z135_intr(int irq, void *data)
 	if (!irq_id)
 		goto out;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	/* It's save to write to IIR[7:6] RXC[9:8] */
 	iowrite8(irq_id, port->membase + MEN_Z135_STAT_REG);
 
@@ -418,7 +418,7 @@ static irqreturn_t men_z135_intr(int irq, void *data)
 		handled = true;
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 out:
 	return IRQ_RETVAL(handled);
 }
@@ -708,7 +708,7 @@ static void men_z135_set_termios(struct uart_port *port,
 
 	baud = uart_get_baud_rate(port, termios, old, 0, uart_freq / 16);
 
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	if (tty_termios_baud_rate(termios))
 		tty_termios_encode_baud_rate(termios, baud, baud);
 
@@ -716,7 +716,7 @@ static void men_z135_set_termios(struct uart_port *port,
 	iowrite32(bd_reg, port->membase + MEN_Z135_BAUD_REG);
 
 	uart_update_timeout(port, termios->c_cflag, baud);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 }
 
 static const char *men_z135_type(struct uart_port *port)
-- 
2.39.2

