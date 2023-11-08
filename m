Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37867E59F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjKHPXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKHPXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:23:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7E1BF7;
        Wed,  8 Nov 2023 07:23:33 -0800 (PST)
Date:   Wed, 8 Nov 2023 16:23:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699457011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=erRb7vQPaCkaGoL+bJF4S1b9t5zsq0fqtscyjEDriFY=;
        b=FR95MEKs1kvCA1adgrK81K9vuOdjnb8eHnndF87HgEsgpCKEDpoRrznbOdhs/PnTBiAef1
        UJIsYWW+zXsXB3A2P0OXCy/OIwME1XFENU2WxzcBG8AoBeYQbx8lDbbRSH/jeuUBSesPnv
        0yizanXQHoyUQEFM8PFVfPp5hEPos/mHBh+2BZO2XyEch2/BCbDb9lR9hc9EhXc9bPY6g8
        O4B9nyMlYucHC6rhPweTFWznXzivtd+t/OUfSncFg/3uLogSY07nJACEa7B/7EOhZ64oeu
        ZbSmYYm/XF5n1jmzVK/hSgeQFBELe+6L2YwvPqFffsj8yN3sMednVlIpdAc9Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699457011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=erRb7vQPaCkaGoL+bJF4S1b9t5zsq0fqtscyjEDriFY=;
        b=Bt4FwXOSkZxneHixqFSlckXNAUEnGsLHSuN+ZnN4DL+EYZF4QzyL0uzq1xaTtW6jiKnEUd
        ZjXq4w//OqYTgADw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [ANNOUNCE] v6.6-rt13
Message-ID: <20231108152329.NDcgOQAF@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear RT folks!

I'm pleased to announce the v6.6-rt13 patch set. 

Changes since v6.6-rt12:

  - Update to the printk series provided by John Ogness. Some of the
    patches were merged during the merge window other are under review.
    Here is a small changelog:
    - warn and panic console output will interrupt the threaded printing
      mid-line rather than waiting for the line to finish printing
    
    - in panic, printing is now synchronous rather than first storing all
      panic messages and then dumping to consoles
    
    - printing kthreads will sleep, rather than busy-wait, while consoles
      are in emergency or panic states
    
    - atomic console printing will only print to the end of the emergency
      messages, rather than flushing all remaining records
    
    - apply various printk mainline fixes currently in review
        https://lore.kernel.org/lkml/20231106210730.115192-1-john.ogness@linutronix.de

Known issues
     Pierre Gondois reported crashes on ARM64 together with "rtla timerlat
     hist" as trigger. It is not yet understood. The report is at
	https://lore.kernel.org/70c08728-3d4f-47a6-8a3e-114e4877d120@arm.com

The delta patch against v6.6-rt12 is appended below and can be found here:
 
     https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/incr/patch-6.6-rt12-rt13.patch.xz

You can get this release via the git tree at:

    https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-rt-devel.git v6.6-rt13

The RT patch against v6.6 can be found here:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patch-6.6-rt13.patch.xz

The split quilt queue is available at:

    https://cdn.kernel.org/pub/linux/kernel/projects/rt/6.6/older/patches-6.6-rt13.tar.xz

Sebastian

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 0535e4903c8d1..eab9b37344a5e 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -592,6 +592,7 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 #ifdef CONFIG_SERIAL_8250_CONSOLE
 
+#ifdef CONFIG_SERIAL_8250_LEGACY_CONSOLE
 static void univ8250_console_write(struct console *co, const char *s,
 				   unsigned int count)
 {
@@ -599,7 +600,7 @@ static void univ8250_console_write(struct console *co, const char *s,
 
 	serial8250_console_write(up, s, count);
 }
-
+#else
 static bool univ8250_console_write_atomic(struct console *co,
 					  struct nbcon_write_context *wctxt)
 {
@@ -608,10 +609,19 @@ static bool univ8250_console_write_atomic(struct console *co,
 	return serial8250_console_write_atomic(up, wctxt);
 }
 
+static bool univ8250_console_write_thread(struct console *co,
+					  struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_port *up = &serial8250_ports[co->index];
+
+	return serial8250_console_write_thread(up, wctxt);
+}
+
 static struct uart_port *univ8250_console_uart_port(struct console *con)
 {
 	return &serial8250_ports[con->index].port;
 }
+#endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
 static int univ8250_console_setup(struct console *co, char *options)
 {
@@ -711,15 +721,19 @@ static int univ8250_console_match(struct console *co, char *name, int idx,
 
 static struct console univ8250_console = {
 	.name		= "ttyS",
+#ifdef CONFIG_SERIAL_8250_LEGACY_CONSOLE
 	.write		= univ8250_console_write,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME,
+#else
 	.write_atomic	= univ8250_console_write_atomic,
-	.write_thread	= univ8250_console_write_atomic,
+	.write_thread	= univ8250_console_write_thread,
+	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
 	.uart_port	= univ8250_console_uart_port,
+#endif
 	.device		= uart_console_device,
 	.setup		= univ8250_console_setup,
 	.exit		= univ8250_console_exit,
 	.match		= univ8250_console_match,
-	.flags		= CON_PRINTBUFFER | CON_ANYTIME | CON_NBCON,
 	.index		= -1,
 	.data		= &serial8250_reg,
 };
diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
index 8c5f8bb16bd39..478b23c207169 100644
--- a/drivers/tty/serial/8250/8250_port.c
+++ b/drivers/tty/serial/8250/8250_port.c
@@ -557,8 +557,10 @@ static int serial8250_em485_init(struct uart_8250_port *p)
 	if (!p->em485)
 		return -ENOMEM;
 
+#ifndef CONFIG_SERIAL_8250_LEGACY_CONSOLE
 	if (uart_console(&p->port))
 		dev_warn(p->port.dev, "no atomic printing for rs485 consoles\n");
+#endif
 
 	hrtimer_init(&p->em485->stop_tx_timer, CLOCK_MONOTONIC,
 		     HRTIMER_MODE_REL);
@@ -712,7 +714,10 @@ static void serial8250_set_sleep(struct uart_8250_port *p, int sleep)
 	serial8250_rpm_put(p);
 }
 
-/* Only to be used by write_atomic(), which does not require port lock. */
+/*
+ * Only to be used by write_atomic() and the legacy write(), which do not
+ * require port lock.
+ */
 static void __serial8250_clear_IER(struct uart_8250_port *up)
 {
 	if (up->capabilities & UART_CAP_UUE)
@@ -3340,6 +3345,11 @@ static void serial8250_console_putchar(struct uart_port *port, unsigned char ch)
 
 	wait_for_xmitr(up, UART_LSR_THRE);
 	serial_port_out(port, UART_TX, ch);
+
+	if (ch == '\n')
+		up->console_newline_needed = false;
+	else
+		up->console_newline_needed = true;
 }
 
 /*
@@ -3368,6 +3378,7 @@ static void serial8250_console_restore(struct uart_8250_port *up)
 	serial8250_out_MCR(up, up->mcr | UART_MCR_DTR | UART_MCR_RTS);
 }
 
+#ifdef CONFIG_SERIAL_8250_LEGACY_CONSOLE
 /*
  * Print a string to the serial port using the device FIFO
  *
@@ -3413,16 +3424,20 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	struct uart_port *port = &up->port;
 	unsigned long flags;
 	unsigned int ier, use_fifo;
+	int locked = 1;
 
 	touch_nmi_watchdog();
 
-	uart_port_lock_irqsave(port, &flags);
+	if (oops_in_progress)
+		locked = uart_port_trylock_irqsave(port, &flags);
+	else
+		uart_port_lock_irqsave(port, &flags);
 
 	/*
 	 *	First save the IER then disable the interrupts
 	 */
 	ier = serial_port_in(port, UART_IER);
-	serial8250_clear_IER(up);
+	__serial8250_clear_IER(up);
 
 	/* check scratch reg to see if port powered off during system sleep */
 	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
@@ -3485,7 +3500,102 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 	if (up->msr_saved_flags)
 		serial8250_modem_status(up);
 
-	uart_port_unlock_irqrestore(port, flags);
+	if (locked)
+		uart_port_unlock_irqrestore(port, flags);
+}
+#else
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt)
+{
+	struct uart_8250_em485 *em485 = up->em485;
+	struct uart_port *port = &up->port;
+	bool done = false;
+	unsigned int ier;
+
+	touch_nmi_watchdog();
+
+	if (!nbcon_enter_unsafe(wctxt))
+		return false;
+
+	/*
+	 *	First save the IER then disable the interrupts
+	 */
+	ier = serial_port_in(port, UART_IER);
+	serial8250_clear_IER(up);
+
+	/* check scratch reg to see if port powered off during system sleep */
+	if (up->canary && (up->canary != serial_port_in(port, UART_SCR))) {
+		serial8250_console_restore(up);
+		up->canary = 0;
+	}
+
+	if (em485) {
+		if (em485->tx_stopped)
+			up->rs485_start_tx(up);
+		mdelay(port->rs485.delay_rts_before_send);
+	}
+
+	if (nbcon_exit_unsafe(wctxt)) {
+		int len = READ_ONCE(wctxt->len);
+		int i;
+
+		/*
+		 * Write out the message. Toggle unsafe for each byte in order
+		 * to give another (higher priority) context the opportunity
+		 * for a friendly takeover. If such a takeover occurs, this
+		 * context must reacquire ownership in order to perform final
+		 * actions (such as re-enabling the interrupts).
+		 *
+		 * IMPORTANT: wctxt->outbuf and wctxt->len are no longer valid
+		 *	      after a reacquire so writing the message must be
+		 *	      aborted.
+		 */
+		for (i = 0; i < len; i++) {
+			if (!nbcon_enter_unsafe(wctxt)) {
+				nbcon_reacquire(wctxt);
+				break;
+			}
+
+			uart_console_write(port, wctxt->outbuf + i, 1, serial8250_console_putchar);
+
+			if (!nbcon_exit_unsafe(wctxt)) {
+				nbcon_reacquire(wctxt);
+				break;
+			}
+		}
+		done = (i == len);
+	} else {
+		nbcon_reacquire(wctxt);
+	}
+
+	while (!nbcon_enter_unsafe(wctxt))
+		nbcon_reacquire(wctxt);
+
+	/*
+	 *	Finally, wait for transmitter to become empty
+	 *	and restore the IER
+	 */
+	wait_for_xmitr(up, UART_LSR_BOTH_EMPTY);
+
+	if (em485) {
+		mdelay(port->rs485.delay_rts_after_send);
+		if (em485->tx_stopped)
+			up->rs485_stop_tx(up);
+	}
+
+	serial_port_out(port, UART_IER, ier);
+
+	/*
+	 *	The receive handling will happen properly because the
+	 *	receive ready bit will still be set; it is not cleared
+	 *	on read.  However, modem control will not, we must
+	 *	call it if we have saved something in the saved flags
+	 *	while processing with interrupts off.
+	 */
+	if (up->msr_saved_flags)
+		serial8250_modem_status(up);
+
+	return (nbcon_exit_unsafe(wctxt) && done);
 }
 
 bool serial8250_console_write_atomic(struct uart_8250_port *up,
@@ -3515,6 +3625,8 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 		up->canary = 0;
 	}
 
+	if (up->console_newline_needed)
+		uart_console_write(port, "\n", 1, serial8250_console_putchar);
 	uart_console_write(port, wctxt->outbuf, wctxt->len, serial8250_console_putchar);
 
 	/*
@@ -3527,6 +3639,7 @@ bool serial8250_console_write_atomic(struct uart_8250_port *up,
 
 	return nbcon_exit_unsafe(wctxt);
 }
+#endif /* CONFIG_SERIAL_8250_LEGACY_CONSOLE */
 
 static unsigned int probe_baud(struct uart_port *port)
 {
@@ -3545,6 +3658,7 @@ static unsigned int probe_baud(struct uart_port *port)
 
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 {
+	struct uart_8250_port *up = up_to_u8250p(port);
 	int baud = 9600;
 	int bits = 8;
 	int parity = 'n';
@@ -3554,6 +3668,8 @@ int serial8250_console_setup(struct uart_port *port, char *options, bool probe)
 	if (!port->iobase && !port->membase)
 		return -ENODEV;
 
+	up->console_newline_needed = false;
+
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
 	else if (probe)
diff --git a/include/linux/console.h b/include/linux/console.h
index 6bbb898f25474..87e787ffb6531 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -467,17 +467,19 @@ static inline bool console_is_registered(const struct console *con)
 	hlist_for_each_entry(con, &console_list, node)
 
 #ifdef CONFIG_PRINTK
-extern enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio);
-extern void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio);
+extern void nbcon_cpu_emergency_enter(void);
+extern void nbcon_cpu_emergency_exit(void);
 extern bool nbcon_can_proceed(struct nbcon_write_context *wctxt);
 extern bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt);
 extern bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt);
