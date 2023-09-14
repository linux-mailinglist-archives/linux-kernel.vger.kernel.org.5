Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600927A0D4F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:42:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbjINSmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241761AbjINSkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:40:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AAD3272D;
        Thu, 14 Sep 2023 11:39:06 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNItZDOSVbjUj/GhN7qtDvHsswbZnbm/OUZHY8Hfuqo=;
        b=wknKwa1kLvdaAYCvkZu9Z81f2T8Ta+CKva4N8RP76TA/NcMmJlm+Kil2JepCpHxBw1BEJU
        K5pPqaYbTwLXrS3/UGwnuSoqeuuWpaEqqES2YbBrkQQJBM2jxPSbaryW3lTtByRM/tMtwh
        gLrH5uhCtN8myDHRj74sRARHv9IwiNLbYc/k8O+0uLooKYlN4mT5AxH563k4Ct6BKNLKBa
        6sfWSVIRNQrC7RUyNp3GxrdgJpqbYtOp6pNuQ7JQPlbSa8eoVNCfaBWQPqRdeKSwo43PTo
        78iMfhiAozSI/V0aIgMpjYRus2ommjIBSLG4FVydEquKML+4oWBSdSlxxdKnPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FNItZDOSVbjUj/GhN7qtDvHsswbZnbm/OUZHY8Hfuqo=;
        b=HCL13mxdtEEBqe3txMOM+VDtV2848oD66CWe/CXn/8/B7TEVd4hlSi4SRJ+K0c3B4MuVs7
        ZsMM+w8fmLRiVrBg==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard GENOUD <richard.genoud@gmail.com>,
        Nick Hu <nick.hu@sifive.com>,
        Ruan Jinjie <ruanjinjie@huawei.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Yangtao Li <frank.li@vivo.com>, linux-riscv@lists.infradead.org
Subject: [PATCH tty v1 61/74] serial: sifive: Use port lock wrappers
Date:   Thu, 14 Sep 2023 20:44:18 +0206
Message-Id: <20230914183831.587273-62-john.ogness@linutronix.de>
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
 drivers/tty/serial/sifive.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index d195c5de52e7..b296e57a9dee 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -521,11 +521,11 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
 	struct sifive_serial_port *ssp = dev_id;
 	u32 ip;
 
-	spin_lock(&ssp->port.lock);
+	uart_port_lock(&ssp->port);
 
 	ip = __ssp_readl(ssp, SIFIVE_SERIAL_IP_OFFS);
 	if (!ip) {
-		spin_unlock(&ssp->port.lock);
+		uart_port_unlock(&ssp->port);
 		return IRQ_NONE;
 	}
 
@@ -534,7 +534,7 @@ static irqreturn_t sifive_serial_irq(int irq, void *dev_id)
 	if (ip & SIFIVE_SERIAL_IP_TXWM_MASK)
 		__ssp_transmit_chars(ssp);
 
-	spin_unlock(&ssp->port.lock);
+	uart_port_unlock(&ssp->port);
 
 	return IRQ_HANDLED;
 }
@@ -653,7 +653,7 @@ static void sifive_serial_set_termios(struct uart_port *port,
 				  ssp->port.uartclk / 16);
 	__ssp_update_baud_rate(ssp, rate);
 
-	spin_lock_irqsave(&ssp->port.lock, flags);
+	uart_port_lock_irqsave(&ssp->port, &flags);
 
 	/* Update the per-port timeout */
 	uart_update_timeout(port, termios->c_cflag, rate);
@@ -670,7 +670,7 @@ static void sifive_serial_set_termios(struct uart_port *port,
 	if (v != old_v)
 		__ssp_writel(v, SIFIVE_SERIAL_RXCTRL_OFFS, ssp);
 
-	spin_unlock_irqrestore(&ssp->port.lock, flags);
+	uart_port_unlock_irqrestore(&ssp->port, flags);
 }
 
 static void sifive_serial_release_port(struct uart_port *port)
@@ -795,9 +795,9 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	if (ssp->port.sysrq)
 		locked = 0;
 	else if (oops_in_progress)
-		locked = spin_trylock(&ssp->port.lock);
+		locked = uart_port_trylock(&ssp->port);
 	else
-		spin_lock(&ssp->port.lock);
+		uart_port_lock(&ssp->port);
 
 	ier = __ssp_readl(ssp, SIFIVE_SERIAL_IE_OFFS);
 	__ssp_writel(0, SIFIVE_SERIAL_IE_OFFS, ssp);
@@ -807,7 +807,7 @@ static void sifive_serial_console_write(struct console *co, const char *s,
 	__ssp_writel(ier, SIFIVE_SERIAL_IE_OFFS, ssp);
 
 	if (locked)
-		spin_unlock(&ssp->port.lock);
+		uart_port_unlock(&ssp->port);
 	local_irq_restore(flags);
 }
 
-- 
2.39.2

