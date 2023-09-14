Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B06A27A0D4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242027AbjINSmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjINSkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:40:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618CB2721;
        Thu, 14 Sep 2023 11:39:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftoYF3ysXZRgd7029hIddGE6TugW7j1R0akznX06Mek=;
        b=AVsgLhp3emlP/RNgitQPW0uhlds6RD4TU4dct35DRx4bNvQKUbjV8C0drufMaiZ0wIihGa
        TWkE52zfn+HIgR6AuRGV2UrROOAZDWRb0IAuAbpAr5VC/Gh442FopUkwW7O+kRKLfTSHHx
        G/fv9sc1lIhZ7fEu2Oniebv2c8pgfU42cXr40v4cri1R0iln1kpbKNFOdKg4yETrJ64mJE
        kgAd6H3xwAKOH8C9w1FbP6P99Y8wCDfoYJ/vhVVOjjgenhJzWwGHEeZaBWZ/Thrlwi+1cQ
        6/GmbmC7aQi/G43VolWTa3jdAOttDC56MXk9R4ZmUBXk9mAekCVd3QZoigP2EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ftoYF3ysXZRgd7029hIddGE6TugW7j1R0akznX06Mek=;
        b=v+V76Qzo12KFfI6gBWpLLNJ0z4vydANWQYRetphYnTZH8vxTQOViwIGVEpH6m5HJPH43Ws
        Y+xUKDucxO8n7uCA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Richard GENOUD <richard.genoud@gmail.com>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH tty v1 59/74] serial: txx9: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:16 +0206
Message-Id: <20230914183831.587273-60-john.ogness@linutronix.de>
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
 drivers/tty/serial/serial_txx9.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index be08fb6f749c..eaa980722455 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -335,13 +335,13 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 	unsigned int status;
 
 	while (1) {
-		spin_lock(&up->lock);
+		uart_port_lock(up);
 		status = sio_in(up, TXX9_SIDISR);
 		if (!(sio_in(up, TXX9_SIDICR) & TXX9_SIDICR_TIE))
 			status &= ~TXX9_SIDISR_TDIS;
 		if (!(status & (TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
 				TXX9_SIDISR_TOUT))) {
-			spin_unlock(&up->lock);
+			uart_port_unlock(up);
 			break;
 		}
 
@@ -353,7 +353,7 @@ static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
 		sio_mask(up, TXX9_SIDISR,
 			 TXX9_SIDISR_TDIS | TXX9_SIDISR_RDIS |
 			 TXX9_SIDISR_TOUT);
-		spin_unlock(&up->lock);
+		uart_port_unlock(up);
 
 		if (pass_counter++ > PASS_LIMIT)
 			break;
@@ -367,9 +367,9 @@ static unsigned int serial_txx9_tx_empty(struct uart_port *up)
 	unsigned long flags;
 	unsigned int ret;
 
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 	ret = (sio_in(up, TXX9_SICISR) & TXX9_SICISR_TXALS) ? TIOCSER_TEMT : 0;
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 
 	return ret;
 }
@@ -399,12 +399,12 @@ static void serial_txx9_break_ctl(struct uart_port *up, int break_state)
 {
 	unsigned long flags;
 
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 	if (break_state == -1)
 		sio_set(up, TXX9_SIFLCR, TXX9_SIFLCR_TBRK);
 	else
 		sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_TBRK);
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 }
 
 #if defined(CONFIG_SERIAL_TXX9_CONSOLE) || defined(CONFIG_CONSOLE_POLL)
@@ -517,9 +517,9 @@ static int serial_txx9_startup(struct uart_port *up)
 	/*
 	 * Now, initialize the UART
 	 */
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 	serial_txx9_set_mctrl(up, up->mctrl);
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 
 	/* Enable RX/TX */
 	sio_mask(up, TXX9_SIFLCR, TXX9_SIFLCR_RSDE | TXX9_SIFLCR_TSDE);
@@ -541,9 +541,9 @@ static void serial_txx9_shutdown(struct uart_port *up)
 	 */
 	sio_out(up, TXX9_SIDICR, 0);	/* disable all intrs */
 
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 	serial_txx9_set_mctrl(up, up->mctrl);
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 
 	/*
 	 * Disable break condition
@@ -625,7 +625,7 @@ serial_txx9_set_termios(struct uart_port *up, struct ktermios *termios,
 	 * Ok, we're now changing the port state.  Do it with
 	 * interrupts disabled.
 	 */
-	spin_lock_irqsave(&up->lock, flags);
+	uart_port_lock_irqsave(up, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -676,7 +676,7 @@ serial_txx9_set_termios(struct uart_port *up, struct ktermios *termios,
 	sio_out(up, TXX9_SIFCR, fcr);
 
 	serial_txx9_set_mctrl(up, up->mctrl);
-	spin_unlock_irqrestore(&up->lock, flags);
+	uart_port_unlock_irqrestore(up, flags);
 }
 
 static void
-- 
2.39.2

