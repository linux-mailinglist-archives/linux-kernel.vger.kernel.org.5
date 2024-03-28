Return-Path: <linux-kernel+bounces-122978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E057089009B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DF8B1C27EE2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B823B823A3;
	Thu, 28 Mar 2024 13:41:05 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8EE12FB0E;
	Thu, 28 Mar 2024 13:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633265; cv=none; b=ps8hxlVKDkNPqK143SvO8LFPKGJxsalLoSxjI0/1OnV7cg0ieQb4jax0vjyzEXy4fkhjOeLlsmYPQ/PFv1IJPep75Z09gnY0S9GCMDzSmCEh8efde8Tklytkha6sGF4FdJG7WlTm+dV7Xcwak8QZzTcXrLZNLklYxtNAEmtFLrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633265; c=relaxed/simple;
	bh=WYJk3b8vSRKVHRSqnf6kRRcpeFM/TqEwKIjzoLf6GOA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KGojWd8LohDE+WMJiyPty31xtillWLugcslI2pHpFkp5HURWNa558F7p70iUe/io76ceNhnwNJ6Aa9wNBIJgjlRq/xzgJpeWJ0zf2zN/X1UzOj03YNBHLfTof71wF0QqTRtkw6dwpuu3Iwkh2FbN+CAZCfE2v3IFw0qMdqv2IXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4V54Pv4MbXz1xrhm;
	Thu, 28 Mar 2024 21:38:59 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 4BF871402CA;
	Thu, 28 Mar 2024 21:41:01 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 21:41:01 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>
Subject: [PATCH RFC 09/10] mm: page_frag: introduce prepare/commit API for page_frag
Date: Thu, 28 Mar 2024 21:38:38 +0800
Message-ID: <20240328133839.13620-10-linyunsheng@huawei.com>
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

There are many use cases that need minimum memory in order
for forward progressing, but can do better if there is more
memory available.

Currently skb_page_frag_refill() API is used to solve the
above usecases, as mentioned in [1], its implementation is
similar to the one in mm subsystem.

To unify those two page_frag implementations, introduce a
prepare API to ensure minimum memory is satisfied and return
how much the actual memory is available to the caller.

And the caller can decide how much memory to use by calling
commit API, or not calling the commit API if deciding to not
use any memory.

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 72 ++++++++++++++++++++++++++++++++-
 mm/page_frag_alloc.c            | 13 +++---
 2 files changed, 75 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index a97a1ac017d6..3f17c0eba7fa 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -43,8 +43,76 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
-			 gfp_t gfp_mask);
+void *__page_frag_alloc_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				gfp_t gfp_mask);
+
+static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
+				       unsigned int fragsz, gfp_t gfp_mask)
+{
+	void *va;
+
+	va = __page_frag_alloc_prepare(nc, fragsz, gfp_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	va += nc->offset;
+	nc->pagecnt_bias--;
+	nc->offset = nc->offset + fragsz;
+
+	return va;
+}
+
+static inline void *page_frag_alloc_prepare(struct page_frag_cache *nc,
+					    unsigned int *offset,
+					    unsigned int *size,
+					    gfp_t gfp_mask)
+{
+	void *va;
+
+	va = __page_frag_alloc_prepare(nc, *size, gfp_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	*offset = nc->offset;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	*size = nc->size_mask - *offset + 1;
+#else
+	*size = PAGE_SIZE - *offset;
+#endif
+
+	return va;
+}
+
+static inline void *page_frag_alloc_prepare_align(struct page_frag_cache *nc,
+						  unsigned int *offset,
+						  unsigned int *size,
+						  unsigned int align,
+						  gfp_t gfp_mask)
+{
+	unsigned int old_offset = nc->offset;
+
+	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE ||
+		     *size < sizeof(unsigned int));
+
+	nc->offset = ALIGN(old_offset, align);
+	return page_frag_alloc_prepare(nc, offset, size, gfp_mask);
+}
+
+static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
+					  unsigned int offset,
+					  unsigned int size)
+{
+	nc->pagecnt_bias--;
+	nc->offset = offset + size;
+}
+
+static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
+						unsigned int offset,
+						unsigned int size)
+{
+	nc->offset = offset + size;
+}
 
 static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 					       unsigned int fragsz,
diff --git a/mm/page_frag_alloc.c b/mm/page_frag_alloc.c
index ae1393d0619a..c4d4fc10a850 100644
--- a/mm/page_frag_alloc.c
+++ b/mm/page_frag_alloc.c
@@ -81,8 +81,8 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
-			 gfp_t gfp_mask)
+void *__page_frag_alloc_prepare(struct page_frag_cache *nc, unsigned int fragsz,
+				gfp_t gfp_mask)
 {
 	unsigned long size_mask;
 	unsigned int offset;
@@ -120,7 +120,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 		set_page_count(page, size_mask);
 		nc->pagecnt_bias |= size_mask;
 
-		offset = 0;
+		nc->offset = 0;
 		if (unlikely(fragsz > (size_mask + 1))) {
 			/*
 			 * The caller is trying to allocate a fragment
@@ -135,12 +135,9 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 		}
 	}
 
-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
-
-	return va + offset;
+	return va;
 }
-EXPORT_SYMBOL(page_frag_alloc_va);
+EXPORT_SYMBOL(__page_frag_alloc_prepare);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.33.0


