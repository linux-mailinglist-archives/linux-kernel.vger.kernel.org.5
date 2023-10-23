Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8327D3C61
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjJWQZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 12:25:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbjJWQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 12:25:12 -0400
X-Greylist: delayed 124 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 09:25:10 PDT
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ca])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A324E5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 09:25:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698078308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kwAPQEKRgU/QjlEBZ2MhqIx/KOtst15cg0pwz3Hyr9g=;
        b=iGUJS+rOn2dXj8f4BIY+WwdB8Mdqb1aEQqfE+6SqjcK1mxQ+u4/MVV6bams1FgB2otyMtr
        VknTKi9tknQ69VcwKIOlmvNy0fBatX3KvqxEFyA/LAWA33e35h42LQLvfNWq4n+5VujTpi
        4WErb4Df30D2FUv9R93/ziOe2SgmPy4=
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
Subject: [PATCH v3 12/19] lib/stackdepot: use list_head for stack record links
Date:   Mon, 23 Oct 2023 18:22:43 +0200
Message-Id: <518e3873243845249c8fb019d744c5f5eac90205.1698077459.git.andreyknvl@google.com>
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

Switch stack_record to use list_head for links in the hash table
and in the freelist.

This will allow removing entries from the hash table buckets.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v2->v3:
- Use the proper number of entries for initializing the stack table when
  alloc_large_system_hash() auto-calculates the number.

Changes v1->v2:
- Use list_head instead of open-coding backward links.
---
 lib/stackdepot.c | 87 ++++++++++++++++++++++++++++--------------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index b1ceade0acc9..85fd40c63817 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -18,6 +18,7 @@
 #include <linux/jhash.h>
 #include <linux/kernel.h>
 #include <linux/kmsan.h>
