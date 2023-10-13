Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB86F7C8E6B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjJMUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMUnt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:43:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05387BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:43:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697229826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYzxkwxZz9LXzgUZOnKlYZjB7QiQP/AcfRfhCkfffWU=;
        b=WZF9t0mBANVVYkG73VGE2cN9flCFUsOuRIGSTjLh39C2aw1HMcMzyIPfC/MmiyXrLYaK5g
        R0bY39rCL7Fzd3cmOUf3Ex4hjJSypZFhxMpCeZ/xxkpTO359ocBukhcahue4qNpr4e/P9Y
        6HT4UK6SUSfrwtZVyytH9FPP1EFwpOt0hcFycJWR7Oaeg9ToQj6Apk56GD3nhDGd1XQVb6
        k595uNASeRsswgmi1n28OH5L2xnTVM0Ga+UAUvNcHnvW/AfH40GirLApj/OR70xIqxiZFr
        IAhU2Hx3Avw6LcE9mS0Y5fujZo6T52AUBcYizxwwkL4tFZeY7/SqIdVJIEdbFw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697229826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYzxkwxZz9LXzgUZOnKlYZjB7QiQP/AcfRfhCkfffWU=;
        b=6hKBtv1gpM+ovw3KsKEpHuHn+ASfz/FSSRdq218lNqAJ7oTvpZYhdN2xIgzOq3BWX1rVIJ
        Ob1sJiFebcu1iiAQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 2/4] printk: Add this_cpu_in_panic()
Date:   Fri, 13 Oct 2023 22:49:38 +0206
Message-Id: <20231013204340.1112036-3-john.ogness@linutronix.de>
In-Reply-To: <20231013204340.1112036-1-john.ogness@linutronix.de>
References: <20231013204340.1112036-1-john.ogness@linutronix.de>
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

There is already panic_in_progress() and other_cpu_in_panic(),
but checking if the current CPU is the panic CPU must still be
open coded.

Add this_cpu_in_panic() to complete the set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/internal.h |  1 +
 kernel/printk/printk.c   | 43 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 7d4979d5c3ce..2397734c0fd2 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -105,3 +105,4 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool this_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index abb6a50ee26f..19b752880879 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -351,6 +351,29 @@ static bool panic_in_progress(void)
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
@@ -2610,26 +2633,6 @@ static int console_cpu_notify(unsigned int cpu)
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
-- 
2.39.2

