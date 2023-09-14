Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EA57A0D6D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:44:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242044AbjINSoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242184AbjINSmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:42:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C532430F6;
        Thu, 14 Sep 2023 11:39:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrDPhfR+hcH2ulqT+tmz0NkOOAInrrikJFQ9+rrgXq4=;
        b=KfjPbYSme07Uy0HtarpcBzSFQ1/rLTznLPx3w1c4fArr0Y5kGtKzI/Ul9ouwJRXdZeU/J2
        nadN6L18ZJIEZd4/qd77a5MMYgHznr/VdEX4YaV6YEVQg226CMthIInseqEgsZrt2JU/SM
        hrvtG4v2A0Aab0JSgQ/X2uc19tg5cN7/KsBEEnvqHijZr/ddzu7OZp4NR0MuQksSw5xf4H
        1FvccofeL0vCGlTQQkCd1W6zru71arQ7y6L7TSn3XqKLX1H/RoT2P0vGRJJ8EmEGrSaGYG
        fykGh54wuVQ019BCJGhN5qdhXCIQatyCIpCafbGGWbvjoPvfFCdXRsxKA0zSAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rrDPhfR+hcH2ulqT+tmz0NkOOAInrrikJFQ9+rrgXq4=;
        b=zw8NaAfgbtDwAq7EKORtMTWehRQcY0jJ9It/03eZCA4UwTMGL31oJD/g86N0no8XkSo7er
        qKWevdh86PM28vAg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Yangtao Li <frank.li@vivo.com>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 73/74] serial: vt8500: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:30 +0206
Message-Id: <20230914183831.587273-74-john.ogness@linutronix.de>
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
 drivers/tty/serial/vt8500_serial.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index c5d5c2765119..78a1c1eea11b 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -227,7 +227,7 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned long isr;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 	isr = vt8500_read(port, VT8500_URISR);
 
 	/* Acknowledge active status bits */
@@ -240,7 +240,7 @@ static irqreturn_t vt8500_irq(int irq, void *dev_id)
 	if (isr & TCTS)
 		handle_delta_cts(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -342,7 +342,7 @@ static void vt8500_set_termios(struct uart_port *port,
 	unsigned int baud, lcr;
 	unsigned int loops = 1000;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* calculate and set baud rate */
 	baud = uart_get_baud_rate(port, termios, old, 900, 921600);
@@ -410,7 +410,7 @@ static void vt8500_set_termios(struct uart_port *port,
 	vt8500_write(&vt8500_port->uart, 0x881, VT8500_URFCR);
 	vt8500_write(&vt8500_port->uart, vt8500_port->ier, VT8500_URIER);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *vt8500_type(struct uart_port *port)
-- 
2.39.2

