Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E9F7E2DEB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbjKFUNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:13:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjKFUMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:12:49 -0500
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6614810C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:12:46 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lOIDRjZO1avx1i6mH90OIJOQ1dfwcpWT2tH0Qop8VTU=;
        b=t8CeOtDwG84XGm08T/bHl0dU0SgTNjwxEbFpQe0150BlnXaBD0GRxcGWFE3gsolklSS+ox
        lTkeYhEYrQQ5j6iilU4kS0eMM5/B2HVjeNJmRJ19p/j/CS/27IgI29IHA++NsiwgXZYidM
        ve2wNSyQK1IC+l9HF2etSKPK0c0wFik=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 14/20] mempool: introduce mempool_use_prealloc_only
Date:   Mon,  6 Nov 2023 21:10:23 +0100
Message-Id: <9752c5fc4763e7533a44a7c9368f056c47b52f34.1699297309.git.andreyknvl@google.com>
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Introduce a new mempool_use_prealloc_only API that tells the mempool to
only use the elements preallocated during the mempool's creation and to
not attempt allocating new ones.

This API is required to test the KASAN poisoning/unpoisoning functinality
in KASAN tests, but it might be also useful on its own.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/mempool.h |  2 ++
 mm/mempool.c            | 27 ++++++++++++++++++++++++---
 2 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 4aae6c06c5f2..822adf1e7567 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -18,6 +18,7 @@ typedef struct mempool_s {
 	int min_nr;		/* nr of elements at *elements */
 	int curr_nr;		/* Current nr of elements at *elements */
 	void **elements;
+	bool use_prealloc_only;	/* Use only preallocated elements */
 
 	void *pool_data;
 	mempool_alloc_t *alloc;
@@ -48,6 +49,7 @@ extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 			mempool_free_t *free_fn, void *pool_data,
 			gfp_t gfp_mask, int nid);
 
+extern void mempool_use_prealloc_only(mempool_t *pool);
 extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
diff --git a/mm/mempool.c b/mm/mempool.c
index f67ca6753332..59f7fcd355b3 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -365,6 +365,20 @@ int mempool_resize(mempool_t *pool, int new_min_nr)
 }
 EXPORT_SYMBOL(mempool_resize);
 
+/**
+ * mempool_use_prealloc_only - mark a pool to only use preallocated elements
+ * @pool:      pointer to the memory pool that should be marked
+ *
+ * This function should only be called right after the pool creation via
+ * mempool_init() or mempool_create() and must not be called concurrently with
+ * mempool_alloc().
+ */
+void mempool_use_prealloc_only(mempool_t *pool)
+{
+	pool->use_prealloc_only = true;
+}
+EXPORT_SYMBOL(mempool_use_prealloc_only);
+
 /**
  * mempool_alloc - allocate an element from a specific memory pool
  * @pool:      pointer to the memory pool which was allocated via
@@ -397,9 +411,11 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 
 repeat_alloc:
 
-	element = pool->alloc(gfp_temp, pool->pool_data);
-	if (likely(element != NULL))
-		return element;
+	if (!pool->use_prealloc_only) {
+		element = pool->alloc(gfp_temp, pool->pool_data);
+		if (likely(element != NULL))
+			return element;
+	}
 
 	spin_lock_irqsave(&pool->lock, flags);
 	if (likely(pool->curr_nr)) {
@@ -415,6 +431,11 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 		return element;
 	}
 
+	if (pool->use_prealloc_only) {
+		spin_unlock_irqrestore(&pool->lock, flags);
+		return NULL;
+	}
+
 	/*
 	 * We use gfp mask w/o direct reclaim or IO for the first round.  If
 	 * alloc failed with that and @pool was empty, retry immediately.
-- 
2.25.1

