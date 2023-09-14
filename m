Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856267A0D3D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241974AbjINSll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241971AbjINSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235D52705;
        Thu, 14 Sep 2023 11:39:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4go78jqQjBoLjBGzmCHOv9NrC20UwwVa764/6PmFVf4=;
        b=KycCGl+Z0tSDZryL3lQvmTDKcENvZ0bElfbOFWqhLIP3byAP8mJeI8s7trSAyJ04mQsP2N
        1/M3CFlEDWRY4Z5SF8LpTdGxlleEfdxtDAci9kbM93yX+OoCLRndlWnDkjX9SKjrnzp/5r
        lorsjYHtyFt5l2tvoeCNi95kjntjmBRR2DCVB41fw2zUWbr1VVIhrzZ9cEfdmvwIGCQfMN
        /tQ3hy7AwDUhqDzBhBfrALwSGfKsBc6a3fEJAD01Miv3D8x8TQnVNgKkBI7QOpEW0GQGtN
        DLVoatFnfmYeO9QruW6684ou7F878JmG8Kr9OaSmLDT6TYpvas/aNOo7t/Q32w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716740;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4go78jqQjBoLjBGzmCHOv9NrC20UwwVa764/6PmFVf4=;
        b=0CSYNn68lqfVz1Tm7+KGTJLruBkCCmjvrxg4X3MZa6H8cRhjyOQ8S2f5ycLq3ZJtfVSNjo
        aLXikOoIdOkjNHCA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Thierry Reding <treding@nvidia.com>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH tty v1 52/74] serial: sa1100: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:09 +0206
Message-Id: <20230914183831.587273-53-john.ogness@linutronix.de>
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
 drivers/tty/serial/sa1100.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index ad011f1e2f4d..be7bcd75d9f4 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -115,9 +115,9 @@ static void sa1100_timeout(struct timer_list *t)
 	unsigned long flags;
 
 	if (sport->port.state) {
-		spin_lock_irqsave(&sport->port.lock, flags);
+		uart_port_lock_irqsave(&sport->port, &flags);
 		sa1100_mctrl_check(sport);
-		spin_unlock_irqrestore(&sport->port.lock, flags);
+		uart_port_unlock_irqrestore(&sport->port, flags);
 
 		mod_timer(&sport->timer, jiffies + MCTRL_TIMEOUT);
 	}
@@ -247,7 +247,7 @@ static irqreturn_t sa1100_int(int irq, void *dev_id)
 	struct sa1100_port *sport = dev_id;
 	unsigned int status, pass_counter = 0;
 
-	spin_lock(&sport->port.lock);
+	uart_port_lock(&sport->port);
 	status = UART_GET_UTSR0(sport);
 	status &= SM_TO_UTSR0(sport->port.read_status_mask) | ~UTSR0_TFS;
 	do {
@@ -276,7 +276,7 @@ static irqreturn_t sa1100_int(int irq, void *dev_id)
 		status &= SM_TO_UTSR0(sport->port.read_status_mask) |
 			  ~UTSR0_TFS;
 	} while (status & (UTSR0_TFS | UTSR0_RFS | UTSR0_RID));
-	spin_unlock(&sport->port.lock);
+	uart_port_unlock(&sport->port);
 
 	return IRQ_HANDLED;
 }
@@ -321,14 +321,14 @@ static void sa1100_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int utcr3;
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 	utcr3 = UART_GET_UTCR3(sport);
 	if (break_state == -1)
 		utcr3 |= UTCR3_BRK;
 	else
 		utcr3 &= ~UTCR3_BRK;
 	UART_PUT_UTCR3(sport, utcr3);
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static int sa1100_startup(struct uart_port *port)
@@ -354,9 +354,9 @@ static int sa1100_startup(struct uart_port *port)
 	/*
 	 * Enable modem status interrupts
 	 */
-	spin_lock_irq(&sport->port.lock);
+	uart_port_lock_irq(&sport->port);
 	sa1100_enable_ms(&sport->port);
-	spin_unlock_irq(&sport->port.lock);
+	uart_port_unlock_irq(&sport->port);
 
 	return 0;
 }
@@ -423,7 +423,7 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 
 	del_timer_sync(&sport->timer);
 
-	spin_lock_irqsave(&sport->port.lock, flags);
+	uart_port_lock_irqsave(&sport->port, &flags);
 
 	sport->port.read_status_mask &= UTSR0_TO_SM(UTSR0_TFS);
 	sport->port.read_status_mask |= UTSR1_TO_SM(UTSR1_ROR);
@@ -485,7 +485,7 @@ sa1100_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (UART_ENABLE_MS(&sport->port, termios->c_cflag))
 		sa1100_enable_ms(&sport->port);
 
-	spin_unlock_irqrestore(&sport->port.lock, flags);
+	uart_port_unlock_irqrestore(&sport->port, flags);
 }
 
 static const char *sa1100_type(struct uart_port *port)
-- 
2.39.2

