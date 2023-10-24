Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA497D4C91
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234312AbjJXJe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234563AbjJXJeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:12 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C441706
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:34:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1189G8OwJQsHaUqQ7omEWGXJiWlZJSsRqA7qcxA5H0E=;
        b=Y7iQvWYnYomwhH9HpqqMB6QnGTBOBbLrimV35vPGob+QAc/EDk42XtH9Qiw36iRppPZAfY
        nbCKMQcN9UNCzVRzFAAYL7APDUqtxspLiF8pMGCAFass0h7cocBOURvFszr/QxFy9Eav/T
        md+C1DNGHg5ckM7dyaawphlNjCc6pmI=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 6/7] slub: Delay freezing of partial slabs
Date:   Tue, 24 Oct 2023 09:33:44 +0000
Message-Id: <20231024093345.3676493-7-chengming.zhou@linux.dev>
In-Reply-To: <20231024093345.3676493-1-chengming.zhou@linux.dev>
References: <20231024093345.3676493-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

Now we will freeze slabs when moving them out of node partial list to
cpu partial list, this method needs two cmpxchg_double operations:

1. freeze slab (acquire_slab()) under the node list_lock
2. get_freelist() when pick used in ___slab_alloc()

Actually we don't need to freeze when moving slabs out of node partial
list, we can delay freezing to when use slab freelist in ___slab_alloc(),
so we can save one cmpxchg_double().

And there are other good points:
 - The moving of slabs between node partial list and cpu partial list
   becomes simpler, since we don't need to freeze or unfreeze at all.

 - The node list_lock contention would be less, since we don't need to
   freeze any slab under the node list_lock.

We can achieve this because there is no concurrent path would manipulate
the partial slab list except the __slab_free() path, which is serialized
now.

Since the slab returned by get_partial() interfaces is not frozen anymore
and no freelist in the partial_context, so we need to use the introduced
freeze_slab() to freeze it and get its freelist.

Similarly, the slabs on the CPU partial list are not frozen anymore,
we need to freeze_slab() on it before use.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 111 +++++++++++-------------------------------------------
 1 file changed, 21 insertions(+), 90 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5b428648021f..486d44421432 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2215,51 +2215,6 @@ static void *alloc_single_from_new_slab(struct kmem_cache *s,
 	return object;
 }
 
-/*
- * Remove slab from the partial list, freeze it and
- * return the pointer to the freelist.
- *
- * Returns a list of objects or NULL if it fails.
- */
-static inline void *acquire_slab(struct kmem_cache *s,
-		struct kmem_cache_node *n, struct slab *slab,
-		int mode)
-{
-	void *freelist;
-	unsigned long counters;
-	struct slab new;
-
-	lockdep_assert_held(&n->list_lock);
-
-	/*
-	 * Zap the freelist and set the frozen bit.
-	 * The old freelist is the list of objects for the
-	 * per cpu allocation list.
-	 */
-	freelist = slab->freelist;
-	counters = slab->counters;
-	new.counters = counters;
-	if (mode) {
-		new.inuse = slab->objects;
-		new.freelist = NULL;
-	} else {
-		new.freelist = freelist;
-	}
-
-	VM_BUG_ON(new.frozen);
-	new.frozen = 1;
-
-	if (!__slab_update_freelist(s, slab,
-			freelist, counters,
-			new.freelist, new.counters,
-			"acquire_slab"))
-		return NULL;
-
-	remove_partial(n, slab);
-	WARN_ON(!freelist);
-	return freelist;
-}
-
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain);
 #else
