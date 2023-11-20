Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABF87F1B61
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbjKTRrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjKTRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:35 -0500
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [IPv6:2001:41d0:203:375::aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F70A9E
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700502449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4+Y9MGkz9f3yZSUENZCgBAvLs1CfO+kuipQPdiyYS+c=;
        b=Ql85St5SjYl9dK6UKQo/wZBfC05xwZ8kz2f2txy485DwN0EC3gx7bgEAGlRsR3amTQZM6i
        Nep6MT9W4kXFWBOfaYnIaeXGDBapToM5EgH6SXSUwG03GDKgl7MtqpodPgiSEzEwBXoD0L
        1m7pwV0+V5c6VKCswrtvLTavWAO/Q/M=
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
Subject: [PATCH v4 05/22] lib/stackdepot: add depot_fetch_stack helper
Date:   Mon, 20 Nov 2023 18:47:03 +0100
Message-Id: <170d8c202f29dc8e3d5491ee074d1e9e029a46db.1700502145.git.andreyknvl@google.com>
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

Add a helper depot_fetch_stack function that fetches the pointer to
a stack record.

With this change, all static depot_* functions now operate on stack pools
and the exported stack_depot_* functions operate on the hash table.

Reviewed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Minor comment fix as suggested by Alexander.
---
 lib/stackdepot.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 46a422d31c1f..e41713983cac 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -310,6 +310,7 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	stack->handle.extra = 0;
 	memcpy(stack->entries, entries, flex_array_size(stack, entries, size));
 	pool_offset += required_size;
+
 	/*
 	 * Let KMSAN know the stored stack record is initialized. This shall
 	 * prevent false positive reports if instrumented code accesses it.
@@ -319,6 +320,32 @@ depot_alloc_stack(unsigned long *entries, int size, u32 hash, void **prealloc)
 	return stack;
 }
 
+static struct stack_record *depot_fetch_stack(depot_stack_handle_t handle)
+{
+	union handle_parts parts = { .handle = handle };
+	/*
+	 * READ_ONCE pairs with potential concurrent write in
+	 * depot_alloc_stack().
+	 */
+	int pool_index_cached = READ_ONCE(pool_index);
+	void *pool;
+	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
+	struct stack_record *stack;
+
+	if (parts.pool_index > pool_index_cached) {
+		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
+		     parts.pool_index, pool_index_cached, handle);
+		return NULL;
+	}
+
+	pool = stack_pools[parts.pool_index];
+	if (!pool)
+		return NULL;
+
+	stack = pool + offset;
+	return stack;
+}
+
 /* Calculates the hash for a stack. */
 static inline u32 hash_stack(unsigned long *entries, unsigned int size)
 {
@@ -462,14 +489,6 @@ EXPORT_SYMBOL_GPL(stack_depot_save);
 unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 			       unsigned long **entries)
 {
-	union handle_parts parts = { .handle = handle };
-	/*
-	 * READ_ONCE pairs with potential concurrent write in
-	 * depot_alloc_stack.
-	 */
-	int pool_index_cached = READ_ONCE(pool_index);
-	void *pool;
-	size_t offset = parts.offset << DEPOT_STACK_ALIGN;
 	struct stack_record *stack;
 
 	*entries = NULL;
@@ -482,15 +501,7 @@ unsigned int stack_depot_fetch(depot_stack_handle_t handle,
 	if (!handle || stack_depot_disabled)
 		return 0;
 
-	if (parts.pool_index > pool_index_cached) {
-		WARN(1, "pool index %d out of bounds (%d) for stack id %08x\n",
-			parts.pool_index, pool_index_cached, handle);
-		return 0;
-	}
-	pool = stack_pools[parts.pool_index];
-	if (!pool)
-		return 0;
-	stack = pool + offset;
+	stack = depot_fetch_stack(handle);
 
 	*entries = stack->entries;
 	return stack->size;
-- 
2.25.1

