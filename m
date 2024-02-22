Return-Path: <linux-kernel+bounces-76556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA8A85F919
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDC8F1C22A7A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96412EBDC;
	Thu, 22 Feb 2024 13:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fOrUDGkk"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2315812E1EB
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606991; cv=none; b=ZFrDV0rBTfMHh2lWgQvkMtkP6HGF6cUuGww1mH5XttesT/7U46BwKPUM8fQMvQsCGZ5fmx5aJKtk0MZls7qXBuqC0OlkGqr+unVazEDZtNI8R1a869H1axDaTjsq/0IAOVuCLF45QDAcGYTrITHs5jfMgGAL5g0RQr6tQOpyKdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606991; c=relaxed/simple;
	bh=EjE7mXBdc338IIDo0nEmWwYag2fsZw52u8AZJ06oaSw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lKgmZg5S6hZRo10MYl4ncO99HIA/ZpbEsjB/f7rEYeHu5KrCsTPmeqPmTX7dVDmdpybljOXFprckcfeg1/DSY8tsLkEtXvGUnh5qPvf80E6fMCPmd3sDjtsj0Zj+khm/psC+Ts6xZHu+SM7WGjGTPmv6rkOEuXdJei9s+kwRBiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fOrUDGkk; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708606985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=IDulxroE9ikP839kUNCu1ABivghSCv1a1QMz7sde4n4=;
	b=fOrUDGkk1lp2vm3txHxBJ5StMHBBYoXpFBOz2bCJg65nm+ucWy3mlMyi4W0RPaFF7wtx5U
	rgVxHY6vd/SOiSK7lTlJy0pSb0L92bsLzlm/2KPhYjihS4Hfj2zdVAnyKKfrwGqlEm5pDo
	EUog2L0gJV2Qlxfm4Aui8nW36E8nJNw=
From: chengming.zhou@linux.dev
To: vbabka@suse.cz,
	cl@linux.com
Cc: penberg@kernel.org,
	rientjes@google.com,
	iamjoonsoo.kim@lge.com,
	akpm@linux-foundation.org,
	roman.gushchin@linux.dev,
	42.hyeyoo@gmail.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	chengming.zhou@linux.dev
Subject: [PATCH] mm, slab: remove the corner case of inc_slabs_node()
Date: Thu, 22 Feb 2024 13:02:33 +0000
Message-Id: <20240222130233.2880176-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <chengming.zhou@linux.dev>

We already have the inc_slabs_node() after kmem_cache_node->node[node]
initialized in early_kmem_cache_node_alloc(), this special case of
inc_slabs_node() can be removed. Then we don't need to consider the
existence of kmem_cache_node in inc_slabs_node() anymore.

Signed-off-by: Chengming Zhou <chengming.zhou@linux.dev>
---
 mm/slub.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/mm/slub.c b/mm/slub.c
index 284b751b3b64..3f413e5e1415 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -1500,16 +1500,8 @@ static inline void inc_slabs_node(struct kmem_cache *s, int node, int objects)
 {
 	struct kmem_cache_node *n = get_node(s, node);
 
-	/*
-	 * May be called early in order to allocate a slab for the
-	 * kmem_cache_node structure. Solve the chicken-egg
-	 * dilemma by deferring the increment of the count during
-	 * bootstrap (see early_kmem_cache_node_alloc).
-	 */
-	if (likely(n)) {
-		atomic_long_inc(&n->nr_slabs);
-		atomic_long_add(objects, &n->total_objects);
-	}
+	atomic_long_inc(&n->nr_slabs);
+	atomic_long_add(objects, &n->total_objects);
 }
 static inline void dec_slabs_node(struct kmem_cache *s, int node, int objects)
 {
@@ -4877,7 +4869,6 @@ static void early_kmem_cache_node_alloc(int node)
 	slab = new_slab(kmem_cache_node, GFP_NOWAIT, node);
 
 	BUG_ON(!slab);
-	inc_slabs_node(kmem_cache_node, slab_nid(slab), slab->objects);
 	if (slab_nid(slab) != node) {
 		pr_err("SLUB: Unable to allocate memory from node %d\n", node);
 		pr_err("SLUB: Allocating a useless per node structure in order to be able to continue\n");
-- 
2.40.1


