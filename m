Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CADE7A0D11
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbjINSkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241757AbjINSi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681ED2125;
        Thu, 14 Sep 2023 11:38:51 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0GmIFy0BH/+UTBQ4ZgVoWD6SiHe6dj4MJtGxMeb4ws=;
        b=N3bXQSCuQqc8ZLKWNuSbsQh7s7GqgSxbmBWpOzM9sEk6QHKWFEbtJOQLKyhKgXthD9Z6vw
        ZqclHiaYgbzHM0EkyRHODr40EGhks6Ju4+uvFCoIRWJsyRuJYJpPhSHmQ6zqkXWlF18uyJ
        Lp3HCPZSY+gJOB8qgK+mgJr7AYWaFTDqMOzoJkrVkA0EQqiC65VBkRuYeSOpsPPovK9u2W
        29CsI2YCrMnYaWb9KnFApf2pxhU3wohFLaS6s+2Fw/Bk1HVYtS4PMXZi3hQ2b0agOB9WHO
        C05OnXJBHopj2iAT5w8ofAESrUqG6Eg80MVy7P4n9F+iazL12dExxlWI+zVnnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j0GmIFy0BH/+UTBQ4ZgVoWD6SiHe6dj4MJtGxMeb4ws=;
        b=BEtIV40ZqaqgdYy1xbSsLLBt/nj7SKd222LHGiscOOSPR6hoLSqDxmWjaHKcOd7VyYnEHr
        2AjDPLb8eakwGnBw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty v1 28/74] serial: icom: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:45 +0206
Message-Id: <20230914183831.587273-29-john.ogness@linutronix.de>
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
 drivers/tty/serial/icom.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/icom.c b/drivers/tty/serial/icom.c
index 819f957b6b84..a75eafbcbea3 100644
--- a/drivers/tty/serial/icom.c
+++ b/drivers/tty/serial/icom.c
@@ -929,7 +929,7 @@ static inline void check_modem_status(struct icom_port *icom_port)
 	char delta_status;
 	unsigned char status;
 
-	spin_lock(&icom_port->uart_port.lock);
+	uart_port_lock(&icom_port->uart_port);
 
 	/*modem input register */
 	status = readb(&icom_port->dram->isr);
@@ -951,7 +951,7 @@ static inline void check_modem_status(struct icom_port *icom_port)
 				      port.delta_msr_wait);
 		old_status = status;
 	}
-	spin_unlock(&icom_port->uart_port.lock);
+	uart_port_unlock(&icom_port->uart_port);
 }
 
 static void xmit_interrupt(u16 port_int_reg, struct icom_port *icom_port)
@@ -1093,7 +1093,7 @@ static void process_interrupt(u16 port_int_reg,
 			      struct icom_port *icom_port)
 {
 
-	spin_lock(&icom_port->uart_port.lock);
+	uart_port_lock(&icom_port->uart_port);
 	trace(icom_port, "INTERRUPT", port_int_reg);
 
 	if (port_int_reg & (INT_XMIT_COMPLETED | INT_XMIT_DISABLED))
@@ -1102,7 +1102,7 @@ static void process_interrupt(u16 port_int_reg,
 	if (port_int_reg & INT_RCV_COMPLETED)
 		recv_interrupt(port_int_reg, icom_port);
 
-	spin_unlock(&icom_port->uart_port.lock);
+	uart_port_unlock(&icom_port->uart_port);
 }
 
 static irqreturn_t icom_interrupt(int irq, void *dev_id)
@@ -1186,14 +1186,14 @@ static unsigned int icom_tx_empty(struct uart_port *port)
 	int ret;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	if (le16_to_cpu(icom_port->statStg->xmit[0].flags) &
 	    SA_FLAGS_READY_TO_XMIT)
 		ret = TIOCSER_TEMT;
 	else
 		ret = 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 	return ret;
 }
 
@@ -1276,7 +1276,7 @@ static void icom_send_xchar(struct uart_port *port, char ch)
 
 	/* wait .1 sec to send char */
 	for (index = 0; index < 10; index++) {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		xdata = readb(&icom_port->dram->xchar);
 		if (xdata == 0x00) {
 			trace(icom_port, "QUICK_WRITE", 0);
@@ -1284,10 +1284,10 @@ static void icom_send_xchar(struct uart_port *port, char ch)
 
 			/* flush write operation */
 			xdata = readb(&icom_port->dram->xchar);
-			spin_unlock_irqrestore(&port->lock, flags);
+			uart_port_unlock_irqrestore(port, flags);
 			break;
 		}
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		msleep(10);
 	}
 }
@@ -1307,7 +1307,7 @@ static void icom_break(struct uart_port *port, int break_state)
 	unsigned char cmdReg;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	trace(icom_port, "BREAK", 0);
 	cmdReg = readb(&icom_port->dram->CmdReg);
 	if (break_state == -1) {
@@ -1315,7 +1315,7 @@ static void icom_break(struct uart_port *port, int break_state)
 	} else {
 		writeb(cmdReg & ~CMD_SND_BREAK, &icom_port->dram->CmdReg);
 	}
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int icom_open(struct uart_port *port)
@@ -1365,7 +1365,7 @@ static void icom_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long offset;
 	unsigned long flags;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	trace(icom_port, "CHANGE_SPEED", 0);
 
 	cflag = termios->c_cflag;
@@ -1516,7 +1516,7 @@ static void icom_set_termios(struct uart_port *port, struct ktermios *termios,
 	trace(icom_port, "XR_ENAB", 0);
 	writeb(CMD_XMIT_RCV_ENABLE, &icom_port->dram->CmdReg);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *icom_type(struct uart_port *port)
-- 
2.39.2

