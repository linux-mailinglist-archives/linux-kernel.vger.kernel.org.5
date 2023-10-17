Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523927CC7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbjJQPps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344158AbjJQPpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:35 -0400
Received: from out-205.mta1.migadu.com (out-205.mta1.migadu.com [IPv6:2001:41d0:203:375::cd])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA56119
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/rqGINGA/f9CjHGz6bcXHgniUddOArpzlJ7hGX+P1rU=;
        b=t7itMpfWMoYVC3j6sv4EJs1ydOPU1zP3XISTj8W27fYulJ37dQyEN+Pa322OfNaStXpJZV
        36vAPklwKga0vw8d+1eVptg8XqL89bkZHme5rmr/8afd3FtJyx000aND1uE1U0lpxztDa8
        d7+B+Qhwf+dLLjvv182AjauHrt2yObw=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 5/5] slub: Introduce get_cpu_partial()
Date:   Tue, 17 Oct 2023 15:44:39 +0000
Message-Id: <20231017154439.3036608-6-chengming.zhou@linux.dev>
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

Since the slabs on cpu partial list are not frozen anymore, we introduce
get_cpu_partial() to get a frozen slab with its freelist from cpu partial
list. It's now much like getting a frozen slab with its freelist from
node partial list.

Another change is about get_partial(), which can return no frozen slab
when all slabs are failed when acquire_slab(), but get some unfreeze slabs
in its cpu partial list, so we need to check this rare case to avoid
allocating a new slab.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 87 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 68 insertions(+), 19 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 044235bd8a45..d58eaf8447fd 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3064,6 +3064,68 @@ static inline void *get_freelist(struct kmem_cache *s, struct slab *slab)
 	return freelist;
 }
 
+#ifdef CONFIG_SLUB_CPU_PARTIAL
+
+static void *get_cpu_partial(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			     struct slab **slabptr, int node, gfp_t gfpflags)
+{
+	unsigned long flags;
+	struct slab *slab;
+	struct slab new;
+	unsigned long counters;
+	void *freelist;
+
+	while (slub_percpu_partial(c)) {
+		local_lock_irqsave(&s->cpu_slab->lock, flags);
+		if (unlikely(!slub_percpu_partial(c))) {
+			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+			/* we were preempted and partial list got empty */
+			return NULL;
+		}
+
+		slab = slub_percpu_partial(c);
+		slub_set_percpu_partial(c, slab);
+		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
+		stat(s, CPU_PARTIAL_ALLOC);
+
+		if (unlikely(!node_match(slab, node) ||
+			     !pfmemalloc_match(slab, gfpflags))) {
+			slab->next = NULL;
+			__unfreeze_partials(s, slab);
+			continue;
+		}
+
+		do {
+			freelist = slab->freelist;
+			counters = slab->counters;
+
+			new.counters = counters;
+			VM_BUG_ON(new.frozen);
+
+			new.inuse = slab->objects;
+			new.frozen = 1;
+		} while (!__slab_update_freelist(s, slab,
+			freelist, counters,
+			NULL, new.counters,
+			"get_cpu_partial"));
+
+		*slabptr = slab;
+		return freelist;
+	}
+
+	return NULL;
+}
+
+#else /* CONFIG_SLUB_CPU_PARTIAL */
+
+static void *get_cpu_partial(struct kmem_cache *s, struct kmem_cache_cpu *c,
+			     struct slab **slabptr, int node, gfp_t gfpflags)
+{
+	return NULL;
+}
+
+#endif
+
 /*
  * Slow path. The lockless freelist is empty or we need to perform
  * debugging duties.
@@ -3106,7 +3168,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 			node = NUMA_NO_NODE;
 		goto new_slab;
 	}
-redo:
 
 	if (unlikely(!node_match(slab, node))) {
 		/*
@@ -3182,24 +3243,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 new_slab:
 
-	if (slub_percpu_partial(c)) {
-		local_lock_irqsave(&s->cpu_slab->lock, flags);
-		if (unlikely(c->slab)) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-			goto reread_slab;
-		}
-		if (unlikely(!slub_percpu_partial(c))) {
-			local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-			/* we were preempted and partial list got empty */
-			goto new_objects;
-		}
-
-		slab = c->slab = slub_percpu_partial(c);
-		slub_set_percpu_partial(c, slab);
-		local_unlock_irqrestore(&s->cpu_slab->lock, flags);
-		stat(s, CPU_PARTIAL_ALLOC);
-		goto redo;
-	}
+	freelist = get_cpu_partial(s, c, &slab, node, gfpflags);
+	if (freelist)
+		goto retry_load_slab;
 
 new_objects:
 
@@ -3210,6 +3256,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	if (freelist)
 		goto check_new_slab;
 
+	if (slub_percpu_partial(c))
+		goto new_slab;
+
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, gfpflags, node);
 	c = slub_get_cpu_ptr(s->cpu_slab);
-- 
2.40.1

