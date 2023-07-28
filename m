Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11743766077
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjG1ACz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbjG1ACn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85B530FF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1xKGpW2D3rUybleKwKmWrTn8UA1EZe2/GxNjEoe5rU=;
        b=LrbaGHeULndIM49PvMkxcA3aQEuZNE32au8Q4SIbnc3w7FlAkv0aTqzPV+ytJzhFy5E9Zo
        LEf9d5kC+QMV7NLMxi+pgRCVmyHKe+A6znNzNw++OLHlFiR4DHSNMXD6/SUacygfQmS+pX
        GgNdSl4W90SWr4d46wuBfB4AKsiAoJfn/BSkyoq/XC/0WJNZh497Gjwm3JxX70UcLlawXz
        Zv2QxsDXSh0Wn1n/kkarDBWqaMZc6WYHC31VrBJaoU1Bi7ajfd8TyemcQxXWY+TEqlAiCq
        NEl5uCCkhZxW1OIHGQWNpJa3noich4sFxAEhgmZjmg2WKXPHYvHDh/EN32Q2pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502556;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c1xKGpW2D3rUybleKwKmWrTn8UA1EZe2/GxNjEoe5rU=;
        b=6P4thcNewSQwvuy8MKkSsZTyY12+vYnGWqzgzN+YkpVsVOPS+UOQ8GqpTHNQcEYqNIAws+
        TEg8ABQzzSBkHtAw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic infrastructure
Date:   Fri, 28 Jul 2023 02:08:26 +0206
Message-Id: <20230728000233.50887-2-john.ogness@linutronix.de>
In-Reply-To: <20230728000233.50887-1-john.ogness@linutronix.de>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The current console/printk subsystem is protected by a Big Kernel Lock,
(aka console_lock) which has ill defined semantics and is more or less
stateless. This puts severe limitations on the console subsystem and
makes forced takeover and output in emergency and panic situations a
fragile endeavour that is based on try and pray.

The goal of non-BKL (nbcon) consoles is to break out of the console lock
jail and to provide a new infrastructure that avoids the pitfalls and
allows console drivers to be gradually converted over.

The proposed infrastructure aims for the following properties:

  - Per console locking instead of global locking
  - Per console state that allows to make informed decisions
  - Stateful handover and takeover

As a first step, state is added to struct console. The per console state
is an atomic_t using a 32bit bit field.

Reserve state bits, which will be populated later in the series. Wire
it up into the console register/unregister functionality and exclude
such consoles from being handled in the legacy console mechanisms. Since
the nbcon consoles will not depend on the console lock/unlock dance
for printing, only perform said dance if a legacy console is registered.

The decision to use a bitfield was made as using a plain u32 with
mask/shift operations turned out to result in uncomprehensible code.

Note that nbcon consoles are not able to print simultaneously with boot
consoles because it is not possible to know if they are using the same
hardware. For this reason, nbcon consoles are handled as legacy consoles
as long as a boot console is registered.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |  31 ++++++++++
 kernel/printk/Makefile       |   2 +-
 kernel/printk/internal.h     |  11 ++++
 kernel/printk/printk.c       | 112 +++++++++++++++++++++++++++++++----
 kernel/printk/printk_nbcon.c |  74 +++++++++++++++++++++++
 5 files changed, 216 insertions(+), 14 deletions(-)
 create mode 100644 kernel/printk/printk_nbcon.c

diff --git a/include/linux/console.h b/include/linux/console.h
index 7de11c763eb3..c99265d82b98 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -156,6 +156,8 @@ static inline int con_debug_leave(void)
  *			/dev/kmesg which requires a larger output buffer.
  * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
  *			printing callbacks must not be called.
+ * @CON_NBCON:		Console can operate outside of the legacy style console_lock
+ *			constraints.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -166,8 +168,32 @@ enum cons_flags {
 	CON_BRL			= BIT(5),
 	CON_EXTENDED		= BIT(6),
 	CON_SUSPENDED		= BIT(7),
+	CON_NBCON		= BIT(8),
 };
 
