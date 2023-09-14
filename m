Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4567A0D6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbjINSoa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241770AbjINSm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:42:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8CF30F0;
        Thu, 14 Sep 2023 11:39:11 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4vNSSSfbKzMTl5dIaX+nKFLqtsf/7qFsjWyC6l0EH0=;
        b=Btvxqnk4X2os6S5PrOaEvdQj5QO8ypBR/vcabWe3Gj5lhywtI34HkX9oqmk/uN8pbMIMfW
        I36GzlO0wMYRThI7KH1lMM/7nxcrYd1F9UhOwQDEjh8Ro10ODzExtzippTDQ7xkrpGTQ8R
        /afpljVJSX4wsuCyOws5j7Ay2eYLJtPePh3JpHOCtohYDUa24cIVB6b+2rSG/THHGoxEo1
        2yJvl9M2jPGFBw6rEt9JljlPfa80dVAzz7Tk3ynReIsFt0hbRYD3tY6LfhhqbzzK8gEI+b
        2P2Z7R5JL0rdoozdGeXCuCLpQ6NHXbmemuyVTCAScZ9i7ZcbmJfp99qRUiG8Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h4vNSSSfbKzMTl5dIaX+nKFLqtsf/7qFsjWyC6l0EH0=;
        b=skOOWWSloirPh2qLF10hQ5qRfe3vdZMKCUw5YKRzGtn51G9SzuSd9vTdeNuK3ueDbstJiR
        QFsCirT45QgYgiBA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Timur Tabi <timur@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH tty v1 72/74] serial: ucc_uart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:29 +0206
Message-Id: <20230914183831.587273-73-john.ogness@linutronix.de>
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
 drivers/tty/serial/ucc_uart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index b06661b80f41..ed7a6bb5596a 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -931,7 +931,7 @@ static void qe_uart_set_termios(struct uart_port *port,
 	baud = uart_get_baud_rate(port, termios, old, 0, port->uartclk / 16);
 
 	/* Do we really need a spinlock here? */
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	/* Update the per-port timeout. */
 	uart_update_timeout(port, termios->c_cflag, baud);
@@ -949,7 +949,7 @@ static void qe_uart_set_termios(struct uart_port *port,
 		qe_setbrg(qe_port->us_info.tx_clock, baud, 16);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 /*
-- 
2.39.2

