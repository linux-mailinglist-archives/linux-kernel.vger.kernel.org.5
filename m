Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9D5790C9C
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242811AbjICPGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 11:06:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242327AbjICPFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 11:05:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AC5116
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 08:05:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8vPFGdeXUNDfa+Ny+mEHwTYVN3mDgzVoBfYv7dgDgM=;
        b=w91VGh58Lhzr4l9BmTa9B+5EkdCgOx+uA6EetqzMuvsczCC1p/yBYcPdxvbbdXjqcuQqlN
        VkK70frEsbrhCHyfOGQcxYuaYoH5lU17xsH3ErGrorQ2LQlBBE3kUBnysAZDMWd5sjuLoy
        uGZvuPYiNaG1bpWJmDQyq5ymSyqX1QeM8rN7zLAJ7bGnggYVAI/d2DAUzH3JXViM+hRgPH
        swof3RdGY+1LMxnthttYxBHJP1H7qJ7qNra4zij9esMRBQQ6Jxrvx/sdACXdMR07vvyUA3
        PTKbCuAxU+aFaSNSiOOHzUzpIpRIl6iOBBbqEgkPtjVm7mCrsKGdO34a0DBUUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693753545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O8vPFGdeXUNDfa+Ny+mEHwTYVN3mDgzVoBfYv7dgDgM=;
        b=n92iUQEbBuyMTcjZm+RcAa4r6YHFwFxS322Av09owQyYM2GbCcOcqadun0x59qD7wbR69e
        fPJW/yulgc7N3qCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 5/7] printk: nbcon: Add sequence handling
Date:   Sun,  3 Sep 2023 17:11:37 +0206
Message-Id: <20230903150539.245076-6-john.ogness@linutronix.de>
In-Reply-To: <20230903150539.245076-1-john.ogness@linutronix.de>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 include/linux/console.h  |   4 ++
 kernel/printk/internal.h |   7 +++
 kernel/printk/nbcon.c    | 112 +++++++++++++++++++++++++++++++++++++++
 kernel/printk/printk.c   |  31 ++++++++---
 4 files changed, 147 insertions(+), 7 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d0bf9abd76b8..8e8dc8d1016b 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -249,6 +249,7 @@ struct printk_buffers;
  *				might cause a system freeze when the console
  *				is used later.
  * @pbufs:			Pointer to the text buffer for this context
+ * @seq:			The sequence number to print for this context
  */
 struct nbcon_context {
 	/* members set by caller */
@@ -259,6 +260,7 @@ struct nbcon_context {
 
 	/* members set by acquire */
 	struct printk_buffers	*pbufs;
+	u64			seq;
 };
 
 /**
@@ -282,6 +284,7 @@ struct nbcon_context {
  * @node:		hlist node for the console list
  *
  * @nbcon_state:	State for nbcon consoles
+ * @nbcon_seq:		Sequence number of the next record for nbcon to print
  * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
@@ -305,6 +308,7 @@ struct console {
 
 	/* nbcon console specific members */
 	atomic_t		__private nbcon_state;
+	atomic_long_t		__private nbcon_seq;
 	struct printk_buffers	*pbufs;
 };
 
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index cb4ea90f04a5..956f65308392 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -4,6 +4,7 @@
  */
 #include <linux/percpu.h>
 #include <linux/console.h>
+#include "printk_ringbuffer.h"
 
 #if defined(CONFIG_PRINTK) && defined(CONFIG_SYSCTL)
 void __init printk_sysctl_init(void);
@@ -42,6 +43,8 @@ enum printk_info_flags {
 	LOG_CONT	= 8,	/* text is a fragment of a continuation line */
 };
 
+extern struct printk_ringbuffer *prb;
+
 __printf(4, 0)
 int vprintk_store(int facility, int level,
 		  const struct dev_printk_info *dev_info,
@@ -69,6 +72,8 @@ void defer_console_output(void);
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 
+u64 nbcon_seq_read(struct console *con);
+void nbcon_seq_force(struct console *con, u64 seq);
 bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
 void nbcon_cleanup(struct console *con);
@@ -88,6 +93,8 @@ void nbcon_cleanup(struct console *con);
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline u64 nbcon_seq_read(struct console *con) { return 0; }
+static inline void nbcon_seq_force(struct console *con, u64 seq) { }
 static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
 static inline void nbcon_cleanup(struct console *con) { }
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 76e39538bdec..cd8d1e8539af 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -84,6 +84,112 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
 	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
 }
 
