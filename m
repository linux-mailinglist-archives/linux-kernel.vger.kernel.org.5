Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89455798E6A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241747AbjIHSv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbjIHSvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:51:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C2A8E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 11:51:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694199012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6He536R9YKn+8XFiXel4OVcUGGr/X1V5MuFFOnacgQ4=;
        b=qnS1CWRfCglNCihDDP3iLgR1hu6R3WjBuyJJjx+j0gtrHQd1w0DWfJqpihUzCwga5f5GFN
        5QzodThoNIlEq8/hJ/QmKFqL0fcuSuyLK/bP75e5ejZ3MDFARz8EG+vb/UzIG1Yh7ljiHd
        CDUGwUZ6xAuSPMSMaStvgq2GW6iUYDZMR9Z+rlw/6v2vyGEi8CVqsIBrJ3DVNRYIxTEN+R
        THn00okcaDTTPJwu8WujAoAcRfV3sAGh19r3GR7r3ILlnQ6QZP0JKsgdvxvAxd7odadosR
        m8TUYrPU8rHIFVVvl1vRlFM/9vbbDpW38i/Tft92spMiQmKbG8iKOz/IADf0zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694199012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6He536R9YKn+8XFiXel4OVcUGGr/X1V5MuFFOnacgQ4=;
        b=Z6Ysms0Pq8vAPRebFrFJcq1vSfvJUe9EKvcGTDH9XAxKz+eeqkjRh86q+Kl3lvUYhzUtbQ
        jYkquwZ+gQKUxcCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v4 4/8] printk: nbcon: Add buffer management
Date:   Fri,  8 Sep 2023 20:56:04 +0206
Message-Id: <20230908185008.468566-5-john.ogness@linutronix.de>
In-Reply-To: <20230908185008.468566-1-john.ogness@linutronix.de>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
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

In case of hostile takeovers it must be ensured that the previous
owner cannot scribble over the output buffer of the emergency/panic
context. This is achieved by:

 - Adding a global output buffer instance for the panic context.
   This is the only situation where hostile takeovers can occur and
   there is always at most 1 panic context.

 - Allocating an output buffer per non-boot console upon console
   registration. This buffer is used by the console owner when not
   in panic context. (For boot consoles, the existing shared global
   legacy output buffer is used instead. Boot console printing will
   be synchronized with legacy console printing.)

 - Choosing the appropriate buffer is handled in the acquire/release
   functions.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h  |  7 +++++
 kernel/printk/internal.h | 12 ++++++--
 kernel/printk/nbcon.c    | 65 ++++++++++++++++++++++++++++++++++++----
 kernel/printk/printk.c   | 17 ++++++-----
 4 files changed, 87 insertions(+), 14 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index eeebb82d6d07..b7279ebafe0f 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -234,6 +234,7 @@ enum nbcon_prio {
 };
 
 struct console;