+/**
+ * struct nbcon_state - console state for nbcon consoles
+ * @atom:	Compound of the state fields for atomic operations
+ *
+ * To be used for reading and preparing of the value stored in the nbcon
+ * state variable @console.nbcon_state.
+ */
+struct nbcon_state {
+	union {
+		unsigned int	atom;
+		struct {
+		};
+	};
+};
+
+/*
+ * The nbcon_state struct is used to easily create and interpret values that
+ * are stored in the console.nbcon_state variable. Make sure this struct stays
+ * within the size boundaries of that atomic variable's underlying type in
+ * order to avoid any accidental truncation.
+ */
+static_assert(sizeof(struct nbcon_state) <= sizeof(int));
+
 /**
  * struct console - The console descriptor structure
  * @name:		The name of the console driver
@@ -187,6 +213,8 @@ enum cons_flags {
  * @dropped:		Number of unreported dropped ringbuffer records
  * @data:		Driver private data
  * @node:		hlist node for the console list
+ *
+ * @nbcon_state:	State for nbcon consoles
  */
 struct console {
 	char			name[16];
@@ -206,6 +234,9 @@ struct console {
 	unsigned long		dropped;
 	void			*data;
 	struct hlist_node	node;
+
+	/* nbcon console specific members */
+	atomic_t		__private nbcon_state;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/Makefile b/kernel/printk/Makefile
index f5b388e810b9..552525edf562 100644
--- a/kernel/printk/Makefile
+++ b/kernel/printk/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y	= printk.o
-obj-$(CONFIG_PRINTK)	+= printk_safe.o
+obj-$(CONFIG_PRINTK)	+= printk_safe.o printk_nbcon.o
 obj-$(CONFIG_A11Y_BRAILLE_CONSOLE)	+= braille.o
 obj-$(CONFIG_PRINTK_INDEX)	+= index.o
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7d4979d5c3ce..655810f2976e 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -3,6 +3,7 @@
  * internal.h - printk internal definitions
  */
 #include <linux/percpu.h>
+#include <linux/console.h>
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -35,6 +36,9 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+extern bool have_legacy_console;
+extern bool have_boot_console;
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -61,6 +65,10 @@ void defer_console_output(void);
 
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
+
+bool nbcon_init(struct console *con);
+void nbcon_cleanup(struct console *con);
+
 #else
 
 #define PRINTK_PREFIX_MAX	0
@@ -76,6 +84,9 @@ u16 printk_parse_prefix(const char *text, int *level,
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline bool nbcon_init(struct console *con) { return true; }
+static inline void nbcon_cleanup(struct console *con) { }
+
 #endif /* CONFIG_PRINTK */
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 8787d3a72114..98b4854c81ea 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -442,6 +442,26 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
 /* syslog_lock protects syslog_* variables and write access to clear_seq. */
 static DEFINE_MUTEX(syslog_lock);
 
+/*
+ * Specifies if a legacy console is registered. See serialized_printing
+ * for details.
+ */
+bool have_legacy_console;
+
+/*
+ * Specifies if a boot console is registered. See serialized_printing
+ * for details.
+ */
+bool have_boot_console;
+
+/*
+ * Specifies if the console lock/unlock dance is needed for console
+ * printing. If @have_boot_console is true, the nbcon consoles will
+ * be printed serially along with the legacy consoles because nbcon
+ * consoles cannot print simultaneously with boot consoles.
+ */
+#define serialized_printing (have_legacy_console || have_boot_console)
+
 #ifdef CONFIG_PRINTK
 DECLARE_WAIT_QUEUE_HEAD(log_wait);
 /* All 3 protected by @syslog_lock. */
@@ -2286,7 +2306,7 @@ asmlinkage int vprintk_emit(int facility, int level,
 	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
 
 	/* If called from the scheduler, we can not call up(). */
-	if (!in_sched) {
+	if (!in_sched && serialized_printing) {
 		/*
 		 * The caller may be holding system-critical or
 		 * timing-sensitive locks. Disable preemption during
@@ -2603,7 +2623,7 @@ void resume_console(void)
  */
 static int console_cpu_notify(unsigned int cpu)
 {
-	if (!cpuhp_tasks_frozen) {
+	if (!cpuhp_tasks_frozen && serialized_printing) {
 		/* If trylock fails, someone else is doing the printing */
 		if (console_trylock())
 			console_unlock();
@@ -2955,8 +2975,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(con) {
+			short flags = console_srcu_read_flags(con);
 			bool progress;
 
+			/*
+			 * console_flush_all() is only for legacy consoles,
+			 * unless a boot console is registered. See
+			 * serialized_printing for details.
+			 */
+			if ((flags & CON_NBCON) && !have_boot_console)
+				continue;
+
 			if (!console_is_usable(con))
 				continue;
 			any_usable = true;
@@ -3075,6 +3104,9 @@ void console_unblank(void)
 	struct console *c;
 	int cookie;
 
+	if (!serialized_printing)
+		return;
+
 	/*
 	 * First check if there are any consoles implementing the unblank()
 	 * callback. If not, there is no reason to continue and take the
@@ -3142,6 +3174,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	bool handover;
 	u64 next_seq;
 
+	if (!serialized_printing)
+		return;
+
 	/*
 	 * Ignore the console lock and flush out the messages. Attempting a
 	 * trylock would not be useful because:
@@ -3324,9 +3359,10 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-#define con_printk(lvl, con, fmt, ...)			\
-	printk(lvl pr_fmt("%sconsole [%s%d] " fmt),	\
-	       (con->flags & CON_BOOT) ? "boot" : "",	\
+#define con_printk(lvl, con, fmt, ...)				\
+	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
+	       (con->flags & CON_NBCON) ? "" : "legacy ",	\
+	       (con->flags & CON_BOOT) ? "boot" : "",		\
 	       con->name, con->index, ##__VA_ARGS__)
 
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
@@ -3486,6 +3522,15 @@ void register_console(struct console *newcon)
 	newcon->dropped = 0;
 	console_init_seq(newcon, bootcon_registered);
 
+	if (!(newcon->flags & CON_NBCON)) {
+		have_legacy_console = true;
+	} else if (!nbcon_init(newcon)) {
+		goto unlock;
+	}
+
+	if (newcon->flags & CON_BOOT)
+		have_boot_console = true;
+
 	/*
 	 * Put this console in the list - keep the
 	 * preferred driver at the head of the list.
@@ -3538,6 +3583,9 @@ EXPORT_SYMBOL(register_console);
 /* Must be called under console_list_lock(). */
 static int unregister_console_locked(struct console *console)
 {
+	bool is_legacy_con = !(console->flags & CON_NBCON);
+	bool is_boot_con = (console->flags & CON_BOOT);
+	struct console *c;
 	int res;
 
 	lockdep_assert_console_list_lock_held();
@@ -3577,11 +3625,34 @@ static int unregister_console_locked(struct console *console)
 	 */
 	synchronize_srcu(&console_srcu);
 
+	if (console->flags & CON_NBCON)
+		nbcon_cleanup(console);
+
 	console_sysfs_notify();
 
 	if (console->exit)
 		res = console->exit(console);
 
+	/*
+	 * If the current console was a boot and/or legacy console, the
+	 * related global flags might need to be updated.
+	 */
+	if (is_boot_con || is_legacy_con) {
+		bool found_boot_con = false;
+		bool found_legacy_con = false;
+
+		for_each_console(c) {
+			if (c->flags & CON_BOOT)
+				found_boot_con = true;
+			if (!(c->flags & CON_NBCON))
+				found_legacy_con = true;
+		}
+		if (!found_boot_con)
+			have_boot_console = false;
+		if (!found_legacy_con)
+			have_legacy_console = false;
+	}
+
 	return res;
 }
 
@@ -3730,6 +3801,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	bool locked;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -3739,13 +3811,17 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	seq = prb_next_seq(prb);
 
 	for (;;) {
+		locked = false;
 		diff = 0;
 
-		/*
-		 * Hold the console_lock to guarantee safe access to
-		 * console->seq.
-		 */
-		console_lock();
+		if (serialized_printing) {
+			/*
+			 * Hold the console_lock to guarantee safe access to
+			 * console->seq.
+			 */
+			console_lock();
+			locked = true;
+		}
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
@@ -3758,7 +3834,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 */
 			if (!console_is_usable(c))
 				continue;
-			printk_seq = c->seq;
+
+			if (locked)
+				printk_seq = c->seq;
+			else
+				continue;
+
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
@@ -3767,7 +3848,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		if (diff != last_diff && reset_on_progress)
 			remaining = timeout_ms;
 
-		console_unlock();
+		if (locked)
+			console_unlock();
 
 		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining == 0)
@@ -3893,7 +3975,11 @@ void defer_console_output(void)
 	 * New messages may have been added directly to the ringbuffer
 	 * using vprintk_store(), so wake any waiters as well.
 	 */
-	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
+	int val = PRINTK_PENDING_WAKEUP;
+
+	if (serialized_printing)
+		val |= PRINTK_PENDING_OUTPUT;
+	__wake_up_klogd(val);
 }
 
 void printk_trigger_flush(void)
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
new file mode 100644
index 000000000000..bb379a4f6263
--- /dev/null
+++ b/kernel/printk/printk_nbcon.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH, John Ogness
+// Copyright (C) 2022 Intel, Thomas Gleixner
+
+#include <linux/kernel.h>
+#include <linux/console.h>
+#include "internal.h"
+/*
+ * Printk console printing implementation for consoles that do not depend on
+ * the legacy style console_lock mechanism.
+ */
+
+/**
+ * nbcon_state_set - Helper function to set the console state
+ * @con:	Console to update
+ * @new:	The new state to write
+ *
+ * Only to be used when the console is not yet or no longer visible in the
+ * system. Otherwise use nbcon_state_try_cmpxchg().
+ */
+static inline void nbcon_state_set(struct console *con, struct nbcon_state *new)
+{
+	atomic_set(&ACCESS_PRIVATE(con, nbcon_state), new->atom);
+}
+
+/**
+ * nbcon_state_read - Helper function to read the console state
+ * @con:	Console to read
+ * @state:	The state to store the result
+ */
+static inline void nbcon_state_read(struct console *con, struct nbcon_state *state)
+{
+	state->atom = atomic_read(&ACCESS_PRIVATE(con, nbcon_state));
+}
+
+/**
+ * nbcon_state_try_cmpxchg() - Helper function for atomic_try_cmpxchg() on console state
+ * @con:	Console to update
+ * @cur:	Old/expected state
+ * @new:	New state
+ *
+ * Return: True on success. False on fail and @cur is updated.
+ */
+static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_state *cur,
+					   struct nbcon_state *new)
+{
+	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
+}
+
+/**
+ * nbcon_init - Initialize the nbcon console specific data
+ * @con:	Console to initialize
+ *
+ * Return:	True on success. False otherwise and the console cannot
+ *		be used.
+ */
+bool nbcon_init(struct console *con)
+{
+	struct nbcon_state state = { };
+
+	nbcon_state_set(con, &state);
+	return true;
+}
+
+/**
+ * nbcon_cleanup - Cleanup the nbcon console specific data
+ * @con:	Console to cleanup
+ */
+void nbcon_cleanup(struct console *con)
+{
+	struct nbcon_state state = { };
+
+	nbcon_state_set(con, &state);
+}
-- 
2.39.2

