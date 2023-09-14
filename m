Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D127A0D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241927AbjINSk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241900AbjINSjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C196426A0;
        Thu, 14 Sep 2023 11:38:58 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEegAouA6je3osDZUCJlEv4gB4p0igZuWACS++cZC6E=;
        b=P6M8uOs7G9Yh2dc008zF0jwOKeRh+0hdHCSyzdlotOmY0uNzJhA9n/z2Ghgw0hLD3btQN0
        LU0PJMIUqY+PNsWpCt8Fgdf7vWhYkHrdBWXJKxjWs1S5osrUX1XYS+GxDXNIcZv0LNbInJ
        KyKAiaExHWIPnNXtopgW1ACgnMGNr2MU4hazjKE35Jr75Mq5heJ3rQ7TobgjB2ZOy1WOTs
        yRaZhaIr9Eg0ziMUyc7mkzNOKXtx9BXRb+CFh6CXdTf2hX6pmnGMnuLJZ/wuwmsSBL9NnF
        2KwNuGN7Ys5NqQfLHT5AFK9JO+piH7H+1QZoujzVSxRXEdHXdAdeCPR0oEouzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716737;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wEegAouA6je3osDZUCJlEv4gB4p0igZuWACS++cZC6E=;
        b=uBA+txHp6Ix/jsJ7gls3Uu83I1iuB3Kr/xTO5a038wo1mz94ZF0uGirU+OK9B6vKmLEgmR
        viMGeXnBcms8HvDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org
Subject: [PATCH tty v1 44/74] serial: owl: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:01 +0206
Message-Id: <20230914183831.587273-45-john.ogness@linutronix.de>
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
 drivers/tty/serial/owl-uart.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index e99970a9437f..919f5e5aa0f1 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -125,12 +125,12 @@ static unsigned int owl_uart_tx_empty(struct uart_port *port)
 	u32 val;
 	unsigned int ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = owl_uart_read(port, OWL_UART_STAT);
 	ret = (val & OWL_UART_STAT_TFES) ? TIOCSER_TEMT : 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return ret;
 }
@@ -232,7 +232,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	unsigned long flags;
 	u32 stat;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	stat = owl_uart_read(port, OWL_UART_STAT);
 
@@ -246,7 +246,7 @@ static irqreturn_t owl_uart_irq(int irq, void *dev_id)
 	stat |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP;
 	owl_uart_write(port, stat, OWL_UART_STAT);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -256,14 +256,14 @@ static void owl_uart_shutdown(struct uart_port *port)
 	u32 val;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = owl_uart_read(port, OWL_UART_CTL);
 	val &= ~(OWL_UART_CTL_TXIE | OWL_UART_CTL_RXIE
 		| OWL_UART_CTL_TXDE | OWL_UART_CTL_RXDE | OWL_UART_CTL_EN);
 	owl_uart_write(port, val, OWL_UART_CTL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	free_irq(port->irq, port);
 }
@@ -279,7 +279,7 @@ static int owl_uart_startup(struct uart_port *port)
 	if (ret)
 		return ret;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	val = owl_uart_read(port, OWL_UART_STAT);
 	val |= OWL_UART_STAT_RIP | OWL_UART_STAT_TIP
@@ -291,7 +291,7 @@ static int owl_uart_startup(struct uart_port *port)
 	val |= OWL_UART_CTL_EN;
 	owl_uart_write(port, val, OWL_UART_CTL);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return 0;
 }
@@ -311,7 +311,7 @@ static void owl_uart_set_termios(struct uart_port *port,
 	u32 ctl;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	ctl = owl_uart_read(port, OWL_UART_CTL);
 
@@ -371,7 +371,7 @@ static void owl_uart_set_termios(struct uart_port *port,
 
 	uart_update_timeout(port, termios->c_cflag, baud);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void owl_uart_release_port(struct uart_port *port)
@@ -515,9 +515,9 @@ static void owl_uart_port_write(struct uart_port *port, const char *s,
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = uart_port_trylock(port);
 	else {
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		locked = 1;
 	}
 
@@ -541,7 +541,7 @@ static void owl_uart_port_write(struct uart_port *port, const char *s,
 	owl_uart_write(port, old_ctl, OWL_UART_CTL);
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.39.2

