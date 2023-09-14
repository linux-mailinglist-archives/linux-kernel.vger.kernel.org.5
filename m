Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2129D7A0D41
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbjINSlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbjINSjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A8270D;
        Thu, 14 Sep 2023 11:39:02 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQN7epFxbwh1qF9A3vKlWoOOC6pmuH30heIRIdUdCsw=;
        b=hmi62IBJprhrBskt+oHKNc4Krp4W/jSVkKbugl+EiEnzpg4bnHZL6tDuwSP35MvhOJqTBF
        Y2qIjTqZkiorNeiPqCopzo2FMj8YkX/23kq1/zgSju9fnqtV2cfdcWGQA/AtPwUxPW57Ab
        4oVbbBmc8Z24NcuPQGwoujNWqBXYpC71pnzj679o/3ud01fI/bc+znMfqELboL6XUIYdP0
        Px0Vb2U0dxClP0Y/t+BHowHcGm9a/kyfT4WJpf3gLYLaQD0U6oHrOsYQxdw2n//tEF5MEd
        8Fi0Fy7EDg74h00xumLAfvfn2pLsMclcPViRc62XZEe6QTpNztkni3Jvpud+5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQN7epFxbwh1qF9A3vKlWoOOC6pmuH30heIRIdUdCsw=;
        b=kfyQuSVNlXEbogFR65EguwGNHtAhOMowXzjYr76Qoe01RXQd/iZhZ694cqLNmiITysx3Ms
        BDxZXp3l3vPr59BQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Richard GENOUD <richard.genoud@gmail.com>,
        Thierry Reding <treding@nvidia.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH tty v1 54/74] serial: sb1250-duart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:11 +0206
Message-Id: <20230914183831.587273-55-john.ogness@linutronix.de>
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
 drivers/tty/serial/sb1250-duart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index f3cd69346482..dbec29d9a6c3 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -610,7 +610,7 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 	else
 		aux &= ~M_DUART_CTS_CHNG_ENA;
 
-	spin_lock(&uport->lock);
+	uart_port_lock(uport);
 
 	if (sport->tx_stopped)
 		command |= M_DUART_TX_DIS;
@@ -632,7 +632,7 @@ static void sbd_set_termios(struct uart_port *uport, struct ktermios *termios,
 
 	write_sbdchn(sport, R_DUART_CMD, command);
 
-	spin_unlock(&uport->lock);
+	uart_port_unlock(uport);
 }
 
 
@@ -839,22 +839,22 @@ static void sbd_console_write(struct console *co, const char *s,
 	unsigned int mask;
 
 	/* Disable transmit interrupts and enable the transmitter. */
-	spin_lock_irqsave(&uport->lock, flags);
+	uart_port_lock_irqsave(uport, &flags);
 	mask = read_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2));
 	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2),
 		     mask & ~M_DUART_IMR_TX);
 	write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_EN);
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_port_unlock_irqrestore(uport, flags);
 
 	uart_console_write(&sport->port, s, count, sbd_console_putchar);
 
 	/* Restore transmit interrupts and the transmitter enable. */
-	spin_lock_irqsave(&uport->lock, flags);
+	uart_port_lock_irqsave(uport, &flags);
 	sbd_line_drain(sport);
 	if (sport->tx_stopped)
 		write_sbdchn(sport, R_DUART_CMD, M_DUART_TX_DIS);
 	write_sbdshr(sport, R_DUART_IMRREG((uport->line) % 2), mask);
-	spin_unlock_irqrestore(&uport->lock, flags);
+	uart_port_unlock_irqrestore(uport, flags);
 }
 
 static int __init sbd_console_setup(struct console *co, char *options)
-- 
2.39.2

