Return-Path: <linux-kernel+bounces-145251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E3C8A5174
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88549B22C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4A312AAD7;
	Mon, 15 Apr 2024 13:22:20 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087A7129A99;
	Mon, 15 Apr 2024 13:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187339; cv=none; b=dFAtK/lriYMHGH64988k4DeN1HudCdQ8A07i1rzKsBmIC/WHGAD1EkCeBlv/VkLEWYoJo+751lP8gHx5Wjkh0pNYA5f7hnoamFqtQtEEOGLXa2tyIHXz6AUU0e8lViJYzCCL9XQqnPpH0IKAZNPn27r0aYApYFsBviRVXEcd70E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187339; c=relaxed/simple;
	bh=S3+R4GR54Egj1XPpy0lLWijQ8y0m54mAman9hLnQH60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SvsBEXFJvugMO4tl3RBO7cG/Gwp3HxsfhMy0yfD9U9kHkQQ+gLtxiT90mgRDG23eSpDp7Uv5IzVJykjXgIp9Tc1t7HflJWOGn8Ncr4M3CpYcF7/93llRXk5j74kWtucAKjkdBjKstbuheuJQxkjXwMh14uiAOnbeVCXm5aBjV1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VJ76v2HPmz1fxcp;
	Mon, 15 Apr 2024 21:19:19 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 15A9818002D;
	Mon, 15 Apr 2024 21:22:16 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:15 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v2 10/15] mm: page_frag: reuse existing bit field of 'va' for pagecnt_bias
Date: Mon, 15 Apr 2024 21:19:35 +0800
Message-ID: <20240415131941.51153-11-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240415131941.51153-1-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

As alignment of 'va' is always aligned with the order of the
page allocated, we can reuse the LSB bits for the pagecount
bias, and remove the orginal space needed by 'pagecnt_bias'.
Also limit the 'fragsz' to be at least the size of
'usigned int' to match the limited pagecnt_bias.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 20 +++++++----
 mm/page_frag_cache.c            | 63 +++++++++++++++++++--------------
 2 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 40a7d6da9ef0..a97a1ac017d6 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -9,7 +9,18 @@
 #define PAGE_FRAG_CACHE_MAX_ORDER	get_order(PAGE_FRAG_CACHE_MAX_SIZE)
 
 struct page_frag_cache {
-	void *va;
+	union {
+		void *va;
+		/* we maintain a pagecount bias, so that we dont dirty cache
+		 * line containing page->_refcount every time we allocate a
+		 * fragment. As 'va' is always aligned with the order of the
+		 * page allocated, we can reuse the LSB bits for the pagecount
+		 * bias, and its bit width happens to be indicated by the
+		 * 'size_mask' below.
+		 */
+		unsigned long pagecnt_bias;
+
+	};
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	__u16 offset;
 	__u16 size_mask:15;
@@ -18,10 +29,6 @@ struct page_frag_cache {
 	__u32 offset:31;
 	__u32 pfmemalloc:1;
 #endif
-	/* we maintain a pagecount bias, so that we dont dirty cache line
-	 * containing page->_refcount every time we allocate a fragment.
-	 */
-	unsigned int		pagecnt_bias;
 };
 
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
@@ -56,7 +63,8 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 					     gfp_t gfp_mask,
 					     unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE);
+	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE ||
+		     fragsz < sizeof(unsigned int));
 
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
 }
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 8d93029116e1..5f7f96c88163 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -18,8 +18,8 @@
 #include <linux/page_frag_cache.h>
 #include "internal.h"
 
-static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
-					     gfp_t gfp_mask)
+static bool __page_frag_cache_refill(struct page_frag_cache *nc,
+				     gfp_t gfp_mask)
 {
 	struct page *page = NULL;
 	gfp_t gfp = gfp_mask;
@@ -38,9 +38,26 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 	if (unlikely(!page))
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
 
-	nc->va = page ? page_address(page) : NULL;
+	if (unlikely(!page)) {
+		nc->va = NULL;
+		return false;
+	}
+
+	nc->va = page_address(page);
 
-	return page;
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	VM_BUG_ON(nc->pagecnt_bias & nc->size_mask);
+	page_ref_add(page, nc->size_mask - 1);
+	nc->pagecnt_bias |= nc->size_mask;
+#else
+	VM_BUG_ON(nc->pagecnt_bias & (PAGE_SIZE - 1));
+	page_ref_add(page, PAGE_SIZE - 2);
+	nc->pagecnt_bias |= (PAGE_SIZE - 1);
+#endif
+
+	nc->pfmemalloc = page_is_pfmemalloc(page);
+	nc->offset = 0;
+	return true;
 }
 
 void page_frag_cache_drain(struct page_frag_cache *nc)
@@ -65,38 +82,31 @@ EXPORT_SYMBOL(__page_frag_cache_drain);
 void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 			 gfp_t gfp_mask)
 {
-	unsigned int size, offset;
+	unsigned long size_mask;
+	unsigned int offset;
 	struct page *page;
+	void *va;
 
 	if (unlikely(!nc->va)) {
 refill:
-		page = __page_frag_cache_refill(nc, gfp_mask);
-		if (!page)
+		if (!__page_frag_cache_refill(nc, gfp_mask))
 			return NULL;
-
-		/* Even if we own the page, we do not use atomic_set().
-		 * This would break get_page_unless_zero() users.
-		 */
-		page_ref_add(page, PAGE_FRAG_CACHE_MAX_SIZE);
-
-		/* reset page count bias and offset to start of new frag */
-		nc->pfmemalloc = page_is_pfmemalloc(page);
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = 0;
 	}
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size_mask + 1;
+	size_mask = nc->size_mask;
 #else
-	size = PAGE_SIZE;
+	size_mask = PAGE_SIZE - 1;
 #endif
 
+	va = (void *)((unsigned long)nc->va & ~size_mask);
 	offset = nc->offset;
-	if (unlikely(offset + fragsz > size)) {
-		page = virt_to_page(nc->va);
 
-		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
+	if (unlikely(offset + fragsz > (size_mask + 1))) {
+		page = virt_to_page(va);
+
+		if (!page_ref_sub_and_test(page, nc->pagecnt_bias & size_mask))
 			goto refill;
 
 		if (unlikely(nc->pfmemalloc)) {
@@ -105,12 +115,11 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 		}
 
 		/* OK, page count is 0, we can safely set it */
-		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
+		set_page_count(page, size_mask);
+		nc->pagecnt_bias |= size_mask;
 
-		/* reset page count bias and offset to start of new frag */
-		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
 		offset = 0;
-		if (unlikely(fragsz > size)) {
+		if (unlikely(fragsz > (size_mask + 1))) {
 			/*
 			 * The caller is trying to allocate a fragment
 			 * with fragsz > PAGE_SIZE but the cache isn't big
@@ -127,7 +136,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 	nc->pagecnt_bias--;
 	nc->offset = offset + fragsz;
 
-	return nc->va + offset;
+	return va + offset;
 }
 EXPORT_SYMBOL(page_frag_alloc_va);
 
-- 
2.33.0


