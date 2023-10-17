Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E67D27CC7BF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344129AbjJQPpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjJQPpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:45:22 -0400
Received: from out-206.mta1.migadu.com (out-206.mta1.migadu.com [95.215.58.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E173095
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 08:45:20 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697557519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=k+bY4oHxBRtJWcNO+Gp7uU0LbPEc1T0Re1GRoZLORj4=;
        b=CcmfhoGdDV5iQ65rv3mmqcXetcW5trAeYkwUs1YW3F3rWasU7mQ1KysL674T5DLYaL+6bY
        hvlmkEqgAGs6ijxn+CaFmKHMdHwEHXZOjokAKPisHp+6bsfBg24xWmR06X5Sv+xRkXOR31
        /Kyv+0b/9DHODnwMzhKPyqiEic4J/bc=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH 1/5] slub: Introduce on_partial()
Date:   Tue, 17 Oct 2023 15:44:35 +0000
Message-Id: <20231017154439.3036608-2-chengming.zhou@linux.dev>
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

We change slab->__unused to slab->flags to use it as SLUB_FLAGS, which
now only include SF_NODE_PARTIAL flag. It indicates whether or not the
slab is on node partial list.

The following patches will change to don't freeze slab when moving it
from node partial list to cpu partial list. So we can't rely on frozen
bit to see if we should manipulate the slab->slab_list.

Instead we will rely on this SF_NODE_PARTIAL flag, which is protected
by node list_lock.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slab.h |  2 +-
 mm/slub.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/mm/slab.h b/mm/slab.h
index 8cd3294fedf5..11e9c9a0f648 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -89,7 +89,7 @@ struct slab {
 		};
 		struct rcu_head rcu_head;
 	};
-	unsigned int __unused;
+	unsigned int flags;
 
 #else
 #error "Unexpected slab allocator configured"
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..e5356ad14951 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1993,6 +1993,12 @@ static inline bool shuffle_freelist(struct kmem_cache *s, struct slab *slab)
 }
 #endif /* CONFIG_SLAB_FREELIST_RANDOM */
 
+enum SLUB_FLAGS {
+	SF_INIT_VALUE = 0,
+	SF_EXIT_VALUE = -1,
+	SF_NODE_PARTIAL = 1 << 0,
+};
+
 static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 {
 	struct slab *slab;
@@ -2031,6 +2037,7 @@ static struct slab *allocate_slab(struct kmem_cache *s, gfp_t flags, int node)
 	slab->objects = oo_objects(oo);
 	slab->inuse = 0;
 	slab->frozen = 0;
+	slab->flags = SF_INIT_VALUE;
 
 	account_slab(slab, oo_order(oo), s, flags);
 
@@ -2077,6 +2084,7 @@ static void __free_slab(struct kmem_cache *s, struct slab *slab)
 	int order = folio_order(folio);
 	int pages = 1 << order;
 
+	slab->flags = SF_EXIT_VALUE;
 	__slab_clear_pfmemalloc(slab);
 	folio->mapping = NULL;
 	/* Make the mapping reset visible before clearing the flag */
@@ -2119,9 +2127,28 @@ static void discard_slab(struct kmem_cache *s, struct slab *slab)
 /*
  * Management of partially allocated slabs.
  */
+static void ___add_partial(struct kmem_cache_node *n, struct slab *slab)
+{
+	lockdep_assert_held(&n->list_lock);
+	slab->flags |= SF_NODE_PARTIAL;
+}
+
+static void ___remove_partial(struct kmem_cache_node *n, struct slab *slab)
+{
+	lockdep_assert_held(&n->list_lock);
+	slab->flags &= ~SF_NODE_PARTIAL;
+}
+
+static inline bool on_partial(struct kmem_cache_node *n, struct slab *slab)
+{
+	lockdep_assert_held(&n->list_lock);
+	return slab->flags & SF_NODE_PARTIAL;
+}
+
 static inline void
 __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
 {
+	___add_partial(n, slab);
 	n->nr_partial++;
 	if (tail == DEACTIVATE_TO_TAIL)
 		list_add_tail(&slab->slab_list, &n->partial);
@@ -2142,6 +2169,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 	lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
 	n->nr_partial--;
+	___remove_partial(n, slab);
 }
 
 /*
-- 
2.40.1

