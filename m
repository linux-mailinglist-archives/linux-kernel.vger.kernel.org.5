Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B3D7A0D21
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbjINSkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241837AbjINSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F152101;
        Thu, 14 Sep 2023 11:38:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpMKqxP39Aj1OlB9VqwDRJumN0r6uN84lHL1pDkCQeE=;
        b=Pp/OGmDj8bMmAT9eZ1ySXB//R2G1FfxBh2rCko4qVh2BdTqpXFvZH3XdSA8/Dt5Rmy8Xmf
        Au2vkXb+sOqd+lUM/wW0LbwmWUmMOItZJ8aipSq6my6kzxRdncDlAzKGX/5t978GKcPpId
        vZuu2M33td/NUSKgQytJNEGeKqPiPmbK4DA/bL/wwv3GrvnJEBHahKvpM5Yf3n4o/QOkdO
        m4wjj2Hih6J8cHfLNftCsYGbNH7EWimZgfNjdcCDHyZIyg2Fjvpwj4604kGsuT3NG6etBN
        JVkGl0gcbLCwXXpWEhYVVwheb41Efq8+HkhAIy2JqF9LjKS6d7HlbaqVUwU6mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hpMKqxP39Aj1OlB9VqwDRJumN0r6uN84lHL1pDkCQeE=;
        b=uwgakoj7fG2f6H2ApkMwkAjT0yD56cfGqEkV4wd0dDYU1DBAjq1VStA47ABhHB07vJ5t/R
        jbBg9GaiGCJPACDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH tty v1 39/74] serial: mpc52xx: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:56 +0206
Message-Id: <20230914183831.587273-40-john.ogness@linutronix.de>
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
 drivers/tty/serial/mpc52xx_uart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 916507b8f31d..a252465e745f 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1096,14 +1096,14 @@ static void
 mpc52xx_uart_break_ctl(struct uart_port *port, int ctl)
 {
 	unsigned long flags;
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (ctl == -1)
 		psc_ops->command(port, MPC52xx_PSC_START_BRK);
 	else
 		psc_ops->command(port, MPC52xx_PSC_STOP_BRK);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int
@@ -1214,7 +1214,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	}
 
 	/* Get the lock */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Do our best to flush TX & RX, so we don't lose anything */
 	/* But we don't wait indefinitely ! */
@@ -1250,7 +1250,7 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	psc_ops->command(port, MPC52xx_PSC_RX_ENABLE);
 
 	/* We're all set, release the lock */
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *
@@ -1477,11 +1477,11 @@ mpc52xx_uart_int(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	irqreturn_t ret;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	ret = psc_ops->handle_irq(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return ret;
 }
-- 
2.39.2

