Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D72AC7CC7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344272AbjJQPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjJQPpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:34 -0400
Received: from out-203.mta1.migadu.com (out-203.mta1.migadu.com [95.215.58.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745610D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwVUZ0CSOlUV0/uHFVqKY/DwonXk9nrbYMCg7m1DgMw=;
        b=QTQRTtR4TDMx815F2FxWR0MO4r4tizfmzdquqGgIm6079a5vKw/+Kv5swHYxfc+xr4bwXq
        Qc4wl110RF7gV0nbPrV0c1kK94qUoAu4HC34L59IfxeRumqBLP9gWTX7ryMGjzSz0nXUJR
        3HtIn99NiO2gQzsXZGKH13+VO/pQ1ig=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 4/5] slub: Don't freeze slabs for cpu partial
Date:   Tue, 17 Oct 2023 15:44:38 +0000
Message-Id: <20231017154439.3036608-5-chengming.zhou@linux.dev>
In-Reply-To: <20231017154439.3036608-1-chengming.zhou@linux.dev>
References: <20231017154439.3036608-1-chengming.zhou@linux.dev>
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
list, we can delay freeze to get slab freelist in ___slab_alloc(), so
we can save one cmpxchg_double().

And there are other good points:

1. The moving of slabs between node partial list and cpu partial list
   becomes simpler, since we don't need to freeze or unfreeze at all.

2. The node list_lock contention would be less, since we only need to
   freeze one slab under the node list_lock. (In fact, we can first
   move slabs out of node partial list, don't need to freeze any slab
   at all, so the contention on slab won't transfer to the node list_lock
   contention.)

We can achieve this because there is no concurrent path would manipulate
the partial slab list except the __slab_free() path, which is serialized
using the new introduced slab->flags.

Note this patch just change the part of moving the partial slabs for
easy code review, we will fix other parts in the following patches.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 61 ++++++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 44 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 5a9711b35c74..044235bd8a45 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2329,19 +2329,21 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 			continue;
 		}
 
-		t = acquire_slab(s, n, slab, object == NULL);
-		if (!t)
-			break;
-
 		if (!object) {
-			*pc->slab = slab;
-			stat(s, ALLOC_FROM_PARTIAL);
-			object = t;
-		} else {
-			put_cpu_partial(s, slab, 0);
-			stat(s, CPU_PARTIAL_NODE);
-			partial_slabs++;
+			t = acquire_slab(s, n, slab, object == NULL);
+			if (t) {
+				*pc->slab = slab;
+				stat(s, ALLOC_FROM_PARTIAL);
+				object = t;
+				continue;
+			}
 		}
+
+		remove_partial(n, slab);
+		put_cpu_partial(s, slab, 0);
+		stat(s, CPU_PARTIAL_NODE);
+		partial_slabs++;
+
 #ifdef CONFIG_SLUB_CPU_PARTIAL
 		if (!kmem_cache_has_cpu_partial(s)
 			|| partial_slabs > s->cpu_partial_slabs / 2)
@@ -2612,9 +2614,6 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 	unsigned long flags = 0;
 
 	while (partial_slab) {
-		struct slab new;
-		struct slab old;
-
 		slab = partial_slab;
 		partial_slab = slab->next;
 
@@ -2627,23 +2626,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
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
@@ -3640,18 +3623,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
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
@@ -3681,7 +3654,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (new.frozen) {
+		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
 			/*
 			 * If we just froze the slab then put it onto the
 			 * per cpu partial list.
-- 
2.40.1

