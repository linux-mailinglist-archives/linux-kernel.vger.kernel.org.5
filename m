Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A992E7E2EA1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 22:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbjKFVHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 16:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233093AbjKFVHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 16:07:38 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4C103
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 13:07:35 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699304854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EjNlI5JonKv0m/kINdXCywSbWYOfTvFxrSFxNOQW5Ko=;
        b=MJVAR+sgDJZ8TL8ljWTnvRYcn0y6yHtJzqUbEQ1e08Ii5zXYVTcFfCo+HM+F2/58vSrvt8
        EROu+OomB2vxIDFyqIF2UTt13/UFWVxvHcwBgtziEhu4iXKMvgFDdEgFc77rLT8H+sO9ty
        3U6iH2DrYM/PwKtpj508qEy+IUrJug5tljmMnPg/N4zQWNiSoxyk6pEDgjCYL/m1iXd/sB
        KfsNmQVvxP+S+XbGcI+HrkLUQn2BTjvNDWOSesTg2KVF2HrtTRtzQKIeDXn6CpErnA3WBD
        6lV/LSeGIK0g3Hvm7yE9wr20Vmx93ZNrfmVWVFvMByZgIub8HG2pQFLQnSb51A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699304854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EjNlI5JonKv0m/kINdXCywSbWYOfTvFxrSFxNOQW5Ko=;
        b=RyhUWvptryHr7Sz4ofjXpuWKZwkpDAcmLBQ1/uuyrbLijg192A/cny+0wnHW0xwQ/7zmoj
        PfrSVwuLOHUZAOCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v2 4/9] printk: Add this_cpu_in_panic()
Date:   Mon,  6 Nov 2023 22:13:25 +0106
Message-Id: <20231106210730.115192-5-john.ogness@linutronix.de>
In-Reply-To: <20231106210730.115192-1-john.ogness@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
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

There is already panic_in_progress() and other_cpu_in_panic(),
but checking if the current CPU is the panic CPU must still be
open coded.

Add this_cpu_in_panic() to complete the set.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  1 +
 kernel/printk/printk.c   | 43 +++++++++++++++++++++-------------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 6c2afee5ef62..ac2d9750e5f8 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -130,6 +130,7 @@ struct printk_message {
 };
 
 bool other_cpu_in_panic(void);
+bool this_cpu_in_panic(void);
 bool printk_get_next_message(struct printk_message *pmsg, u64 seq,
 			     bool is_extended, bool may_supress);
 
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 22bb45d8f2f2..82dc2c7949b7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -347,6 +347,29 @@ static bool panic_in_progress(void)
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
@@ -2592,26 +2615,6 @@ static int console_cpu_notify(unsigned int cpu)
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

