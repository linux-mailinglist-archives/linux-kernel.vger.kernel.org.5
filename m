Return-Path: <linux-kernel+bounces-125195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2838921FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD4E11F2504F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782701327ED;
	Fri, 29 Mar 2024 16:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LlJNVk2t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ABFC120;
	Fri, 29 Mar 2024 16:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711731365; cv=none; b=AgmpAL2DPIFks8yTDATVC873hloSnFjavRLlti7gljXj9FoHm3EKcOzMBqoQyOcpaIXFtDfeGFNePKXrH7xNP15JehtuysdCEAMm7FD/wfl3id+IcH/7QpuXoZzWTpHwqRh2SCNzy51yt8KAirfSR26Kos8TZ3QOjmV9+5k8lX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711731365; c=relaxed/simple;
	bh=3ivyAhdg7ynxpBW7rac0B1hX0R1RBBBH8OGp86Z9ZbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDyjHfy3vY2geFAo6hL3sI5+Taav33/dBFoC5UItVlSfUfZDjw6cL/nGvNTfyAnAY3X/owHqP1lxsIcOacVvBkrgTs1yktiVdqnNfpEO1fS/wLVtByOOe9MgQTn3ShsOZgo9EhPspEnNsT4OD15bweWOhH/OBRvwENbM3hvhrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LlJNVk2t; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711731363; x=1743267363;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3ivyAhdg7ynxpBW7rac0B1hX0R1RBBBH8OGp86Z9ZbI=;
  b=LlJNVk2tVhlscGfpRM49Kr2HBQaMpo1CpDbk/IVcvrzIkotp1/XFbT7K
   LT0YtjnFoZ3XSN/VY6DNOyShBO2lEe1t1orp3Xa9UinyyUqWSLsRXEDp8
   /NMfZP/veJvpmUQlNc11+kPVGuEBN03H7acTpx7v+g7gKWzPMFNncJXER
   ifbuRi2YjByDTQO9qA3h6QfwtCh9lFCDUDPyeDtkKyonaegnkBup+cOOj
   +CBs7iCiTXFx5P+EWO5TWez5UCqSq9IN5sJXkHmGEQx31bZWM66969rK7
   yLGXFSCl9NJK5+L9ukFNza5wiuhDEJ5sJm+qmHDUmlOVfrU+f2fovw19+
   w==;
X-CSE-ConnectionGUID: +An7P8BQSx63qVaIZW+83Q==
X-CSE-MsgGUID: EAcWTAICS9SiCuSezS12lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="18072473"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="18072473"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 09:55:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17100398"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 29 Mar 2024 09:55:55 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] page_pool: check for PP direct cache locality later
Date: Fri, 29 Mar 2024 17:55:06 +0100
Message-ID: <20240329165507.3240110-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
References: <20240329165507.3240110-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since we have pool->p.napi (Jakub) and pool->cpuid (Lorenzo) to check
whether it's safe to use direct recycling, we can use both globally for
each page instead of relying solely on @allow_direct argument.
Let's assume that @allow_direct means "I'm sure it's local, don't waste
time rechecking this" and when it's false, try the mentioned params to
still recycle the page directly. If neither is true, we'll lose some
CPU cycles, but then it surely won't be hotpath. On the other hand,
paths where it's possible to use direct cache, but not possible to
safely set @allow_direct, will benefit from this move.
The whole propagation of @napi_safe through a dozen of skb freeing
functions can now go away, which saves us some stack space.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/skbuff.h | 12 ++++----
 net/core/page_pool.c   | 31 +++++++++++++++++--
 net/core/skbuff.c      | 70 +++++++++++++-----------------------------
 net/ipv4/esp4.c        |  2 +-
 net/ipv6/esp6.c        |  2 +-
 5 files changed, 58 insertions(+), 59 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index dadd3f55d549..f7f6e42c6814 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -3515,25 +3515,25 @@ int skb_pp_cow_data(struct page_pool *pool, struct sk_buff **pskb,
 		    unsigned int headroom);
 int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 			 struct bpf_prog *prog);
