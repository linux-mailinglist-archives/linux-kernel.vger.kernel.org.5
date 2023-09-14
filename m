Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406037A0CD9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241613AbjINSix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237683AbjINSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1341FFB;
        Thu, 14 Sep 2023 11:38:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtv2ooAyzSE0YQWAS7XlGsZho6T7ZcwOVdsZs7LIu1E=;
        b=g+dINB6iW64ACyGaujJ1o1fmjmZZbggm+6IGvHEYyUBn1NzpRPs7TAlZjj6IsoY1R6uRqA
        l02QK0APIRRJEGEHzLmuA3KNxtug5g+ZiMeicDYNS16St1i3YebOJpD8Th+Ih0YDcly03Y
        88NV2gWch783aKq55g9nJrpFBkOUi+kX5aDhtwbssvlMaTyqZEhO4g9OM0wPPxDm3k2Dd1
        WLbM9DkVbWc/Pmo0rWfMA0lismVw25oXL6aNdf3ZGpKv2Oq7ytfCJtWuGu+AbLDTWO10uR
        b0MdDi4MZRShdMearsckOqhJOJsQAj23J0JWA6Mgza8OCdfmiqjky48X7C7X3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716720;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtv2ooAyzSE0YQWAS7XlGsZho6T7ZcwOVdsZs7LIu1E=;
        b=PhIqp92kh8QdxyU/WhDvrm3+buau2QJZp8tIjUyzIecq6jH+ypbOUQF51L77DTojwzBhYS
        2sI3D1mGczaDbsBw==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Tobias Klauser <tklauser@distanz.ch>,
        Thierry Reding <treding@nvidia.com>
Subject: [PATCH tty v1 03/74] serial: 21285: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:20 +0206
Message-Id: <20230914183831.587273-4-john.ogness@linutronix.de>
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
 drivers/tty/serial/21285.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index d756fcc884cb..4de0c975ebdc 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -185,14 +185,14 @@ static void serial21285_break_ctl(struct uart_port *port, int break_state)
 	unsigned long flags;
 	unsigned int h_lcr;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	h_lcr = *CSR_H_UBRLCR;
 	if (break_state)
 		h_lcr |= H_UBRLCR_BREAK;
 	else
 		h_lcr &= ~H_UBRLCR_BREAK;
 	*CSR_H_UBRLCR = h_lcr;
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static int serial21285_startup(struct uart_port *port)
@@ -272,7 +272,7 @@ serial21285_set_termios(struct uart_port *port, struct ktermios *termios,
 	if (port->fifosize)
 		h_lcr |= H_UBRLCR_FIFO;
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 * Update the per-port timeout.
@@ -309,7 +309,7 @@ serial21285_set_termios(struct uart_port *port, struct ktermios *termios,
 	*CSR_H_UBRLCR = h_lcr;
 	*CSR_UARTCON = 1;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *serial21285_type(struct uart_port *port)
-- 
2.39.2

