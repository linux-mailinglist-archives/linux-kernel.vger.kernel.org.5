Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274A5756D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjGQTqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjGQTqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:46:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4232B134
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:46:14 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689623172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YQbbOC++27VfIsffSPDpAp65YkynE+WjOPzsRadPmE=;
        b=sHqCWahsOvD4A9UnYFTXLDtz/ASa6LrsAWgDf7FkeeOlFfFT6K8hRPadzcCdN7/rt1KDpg
        +lXZk0RmJ+it1hdcsm9cCIMXgbxUHGkEfGqRsf1TOJ3harahQ15nvdYIZl4vV7sXjVDoVU
        6t3CG7T7aY1UYRwFZVV1IcEZ3+nzLIwBlD+kpfhnLNW+PrJaiTSVV0JhxYZJtCGA8wCgAg
        e8P0RP77KrwB5Xz1BSRa4wuUIxdb1uv7FubBSvaU7otmfxnjvakNVkSHSrDEyAcq1hm6hr
        +uXeS7EVoczXX2jpuDgUcqKlrPRSp7rts2ibREKF3P9Xeq1vOLplZfc+N7xDgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689623172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9YQbbOC++27VfIsffSPDpAp65YkynE+WjOPzsRadPmE=;
        b=9IHgE7RC4BYeds2iX1dQh0bYNmwmlziLbwfkx0g88uyZzMRrVw2b+YmkusV7QhwEST5u4Z
        7rrXFemlFI7bylAA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH printk v3 7/7] printk: Rename abandon_console_lock_in_panic() to other_cpu_in_panic()
Date:   Mon, 17 Jul 2023 21:52:07 +0206
Message-Id: <20230717194607.145135-8-john.ogness@linutronix.de>
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

Currently abandon_console_lock_in_panic() is only used to determine if
the current CPU should immediately release the console lock because
another CPU is in panic. However, later this function will be used by
the CPU to immediately release other resources in this situation.

Rename the function to other_cpu_in_panic(), which is a better
description and does not assume it is related to the console lock.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/internal.h |  2 ++
 kernel/printk/printk.c   | 15 ++++++++-------
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
index 2a17704136f1..7d4979d5c3ce 100644
--- a/kernel/printk/internal.h
+++ b/kernel/printk/internal.h
@@ -103,3 +103,5 @@ struct printk_message {
 	u64			seq;
 	unsigned long		dropped;
 };
+
+bool other_cpu_in_panic(void);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index efe577477913..8787d3a72114 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2612,11 +2612,12 @@ static int console_cpu_notify(unsigned int cpu)
 }
 
 /*
- * Return true when this CPU should unlock console_sem without pushing all
- * messages to the console. This reduces the chance that the console is
- * locked when the panic CPU tries to use it.
+ * Return true if a panic is in progress on a remote CPU.
+ *
+ * On true, the local CPU should immediately release any printing resources
+ * that may be needed by the panic CPU.
  */
-static bool abandon_console_lock_in_panic(void)
+bool other_cpu_in_panic(void)
 {
 	if (!panic_in_progress())
 		return false;
@@ -2643,7 +2644,7 @@ void console_lock(void)
 	might_sleep();
 
 	/* On panic, the console_lock must be left to the panic cpu. */
-	while (abandon_console_lock_in_panic())
+	while (other_cpu_in_panic())
 		msleep(1000);
 
 	down_console_sem();
@@ -2663,7 +2664,7 @@ EXPORT_SYMBOL(console_lock);
 int console_trylock(void)
 {
 	/* On panic, the console_lock must be left to the panic cpu. */
-	if (abandon_console_lock_in_panic())
+	if (other_cpu_in_panic())
 		return 0;
 	if (down_trylock_console_sem())
 		return 0;
@@ -2978,7 +2979,7 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
 			any_progress = true;
 
 			/* Allow panic_cpu to take over the consoles safely. */
-			if (abandon_console_lock_in_panic())
+			if (other_cpu_in_panic())
 				goto abandon;
 
 			if (do_cond_resched)
-- 
2.30.2

