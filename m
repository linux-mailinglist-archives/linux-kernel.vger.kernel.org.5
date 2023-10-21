Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89B897D1D8A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjJUOoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjJUOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:44:00 -0400
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [IPv6:2001:41d0:203:375::c4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA95C0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:43:57 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697899435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=McUlAOC6AXMF3DQxwjxFsXChYXBELSqYw7TfeM0+yv0=;
        b=U7c03tZf2fCoW5T3wE2WN887d5Ut/z0dqbsdzuHPFwfuTnJjKkXIqgu1qkz/ZM1D7dvN/0
        +t0ZPZQ04YUwljOgsVlPl0zjwouHH5C+41xLj3a5pQygz/jzSeLcr3C5ImZ/LyIGOBMkuM
        Zx55Qopachdrboij0Lf1+nGLH57UfVI=
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
Subject: [RFC PATCH v2 1/6] slub: Keep track of whether slub is on the per-node partial list
Date:   Sat, 21 Oct 2023 14:43:12 +0000
Message-Id: <20231021144317.3400916-2-chengming.zhou@linux.dev>
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

Now we rely on the "frozen" bit to see if we should manipulate the
slab->slab_list, which will be changed in the following patch.

Instead we introduce another way to keep track of whether slub is on
the per-node partial list, here we reuse the PG_workingset bit.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 include/linux/page-flags.h |  2 ++
 mm/slab.h                  | 19 +++++++++++++++++++
 mm/slub.c                  |  3 +++
 3 files changed, 24 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index a88e64acebfe..e8b1be71d722 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -478,6 +478,8 @@ PAGEFLAG(Active, active, PF_HEAD) __CLEARPAGEFLAG(Active, active, PF_HEAD)
 	TESTCLEARFLAG(Active, active, PF_HEAD)
 PAGEFLAG(Workingset, workingset, PF_HEAD)
 	TESTCLEARFLAG(Workingset, workingset, PF_HEAD)
+	__SETPAGEFLAG(Workingset, workingset, PF_HEAD)
+	__CLEARPAGEFLAG(Workingset, workingset, PF_HEAD)
 __PAGEFLAG(Slab, slab, PF_NO_TAIL)
 PAGEFLAG(Checked, checked, PF_NO_COMPOUND)	   /* Used by some filesystems */
 
diff --git a/mm/slab.h b/mm/slab.h
index 8cd3294fedf5..9cff64cae8de 100644
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
+	__folio_set_workingset(slab_folio(slab));
+}
+
+static inline void slab_clear_node_partial(struct slab *slab)
+{
+	__folio_clear_workingset(slab_folio(slab));
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
2.20.1