+extern void nbcon_reacquire(struct nbcon_write_context *wctxt);
 #else
-static inline enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio) { return NBCON_PRIO_NONE; }
-static inline void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio) { }
+static inline void nbcon_cpu_emergency_enter(void) { }
+static inline void nbcon_cpu_emergency_exit(void) { }
 static inline bool nbcon_can_proceed(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_enter_unsafe(struct nbcon_write_context *wctxt) { return false; }
 static inline bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt) { return false; }
+static inline void nbcon_reacquire(struct nbcon_write_context *wctxt) { }
 #endif
 
 extern int console_set_on_cmdline;
diff --git a/include/linux/printk.h b/include/linux/printk.h
index d77e13fd4cd32..196a4cf3ccb76 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -197,9 +197,9 @@ void show_regs_print_info(const char *log_lvl);
 extern asmlinkage void dump_stack_lvl(const char *log_lvl) __cold;
 extern asmlinkage void dump_stack(void) __cold;
 void printk_trigger_flush(void);
-extern void nbcon_atomic_flush_all(void);
 extern void nbcon_handle_port_lock(struct uart_port *up);
 extern void nbcon_handle_port_unlock(struct uart_port *up);
+void nbcon_atomic_flush_unsafe(void);
 #else
 static inline __printf(1, 0)
 int vprintk(const char *s, va_list args)
@@ -280,10 +280,6 @@ static inline void printk_trigger_flush(void)
 {
 }
 
-static inline void nbcon_atomic_flush_all(void)
-{
-}
-
 static inline void nbcon_handle_port_lock(struct uart_port *up)
 {
 }
@@ -292,6 +288,10 @@ static inline void nbcon_handle_port_unlock(struct uart_port *up)
 {
 }
 
+static inline void nbcon_atomic_flush_unsafe(void)
+{
+}
+
 #endif
 
 #ifdef CONFIG_SMP
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index dab5e820d778a..ec46e3b49ee99 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -153,6 +153,8 @@ struct uart_8250_port {
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
 
+	bool			console_newline_needed;
+
 	struct uart_8250_dma	*dma;
 	const struct uart_8250_ops *ops;
 
@@ -206,6 +208,8 @@ void serial8250_console_write(struct uart_8250_port *up, const char *s,
 			      unsigned int count);
 bool serial8250_console_write_atomic(struct uart_8250_port *up,
 				     struct nbcon_write_context *wctxt);
+bool serial8250_console_write_thread(struct uart_8250_port *up,
+				     struct nbcon_write_context *wctxt);
 int serial8250_console_setup(struct uart_port *port, char *options, bool probe);
 int serial8250_console_exit(struct uart_port *port);
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 5310a94e3efdc..00465373d358f 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3968,12 +3968,10 @@ static void
 print_usage_bug(struct task_struct *curr, struct held_lock *this,
 		enum lock_usage_bit prev_bit, enum lock_usage_bit new_bit)
 {
-	enum nbcon_prio prev_prio;
-
 	if (!debug_locks_off() || debug_locks_silent)
 		return;
 
-	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+	nbcon_cpu_emergency_enter();
 
 	pr_warn("\n");
 	pr_warn("================================\n");
@@ -4004,7 +4002,7 @@ print_usage_bug(struct task_struct *curr, struct held_lock *this,
 	pr_warn("\nstack backtrace:\n");
 	dump_stack();
 
-	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
+	nbcon_cpu_emergency_exit();
 }
 
 /*
diff --git a/kernel/panic.c b/kernel/panic.c
index b4c36409a7744..42890ffc7ae98 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -275,7 +275,6 @@ static void panic_other_cpus_shutdown(bool crash_kexec)
  */
 void panic(const char *fmt, ...)
 {
-	enum nbcon_prio prev_prio;
 	static char buf[1024];
 	va_list args;
 	long i, i_next = 0, len;
@@ -323,8 +322,6 @@ void panic(const char *fmt, ...)
 	if (old_cpu != PANIC_CPU_INVALID && old_cpu != this_cpu)
 		panic_smp_self_stop();
 
-	prev_prio = nbcon_atomic_enter(NBCON_PRIO_PANIC);
-
 	console_verbose();
 	bust_spinlocks(1);
 	va_start(args, fmt);
@@ -385,8 +382,6 @@ void panic(const char *fmt, ...)
 	if (_crash_kexec_post_notifiers)
 		__crash_kexec(NULL);
 
-	nbcon_atomic_flush_all();
-
 	console_unblank();
 
 	/*
@@ -411,7 +406,6 @@ void panic(const char *fmt, ...)
 		 * We can't use the "normal" timers since we just panicked.
 		 */
 		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
-		nbcon_atomic_flush_all();
 
 		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
 			touch_nmi_watchdog();
@@ -430,7 +424,6 @@ void panic(const char *fmt, ...)
 		 */
 		if (panic_reboot_mode != REBOOT_UNDEFINED)
 			reboot_mode = panic_reboot_mode;
-		nbcon_atomic_flush_all();
 		emergency_restart();
 	}
 #ifdef __sparc__
@@ -443,7 +436,6 @@ void panic(const char *fmt, ...)
 	}
 #endif
 #if defined(CONFIG_S390)
-	nbcon_atomic_flush_all();
 	disabled_wait();
 #endif
 	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
@@ -451,7 +443,7 @@ void panic(const char *fmt, ...)
 	/* Do not scroll important messages printed above */
 	suppress_printk = 1;
 
-	nbcon_atomic_exit(NBCON_PRIO_PANIC, prev_prio);
+	nbcon_atomic_flush_unsafe();
 
 	local_irq_enable();
 	for (i = 0; ; i += PANIC_TIMER_STEP) {
@@ -614,10 +606,6 @@ bool oops_may_print(void)
 	return pause_on_oops_flag == 0;
 }
 
-static int oops_printing_cpu = -1;
-static int oops_nesting;
-static enum nbcon_prio oops_prev_prio;
-
 /*
  * Called when the architecture enters its oops handler, before it prints
  * anything.  If this is the first CPU to oops, and it's oopsing the first
@@ -634,38 +622,7 @@ static enum nbcon_prio oops_prev_prio;
  */
 void oops_enter(void)
 {
-	enum nbcon_prio prev_prio;
-	int cur_cpu = get_cpu();
-	int old_cpu = -1;
-
-	/*
-	 * If this turns out to be the first CPU in oops, this is the
-	 * beginning of the outermost atomic printing section. Otherwise
-	 * it is the beginning of an inner atomic printing section.
-	 */
-	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
-
-	old_cpu = cmpxchg(&oops_printing_cpu, old_cpu, cur_cpu);
-	if (old_cpu == -1) {
-		/*
-		 * This is the first CPU in oops so it will be the printer.
-		 * Save the outermost @prev_prio in order to restore it on the
-		 * outermost matching oops_exit(), when @oops_nesting == 0.
-		 */
-		oops_prev_prio = prev_prio;
-
-		/*
-		 * Enter an inner atomic printing section that ends at the end
-		 * of this function. In this case, the nbcon_atomic_enter()
-		 * above began the outermost atomic printing section.
-		 */
-		prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
-	}
-
-	/* Track nesting when this CPU is the printer. */
-	if (old_cpu == -1 || old_cpu == cur_cpu)
-		oops_nesting++;
-
+	nbcon_cpu_emergency_enter();
 	tracing_off();
 	/* can't trust the integrity of the kernel anymore: */
 	debug_locks_off();
@@ -673,9 +630,6 @@ void oops_enter(void)
 
 	if (sysctl_oops_all_cpu_backtrace)
 		trigger_all_cpu_backtrace();
-
-	/* Exit inner atomic printing section. */
-	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
 }
 
 static void print_oops_end_marker(void)
@@ -691,23 +645,7 @@ void oops_exit(void)
 {
 	do_oops_enter_exit();
 	print_oops_end_marker();
-
-	/*
-	 * Reading @oops_printing_cpu is a data race if this CPU is not the
-	 * printer. But that is OK because in that situation the condition
-	 * will correctly evaluate to false regardless which value was read.
-	 */
-	if (oops_printing_cpu == smp_processor_id()) {
-		oops_nesting--;
-		if (oops_nesting == 0) {
-			oops_printing_cpu = -1;
-
-			/* Exit outermost atomic printing section. */
-			nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, oops_prev_prio);
-		}
-	}
-	put_cpu();
-
+	nbcon_cpu_emergency_exit();
 	kmsg_dump(KMSG_DUMP_OOPS);
 }
 
