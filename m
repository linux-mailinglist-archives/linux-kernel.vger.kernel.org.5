Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2161E7A0CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbjINSjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241566AbjINSiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9591FFD;
        Thu, 14 Sep 2023 11:38:44 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXz8JGMJt54lxBpqvVsLQWaGP0tVfnWkCc3ahu/OaTk=;
        b=vmCnTqOsrLD4owKMnmfvtt1mBVdB6YqBmGZYVNCuNttix45bbD9ZYBKfLxWRoBxQcBrNFS
        ULCYyVAqLXI4WuA9/BsruLgLGbEQI0qOqenpk/mUGPr+fPvVS+xGWUKS7kYFDYc0WhUm27
        aVTjiT5owCNSXMMUD6DKhb7HMUIh7wEVB3Z5nSl559BN3e+O7kuLsiSfuog8zZMXDWHAjs
        5zUaC5XtIkdT+69XNmr/KvqG8mTwRsZEuLyoS0zyLneujo8Xe6IZvjTY2OaCkQ9Dneu7rx
        rxPzEpc7LJxm0RT3M6KzjMRuQiQm6AL2MbwkL48z/fbQ2VixAGYrORAhlzhwFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wXz8JGMJt54lxBpqvVsLQWaGP0tVfnWkCc3ahu/OaTk=;
        b=oELZSVWpujrqq3F+QVn6Xal+m55lYszHQlaRnpJvhYUD7X9S9LcC3ptf/FaXfToMUvP96p
        2Q76arcWnsSNdHAg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Johan Hovold <johan@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH tty v1 10/74] serial: 8250_fsl: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:27 +0206
Message-Id: <20230914183831.587273-11-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_fsl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_fsl.c b/drivers/tty/serial/8250/8250_fsl.c
index 6af4e1c1210a..f522eb5026c9 100644
--- a/drivers/tty/serial/8250/8250_fsl.c
+++ b/drivers/tty/serial/8250/8250_fsl.c
@@ -30,11 +30,11 @@ int fsl8250_handle_irq(struct uart_port *port)
 	unsigned int iir;
 	struct uart_8250_port *up = up_to_u8250p(port);
 
-	spin_lock_irqsave(&up->port.lock, flags);
+	uart_port_lock_irqsave(&up->port, &flags);
 
 	iir = port->serial_in(port, UART_IIR);
 	if (iir & UART_IIR_NO_INT) {
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 		return 0;
 	}
 
@@ -54,7 +54,7 @@ int fsl8250_handle_irq(struct uart_port *port)
 	if (unlikely(up->lsr_saved_flags & UART_LSR_BI)) {
 		up->lsr_saved_flags &= ~UART_LSR_BI;
 		port->serial_in(port, UART_RX);
-		spin_unlock_irqrestore(&up->port.lock, flags);
+		uart_port_unlock_irqrestore(&up->port, flags);
 		return 1;
 	}
 
-- 
2.39.2

