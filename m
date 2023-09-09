Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8E0799567
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 03:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbjIIBO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 21:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345894AbjIIBOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 21:14:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784F12694;
        Fri,  8 Sep 2023 18:14:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB8D9C116A7;
        Sat,  9 Sep 2023 01:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694221999;
        bh=kg4R1h/fNOZV0D2244wKfNAhBav9HmO2lNH3eR6n1QA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jI1zVrNJvk2jVkfkyAvvyDxd0gPekdcHJen7W9IqFUmoaFlY6snugkJ+lRf4LUUW9
         Sh7bQ8ndAKmnoiOWDvYtzKyImJ4xmdXhPviOJD2d52D8KN7wjqtfoqKduNXM9ElkUo
         Y0D9YxiZ6aE6D3JWYl4g8BjuaDJlPeL0T9NOI1pUD4j2NdsMNl79eY46p77UcqOKjN
         QCx3uRZsIbh8L2uGXZEj4zB8uNECDyUwL28CW3WDQnWJms0UZ4SCY804ZdwoICncUw
         t0YzN4RoigRUbXLz4Jmsk82GmzG32nQg1YU5e9K3PfLTeItJxz1lvrpQTd3hLXivmH
         0QbBi4veIu/8w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 2/3] printk: Consolidate console deferred printing
Date:   Fri,  8 Sep 2023 21:13:13 -0400
Message-Id: <20230909011314.3581953-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909011314.3581953-1-sashal@kernel.org>
References: <20230909011314.3581953-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Ogness <john.ogness@linutronix.de>

[ Upstream commit 696ffaf50e1f8dbc66223ff614473f945f5fb8d8 ]

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
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230717194607.145135-6-john.ogness@linutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/printk/printk.c      | 35 ++++++++++++++++++++++++++++-------
 kernel/printk/printk_safe.c |  9 ++-------
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 4b9429f3fd6d8..cc53fb77f77cc 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2269,7 +2269,11 @@ asmlinkage int vprintk_emit(int facility, int level,
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
@@ -3490,11 +3494,33 @@ static void __wake_up_klogd(int val)
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
@@ -3511,12 +3537,7 @@ void printk_trigger_flush(void)
 
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
index ef0f9a2044da1..6d10927a07d83 100644
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
2.40.1

