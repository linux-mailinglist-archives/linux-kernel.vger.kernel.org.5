Return-Path: <linux-kernel+bounces-122975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2A6890095
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFB91C2789F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E6312F374;
	Thu, 28 Mar 2024 13:41:00 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640628175B;
	Thu, 28 Mar 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633260; cv=none; b=hlu+Clj6KIe8m3QpQnPcg6x/50SL3c+2tSFwUULVXfkfFKWGfbEi1lq408Jg0se2ZqoUE1Dz/md8rQISsD9SxBnDV1uJ/HVzFLFkHzdObt9O16quiIJx72Hqjbcr8NKuLTYS/TK7LZMYiUkd/LG9rm0JULVsEGoPMlOkZhE+HKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633260; c=relaxed/simple;
	bh=Ix04qNi/vak0WyTKQjVjhF/8M+BDkDbVXujtrUoQ80k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QXRKUWLUXCaAxAICNx5dhnAElXd+tFJpBPdMeglsOHTlZpHaoKRjhXN63nUsNbO3pBNg+WptpvNsSfDz+AURswKkFVM1RxsuZc+r4OgkuR75XC7VdwRvcVYz+I5HjBauIVywYihoFBuvByk3ePqvy5JG1l9ixPb2J+fxbVMJcH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V54P32lZ6z1h4Kn;
	Thu, 28 Mar 2024 21:38:15 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id B5FBC140258;
	Thu, 28 Mar 2024 21:40:55 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:40:55 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Subject: [PATCH RFC 06/10] mm: page_frag: reuse MSB of 'size' field for pfmemalloc
Date: Thu, 28 Mar 2024 21:38:35 +0800
Message-ID: <20240328133839.13620-7-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240328133839.13620-1-linyunsheng@huawei.com>
References: <20240328133839.13620-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
system with page size less than 32KB, which is 0x8000 bytes
requiring 16 bits space, change 'size' to 'size_mask' to avoid
using the MSB, and change 'pfmemalloc' field to reuse the that
MSB, so that we remove the orginal space needed by 'pfmemalloc'.

For another case, the MSB of 'offset' is reused for 'pfmemalloc'.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 13 ++++++++-----
 mm/page_frag_alloc.c            |  5 +++--
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index fe5faa80b6c3..40a7d6da9ef0 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -12,15 +12,16 @@ struct page_frag_cache {
 	void *va;
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	__u16 offset;
-	__u16 size;
+	__u16 size_mask:15;
+	__u16 pfmemalloc:1;
 #else
-	__u32 offset;
+	__u32 offset:31;
+	__u32 pfmemalloc:1;
 #endif
 	/* we maintain a pagecount bias, so that we dont dirty cache line
 	 * containing page->_refcount every time we allocate a fragment.
 	 */
 	unsigned int		pagecnt_bias;
-	bool pfmemalloc;
 };
 
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
@@ -43,7 +44,9 @@ static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 					       gfp_t gfp_mask,
 					       unsigned int align)
 {
-	nc->offset = ALIGN(nc->offset, align);
+	unsigned int offset = nc->offset;
+
+	nc->offset = ALIGN(offset, align);
 
 	return page_frag_alloc_va(nc, fragsz, gfp_mask);
 }
@@ -53,7 +56,7 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 					     gfp_t gfp_mask,
 					     unsigned int align)
 {
-	WARN_ON_ONCE(!is_power_of_2(align));
+	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE);
 
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
 }
diff --git a/mm/page_frag_alloc.c b/mm/page_frag_alloc.c
index 7f639af4e518..a02e57a439f0 100644
--- a/mm/page_frag_alloc.c
+++ b/mm/page_frag_alloc.c
@@ -29,7 +29,8 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
+	nc->size_mask = page ? PAGE_FRAG_CACHE_MAX_SIZE - 1 : PAGE_SIZE - 1;
+	VM_BUG_ON(page && nc->size_mask != PAGE_FRAG_CACHE_MAX_SIZE - 1);
 #endif
 	if (unlikely(!page))
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
@@ -88,7 +89,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size;
+	size = nc->size_mask + 1;
 #else
 	size = PAGE_SIZE;
 #endif
-- 
2.33.0


