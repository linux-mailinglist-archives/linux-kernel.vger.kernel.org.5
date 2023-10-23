Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D207D3C80
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233728AbjJWQ3r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjJWQ3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:29:35 -0400
Received: from out-201.mta1.migadu.com (out-201.mta1.migadu.com [95.215.58.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C07AFF
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:29:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QFz7c41J1QbS9PQ1h2ItmRgQJE/l+/U2CDCp2U3Lga0=;
        b=Ln8jn/btUwxdS3NYz+kfGYLWvsWTvJ5u3YyVev72quQFxpQ6rAJIQeN6sfP0fJG2IQ2K/7
        Ru/NFMADjWGJJEoVmdgwuQzr+Cafy+Kpdr9JMH8ZcWTuixF85WuxaVOR1wWdIJI6caGvld
        MaqFZ97JESE7qZ5aZRIgTe9xXo/s0x4=
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
Subject: [PATCH v3 08/19] lib/stackdepot: rename next_pool_required to new_pool_required
Date:   Mon, 23 Oct 2023 18:22:39 +0200
Message-Id: <5d8faf61763307b4d71a9b5272b88fb5c5ae7521.1698077459.git.andreyknvl@google.com>
In-Reply-To: <cover.1698077459.git.andreyknvl@google.com>
References: <cover.1698077459.git.andreyknvl@google.com>
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

Rename next_pool_required to new_pool_required.

This a purely code readability change: the following patch will change
stack depot to store the pointer to the new pool in a separate variable,
and "new" seems like a more logical name.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 lib/stackdepot.c | 49 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 25 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 3f921aaae44a..7579e20114b1 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -93,12 +93,11 @@ static size_t pool_offset;
 static DEFINE_RAW_SPINLOCK(pool_lock);
 /*
  * Stack depot tries to keep an extra pool allocated even before it runs out
- * of space in the currently used pool.
- * This flag marks that this next extra pool needs to be allocated and
- * initialized. It has the value 0 when either the next pool is not yet
- * initialized or the limit on the number of pools is reached.
+ * of space in the currently used pool. This flag marks whether this extra pool
+ * needs to be allocated. It has the value 0 when either an extra pool is not
+ * yet allocated or if the limit on the number of pools is reached.
  */
-static int next_pool_required = 1;
+static int new_pool_required = 1;
 
 static int __init disable_stack_depot(char *str)
 {
@@ -219,20 +218,20 @@ int stack_depot_init(void)
 }
 EXPORT_SYMBOL_GPL(stack_depot_init);
 
-/* Keeps the preallocated memory to be used for the next stack depot pool. */
-static void depot_keep_next_pool(void **prealloc)
+/* Keeps the preallocated memory to be used for a new stack depot pool. */
+static void depot_keep_new_pool(void **prealloc)
 {
 	/*
-	 * If the next pool is already saved or the maximum number of
+	 * If a new pool is already saved or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
-	 * Access next_pool_required non-atomically, as there are no concurrent
+	 * Access new_pool_required non-atomically, as there are no concurrent
 	 * write accesses to this variable.
 	 */
-	if (!next_pool_required)
+	if (!new_pool_required)
 		return;
 
 	/*
-	 * Use the preallocated memory for the next pool
+	 * Use the preallocated memory for the new pool
 	 * as long as we do not exceed the maximum number of pools.
 	 */
 	if (pool_index + 1 < DEPOT_MAX_POOLS) {
@@ -241,13 +240,13 @@ static void depot_keep_next_pool(void **prealloc)
 	}
 
 	/*
-	 * At this point, either the next pool is kept or the maximum
+	 * At this point, either a new pool is kept or the maximum
 	 * number of pools is reached. In either case, take note that
 	 * keeping another pool is not required.
 	 * smp_store_release() pairs with smp_load_acquire() in
 	 * stack_depot_save().
 	 */
-	smp_store_release(&next_pool_required, 0);
+	smp_store_release(&new_pool_required, 0);
 }
 
 /* Updates refences to the current and the next stack depot pools. */
@@ -262,7 +261,7 @@ static bool depot_update_pools(size_t required_size, void **prealloc)
 		}
 
 		/*
-		 * Move on to the next pool.
+		 * Move on to the new pool.
 		 * WRITE_ONCE() pairs with potential concurrent read in
 		 * stack_depot_fetch().
 		 */
@@ -271,12 +270,12 @@ static bool depot_update_pools(size_t required_size, void **prealloc)
 
 		/*
 		 * If the maximum number of pools is not reached, take note
-		 * that the next pool needs to be initialized.
+		 * that yet another new pool needs to be allocated.
 		 * smp_store_release() pairs with smp_load_acquire() in
 		 * stack_depot_save().
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
-			smp_store_release(&next_pool_required, 1);
+			smp_store_release(&new_pool_required, 1);
 	}
 
 	/* Check if the current pool is not yet allocated. */
@@ -287,9 +286,9 @@ static bool depot_update_pools(size_t required_size, void **prealloc)
 		return true;
 	}
 
-	/* Otherwise, try using the preallocated memory for the next pool. */
+	/* Otherwise, try using the preallocated memory for a new pool. */
 	if (*prealloc)
-		depot_keep_next_pool(prealloc);
+		depot_keep_new_pool(prealloc);
 	return true;
 }
 
@@ -300,7 +299,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	struct stack_record *stack;
 	size_t required_size = DEPOT_STACK_RECORD_SIZE;
 
-	/* Update current and next pools if required and possible. */
+	/* Update current and new pools if required and possible. */
 	if (!depot_update_pools(required_size, prealloc))
 		return NULL;
 
@@ -432,13 +431,13 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		goto exit;
 
 	/*
-	 * Check if another stack pool needs to be initialized. If so, allocate
-	 * the memory now - we won't be able to do that under the lock.
+	 * Check if another stack pool needs to be allocated. If so, allocate
+	 * the memory now: we won't be able to do that under the lock.
 	 *
 	 * smp_load_acquire() pairs with smp_store_release() in
-	 * depot_update_pools() and depot_keep_next_pool().
+	 * depot_update_pools() and depot_keep_new_pool().
 	 */
-	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
+	if (unlikely(can_alloc && smp_load_acquire(&new_pool_required))) {
 		/*
 		 * Zero out zone modifiers, as we don't have specific zone
 		 * requirements. Keep the flags related to allocation in atomic
@@ -471,9 +470,9 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	} else if (prealloc) {
 		/*
 		 * Stack depot already contains this stack trace, but let's
-		 * keep the preallocated memory for the future.
+		 * keep the preallocated memory for future.
 		 */
-		depot_keep_next_pool(&prealloc);
+		depot_keep_new_pool(&prealloc);
 	}
 
 	raw_spin_unlock_irqrestore(&pool_lock, flags);
-- 
2.25.1

