Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40176607C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjG1ADL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:03:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjG1ACp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F6EDB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2CQPdz/Xds8UFh3BREFGUGoaQ7ARNwZtS9/ALhBvE0=;
        b=yPNvc/AxHIy5mN1vjVRYZp5bhzb1pSPtA5IVb36D7S3EaUkaNoZogU/rbJFPTTWpTUluBs
        qjtOLZ+ZxNGrGSLLwkFeV/ILdpKFCjaoF1w5/XmOLJE00vWX0kI0qVrSR38OkCIz/WriwI
        L3jLs1O5ndIYlQIRrunOYeFz+ckm0dz+XuKrV+DUH4V1ybl1raWeodrD0sM4a32VViL792
        0qMkynegjZMYlMNZtIyEL7e8lk9GxVLbkMMO+2mF5msOLIZHPb6hqkLj6Drjs05YJBNuE6
        u9lrcfu3jnj831PdHAnep6BLQuvYyZ6rZEL6iScj1+/MvCkHehdKqQqW1V2kaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502558;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j2CQPdz/Xds8UFh3BREFGUGoaQ7ARNwZtS9/ALhBvE0=;
        b=BJFhd29SUIjXu9rd7WsFAZLqDPn0RL8jsHvJzgvBSnY1SDvnYZoYEhYWaX8nAritwMlwfr
        L7zh2WPzHK3McWBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
Date:   Fri, 28 Jul 2023 02:08:30 +0206
Message-Id: <20230728000233.50887-6-john.ogness@linutronix.de>
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

Add an atomic_long_t field @nbcon_seq to the console struct to
store the sequence number for nbcon consoles. For nbcon consoles
this will be used instead of the non-atomic @seq field. The new
field allows for safe atomic sequence number updates without
requiring any locking.

On 64bit systems the new field stores the full sequence number.
On 32bit systems the new field stores the lower 32 bits of the
sequence number, which are expanded to 64bit as needed by
folding the values based on the sequence numbers available in
the ringbuffer.

For 32bit systems, having a 32bit representation in the console
is sufficient. If a console ever gets more than 2^31 records
behind the ringbuffer then this is the least of the problems.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |   4 ++
 kernel/printk/internal.h     |   6 ++
 kernel/printk/printk.c       |  39 +++++++++---
 kernel/printk/printk_nbcon.c | 114 +++++++++++++++++++++++++++++++++++
 4 files changed, 153 insertions(+), 10 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d2bcd2c190a7..a50eaa3b8420 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -244,6 +244,7 @@ struct printk_buffers;
  * @hostile:		Acquire console by hostile takeover
  * @takeover_unsafe:	Acquire console by hostile takeover even if unsafe
  * @pbufs:		Pointer to the text buffer for this context
