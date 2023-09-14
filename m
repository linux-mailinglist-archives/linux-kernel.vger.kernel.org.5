Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF35D7A0D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241887AbjINSjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241716AbjINSi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C912118;
        Thu, 14 Sep 2023 11:38:49 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJInWHcVqt4j3eK/rdEfaKxcD8K2U9aP/8B1IuSlnT4=;
        b=WJ4kvtW/Klk/02gMpc/36dTKSEBiKrsPeyQpTm47TyugrlRa3xSvyphTVBdLWkj9HyCEXy
        Qe6cvcJeo0g78iUJIHJ59KvdU2Tzmku8IDNIqcDv98mhoyIy4h4P7uN8ZayAi7WW0zbV3S
        QLxLZhkPt7PiZqd3EdZYLSDFyPr+PkYSQDb4G7uhGDD3CMBUYreQygN79bpiL40W4Rs9Y6
        ocWTdUS6+trFldWScC3epmB+dXCmQ4s+Q3VTeSUyjKard3ZefZVNEQbNoq/YVy7oXenGlw
        1Yelc3nlPF6ymmmW123ooVQ6AUTo5qZjHXN+fLKHHED4EBKaYfKDxSp09jt9ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YJInWHcVqt4j3eK/rdEfaKxcD8K2U9aP/8B1IuSlnT4=;
        b=qzZ73KVlbH94C0/unIwHIzsufL+EDGFyJaBMYq/cOVMeReYLKBF1RMmw+o04bW9Lq3Rw26
        oUJdipfVYni+ihDg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH tty v1 23/74] serial: cpm_uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:40 +0206
Message-Id: <20230914183831.587273-24-john.ogness@linutronix.de>
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
 drivers/tty/serial/cpm_uart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart.c b/drivers/tty/serial/cpm_uart.c
index 626423022d62..be4af6eda4c2 100644
--- a/drivers/tty/serial/cpm_uart.c
+++ b/drivers/tty/serial/cpm_uart.c
@@ -569,7 +569,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 	if ((termios->c_cflag & CREAD) == 0)
 		port->read_status_mask &= ~BD_SC_EMPTY;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (IS_SMC(pinfo)) {
 		unsigned int bits = tty_get_frame_size(termios->c_cflag);
@@ -609,7 +609,7 @@ static void cpm_uart_set_termios(struct uart_port *port,
 		clk_set_rate(pinfo->clk, baud);
 	else
 		cpm_setbrg(pinfo->brg - 1, baud);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *cpm_uart_type(struct uart_port *port)
@@ -1386,9 +1386,9 @@ static void cpm_uart_console_write(struct console *co, const char *s,
 		cpm_uart_early_write(pinfo, s, count, true);
 		local_irq_restore(flags);
 	} else {
-		spin_lock_irqsave(&pinfo->port.lock, flags);
+		uart_port_lock_irqsave(&pinfo->port, &flags);
 		cpm_uart_early_write(pinfo, s, count, true);
-		spin_unlock_irqrestore(&pinfo->port.lock, flags);
+		uart_port_unlock_irqrestore(&pinfo->port, flags);
 	}
 }
 
-- 
2.39.2

