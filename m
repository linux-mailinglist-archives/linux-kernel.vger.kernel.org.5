Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E69F7A0D0A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241814AbjINSjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241748AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049F1FFF;
        Thu, 14 Sep 2023 11:38:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnvnRSzrP5woiUHdOlb0Xg3fIJh3UJCjsy6M4up7fns=;
        b=q3Pkc5q153R9B4lAEoaA19W6MCMs6e7mCMtjnfPCoSu5uskZO70YiNFkdi4cc2AiIdF44X
        xMN/yA0YBtf1rAThdjz4/pj0TN952tVmeDh4LfVuzsehKXBkDYjOjivfsFWjHiND1aoCDR
        vOZihjkxvwaVoFclY/TK4PPQec6xJixb03Sgeu8bZAxp2rNnEF/LwPJfUSJMiKC6sekAar
        DMNKKY5hA3CkE8EqATl34e8U6c3UqqVj7GF22fSwM5KGL8t90o0+uh92rOgF6yoH2pv3OJ
        JyFF3Qy8mEpw8dfdii/p/yOitx+q9v/ismffS6J7mEVMch28sWMu9yb7W2uvAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LnvnRSzrP5woiUHdOlb0Xg3fIJh3UJCjsy6M4up7fns=;
        b=5doHq489JrJleGSPjVe5kdeivGhy0qLN1gSxtjdAKVkc4V0xuC8emnUqbt0JJUzhj7NGUS
        pfM2wQcP0bLD79Bw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Yangtao Li <frank.li@vivo.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH tty v1 26/74] serial: linflexuart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:43 +0206
Message-Id: <20230914183831.587273-27-john.ogness@linutronix.de>
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
 drivers/tty/serial/fsl_linflexuart.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 249cb380c3c6..7fa809a405e8 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -203,7 +203,7 @@ static irqreturn_t linflex_txint(int irq, void *dev_id)
 	struct circ_buf *xmit = &sport->state->xmit;
 	unsigned long flags;
 
-	spin_lock_irqsave(&sport->lock, flags);
+	uart_port_lock_irqsave(sport, &flags);
 
 	if (sport->x_char) {
 		linflex_put_char(sport, sport->x_char);
@@ -217,7 +217,7 @@ static irqreturn_t linflex_txint(int irq, void *dev_id)
 
 	linflex_transmit_buffer(sport);
 out:
-	spin_unlock_irqrestore(&sport->lock, flags);
+	uart_port_unlock_irqrestore(sport, flags);
 	return IRQ_HANDLED;
 }
 
@@ -230,7 +230,7 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id)
 	unsigned char rx;
 	bool brk;
 
-	spin_lock_irqsave(&sport->lock, flags);
+	uart_port_lock_irqsave(sport, &flags);
 
 	status = readl(sport->membase + UARTSR);
 	while (status & LINFLEXD_UARTSR_RMB) {
@@ -266,7 +266,7 @@ static irqreturn_t linflex_rxint(int irq, void *dev_id)
 		}
 	}
 
-	spin_unlock_irqrestore(&sport->lock, flags);
+	uart_port_unlock_irqrestore(sport, flags);
 
 	tty_flip_buffer_push(port);
 
@@ -369,11 +369,11 @@ static int linflex_startup(struct uart_port *port)
 	int ret = 0;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	linflex_setup_watermark(port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	ret = devm_request_irq(port->dev, port->irq, linflex_int, 0,
 			       DRIVER_NAME, port);
@@ -386,14 +386,14 @@ static void linflex_shutdown(struct uart_port *port)
 	unsigned long ier;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* disable interrupts */
 	ier = readl(port->membase + LINIER);
 	ier &= ~(LINFLEXD_LINIER_DRIE | LINFLEXD_LINIER_DTIE);
 	writel(ier, port->membase + LINIER);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	devm_free_irq(port->dev, port->irq, port);
 }
@@ -474,7 +474,7 @@ linflex_set_termios(struct uart_port *port, struct ktermios *termios,
 		cr &= ~LINFLEXD_UARTCR_PCE;
 	}
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	port->read_status_mask = 0;
 
@@ -507,7 +507,7 @@ linflex_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	writel(cr1, port->membase + LINCR1);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *linflex_type(struct uart_port *port)
@@ -646,14 +646,14 @@ linflex_console_write(struct console *co, const char *s, unsigned int count)
 	if (sport->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&sport->lock, flags);
+		locked = uart_port_trylock_irqsave(sport, &flags);
 	else
-		spin_lock_irqsave(&sport->lock, flags);
+		uart_port_lock_irqsave(sport, &flags);
 
 	linflex_string_write(sport, s, count);
 
 	if (locked)
-		spin_unlock_irqrestore(&sport->lock, flags);
+		uart_port_unlock_irqrestore(sport, flags);
 }
 
 /*
-- 
2.39.2

