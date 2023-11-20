Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBDD7F1B88
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:50:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbjKTRuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:50:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234647AbjKTRtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:49:52 -0500
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9B110F6
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:49:41 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=91QxaYvk4RHHEJwI4Sc7Oo7z2rlFVPgOoXOer3eAY+g=;
        b=rZ/C2HcsNzvMwpX5O9VOx1lNSC2GHR0kSTsgEzMvFKq6y+hKBKp3/9Ua+zCoBCJmYeieov
        wMbZyfFLCbQY6lOshDlPQuKUW5//srMlo9hBj2CFZiAjPs39TBjkS5qlASK6p+8fCOmgfm
        q8MQh7TtmnvvOGnA2P/0s6mRGFe8vjU=
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
Subject: [PATCH v4 16/22] lib/stackdepot: add refcount for records
Date:   Mon, 20 Nov 2023 18:47:14 +0100
Message-Id: <a3fc14a2359d019d2a008d4ff8b46a665371ffee.1700502145.git.andreyknvl@google.com>
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

Add a reference counter for how many times a stack records has been added
to stack depot.

Add a new STACK_DEPOT_FLAG_GET flag to stack_depot_save_flags that
instructs the stack depot to increment the refcount.

Do not yet decrement the refcount; this is implemented in one of the
following patches.

Do not yet enable any users to use the flag to avoid overflowing the
refcount.

This is preparatory patch for implementing the eviction of stack records
from the stack depot.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Add forgotten refcount_inc() under write lock.
- Add STACK_DEPOT_FLAG_GET flag for stack_depot_save_flags.
---
 include/linux/stackdepot.h | 13 ++++++++++---
 lib/stackdepot.c           | 12 ++++++++++--
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/include/linux/stackdepot.h b/include/linux/stackdepot.h
index 0b262e14144e..611716702d73 100644
--- a/include/linux/stackdepot.h
+++ b/include/linux/stackdepot.h
@@ -39,8 +39,9 @@ typedef u32 depot_flags_t;
  * to its declaration for more details.
  */
 #define STACK_DEPOT_FLAG_CAN_ALLOC	((depot_flags_t)0x0001)
+#define STACK_DEPOT_FLAG_GET		((depot_flags_t)0x0002)
 
-#define STACK_DEPOT_FLAGS_NUM	1
+#define STACK_DEPOT_FLAGS_NUM	2
 #define STACK_DEPOT_FLAGS_MASK	((depot_flags_t)((1 << STACK_DEPOT_FLAGS_NUM) - 1))
 
 /*
@@ -94,6 +95,9 @@ static inline int stack_depot_early_init(void)	{ return 0; }
  * flags of @alloc_flags). Otherwise, stack depot avoids any allocations and
  * fails if no space is left to store the stack trace.
  *
+ * If STACK_DEPOT_FLAG_GET is set in @depot_flags, stack depot will increment
+ * the refcount on the saved stack trace if it already exists in stack depot.
+ *
  * If the provided stack trace comes from the interrupt context, only the part
  * up to the interrupt entry is saved.
  *
@@ -116,8 +120,11 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
  * @nr_entries:		Number of frames in the stack
  * @alloc_flags:	Allocation GFP flags
  *
- * Context: Contexts where allocations via alloc_pages() are allowed.
- *          See stack_depot_save_flags() for more details.
+ * Does not increment the refcount on the saved stack trace; see
+ * stack_depot_save_flags() for more details.
+ *
+ * Context: Contexts where allocations via alloc_pages() are allowed;
+ *          see stack_depot_save_flags() for more details.
  *
  * Return: Handle of the stack trace stored in depot, 0 on failure
  */
diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 59d61d5c09a7..911dee11bf39 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -23,6 +23,7 @@
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/printk.h>
+#include <linux/refcount.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/stacktrace.h>
@@ -60,6 +61,7 @@ struct stack_record {
 	u32 hash;			/* Hash in hash table */
 	u32 size;			/* Number of stored frames */
 	union handle_parts handle;
+	refcount_t count;
 	unsigned long entries[CONFIG_STACKDEPOT_MAX_FRAMES];	/* Frames */
 };
 
@@ -373,6 +375,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->hash = hash;
 	stack->size = size;
 	/* stack->handle is already filled in by depot_init_pool(). */
+	refcount_set(&stack->count, 1);
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 
 	/*
@@ -489,6 +492,8 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 	/* Fast path: look the stack trace up without full locking. */
 	found = find_stack(bucket, entries, nr_entries, hash);
 	if (found) {
+		if (depot_flags & STACK_DEPOT_FLAG_GET)
+			refcount_inc(&found->count);
 		read_unlock_irqrestore(&pool_rwlock, flags);
 		goto exit;
 	}
@@ -528,12 +533,15 @@ depot_stack_handle_t stack_depot_save_flags(unsigned long *entries,
 			list_add(&new->list, bucket);
 			found = new;
 		}
-	} else if (prealloc) {
+	} else {
+		if (depot_flags & STACK_DEPOT_FLAG_GET)
+			refcount_inc(&found->count);
 		/*
 		 * Stack depot already contains this stack trace, but let's
 		 * keep the preallocated memory for future.
 		 */
-		depot_keep_new_pool(&prealloc);
+		if (prealloc)
+			depot_keep_new_pool(&prealloc);
 	}
 
 	write_unlock_irqrestore(&pool_rwlock, flags);
-- 
2.25.1

