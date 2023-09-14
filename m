Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0D2B7A0D67
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241793AbjINSoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241670AbjINSmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:42:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3A330DD;
        Thu, 14 Sep 2023 11:39:10 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pan/Otko80+kx5GwrdBzH5rqxtGnDYcelX/t2yRhZyw=;
        b=zpUU9dctskVd4WufCbynS94+Ovx8KK1h4oYx/VysK2/dpx9kiRW4O/QxyeZooQF1eBJlYg
        zU3LU+Bh7QFa5pfsMSJ8KHpSkpf/gsyL67K87tpZ6AJbvTog7UvJKenbn8hDcHEE9p+jFM
        FHVu3GMxb6FaLdoRVy1KsU/BkBLLsWVH2MakIP6ye29Hl9LWhxcFMDGUzhILqB6/Izolr4
        jehJ0JjYJP4OsrVERl7wOiyFiw2ERZPHYR0zK3OIu4M0iKW7iKuXtPt25ngJMqCNPhC8Oc
        MaVs9NHEsal5rbJya1yYTrlxJsFtEhZUKqNx7kXV7SDtGvorFSTBlM6pivDgIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716749;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pan/Otko80+kx5GwrdBzH5rqxtGnDYcelX/t2yRhZyw=;
        b=h4GrYv7OIG3dE8qwnp/pMYJXI0g1EyToxTcSzaqK+cHIYOtxHObwnYxOf/KaP9TALJI2vI
        I/ttHd7kyn1pyGAg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH tty v1 70/74] serial: timbuart: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:27 +0206
Message-Id: <20230914183831.587273-71-john.ogness@linutronix.de>
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
 drivers/tty/serial/timbuart.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/timbuart.c b/drivers/tty/serial/timbuart.c
index 0859394a78cd..0cc6524f5e8b 100644
--- a/drivers/tty/serial/timbuart.c
+++ b/drivers/tty/serial/timbuart.c
@@ -174,7 +174,7 @@ static void timbuart_tasklet(struct tasklet_struct *t)
 	struct timbuart_port *uart = from_tasklet(uart, t, tasklet);
 	u32 isr, ier = 0;
 
-	spin_lock(&uart->port.lock);
+	uart_port_lock(&uart->port);
 
 	isr = ioread32(uart->port.membase + TIMBUART_ISR);
 	dev_dbg(uart->port.dev, "%s ISR: %x\n", __func__, isr);
@@ -189,7 +189,7 @@ static void timbuart_tasklet(struct tasklet_struct *t)
 
 	iowrite32(ier, uart->port.membase + TIMBUART_IER);
 
-	spin_unlock(&uart->port.lock);
+	uart_port_unlock(&uart->port);
 	dev_dbg(uart->port.dev, "%s leaving\n", __func__);
 }
 
@@ -295,10 +295,10 @@ static void timbuart_set_termios(struct uart_port *port,
 		tty_termios_copy_hw(termios, old);
 	tty_termios_encode_baud_rate(termios, baud, baud);
 
-	spin_lock_irqsave(&port->lock, flags);
+	uart_port_lock_irqsave(port, &flags);
 	iowrite8((u8)bindex, port->membase + TIMBUART_BAUDRATE);
 	uart_update_timeout(port, termios->c_cflag, baud);
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 
 static const char *timbuart_type(struct uart_port *port)
-- 
2.39.2

