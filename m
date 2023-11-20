Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C937F1B7F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbjKTRtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:49:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjKTRtS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:49:18 -0500
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DFEE171D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:48:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+N1Q7uFgicZ/Pf0RFILDijpppowVMY0ExiNLLtkdgaQ=;
        b=RxqnWJ/WbNov6GNDVKKl98NdJigJDFyuUx5XrfpgY0Y/FIFkxZ8cb2F/DaXDPkvN4oYnyI
        w7lMzmrfXQRH2KCXJzK07x0GGzxp0h1cjOV+z4h6XLtv4ZtoYRFtRsvvF70WP3/hsS5GYv
        gtRARyq+ePtSURhjvSTg/rB+k7qi5sM=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Oscar Salvador <osalvador@suse.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v4 11/22] lib/stackdepot: store free stack records in a freelist
Date:   Mon, 20 Nov 2023 18:47:09 +0100
Message-Id: <b9e4c79955c2121b69301778643b203d3fb09ccc.1700502145.git.andreyknvl@google.com>
In-Reply-To: <cover.1700502145.git.andreyknvl@google.com>
References: <cover.1700502145.git.andreyknvl@google.com>
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

Instead of using the global pool_offset variable to find a free slot
when storing a new stack record, mainlain a freelist of free slots
within the allocated stack pools.

A global next_stack variable is used as the head of the freelist, and
the next field in the stack_record struct is reused as freelist link
(when the record is not in the freelist, this field is used as a link
in the hash table).

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Add parentheses when referring to function calls in comments.

