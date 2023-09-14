Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4416C7A0D53
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242187AbjINSmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241893AbjINSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:40:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AE482D46;
        Thu, 14 Sep 2023 11:39:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scaU8Ke6aOSrJaDl+5gO/v/Oetd46gqnVkH3I+dMdgg=;
        b=Mj0+Pe00fFVsZ6+hpkjEb3RIQOukUDP/nj1KpIONzsm0lww8nBluFaZ+8hIg2znuQmiWH4
        vNAWfweVOIIC3hs2ouo/HTGnWFvKQTHnVTL06YlCaX7vMbezkTePgE6J74dkWomiuMqOQQ
        ru3qVZ30o2933msd35CcKWgDiDbRkpKnZ6kwgeMewj8MJZ46Z7eU9Rt60frRbKszO1uaTA
        hpQQwZs7tW5WJhj9LsMLqxu+1k4qsB1GmAK5HGTKrdsk7r+VxD8/eIDo1aoHemxCxRLDYZ
        g0ZJ1ORRCqncjJTriPe2+NnN37tZDQIFBOsGczeAAbY8U4yjZCiTZl5ndWA/ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=scaU8Ke6aOSrJaDl+5gO/v/Oetd46gqnVkH3I+dMdgg=;
        b=QKNzNzgHqgZN0A8MG25uklYWnJo/RRItn+QWlEUJLX2q9Iyh5vLVHi37d5Blz4HXcuFPVr
        fGe1OYlr4ZvZWSBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH tty v1 63/74] serial: st-asc: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:20 +0206
Message-Id: <20230914183831.587273-64-john.ogness@linutronix.de>
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
 drivers/tty/serial/st-asc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index 92b9f6894006..a821f5d76a26 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -319,7 +319,7 @@ static irqreturn_t asc_interrupt(int irq, void *ptr)
 	struct uart_port *port = ptr;
 	u32 status;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	status = asc_in(port, ASC_STA);
 
@@ -334,7 +334,7 @@ static irqreturn_t asc_interrupt(int irq, void *ptr)
 		asc_transmit_chars(port);
 	}
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -452,10 +452,10 @@ static void asc_pm(struct uart_port *port, unsigned int state,
 		 * we can come to turning it off. Note this is not called with
 		 * the port spinlock held.
 		 */
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		ctl = asc_in(port, ASC_CTL) & ~ASC_CTL_RUN;
 		asc_out(port, ASC_CTL, ctl);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		clk_disable_unprepare(ascport->clk);
 		break;
 	}
@@ -480,7 +480,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk/16);
 	cflag = termios->c_cflag;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* read control register */
 	ctrl_val = asc_in(port, ASC_CTL);
@@ -594,7 +594,7 @@ static void asc_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* write final value and enable port */
 	asc_out(port, ASC_CTL, (ctrl_val | ASC_CTL_RUN));
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *asc_type(struct uart_port *port)
@@ -849,9 +849,9 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
 	if (port->sysrq)
 		locked = 0; /* asc_interrupt has already claimed the lock */
 	else if (oops_in_progress)
-		locked = spin_trylock_irqsave(&port->lock, flags);
+		locked = uart_port_trylock_irqsave(port, &flags);
 	else
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Disable interrupts so we don't get the IRQ line bouncing
@@ -869,7 +869,7 @@ static void asc_console_write(struct console *co, const char *s, unsigned count)
 	asc_out(port, ASC_INTEN, intenable);
 
 	if (locked)
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 }
 
 static int asc_console_setup(struct console *co, char *options)
-- 
2.39.2

