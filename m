Return-Path: <linux-kernel+bounces-134399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14EEB89B100
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D5BAB2144C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF1E839FFF;
	Sun,  7 Apr 2024 13:11:04 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF97239855;
	Sun,  7 Apr 2024 13:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495464; cv=none; b=PTrgj7ETNAh3R8EbpnWydUvm1M2iwnCq82i53AxcQKuMkPn2q9tWBvYrxmZ2YV2xRULAvsubrSvm+4/KqB4GT+TTos+jywDVZpX2khjLo5/XNqVOT/2h1jSRiUUYCHNE1nyOU5NPRj5xkF2/YWxstYQR1wLJdtaCgpFKXV4t85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495464; c=relaxed/simple;
	bh=ckzJsKLlvTZAa8riV8iVnTe/Y30hT3rAXMB8iLio1u0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=owEMGkwoLeIadgs3arf1I6c3aoGaFZxyWy7pF0YD6AuckvblUmHdO9RxxtY5qbb/yz5Lg3pOZK3/+Vy4h+keDJLNQ3c9VXVh/onHFfPj2TS8EC2bPqoJDOi2x7+MRRtqWsDSZ+WFdU5XoN3BFhhiTWcs24/+Q6s9PI+K6DECYG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VCCFw0Q1Tz1QCR6;
	Sun,  7 Apr 2024 21:08:20 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DA4B1404F7;
	Sun,  7 Apr 2024 21:10:59 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Apr 2024 21:10:59 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v1 02/12] mm: page_frag: use initial zero offset for page_frag_alloc_align()
Date: Sun, 7 Apr 2024 21:08:39 +0800
Message-ID: <20240407130850.19625-3-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240407130850.19625-1-linyunsheng@huawei.com>
References: <20240407130850.19625-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500005.china.huawei.com (7.185.36.74)

We are above to use page_frag_alloc_*() API to not just
allocate memory for skb->data, but also use them to do
the memory allocation for skb frag too. Currently the
implementation of page_frag in mm subsystem is running
the offset as a countdown rather than count-up value,
there may have several advantages to that as mentioned
in [1], but it may have some disadvantages, for example,
it may disable skb frag coaleasing and more correct cache
prefetching

We have a trade-off to make in order to have a unified
implementation and API for page_frag, so use a initial zero
offset in this patch, and the following patch will try to
make some optimization to aovid the disadvantages as much
as possible.

1. https://lore.kernel.org/all/f4abe71b3439b39d17a6fb2d410180f367cadf5c.camel@gmail.com/

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 mm/page_frag_cache.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index a0f90ba25200..3e3e88d9af90 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -67,9 +67,8 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			      unsigned int fragsz, gfp_t gfp_mask,
 			      unsigned int align_mask)
 {
-	unsigned int size = PAGE_SIZE;
+	unsigned int size, offset;
 	struct page *page;
-	int offset;
 
 	if (unlikely(!nc->va)) {
 refill:
@@ -77,10 +76,6 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		if (!page)
 			return NULL;
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* Even if we own the page, we do not use atomic_set().
 		 * This would break get_page_unless_zero() users.
 		 */
@@ -89,11 +84,18 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 		/* reset page count bias and offset to start of new frag */
 		nc->pfmemalloc = page_is_pfmemalloc(page);
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		nc->offset = size;
+		nc->offset = 0;
 	}
 
-	offset = nc->offset - fragsz;
-	if (unlikely(offset < 0)) {
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	/* if size can vary use size else just use PAGE_SIZE */
+	size = nc->size;
+#else
+	size = PAGE_SIZE;
+#endif
+
+	offset = ALIGN(nc->offset, -align_mask);
+	if (unlikely(offset + fragsz > size)) {
 		page = virt_to_page(nc->va);
 
 		if (!page_ref_sub_and_test(page, nc->pagecnt_bias))
@@ -104,17 +106,13 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 			goto refill;
 		}
 
-#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
-		/* if size can vary use size else just use PAGE_SIZE */
-		size = nc->size;
-#endif
 		/* OK, page count is 0, we can safely set it */
 		set_page_count(page, PAGE_FRAG_CACHE_MAX_SIZE + 1);
 
 		/* reset page count bias and offset to start of new frag */
 		nc->pagecnt_bias = PAGE_FRAG_CACHE_MAX_SIZE + 1;
-		offset = size - fragsz;
-		if (unlikely(offset < 0)) {
+		offset = 0;
+		if (unlikely(fragsz > size)) {
 			/*
 			 * The caller is trying to allocate a fragment
 			 * with fragsz > PAGE_SIZE but the cache isn't big
@@ -129,8 +127,7 @@ void *__page_frag_alloc_align(struct page_frag_cache *nc,
 	}
 
 	nc->pagecnt_bias--;
-	offset &= align_mask;
-	nc->offset = offset;
+	nc->offset = offset + fragsz;
 
 	return nc->va + offset;
 }
-- 
2.33.0


