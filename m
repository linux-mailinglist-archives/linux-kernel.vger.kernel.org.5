Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE06C7A0CD0
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241499AbjINSit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 14:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbjINSiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 14:38:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A781FF9;
        Thu, 14 Sep 2023 11:38:41 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694716719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRoapPsp3k8C9+cAJncEIUfgF6L1OgYHKNIWMNQArN8=;
        b=VAjKIhObU4Ecwzj1Ft23hUIFCg5wNU+ACZXfHOo/+M6G3rDdjIutIP/3dgKZphFycD7k0s
        l1K/shKjUF1xNDyqSV4Dkv1WCexNBS4t69JIncUEixls1YhZ/pLnSCgDpEory16tlJ3aaK
        cTsL9IOd8JYrt8dYej3n1jevYWZHoDYTaJtVMpwp/BHiRAyRsFxkoewey2tW8f/zXlHHoj
        eGxIhZNWggKOIC77flgOvFXuitF29LOz6qsVQG5nx2unbIXnsGYvp0nQHU7vFHpswVtoGd
        qFrRpKlOyVTIQm/uj3/xhPNHlPXIYSjTqnj+ukPYGxr4V79XY9RgkxxGqm6CVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694716719;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IRoapPsp3k8C9+cAJncEIUfgF6L1OgYHKNIWMNQArN8=;
        b=wGLW0CPqtjKXdq32BWOBlskt8IKEQHA9vLWBa4IeEQiBvGjl9GrE1AxJD/0KbuJjMJhKKB
        l4R6nV8mtg7pUYBQ==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org,
        Petr Mladek <pmladek@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
Date:   Thu, 14 Sep 2023 20:43:18 +0206
Message-Id: <20230914183831.587273-2-john.ogness@linutronix.de>
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

Provide wrapper functions for spin_[un]lock*(port->lock) invocations so
that the console mechanics can be applied later on at a single place and
does not require to copy the same logic all over the drivers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/serial_core.h | 79 +++++++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index bb6f073bc159..f1d5c0d1568c 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -588,6 +588,85 @@ struct uart_port {
 	void			*private_data;		/* generic platform data pointer */
 };
 
+/**
+ * uart_port_lock - Lock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock(struct uart_port *up)
+{
+	spin_lock(&up->lock);
+}
+
+/**
+ * uart_port_lock_irq - Lock the UART port and disable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_lock_irq(struct uart_port *up)
+{
+	spin_lock_irq(&up->lock);
+}
+
+/**
+ * uart_port_lock_irqsave - Lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ */
+static inline void uart_port_lock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	spin_lock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_trylock - Try to lock the UART port
+ * @up:		Pointer to UART port structure
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock(struct uart_port *up)
+{
+	return spin_trylock(&up->lock);
+}
+
+/**
+ * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	Pointer to interrupt flags storage
+ *
+ * Returns: True if lock was acquired, false otherwise
+ */
+static inline bool uart_port_trylock_irqsave(struct uart_port *up, unsigned long *flags)
+{
+	return spin_trylock_irqsave(&up->lock, *flags);
+}
+
+/**
+ * uart_port_unlock - Unlock the UART port
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock(struct uart_port *up)
+{
+	spin_unlock(&up->lock);
+}
+
+/**
+ * uart_port_unlock_irq - Unlock the UART port and re-enable interrupts
+ * @up:		Pointer to UART port structure
+ */
+static inline void uart_port_unlock_irq(struct uart_port *up)
+{
+	spin_unlock_irq(&up->lock);
+}
+
+/**
+ * uart_port_lock_irqrestore - Unlock the UART port, restore interrupts
+ * @up:		Pointer to UART port structure
+ * @flags:	The saved interrupt flags for restore
+ */
+static inline void uart_port_unlock_irqrestore(struct uart_port *up, unsigned long flags)
+{
+	spin_unlock_irqrestore(&up->lock, flags);
+}
+
 static inline int serial_port_in(struct uart_port *up, int offset)
 {
 	return up->serial_in(up, offset);
-- 
2.39.2