@@ -719,9 +657,7 @@ struct warn_args {
 void __warn(const char *file, int line, void *caller, unsigned taint,
 	    struct pt_regs *regs, struct warn_args *args)
 {
-	enum nbcon_prio prev_prio;
-
-	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+	nbcon_cpu_emergency_enter();
 
 	disable_trace_on_warning();
 
@@ -754,7 +690,7 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
 	/* Just a warning, don't kill lockdep. */
 	add_taint(taint, LOCKDEP_STILL_OK);
 
-	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
+	nbcon_cpu_emergency_exit();
 }
 
 #ifdef CONFIG_BUG
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 654a9bfb4d154..db8329091bb82 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -54,7 +54,7 @@ extern bool have_boot_console;
  * be printed serially along with the legacy consoles because nbcon
  * consoles cannot print simultaneously with boot consoles.
  */
-#define serialized_printing (have_legacy_console || have_boot_console)
+#define printing_via_unlock (have_legacy_console || have_boot_console)
 
 __printf(4, 0)
 int vprintk_store(int facility, int level,
@@ -88,7 +88,9 @@ void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_free(struct console *con);
-bool nbcon_console_emit_next_record(struct console *con);
+enum nbcon_prio nbcon_get_default_prio(void);
+void nbcon_atomic_flush_all(void);
+bool nbcon_atomic_emit_next_record(struct console *con);
 void nbcon_kthread_create(struct console *con);
 void nbcon_wake_threads(void);
 void nbcon_legacy_kthread_create(void);
@@ -160,7 +162,7 @@ static inline void nbcon_kthread_wake(struct console *con)
 static inline void nbcon_kthread_wake(struct console *con) { }
 static inline void nbcon_kthread_create(struct console *con) { }
 #define printk_threads_enabled (false)
-#define serialized_printing (false)
+#define printing_via_unlock (false)
 
 /*
  * In !PRINTK builds we still export console_sem
@@ -176,7 +178,9 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_free(struct console *con) { }
-static bool nbcon_console_emit_next_record(struct console *con) { return false; }
+enum nbcon_prio nbcon_get_default_prio(void) { return NBCON_PRIO_NONE; }
+static inline void nbcon_atomic_flush_all(void) { }
+static bool nbcon_atomic_emit_next_record(struct console *con) { return false; }
 
 static inline bool console_is_usable(struct console *con, short flags, bool use_atomic) { return false; }
 
@@ -211,6 +215,7 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 4cd2365628d09..a9be219673dbf 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -867,10 +867,26 @@ bool nbcon_exit_unsafe(struct nbcon_write_context *wctxt)
 }
 EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
 
+void nbcon_reacquire(struct nbcon_write_context *wctxt)
+{
+	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
+	struct console *con = ctxt->console;
+	struct nbcon_state cur;
+
+	while (!nbcon_context_try_acquire(ctxt))
+		cpu_relax();
+
+	wctxt->outbuf = NULL;
+	wctxt->len = 0;
+	nbcon_state_read(con, &cur);
+	wctxt->unsafe_takeover = cur.unsafe_takeover;
+}
+EXPORT_SYMBOL_GPL(nbcon_reacquire);
+
 /**
  * nbcon_emit_next_record - Emit a record in the acquired context
  * @wctxt:	The write context that will be handed to the write function
- * @in_kthread:	True if called from kthread printer context.
+ * @use_atomic:	True if the write_atomic callback is to be used
  *
  * Return:	True if this context still owns the console. False if
  *		ownership was handed over or taken.
@@ -884,7 +900,7 @@ EXPORT_SYMBOL_GPL(nbcon_exit_unsafe);
  * When true is returned, @wctxt->ctxt.backlog indicates whether there are
  * still records pending in the ringbuffer,
  */
-static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool in_kthread)
+static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool use_atomic)
 {
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
 	struct console *con = ctxt->console;
@@ -934,19 +950,29 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool in_kt
 	nbcon_state_read(con, &cur);
 	wctxt->unsafe_takeover = cur.unsafe_takeover;
 
-	if (!in_kthread && con->write_atomic) {
+	if (use_atomic &&
+	    con->write_atomic) {
 		done = con->write_atomic(con, wctxt);
-	} else if (in_kthread && con->write_thread && con->kthread) {
+
+	} else if (!use_atomic &&
+		   con->write_thread &&
+		   con->kthread) {
+		WARN_ON_ONCE(con->kthread != current);
 		done = con->write_thread(con, wctxt);
+
 	} else {
-		nbcon_context_release(ctxt);
 		WARN_ON_ONCE(1);
 		done = false;
 	}
 
-	/* If not done, the emit was aborted. */
-	if (!done)
+	if (!done) {
+		/*
+		 * The emit was aborted. This may have been due to a loss
+		 * of ownership. Explicitly release ownership to be sure.
+		 */
+		nbcon_context_release(ctxt);
 		return false;
+	}
 
 	/*
 	 * Since any dropped message was successfully output, reset the
@@ -974,13 +1000,13 @@ static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt, bool in_kt
 }
 
 /**
- * nbcon_kthread_should_wakeup - Check whether the printk thread should wakeup
+ * nbcon_kthread_should_wakeup - Check whether a printer thread should wakeup
  * @con:	Console to operate on
  * @ctxt:	The acquire context that contains the state
  *		at console_acquire()
  *
- * Returns: True if the thread should shutdown or if the console is allowed to
- * print and a record is available. False otherwise
+ * Return:	True if the thread should shutdown or if the console is
+ *		allowed to print and a record is available. False otherwise.
  *
  * After the thread wakes up, it must first check if it should shutdown before
  * attempting any printing.
@@ -992,25 +1018,28 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 	short flags;
 	int cookie;
 
-	if (kthread_should_stop())
-		return true;
+	do {
+		if (kthread_should_stop())
+			return true;
 
-	cookie = console_srcu_read_lock();
-	flags = console_srcu_read_flags(con);
-	is_usable = console_is_usable(con, flags, false);
-	console_srcu_read_unlock(cookie);
+		cookie = console_srcu_read_lock();
+		flags = console_srcu_read_flags(con);
+		is_usable = console_is_usable(con, flags, false);
+		console_srcu_read_unlock(cookie);
 
-	if (!is_usable)
-		return false;
+		if (!is_usable)
+			return false;
 
-	nbcon_state_read(con, &cur);
+		nbcon_state_read(con, &cur);
 
-	/*
-	 * Atomic printing is running on some other CPU. The owner
-	 * will wake the console thread on unlock if necessary.
-	 */
-	if (cur.prio != NBCON_PRIO_NONE)
-		return false;
+		/*
+		 * Some other CPU is using the console. Patiently poll
+		 * to see if it becomes available. This is more efficient
+		 * than having every release trigger an irq_work to wake
+		 * the kthread.
+		 */
+		msleep(1);
+	} while (cur.prio != NBCON_PRIO_NONE);
 
 	/* Bring the sequence in @ctxt up to date */
 	nbcon_context_seq_set(ctxt);
@@ -1019,7 +1048,7 @@ static bool nbcon_kthread_should_wakeup(struct console *con, struct nbcon_contex
 }
 
 /**
- * nbcon_kthread_func - The printk thread function
+ * nbcon_kthread_func - The printer thread function
  * @__console:	Console to operate on
  */
 static int nbcon_kthread_func(void *__console)
@@ -1084,7 +1113,7 @@ static int nbcon_kthread_func(void *__console)
 				 * If the emit fails, this context is no
 				 * longer the owner.
 				 */
-				if (nbcon_emit_next_record(&wctxt, true)) {
+				if (nbcon_emit_next_record(&wctxt, false)) {
 					nbcon_context_release(ctxt);
 					backlog = ctxt->backlog;
 				}
@@ -1160,40 +1189,37 @@ void nbcon_wake_threads(void)
 	console_srcu_read_unlock(cookie);
 }
 
-/**
- * struct nbcon_cpu_state - Per CPU printk context state
- * @prio:	The current context priority level
- * @nesting:	Per priority nest counter
- */
-struct nbcon_cpu_state {
-	enum nbcon_prio		prio;
-	int			nesting[NBCON_PRIO_MAX];
-};
-
-static DEFINE_PER_CPU(struct nbcon_cpu_state, nbcon_pcpu_state);
-static struct nbcon_cpu_state early_nbcon_pcpu_state __initdata;
+/* Track the nbcon emergency nesting per CPU. */
+static DEFINE_PER_CPU(unsigned int, nbcon_pcpu_emergency_nesting);
+static unsigned int early_nbcon_pcpu_emergency_nesting __initdata;
 
 /**
- * nbcon_get_cpu_state - Get the per CPU console state pointer
+ * nbcon_get_cpu_emergency_nesting - Get the per CPU emergency nesting pointer
  *
- * Returns either a pointer to the per CPU state of the current CPU or to
- * the init data state during early boot.
+ * Return:	Either a pointer to the per CPU emergency nesting counter of
+ *		the current CPU or to the init data during early boot.
  */
-static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
+static __ref unsigned int *nbcon_get_cpu_emergency_nesting(void)
 {
+	/*
+	 * The value of __printk_percpu_data_ready gets set in normal
+	 * context and before SMP initialization. As a result it could
+	 * never change while inside an nbcon emergency section.
+	 */
 	if (!printk_percpu_data_ready())
-		return &early_nbcon_pcpu_state;
+		return &early_nbcon_pcpu_emergency_nesting;
 
-	return this_cpu_ptr(&nbcon_pcpu_state);
+	return this_cpu_ptr(&nbcon_pcpu_emergency_nesting);
 }
 
 /**
- * nbcon_atomic_emit_one - Print one record for a console in atomic mode
+ * nbcon_atomic_emit_one - Print one record for an nbcon console using the
+ *					write_atomic() callback
  * @wctxt:			An initialized write context struct to use
  *				for this context
  *
- * Returns false if the given console could not print a record or there are
- * no more records to print, otherwise true.
+ * Return:	False if the given console could not print a record or there
+ *		are no more records to print, otherwise true.
  *
  * This is an internal helper to handle the locking of the console before
  * calling nbcon_emit_next_record().
@@ -1210,36 +1236,53 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
 	 * handed over or taken over. In both cases the context is no
 	 * longer valid.
 	 */
-	if (!nbcon_emit_next_record(wctxt, false))
+	if (!nbcon_emit_next_record(wctxt, true))
 		return false;
 
 	nbcon_context_release(ctxt);
 
-	return prb_read_valid(prb, ctxt->seq, NULL);
+	return ctxt->backlog;
 }
 
 /**
- * nbcon_console_emit_next_record - Print one record for an nbcon console
- *					in atomic mode
+ * nbcon_get_default_prio - The appropriate nbcon priority to use for nbcon
+ *				printing on the current CPU
+ *
+ * Return:	The nbcon_prio to use for acquiring an nbcon console in this
+ *		context for printing.
+ */
+enum nbcon_prio nbcon_get_default_prio(void)
+{
+	unsigned int *cpu_emergency_nesting;
+
+	if (this_cpu_in_panic())
+		return NBCON_PRIO_PANIC;
+
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	if (*cpu_emergency_nesting)
+		return NBCON_PRIO_EMERGENCY;
+
+	return NBCON_PRIO_NORMAL;
+}
+
+/**
+ * nbcon_atomic_emit_next_record - Print one record for an nbcon console
+ *					using the write_atomic() callback
  * @con:	The console to print on
  *
  * Return:	True if a record could be printed, otherwise false.
- * Context:	Any context where migration is disabled.
+ * Context:	Any context which could not be migrated to another CPU.
  *
- * This function is meant to be called by console_flush_all() to atomically
- * print records on nbcon consoles. Essentially it is the nbcon version of
- * console_emit_next_record().
- *
- * This function also returns false if the current CPU is in an elevated
- * atomic priority state in order to allow the CPU to get all of the
- * emergency messages into the ringbuffer first.
+ * This function is meant to be called by console_flush_all() to print records
+ * on nbcon consoles using the write_atomic() callback. Essentially it is the
+ * nbcon version of console_emit_next_record().
  */
