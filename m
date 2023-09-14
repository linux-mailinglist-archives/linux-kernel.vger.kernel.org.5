Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A887A0CF6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241826AbjINSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241609AbjINSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 871682101;
        Thu, 14 Sep 2023 11:38:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC6ee95LLgICXwmE0USSEBuHjBCWJtZsDUgyx/Ctu9I=;
        b=R1TuVbNostHa0wM4yepEE7v6WHYuLqdxHUqaYn+qB5pl6tCd4QoP0ouCPBj/gYuUjWU2Hl
        qZSxgx+XXc/VQiIbUuVilNn3nM35W92GRgdyC6GzHPzgXIzngraczIF+lQGD9zNMwJBoVE
        orO2MdWxWEsso3g+/W+4DPjj1PAxTEk4Ngx2Oi+rIWTZF+orsNP2nKu4Q3yVlYIW1gI/to
        QdnLyyvD3oIXml7AgZqrVHTRaq5qTQuWRRt2xEKRNBtXo5LM/raiC8Fp2QnzPPv8+4HCmj
        PiYmbhKFmSLs+5ksgnA4L6VU/drWEG5TNzjchepMiTwFo+4Ae8GZ2/3YVbPhzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LC6ee95LLgICXwmE0USSEBuHjBCWJtZsDUgyx/Ctu9I=;
        b=CZYVJekgCab/O5x5km8To1UaDf+NZCMKRy3KHKXP+YTu0UQJ7PUVdCpMdSS2HphSeJTuVJ
        /2B0cSEgLlc3bHDA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH tty v1 13/74] serial: 8250_pci1xxxx: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:30 +0206
Message-Id: <20230914183831.587273-14-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_pci1xxxx.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index a3b25779d921..53e238c8cc89 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -225,10 +225,10 @@ static bool pci1xxxx_port_suspend(int line)
 	if (port->suspended == 0 && port->dev) {
 		wakeup_mask = readb(up->port.membase + UART_WAKE_MASK_REG);
 
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		port->mctrl &= ~TIOCM_OUT2;
 		port->ops->set_mctrl(port, port->mctrl);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 
 		ret = (wakeup_mask & UART_WAKE_SRCS) != UART_WAKE_SRCS;
 	}
@@ -251,10 +251,10 @@ static void pci1xxxx_port_resume(int line)
 	writeb(UART_WAKE_SRCS, port->membase + UART_WAKE_REG);
 
 	if (port->suspended == 0) {
-		spin_lock_irqsave(&port->lock, flags);
+		uart_port_lock_irqsave(port, &flags);
 		port->mctrl |= TIOCM_OUT2;
 		port->ops->set_mctrl(port, port->mctrl);
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 	}
 	mutex_unlock(&tport->mutex);
 }
-- 
2.39.2

