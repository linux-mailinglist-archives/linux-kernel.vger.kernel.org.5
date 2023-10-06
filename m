Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10447BC09D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjJFUpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233535AbjJFUpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:45:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B74BBF;
        Fri,  6 Oct 2023 13:45:02 -0700 (PDT)
Date:   Fri, 6 Oct 2023 22:44:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696625100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ibwo2EgPW3ipn5g8X6zPQ6+Vmq29eXKwo/fluAnfEOM=;
        b=NGjHPeYGHaDoiZNZcZMsRcfB9VI7ovoJNNa8UweydEixUysQhHaWnI/ZQt4aMoY+d8VX+c
        52Rfh7WHQbnqQURzAg1jpt38JtxTQZRSvWWowYVO8Oy+3vcg9IHZIu8MB2Rn7dnCaI1Gcz
        UThOiKCBhbp0ZBBdW3wreJVcptYkIc4336/a62UVE+9dpxNUIfHqH1dcJwA6YZ6LBYAcOq
        9V705E2cvK2UUNPoXecdPWVazuRABp3ynkyToOsE+3wcw43Nix21h0umwLTM3zksxh6koE
        /FcodilUSp2RtjIchQ6B0qAzm2IyHMyoNWRGtPE3iSnjFvVZ03VIALVycWp3Hg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696625100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ibwo2EgPW3ipn5g8X6zPQ6+Vmq29eXKwo/fluAnfEOM=;
        b=+JXg47WrTAf9dUM2hKpJYcmVf89USHmjmLuWoAea6bJp9p/Sto9Nc9wWGlRtQ0lu8qd4Fr
        YbSyuvHQ968wyHCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rc4-rt8
Message-ID: <20231006204455.93JQYA6P@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rc4-rt8 patch set. 

Changes since v6.6-rc4-rt7:

  - The amba-pl011 acciently used a trylock instead of a normal lock
    operation for console output. This has been introduced in the
    previous release. Reported by Pierre Gondois.

  - The 8250 atomic console implementation used a bit of code which was
    not designed for atomic consoles. Reported by Pierre Gondois, patch
    by John Ogness.

Known issues
     None

The delta patch against v6.6-rc4-rt7 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rc4-rt7-rt8.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rc4-rt8

The RT patch against v6.6-rc4 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rc4-rt8.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rc4-rt8.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 512fe4cabfa27..ed29d840070ee 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -557,6 +557,9 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	if (!p->em485)
 		return -ENOMEM;
 
+	if (uart_console(&p->port))
+		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
+
 	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
 	hrtimer_init(&p->em485->start_tx_timer, CLOCK_MONOTONIC,
@@ -709,17 +712,23 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
-static void serial8250_clear_IER(struct uart_8250_port *up)
+/* Only to be used by write_atomic(), which does not require port lock. */
+static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
-	/* Port locked to synchronize UART_IER access against the console. */
-	lockdep_assert_held_once(&up->port.lock);
-
 	if (up->capabilities & UART_CAP_UUE)
 		serial_out(up, UART_IER, UART_IER_UUE);
 	else
 		serial_out(up, UART_IER, 0);
 }
 
+static inline void serial8250_clear_IER(struct uart_8250_port *up)
+{
+	/* Port locked to synchronize UART_IER access against the console. */
+	lockdep_assert_held_once(&up->port.lock);
+
+	__serial8250_clear_IER(up);
+}
+
 #ifdef CONFIG_SERIAL_8250_RSA
 /*
  * Attempts to turn on the RSA FIFO.  Returns zero on failure.
@@ -3397,15 +3406,18 @@ static void serial8250_console_fifo_write(struct uart_8250_port *up,
  *	Doing runtime PM is really a bad idea for the kernel console.
  *	Thus, we assume the function is called when device is powered up.
  */
-static void __serial8250_console_write(struct uart_8250_port *up, const char *s,
-				       unsigned int count)
+void serial8250_console_write(struct uart_8250_port *up, const char *s,
+			      unsigned int count)
 {
 	struct uart_8250_em485 *em485 = up->em485;
 	struct uart_port *port = &up->port;
+	unsigned long flags;
 	unsigned int ier, use_fifo;
 
 	touch_nmi_watchdog();
 
+	uart_port_lock_irqsave(port, &flags);
+
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
@@ -3472,17 +3484,6 @@ static void __serial8250_console_write(struct uart_8250_port *up, const char *s,
 	 */
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
-}
-
-void serial8250_console_write(struct uart_8250_port *up, const char *s,
-			      unsigned int count)
-{
-	struct uart_port *port = &up->port;
-	unsigned long flags;
-
-	uart_port_lock_irqsave(port, &flags);
-
-	__serial8250_console_write(up, s, count);
 
 	uart_port_unlock_irqrestore(port, flags);
 }
@@ -3490,10 +3491,43 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 bool serial8250_console_write_atomic(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt)
 {
+	struct uart_port *port = &up->port;
+	unsigned int ier;
+
+	/* Atomic console not supported for rs485 mode. */
+	if (up->em485)
+		return false;
+
+	/* Atomic console does not support handling modem control. */
+	if (up->msr_saved_flags)
+		return false;
+
+	touch_nmi_watchdog();
+
 	if (!nbcon_enter_unsafe(wctxt))
 		return false;
 
-	__serial8250_console_write(up, wctxt->outbuf, wctxt->len);
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = serial_port_in(port, UART_IER);
+	__serial8250_clear_IER(up);
+
+	/* check scratch reg to see if port powered off during system sleep */
+	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
+		serial8250_console_restore(up);
+		up->canary = 0;
+	}
+
+	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+
+	serial_port_out(port, UART_IER, ier);
 
 	return nbcon_exit_unsafe(wctxt);
 }
diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 96da994e5af06..c6c2d3e46a8ec 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2335,7 +2335,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	if (uap->port.sysrq || oops_in_progress)
 		locked = uart_port_trylock_irqsave(&uap->port, &flags);
 	else
-		uart_port_trylock_irqsave(&uap->port, &flags);
+		uart_port_lock_irqsave(&uap->port, &flags);
 
 	/*
 	 *	First save the CR then disable the interrupts
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index abef60e6e4362..4cd2365628d09 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -870,6 +870,7 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
+ * @in_kthread:	True if called from kthread printer context.
  *
  * Return:	True if this context still owns the console. False if
  *		ownership was handed over or taken.
diff --git a/localversion-rt b/localversion-rt
index 045478966e9f1..700c857efd9ba 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt7
+-rt8
