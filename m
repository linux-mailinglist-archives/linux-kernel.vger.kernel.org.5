Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1A778CA73
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 19:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237700AbjH2RNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 13:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237717AbjH2RMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 13:12:52 -0400
Received: from out-244.mta1.migadu.com (out-244.mta1.migadu.com [95.215.58.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF40CD1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 10:12:41 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1693329160;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TBLA9eVhfpPnUCaW6dvoHE+HvIWz4FYhXI+BxxI+EVo=;
        b=rTza+MTDtXsApdY3UtmvCOQ7kVEgxoogWmU+0/N+/sEo8Jl8pyma+tVj6hbC217kRw1J6E
        W2W+iu1c4gZpxYAIOpkN1sNFMFS3da9ylVLiov/nqPc0JE4H1dH8MM7fvRWFW9ucQ0eS+L
        WhjGfi5dKdpIeZyWgv2oUZtl5JJ4KEI=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 07/15] stackdepot: rework helpers for depot_alloc_stack
Date:   Tue, 29 Aug 2023 19:11:17 +0200
Message-Id: <a8e6add5dae996633a45a1ae7291a26e31118dfb.1693328501.git.andreyknvl@google.com>
In-Reply-To: <cover.1693328501.git.andreyknvl@google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 lib/stackdepot.c | 85 +++++++++++++++++++++++++++---------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 9ae71e1ef1a7..869d520bc690 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -220,11 +220,11 @@ int stack_depot_init(void)
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
 	 * READ_ONCE is only used to mark the variable as atomic,
 	 * there are no concurrent writes.
@@ -232,44 +232,33 @@ static void depot_init_pool(void **prealloc)
 	if (!READ_ONCE(next_pool_required))
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
@@ -279,9 +268,10 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
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
@@ -289,9 +279,30 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
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
@@ -325,7 +336,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	union handle_parts parts = { .handle = handle };
 	/*
 	 * READ_ONCE pairs with potential concurrent write in
-	 * depot_alloc_stack.
+	 * depot_update_pools.
 	 */
 	int pool_index_cached = READ_ONCE(pool_index);
 	void *pool;
@@ -425,7 +436,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * the memory now - we won't be able to do that under the lock.
 	 *
 	 * smp_load_acquire pairs with smp_store_release
-	 * in depot_alloc_stack and depot_init_pool.
+	 * in depot_update_pools and depot_keep_next_pool.
 	 */
 	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
 		/*
@@ -462,7 +473,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		 * Stack depot already contains this stack trace, but let's
 		 * keep the preallocated memory for the future.
 		 */
-		depot_init_pool(&prealloc);
+		depot_keep_next_pool(&prealloc);
 	}
 
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.25.1

