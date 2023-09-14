Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F807A0D03
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241945AbjINSjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241653AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83451210A;
        Thu, 14 Sep 2023 11:38:47 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SN1m+sQgeewvT16dEWJcKSrjCp4ddLkdrzOmS932/1c=;
        b=T2+nJtqFHK05/tM4MSOXTG0QEMWzm7dci51Lnw0aYytoCX/b+7AuMkFiu1PbFgG9imA4uk
        B2kOwsnzIg07yBXTnAtEye+O1CWkfLiDiP4wioM6jGNZ3sXID24JoP3waGuQwzgiFaVSqo
        5QVF6oI1wtFfzxrvHKA8vi9aU+u2T1eupWzb0RTs6XHvIJnrCz6J1TeJratDX4HI7KQKHU
        jr9bmor/75Bb4cnokJXTPSjpwtG5gBuZWs7Ue4KUkQutBWO/7cFMJo25ZWpH5ugDtjYINj
        fbduXBudQtprxvZRd/MIhyr4IZIww66j0DnbzrZn4I93U+828kcVZTn09qE5YQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SN1m+sQgeewvT16dEWJcKSrjCp4ddLkdrzOmS932/1c=;
        b=GQ4AT7dpwj6KdWTSvLHa6Iv58kWfyk7q6vILB5b0vKY5MPYKmqRhTOU1r+F/DfpZzSfmwk
        0VrqhxSNFO63RJCA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Rob Herring <robh@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>
Subject: [PATCH tty v1 18/74] serial: apb: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:35 +0206
Message-Id: <20230914183831.587273-19-john.ogness@linutronix.de>
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
 drivers/tty/serial/apbuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index d7658f380838..716cb014c028 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -133,7 +133,7 @@ static irqreturn_t apbuart_int(int irq, void *dev_id)
 	struct uart_port *port = dev_id;
 	unsigned int status;
 
-	spin_lock(&port->lock);
+	uart_port_lock(port);
 
 	status = UART_GET_STATUS(port);
 	if (status & UART_STATUS_DR)
@@ -141,7 +141,7 @@ static irqreturn_t apbuart_int(int irq, void *dev_id)
 	if (status & UART_STATUS_THE)
 		apbuart_tx_chars(port);
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	return IRQ_HANDLED;
 }
@@ -228,7 +228,7 @@ static void apbuart_set_termios(struct uart_port *port,
 	if (termios->c_cflag & CRTSCTS)
 		cr |= UART_CTRL_FL;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Update the per-port timeout. */
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -251,7 +251,7 @@ static void apbuart_set_termios(struct uart_port *port,
 	UART_PUT_SCAL(port, quot);
 	UART_PUT_CTRL(port, cr);
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *apbuart_type(struct uart_port *port)
-- 
2.39.2

