Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC395756D97
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjGQTq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjGQTqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C37132
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu6gzK/4jkqAoJ/jXncCLCUSjs8DGhEWy7oSpwCss+o=;
        b=kSG+caGmZXeuMzfARy/5g8A1jKk5qOKE0oQT3Q0EeW7PqIKal9w9WLVd3I4pTWn7y/aVk3
        ucABjSN5jiENmitHz/IR3qaX4c0GTzcNOtedP/BZP8+KE/ujSs0ZafsLJmJId6+aSnxjHu
        BMBReSEjGAUuyagWZsXzjpcGTYzzuENX7kne2jOiR6JbBni0hUHRx2laAN9u4YXz2FDrpz
        cC54gpOoXpwoKOk8XDl2U/58PfYqNzrSnZXqaY8uX9UMnq5ZfNIehV0uMIIyPDJe3bcT4w
        2M7yjFXbETXTxHvvng/DbNpB2uN/lTEjGsgfZCzmzVpOLnYbfOapoIg6GqpCNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623171;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zu6gzK/4jkqAoJ/jXncCLCUSjs8DGhEWy7oSpwCss+o=;
        b=WBcXj89+TVh8RDV6RI3gikxev5tMiMSU0s9Bw/GOSnCnpQ/fdxIT1UuTq6YhIUxOCH7tzq
        uXux6730MeuQezBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 5/7] printk: Consolidate console deferred printing
Date:   Mon, 17 Jul 2023 21:52:05 +0206
Message-Id: <20230717194607.145135-6-john.ogness@linutronix.de>
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

Printing to consoles can be deferred for several reasons:

- explicitly with printk_deferred()
- printk() in NMI context
- recursive printk() calls

The current implementation is not consistent. For printk_deferred(),
irq work is scheduled twice. For NMI und recursive, panic CPU
suppression and caller delays are not properly enforced.

Correct these inconsistencies by consolidating the deferred printing
code so that vprintk_deferred() is the top-level function for
deferred printing and vprintk_emit() will perform whichever irq_work
queueing is appropriate.

Also add kerneldoc for wake_up_klogd() and defer_console_output() to
clarify their differences and appropriate usage.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c      | 35 ++++++++++++++++++++++++++++-------
 kernel/printk/printk_safe.c |  9 ++-------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 51445e8ea730..6e853a1441a7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2306,7 +2306,11 @@ asmlinkage int vprintk_emit(int facility, int level,
 		preempt_enable();
 	}
 
-	wake_up_klogd();
+	if (in_sched)
+		defer_console_output();
+	else
+		wake_up_klogd();
+
 	return printed_len;
 }
 EXPORT_SYMBOL(vprintk_emit);
@@ -3841,11 +3845,33 @@ static void __wake_up_klogd(int val)
 	preempt_enable();
 }
 
+/**
+ * wake_up_klogd - Wake kernel logging daemon
+ *
+ * Use this function when new records have been added to the ringbuffer
+ * and the console printing of those records has already occurred or is
+ * known to be handled by some other context. This function will only
+ * wake the logging daemon.
+ *
+ * Context: Any context.
+ */
 void wake_up_klogd(void)
 {
 	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
 }
 
+/**
+ * defer_console_output - Wake kernel logging daemon and trigger
+ *	console printing in a deferred context
+ *
+ * Use this function when new records have been added to the ringbuffer,
+ * this context is responsible for console printing those records, but
+ * the current context is not allowed to perform the console printing.
+ * Trigger an irq_work context to perform the console printing. This
+ * function also wakes the logging daemon.
+ *
+ * Context: Any context.
+ */
 void defer_console_output(void)
 {
 	/*
@@ -3862,12 +3888,7 @@ void printk_trigger_flush(void)
 
 int vprintk_deferred(const char *fmt, va_list args)
 {
-	int r;
-
-	r = vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
-	defer_console_output();
-
-	return r;
+	return vprintk_emit(0, LOGLEVEL_SCHED, NULL, fmt, args);
 }
 
 int _printk_deferred(const char *fmt, ...)
diff --git a/kernel/printk/printk_safe.c b/kernel/printk/printk_safe.c
index ef0f9a2044da..6d10927a07d8 100644
--- a/kernel/printk/printk_safe.c
+++ b/kernel/printk/printk_safe.c
@@ -38,13 +38,8 @@ asmlinkage int vprintk(const char *fmt, va_list args)
 	 * Use the main logbuf even in NMI. But avoid calling console
 	 * drivers that might have their own locks.
 	 */
-	if (this_cpu_read(printk_context) || in_nmi()) {
-		int len;
-
-		len = vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
-		defer_console_output();
-		return len;
-	}
+	if (this_cpu_read(printk_context) || in_nmi())
+		return vprintk_deferred(fmt, args);
 
 	/* No obstacles. */
 	return vprintk_default(fmt, args);
-- 
2.30.2