-bool napi_pp_put_page(struct page *page, bool napi_safe);
+bool napi_pp_put_page(struct page *page);
 
 static inline void
-skb_page_unref(const struct sk_buff *skb, struct page *page, bool napi_safe)
+skb_page_unref(const struct sk_buff *skb, struct page *page)
 {
 #ifdef CONFIG_PAGE_POOL
-	if (skb->pp_recycle && napi_pp_put_page(page, napi_safe))
+	if (skb->pp_recycle && napi_pp_put_page(page))
 		return;
 #endif
 	put_page(page);
 }
 
 static inline void
-napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
+napi_frag_unref(skb_frag_t *frag, bool recycle)
 {
 	struct page *page = skb_frag_page(frag);
 
 #ifdef CONFIG_PAGE_POOL
-	if (recycle && napi_pp_put_page(page, napi_safe))
+	if (recycle && napi_pp_put_page(page))
 		return;
 #endif
 	put_page(page);
@@ -3549,7 +3549,7 @@ napi_frag_unref(skb_frag_t *frag, bool recycle, bool napi_safe)
  */
 static inline void __skb_frag_unref(skb_frag_t *frag, bool recycle)
 {
-	napi_frag_unref(frag, recycle, false);
+	napi_frag_unref(frag, recycle);
 }
 
 /**
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index dd364d738c00..9d56257e444b 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -690,8 +690,7 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 			page_pool_dma_sync_for_device(pool, page,
 						      dma_sync_size);
 
-		if (allow_direct && in_softirq() &&
-		    page_pool_recycle_in_cache(page, pool))
+		if (allow_direct && page_pool_recycle_in_cache(page, pool))
 			return NULL;
 
 		/* Page found as candidate for recycling */
@@ -716,9 +715,35 @@ __page_pool_put_page(struct page_pool *pool, struct page *page,
 	return NULL;
 }
 
+static bool page_pool_napi_local(const struct page_pool *pool)
+{
+	const struct napi_struct *napi;
+	u32 cpuid;
+
+	if (unlikely(!in_softirq()))
+		return false;
+
+	/* Allow direct recycle if we have reasons to believe that we are
+	 * in the same context as the consumer would run, so there's
+	 * no possible race.
+	 * __page_pool_put_page() makes sure we're not in hardirq context
+	 * and interrupts are enabled prior to accessing the cache.
+	 */
+	cpuid = smp_processor_id();
+	if (READ_ONCE(pool->cpuid) == cpuid)
+		return true;
+
+	napi = READ_ONCE(pool->p.napi);
+
+	return napi && READ_ONCE(napi->list_owner) == cpuid;
+}
+
 void page_pool_put_unrefed_page(struct page_pool *pool, struct page *page,
 				unsigned int dma_sync_size, bool allow_direct)
 {
+	if (!allow_direct)
+		allow_direct = page_pool_napi_local(pool);
+
 	page = __page_pool_put_page(pool, page, dma_sync_size, allow_direct);
 	if (page && !page_pool_recycle_in_ring(pool, page)) {
 		/* Cache full, fallback to free pages */
@@ -969,7 +994,7 @@ void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
 static void page_pool_disable_direct_recycling(struct page_pool *pool)
 {
 	/* Disable direct recycling based on pool->cpuid.
-	 * Paired with READ_ONCE() in napi_pp_put_page().
+	 * Paired with READ_ONCE() in page_pool_napi_local().
 	 */
 	WRITE_ONCE(pool->cpuid, -1);
 
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e0e172638c0a..e01e2a618621 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1005,11 +1005,8 @@ int skb_cow_data_for_xdp(struct page_pool *pool, struct sk_buff **pskb,
 EXPORT_SYMBOL(skb_cow_data_for_xdp);
 
 #if IS_ENABLED(CONFIG_PAGE_POOL)
-bool napi_pp_put_page(struct page *page, bool napi_safe)
+bool napi_pp_put_page(struct page *page)
 {
-	bool allow_direct = false;
-	struct page_pool *pp;
-
 	page = compound_head(page);
 
 	/* page->pp_magic is OR'ed with PP_SIGNATURE after the allocation
@@ -1022,39 +1019,18 @@ bool napi_pp_put_page(struct page *page, bool napi_safe)
 	if (unlikely(!is_pp_page(page)))
 		return false;
 
-	pp = page->pp;
-
-	/* Allow direct recycle if we have reasons to believe that we are
-	 * in the same context as the consumer would run, so there's
-	 * no possible race.
-	 * __page_pool_put_page() makes sure we're not in hardirq context
-	 * and interrupts are enabled prior to accessing the cache.
-	 */
-	if (napi_safe || in_softirq()) {
-		const struct napi_struct *napi = READ_ONCE(pp->p.napi);
-		unsigned int cpuid = smp_processor_id();
-
-		allow_direct = napi && READ_ONCE(napi->list_owner) == cpuid;
-		allow_direct |= READ_ONCE(pp->cpuid) == cpuid;
-	}
-
-	/* Driver set this to memory recycling info. Reset it on recycle.
-	 * This will *not* work for NIC using a split-page memory model.
-	 * The page will be returned to the pool here regardless of the
-	 * 'flipped' fragment being in use or not.
-	 */
-	page_pool_put_full_page(pp, page, allow_direct);
+	page_pool_put_full_page(page->pp, page, false);
 
 	return true;
 }
 EXPORT_SYMBOL(napi_pp_put_page);
 #endif
 
-static bool skb_pp_recycle(struct sk_buff *skb, void *data, bool napi_safe)
+static bool skb_pp_recycle(struct sk_buff *skb, void *data)
 {
 	if (!IS_ENABLED(CONFIG_PAGE_POOL) || !skb->pp_recycle)
 		return false;
-	return napi_pp_put_page(virt_to_page(data), napi_safe);
+	return napi_pp_put_page(virt_to_page(data));
 }
 
 /**
@@ -1096,12 +1072,12 @@ static void skb_kfree_head(void *head, unsigned int end_offset)
 		kfree(head);
 }
 
-static void skb_free_head(struct sk_buff *skb, bool napi_safe)
+static void skb_free_head(struct sk_buff *skb)
 {
 	unsigned char *head = skb->head;
 
 	if (skb->head_frag) {
-		if (skb_pp_recycle(skb, head, napi_safe))
+		if (skb_pp_recycle(skb, head))
 			return;
 		skb_free_frag(head);
 	} else {
@@ -1109,8 +1085,7 @@ static void skb_free_head(struct sk_buff *skb, bool napi_safe)
 	}
 }
 
-static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
-			     bool napi_safe)
+static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason)
 {
 	struct skb_shared_info *shinfo = skb_shinfo(skb);
 	int i;
@@ -1127,13 +1102,13 @@ static void skb_release_data(struct sk_buff *skb, enum skb_drop_reason reason,
 	}
 
 	for (i = 0; i < shinfo->nr_frags; i++)
-		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle, napi_safe);
+		napi_frag_unref(&shinfo->frags[i], skb->pp_recycle);
 
 free_head:
 	if (shinfo->frag_list)
 		kfree_skb_list_reason(shinfo->frag_list, reason);
 
-	skb_free_head(skb, napi_safe);
+	skb_free_head(skb);
 exit:
 	/* When we clone an SKB we copy the reycling bit. The pp_recycle
 	 * bit is only set on the head though, so in order to avoid races
@@ -1194,12 +1169,11 @@ void skb_release_head_state(struct sk_buff *skb)
 }
 
 /* Free everything but the sk_buff shell. */
-static void skb_release_all(struct sk_buff *skb, enum skb_drop_reason reason,
-			    bool napi_safe)
+static void skb_release_all(struct sk_buff *skb, enum skb_drop_reason reason)
 {
 	skb_release_head_state(skb);
 	if (likely(skb->head))
-		skb_release_data(skb, reason, napi_safe);
+		skb_release_data(skb, reason);
 }
 
 /**
@@ -1213,7 +1187,7 @@ static void skb_release_all(struct sk_buff *skb, enum skb_drop_reason reason,
 
 void __kfree_skb(struct sk_buff *skb)
 {
-	skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED, false);
+	skb_release_all(skb, SKB_DROP_REASON_NOT_SPECIFIED);
 	kfree_skbmem(skb);
 }
 EXPORT_SYMBOL(__kfree_skb);
@@ -1270,7 +1244,7 @@ static void kfree_skb_add_bulk(struct sk_buff *skb,
 		return;
 	}
 
-	skb_release_all(skb, reason, false);
+	skb_release_all(skb, reason);
 	sa->skb_array[sa->skb_count++] = skb;
 
 	if (unlikely(sa->skb_count == KFREE_SKB_BULK_SIZE)) {
@@ -1444,7 +1418,7 @@ EXPORT_SYMBOL(consume_skb);
 void __consume_stateless_skb(struct sk_buff *skb)
 {
 	trace_consume_skb(skb, __builtin_return_address(0));
-	skb_release_data(skb, SKB_CONSUMED, false);
+	skb_release_data(skb, SKB_CONSUMED);
 	kfree_skbmem(skb);
 }
 
@@ -1471,7 +1445,7 @@ static void napi_skb_cache_put(struct sk_buff *skb)
 
 void __napi_kfree_skb(struct sk_buff *skb, enum skb_drop_reason reason)
 {
-	skb_release_all(skb, reason, true);
+	skb_release_all(skb, reason);
 	napi_skb_cache_put(skb);
 }
 
@@ -1509,7 +1483,7 @@ void napi_consume_skb(struct sk_buff *skb, int budget)
 		return;
 	}
 
-	skb_release_all(skb, SKB_CONSUMED, !!budget);
+	skb_release_all(skb, SKB_CONSUMED);
 	napi_skb_cache_put(skb);
 }
 EXPORT_SYMBOL(napi_consume_skb);
@@ -1640,7 +1614,7 @@ EXPORT_SYMBOL_GPL(alloc_skb_for_msg);
  */
 struct sk_buff *skb_morph(struct sk_buff *dst, struct sk_buff *src)
 {
-	skb_release_all(dst, SKB_CONSUMED, false);
+	skb_release_all(dst, SKB_CONSUMED);
 	return __skb_clone(dst, src);
 }
 EXPORT_SYMBOL_GPL(skb_morph);
@@ -2272,9 +2246,9 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		if (skb_has_frag_list(skb))
 			skb_clone_fraglist(skb);
 
-		skb_release_data(skb, SKB_CONSUMED, false);
+		skb_release_data(skb, SKB_CONSUMED);
 	} else {
-		skb_free_head(skb, false);
+		skb_free_head(skb);
 	}
 	off = (data + nhead) - skb->head;
 
@@ -6575,12 +6549,12 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
 			skb_clone_fraglist(skb);
-		skb_release_data(skb, SKB_CONSUMED, false);
+		skb_release_data(skb, SKB_CONSUMED);
 	} else {
 		/* we can reuse existing recount- all we did was
 		 * relocate values
 		 */
-		skb_free_head(skb, false);
+		skb_free_head(skb);
 	}
 
 	skb->head = data;
@@ -6715,7 +6689,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		skb_kfree_head(data, size);
 		return -ENOMEM;
 	}
-	skb_release_data(skb, SKB_CONSUMED, false);
+	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;
 	skb->head_frag = 0;
diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index d33d12421814..3d647c9a7a21 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -114,7 +114,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(skb, sg_page(sg));
 }
 
 #ifdef CONFIG_INET_ESPINTCP
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 7371886d4f9f..fe8d53f5a5ee 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -131,7 +131,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
 	 */
 	if (req->src != req->dst)
 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
-			skb_page_unref(skb, sg_page(sg), false);
+			skb_page_unref(skb, sg_page(sg));
 }
 
 #ifdef CONFIG_INET6_ESPINTCP
-- 
2.44.0


