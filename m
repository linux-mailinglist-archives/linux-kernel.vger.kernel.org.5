Return-Path: <linux-kernel+bounces-145250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872F8A5172
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF65EB234AD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33ACB129E9F;
	Mon, 15 Apr 2024 13:22:19 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C82129E6D;
	Mon, 15 Apr 2024 13:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187338; cv=none; b=J0vR7JWONgYwylRqKClUojaS1mj+4HwsJ51gKKPODYZsdVu+cYxVhcOj/oBcLQzSkngVS6fo7dStvBCg4fPlSkfpX0ITtWT7Jj3amCyfniGwof4D0g/DAtVwFFUlRE323ppDulTuDjnk7lRWKw/ATU+eQC4bQiT7jPONy1CUxhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187338; c=relaxed/simple;
	bh=X6NPrzPSXigXQjpjhvytUi+UP0PZWhvVUdbGdOHDUTQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkpOnMWIj5OZnv9ANFwqpbUHwhobnhucDrEywjftS6m/LE/OoysBZmn8mcZM2fMjWiw4ml+vwYRPrrQ+V7zQejT9zOIzvcgH/IBCMym/NTTVwQG1bDVY5BqK3qZq0TLDA+9eQBQ8dDvFTDnFfy4aBqvQ4y69aDhjAd8oc8rSloY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJ7983ZXkz1wryw;
	Mon, 15 Apr 2024 21:21:16 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 333DD140410;
	Mon, 15 Apr 2024 21:22:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:13 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v2 09/15] mm: page_frag: reuse MSB of 'size' field for pfmemalloc
Date: Mon, 15 Apr 2024 21:19:34 +0800
Message-ID: <20240415131941.51153-10-linyunsheng@huawei.com>
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

The '(PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)' case is for the
system with page size less than 32KB, which is 0x8000 bytes
requiring 16 bits space, change 'size' to 'size_mask' to avoid
using the MSB, and change 'pfmemalloc' field to reuse the that
MSB, so that we remove the orginal space needed by 'pfmemalloc'.

For another case, the MSB of 'offset' is reused for 'pfmemalloc'.

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 13 ++++++++-----
 mm/page_frag_cache.c            |  5 +++--
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
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 50511d8522d0..8d93029116e1 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -32,7 +32,8 @@ static struct page *__page_frag_cache_refill(struct page_frag_cache *nc,
 		   __GFP_NOWARN | __GFP_NORETRY | __GFP_NOMEMALLOC;
 	page = alloc_pages_node(NUMA_NO_NODE, gfp_mask,
 				PAGE_FRAG_CACHE_MAX_ORDER);
-	nc->size = page ? PAGE_FRAG_CACHE_MAX_SIZE : PAGE_SIZE;
+	nc->size_mask = page ? PAGE_FRAG_CACHE_MAX_SIZE - 1 : PAGE_SIZE - 1;
+	VM_BUG_ON(page && nc->size_mask != PAGE_FRAG_CACHE_MAX_SIZE - 1);
 #endif
 	if (unlikely(!page))
 		page = alloc_pages_node(NUMA_NO_NODE, gfp, 0);
@@ -86,7 +87,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 
 #if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
 	/* if size can vary use size else just use PAGE_SIZE */
-	size = nc->size;
+	size = nc->size_mask + 1;
 #else
 	size = PAGE_SIZE;
 #endif
-- 
2.33.0


