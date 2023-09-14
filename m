Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1207A0CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbjINSiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjINSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7501FEB;
        Thu, 14 Sep 2023 11:38:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtT3qcU2XT7sBWbeVRoS4eXwomdEnzl8JI54HpXjFPk=;
        b=16oMLXh+x41buwFBxm6MjmScUALYnbHnctuSlnCJImDb+hw6IInt0wo8Oz7A7El5VEtrzZ
        ehgyfKluVVW+QLIaiBAOsZTImLOShBkB8G9EBqB7JcGNn5k48TwECuTG4UlOTZH5MSdwHs
        hxvPohSSTULpW9tg9xJiFxOd0ZreLZGAH4KwMbCe9li0OELjCwmLocizmQc3bfTBXr768z
        NUkJytLfCrs+3V3XppweqwkkFWHFWXYIwVuw54Qr2Bn/SXld+NLkJHqZYJiI4IvtWPfEKz
        G8bmjzQrKvBcdEOeUtWsqI2QUQyyEqkFgml+Ze2Au7tqNhW1+CyrEjoNdPbf0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtT3qcU2XT7sBWbeVRoS4eXwomdEnzl8JI54HpXjFPk=;
        b=z6TexzG/00l02Fbtx0bPhdCI79PStLL0Fhn/0+ixK+c/BftQZOZ2PcUkUHXgDPVF8zvEno
        3ft3BN8P50LrL+BQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty v1 02/74] serial: core: Use lock wrappers
Date:   Thu, 14 Sep 2023 20:43:19 +0206
Message-Id: <20230914183831.587273-3-john.ogness@linutronix.de>
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
 include/linux/serial_core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f1d5c0d1568c..3091c62ec37b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -1035,14 +1035,14 @@ static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
-		spin_unlock(&port->lock);
+		uart_port_unlock(port);
 		return;
 	}
 
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
@@ -1054,14 +1054,14 @@ static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port
 	u8 sysrq_ch;
 
 	if (!port->has_sysrq) {
-		spin_unlock_irqrestore(&port->lock, flags);
+		uart_port_unlock_irqrestore(port, flags);
 		return;
 	}
 
 	sysrq_ch = port->sysrq_ch;
 	port->sysrq_ch = 0;
 
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 
 	if (sysrq_ch)
 		handle_sysrq(sysrq_ch);
@@ -1077,12 +1077,12 @@ static inline int uart_prepare_sysrq_char(struct uart_port *port, u8 ch)
 }
 static inline void uart_unlock_and_check_sysrq(struct uart_port *port)
 {
-	spin_unlock(&port->lock);
+	uart_port_unlock(port);
 }
 static inline void uart_unlock_and_check_sysrq_irqrestore(struct uart_port *port,
 		unsigned long flags)
 {
-	spin_unlock_irqrestore(&port->lock, flags);
+	uart_port_unlock_irqrestore(port, flags);
 }
 #endif	/* CONFIG_MAGIC_SYSRQ_SERIAL */
 
-- 
2.39.2

