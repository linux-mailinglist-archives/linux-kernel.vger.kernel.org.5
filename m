Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AA87A0CE3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241801AbjINSjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241423AbjINSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED74C1FFC;
        Thu, 14 Sep 2023 11:38:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwAuYpYc3fWXqol8AKchJjd2gF2BZfWOXYVLA/beRQc=;
        b=vSKwIdxZS0Wy8y0+/xBxwuLThTEsw4FHoB6EHTIG1aUZ/vnNzHzcVNEuoBNexfguoPfsUG
        AuuyuU3K3dRpSywuVrx6WMcLVtPGSQeGW9r86rAxNTjYZ9IVPS27lt77osMrXyqSC1bvRm
        o4Ea6eBOgx0An5Xfej5rhguuAlR6FU3QURdKKa3w/qSU1NgHZ4hpp5ouzAH1P2Fjy8qS2v
        GvlBKyD32A4oDfzVMtEbAeSmNv6nrMJn/xfUL/8+6B9N6cUdThGb44P9DyJL96z3lvV1jh
        zOgajJ2htEmcYmbcCqvWAYjS13lgL7oWQG0+gr/0zGI25LwYeN0J4QzjWCjO8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716722;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VwAuYpYc3fWXqol8AKchJjd2gF2BZfWOXYVLA/beRQc=;
        b=i5GRywZjHj1wrVT3sjOj3uMBjzzxZVwAf9xbXgkUxQ5dZtMNghRLuxeKwuRpV4hrBVCmwr
        meSdgbwTEVR38SAQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Howell <matthew.howell@sealevel.com>
Subject: [PATCH tty v1 09/74] serial: 8250_exar: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:26 +0206
Message-Id: <20230914183831.587273-10-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_exar.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
index 077c3ba3539e..07ad21336301 100644
--- a/drivers/tty/serial/8250/8250_exar.c
+++ b/drivers/tty/serial/8250/8250_exar.c
@@ -201,9 +201,9 @@ static int xr17v35x_startup(struct uart_port *port)
 	 *
 	 * Synchronize UART_IER access against the console.
 	 */
-	spin_lock_irq(&port->lock);
+	uart_port_lock_irq(port);
 	serial_port_out(port, UART_IER, 0);
-	spin_unlock_irq(&port->lock);
+	uart_port_unlock_irq(port);
 
 	return serial8250_do_startup(port);
 }
-- 
2.39.2