-bool nbcon_console_emit_next_record(struct console *con)
+bool nbcon_atomic_emit_next_record(struct console *con)
 {
 	struct uart_port *port = con->uart_port(con);
 	static DEFINE_SPINLOCK(shared_spinlock);
-	struct nbcon_cpu_state *cpu_state;
 	bool progress = false;
+	enum nbcon_prio prio;
 	unsigned long flags;
 
 	/*
@@ -1252,21 +1295,17 @@ bool nbcon_console_emit_next_record(struct console *con)
 	else
 		spin_lock_irqsave(&shared_spinlock, flags);
 
-	cpu_state = nbcon_get_cpu_state();
-
 	/*
-	 * Atomic printing from console_flush_all() only occurs if this
-	 * CPU is not in an elevated atomic priority state. If it is, the
-	 * atomic printing will occur when this CPU exits that state. This
-	 * allows a set of emergency messages to be completely stored in
-	 * the ringbuffer before this CPU begins flushing.
+	 * Do not emit for EMERGENCY priority. The console will be
+	 * explicitly flushed when exiting the emergency section.
 	 */
-	if (cpu_state->prio <= NBCON_PRIO_NORMAL) {
+	prio = nbcon_get_default_prio();
+	if (prio != NBCON_PRIO_EMERGENCY) {
 		struct nbcon_write_context wctxt = { };
 		struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
 
 		ctxt->console	= con;
-		ctxt->prio	= NBCON_PRIO_NORMAL;
+		ctxt->prio	= prio;
 
 		progress = nbcon_atomic_emit_one(&wctxt);
 	}
@@ -1280,41 +1319,26 @@ bool nbcon_console_emit_next_record(struct console *con)
 }
 
 /**
- * __nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
+ * __nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ *					write_atomic() callback
+ * @stop_seq:			Flush up until this record
  * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
  */
-static void __nbcon_atomic_flush_all(bool allow_unsafe_takeover)
+static void __nbcon_atomic_flush_all(u64 stop_seq, bool allow_unsafe_takeover)
 {
 	struct nbcon_write_context wctxt = { };
 	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
-	struct nbcon_cpu_state *cpu_state;
+	enum nbcon_prio prio = nbcon_get_default_prio();
 	struct console *con;
 	bool any_progress;
 	int cookie;
 
-	cpu_state = nbcon_get_cpu_state();
-
-	/*
-	 * Let the outermost flush of this priority print. This avoids
-	 * nasty hackery for nested WARN() where the printing itself
-	 * generates one and ensures such nested messages are stored to
-	 * the ringbuffer before any printing resumes.
-	 *
-	 * cpu_state->prio <= NBCON_PRIO_NORMAL is not subject to nesting
-	 * and can proceed in order to allow any atomic printing for
-	 * regular kernel messages.
-	 */
-	if (cpu_state->prio > NBCON_PRIO_NORMAL &&
-	    cpu_state->nesting[cpu_state->prio] != 1)
-		return;
-
 	do {
 		any_progress = false;
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
 			short flags = console_srcu_read_flags(con);
-			bool progress;
 
 			if (!(flags & CON_NBCON))
 				continue;
@@ -1322,111 +1346,100 @@ static void __nbcon_atomic_flush_all(bool allow_unsafe_takeover)
 			if (!console_is_usable(con, flags, true))
 				continue;
 
+			if (nbcon_seq_read(con) >= stop_seq)
+				continue;
+
 			memset(ctxt, 0, sizeof(*ctxt));
 			ctxt->console			= con;
 			ctxt->spinwait_max_us		= 2000;
-			ctxt->prio			= cpu_state->prio;
+			ctxt->prio			= prio;
 			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
 
-			progress = nbcon_atomic_emit_one(&wctxt);
-			if (!progress)
-				continue;
-			any_progress = true;
+			any_progress |= nbcon_atomic_emit_one(&wctxt);
 		}
 		console_srcu_read_unlock(cookie);
 	} while (any_progress);
 }
 
 /**
- * nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
+ * nbcon_atomic_flush_all - Flush all nbcon consoles using their
+ *				write_atomic() callback
  *
- * Context:	Any context where migration is disabled.
+ * Flush the backlog up through the currently newest record. Any new
+ * records added while flushing will not be flushed. This is to avoid
+ * one CPU printing unbounded because other CPUs continue to add records.
+ *
+ * Context:	Any context which could not be migrated to another CPU.
  */
 void nbcon_atomic_flush_all(void)
 {
-	__nbcon_atomic_flush_all(false);
+	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), false);
 }
 
 /**
- * nbcon_atomic_enter - Enter a context that enforces atomic printing
- * @prio:	Priority of the context
+ * nbcon_atomic_flush_unsafe - Flush all nbcon consoles using their
+ *	write_atomic() callback and allowing unsafe hostile takeovers
+ *
+ * Flush the backlog up through the currently newest record. Unsafe hostile
+ * takeovers will be performed, if necessary.
+ *
+ * Context:	Any context which could not be migrated to another CPU.
+ */
+void nbcon_atomic_flush_unsafe(void)
+{
+	__nbcon_atomic_flush_all(prb_next_reserve_seq(prb), true);
+}
+
+/**
+ * nbcon_cpu_emergency_enter - Enter an emergency section where printk()
+ *	messages for that CPU are only stored
+ *
+ * Upon exiting the emergency section, all stored messages are flushed.
  *
- * Return:	The previous priority that needs to be fed into
- *		the corresponding nbcon_atomic_exit()
  * Context:	Any context. Disables preemption.
  *
- * When within an atomic printing section, no atomic printing occurs. This
+ * When within an emergency section, no printing occurs on that CPU. This
  * is to allow all emergency messages to be dumped into the ringbuffer before
- * flushing the ringbuffer. The actual atomic printing occurs when exiting
- * the outermost atomic printing section.
+ * flushing the ringbuffer. The actual printing occurs when exiting the
+ * outermost emergency section.
  */
-enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio)
+void nbcon_cpu_emergency_enter(void)
 {
-	struct nbcon_cpu_state *cpu_state;
-	enum nbcon_prio prev_prio;
+	unsigned int *cpu_emergency_nesting;
 
 	preempt_disable();
 
-	cpu_state = nbcon_get_cpu_state();
-
-	prev_prio = cpu_state->prio;
-	if (prio > prev_prio)
-		cpu_state->prio = prio;
-
-	/*
-	 * Increment the nesting on @cpu_state->prio (instead of
-	 * @prio) so that a WARN() nested within a panic printout
-	 * does not attempt to scribble state.
-	 */
-	cpu_state->nesting[cpu_state->prio]++;
-
-	return prev_prio;
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
+	(*cpu_emergency_nesting)++;
 }
 
 /**
- * nbcon_atomic_exit - Exit a context that enforces atomic printing
- * @prio:	Priority of the context to leave
- * @prev_prio:	Priority of the previous context for restore
+ * nbcon_cpu_emergency_exit - Exit an emergency section and flush the
+ *	stored messages
+ *
+ * Flushing only occurs when exiting all nesting for the CPU.
  *
  * Context:	Any context. Enables preemption.
- *
- * @prev_prio is the priority returned by the corresponding
- * nbcon_atomic_enter().
  */
-void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
+void nbcon_cpu_emergency_exit(void)
 {
-	struct nbcon_cpu_state *cpu_state;
-	u64 next_seq = prb_next_seq(prb);
+	unsigned int *cpu_emergency_nesting;
 
-	__nbcon_atomic_flush_all(false);
+	cpu_emergency_nesting = nbcon_get_cpu_emergency_nesting();
 
-	cpu_state = nbcon_get_cpu_state();
+	WARN_ON_ONCE(*cpu_emergency_nesting == 0);
 
-	if (cpu_state->prio == NBCON_PRIO_PANIC)
-		__nbcon_atomic_flush_all(true);
+	if (*cpu_emergency_nesting == 1)
+		printk_trigger_flush();
 
-	/*
-	 * Undo the nesting of nbcon_atomic_enter() at the CPU state
-	 * priority.
-	 */
-	cpu_state->nesting[cpu_state->prio]--;
-
-	/*
-	 * Restore the previous priority, which was returned by
-	 * nbcon_atomic_enter().
-	 */
-	cpu_state->prio = prev_prio;
-
-	if (cpu_state->nesting[cpu_state->prio] == 0 &&
-	    prb_read_valid(prb, next_seq, NULL)) {
-		nbcon_wake_threads();
-	}
+	/* Undo the nesting count of nbcon_cpu_emergency_enter(). */
+	(*cpu_emergency_nesting)--;
 
 	preempt_enable();
 }
 
 /**
- * nbcon_kthread_stop - Stop a printk thread
+ * nbcon_kthread_stop - Stop a printer thread
  * @con:	Console to operate on
  */
 static void nbcon_kthread_stop(struct console *con)
@@ -1441,7 +1454,7 @@ static void nbcon_kthread_stop(struct console *con)
 }
 
 /**
- * nbcon_kthread_create - Create a printk thread
+ * nbcon_kthread_create - Create a printer thread
  * @con:	Console to operate on
  *
  * If it fails, let the console proceed. The atomic part might
@@ -1490,7 +1503,7 @@ static int __init printk_setup_threads(void)
 	printk_threads_enabled = true;
 	for_each_console(con)
 		nbcon_kthread_create(con);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && serialized_printing)
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && printing_via_unlock)
 		nbcon_legacy_kthread_create();
 	console_list_unlock();
 	return 0;
@@ -1591,6 +1604,9 @@ static inline bool uart_is_nbcon(struct uart_port *up)
  *
  * If @up is an nbcon console, this console will be acquired and marked as
  * unsafe. Otherwise this function does nothing.
+ *
+ * nbcon consoles acquired via the port lock wrapper always use priority
+ * NBCON_PRIO_NORMAL.
  */
 void nbcon_handle_port_lock(struct uart_port *up)
 {
@@ -1625,6 +1641,9 @@ EXPORT_SYMBOL_GPL(nbcon_handle_port_lock);
  *
  * If @up is an nbcon console, the console will be marked as safe and
  * released. Otherwise this function does nothing.
+ *
+ * nbcon consoles acquired via the port lock wrapper always use priority
+ * NBCON_PRIO_NORMAL.
  */
 void nbcon_handle_port_unlock(struct uart_port *up)
 {
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8f2b52996568c..cff34b06fabfa 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -349,6 +349,29 @@ static bool panic_in_progress(void)
 	return unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID);
 }
 
+/* Return true if a panic is in progress on the current CPU. */
+bool this_cpu_in_panic(void)
+{
+	/*
+	 * We can use raw_smp_processor_id() here because it is impossible for
+	 * the task to be migrated to the panic_cpu, or away from it. If
+	 * panic_cpu has already been set, and we're not currently executing on
+	 * that CPU, then we never will be.
+	 */
+	return unlikely(atomic_read(&panic_cpu) == raw_smp_processor_id());
+}
+
+/*
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
+ */
+bool other_cpu_in_panic(void)
+{
+	return (panic_in_progress() && !this_cpu_in_panic());
+}
+
 /*
  * This is used for debugging the mess that is the VT code by
  * keeping track if we have the console semaphore held. It's
@@ -441,14 +464,17 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 static DEFINE_MUTEX(syslog_lock);
 
 /*
- * Specifies if a legacy console is registered. See serialized_printing
- * for details.
+ * Specifies if a legacy console is registered. If legacy consoles are
+ * present, it is necessary to perform the console_lock/console_unlock dance
+ * whenever console flushing should occur.
  */
 bool have_legacy_console;
 
 /*
- * Specifies if a boot console is registered. See serialized_printing
- * for details.
+ * Specifies if a boot console is registered. If boot consoles are present,
+ * nbcon consoles cannot print simultaneously and must be synchronized by
+ * the console lock. This is because boot consoles and nbcon consoles may
+ * have mapped the same hardware.
  */
 bool have_boot_console;
 
@@ -1864,10 +1890,23 @@ static bool console_waiter;
  */
 static void console_lock_spinning_enable(void)
 {
+	/*
+	 * Do not use spinning in panic(). The panic CPU wants to keep the lock.
+	 * Non-panic CPUs abandon the flush anyway.
+	 *
+	 * Just keep the lockdep annotation. The panic-CPU should avoid
+	 * taking console_owner_lock because it might cause a deadlock.
+	 * This looks like the easiest way how to prevent false lockdep
+	 * reports without handling races a lockless way.
+	 */
+	if (panic_in_progress())
+		goto lockdep;
+
 	raw_spin_lock(&console_owner_lock);
 	console_owner = current;
 	raw_spin_unlock(&console_owner_lock);
 
+lockdep:
 	/* The waiter may spin on us after setting console_owner */
 	spin_acquire(&console_owner_dep_map, 0, 0, _THIS_IP_);
 }
