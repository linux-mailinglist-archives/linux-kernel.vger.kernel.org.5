Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E19479F01E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 19:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjIMRQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 13:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjIMRQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 13:16:00 -0400
Received: from out-222.mta1.migadu.com (out-222.mta1.migadu.com [IPv6:2001:41d0:203:375::de])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA499B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 10:15:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694625355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gAOd+0bdipGa5TwT77P0cix2trL96KYDpIy1afA6aX4=;
        b=puVK18ovwq5iY1p+xtahLNnbqGMtfLRPDwUGhyhUQSv+gXInLzJ556ocSpipYuAJUi0IMk
        O/5IT0uIadYTAipofo7r3zp1kwfW+8ahs4/NkRwA7zFRFCmipzk5gZ6+1AqN6CDXnhRBxH
        zjagfztze/wMDtvIwTVJol/qj+Z7myE=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 07/19] lib/stackdepot: rework helpers for depot_alloc_stack
Date:   Wed, 13 Sep 2023 19:14:32 +0200
Message-Id: <bbf482643e882f9f870d80cb35342c61955ea291.1694625260.git.andreyknvl@google.com>
In-Reply-To: <cover.1694625260.git.andreyknvl@google.com>
References: <cover.1694625260.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Split code in depot_alloc_stack and depot_init_pool into 3 functions:

1. depot_keep_next_pool that keeps preallocated memory for the next pool
   if required.

2. depot_update_pools that moves on to the next pool if there's no space
   left in the current pool, uses preallocated memory for the new current
   pool if required, and calls depot_keep_next_pool otherwise.

3. depot_alloc_stack that calls depot_update_pools and then allocates
   a stack record as before.

This makes it somewhat easier to follow the logic of depot_alloc_stack
and also serves as a preparation for implementing the eviction of stack
records from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 87 +++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 38 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index babd453261f0..e85b658be050 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -219,54 +219,43 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-/* Uses preallocated memory to initialize a new stack depot pool. */
-static void depot_init_pool(void **prealloc)
+/* Keeps the preallocated memory to be used for the next stack depot pool. */
+static void depot_keep_next_pool(void **prealloc)
 {
 	/*
-	 * If the next pool is already initialized or the maximum number of
+	 * If the next pool is already saved or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
 	 */
 	if (!next_pool_required)
 		return;
 
-	/* Check if the current pool is not yet allocated. */
-	if (stack_pools[pool_index] == NULL) {
-		/* Use the preallocated memory for the current pool. */
-		stack_pools[pool_index] = *prealloc;
+	/*
+	 * Use the preallocated memory for the next pool
+	 * as long as we do not exceed the maximum number of pools.
+	 */
+	if (pool_index + 1 < DEPOT_MAX_POOLS) {
+		stack_pools[pool_index + 1] = *prealloc;
 		*prealloc = NULL;
-	} else {
-		/*
-		 * Otherwise, use the preallocated memory for the next pool
-		 * as long as we do not exceed the maximum number of pools.
-		 */
-		if (pool_index + 1 < DEPOT_MAX_POOLS) {
-			stack_pools[pool_index + 1] = *prealloc;
-			*prealloc = NULL;
-		}
-		/*
-		 * At this point, either the next pool is initialized or the
-		 * maximum number of pools is reached. In either case, take
-		 * note that initializing another pool is not required.
-		 * smp_store_release pairs with smp_load_acquire in
-		 * stack_depot_save.
-		 */
-		smp_store_release(&next_pool_required, 0);
 	}
+
+	/*
+	 * At this point, either the next pool is kept or the maximum
+	 * number of pools is reached. In either case, take note that
+	 * keeping another pool is not required.
+	 * smp_store_release pairs with smp_load_acquire in stack_depot_save.
+	 */
+	smp_store_release(&next_pool_required, 0);
 }
 
-/* Allocates a new stack in a stack depot pool. */
-static struct stack_record *
-depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
+/* Updates refences to the current and the next stack depot pools. */
+static bool depot_update_pools(size_t required_size, void **prealloc)
 {
-	struct stack_record *stack;
-	size_t required_size = DEPOT_STACK_RECORD_SIZE;
-
 	/* Check if there is not enough space in the current pool. */
 	if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
 		/* Bail out if we reached the pool limit. */
 		if (unlikely(pool_index + 1 >= DEPOT_MAX_POOLS)) {
 			WARN_ONCE(1, "Stack depot reached limit capacity");
-			return NULL;
+			return false;
 		}
 
 		/*
@@ -276,9 +265,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		 */
 		WRITE_ONCE(pool_index, pool_index + 1);
 		pool_offset = 0;
+
 		/*
 		 * If the maximum number of pools is not reached, take note
-		 * that the next pool needs to initialized.
+		 * that the next pool needs to be initialized.
 		 * smp_store_release pairs with smp_load_acquire in
 		 * stack_depot_save.
 		 */
@@ -286,9 +276,30 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 			smp_store_release(&next_pool_required, 1);
 	}
 
-	/* Assign the preallocated memory to a pool if required. */
+	/* Check if the current pool is not yet allocated. */
+	if (*prealloc && stack_pools[pool_index] == NULL) {
+		/* Use the preallocated memory for the current pool. */
+		stack_pools[pool_index] = *prealloc;
+		*prealloc = NULL;
+		return true;
+	}
+
+	/* Otherwise, try using the preallocated memory for the next pool. */
 	if (*prealloc)
-		depot_init_pool(prealloc);
+		depot_keep_next_pool(prealloc);
+	return true;
+}
+
+/* Allocates a new stack in a stack depot pool. */
+static struct stack_record *
+depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
+{
+	struct stack_record *stack;
+	size_t required_size = DEPOT_STACK_RECORD_SIZE;
+
+	/* Update current and next pools if required and possible. */
+	if (!depot_update_pools(required_size, prealloc))
+		return NULL;
 
 	/* Check if we have a pool to save the stack trace. */
 	if (stack_pools[pool_index] == NULL)
@@ -322,7 +333,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	union handle_parts parts = { .handle = handle };
 	/*
 	 * READ_ONCE pairs with potential concurrent write in
-	 * depot_alloc_stack.
+	 * depot_update_pools.
 	 */
 	int pool_index_cached = READ_ONCE(pool_index);
 	void *pool;
@@ -421,8 +432,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * Check if another stack pool needs to be initialized. If so, allocate
 	 * the memory now - we won't be able to do that under the lock.
 	 *
-	 * smp_load_acquire pairs with smp_store_release in depot_alloc_stack
-	 * and depot_init_pool.
+	 * smp_load_acquire pairs with smp_store_release in depot_update_pools
+	 * and depot_keep_next_pool.
 	 */
 	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
 		/*
@@ -459,7 +470,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * Stack depot already contains this stack trace, but let's
 		 * keep the preallocated memory for the future.
 		 */
-		depot_init_pool(&prealloc);
+		depot_keep_next_pool(&prealloc);
 	}
 
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.25.1

