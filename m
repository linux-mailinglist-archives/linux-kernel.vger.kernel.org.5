Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D97F1B74
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjKTRtc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234159AbjKTRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:49:17 -0500
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83C9D5B
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:48:34 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ul/nKw7kj0oOeSlF9NlnEwH7YAqJQYzQqOqaJ7LWVgY=;
        b=ukcrau9rBSSL43tgTPUpFjw/XmDDuuV7b5Rf6ugJdDIx3eaVAx8V/9PFiPuIgxA8HOVqDI
        FOv6Ks7qLmHGEak24eJMUo0HQta3weJK4BNrKPY6LbsCGCWMiUh2CgVaukTzBdLG8nj0JF
        0fqdYiwEAxqEdM4YGbvK075MNLH3F5M=
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
Subject: [PATCH v4 07/22] lib/stackdepot: fix and clean-up atomic annotations
Date:   Mon, 20 Nov 2023 18:47:05 +0100
Message-Id: <c118ef044d8db80248d9e1f14592c72e8429e9d9.1700502145.git.andreyknvl@google.com>
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

Drop smp_load_acquire from next_pool_required in depot_init_pool, as both
depot_init_pool and the all smp_store_release's to this variable are
executed under the stack depot lock.

Also simplify and clean up comments accompanying the use of atomic
accesses in the stack depot code.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

This patch is not strictly required, as the atomic accesses are fully
removed in one of the latter patches. However, I decided to keep the
patch just in case we end up needing these atomics in the following
iterations of this series.

Changes v2->v3:
- Keep parentheses when referring to functions in comments.
- Add comment that explains why depot_init_pool reads next_pool_required
  non-atomically.

Changes v1->v2:
- Minor comment fix as suggested by Marco.
- Drop READ_ONCE marking for next_pool_required.
---
 lib/stackdepot.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 682497dbe081..cfa3c6c7cc2e 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -231,10 +231,10 @@ static void depot_init_pool(void **prealloc)
 	/*
 	 * If the next pool is already initialized or the maximum number of
 	 * pools is reached, do not use the preallocated memory.
-	 * smp_load_acquire() here pairs with smp_store_release() below and
-	 * in depot_alloc_stack().
+	 * Access next_pool_required non-atomically, as there are no concurrent
+	 * write accesses to this variable.
 	 */
-	if (!smp_load_acquire(&next_pool_required))
+	if (!next_pool_required)
 		return;
 
 	/* Check if the current pool is not yet allocated. */
@@ -255,8 +255,8 @@ static void depot_init_pool(void **prealloc)
 		 * At this point, either the next pool is initialized or the
 		 * maximum number of pools is reached. In either case, take
 		 * note that initializing another pool is not required.
-		 * This smp_store_release pairs with smp_load_acquire() above
-		 * and in stack_depot_save().
+		 * smp_store_release() pairs with smp_load_acquire() in
+		 * stack_depot_save().
 		 */
 		smp_store_release(&next_pool_required, 0);
 	}
@@ -279,7 +279,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 
 		/*
 		 * Move on to the next pool.
-		 * WRITE_ONCE pairs with potential concurrent read in
+		 * WRITE_ONCE() pairs with potential concurrent read in
 		 * stack_depot_fetch().
 		 */
 		WRITE_ONCE(pool_index, pool_index + 1);
@@ -287,8 +287,8 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		/*
 		 * If the maximum number of pools is not reached, take note
 		 * that the next pool needs to initialized.
-		 * smp_store_release() here pairs with smp_load_acquire() in
-		 * stack_depot_save() and depot_init_pool().
+		 * smp_store_release() pairs with smp_load_acquire() in
+		 * stack_depot_save().
 		 */
 		if (pool_index + 1 < DEPOT_MAX_POOLS)
 			smp_store_release(&next_pool_required, 1);
@@ -329,7 +329,7 @@ static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
 {
 	union handle_parts parts = { .handle = handle };
 	/*
-	 * READ_ONCE pairs with potential concurrent write in
+	 * READ_ONCE() pairs with potential concurrent write in
 	 * depot_alloc_stack().
 	 */
 	int pool_index_cached = READ_ONCE(pool_index);
@@ -419,8 +419,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 	/*
 	 * Fast path: look the stack trace up without locking.
-	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |bucket| below.
+	 * smp_load_acquire() pairs with smp_store_release() to |bucket| below.
 	 */
 	found = find_stack(smp_load_acquire(bucket), entries, nr_entries, hash);
 	if (found)
@@ -430,8 +429,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	 * Check if another stack pool needs to be initialized. If so, allocate
 	 * the memory now - we won't be able to do that under the lock.
 	 *
-	 * The smp_load_acquire() here pairs with smp_store_release() to
-	 * |next_pool_inited| in depot_alloc_stack() and depot_init_pool().
+	 * smp_load_acquire() pairs with smp_store_release() in
+	 * depot_alloc_stack() and depot_init_pool().
 	 */
 	if (unlikely(can_alloc && smp_load_acquire(&next_pool_required))) {
 		/*
@@ -457,8 +456,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 		if (new) {
 			new->next = *bucket;
 			/*
-			 * This smp_store_release() pairs with
-			 * smp_load_acquire() from |bucket| above.
+			 * smp_store_release() pairs with smp_load_acquire()
+			 * from |bucket| above.
 			 */
 			smp_store_release(bucket, new);
 			found = new;
-- 
2.25.1

