Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5E756D98
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbjGQTqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjGQTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96CD129
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKtFcTm51p2UyE/4CXzBxj1k6TpKtEUesAG6IFFRp+k=;
        b=tmQbpPkFzxdsyvVM638zyr0wuBwxyPEompovgJAF3P9kBpCkaK/U7fZKZ0UVKZDplHXjzY
        qvCrPtrRvqR1rFanVThoTfjRH2T0tOceoWtozimvyjMVU1Qe7ABVF+uByQpNRclm3/23iZ
        SUA19xKeTeJOHR0unrreM524Rv0y8rdT6cz/OnSa4c0D/GWt08KLpKt1qs/XA6Q3sXatUe
        4JIouvZ1KrBRrpdobztz7P2Km0PQGSh65t4JMGaVe0lw2zvmFpx137oxo9PXPo7I4dxFr8
        MGAu/iOasODeKZGFIynSstRDKkxnY0lrtcezNrsMd/d7I74ndfEEOK8Nmj3+LQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKtFcTm51p2UyE/4CXzBxj1k6TpKtEUesAG6IFFRp+k=;
        b=mMXHcNdFat3Ydenjfn88gH8Zfi8wPS0Vhmj9MewLjS8QCROwF/zs8SLmG3Y973q5prQ+rP
        /wbjg3/b+Fq5FqCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH printk v3 6/7] printk: Add per-console suspended state
Date:   Mon, 17 Jul 2023 21:52:06 +0206
Message-Id: <20230717194607.145135-7-john.ogness@linutronix.de>
In-Reply-To: <20230717194607.145135-1-john.ogness@linutronix.de>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the global @console_suspended is used to determine if
consoles are in a suspended state. Its primary purpose is to allow
usage of the console_lock when suspended without causing console
printing. It is synchronized by the console_lock.

Rather than relying on the console_lock to determine suspended
state, make it an official per-console state that is set within
console->flags. This allows the state to be queried via SRCU.

Remove @console_suspended. Console printing will still be avoided
when suspended because console_is_usable() returns false when
the new suspended flag is set for that console.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/console.h |  3 ++
 kernel/printk/printk.c  | 74 ++++++++++++++++++++++++-----------------
 2 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/include/linux/console.h b/include/linux/console.h
index d3195664baa5..7de11c763eb3 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -154,6 +154,8 @@ static inline int con_debug_leave(void)
  *			receiving the printk spam for obvious reasons.
  * @CON_EXTENDED:	The console supports the extended output format of
  *			/dev/kmesg which requires a larger output buffer.
+ * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
+ *			printing callbacks must not be called.
  */
 enum cons_flags {
 	CON_PRINTBUFFER		= BIT(0),
@@ -163,6 +165,7 @@ enum cons_flags {
 	CON_ANYTIME		= BIT(4),
 	CON_BRL			= BIT(5),
 	CON_EXTENDED		= BIT(6),
+	CON_SUSPENDED		= BIT(7),
 };
 
 /**
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 6e853a1441a7..efe577477913 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -86,7 +86,7 @@ EXPORT_SYMBOL(oops_in_progress);
 static DEFINE_MUTEX(console_mutex);
 
 /*
- * console_sem protects updates to console->seq and console_suspended,
+ * console_sem protects updates to console->seq
  * and also provides serialization for console printing.
  */
 static DEFINE_SEMAPHORE(console_sem);
@@ -359,7 +359,7 @@ static bool panic_in_progress(void)
  * paths in the console code where we end up in places I want
  * locked without the console semaphore held).
  */
-static int console_locked, console_suspended;
+static int console_locked;
 
 /*
  *	Array of consoles built from command line options (console=)
@@ -2549,22 +2549,46 @@ MODULE_PARM_DESC(console_no_auto_verbose, "Disable console loglevel raise to hig
  */
 void suspend_console(void)
 {
+	struct console *con;
+
 	if (!console_suspend_enabled)
 		return;
 	pr_info("Suspending console(s) (use no_console_suspend to debug)\n");
 	pr_flush(1000, true);
-	console_lock();
-	console_suspended = 1;
-	up_console_sem();
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags | CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see that they are suspended so that it
+	 * is guaranteed that all printing has stopped when this function
+	 * completes.
+	 */
+	synchronize_srcu(&console_srcu);
 }
 
 void resume_console(void)
 {
+	struct console *con;
+
 	if (!console_suspend_enabled)
 		return;
-	down_console_sem();
-	console_suspended = 0;
-	console_unlock();
+
+	console_list_lock();
+	for_each_console(con)
+		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
+	console_list_unlock();
+
+	/*
+	 * Ensure that all SRCU list walks have completed. All printing
+	 * contexts must be able to see they are no longer suspended so
+	 * that they are guaranteed to wake up and resume printing.
+	 */
+	synchronize_srcu(&console_srcu);
+
 	pr_flush(1000, true);
 }
 
@@ -2623,8 +2647,6 @@ void console_lock(void)
 		msleep(1000);
 
 	down_console_sem();
-	if (console_suspended)
-		return;
 	console_locked = 1;
 	console_may_schedule = 1;
 }
@@ -2645,10 +2667,6 @@ int console_trylock(void)
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
-	if (console_suspended) {
-		up_console_sem();
-		return 0;
-	}
 	console_locked = 1;
 	console_may_schedule = 0;
 	return 1;
@@ -2674,6 +2692,9 @@ static inline bool console_is_usable(struct console *con)
 	if (!(flags & CON_ENABLED))
 		return false;
 
+	if ((flags & CON_SUSPENDED))
+		return false;
+
 	if (!con->write)
 		return false;
 
@@ -2992,11 +3013,6 @@ void console_unlock(void)
 	bool flushed;
 	u64 next_seq;
 
-	if (console_suspended) {
-		up_console_sem();
-		return;
-	}
-
 	/*
 	 * Console drivers are called with interrupts disabled, so
 	 * @console_may_schedule should be cleared before; however, we may
@@ -3726,8 +3742,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 
 		/*
 		 * Hold the console_lock to guarantee safe access to
-		 * console->seq and to prevent changes to @console_suspended
-		 * until all consoles have been processed.
+		 * console->seq.
 		 */
 		console_lock();
 
@@ -3735,6 +3750,11 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		for_each_console_srcu(c) {
 			if (con && con != c)
 				continue;
+			/*
+			 * If consoles are not usable, it cannot be expected
+			 * that they make forward progress, so only increment
+			 * @diff for usable consoles.
+			 */
 			if (!console_is_usable(c))
 				continue;
 			printk_seq = c->seq;
@@ -3743,18 +3763,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
 		}
 		console_srcu_read_unlock(cookie);
 
-		/*
-		 * If consoles are suspended, it cannot be expected that they
-		 * make forward progress, so timeout immediately. @diff is
-		 * still used to return a valid flush status.
-		 */
-		if (console_suspended)
-			remaining = 0;
-		else if (diff != last_diff && reset_on_progress)
+		if (diff != last_diff && reset_on_progress)
 			remaining = timeout_ms;
 
 		console_unlock();
 
+		/* Note: @diff is 0 if there are no usable consoles. */
 		if (diff == 0 || remaining == 0)
 			break;
 
@@ -3788,7 +3802,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
  * printer has been seen to make some forward progress.
  *
  * Context: Process context. May sleep while acquiring console lock.
- * Return: true if all enabled printers are caught up.
+ * Return: true if all usable printers are caught up.
  */
 static bool pr_flush(int timeout_ms, bool reset_on_progress)
 {
-- 
2.30.2

