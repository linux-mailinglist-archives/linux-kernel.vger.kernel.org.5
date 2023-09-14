Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C95A7A0CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241911AbjINSjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241641AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB42108;
        Thu, 14 Sep 2023 11:38:46 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/K94+x3VFE0qetYCzTIZYxK3St4nQt/7CBPmZkbDy0=;
        b=uXRvCbL7vfpBV5pZH3vtwjfrVzht6pNDjcB+IJ3mBgRurMU50xvCNJEblOFTzf5irLDRjL
        pK76Su5YXYdA96s7uTDL+TFhhIFShdvVvONxSYP8omoCujJKqeMxXR1eyZRSFbobsWrIUy
        PuruvXaJ+DSg6ucY45X9NISbI6TdO8NKvT7EaEN0vq/wjQpTOyIpE1dcb3b8Labtt7mgRP
        Z2gy2rBsZLF+77grTxPukz/I4i9bhDYeGjM164jFavZhuLVZBbvs1yKX5To7smV47VRwCg
        +pjT5c+alUEEPBMvhp2oaxk0qX/zXSVkiWZCDQktM/QzpgMdFU6AHyBmufwnTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/K94+x3VFE0qetYCzTIZYxK3St4nQt/7CBPmZkbDy0=;
        b=0eCUUL3vP8dQK2rfMC19TJ15tM6G1CJryy1OXDnP7smmbsbckCADcGIX4LYSmlXekjyfbx
        1PiS2o1fQDOXmFCg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Tobias Klauser <tklauser@distanz.ch>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH tty v1 16/74] serial: amba-pl010: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:33 +0206
Message-Id: <20230914183831.587273-17-john.ogness@linutronix.de>
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
 drivers/tty/serial/amba-pl010.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index b5a7404cbacb..eabbf8afc9b5 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -207,7 +207,7 @@ static irqreturn_t pl010_int(int irq, void *dev_id)
 	unsigned int status, pass_counter = AMBA_ISR_PASS_LIMIT;
 	int handled = 0;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	status = readb(port->membase + UART010_IIR);
 	if (status) {
@@ -228,7 +228,7 @@ static irqreturn_t pl010_int(int irq, void *dev_id)
 		handled = 1;
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_RETVAL(handled);
 }
@@ -270,14 +270,14 @@ static void pl010_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int lcr_h;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	lcr_h = readb(port->membase + UART010_LCRH);
 	if (break_state == -1)
 		lcr_h |= UART01x_LCRH_BRK;
 	else
 		lcr_h &= ~UART01x_LCRH_BRK;
 	writel(lcr_h, port->membase + UART010_LCRH);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int pl010_startup(struct uart_port *port)
@@ -385,7 +385,7 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (port->fifosize > 1)
 		lcr_h |= UART01x_LCRH_FEN;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -438,22 +438,22 @@ pl010_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(lcr_h, port->membase + UART010_LCRH);
 	writel(old_cr, port->membase + UART010_CR);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static void pl010_set_ldisc(struct uart_port *port, struct ktermios *termios)
 {
 	if (termios->c_line == N_PPS) {
 		port->flags |= UPF_HARDPPS_CD;
-		spin_lock_irq(&port->lock);
+		uart_port_lock_irq(port);
 		pl010_enable_ms(port);
-		spin_unlock_irq(&port->lock);
+		uart_port_unlock_irq(port);
 	} else {
 		port->flags &= ~UPF_HARDPPS_CD;
 		if (!UART_ENABLE_MS(port, termios->c_cflag)) {
-			spin_lock_irq(&port->lock);
+			uart_port_lock_irq(port);
 			pl010_disable_ms(port);
-			spin_unlock_irq(&port->lock);
+			uart_port_unlock_irq(port);
 		}
 	}
 }
-- 
2.39.2

