Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5317D1D8B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJUOoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjJUOoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:44:17 -0400
Received: from out-210.mta1.migadu.com (out-210.mta1.migadu.com [IPv6:2001:41d0:203:375::d2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBC0D7C
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:44:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697899451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fc6duZ/q+apDqgoP4cLzy3p5t8cD8/eKarQEAhD6cwA=;
        b=VwdHbGN6iqPqOPPmjkoCZCqeya5Wrnfy29DfCh17oso4mTQaIrjGQ/bBj7cuImP6Ak0ZDt
        74Ji4pLY0KWggdSHOhw8II53OTlr2K3tbgg2NViY04lO63dYbYrl8s/FsQ+pKx4DbOjdEG
        yYcnIac3YU/gH6s55G+958BKYZfu70Y=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, willy@infradead.org,
        pcc@google.com, tytso@mit.edu, maz@kernel.org,
        ruansy.fnst@fujitsu.com, vishal.moola@gmail.com,
        lrh2000@pku.edu.cn, hughd@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v2 3/6] slub: Don't freeze slabs for cpu partial
Date:   Sat, 21 Oct 2023 14:43:14 +0000
Message-Id: <20231021144317.3400916-4-chengming.zhou@linux.dev>
In-Reply-To: <20231021144317.3400916-1-chengming.zhou@linux.dev>
References: <20231021144317.3400916-1-chengming.zhou@linux.dev>
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
list, we can delay freeze to use slab freelist in ___slab_alloc(), so
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
now.

Note this patch just change the parts of moving the partial slabs for
easy code review, we will fix other parts in the following patches.
Specifically this patch change three paths:
1. get partial slab from node: get_partial_node()
2. put partial slab to node: __unfreeze_partials()
3. cache partail slab on cpu when __slab_free()

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 63 +++++++++++++++++--------------------------------------
 1 file changed, 19 insertions(+), 44 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index adeff8df85ec..61ee82ea21b6 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2277,7 +2277,9 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
 	struct slab *slab, *slab2;
 	void *object = NULL;
 	unsigned long flags;
+#ifdef CONFIG_SLUB_CPU_PARTIAL
 	unsigned int partial_slabs = 0;
+#endif
 
 	/*
 	 * Racy check. If we mistakenly see no partial slabs then we
@@ -2303,20 +2305,22 @@ static void *get_partial_node(struct kmem_cache *s, struct kmem_cache_node *n,
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
 #ifdef CONFIG_SLUB_CPU_PARTIAL
+		remove_partial(n, slab);
+		put_cpu_partial(s, slab, 0);
+		stat(s, CPU_PARTIAL_NODE);
+		partial_slabs++;
+
 		if (!kmem_cache_has_cpu_partial(s)
 			|| partial_slabs > s->cpu_partial_slabs / 2)
 			break;
@@ -2606,9 +2610,6 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 	unsigned long flags = 0;
 
 	while (partial_slab) {
-		struct slab new;
-		struct slab old;
-
 		slab = partial_slab;
 		partial_slab = slab->next;
 
@@ -2621,23 +2622,7 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
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
@@ -3634,18 +3619,8 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
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
@@ -3675,7 +3650,7 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
 			 * activity can be necessary.
 			 */
 			stat(s, FREE_FROZEN);
-		} else if (new.frozen) {
+		} else if (kmem_cache_has_cpu_partial(s) && !prior) {
 			/*
 			 * If we just froze the slab then put it onto the
 			 * per cpu partial list.
-- 
2.20.1

