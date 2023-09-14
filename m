Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDAD87A0CF9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241894AbjINSjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241400AbjINSis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB21FF9;
        Thu, 14 Sep 2023 11:38:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzZ2M7Ay+uoSpWDNXt2IF108PlOFaDB0Gl5ZSfxIoKA=;
        b=MN04YVr9XpiH+REY6l7sFIUGI/otQWeRx+CKe/J4+jMfCS0h0U6aIm01i3LOSc/jBKZ4lL
        XTInMSjAR/ywP2wrgbrAtW4+AKEkb/ExW/V2qne+n4kXbGFT1vswV4l3nARA/jtnvknOxh
        jiaUIX8aUYihEu7/LSXCaQcmM6LcClRkIv6ACbTowKQvmPN6ErddahwcH7LNL9ibjbD3gC
        2MamTfJD3//3CTP1OMZtoXs5K/TWjqPaxcxAgxnf37Lgae3nJP3KXUPCSpx/q4BeLm11JQ
        l53K51Y5jNK1jpi/XFuhvi2+qzo/Sd/erXOzxvJplGgq4Qg4g9KImV9kXWNcqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716721;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CzZ2M7Ay+uoSpWDNXt2IF108PlOFaDB0Gl5ZSfxIoKA=;
        b=7AP6OHdmQkAf45CIbcjDpOnJQIa7Mil7nBAtO0WArIZaqyFG/TyjfxMEofUIZB8/cnTr7G
        Cv7UMdHf9PI0DHCQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH tty v1 07/74] serial: 8250_dma: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:24 +0206
Message-Id: <20230914183831.587273-8-john.ogness@linutronix.de>
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
 drivers/tty/serial/8250/8250_dma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dma.c b/drivers/tty/serial/8250/8250_dma.c
index 7fa66501792d..8b30ca8fdd3f 100644
--- a/drivers/tty/serial/8250/8250_dma.c
+++ b/drivers/tty/serial/8250/8250_dma.c
@@ -22,7 +22,7 @@ static void __dma_tx_complete(void *param)
 	dma_sync_single_for_cpu(dma->txchan->device->dev, dma->tx_addr,
 				UART_XMIT_SIZE, DMA_TO_DEVICE);
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 
 	dma->tx_running = 0;
 
@@ -35,7 +35,7 @@ static void __dma_tx_complete(void *param)
 	if (ret || !dma->tx_running)
 		serial8250_set_THRI(p);
 
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 static void __dma_rx_complete(struct uart_8250_port *p)
@@ -70,7 +70,7 @@ static void dma_rx_complete(void *param)
 	struct uart_8250_dma *dma = p->dma;
 	unsigned long flags;
 
-	spin_lock_irqsave(&p->port.lock, flags);
+	uart_port_lock_irqsave(&p->port, &flags);
 	if (dma->rx_running)
 		__dma_rx_complete(p);
 
@@ -80,7 +80,7 @@ static void dma_rx_complete(void *param)
 	 */
 	if (!dma->rx_running && (serial_lsr_in(p) & UART_LSR_DR))
 		p->dma->rx_dma(p);
-	spin_unlock_irqrestore(&p->port.lock, flags);
+	uart_port_unlock_irqrestore(&p->port, flags);
 }
 
 int serial8250_tx_dma(struct uart_8250_port *p)
-- 
2.39.2

