Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F627A0D49
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241994AbjINSmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242004AbjINSj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:39:58 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A88B2139;
        Thu, 14 Sep 2023 11:39:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VJ6CgzcUt97Sq6jT/T/98yELCXXHkc/OLg8MuGFujM=;
        b=2Q8ZWVVt4nOO784XYJxgw1TUsfcdKAz0Y5+p60KtUyCRIsGYdCIskPFE+osS7+MkxwviQt
        UML2Y73woxFqdZHm6y94vd3WGC56kpgzzzbF2i5Ubc0Aro/OmrgD0CxWgcpFi347G+NQZH
        h90Lof0AlZsIu85LlPQevIPzRFfD7CrqttJtuQU3DYChU+D751il2UBumt99HaTKqunct/
        26LmtSeaqPDLr1pPNjDhaxBC8MMUkiG9VtRP+NG14Ke6NMcQ0DamBJBgpShKTO0+/7MQDj
        l510AATKDexz0xJw6MogQYOHDTzUhEwMvTmC02EXbku1B63xHHV0/JriASW0lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0VJ6CgzcUt97Sq6jT/T/98yELCXXHkc/OLg8MuGFujM=;
        b=vwvzaothGm7O+kiuENFNt17TWnYKIc4YDYnd1sfg4ZHwAk6rFlSpEEbCz+oonZ6Z7p4V0g
        2/A7G8m1pzZF8rBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty v1 58/74] serial: mctrl_gpio: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:15 +0206
Message-Id: <20230914183831.587273-59-john.ogness@linutronix.de>
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
 drivers/tty/serial/serial_mctrl_gpio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_mctrl_gpio.c b/drivers/tty/serial/serial_mctrl_gpio.c
index 7d5aaa8d422b..e51ca593ab86 100644
--- a/drivers/tty/serial/serial_mctrl_gpio.c
+++ b/drivers/tty/serial/serial_mctrl_gpio.c
@@ -184,7 +184,7 @@ static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
 
 	mctrl_gpio_get(gpios, &mctrl);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 
 	mctrl_diff = mctrl ^ gpios->mctrl_prev;
 	gpios->mctrl_prev = mctrl;
@@ -205,7 +205,7 @@ static irqreturn_t mctrl_gpio_irq_handle(int irq, void *context)
 		wake_up_interruptible(&port->state->port.delta_msr_wait);
 	}
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	return IRQ_HANDLED;
 }
-- 
2.39.2

