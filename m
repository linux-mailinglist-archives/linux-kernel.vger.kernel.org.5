Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01917A0D23
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242062AbjINSkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241867AbjINSjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F7C2693;
        Thu, 14 Sep 2023 11:38:57 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lU9D8We8m4x72sUrLwTLFKudvB8THnTuYuyUkrl8N/A=;
        b=hAMHEMsgqejMT1XBX057U7gRX/U0TGRx3iue3x/BaIGP2roM1YCGjozN2L9FUjZkyFgPiO
        wNfTWFxb0/ZsMZt0RPpay2OdEU7JJs2RY/X4jt+EPSppHA6AWFVLL5/T6PrwgIMEeEqubC
        EYxKB7lM2J8v0TaCjrXRhAWNCjoiXfxeRwOVToCiZt2ch0bFJmBg+aMXDbzknRGYCju55k
        lRkHT77aZRlm4KXBzKvDseK8wwh+FN7CZ53u7vuDS1TKBclGeiDLNcGKKXu12nDDfRPWBC
        0vzQIR61YbtQNGgDRyRvi+qk0aRx/DSdaGwbJsi3WyJ/sMuXwNbSbK0fyL7OCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lU9D8We8m4x72sUrLwTLFKudvB8THnTuYuyUkrl8N/A=;
        b=w2ZDYAKVL3yIhf3zWrk2VoKWILS3vFbQnBzPcxXlGmzGcK+Zrii90SS8A7LT64OBqbAGcJ
        fmc4JyzXXOILh3Dw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH tty v1 41/74] serial: msm: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:58 +0206
Message-Id: <20230914183831.587273-42-john.ogness@linutronix.de>
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
 drivers/tty/serial/msm_serial.c | 38 ++++++++++++++++-----------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/tty/serial/msm_serial.c b/drivers/tty/serial/msm_serial.c
index 90953e679e38..597264b546fd 100644
--- a/drivers/tty/serial/msm_serial.c
+++ b/drivers/tty/serial/msm_serial.c
@@ -444,7 +444,7 @@ static void msm_complete_tx_dma(void *args)
 	unsigned int count;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
 	if (!dma->count)
@@ -476,7 +476,7 @@ static void msm_complete_tx_dma(void *args)
 
 	msm_handle_tx(port);
 done:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int msm_handle_tx_dma(struct msm_port *msm_port, unsigned int count)
@@ -549,7 +549,7 @@ static void msm_complete_rx_dma(void *args)
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Already stopped */
 	if (!dma->count)
@@ -587,16 +587,16 @@ static void msm_complete_rx_dma(void *args)
 		if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 			flag = TTY_NORMAL;
 
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		sysrq = uart_handle_sysrq_char(port, dma->virt[i]);
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		if (!sysrq)
 			tty_insert_flip_char(tport, dma->virt[i], flag);
 	}
 
 	msm_start_rx_dma(msm_port);
 done:
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (count)
 		tty_flip_buffer_push(tport);
@@ -762,9 +762,9 @@ static void msm_handle_rx_dm(struct uart_port *port, unsigned int misr)
 			if (!(port->read_status_mask & MSM_UART_SR_RX_BREAK))
 				flag = TTY_NORMAL;
 
-			spin_unlock(&port->lock);
+			uart_port_unlock(port);
 			sysrq = uart_handle_sysrq_char(port, buf[i]);
-			spin_lock(&port->lock);
+			uart_port_lock(port);
 			if (!sysrq)
 				tty_insert_flip_char(tport, buf[i], flag);
 		}
@@ -824,9 +824,9 @@ static void msm_handle_rx(struct uart_port *port)
 		else if (sr & MSM_UART_SR_PAR_FRAME_ERR)
 			flag = TTY_FRAME;
 
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 		sysrq = uart_handle_sysrq_char(port, c);
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 		if (!sysrq)
 			tty_insert_flip_char(tport, c, flag);
 	}
@@ -951,7 +951,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 	unsigned int misr;
 	u32 val;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	misr = msm_read(port, MSM_UART_MISR);
 	msm_write(port, 0, MSM_UART_IMR); /* disable interrupt */
 
@@ -983,7 +983,7 @@ static irqreturn_t msm_uart_irq(int irq, void *dev_id)
 		msm_handle_delta_cts(port);
 
 	msm_write(port, msm_port->imr, MSM_UART_IMR); /* restore interrupt */
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
@@ -1128,13 +1128,13 @@ static int msm_set_baud_rate(struct uart_port *port, unsigned int baud,
 	unsigned long flags, rate;
 
 	flags = *saved_flags;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	entry = msm_find_best_baud(port, baud, &rate);
 	clk_set_rate(msm_port->clk, rate);
 	baud = rate / 16 / entry->divisor;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	*saved_flags = flags;
 	port->uartclk = rate;
 
@@ -1266,7 +1266,7 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	unsigned long flags;
 	unsigned int baud, mr;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	if (dma->chan) /* Terminate if any */
 		msm_stop_dma(port, dma);
@@ -1338,7 +1338,7 @@ static void msm_set_termios(struct uart_port *port, struct ktermios *termios,
 	/* Try to use DMA */
 	msm_start_rx_dma(msm_port);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *msm_type(struct uart_port *port)
@@ -1620,9 +1620,9 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 	if (port->sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&port->lock);
+		locked = uart_port_trylock(port);
 	else
-		spin_lock(&port->lock);
+		uart_port_lock(port);
 
 	if (is_uartdm)
 		msm_reset_dm_count(port, count);
@@ -1661,7 +1661,7 @@ static void __msm_console_write(struct uart_port *port, const char *s,
 	}
 
 	if (locked)
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 
 	local_irq_restore(flags);
 }
-- 
2.39.2

