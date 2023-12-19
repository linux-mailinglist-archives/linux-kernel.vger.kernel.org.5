Return-Path: <linux-kernel+bounces-5959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3270581922B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9914B23F00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC33D541;
	Tue, 19 Dec 2023 21:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="elb7wJjm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F83D0AB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 21:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703020797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nejB0rN/5EGuA3SQQpabp67CuxIikS5y1NrnTFuMISI=;
	b=elb7wJjmHVmMnqrahneo3nmWE9hHEyTRVGuiSBGymfQVeOW15J6gqNykSrIgFdw9PIMbZF
	ta1kf9P/xFptBLk6yUizJYveQGUO6hzXz1/PIciaF5j55mJ3tEib32Ug4OJ35XYc+zlmf1
	5OklhsBMYdcTGxBkNXOkqzloDUn2vJw=
From: andrey.konovalov@linux.dev
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v3 mm 1/4] lib/stackdepot: add printk_deferred_enter/exit guards
Date: Tue, 19 Dec 2023 22:19:50 +0100
Message-Id: <82092f9040d075a161d1264377d51e0bac847e8a.1703020707.git.andreyknvl@google.com>
In-Reply-To: <cover.1703020707.git.andreyknvl@google.com>
References: <cover.1703020707.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Stack depot functions can be called from various contexts that do
allocations, including with console locks taken. At the same time, stack
depot functions might print WARNING's or refcount-related failures.

This can cause a deadlock on console locks.

Add printk_deferred_enter/exit guards to stack depot to avoid this.

Reported-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Closes: https://lore.kernel.org/all/000000000000f56750060b9ad216@google.com/
Fixes: 108be8def46e ("lib/stackdepot: allow users to evict stack traces")
Fixes: cd11016e5f52 ("mm, kasan: stackdepot implementation. Enable stackdepot for SLAB")
Reviewed-by: Marco Elver <elver@google.com>
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


