Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8E37DEB4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 04:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348388AbjKBDY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 23:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348366AbjKBDYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 23:24:52 -0400
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B6D120
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 20:24:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698895487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IPS3iWC0ordY9Z/gFrasLVfoOU0ee6NMzPFkJtmjEdA=;
        b=v1GKoBc/GWi/6wA+3MMyQ6L15tftj7e2VTfNMKRmvlXo85TA0YUcUSnVVJ8Kga11asCboO
        btJ3b5nOE+cya1I08GWukxT+lICauUTNrau2aealf4F9CdmRScWkmlPsoHeV6UcabxAXZx
        LYjHaUg928T27sxO5LCHMigYm2gu+Xw=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v5 3/9] slub: Keep track of whether slub is on the per-node partial list
Date:   Thu,  2 Nov 2023 03:23:24 +0000
Message-Id: <20231102032330.1036151-4-chengming.zhou@linux.dev>
In-Reply-To: <20231102032330.1036151-1-chengming.zhou@linux.dev>
References: <20231102032330.1036151-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

Now we rely on the "frozen" bit to see if we should manipulate the
slab->slab_list, which will be changed in the following patch.

Instead we introduce another way to keep track of whether slub is on
the per-node partial list, here we reuse the PG_workingset bit.

We use __set_bit and __clear_bit directly instead of the atomic version
for better performance and it's safe since it's protected by the slub
node list_lock.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Tested-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
---
 mm/slub.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/slub.c b/mm/slub.c
index 03384cd965c5..eed8ae0dbaf9 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2116,6 +2116,25 @@ static void discard_slab(struct kmem_cache *s, struct slab *slab)
 	free_slab(s, slab);
 }
 
+/*
+ * SLUB reuses PG_workingset bit to keep track of whether it's on
+ * the per-node partial list.
+ */
+static inline bool slab_test_node_partial(const struct slab *slab)
+{
+	return folio_test_workingset((struct folio *)slab_folio(slab));
+}
+
+static inline void slab_set_node_partial(struct slab *slab)
+{
+	__set_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
+}
+
+static inline void slab_clear_node_partial(struct slab *slab)
+{
+	__clear_bit(PG_workingset, folio_flags(slab_folio(slab), 0));
+}
+
 /*
  * Management of partially allocated slabs.
  */
@@ -2127,6 +2146,7 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
 		list_add_tail(&slab->slab_list, &n->partial);
 	else
 		list_add(&slab->slab_list, &n->partial);
+	slab_set_node_partial(slab);
 }
 
 static inline void add_partial(struct kmem_cache_node *n,
@@ -2141,6 +2161,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 {
 	lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
+	slab_clear_node_partial(slab);
 	n->nr_partial--;
 }
 
@@ -4833,6 +4854,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 
 			if (free == slab->objects) {
 				list_move(&slab->slab_list, &discard);
+				slab_clear_node_partial(slab);
 				n->nr_partial--;
 				dec_slabs_node(s, node, slab->objects);
 			} else if (free <= SHRINK_PROMOTE_MAX)
-- 
2.20.1

