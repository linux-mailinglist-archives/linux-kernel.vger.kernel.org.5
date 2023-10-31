Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2CF97DCF28
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 15:27:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbjJaOJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 10:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJaOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 10:09:05 -0400
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [IPv6:2001:41d0:203:375::b3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA376C1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 07:09:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698761341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V/1IQ8DC4Ww2WANT0Yk1WGGMP6T1XolwvFVe/nWWtdo=;
        b=fWm3Ia9WLFuFmGWFVj3nkTO3KKIcArYI3sKwoNpxt4Vp+VSnp85jAdULf4fwS1xOUGBFRy
        qaL4xq+9jHvu/YO3QBypb2sb88cVvTthrSNRtZkaROqU8A7pGtYB9RLWsXKVwXBPAiXyCD
        wIoAlyBL54p89iiOAU9sfE8NjzIGnzM=
From:   chengming.zhou@linux.dev
To:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        willy@infradead.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, roman.gushchin@linux.dev,
        42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v4 1/9] slub: Reflow ___slab_alloc()
Date:   Tue, 31 Oct 2023 14:07:33 +0000
Message-Id: <20231031140741.79387-2-chengming.zhou@linux.dev>
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

The get_partial() interface used in ___slab_alloc() may return a single
object in the "kmem_cache_debug(s)" case, in which we will just return
the "freelist" object.

Move this handling up to prepare for later changes.

And the "pfmemalloc_match()" part is not needed for node partial slab,
since we already check this in the get_partial_node().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/slub.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 63d281dfacdb..0b0fdc8c189f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3216,8 +3216,21 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 	pc.slab = &slab;
 	pc.orig_size = orig_size;
 	freelist = get_partial(s, node, &pc);
-	if (freelist)
-		goto check_new_slab;
+	if (freelist) {
+		if (kmem_cache_debug(s)) {
+			/*
+			 * For debug caches here we had to go through
+			 * alloc_single_from_partial() so just store the
+			 * tracking info and return the object.
+			 */
+			if (s->flags & SLAB_STORE_USER)
+				set_track(s, freelist, TRACK_ALLOC, addr);
+
+			return freelist;
+		}
+
+		goto retry_load_slab;
+	}
 
 	slub_put_cpu_ptr(s->cpu_slab);
 	slab = new_slab(s, gfpflags, node);
@@ -3253,20 +3266,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
 	inc_slabs_node(s, slab_nid(slab), slab->objects);
 
-check_new_slab:
-
-	if (kmem_cache_debug(s)) {
-		/*
-		 * For debug caches here we had to go through
-		 * alloc_single_from_partial() so just store the tracking info
-		 * and return the object
-		 */
-		if (s->flags & SLAB_STORE_USER)
-			set_track(s, freelist, TRACK_ALLOC, addr);
-
-		return freelist;
-	}
-
 	if (unlikely(!pfmemalloc_match(slab, gfpflags))) {
 		/*
 		 * For !pfmemalloc_match() case we don't load freelist so that
-- 
2.20.1