+struct printk_buffers;
 
 /**
  * struct nbcon_context - Context for console acquire/release
@@ -244,6 +245,7 @@ struct console;
  *				be used only with NBCON_PRIO_PANIC @prio. It
  *				might cause a system freeze when the console
  *				is used later.
+ * @pbufs:			Pointer to the text buffer for this context
  */
 struct nbcon_context {
 	/* members set by caller */
@@ -251,6 +253,9 @@ struct nbcon_context {
 	unsigned int		spinwait_max_us;
 	enum nbcon_prio		prio;
 	unsigned int		allow_unsafe_takeover	: 1;
+
+	/* members set by acquire */
+	struct printk_buffers	*pbufs;
 };
 
 /**
@@ -274,6 +279,7 @@ struct nbcon_context {
  * @node:		hlist node for the console list
  *
  * @nbcon_state:	State for nbcon consoles
+ * @pbufs:		Pointer to nbcon private buffer
  */
 struct console {
 	char			name[16];
@@ -296,6 +302,7 @@ struct console {
 
 	/* nbcon console specific members */
 	atomic_t		__private nbcon_state;
+	struct printk_buffers	*pbufs;
 };
 
 #ifdef CONFIG_LOCKDEP
diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7199d60bfc25..f6161cd75d7d 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -13,6 +13,12 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 #define printk_sysctl_init() do { } while (0)
 #endif
 
+#define con_printk(lvl, con, fmt, ...)				\
+	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
+		(con->flags & CON_NBCON) ? "" : "legacy ",	\
+		(con->flags & CON_BOOT) ? "boot" : "",		\
+		con->name, con->index, ##__VA_ARGS__)
+
 #ifdef CONFIG_PRINTK
 
 #ifdef CONFIG_PRINTK_CALLER
@@ -63,8 +69,9 @@ void defer_console_output(void);
 u16 printk_parse_prefix(const char *text, int *level,
 			enum printk_info_flags *flags);
 
+bool nbcon_alloc(struct console *con);
 void nbcon_init(struct console *con);
-void nbcon_cleanup(struct console *con);
+void nbcon_free(struct console *con);
 
 #else
 
@@ -81,8 +88,9 @@ void nbcon_cleanup(struct console *con);
 #define printk_safe_exit_irqrestore(flags) local_irq_restore(flags)
 
 static inline bool printk_percpu_data_ready(void) { return false; }
+static inline bool nbcon_alloc(struct console *con) { return false; }
 static inline void nbcon_init(struct console *con) { }
-static inline void nbcon_cleanup(struct console *con) { }
+static inline void nbcon_free(struct console *con) { }
 
 #endif /* CONFIG_PRINTK */
 
diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
index 57ddfb7f0994..cad1cf663078 100644
--- a/kernel/printk/nbcon.c
+++ b/kernel/printk/nbcon.c
@@ -5,6 +5,7 @@
 #include <linux/kernel.h>
 #include <linux/console.h>
 #include <linux/delay.h>
+#include <linux/slab.h>
 #include "internal.h"
 /*
  * Printk console printing implementation for consoles that do not depend on
@@ -20,6 +21,9 @@
  * region and aborts the operation if it detects a takeover.
  *
  * In case of panic the nesting context can take over the console forcefully.
+ * If the interrupted context touches the assigned record buffer after
+ * takeover, it does not cause harm because the interrupting single panic
+ * context is assigned its own panic record buffer.
  *
  * A concurrent writer on a different CPU with a higher priority can directly
  * take over if the console is not in an unsafe state by carefully writing
@@ -380,6 +384,8 @@ static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
 	cur->atom = new.atom;
 }
 
+static struct printk_buffers panic_nbcon_pbufs;
+
 /**
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
@@ -394,7 +400,6 @@ static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
 __maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
-	__maybe_unused
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state cur;
@@ -426,6 +431,12 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 
 	nbcon_context_acquire_hostile(ctxt, &cur);
 success:
+	/* Assign the appropriate buffer for this context. */
+	if (atomic_read(&panic_cpu) == cpu)
+		ctxt->pbufs = &panic_nbcon_pbufs;
+	else
+		ctxt->pbufs = con->pbufs;
+
 	return true;
 }
 
@@ -465,7 +476,7 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 
 	do {
 		if (!nbcon_owner_matches(&cur, cpu, ctxt->prio))
-			return;
+			break;
 
 		new.atom = cur.atom;
 		new.prio = NBCON_PRIO_NONE;
@@ -477,26 +488,70 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 		new.unsafe |= cur.unsafe_takeover;
 
 	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+
+	ctxt->pbufs = NULL;
+}
+
+/**
+ * nbcon_alloc - Allocate buffers needed by the nbcon console
+ * @con:	Console to allocate buffers for
+ *
+ * Return:	True on success. False otherwise and the console cannot
+ *		be used.
+ *
+ * This is not part of nbcon_init() because buffer allocation must
+ * be performed earlier in the console registration process.
+ */
+bool nbcon_alloc(struct console *con)
+{
+	if (con->flags & CON_BOOT) {
+		/*
+		 * Boot console printing is synchronized with legacy console
+		 * printing, so boot consoles can share the same global printk
+		 * buffers.
+		 */
+		con->pbufs = &printk_shared_pbufs;
+	} else {
+		con->pbufs = kmalloc(sizeof(*con->pbufs), GFP_KERNEL);
+		if (!con->pbufs) {
+			con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
+			return false;
+		}
+	}
+
+	return true;
 }
 
 /**
  * nbcon_init - Initialize the nbcon console specific data
  * @con:	Console to initialize
+ *
+ * nbcon_alloc() *must* be called and succeed before this function
+ * is called.
  */
 void nbcon_init(struct console *con)
 {
 	struct nbcon_state state = { };
 
+	/* nbcon_alloc() must have been called and successful! */
+	BUG_ON(!con->pbufs);
+
 	nbcon_state_set(con, &state);
 }
 
 /**
- * nbcon_cleanup - Cleanup the nbcon console specific data
- * @con:	Console to cleanup
+ * nbcon_free - Free and cleanup the nbcon console specific data
+ * @con:	Console to free/cleanup nbcon data
  */
-void nbcon_cleanup(struct console *con)
+void nbcon_free(struct console *con)
 {
 	struct nbcon_state state = { };
 
 	nbcon_state_set(con, &state);
+
+	/* Boot consoles share global printk buffers. */
+	if (!(con->flags & CON_BOOT))
+		kfree(con->pbufs);
+
+	con->pbufs = NULL;
 }
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 9a2ddab16abe..d1c43fa1ffd3 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3329,12 +3329,6 @@ static void try_enable_default_console(struct console *newcon)
 		newcon->flags |= CON_CONSDEV;
 }
 
-#define con_printk(lvl, con, fmt, ...)				\
-	printk(lvl pr_fmt("%s%sconsole [%s%d] " fmt),		\
-	       (con->flags & CON_NBCON) ? "" : "legacy ",	\
-	       (con->flags & CON_BOOT) ? "boot" : "",		\
-	       con->name, con->index, ##__VA_ARGS__)
-
 static void console_init_seq(struct console *newcon, bool bootcon_registered)
 {
 	struct console *con;
@@ -3448,6 +3442,15 @@ void register_console(struct console *newcon)
 		goto unlock;
 	}
 
+	if (newcon->flags & CON_NBCON) {
+		/*
+		 * Ensure the nbcon console buffers can be allocated
+		 * before modifying any global data.
+		 */
+		if (!nbcon_alloc(newcon))
+			goto unlock;
+	}
+
 	/*
 	 * See if we want to enable this console driver by default.
 	 *
@@ -3587,7 +3590,7 @@ static int unregister_console_locked(struct console *console)
 	synchronize_srcu(&console_srcu);
 
 	if (console->flags & CON_NBCON)
-		nbcon_cleanup(console);
+		nbcon_free(console);
 
 	console_sysfs_notify();
 
-- 
2.39.2

