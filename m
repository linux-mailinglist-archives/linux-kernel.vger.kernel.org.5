Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C547D4CCF
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 11:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjJXJoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 05:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234547AbjJXJeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 05:34:09 -0400
Received: from out-191.mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF0610F6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 02:34:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698140042;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nZerFoAj8INaI6ZSxOyjE3BeTDGPig5MeJKjJh1pMQ8=;
        b=V5gwmpkG8243Dq0GOsqzdIUFu+jgwdS+wsU2S/1oNpANH7Jiro5jaQ+wSigcoAXTIwUHR0
        tz233Wke1fEJVMWATf22pDzMl0BDfdcprGotQ76eoP2bW65VEb0nau30v/bz1ONYQ7C1iq
        uidyW/b1k2Vm8H6knFM73iZoGZXo8uc=
From:   chengming.zhou@linux.dev
To:     cl@linux.com, penberg@kernel.org
Cc:     rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, chengming.zhou@linux.dev,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [RFC PATCH v3 3/7] slub: Reflow ___slab_alloc()
Date:   Tue, 24 Oct 2023 09:33:41 +0000
Message-Id: <20231024093345.3676493-4-chengming.zhou@linux.dev>
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

The get_partial() interface used in ___slab_alloc() may return a single
object in the "kmem_cache_debug(s)" case, in which we will just return
the "freelist" object.

Move this handling up to prepare for later changes.

And the "pfmemalloc_match()" part is not needed for node partial slab,
since we already check this in the get_partial_node().

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 mm/slub.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index f568a32d7332..cd8aa68c156e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -3218,8 +3218,21 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
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
@@ -3255,20 +3268,6 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
 
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
2.40.1

