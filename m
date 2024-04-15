Return-Path: <linux-kernel+bounces-145254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3208A517C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FAEC1F23431
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702F212F590;
	Mon, 15 Apr 2024 13:22:24 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E070E12D1FA;
	Mon, 15 Apr 2024 13:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187343; cv=none; b=AaS1Sh9qjdXjuiS2N5SyDSj6UmH7xtv6rj/725EEP451se4Rm731rkLKvG8vjmnm6OSi+f/zTcjx0CqeFeG6psTUCF2bYdcsaVNEL5PZDUYnYl34fwFcj2G0gWjnBCKQCmtqccLIzqj8uG6MkWQOgg/XR6CQs5vHotWlybTq3HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187343; c=relaxed/simple;
	bh=qgQAwA0hldq08LMy1cx1bu/cfrHU/KY3Jm3B+cq2krM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n+j5vstg4Xt7NKUw/hzAFGvnlv/Xhg1ELFZ6edofRKFdo6/gs8JnT7t5MbqIhLvCNPstkY7SuSAnn+jDXOy/MvGtSkgS2k9awPY3xw2kWqvAtTkL/txI5MxZ8XP4BY54+H/U3n7IOcuGrYkfOfjl5Tz92M2aj6Hf5CBkQBpsEqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VJ79F6CnJz1ws3y;
	Mon, 15 Apr 2024 21:21:21 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DB7B1A0172;
	Mon, 15 Apr 2024 21:22:19 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:19 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>, Andrew
 Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: [PATCH net-next v2 12/15] mm: page_frag: introduce prepare/commit API for page_frag
Date: Mon, 15 Apr 2024 21:19:37 +0800
Message-ID: <20240415131941.51153-13-linyunsheng@huawei.com>
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

Note it seems hard to decide which header files for caling
virt_to_page() in the inline helper, so macro is used instead
of inline helper to avoid dealing with that.

1. https://lore.kernel.org/all/20240228093013.8263-1-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/page_frag_cache.h | 141 +++++++++++++++++++++++++++++++-
 mm/page_frag_cache.c            |  13 ++-
 2 files changed, 144 insertions(+), 10 deletions(-)

diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index a97a1ac017d6..28185969cd2c 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -43,8 +43,25 @@ static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 
 void page_frag_cache_drain(struct page_frag_cache *nc);
 void __page_frag_cache_drain(struct page *page, unsigned int count);
-void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
-			 gfp_t gfp_mask);
+void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
+			     gfp_t gfp_mask);
+
+static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
+				       unsigned int fragsz, gfp_t gfp_mask)
+{
+	unsigned int offset;
+	void *va;
+
+	va = page_frag_cache_refill(nc, fragsz, gfp_mask);
+	if (unlikely(!va))
+		return NULL;
+
+	offset = nc->offset;
+	nc->pagecnt_bias--;
+	nc->offset = offset + fragsz;
+
+	return va + offset;
+}
 
 static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 					       unsigned int fragsz,
@@ -69,6 +86,126 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
 }
 
+static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
+					       unsigned int *offset,
+					       unsigned int *size,
+					       gfp_t gfp_mask)
+{
+	void *va;
+
+	va = page_frag_cache_refill(nc, *size, gfp_mask);
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
+	return va + *offset;
+}
+
+static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
+						     unsigned int *offset,
+						     unsigned int *size,
+						     unsigned int align,
+						     gfp_t gfp_mask)
+{
+	WARN_ON_ONCE(!is_power_of_2(align) || align >= PAGE_SIZE ||
+		     *size < sizeof(unsigned int));
+
+	*offset = nc->offset;
+	nc->offset = ALIGN(*offset, align);
+	return page_frag_alloc_va_prepare(nc, offset, size, gfp_mask);
+}
+
+static inline void *__page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
+						 unsigned int *offset,
+						 unsigned int *size,
+						 gfp_t gfp_mask)
+{
+	void *va;
+
+	va = page_frag_cache_refill(nc, *size, gfp_mask);
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
+#define page_frag_alloc_pg_prepare(nc, offset, size, gfp)		\
+({									\
+	struct page *__page = NULL;					\
+	void *__va;							\
+									\
+	__va = __page_frag_alloc_pg_prepare(nc, offset, size, gfp);	\
+	if (likely(__va))						\
+		__page = virt_to_page(__va);				\
+									\
+	__page;								\
+})
+
+static inline void *__page_frag_alloc_prepare(struct page_frag_cache *nc,
+					      unsigned int *offset,
+					      unsigned int *size,
+					      void **va, gfp_t gfp_mask)
+{
+	void *nc_va;
+
+	nc_va = page_frag_cache_refill(nc, *size, gfp_mask);
+	if (unlikely(!nc_va))
+		return NULL;
+
+	*offset = nc->offset;
+	*va = nc_va + *offset;
+
+#if (PAGE_SIZE < PAGE_FRAG_CACHE_MAX_SIZE)
+	*size = nc->size_mask - *offset + 1;
+#else
+	*size = PAGE_SIZE - *offset;
+#endif
+
+	return nc_va;
+}
+
+#define page_frag_alloc_prepare(nc, offset, size, va, gfp)		\
+({									\
+	struct page *__page = NULL;					\
+	void *__va;							\
+									\
+	__va = __page_frag_alloc_prepare(nc, offset, size, va, gfp);	\
+	if (likely(__va))						\
+		__page = virt_to_page(__va);				\
+									\
+	__page;								\
+})
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
+
 void page_frag_free_va(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 5f7f96c88163..8774cb07e630 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -79,8 +79,8 @@ void __page_frag_cache_drain(struct page *page, unsigned int count)
 }
 EXPORT_SYMBOL(__page_frag_cache_drain);
 
-void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
-			 gfp_t gfp_mask)
+void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
+			     gfp_t gfp_mask)
 {
 	unsigned long size_mask;
 	unsigned int offset;
@@ -118,7 +118,7 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 		set_page_count(page, size_mask);
 		nc->pagecnt_bias |= size_mask;
 
-		offset = 0;
+		nc->offset = 0;
 		if (unlikely(fragsz > (size_mask + 1))) {
 			/*
 			 * The caller is trying to allocate a fragment
@@ -133,12 +133,9 @@ void *page_frag_alloc_va(struct page_frag_cache *nc, unsigned int fragsz,
 		}
 	}
 
-	nc->pagecnt_bias--;
-	nc->offset = offset + fragsz;
-
-	return va + offset;
+	return va;
 }
-EXPORT_SYMBOL(page_frag_alloc_va);
+EXPORT_SYMBOL(page_frag_cache_refill);
 
 /*
  * Frees a page fragment allocated out of either a compound or order 0 page.
-- 
2.33.0