@@ -1892,6 +1931,22 @@ static int console_lock_spinning_disable_and_check(int cookie)
 {
 	int waiter;
 
+	/*
+	 * Ignore spinning waiters during panic() because they might get stopped
+	 * or blocked at any time,
+	 *
+	 * It is safe because nobody is allowed to start spinning during panic
+	 * in the first place. If there has been a waiter then non panic CPUs
+	 * might stay spinning. They would get stopped anyway. The panic context
+	 * will never start spinning and an interrupted spin on panic CPU will
+	 * never continue.
+	 */
+	if (panic_in_progress()) {
+		/* Keep lockdep happy. */
+		spin_release(&console_owner_dep_map, _THIS_IP_);
+		return 0;
+	}
+
 	raw_spin_lock(&console_owner_lock);
 	waiter = READ_ONCE(console_waiter);
 	console_owner = NULL;
@@ -2281,30 +2336,71 @@ asmlinkage int vprintk_emit(int facility, int level,
 			    const struct dev_printk_info *dev_info,
 			    const char *fmt, va_list args)
 {
-	bool print_direct = serialized_printing && !IS_ENABLED(CONFIG_PREEMPT_RT);
+	static atomic_t panic_noise_count = ATOMIC_INIT(0);
+
+	bool do_trylock_unlock = printing_via_unlock && !IS_ENABLED(CONFIG_PREEMPT_RT);
 	int printed_len;
 
 	/* Suppress unimportant messages after panic happens */
 	if (unlikely(suppress_printk))
 		return 0;
 
-	if (unlikely(suppress_panic_printk) &&
-	    atomic_read(&panic_cpu) != raw_smp_processor_id())
-		return 0;
+	if (other_cpu_in_panic()) {
+		if (unlikely(suppress_panic_printk))
+			return 0;
+
+		/*
+		 * The messages on the panic CPU are the most important. If
+		 * non-panic CPUs are generating many messages, the panic
+		 * messages could get lost. Limit the number of non-panic
+		 * messages to approximately 1/4 of the ringbuffer.
+		 */
+		if (atomic_inc_return_relaxed(&panic_noise_count) >
+		    (1 << (prb->desc_ring.count_bits - 2))) {
+			suppress_panic_printk = 1;
+			return 0;
+		}
+	}
 
 	if (level == LOGLEVEL_SCHED) {
 		level = LOGLEVEL_DEFAULT;
 		/* If called from the scheduler, we can not call up(). */
-		print_direct = false;
+		do_trylock_unlock = false;
 	}
 
 	printk_delay(level);
 
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
+	/*
+	 * There are 3 situations where nbcon atomic printing should happen in
+	 * the printk() caller context:
+	 *
+	 * 1. When booting, before the printing threads have been started.
+	 *
+	 * 2. During shutdown, since the printing threads may not get a
+	 *    chance to print the final messages.
+	 *
+	 * 3. When this CPU is in panic.
+	 *
+	 * Note that if boot consoles are registered (have_boot_console), the
+	 * console_lock/console_unlock dance must be relied upon instead
+	 * because nbcon consoles cannot print simultaneously with boot
+	 * consoles.
+	 */
+	if (!have_boot_console) {
+		if (!printk_threads_enabled ||
+		    (system_state > SYSTEM_RUNNING) ||
+		    this_cpu_in_panic()) {
+			preempt_disable();
+			nbcon_atomic_flush_all();
+			preempt_enable();
+		}
+	}
+
 	nbcon_wake_threads();
 
-	if (print_direct) {
+	if (do_trylock_unlock) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2313,16 +2409,20 @@ asmlinkage int vprintk_emit(int facility, int level,
 		 * another printk() caller will take over the printing.
 		 */
 		preempt_disable();
-		/*
-		 * Try to acquire and then immediately release the console
-		 * semaphore. The release will print out buffers. With the
-		 * spinning variant, this context tries to take over the
-		 * printing from another printing context.
-		 */
-		if (console_trylock_spinning())
-			console_unlock();
+		if (nbcon_get_default_prio() != NBCON_PRIO_EMERGENCY) {
+			/*
+			 * Try to acquire and then immediately release the
+			 * console semaphore. The release will print out
+			 * buffers. With the spinning variant, this context
+			 * tries to take over the printing from another
+			 * printing context.
+			 */
+			if (console_trylock_spinning())
+				console_unlock();
+		}
 		preempt_enable();
 
+		wake_up_klogd();
 	} else {
 		defer_console_output();
 	}
@@ -2629,7 +2729,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen && serialized_printing &&
+	if (!cpuhp_tasks_frozen && printing_via_unlock &&
 	    !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
@@ -2638,26 +2738,6 @@ static int console_cpu_notify(unsigned int cpu)
 	return 0;
 }
 
-/*
- * Return true if a panic is in progress on a remote CPU.
- *
- * On true, the local CPU should immediately release any printing resources
- * that may be needed by the panic CPU.
- */
-bool other_cpu_in_panic(void)
-{
-	if (!panic_in_progress())
-		return false;
-
-	/*
-	 * We can use raw_smp_processor_id() here because it is impossible for
-	 * the task to be migrated to the panic_cpu, or away from it. If
-	 * panic_cpu has already been set, and we're not currently executing on
-	 * that CPU, then we never will be.
-	 */
-	return atomic_read(&panic_cpu) != raw_smp_processor_id();
-}
-
 /**
  * console_lock - block the console subsystem from printing
  *
@@ -2783,8 +2863,6 @@ void console_prepend_dropped(struct printk_message *pmsg, unsigned long dropped)
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_suppress)
 {
-	static int panic_console_dropped;
-
 	struct printk_buffers *pbufs = pmsg->pbufs;
 	const size_t scratchbuf_sz = sizeof(pbufs->scratchbuf);
 	const size_t outbuf_sz = sizeof(pbufs->outbuf);
@@ -2812,17 +2890,6 @@ bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 	pmsg->seq = r.info->seq;
 	pmsg->dropped = r.info->seq - seq;
 
-	/*
-	 * Check for dropped messages in panic here so that printk
-	 * suppression can occur as early as possible if necessary.
-	 */
-	if (pmsg->dropped &&
-	    panic_in_progress() &&
-	    panic_console_dropped++ > 10) {
-		suppress_panic_printk = 1;
-		pr_warn_once("Too many dropped messages. Suppress messages on non-panic CPUs to prevent livelock.\n");
-	}
-
 	/* Skip record that has level above the console loglevel. */
 	if (may_suppress && suppress_message_printing(r.info->level))
 		goto out;
@@ -2988,7 +3055,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_usable = true;
 
 			if (flags & CON_NBCON) {
-				progress = nbcon_console_emit_next_record(con);
+				progress = nbcon_atomic_emit_next_record(con);
 				printk_seq = nbcon_seq_read(con);
 			} else {
 				progress = console_emit_next_record(con, handover, cookie);
@@ -3233,9 +3300,10 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
-	nbcon_atomic_flush_all();
+	if (!have_boot_console)
+		nbcon_atomic_flush_all();
 
-	if (serialized_printing)
+	if (printing_via_unlock)
 		console_flush_all(false, &next_seq, &handover);
 }
 
@@ -3329,16 +3397,29 @@ static bool printer_should_wake(u64 seq)
 	cookie = console_srcu_read_lock();
 	for_each_console_srcu(con) {
 		short flags = console_srcu_read_flags(con);
+		u64 printk_seq;
 
-		if (flags & CON_NBCON)
+		/*
+		 * The legacy printer thread is only for legacy consoles,
+		 * unless the nbcon console has no kthread printer.
+		 */
+		if ((flags & CON_NBCON) && con->kthread)
 			continue;
+
 		if (!console_is_usable(con, flags, true))
 			continue;
-		/*
-		 * It is safe to read @seq because only this
-		 * thread context updates @seq.
-		 */
-		if (prb_read_valid(prb, con->seq, NULL)) {
+
+		if (flags & CON_NBCON) {
+			printk_seq = nbcon_seq_read(con);
+		} else {
+			/*
+			 * It is safe to read @seq because only this
+			 * thread context updates @seq.
+			 */
+			printk_seq = con->seq;
+		}
+
+		if (prb_read_valid(prb, printk_seq, NULL)) {
 			available = true;
 			break;
 		}
@@ -3761,12 +3842,12 @@ static int unregister_console_locked(struct console *console)
 		res = console->exit(console);
 
 	/*
-	 * If the current console was a boot and/or legacy console, the
+	 * If this console was a boot and/or legacy console, the
 	 * related global flags might need to be updated.
 	 */
 	if (is_boot_con || is_legacy_con) {
-		bool found_boot_con = false;
 		bool found_legacy_con = false;
+		bool found_boot_con = false;
 
 		for_each_console(c) {
 			if (c->flags & CON_BOOT)
@@ -3790,7 +3871,7 @@ static int unregister_console_locked(struct console *console)
 	}
 
 #ifdef CONFIG_PRINTK
-	if (!serialized_printing && nbcon_legacy_kthread) {
+	if (!printing_via_unlock && nbcon_legacy_kthread) {
 		kthread_stop(nbcon_legacy_kthread);
 		nbcon_legacy_kthread = NULL;
 	}
@@ -3940,7 +4021,8 @@ late_initcall(printk_late_init);
 /* If @con is specified, only wait for that console. Otherwise wait for all. */
 static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progress)
 {
-	int remaining = timeout_ms;
+	unsigned long timeout_jiffies = msecs_to_jiffies(timeout_ms);
+	unsigned long remaining_jiffies = timeout_jiffies;
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
@@ -3952,23 +4034,26 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 	might_sleep();
 
-	seq = prb_next_seq(prb);
+	seq = prb_next_reserve_seq(prb);
 
 	/*
 	 * Flush the consoles so that records up to @seq are printed.
 	 * Otherwise this function will just wait for the threaded printers
 	 * to print up to @seq.
 	 */
-	if (serialized_printing && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
+	if (printing_via_unlock && !IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		console_lock();
 		console_unlock();
 	}
 
 	for (;;) {
+		unsigned long begin_jiffies;
+		unsigned long slept_jiffies;
+
 		locked = false;
 		diff = 0;
 
-		if (serialized_printing) {
+		if (printing_via_unlock) {
 			/*
 			 * Hold the console_lock to guarantee safe access to
 			 * console->seq. Releasing console_lock flushes more
@@ -4009,20 +4094,21 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		console_srcu_read_unlock(cookie);
 
 		if (diff != last_diff && reset_on_progress)
-			remaining = timeout_ms;
+			remaining_jiffies = timeout_jiffies;
 
 		if (locked)
 			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
-		if (diff == 0 || remaining == 0)
+		if (diff == 0 || remaining_jiffies == 0)
 			break;
 
+		/* msleep(1) might sleep much longer. Check time by jiffies. */
+		begin_jiffies = jiffies;
 		msleep(1);
+		slept_jiffies = jiffies - begin_jiffies;
 
-		/* If @remaining < 0, there is no timeout limit. */
-		if (remaining > 0)
-			remaining--;
+		remaining_jiffies -= min(slept_jiffies, remaining_jiffies);
 
 		last_diff = diff;
 	}
@@ -4142,16 +4228,26 @@ void defer_console_output(void)
 	 */
 	int val = PRINTK_PENDING_WAKEUP;
 
-	if (serialized_printing)
+	if (printing_via_unlock)
 		val |= PRINTK_PENDING_OUTPUT;
 	__wake_up_klogd(val);
 }
 
+/**
+ * printk_trigger_flush() - Make sure that the consoles will get flushed
+ *
+ * Try to flush consoles when possible or queue flushing consoles like
+ * in the deferred printk.
+ *
+ * Context: Can be used in any context
+ */
 void printk_trigger_flush(void)
 {
-	preempt_disable();
-	nbcon_atomic_flush_all();
-	preempt_enable();
+	if (!have_boot_console) {
+		preempt_disable();
+		nbcon_atomic_flush_all();
+		preempt_enable();
+	}
 
 	nbcon_wake_threads();
 	defer_console_output();
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index fde338606ce83..a949d02fbd174 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/bug.h>
 #include "printk_ringbuffer.h"
+#include "internal.h"
 
 /**
  * DOC: printk_ringbuffer overview
@@ -303,6 +304,9 @@
  *
  *   desc_push_tail:B / desc_reserve:D
  *     set descriptor reusable (state), then push descriptor tail (id)
+ *
+ *   desc_update_last_finalized:A / desc_last_finalized_seq:A
+ *     store finalized record, then set new highest finalized sequence number
  */
 
 #define DATA_SIZE(data_ring)		_DATA_SIZE((data_ring)->size_bits)
@@ -1030,9 +1034,13 @@ static char *data_alloc(struct printk_ringbuffer *rb, unsigned int size,
 	unsigned long next_lpos;
 
 	if (size == 0) {
-		/* Specify a data-less block. */
-		blk_lpos->begin = NO_LPOS;
-		blk_lpos->next = NO_LPOS;
+		/*
+		 * Data blocks are not created for empty lines. Instead, the
+		 * reader will recognize these special lpos values and handle
+		 * it appropriately.
+		 */
+		blk_lpos->begin = EMPTY_LINE_LPOS;
+		blk_lpos->next = EMPTY_LINE_LPOS;
 		return NULL;
 	}
 
@@ -1210,10 +1218,18 @@ static const char *get_data(struct prb_data_ring *data_ring,
 
 	/* Data-less data block description. */
 	if (BLK_DATALESS(blk_lpos)) {
-		if (blk_lpos->begin == NO_LPOS && blk_lpos->next == NO_LPOS) {
+		/*
+		 * Records that are just empty lines are also valid, even
+		 * though they do not have a data block. For such records
+		 * explicitly return empty string data to signify success.
+		 */
+		if (blk_lpos->begin == EMPTY_LINE_LPOS &&
+		    blk_lpos->next == EMPTY_LINE_LPOS) {
 			*data_size = 0;
 			return "";
 		}
+
+		/* Data lost, invalid, or otherwise unavailable. */
 		return NULL;
 	}
 
@@ -1441,20 +1457,144 @@ bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer
 	return false;
 }
 
+#ifdef CONFIG_64BIT
+
+#define __u64seq_to_ulseq(u64seq) (u64seq)
+#define __ulseq_to_u64seq(ulseq) (ulseq)
+
+#else /* CONFIG_64BIT */
+
+static u64 prb_first_seq(struct printk_ringbuffer *rb);
+
+#define __u64seq_to_ulseq(u64seq) ((u32)u64seq)
+static inline u64 __ulseq_to_u64seq(u32 ulseq)
+{
+	u64 rb_first_seq = prb_first_seq(prb);
+	u64 seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the first sequence
+	 * number from the ringbuffer and fold it.
+	 */
+	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
+
+	return seq;
+}
+
+#endif /* CONFIG_64BIT */
+
+/*
+ * @last_finalized_seq value guarantees that all records up to and including
+ * this sequence number are finalized and can be read. The only exception are
+ * too old records which have already been overwritten.
+ *
+ * It is also guaranteed that @last_finalized_seq only increases.
+ *
+ * Be aware that finalized records following non-finalized records are not
+ * reported because they are not yet available to the reader. For example,
+ * a new record stored via printk() will not be available to a printer if
+ * it follows a record that has not been finalized yet. However, once that
+ * non-finalized record becomes finalized, @last_finalized_seq will be
+ * appropriately updated and the full set of finalized records will be
+ * available to the printer. And since each printk() caller will either
+ * directly print or trigger deferred printing of all available unprinted
+ * records, all printk() messages will get printed.
+ */
+static u64 desc_last_finalized_seq(struct prb_desc_ring *desc_ring)
+{
+	unsigned long ulseq;
+
+	/*
+	 * Guarantee the sequence number is loaded before loading the
+	 * associated record in order to guarantee that the record can be
+	 * seen by this CPU. This pairs with desc_update_last_finalized:A.
+	 */
+	ulseq = atomic_long_read_acquire(&desc_ring->last_finalized_seq
+					); /* LMM(desc_last_finalized_seq:A) */
+
+	return __ulseq_to_u64seq(ulseq);
+}
+
+static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
+			    struct printk_record *r, unsigned int *line_count);
+
+/*
+ * Check if there are records directly following @last_finalized_seq that are
+ * finalized. If so, update @last_finalized_seq to the latest of these
+ * records. It is not allowed to skip over records that are not yet finalized.
+ */
+static void desc_update_last_finalized(struct printk_ringbuffer *rb)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	u64 old_seq = desc_last_finalized_seq(desc_ring);
+	unsigned long oldval;
+	unsigned long newval;
+	u64 finalized_seq;
+	u64 try_seq;
+
+try_again:
+	finalized_seq = old_seq;
+	try_seq = finalized_seq + 1;
+
+	/* Try to find later finalized records. */
+	while (_prb_read_valid(rb, &try_seq, NULL, NULL)) {
+		finalized_seq = try_seq;
+		try_seq++;
+	}
+
+	/* No update needed if no later finalized record was found. */
+	if (finalized_seq == old_seq)
+		return;
+
+	oldval = __u64seq_to_ulseq(old_seq);
+	newval = __u64seq_to_ulseq(finalized_seq);
+
+	/*
+	 * Set the sequence number of a later finalized record that has been
+	 * seen.
+	 *
+	 * Guarantee the record data is visible to other CPUs before storing
+	 * its sequence number. This pairs with desc_last_finalized_seq:A.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If desc_last_finalized_seq:A reads from
+	 * desc_update_last_finalized:A, then desc_read:A reads from
+	 * _prb_commit:B.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from _prb_commit:B to desc_update_last_finalized:A
+	 *    matching
+	 * ACQUIRE from desc_last_finalized_seq:A to desc_read:A
+	 *
+	 * Note: _prb_commit:B and desc_update_last_finalized:A can be
+	 *       different CPUs. However, the desc_update_last_finalized:A
+	 *       CPU (which performs the release) must have previously seen
+	 *       _prb_commit:B.
+	 */
+	if (!atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq,
+				&oldval, newval)) { /* LMM(desc_update_last_finalized:A) */
+		old_seq = __ulseq_to_u64seq(oldval);
+		goto try_again;
+	}
+}
+
 /*
  * Attempt to finalize a specified descriptor. If this fails, the descriptor
  * is either already final or it will finalize itself when the writer commits.
  */
-static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
+static void desc_make_final(struct printk_ringbuffer *rb, unsigned long id)
 {
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
 	unsigned long prev_state_val = DESC_SV(id, desc_committed);
 	struct prb_desc *d = to_desc(desc_ring, id);
 
-	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
-			DESC_SV(id, desc_finalized)); /* LMM(desc_make_final:A) */
-
-	/* Best effort to remember the last finalized @id. */
-	atomic_long_set(&desc_ring->last_finalized_id, id);
+	if (atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
+			DESC_SV(id, desc_finalized))) { /* LMM(desc_make_final:A) */
+		desc_update_last_finalized(rb);
+	}
 }
 
 /**
@@ -1550,7 +1690,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	 * readers. (For seq==0 there is no previous descriptor.)
 	 */
 	if (info->seq > 0)
-		desc_make_final(desc_ring, DESC_ID(id - 1));
+		desc_make_final(rb, DESC_ID(id - 1));
 
 	r->text_buf = data_alloc(rb, r->text_buf_size, &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
@@ -1643,7 +1783,7 @@ void prb_commit(struct prb_reserved_entry *e)
 	 */
 	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_commit:A) */
 	if (head_id != e->id)
-		desc_make_final(desc_ring, e->id);
+		desc_make_final(e->rb, e->id);
 }
 
 /**
@@ -1663,12 +1803,9 @@ void prb_commit(struct prb_reserved_entry *e)
  */
 void prb_final_commit(struct prb_reserved_entry *e)
 {
-	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
-
 	_prb_commit(e, desc_finalized);
 
-	/* Best effort to remember the last finalized @id. */
-	atomic_long_set(&desc_ring->last_finalized_id, e->id);
+	desc_update_last_finalized(e->rb);
 }
 
 /*
@@ -1875,12 +2012,114 @@ static u64 prb_first_seq(struct printk_ringbuffer *rb)
 	return seq;
 }
 
-/*
- * Non-blocking read of a record. Updates @seq to the last finalized record
- * (which may have no data available).
+/**
+ * prb_next_reserve_seq() - Get the sequence number after the most recently
+ *                  reserved record.
  *
- * See the description of prb_read_valid() and prb_read_valid_info()
- * for details.
+ * @rb:  The ringbuffer to get the sequence number from.
+ *
+ * This is the public function available to readers to see what sequence
+ * number will be assigned to the next reserved record.
+ *
+ * Note that depending on the situation, this value can be equal to or
+ * higher than the sequence number returned by prb_next_seq().
+ *
+ * Context: Any context.
+ * Return: The sequence number that will be assigned to the next record
+ *         reserved.
+ */
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb)
+{
+	struct prb_desc_ring *desc_ring = &rb->desc_ring;
+	unsigned long last_finalized_id;
+	atomic_long_t *state_var;
+	u64 last_finalized_seq;
+	unsigned long head_id;
+	struct prb_desc desc;
+	unsigned long diff;
+	struct prb_desc *d;
+	int err;
+
+	/*
+	 * It may not be possible to read a sequence number for @head_id.
+	 * So the ID of @last_finailzed_seq is used to calculate what the
+	 * sequence number of @head_id will be.
+	 */
+
+try_again:
+	last_finalized_seq = desc_last_finalized_seq(desc_ring);
+
+	/*
+	 * @head_id is loaded after @last_finalized_seq to ensure that it is
+	 * at or beyond @last_finalized_seq.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If desc_last_finalized_seq:A reads from
+	 * desc_update_last_finalized:A, then
+	 * prb_next_reserve_seq:A reads from desc_reserve:D.
+	 *
+	 * Relies on:
+	 *
+	 * RELEASE from desc_reserve:D to desc_update_last_finalized:A
+	 *    matching
+	 * ACQUIRE from desc_last_finalized_seq:A to prb_next_reserve_seq:A
+	 *
+	 * Note: desc_reserve:D and desc_update_last_finalized:A can be
+	 *       different CPUs. However, the desc_update_last_finalized:A CPU
+	 *       (which performs the release) must have previously seen
+	 *       desc_read:C, which implies desc_reserve:D can be seen.
+	 */
+	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_next_reserve_seq:A) */
+
+	d = to_desc(desc_ring, last_finalized_seq);
+	state_var = &d->state_var;
+
+	/* Extract the ID, used to specify the descriptor to read. */
+	last_finalized_id = DESC_ID(atomic_long_read(state_var));
+
+	/* Ensure @last_finalized_id is correct. */
+	err = desc_read_finalized_seq(desc_ring, last_finalized_id, last_finalized_seq, &desc);
+
+	if (err == -EINVAL) {
+		if (last_finalized_seq == 0) {
+			/*
+			 * @last_finalized_seq still contains its initial
+			 * value. Probably no record has been finalized yet.
+			 * This means the ringbuffer is not yet full and the
+			 * @head_id value can be used directly (subtracting
+			 * off its initial value).
+			 *
+			 * Because of hack#2 of the bootstrapping phase, the
+			 * @head_id initial value must be handled separately.
+			 */
+			if (head_id == DESC0_ID(desc_ring->count_bits))
+				return 0;
+
+			last_finalized_id = DESC0_ID(desc_ring->count_bits) + 1;
+		} else {
+			/* Record must have been overwritten. Try again. */
+			goto try_again;
+		}
+	}
+
+	diff = head_id - last_finalized_id;
+
+	return (last_finalized_seq + diff + 1);
+}
+
+/*
+ * Non-blocking read of a record.
+ *
+ * On success @seq is updated to the record that was read and (if provided)
+ * @r and @line_count will contain the read/calculated data.
+ *
+ * On failure @seq is updated to a record that is not yet available to the
+ * reader, but it will be the next record available to the reader.
+ *
+ * Note: When the current CPU is in panic, this function will skip over any
+ *       non-existent/non-finalized records in order to allow the panic CPU
+ *       to print any and all records that have been finalized.
  */
 static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			    struct printk_record *r, unsigned int *line_count)
@@ -1899,12 +2138,26 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
 			*seq = tail_seq;
 
 		} else if (err == -ENOENT) {
-			/* Record exists, but no data available. Skip. */
+			/* Record exists, but the data was lost. Skip. */
 			(*seq)++;
 
 		} else {
-			/* Non-existent/non-finalized record. Must stop. */
-			return false;
+			/*
+			 * Non-existent/non-finalized record. Must stop.
+			 *
+			 * For panic situations it cannot be expected that
+			 * non-finalized records will become finalized. But
+			 * there may be other finalized records beyond that
+			 * need to be printed for a panic situation. If this
+			 * is the panic CPU, skip this
+			 * non-existent/non-finalized record unless it is
+			 * at or beyond the head, in which case it is not
+			 * possible to continue.
+			 */
+			if (this_cpu_in_panic() && ((*seq + 1) < prb_next_reserve_seq(rb)))
+				(*seq)++;
+			else
+				return false;
 		}
 	}
 
@@ -1932,7 +2185,7 @@ static bool _prb_read_valid(struct printk_ringbuffer *rb, u64 *seq,
  * On success, the reader must check r->info.seq to see which record was
  * actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
 		    struct printk_record *r)
@@ -1962,7 +2215,7 @@ bool prb_read_valid(struct printk_ringbuffer *rb, u64 seq,
  * On success, the reader must check info->seq to see which record meta data
  * was actually read. This allows the reader to detect dropped records.
  *
- * Failure means @seq refers to a not yet written record.
+ * Failure means @seq refers to a record not yet available to the reader.
  */
 bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 			 struct printk_info *info, unsigned int *line_count)
@@ -2008,7 +2261,9 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
  * newest sequence number available to readers will be.
  *
  * This provides readers a sequence number to jump to if all currently
- * available records should be skipped.
+ * available records should be skipped. It is guaranteed that all records
+ * previous to the returned value have been finalized and are (or were)
+ * available to the reader.
  *
  * Context: Any context.
  * Return: The sequence number of the next newest (not yet available) record
@@ -2017,33 +2272,19 @@ u64 prb_first_valid_seq(struct printk_ringbuffer *rb)
 u64 prb_next_seq(struct printk_ringbuffer *rb)
 {
 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
-	enum desc_state d_state;
-	unsigned long id;
 	u64 seq;
 
-	/* Check if the cached @id still points to a valid @seq. */
-	id = atomic_long_read(&desc_ring->last_finalized_id);
-	d_state = desc_read(desc_ring, id, NULL, &seq, NULL);
+	seq = desc_last_finalized_seq(desc_ring);
 
-	if (d_state == desc_finalized || d_state == desc_reusable) {
-		/*
-		 * Begin searching after the last finalized record.
-		 *
-		 * On 0, the search must begin at 0 because of hack#2
-		 * of the bootstrapping phase it is not known if a
-		 * record at index 0 exists.
-		 */
-		if (seq != 0)
-			seq++;
-	} else {
-		/*
-		 * The information about the last finalized sequence number
-		 * has gone. It should happen only when there is a flood of
-		 * new messages and the ringbuffer is rapidly recycled.
-		 * Give up and start from the beginning.
-		 */
-		seq = 0;
-	}
+	/*
+	 * Begin searching after the last finalized record.
+	 *
+	 * On 0, the search must begin at 0 because of hack#2
+	 * of the bootstrapping phase it is not known if a
+	 * record at index 0 exists.
+	 */
+	if (seq != 0)
+		seq++;
 
 	/*
 	 * The information about the last finalized @seq might be inaccurate.
@@ -2085,7 +2326,7 @@ void prb_init(struct printk_ringbuffer *rb,
 	rb->desc_ring.infos = infos;
 	atomic_long_set(&rb->desc_ring.head_id, DESC0_ID(descbits));
 	atomic_long_set(&rb->desc_ring.tail_id, DESC0_ID(descbits));
-	atomic_long_set(&rb->desc_ring.last_finalized_id, DESC0_ID(descbits));
+	atomic_long_set(&rb->desc_ring.last_finalized_seq, 0);
 
 	rb->text_data_ring.size_bits = textbits;
 	rb->text_data_ring.data = text_buf;
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 18cd25e489b89..b48b44ecbe6da 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -75,7 +75,7 @@ struct prb_desc_ring {
 	struct printk_info	*infos;
 	atomic_long_t		head_id;
 	atomic_long_t		tail_id;
-	atomic_long_t		last_finalized_id;
+	atomic_long_t		last_finalized_seq;
 };
 
 /*
@@ -127,8 +127,22 @@ enum desc_state {
 #define DESC_SV(id, state)	(((unsigned long)state << DESC_FLAGS_SHIFT) | id)
 #define DESC_ID_MASK		(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)		((sv) & DESC_ID_MASK)
+
+/*
+ * Special data block logical position values (for fields of
+ * @prb_desc.text_blk_lpos).
+ *
+ * - Bit0 is used to identify if the record has no data block. (Implemented in
+ *   the LPOS_DATALESS() macro.)
+ *
+ * - Bit1 specifies the reason for not having a data block.
+ *
+ * These special values could never be real lpos values because of the
+ * meta data and alignment padding of data blocks. (See to_blk_size() for
+ * details.)
+ */
 #define FAILED_LPOS		0x1
-#define NO_LPOS			0x3
+#define EMPTY_LINE_LPOS		0x3
 
 #define FAILED_BLK_LPOS	\
 {				\
@@ -259,7 +273,7 @@ static struct printk_ringbuffer name = {							\
 		.infos		= &_##name##_infos[0],						\
 		.head_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
 		.tail_id	= ATOMIC_INIT(DESC0_ID(descbits)),				\
-		.last_finalized_id = ATOMIC_INIT(DESC0_ID(descbits)),				\
+		.last_finalized_seq = ATOMIC_INIT(0),						\
 	},											\
 	.text_data_ring = {									\
 		.size_bits	= (avgtextbits) + (descbits),					\
@@ -380,5 +394,6 @@ bool prb_read_valid_info(struct printk_ringbuffer *rb, u64 seq,
 
 u64 prb_first_valid_seq(struct printk_ringbuffer *rb);
 u64 prb_next_seq(struct printk_ringbuffer *rb);
+u64 prb_next_reserve_seq(struct printk_ringbuffer *rb);
 
 #endif /* _KERNEL_PRINTK_RINGBUFFER_H */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 0a58f8b233d88..ddd4005ce57ab 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -583,7 +583,6 @@ static void rcu_check_gp_kthread_expired_fqs_timer(void)
 
 static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
-	enum nbcon_prio prev_prio;
 	int cpu;
 	unsigned long flags;
 	unsigned long gpa;
@@ -599,7 +598,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 	if (rcu_stall_is_suppressed())
 		return;
 
-	prev_prio = nbcon_atomic_enter(NBCON_PRIO_EMERGENCY);
+	nbcon_cpu_emergency_enter();
 
 	/*
 	 * OK, time to rat on our buddy...
@@ -656,7 +655,7 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 
 	rcu_force_quiescent_state();  /* Kick them all. */
 
-	nbcon_atomic_exit(NBCON_PRIO_EMERGENCY, prev_prio);
+	nbcon_cpu_emergency_exit();
 }
 
 static void print_cpu_stall(unsigned long gps)
diff --git a/localversion-rt b/localversion-rt
index 6e44e540b927b..9f7d0bdbffb18 100644
--- a/localversion-rt
+++ b/localversion-rt
@@ -1 +1 @@
--rt12
+-rt13