Changes v1->v2:
- Fix out-of-bounds when initializing a pool.
---
 lib/stackdepot.c | 131 +++++++++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 49 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 68c1ac9aa916..a5eff165c0d5 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -54,8 +54,8 @@ union handle_parts {
 };
 
 struct stack_record {
-	struct stack_record *next;	/* Link in the hash table */
-	u32 hash;			/* Hash in the hash table */
+	struct stack_record *next;	/* Link in hash table or freelist */
+	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
 	unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
@@ -87,10 +87,10 @@ static unsigned int stack_hash_mask;
 static void *stack_pools[DEPOT_MAX_POOLS];
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
-/* Currently used pool in stack_pools. */
-static int pool_index;
-/* Offset to the unused space in the currently used pool. */
-static size_t pool_offset;
+/* Number of pools in stack_pools. */
+static int pools_num;
+/* Next stack in the freelist of stack records within stack_pools. */
+static struct stack_record *next_stack;
 /* Lock that protects the variables above. */
 static DEFINE_RAW_SPINLOCK(pool_lock);
 /*
@@ -226,6 +226,42 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
+/* Initializes a stack depol pool. */
+static void depot_init_pool(void *pool)
+{
+	const int records_in_pool = DEPOT_POOL_SIZE / DEPOT_STACK_RECORD_SIZE;
+	int i, offset;
+
+	/* Initialize handles and link stack records to each other. */
+	for (i = 0, offset = 0;
+	     offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
+	     i++, offset += DEPOT_STACK_RECORD_SIZE) {
+		struct stack_record *stack = pool + offset;
+
+		stack->handle.pool_index = pools_num;
+		stack->handle.offset = offset >> DEPOT_STACK_ALIGN;
+		stack->handle.extra = 0;
+
+		if (i < records_in_pool - 1)
+			stack->next = (void *)stack + DEPOT_STACK_RECORD_SIZE;
+		else
+			stack->next = NULL;
+	}
+
+	/* Link stack records into the freelist. */
+	WARN_ON(next_stack);
+	next_stack = pool;
+
+	/* Save reference to the pool to be used by depot_fetch_stack(). */
+	stack_pools[pools_num] = pool;
+
+	/*
+	 * WRITE_ONCE() pairs with potential concurrent read in
+	 * depot_fetch_stack().
+	 */
+	WRITE_ONCE(pools_num, pools_num + 1);
+}
+
 /* Keeps the preallocated memory to be used for a new stack depot pool. */
 static void depot_keep_new_pool(void **prealloc)
 {
@@ -242,7 +278,7 @@ static void depot_keep_new_pool(void **prealloc)
 	 * Use the preallocated memory for the new pool
 	 * as long as we do not exceed the maximum number of pools.
 	 */
-	if (pool_index + 1 < DEPOT_MAX_POOLS) {
+	if (pools_num < DEPOT_MAX_POOLS) {
 		new_pool = *prealloc;
 		*prealloc = NULL;
 	}
@@ -258,45 +294,42 @@ static void depot_keep_new_pool(void **prealloc)
 }
 
 /* Updates references to the current and the next stack depot pools. */
-static bool depot_update_pools(size_t required_size, void **prealloc)
+static bool depot_update_pools(void **prealloc)
 {
-	/* Check if there is not enough space in the current pool. */
-	if (unlikely(pool_offset + required_size > DEPOT_POOL_SIZE)) {
-		/* Bail out if we reached the pool limit. */
-		if (unlikely(pool_index + 1 >= DEPOT_MAX_POOLS)) {
-			WARN_ONCE(1, "Stack depot reached limit capacity");
-			return false;
-		}
+	/* Check if we still have objects in the freelist. */
+	if (next_stack)
+		goto out_keep_prealloc;
 
-		/*
-		 * Move on to the new pool.
-		 * WRITE_ONCE() pairs with potential concurrent read in
-		 * stack_depot_fetch().
-		 */
-		WRITE_ONCE(pool_index, pool_index + 1);
-		stack_pools[pool_index] = new_pool;
+	/* Check if we have a new pool saved and use it. */
+	if (new_pool) {
+		depot_init_pool(new_pool);
 		new_pool = NULL;
-		pool_offset = 0;
 
-		/*
-		 * If the maximum number of pools is not reached, take note
-		 * that yet another new pool needs to be allocated.
-		 * smp_store_release() pairs with smp_load_acquire() in
-		 * stack_depot_save().
-		 */
-		if (pool_index + 1 < DEPOT_MAX_POOLS)
+		/* Take note that we might need a new new_pool. */
+		if (pools_num < DEPOT_MAX_POOLS)
 			smp_store_release(&new_pool_required, 1);
+
+		/* Try keeping the preallocated memory for new_pool. */
+		goto out_keep_prealloc;
+	}
+
+	/* Bail out if we reached the pool limit. */
+	if (unlikely(pools_num >= DEPOT_MAX_POOLS)) {
+		WARN_ONCE(1, "Stack depot reached limit capacity");
+		return false;
 	}
 
-	/* Check if the current pool is not yet allocated. */
-	if (*prealloc && stack_pools[pool_index] == NULL) {
-		/* Use the preallocated memory for the current pool. */
-		stack_pools[pool_index] = *prealloc;
+	/* Check if we have preallocated memory and use it. */
+	if (*prealloc) {
+		depot_init_pool(*prealloc);
 		*prealloc = NULL;
 		return true;
 	}
 
-	/* Otherwise, try using the preallocated memory for a new pool. */
+	return false;
+
+out_keep_prealloc:
+	/* Keep the preallocated memory for a new pool if required. */
 	if (*prealloc)
 		depot_keep_new_pool(prealloc);
 	return true;
@@ -307,35 +340,35 @@ static struct stack_record *
 depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 {
 	struct stack_record *stack;
-	size_t required_size = DEPOT_STACK_RECORD_SIZE;
 
 	/* Update current and new pools if required and possible. */
-	if (!depot_update_pools(required_size, prealloc))
+	if (!depot_update_pools(prealloc))
 		return NULL;
 
-	/* Check if we have a pool to save the stack trace. */
-	if (stack_pools[pool_index] == NULL)
+	/* Check if we have a stack record to save the stack trace. */
+	stack = next_stack;
+	if (!stack)
 		return NULL;
 
+	/* Advance the freelist. */
+	next_stack = stack->next;
+
 	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
 	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
 		size = CONFIG_STACKDEPOT_MAX_FRAMES;
 
 	/* Save the stack trace. */
-	stack = stack_pools[pool_index] + pool_offset;
+	stack->next = NULL;
 	stack->hash = hash;
 	stack->size = size;
-	stack->handle.pool_index = pool_index;
-	stack->handle.offset = pool_offset >> DEPOT_STACK_ALIGN;
-	stack->handle.extra = 0;
+	/* stack->handle is already filled in by depot_init_pool(). */
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
-	pool_offset += required_size;
 
 	/*
 	 * Let KMSAN know the stored stack record is initialized. This shall
 	 * prevent false positive reports if instrumented code accesses it.
 	 */
-	kmsan_unpoison_memory(stack, required_size);
+	kmsan_unpoison_memory(stack, DEPOT_STACK_RECORD_SIZE);
 
 	return stack;
 }
@@ -345,16 +378,16 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 	union handle_parts parts = { .handle = handle };
 	/*
 	 * READ_ONCE() pairs with potential concurrent write in
-	 * depot_update_pools().
+	 * depot_init_pool().
 	 */
-	int pool_index_cached = READ_ONCE(pool_index);
+	int pools_num_cached = READ_ONCE(pools_num);
 	void *pool;
 	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
-	if (parts.pool_index > pool_index_cached) {
+	if (parts.pool_index > pools_num_cached) {
 		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-		     parts.pool_index, pool_index_cached, handle);
+		     parts.pool_index, pools_num_cached, handle);
 		return NULL;
 	}
 
-- 
2.25.1