+#include <linux/list.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
@@ -55,7 +56,7 @@ union handle_parts {
 };
 
 struct stack_record {
-	struct stack_record *next;	/* Link in hash table or freelist */
+	struct list_head list;		/* Links in hash table or freelist */
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
@@ -77,21 +78,21 @@ static bool __stack_depot_early_init_passed __initdata;
 /* Initial seed for jhash2. */
 #define STACK_HASH_SEED 0x9747b28c
 
-/* Hash table of pointers to stored stack traces. */
-static struct stack_record **stack_table;
+/* Hash table of stored stack records. */
+static struct list_head *stack_table;
 /* Fixed order of the number of table buckets. Used when KASAN is enabled. */
 static unsigned int stack_bucket_number_order;
 /* Hash mask for indexing the table. */
 static unsigned int stack_hash_mask;
 
-/* Array of memory regions that store stack traces. */
+/* Array of memory regions that store stack records. */
 static void *stack_pools[DEPOT_MAX_POOLS];
 /* Newly allocated pool that is not yet added to stack_pools. */
 static void *new_pool;
 /* Number of pools in stack_pools. */
 static int pools_num;
-/* Next stack in the freelist of stack records within stack_pools. */
-static struct stack_record *next_stack;
+/* Freelist of stack records within stack_pools. */
+static LIST_HEAD(free_stacks);
 /*
  * Stack depot tries to keep an extra pool allocated even before it runs out
  * of space in the currently used pool. This flag marks whether this extra pool
@@ -123,6 +124,15 @@ void __init stack_depot_request_early_init(void)
 	__stack_depot_early_init_requested = true;
 }
 
+/* Initialize list_head's within the hash table. */
+static void init_stack_table(unsigned long entries)
+{
+	unsigned long i;
+
+	for (i = 0; i < entries; i++)
+		INIT_LIST_HEAD(&stack_table[i]);
+}
+
 /* Allocates a hash table via memblock. Can only be used during early boot. */
 int __init stack_depot_early_init(void)
 {
@@ -146,16 +156,16 @@ int __init stack_depot_early_init(void)
 
 	/*
 	 * If stack_bucket_number_order is not set, leave entries as 0 to rely
-	 * on the automatic calculations performed by alloc_large_system_hash.
+	 * on the automatic calculations performed by alloc_large_system_hash().
 	 */
 	if (stack_bucket_number_order)
 		entries = 1UL << stack_bucket_number_order;
 	pr_info("allocating hash table via alloc_large_system_hash\n");
 	stack_table = alloc_large_system_hash("stackdepot",
-						sizeof(struct stack_record *),
+						sizeof(struct list_head),
 						entries,
 						STACK_HASH_TABLE_SCALE,
-						HASH_EARLY | HASH_ZERO,
+						HASH_EARLY,
 						NULL,
 						&stack_hash_mask,
 						1UL << STACK_BUCKET_NUMBER_ORDER_MIN,
@@ -165,6 +175,14 @@ int __init stack_depot_early_init(void)
 		stack_depot_disabled = true;
 		return -ENOMEM;
 	}
+	if (!entries) {
+		/*
+		 * Obtain the number of entries that was calculated by
+		 * alloc_large_system_hash().
+		 */
+		entries = stack_hash_mask + 1;
+	}
+	init_stack_table(entries);
 
 	return 0;
 }
@@ -205,7 +223,7 @@ int stack_depot_init(void)
 		entries = 1UL << STACK_BUCKET_NUMBER_ORDER_MAX;
 
 	pr_info("allocating hash table of %lu entries via kvcalloc\n", entries);
-	stack_table = kvcalloc(entries, sizeof(struct stack_record *), GFP_KERNEL);
+	stack_table = kvcalloc(entries, sizeof(struct list_head), GFP_KERNEL);
 	if (!stack_table) {
 		pr_err("hash table allocation failed, disabling\n");
 		stack_depot_disabled = true;
@@ -213,6 +231,7 @@ int stack_depot_init(void)
 		goto out_unlock;
 	}
 	stack_hash_mask = entries - 1;
+	init_stack_table(entries);
 
 out_unlock:
 	mutex_unlock(&stack_depot_init_mutex);
@@ -224,31 +243,24 @@ EXPORT_SYMBOL_GPL(stack_depot_init);
 /* Initializes a stack depol pool. */
 static void depot_init_pool(void *pool)
 {
-	const int records_in_pool = DEPOT_POOL_SIZE / DEPOT_STACK_RECORD_SIZE;
-	int i, offset;
+	int offset;
 
 	lockdep_assert_held_write(&pool_rwlock);
 
-	/* Initialize handles and link stack records to each other. */
-	for (i = 0, offset = 0;
-	     offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
-	     i++, offset += DEPOT_STACK_RECORD_SIZE) {
+	WARN_ON(!list_empty(&free_stacks));
+
+	/* Initialize handles and link stack records into the freelist. */
+	for (offset = 0; offset <= DEPOT_POOL_SIZE - DEPOT_STACK_RECORD_SIZE;
+	     offset += DEPOT_STACK_RECORD_SIZE) {
 		struct stack_record *stack = pool + offset;
 
 		stack->handle.pool_index = pools_num;
 		stack->handle.offset = offset >> DEPOT_STACK_ALIGN;
 		stack->handle.extra = 0;
 
-		if (i < records_in_pool - 1)
-			stack->next = (void *)stack + DEPOT_STACK_RECORD_SIZE;
-		else
-			stack->next = NULL;
+		list_add(&stack->list, &free_stacks);
 	}
 
-	/* Link stack records into the freelist. */
-	WARN_ON(next_stack);
-	next_stack = pool;
-
 	/* Save reference to the pool to be used by depot_fetch_stack(). */
 	stack_pools[pools_num] = pool;
 	pools_num++;
@@ -289,7 +301,7 @@ static bool depot_update_pools(void **prealloc)
 	lockdep_assert_held_write(&pool_rwlock);
 
 	/* Check if we still have objects in the freelist. */
-	if (next_stack)
+	if (!list_empty(&free_stacks))
 		goto out_keep_prealloc;
 
 	/* Check if we have a new pool saved and use it. */
@@ -340,19 +352,18 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 		return NULL;
 
 	/* Check if we have a stack record to save the stack trace. */
-	stack = next_stack;
-	if (!stack)
+	if (list_empty(&free_stacks))
 		return NULL;
 
-	/* Advance the freelist. */
-	next_stack = stack->next;
+	/* Get and unlink the first entry from the freelist. */
+	stack = list_first_entry(&free_stacks, struct stack_record, list);
+	list_del(&stack->list);
 
 	/* Limit number of saved frames to CONFIG_STACKDEPOT_MAX_FRAMES. */
 	if (size > CONFIG_STACKDEPOT_MAX_FRAMES)
 		size = CONFIG_STACKDEPOT_MAX_FRAMES;
 
 	/* Save the stack trace. */
-	stack->next = NULL;
 	stack->hash = hash;
 	stack->size = size;
 	/* stack->handle is already filled in by depot_init_pool(). */
@@ -414,15 +425,17 @@ int stackdepot_memcmp(const unsigned long *u1, const unsigned long *u2,
 }
 
 /* Finds a stack in a bucket of the hash table. */
-static inline struct stack_record *find_stack(struct stack_record *bucket,
+static inline struct stack_record *find_stack(struct list_head *bucket,
 					     unsigned long *entries, int size,
 					     u32 hash)
 {
+	struct list_head *pos;
 	struct stack_record *found;
 
 	lockdep_assert_held(&pool_rwlock);
 
-	for (found = bucket; found; found = found->next) {
+	list_for_each(pos, bucket) {
+		found = list_entry(pos, struct stack_record, list);
 		if (found->hash == hash &&
 		    found->size == size &&
 		    !stackdepot_memcmp(entries, found->entries, size))
@@ -435,7 +448,8 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 					unsigned int nr_entries,
 					gfp_t alloc_flags, bool can_alloc)
 {
-	struct stack_record *found = NULL, **bucket;
+	struct list_head *bucket;
+	struct stack_record *found = NULL;
 	depot_stack_handle_t handle = 0;
 	struct page *page = NULL;
 	void *prealloc = NULL;
@@ -462,7 +476,7 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 	read_lock_irqsave(&pool_rwlock, flags);
 
 	/* Fast path: look the stack trace up without full locking. */
-	found = find_stack(*bucket, entries, nr_entries, hash);
+	found = find_stack(bucket, entries, nr_entries, hash);
 	if (found) {
 		read_unlock_irqrestore(&pool_rwlock, flags);
 		goto exit;
@@ -494,14 +508,13 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
 
 	write_lock_irqsave(&pool_rwlock, flags);
 
-	found = find_stack(*bucket, entries, nr_entries, hash);
+	found = find_stack(bucket, entries, nr_entries, hash);
 	if (!found) {
 		struct stack_record *new =
 			depot_alloc_stack(entries, nr_entries, hash, &prealloc);
 
 		if (new) {
-			new->next = *bucket;
-			*bucket = new;
+			list_add(&new->list, bucket);
 			found = new;
 		}
 	} else if (prealloc) {
-- 
2.25.1

