Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A007DCF14
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbjJaOJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjJaOJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:25 -0400
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79B9121
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNirFUhouaQ2FdRmy2RjQgkCONe7ugTNtD0fPI9SkvQ=;
        b=r1MiH4vM84Jj3nwHog6emae9i1zx3YqzKMYp0IBEloU7g/8tB45Y1H9zMFiMKQbkD/H0Qe
        VuvBkAF8ea4irChfcbAhAq0tXL092g71ipfL7eKZwrga14ekhl47LZcRSrMGn4jQOfzSeP
        bhCSvGRNAWF820iIR0MuX+4oZgKIP/E=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 8/9] slub: Rename all *unfreeze_partials* functions to *put_partials*
Date:   Tue, 31 Oct 2023 14:07:40 +0000
Message-Id: <20231031140741.79387-9-chengming.zhou@linux.dev>
In-Reply-To: <20231031140741.79387-1-chengming.zhou@linux.dev>
References: <20231031140741.79387-1-chengming.zhou@linux.dev>
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

From: Chengming Zhou <zhouchengming@bytedance.com>

Since all partial slabs on the CPU partial list are not frozen anymore,
we don't unfreeze when moving cpu partial slabs to node partial list,
it's better to rename these functions.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index c429f8baba5f..bb7368047103 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2549,7 +2549,7 @@ static void deactivate_slab(struct kmem_cache *s, struct slab *slab,
 }
 
 #ifdef CONFIG_SLUB_CPU_PARTIAL
-static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
+static void put_partials_node(struct kmem_cache *s, struct slab *partial_slab)
 {
 	struct kmem_cache_node *n = NULL, *n2 = NULL;
 	struct slab *slab, *slab_to_discard = NULL;
@@ -2591,9 +2591,9 @@ static void __unfreeze_partials(struct kmem_cache *s, struct slab *partial_slab)
 }
 
 /*
- * Unfreeze all the cpu partial slabs.
+ * Put all the cpu partial slabs to the node partial list.
  */
-static void unfreeze_partials(struct kmem_cache *s)
+static void put_partials(struct kmem_cache *s)
 {
 	struct slab *partial_slab;
 	unsigned long flags;
@@ -2604,11 +2604,11 @@ static void unfreeze_partials(struct kmem_cache *s)
 	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
 	if (partial_slab)
-		__unfreeze_partials(s, partial_slab);
+		put_partials_node(s, partial_slab);
 }
 
-static void unfreeze_partials_cpu(struct kmem_cache *s,
-				  struct kmem_cache_cpu *c)
+static void put_partials_cpu(struct kmem_cache *s,
+			     struct kmem_cache_cpu *c)
 {
 	struct slab *partial_slab;
 
@@ -2616,7 +2616,7 @@ static void unfreeze_partials_cpu(struct kmem_cache *s,
 	c->partial = NULL;
 
 	if (partial_slab)
-		__unfreeze_partials(s, partial_slab);
+		put_partials_node(s, partial_slab);
 }
 
 /*
@@ -2629,7 +2629,7 @@ static void unfreeze_partials_cpu(struct kmem_cache *s,
 static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 {
 	struct slab *oldslab;
-	struct slab *slab_to_unfreeze = NULL;
+	struct slab *slab_to_put = NULL;
 	unsigned long flags;
 	int slabs = 0;
 
@@ -2644,7 +2644,7 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 			 * per node partial list. Postpone the actual unfreezing
 			 * outside of the critical section.
 			 */
-			slab_to_unfreeze = oldslab;
+			slab_to_put = oldslab;
 			oldslab = NULL;
 		} else {
 			slabs = oldslab->slabs;
@@ -2660,17 +2660,17 @@ static void put_cpu_partial(struct kmem_cache *s, struct slab *slab, int drain)
 
 	local_unlock_irqrestore(&s->cpu_slab->lock, flags);
 
-	if (slab_to_unfreeze) {
-		__unfreeze_partials(s, slab_to_unfreeze);
+	if (slab_to_put) {
+		put_partials_node(s, slab_to_put);
 		stat(s, CPU_PARTIAL_DRAIN);
 	}
 }
 
 #else	/* CONFIG_SLUB_CPU_PARTIAL */
 
-static inline void unfreeze_partials(struct kmem_cache *s) { }
-static inline void unfreeze_partials_cpu(struct kmem_cache *s,
-				  struct kmem_cache_cpu *c) { }
+static inline void put_partials(struct kmem_cache *s) { }
+static inline void put_partials_cpu(struct kmem_cache *s,
+				    struct kmem_cache_cpu *c) { }
 
 #endif	/* CONFIG_SLUB_CPU_PARTIAL */
 
@@ -2712,7 +2712,7 @@ static inline void __flush_cpu_slab(struct kmem_cache *s, int cpu)
 		stat(s, CPUSLAB_FLUSH);
 	}
 
-	unfreeze_partials_cpu(s, c);
+	put_partials_cpu(s, c);
 }
 
 struct slub_flush_work {
@@ -2740,7 +2740,7 @@ static void flush_cpu_slab(struct work_struct *w)
 	if (c->slab)
 		flush_slab(s, c);
 
-	unfreeze_partials(s);
+	put_partials(s);
 }
 
 static bool has_cpu_slab(int cpu, struct kmem_cache *s)
@@ -3171,7 +3171,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 		if (unlikely(!node_match(slab, node) ||
 			     !pfmemalloc_match(slab, gfpflags))) {
 			slab->next = NULL;
-			__unfreeze_partials(s, slab);
+			put_partials_node(s, slab);
 			continue;
 		}
 
-- 
2.20.1

