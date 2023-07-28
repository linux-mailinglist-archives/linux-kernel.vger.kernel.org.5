Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B168766076
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjG1ACv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjG1ACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:02:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C3F30FB
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 17:02:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ+5GFgvTYBrgG/gdG5LVsZvzCc8vSNhvk0jKBm+CCo=;
        b=uIIPXliW+A6EgH2lwlEr1gJeNeuAXEsY3WO8uFMJrkYscgESGYB+lhCWaXYRoO58CZTnwa
        l2h5meAY/H5+TL6R+znFVDl5drSt18/dXv6TAe+UVeHxR2PgeahI3Lnaa4LhWkZiSJ0LU2
        uv3vj+qKYERD3I4r+VAu/JikZ3lt+entASHR2xUl0GoFVbAlD65foUX1RSIJLB+5nh2J9V
        3OryIMUi0T3CiF4zkHiEa5CycdmdEEZo0WdOvKwXmgWdGnu2OqTQUjqZUXFP3+MtQ9oYzX
        SAolP93EPQnjW+o6e92Ymeo7NalwvY2idruM/kv5lv5Cghv94bxOSGcIU867ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690502557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zQ+5GFgvTYBrgG/gdG5LVsZvzCc8vSNhvk0jKBm+CCo=;
        b=gPSHpsOiX/R3mhLQZAseHTJvjSYroz99Pnd9DUbBZu5UhZCYBRgMi4zQkGQuBcD/ufPblk
        pVxwVBqn/ssCI9CA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v2 4/8] printk: nbcon: Add buffer management
Date:   Fri, 28 Jul 2023 02:08:29 +0206
Message-Id: <20230728000233.50887-5-john.ogness@linutronix.de>
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

In case of hostile takeovers it must be ensured that the previous
owner cannot scribble over the output buffer of the emergency/panic
context. This is achieved by:

 - Adding a global output buffer instance for the panic context.
   This is the only situation where hostile takeovers can occur and
   there is always at most 1 panic context.

 - Allocating an output buffer per console upon console
   registration. This buffer is used by the console owner when not
   in panic context.

 - Choosing the appropriate buffer is handled in the acquire/release
   functions.

Co-developed-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: John Ogness <john.ogness@linutronix.de>
Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>
---
 include/linux/console.h      |  7 +++++++
 kernel/printk/internal.h     |  6 ++++++
 kernel/printk/printk.c       |  6 ------
 kernel/printk/printk_nbcon.c | 26 ++++++++++++++++++++++++--
 4 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index e06cd1ce3e82..d2bcd2c190a7 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -233,6 +233,7 @@ enum nbcon_prio {
 };
 
 struct console;
+struct printk_buffers;
 
 /**
  * struct nbcon_context - Context for console acquire/release
@@ -242,6 +243,7 @@ struct console;
  * @unsafe:		This context is in an unsafe section
  * @hostile:		Acquire console by hostile takeover
  * @takeover_unsafe:	Acquire console by hostile takeover even if unsafe
+ * @pbufs:		Pointer to the text buffer for this context
  */
 struct nbcon_context {
 	/* members set by caller */
@@ -251,6 +253,9 @@ struct nbcon_context {
 	unsigned int		unsafe			: 1;
 	unsigned int		hostile			: 1;
 	unsigned int		takeover_unsafe		: 1;
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
index 655810f2976e..0f2be350600e 100644
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
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 98b4854c81ea..582552a96c57 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -3359,12 +3359,6 @@ static void try_enable_default_console(struct console *newcon)
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
diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
index b0acde0cb949..39fa64891ec6 100644
--- a/kernel/printk/printk_nbcon.c
+++ b/kernel/printk/printk_nbcon.c
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
  * A concurrent writer on a different CPU with a higher priority can request
  * to take over the console by:
@@ -356,6 +360,8 @@ static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
 	return 0;
 }
 
+static struct printk_buffers panic_nbcon_pbufs;
+
 /**
  * nbcon_context_try_acquire - Try to acquire nbcon console
  * @ctxt:	The context of the caller
@@ -372,7 +378,6 @@ static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
 __maybe_unused
 static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 {
-	__maybe_unused
 	unsigned int cpu = smp_processor_id();
 	struct console *con = ctxt->console;
 	struct nbcon_state cur;
@@ -471,6 +476,13 @@ static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
 		ctxt->hostile = 0;
 		ctxt->takeover_unsafe = 0;
 	}
+
+	/* Assign the appropriate buffer for this context. */
+	if (atomic_read(&panic_cpu) == cpu)
+		ctxt->pbufs = &panic_nbcon_pbufs;
+	else
+		ctxt->pbufs = con->pbufs;
+
 	return true;
 }
 
@@ -509,7 +521,7 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 	nbcon_state_read(con, &cur);
 	do {
 		if (!nbcon_owner_matches(&cur, cpu, ctxt->prio))
-			return;
+			break;
 
 		new.atom = cur.atom;
 		new.prio = NBCON_PRIO_NONE;
@@ -521,6 +533,8 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
 		 */
 
 	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
+
+	ctxt->pbufs = NULL;
 }
 
 /**
@@ -534,6 +548,12 @@ bool nbcon_init(struct console *con)
 {
 	struct nbcon_state state = { };
 
+	con->pbufs = kmalloc(sizeof(*con->pbufs), GFP_KERNEL);
+	if (!con->pbufs) {
+		con_printk(KERN_ERR, con, "failed to allocate printing buffer\n");
+		return false;
+	}
+
 	nbcon_state_set(con, &state);
 	return true;
 }
@@ -547,4 +567,6 @@ void nbcon_cleanup(struct console *con)
 	struct nbcon_state state = { };
 
 	nbcon_state_set(con, &state);
+	kfree(con->pbufs);
+	con->pbufs = NULL;
 }
-- 
2.39.2

