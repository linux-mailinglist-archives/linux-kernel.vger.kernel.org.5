Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1887DCEFA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjJaOJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbjJaOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:08 -0400
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A73AE6
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:05 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GvFpTjudBUawLgUZhfA4XumfhFt8DHF3SUizR1gsSN0=;
        b=TXFp5ZrS2RLrdK40RbVab8YMC1O20QrLDJHbtWDv0h7N6MLbta00vjmZGm7DnKTG5RBgxq
        h6YdjNWfhUe2h4dCRzYErdTwo+9MGcYO5LIMetNw+He4mdD9iExl/e/+7gz+qY3n+fIq95
        TDslQnTghxmWva6tPEM6zC6/ZgI5/0A=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 2/9] slub: Change get_partial() interfaces to return slab
Date:   Tue, 31 Oct 2023 14:07:34 +0000
Message-Id: <20231031140741.79387-3-chengming.zhou@linux.dev>
In-Reply-To: <20231031140741.79387-1-chengming.zhou@linux.dev>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

We need all get_partial() related interfaces to return a slab, instead
of returning the freelist (or object).

Use the partial_context.object to return back freelist or object for
now. This patch shouldn't have any functional changes.

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 63 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 0b0fdc8c189f..03384cd965c5 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -204,9 +204,9 @@ DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 
 /* Structure holding parameters for get_partial() call chain */
 struct partial_context {
-	struct slab **slab;
 	gfp_t flags;
 	unsigned int orig_size;
+	void *object;
 };
 
 static inline bool kmem_cache_debug(struct kmem_cache *s)
@@ -2269,10 +2269,11 @@ static inline bool pfmemalloc_match(struct slab *slab, gfp_t gfpflags);
 /*
  * Try to allocate a partial slab from a specific node.
  */
-static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
-			      struct partial_context *pc)
+static struct slab *get_partial_node(struct kmem_cache *s,
+				     struct kmem_cache_node *n,
+				     struct partial_context *pc)
 {
-	struct slab *slab, *slab2;
+	struct slab *slab, *slab2, *partial = NULL;
 	void *object = NULL;
 	unsigned long flags;
 	unsigned int partial_slabs = 0;
@@ -2288,27 +2289,28 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 
 	spin_lock_irqsave(&n->list_lock, flags);
 	list_for_each_entry_safe(slab, slab2, &n->partial, slab_list) {
-		void *t;
-
 		if (!pfmemalloc_match(slab, pc->flags))
 			continue;
 
 		if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
 			object = alloc_single_from_partial(s, n, slab,
 							pc->orig_size);
-			if (object)
+			if (object) {
+				partial = slab;
+				pc->object = object;
 				break;
+			}
 			continue;
 		}
 
-		t = acquire_slab(s, n, slab, object == NULL);
-		if (!t)
+		object = acquire_slab(s, n, slab, object == NULL);
+		if (!object)
 			break;
 
-		if (!object) {
-			*pc->slab = slab;
+		if (!partial) {
+			partial = slab;
+			pc->object = object;
 			stat(s, ALLOC_FROM_PARTIAL);
-			object = t;
 		} else {
 			put_cpu_partial(s, slab, 0);
 			stat(s, CPU_PARTIAL_NODE);
@@ -2324,20 +2326,21 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 
 	}
 	spin_unlock_irqrestore(&n->list_lock, flags);
-	return object;
+	return partial;
 }
 
 /*
  * Get a slab from somewhere. Search in increasing NUMA distances.
  */
-static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
+static struct slab *get_any_partial(struct kmem_cache *s,
+				    struct partial_context *pc)
 {
 #ifdef CONFIG_NUMA
 	struct zonelist *zonelist;
 	struct zoneref *z;
 	struct zone *zone;
 	enum zone_type highest_zoneidx = gfp_zone(pc->flags);
-	void *object;
+	struct slab *slab;
 	unsigned int cpuset_mems_cookie;
 
 	/*
@@ -2372,8 +2375,8 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 
 			if (n && cpuset_zone_allowed(zone, pc->flags) &&
 					n->nr_partial > s->min_partial) {
-				object = get_partial_node(s, n, pc);
-				if (object) {
+				slab = get_partial_node(s, n, pc);
+				if (slab) {
 					/*
 					 * Don't check read_mems_allowed_retry()
 					 * here - if mems_allowed was updated in
@@ -2381,7 +2384,7 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 					 * between allocation and the cpuset
 					 * update
 					 */
-					return object;
+					return slab;
 				}
 			}
 		}
@@ -2393,17 +2396,18 @@ static void *get_any_partial(struct kmem_cache *s, struct partial_context *pc)
 /*
  * Get a partial slab, lock it and return it.
  */
-static void *get_partial(struct kmem_cache *s, int node, struct partial_context *pc)
+static struct slab *get_partial(struct kmem_cache *s, int node,
+				struct partial_context *pc)
 {
-	void *object;
+	struct slab *slab;
 	int searchnode = node;
 
 	if (node == NUMA_NO_NODE)
 		searchnode = numa_mem_id();
 
-	object = get_partial_node(s, get_node(s, searchnode), pc);
-	if (object || node != NUMA_NO_NODE)
-		return object;
+	slab = get_partial_node(s, get_node(s, searchnode), pc);
+	if (slab || node != NUMA_NO_NODE)
+		return slab;
 
 	return get_any_partial(s, pc);
 }
@@ -3213,10 +3217,10 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 new_objects:
 
 	pc.flags = gfpflags;
-	pc.slab = &slab;
 	pc.orig_size = orig_size;
-	freelist = get_partial(s, node, &pc);
-	if (freelist) {
+	slab = get_partial(s, node, &pc);
+	if (slab) {
+		freelist = pc.object;
 		if (kmem_cache_debug(s)) {
 			/*
 			 * For debug caches here we had to go through
@@ -3408,12 +3412,11 @@ static void *__slab_alloc_node(struct kmem_cache *s,
 	void *object;
 
 	pc.flags = gfpflags;
-	pc.slab = &slab;
 	pc.orig_size = orig_size;
-	object = get_partial(s, node, &pc);
+	slab = get_partial(s, node, &pc);
 
-	if (object)
-		return object;
+	if (slab)
+		return pc.object;
 
 	slab = new_slab(s, gfpflags, node);
 	if (unlikely(!slab)) {
-- 
2.20.1