+ * @seq:		The sequence number to print for this context
  */
 struct nbcon_context {
 	/* members set by caller */
@@ -256,6 +257,7 @@ struct nbcon_context {
 
 	/* members set by acquire */
 	struct printk_buffers	*pbufs;
+	u64			seq;
 };
 
 /**
@@ -279,6 +281,7 @@ struct nbcon_context {
  * @node:		hlist node for the console list
  *
  * @nbcon_state:	State for nbcon consoles
+ * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -302,6 +305,7 @@ struct console {
 
 	/* nbcon console specific members */
 	atomic_t		__private nbcon_state;
+	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 0f2be350600e..1baccddf83b8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,6 +4,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/console.h>
+#include "printk_ringbuffer.h"
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -42,6 +43,7 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+extern struct printk_ringbuffer *prb;
 extern bool have_legacy_console;
 extern bool have_boot_console;
 
@@ -72,6 +74,8 @@ void defer_console_output(void);
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 
+u64 nbcon_seq_read(struct console *con);
+void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_init(struct console *con);
 void nbcon_cleanup(struct console *con);
 
@@ -90,6 +94,8 @@ void nbcon_cleanup(struct console *con);
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline u64 nbcon_seq_read(struct console *con) { return 0; }
+static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_init(struct console *con) { return true; }
 static inline void nbcon_cleanup(struct console *con) { }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 582552a96c57..64e404aacbc4 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -512,7 +512,7 @@ _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 
 static struct printk_ringbuffer printk_rb_dynamic;
 
-static struct printk_ringbuffer *prb = &printk_rb_static;
+struct printk_ringbuffer *prb = &printk_rb_static;
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -3171,8 +3171,27 @@ void console_unblank(void)
  */
 void console_flush_on_panic(enum con_flush_mode mode)
 {
+	struct console *c;
 	bool handover;
-	u64 next_seq;
+	short flags;
+	int cookie;
+	u64 seq;
+
+	seq = prb_first_valid_seq(prb);
+
+	/*
+	 * Safely handle the atomic consoles before trying to flush any
+	 * legacy consoles.
+	 */
+	if (mode == CONSOLE_REPLAY_ALL) {
+		cookie = console_srcu_read_lock();
+		for_each_console_srcu(c) {
+			flags = console_srcu_read_flags(c);
+			if (flags & CON_NBCON)
+				nbcon_seq_force(c, seq);
+		}
+		console_srcu_read_unlock(cookie);
+	}
 
 	if (!serialized_printing)
 		return;
@@ -3195,12 +3214,6 @@ void console_flush_on_panic(enum con_flush_mode mode)
 	console_may_schedule = 0;
 
 	if (mode == CONSOLE_REPLAY_ALL) {
-		struct console *c;
-		int cookie;
-		u64 seq;
-
-		seq = prb_first_valid_seq(prb);
-
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
 			/*
@@ -3212,7 +3225,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 		console_srcu_read_unlock(cookie);
 	}
 
-	console_flush_all(false, &next_seq, &handover);
+	console_flush_all(false, &seq, &handover);
 }
 
 /*
@@ -3795,6 +3808,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	short flags;
 	bool locked;
 	int cookie;
 	u64 diff;
@@ -3821,6 +3835,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		for_each_console_srcu(c) {
 			if (con && con != c)
 				continue;
+
+			flags = console_srcu_read_flags(c);
+
 			/*
 			 * If consoles are not usable, it cannot be expected
 			 * that they make forward progress, so only increment
@@ -3829,7 +3846,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			if (!console_is_usable(c))
 				continue;
 
-			if (locked)
+			if (flags & CON_NBCON)
+				printk_seq = nbcon_seq_read(c);
+			else if (locked)
 				printk_seq = c->seq;
 			else
 				continue;
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index 39fa64891ec6..8229a0a00d5b 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
@@ -108,6 +108,116 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
+/* Convert sequence from u64 to unsigned long. */
+static inline unsigned long __nbcon_seq_to_stored(u64 full_seq)
+{
+	/* On 32bit systems only the lower 32 bits are stored. */
+	return (unsigned long)full_seq;
+}
+
+/* Convert sequence from unsigned long to u64. */
+static inline u64 __nbcon_seq_to_full(unsigned long stored_seq)
+{
+#ifdef CONFIG_64BIT
+	return stored_seq;
+#else
+	u64 full_seq;
+	u64 rb_seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 */
+	rb_seq = prb_next_seq(prb);
+	full_seq = rb_seq - ((u32)rb_seq - stored_seq);
+
+	return full_seq;
+#endif
+}
+
+/**
+ * nbcon_seq_init - Helper function to initialize the console sequence
+ * @con:	Console to work on
+ *
+ * Set @con->nbcon_seq to the starting record (specified with con->seq).
+ * If the starting record no longer exists, the oldest available record
+ * is chosen. This is because on 32bit systems only the lower 32 bits of
+ * the sequence number are stored. The upper 32 bits are derived from the
+ * sequence numbers available in the ringbuffer.
+ *
+ * For init only. Do not use for runtime updates.
+ */
+static void nbcon_seq_init(struct console *con)
+{
+	u64 seq = max_t(u64, con->seq, prb_first_valid_seq(prb));
+
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __nbcon_seq_to_stored(seq));
+
+	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
+	con->seq = 0;
+}
+
+/**
+ * nbcon_read_seq - Read the current console sequence
+ * @con:	Console to read the sequence of
+ *
+ * Return:	Sequence number of the next record to print on @con.
+ */
+u64 nbcon_seq_read(struct console *con)
+{
+	unsigned long seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
+
+	return __nbcon_seq_to_full(seq);
+}
+
+/**
+ * nbcon_seq_force - Force console sequence to a specific value
+ * @con:	Console to work on
+ *
+ * Only to be used in extreme situations (such as panic with
+ * CONSOLE_REPLAY_ALL).
+ */
+void nbcon_seq_force(struct console *con, u64 seq)
+{
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __nbcon_seq_to_stored(seq));
+}
+
+/**
+ * nbcon_seq_try_update - Try to update the console sequence number
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ *
+ * Return:	True if the console sequence was updated, false otherwise.
+ *
+ * On 32bit the sequence in con->nbcon_seq is only the lower 32 bits.
+ * Therefore it must be expanded to 64bit upon a failed cmpxchg in
+ * order to correctly verify that the new sequence (ctxt->seq) is
+ * larger.
+ *
+ * In case of fail the console has been likely taken over. However, the
+ * caller must still assume it has ownership and decide how to proceed.
+ */
+__maybe_unused
+static bool nbcon_seq_try_update(struct nbcon_context *ctxt)
+{
+	struct console *con = ctxt->console;
+	u64 con_seq = nbcon_seq_read(con);
+
+	while (con_seq < ctxt->seq) {
+		unsigned long seq = __nbcon_seq_to_stored(con_seq);
+
+		if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &seq,
+					    __nbcon_seq_to_stored(ctxt->seq))) {
+			return true;
+		}
+
+		/* Expand new @seq value for comparing. */
+		con_seq = __nbcon_seq_to_full(seq);
+	}
+	return false;
+}
+
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
  * @ctxt:		The context of the caller
@@ -483,6 +593,9 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 	else
 		ctxt->pbufs = con->pbufs;
 
+	/* Set the record sequence for this context to print. */
+	ctxt->seq = nbcon_seq_read(ctxt->console);
+
 	return true;
 }
 
@@ -554,6 +667,7 @@ bool nbcon_init(struct console *con)
 		return false;
 	}
 
+	nbcon_seq_init(con);
 	nbcon_state_set(con, &state);
 	return true;
 }
-- 
2.39.2