@@ -2276,7 +2231,6 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 				     struct partial_context *pc)
 {
 	struct slab *slab, *slab2, *partial = NULL;
-	void *object = NULL;
 	unsigned long flags;
 	unsigned int partial_slabs = 0;
 
@@ -2295,7 +2249,7 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 			continue;
 
 		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
-			object = alloc_single_from_partial(s, n, slab,
+			void *object = alloc_single_from_partial(s, n, slab,
 							pc->orig_size);
 			if (object) {
 				partial = slab;
@@ -2305,13 +2259,10 @@ static struct slab *get_partial_node(struct kmem_cache *s,
 			continue;
 		}
 
-		object = acquire_slab(s, n, slab, object == NULL);
-		if (!object)
-			break;
+		remove_partial(n, slab);
 
 		if (!partial) {
 			partial = slab;
-			pc->object = object;
 			stat(s, ALLOC_FROM_PARTIAL);
 		} else {
 			put_cpu_partial(s, slab, 0);
@@ -2610,9 +2561,6 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 	unsigned long flags = 0;
 
 	while (partial_slab) {
-		struct slab new;
-		struct slab old;
-
 		slab = partial_slab;
 		partial_slab = slab->next;
 
@@ -2625,23 +2573,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 			spin_lock_irqsave(&n->list_lock, flags);
 		}
 
-		do {
-
-			old.freelist = slab->freelist;
-			old.counters = slab->counters;
-			VM_BUG_ON(!old.frozen);
-
-			new.counters = old.counters;
-			new.freelist = old.freelist;
-
-			new.frozen = 0;
-
-		} while (!__slab_update_freelist(s, slab,
-				old.freelist, old.counters,
-				new.freelist, new.counters,
-				"unfreezing slab"));
-
-		if (unlikely(!new.inuse && n->nr_partial >= s->min_partial)) {
+		if (unlikely(!slab->inuse && n->nr_partial >= s->min_partial)) {
 			slab->next = slab_to_discard;
 			slab_to_discard = slab;
 		} else {
@@ -3148,7 +3080,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			node = NUMA_NO_NODE;
 		goto new_slab;
 	}
-redo:
 
 	if (unlikely(!node_match(slab, node))) {
 		/*
@@ -3224,7 +3155,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_slab:
 
-	if (slub_percpu_partial(c)) {
+	while (slub_percpu_partial(c)) {
 		local_lock_irqsave(&s->cpu_slab->lock, flags);
 		if (unlikely(c->slab)) {
 			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
@@ -3236,11 +3167,20 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			goto new_objects;
 		}
 
-		slab = c->slab = slub_percpu_partial(c);
+		slab = slub_percpu_partial(c);
 		slub_set_percpu_partial(c, slab);
 		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 		stat(s, CPU_PARTIAL_ALLOC);
-		goto redo;
+
+		if (unlikely(!node_match(slab, node) ||
+			     !pfmemalloc_match(slab, gfpflags))) {
+			slab->next = NULL;
+			__unfreeze_partials(s, slab);
+			continue;
+		}
+
+		freelist = freeze_slab(s, slab);
+		goto retry_load_slab;
 	}
 
 new_objects:
@@ -3249,8 +3189,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.orig_size = orig_size;
 	slab = get_partial(s, node, &pc);
 	if (slab) {
-		freelist = pc.object;
 		if (kmem_cache_debug(s)) {
+			freelist = pc.object;
 			/*
 			 * For debug caches here we had to go through
 			 * alloc_single_from_partial() so just store the
@@ -3262,6 +3202,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			return freelist;
 		}
 
+		freelist = freeze_slab(s, slab);
 		goto retry_load_slab;
 	}
 
@@ -3663,18 +3604,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 		was_frozen = new.frozen;
 		new.inuse -= cnt;
 		if ((!new.inuse || !prior) && !was_frozen) {
-
-			if (kmem_cache_has_cpu_partial(s) && !prior) {
-
-				/*
-				 * Slab was on no list before and will be
-				 * partially empty
-				 * We can defer the list move and instead
-				 * freeze it.
-				 */
-				new.frozen = 1;
-
-			} else { /* Needs to be taken off a list */
+			/* Needs to be taken off a list */
+			if (!kmem_cache_has_cpu_partial(s) || prior) {
 
 				n = get_node(s, slab_nid(slab));
 				/*
@@ -3704,9 +3635,9 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (new.frozen) {
+		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
 			/*
-			 * If we just froze the slab then put it onto the
+			 * If we started with a full slab then put it onto the
 			 * per cpu partial list.
 			 */
 			put_cpu_partial(s, slab, 1);
-- 
2.40.1

