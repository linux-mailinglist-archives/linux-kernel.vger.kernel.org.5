Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72F927D4C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbjJXJel (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:34:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjJXJeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:08 -0400
Received: from out-206.mta0.migadu.com (out-206.mta0.migadu.com [IPv6:2001:41d0:1004:224b::ce])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45085D7F
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:33:59 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mVsHpTi8/ybc90IBC2PUgLSTYbIjUF6GvQZHOJT0cXI=;
        b=WkSYYMuXGHeVTVvJKeEDkqylfQ5ISuw3VBdmhEEMq+LWy2qJeirb8he9LzRmfOp5qZ6+kT
        ZswKHPlHfUqDgf+oW4CzD+qBmu/0yksI5xZDpGRNHQHcev4VmDR1H8HChl9GYIrTSRecZo
        StPLjAgG42c97ebsxtS4Z+pyEQMwhsc=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 1/7] slub: Keep track of whether slub is on the per-node partial list
Date:   Tue, 24 Oct 2023 09:33:39 +0000
Message-Id: <20231024093345.3676493-2-chengming.zhou@linux.dev>
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

Now we rely on the "frozen" bit to see if we should manipulate the
slab->slab_list, which will be changed in the following patch.

Instead we introduce another way to keep track of whether slub is on
the per-node partial list, here we reuse the PG_workingset bit.

We use __set_bit and __clear_bit directly instead of the atomic version
for better performance and it's safe since it's protected by the slub
node list_lock.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slab.h | 19 +++++++++++++++++++
 mm/slub.c |  3 +++
 2 files changed, 22 insertions(+)

diff --git a/mm/slab.h b/mm/slab.h
index 8cd3294fedf5..50522b688cfb 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -193,6 +193,25 @@ static inline void __slab_clear_pfmemalloc(struct slab *slab)
 	__folio_clear_active(slab_folio(slab));
 }
 
+/*
+ * Slub reuse PG_workingset bit to keep track of whether it's on
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
 static inline void *slab_address(const struct slab *slab)
 {
 	return folio_address(slab_folio(slab));
diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..3fad4edca34b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2127,6 +2127,7 @@ __add_partial(struct kmem_cache_node *n, struct slab *slab, int tail)
 		list_add_tail(&slab->slab_list, &n->partial);
 	else
 		list_add(&slab->slab_list, &n->partial);
+	slab_set_node_partial(slab);
 }
 
 static inline void add_partial(struct kmem_cache_node *n,
@@ -2141,6 +2142,7 @@ static inline void remove_partial(struct kmem_cache_node *n,
 {
 	lockdep_assert_held(&n->list_lock);
 	list_del(&slab->slab_list);
+	slab_clear_node_partial(slab);
 	n->nr_partial--;
 }
 
@@ -4831,6 +4833,7 @@ static int __kmem_cache_do_shrink(struct kmem_cache *s)
 
 			if (free == slab->objects) {
 				list_move(&slab->slab_list, &discard);
+				slab_clear_node_partial(slab);
 				n->nr_partial--;
 				dec_slabs_node(s, node, slab->objects);
 			} else if (free <= SHRINK_PROMOTE_MAX)
-- 
2.40.1