+#ifdef CONFIG_64BIT
+
+#define __seq_to_nbcon_seq(seq) (seq)
+#define __nbcon_seq_to_seq(seq) (seq)
+
+#else /* CONFIG_64BIT */
+
+#define __seq_to_nbcon_seq(seq) ((u32)seq)
+
+static inline u64 __nbcon_seq_to_seq(u32 nbcon_seq)
+{
+	u64 seq;
+	u64 rb_next_seq;
+
+	/*
+	 * The provided sequence is only the lower 32 bits of the ringbuffer
+	 * sequence. It needs to be expanded to 64bit. Get the next sequence
+	 * number from the ringbuffer and fold it.
+	 *
+	 * Having a 32bit representation in the console is sufficient.
+	 * If a console ever gets more than 2^31 records behind
+	 * the ringbuffer then this is the least of the problems.
+	 *
+	 * Also the access to the ring buffer is always safe.
+	 */
+	rb_next_seq = prb_next_seq(prb);
+	seq = rb_next_seq - ((u32)rb_next_seq - nbcon_seq);
+
+	return seq;
+}
+
+#endif /* CONFIG_64BIT */
+
+/**
+ * nbcon_seq_init - Helper function to initialize the console sequence
+ * @con:	Console to work on
+ *
+ * Set @con->nbcon_seq to the starting record (specified with con->seq).
+ * If the starting record no longer exists, the oldest available record
+ * is chosen. This is especially important on 32bit systems because only
+ * the lower 32 bits of the sequence number are stored. The upper 32 bits
+ * are derived from the sequence numbers available in the ringbuffer.
+ *
+ * For init only. Do not use for runtime updates.
+ */
+static void nbcon_seq_init(struct console *con)
+{
+	u64 seq = max_t(u64, con->seq, prb_first_valid_seq(prb));
+
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(seq));
+
+	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
+	con->seq = 0;
+}
+
+/**
+ * nbcon_seq_read - Read the current console sequence
+ * @con:	Console to read the sequence of
+ *
+ * Return:	Sequence number of the next record to print on @con.
+ */
+u64 nbcon_seq_read(struct console *con)
+{
+	unsigned long nbcon_seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
+
+	return __nbcon_seq_to_seq(nbcon_seq);
+}
+
+/**
+ * nbcon_seq_force - Force console sequence to a specific value
+ * @con:	Console to work on
+ * @seq:	Sequence number value to set
+ *
+ * Only to be used in extreme situations (such as panic with
+ * CONSOLE_REPLAY_ALL).
+ */
+void nbcon_seq_force(struct console *con, u64 seq)
+{
+	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __seq_to_nbcon_seq(seq));
+}
+
+/**
+ * nbcon_seq_try_update - Try to update the console sequence number
+ * @ctxt:	Pointer to an acquire context that contains
+ *		all information about the acquire mode
+ * @new_seq:	The new sequence number to set
+ *
+ * @ctxt->seq is updated to the new value of @con::nbcon_seq. This could
+ * be a different value than @new_seq if nbcon_seq_force() was used or the
+ * current context no longer owns the console. In the later case, it will
+ * stop printing anyway.
+ */
+__maybe_unused
+static void nbcon_seq_try_update(struct nbcon_context *ctxt, u64 new_seq)
+{
+	unsigned long nbcon_seq = __seq_to_nbcon_seq(ctxt->seq);
+	struct console *con = ctxt->console;
+
+	if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &nbcon_seq,
+				    __seq_to_nbcon_seq(new_seq))) {
+		ctxt->seq = new_seq;
+	} else {
+		ctxt->seq = atomic_long_read(&ACCESS_PRIVATE(con, nbcon_seq));
+	}
+}
+
 /**
  * nbcon_context_try_acquire_direct - Try to acquire directly
  * @ctxt:	The context of the caller
@@ -463,6 +569,9 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 	else
 		ctxt->pbufs = con->pbufs;
 
+	/* Set the record sequence for this context to print. */
+	ctxt->seq = nbcon_seq_read(ctxt->console);
+
 	return true;
 }
 
@@ -648,6 +757,8 @@ bool nbcon_alloc(struct console *con)
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ *
+ * This function expects that the legacy @con->seq has been set.
  */
 void nbcon_init(struct console *con)
 {
@@ -656,6 +767,7 @@ void nbcon_init(struct console *con)
 	/* nbcon_alloc() must have been called and successful! */
 	BUG_ON(!con->pbufs);
 
+	nbcon_seq_init(con);
 	nbcon_state_set(con, &state);
 }
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b340c5a36fe2..4e22ff8d065e 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -492,7 +492,7 @@ _DEFINE_PRINTKRB(printk_rb_static, CONFIG_LOG_BUF_SHIFT - PRB_AVGBITS,
 
 static struct printk_ringbuffer printk_rb_dynamic;
 
-static struct printk_ringbuffer *prb = &printk_rb_static;
+struct printk_ringbuffer *prb = &printk_rb_static;
 
 /*
  * We cannot access per-CPU data (e.g. per-CPU flush irq_work) before
@@ -3161,6 +3161,7 @@ void console_flush_on_panic(enum con_flush_mode mode)
 
 	if (mode == CONSOLE_REPLAY_ALL) {
 		struct console *c;
+		short flags;
 		int cookie;
 		u64 seq;
 
@@ -3168,11 +3169,17 @@ void console_flush_on_panic(enum con_flush_mode mode)
 
 		cookie = console_srcu_read_lock();
 		for_each_console_srcu(c) {
-			/*
-			 * This is an unsynchronized assignment, but the
-			 * kernel is in "hope and pray" mode anyway.
-			 */
-			c->seq = seq;
+			flags = console_srcu_read_flags(c);
+
+			if (flags & CON_NBCON) {
+				nbcon_seq_force(c, seq);
+			} else {
+				/*
+				 * This is an unsynchronized assignment. On
+				 * panic legacy consoles are only best effort.
+				 */
+				c->seq = seq;
+			}
 		}
 		console_srcu_read_unlock(cookie);
 	}
@@ -3740,6 +3747,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 	struct console *c;
 	u64 last_diff = 0;
 	u64 printk_seq;
+	short flags;
 	int cookie;
 	u64 diff;
 	u64 seq;
@@ -3761,6 +3769,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		for_each_console_srcu(c) {
 			if (con && con != c)
 				continue;
+
+			flags = console_srcu_read_flags(c);
+
 			/*
 			 * If consoles are not usable, it cannot be expected
 			 * that they make forward progress, so only increment
@@ -3768,7 +3779,13 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 			 */
 			if (!console_is_usable(c))
 				continue;
-			printk_seq = c->seq;
+
+			if (flags & CON_NBCON) {
+				printk_seq = nbcon_seq_read(c);
+			} else {
+				printk_seq = c->seq;
+			}
+
 			if (printk_seq < seq)
 				diff += seq - printk_seq;
 		}
-- 
2.39.2

