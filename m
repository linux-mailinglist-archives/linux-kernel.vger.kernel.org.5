Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2822C80DFE8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 01:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345428AbjLLAOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 19:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345394AbjLLAOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 19:14:04 -0500
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF517B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 16:14:10 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1702340049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vOaXJmSZ4mgcOuCRTmHs9viCNJ5mspLX8zhenk2W1qY=;
        b=ZFY0MXvUwTln62U1tHBt6KK8Dqg+6tfH+i/GfcUa4eujPC2CC53JaDXpaZhT1eWOt98GO5
        rQ36NXtwX/bnZpsUbbyhXz3bTvVFqA6FvpYHeqX+qP0YEUP3BL6KN8k/7Q6TNtfpTILzXF
        HbnIpR5duzaXmjUbV13x2oH9iQ3NxmE=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 1/4] lib/stackdepot: add printk_deferred_enter/exit guards
Date:   Tue, 12 Dec 2023 01:14:00 +0100
Message-Id: <6c38c31e304a55449f76f60b6f72e35f992cad99.1702339432.git.andreyknvl@google.com>
In-Reply-To: <cover.1702339432.git.andreyknvl@google.com>
References: <cover.1702339432.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Stack depot functions can be called from various contexts that do
allocations, including with console locks taken. At the same time, stack
depot functions might print WARNING's or refcount-related failures.

This can cause a deadlock on console locks.

Add printk_deferred_enter/exit guards to stack depot to avoid this.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Closes: https://lore.kernel.org/all/000000000000f56750060b9ad216@google.com/
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 870cce2f4cbd..a0be5d05c7f0 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -506,12 +506,14 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	bucket = &stack_table[hash & stack_hash_mask];
 
 	read_lock_irqsave(&pool_rwlock, flags);
+	printk_deferred_enter();
 
 	/* Fast path: look the stack trace up without full locking. */
 	found = find_stack(bucket, entries, nr_entries, hash);
 	if (found) {
 		if (depot_flags & STACK_DEPOT_FLAG_GET)
 			refcount_inc(&found->count);
+		printk_deferred_exit();
 		read_unlock_irqrestore(&pool_rwlock, flags);
 		goto exit;
 	}
@@ -520,6 +522,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	if (new_pool_required)
 		need_alloc = true;
 
+	printk_deferred_exit();
 	read_unlock_irqrestore(&pool_rwlock, flags);
 
 	/*
@@ -541,6 +544,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	}
 
 	write_lock_irqsave(&pool_rwlock, flags);
+	printk_deferred_enter();
 
 	found = find_stack(bucket, entries, nr_entries, hash);
 	if (!found) {
@@ -562,6 +566,7 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			depot_keep_new_pool(&prealloc);
 	}
 
+	printk_deferred_exit();
 	write_unlock_irqrestore(&pool_rwlock, flags);
 exit:
 	if (prealloc) {
@@ -600,9 +605,11 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 		return 0;
 
 	read_lock_irqsave(&pool_rwlock, flags);
+	printk_deferred_enter();
 
 	stack = depot_fetch_stack(handle);
 
+	printk_deferred_exit();
 	read_unlock_irqrestore(&pool_rwlock, flags);
 
 	*entries = stack->entries;
@@ -619,6 +626,7 @@ void stack_depot_put(depot_stack_handle_t handle)
 		return;
 
 	write_lock_irqsave(&pool_rwlock, flags);
+	printk_deferred_enter();
 
 	stack = depot_fetch_stack(handle);
 	if (WARN_ON(!stack))
@@ -633,6 +641,7 @@ void stack_depot_put(depot_stack_handle_t handle)
 	}
 
 out:
+	printk_deferred_exit();
 	write_unlock_irqrestore(&pool_rwlock, flags);
 }
 EXPORT_SYMBOL_GPL(stack_depot_put);
-- 
2.25.1

