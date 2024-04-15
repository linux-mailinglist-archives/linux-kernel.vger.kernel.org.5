Return-Path: <linux-kernel+bounces-145255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D2438A5181
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:35:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA78B24FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:35:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F1212FB27;
	Mon, 15 Apr 2024 13:22:32 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB18F763EE;
	Mon, 15 Apr 2024 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187351; cv=none; b=ZbP/gUy01InzWgFSEacuc5gboEylrDlg+40nkJMFZI89cHA9TqH+bUOzl3ipE0UM42CN0pZsRQNSy3QmMObBLqKi3pZp3AaMaTIZ6mEL3c5v++aSD79OnKT8aS+O6sdzHzx2pw8E3nFFn5xAoN0LK9HG5uOlUCXBPQGdBijGkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187351; c=relaxed/simple;
	bh=XcQf/cJS8UHoY4bIpKI4ut+IWGmNAOYj6Ebdsl+jC0A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SYmf7EaFp/gp465TWW5bcGQ6MGvwg4hKP1+SwgV2UNuuenU3whEZZa9uSPdPk3Qqz9F2QwlLYxV6JRAWTKzdrSM5kQT9tQSm839HCSnkNUtxBlMO7QD8Mi3y4kGxmr00I0by5TAfOGDvs+j2gO2+FuERQQ56T1M9PD4d1bA95t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VJ7775GkYz1hwPD;
	Mon, 15 Apr 2024 21:19:31 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id EFDE714011B;
	Mon, 15 Apr 2024 21:22:27 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 21:22:27 +0800
From: Yunsheng Lin <linyunsheng@huawei.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Yunsheng Lin
	<linyunsheng@huawei.com>, Alexander Duyck <alexander.duyck@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>,
	<linux-mm@kvack.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH net-next v2 14/15] mm: page_frag: update documentation for page_frag
Date: Mon, 15 Apr 2024 21:19:39 +0800
Message-ID: <20240415131941.51153-15-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240415131941.51153-1-linyunsheng@huawei.com>
References: <20240415131941.51153-1-linyunsheng@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)

Update documentation about design, implementation and API usages
for page_frag.

CC: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 Documentation/mm/page_frags.rst | 148 +++++++++++++++++++++++++++++++-
 include/linux/page_frag_cache.h | 133 ++++++++++++++++++++++++++++
 mm/page_frag_cache.c            |   4 +
 3 files changed, 284 insertions(+), 1 deletion(-)

diff --git a/Documentation/mm/page_frags.rst b/Documentation/mm/page_frags.rst
index 503ca6cdb804..ac9dd9e8ee16 100644
--- a/Documentation/mm/page_frags.rst
+++ b/Documentation/mm/page_frags.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==============
 Page fragments
 ==============
@@ -40,4 +42,148 @@ page via a single call.  The advantage to doing this is that it allows for
 cleaning up the multiple references that were added to a page in order to
 avoid calling get_page per allocation.
 
-Alexander Duyck, Nov 29, 2016.
+
+Architecture overview
+=====================
+
+.. code-block:: none
+
+                +----------------------+
+                | page_frag API caller |
+                +----------------------+
+                            ^
+                            |
+                            |
+                            |
+                            v
+    +------------------------------------------------+
+    |             request page fragment              |
+    +------------------------------------------------+
+        ^                      ^                   ^
+        |                      | Cache not enough  |
+        | Cache empty          v                   |
+        |             +-----------------+          |
+        |             | drain old cache |          |
+        |             +-----------------+          |
+        |                      ^                   |
+        |                      |                   |
+        v                      v                   |
+    +----------------------------------+           |
+    |  refill cache with order 3 page  |           |
+    +----------------------------------+           |
+     ^                  ^                          |
+     |                  |                          |
+     |                  | Refill failed            |
+     |                  |                          | Cache is enough
+     |                  |                          |
+     |                  v                          |
+     |    +----------------------------------+     |
+     |    |  refill cache with order 0 page  |     |
+     |    +----------------------------------+     |
+     |                       ^                     |
+     | Refill succeed        |                     |
+     |                       | Refill succeed      |
+     |                       |                     |
+     v                       v                     v
+    +------------------------------------------------+
+    |         allocate fragment from cache           |
+    +------------------------------------------------+
+
+API interface
+=============
+As the design and implementation of page_frag API, the allocation side does not
+allow concurrent calling, it is assumed that the caller must ensure there is not
+concurrent alloc calling to the same page_frag_cache instance by using it's own
+lock or rely on some lockless guarantee like NAPI softirq.
+
+Depending on different use cases, callers expecting to deal with va, page or
+both va and page for them may call page_frag_alloc_va*, page_frag_alloc_pg*,
+or page_frag_alloc* API accordingly.
+
+There is also a use case that need minimum memory in order for forward
+progressing, but can do better if there is more memory available. Introduce
+page_frag_alloc_prepare() and page_frag_alloc_commit() related API, the caller
+requests the minimum memory it need and the prepare API will return the maximum
+size of the fragment returned, caller need to report back to the page_frag core
+how much memory it actually use by calling commit API, or not calling the commit
+API if deciding to not use any memory.
+
+.. kernel-doc:: include/linux/page_frag_cache.h
+   :identifiers: page_frag_cache_init page_frag_cache_is_pfmemalloc
+                 page_frag_alloc_va __page_frag_alloc_va_align
+                 page_frag_alloc_va_align page_frag_alloc_va_prepare
+                 page_frag_alloc_va_prepare_align page_frag_alloc_pg_prepare
+                 page_frag_alloc_prepare page_frag_alloc_commit
+                 page_frag_alloc_commit_noref page_frag_free_va
+
+.. kernel-doc:: mm/page_frag_cache.c
+   :identifiers: page_frag_cache_drain
+
+Coding examples
+===============
+
+Init & Drain API
+----------------
+
+.. code-block:: c
+
+   page_frag_cache_init(pfrag);
+   ...
+   page_frag_cache_drain(pfrag);
+
+
+Alloc & Free API
+----------------
+
+.. code-block:: c
+
+    void *va;
+
+    va = page_frag_alloc_va_align(pfrag, size, gfp, align);
+    if (!va)
+        goto do_error;
+
+    err = do_something(va, size);
+    if (err) {
+        page_frag_free_va(va);
+        goto do_error;
+    }
+
+Prepare & Commit API
+--------------------
+
+.. code-block:: c
+
+    unsigned int offset, size;
+    bool merge = true;
+    struct page *page;
+    void *va;
+
+    size = 32U;
+    page = page_frag_alloc_prepare(pfrag, &offset, &size, &va);
+    if (!page)
+        goto wait_for_space;
+
+    copy = min_t(int, copy, size);
+    if (!skb_can_coalesce(skb, i, page, offset)) {
+        if (i >= max_skb_frags)
+            goto new_segment;
+
+        merge = false;
+    }
+
+    copy = mem_schedule(copy);
+    if (!copy)
+        goto wait_for_space;
+
+    err = copy_from_iter_full_nocache(va, copy, iter);
+    if (err)
+        goto do_error;
+
+    if (merge) {
+        skb_frag_size_add(&skb_shinfo(skb)->frags[i - 1], copy);
+        page_frag_alloc_commit_noref(pfrag, offset, copy);
+    } else {
+        skb_fill_page_desc(skb, i, page, offset, copy);
+        page_frag_alloc_commit(pfrag, offset, copy);
+    }
diff --git a/include/linux/page_frag_cache.h b/include/linux/page_frag_cache.h
index 28185969cd2c..529e7c040dad 100644
--- a/include/linux/page_frag_cache.h
+++ b/include/linux/page_frag_cache.h
@@ -31,11 +31,28 @@ struct page_frag_cache {
 #endif
 };
 
+/**
+ * page_frag_cache_init() - Init page_frag cache.
+ * @nc: page_frag cache from which to init
+ *
+ * Inline helper to init the page_frag cache.
+ */
 static inline void page_frag_cache_init(struct page_frag_cache *nc)
 {
 	nc->va = NULL;
 }
 
+/**
+ * page_frag_cache_is_pfmemalloc() - Check for pfmemalloc.
+ * @nc: page_frag cache from which to check
+ *
+ * Used to check if the current page in page_frag cache is pfmemalloc'ed.
+ * It has the same calling context expection as the alloc API.
+ *
+ * Return:
+ * Return true if the current page in page_frag cache is pfmemalloc'ed,
+ * otherwise return false.
+ */
 static inline bool page_frag_cache_is_pfmemalloc(struct page_frag_cache *nc)
 {
 	return !!nc->pfmemalloc;
@@ -46,6 +63,17 @@ void __page_frag_cache_drain(struct page *page, unsigned int count);
 void *page_frag_cache_refill(struct page_frag_cache *nc, unsigned int fragsz,
 			     gfp_t gfp_mask);
 
+/**
+ * page_frag_alloc_va() - Alloc a page fragment.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Get a page fragment from page_frag cache.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 				       unsigned int fragsz, gfp_t gfp_mask)
 {
@@ -63,6 +91,19 @@ static inline void *page_frag_alloc_va(struct page_frag_cache *nc,
 	return va + offset;
 }
 
+/**
+ * __page_frag_alloc_va_align() - Alloc a page fragment with aligning
+ * requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement
+ *
+ * Get a page fragment from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 					       unsigned int fragsz,
 					       gfp_t gfp_mask,
@@ -75,6 +116,19 @@ static inline void *__page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return page_frag_alloc_va(nc, fragsz, gfp_mask);
 }
 
+/**
+ * page_frag_alloc_va_align() - Alloc a page fragment with aligning requirement.
+ * @nc: page_frag cache from which to allocate
+ * @fragsz: the requested fragment size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ * @align: the requested aligning requirement
+ *
+ * WARN_ON_ONCE() checking for align and fragsz before getting a page fragment
+ * from page_frag cache with aligning requirement.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 					     unsigned int fragsz,
 					     gfp_t gfp_mask,
@@ -86,6 +140,19 @@ static inline void *page_frag_alloc_va_align(struct page_frag_cache *nc,
 	return __page_frag_alloc_va_align(nc, fragsz, gfp_mask, align);
 }
 
+/**
+ * page_frag_alloc_va_prepare() - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 					       unsigned int *offset,
 					       unsigned int *size,
@@ -108,6 +175,21 @@ static inline void *page_frag_alloc_va_prepare(struct page_frag_cache *nc,
 	return va + *offset;
 }
 
+/**
+ * page_frag_alloc_va_prepare_align() - Prepare allocing a page fragment with
+ * aligning requirement.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @align: the requested aligning requirement
+ * @gfp_mask: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare an aligned page fragment with minimum size of ‘size’, 'size' is also
+ * used to report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return va of the page fragment, otherwise return NULL.
+ */
 static inline void *page_frag_alloc_va_prepare_align(struct page_frag_cache *nc,
 						     unsigned int *offset,
 						     unsigned int *size,
@@ -144,6 +226,19 @@ static inline void *__page_frag_alloc_pg_prepare(struct page_frag_cache *nc,
 	return va;
 }
 
+/**
+ * page_frag_alloc_pg_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @gfp: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment the caller can use.
+ *
+ * Return:
+ * Return the page fragment, otherwise return NULL.
+ */
 #define page_frag_alloc_pg_prepare(nc, offset, size, gfp)		\
 ({									\
 	struct page *__page = NULL;					\
@@ -179,6 +274,21 @@ static inline void *__page_frag_alloc_prepare(struct page_frag_cache *nc,
 	return nc_va;
 }
 
+/**
+ * page_frag_alloc_prepare - Prepare allocing a page fragment.
+ * @nc: page_frag cache from which to prepare
+ * @offset: out as the offset of the page fragment
+ * @size: in as the requested size, out as the available size
+ * @va: out as the va of the returned page fragment
+ * @gfp: the allocation gfp to use when cache need to be refilled
+ *
+ * Prepare a page fragment with minimum size of ‘size’, 'size' is also used to
+ * report the maximum size of the page fragment. Return both 'page' and 'va' of
+ * the fragment to the caller.
+ *
+ * Return:
+ * Return the page fragment, otherwise return NULL.
+ */
 #define page_frag_alloc_prepare(nc, offset, size, va, gfp)		\
 ({									\
 	struct page *__page = NULL;					\
@@ -191,6 +301,14 @@ static inline void *__page_frag_alloc_prepare(struct page_frag_cache *nc,
 	__page;								\
 })
 
+/**
+ * page_frag_alloc_commit - Commit allocing a page fragment.
+ * @nc: page_frag cache from which to commit
+ * @offset: offset of the page fragment
+ * @size: size of the page fragment has been used
+ *
+ * Commit the alloc preparing by passing offset and the actual used size.
+ */
 static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 					  unsigned int offset,
 					  unsigned int size)
@@ -199,6 +317,17 @@ static inline void page_frag_alloc_commit(struct page_frag_cache *nc,
 	nc->offset = offset + size;
 }
 
+/**
+ * page_frag_alloc_commit_noref - Commit allocing a page fragment without taking
+ * page refcount.
+ * @nc: page_frag cache from which to commit
+ * @offset: offset of the page fragment
+ * @size: size of the page fragment has been used
+ *
+ * Commit the alloc preparing by passing offset and the actual used size, but
+ * not taking page refcount. Mostly used for fragmemt coaleasing case when the
+ * current fragmemt can share the same refcount with previous fragmemt.
+ */
 static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 						unsigned int offset,
 						unsigned int size)
@@ -206,6 +335,10 @@ static inline void page_frag_alloc_commit_noref(struct page_frag_cache *nc,
 	nc->offset = offset + size;
 }
 
+/**
+ * page_frag_free_va - Free a page fragment by va.
+ * @addr: va of page fragment to be freed
+ */
 void page_frag_free_va(void *addr);
 
 #endif
diff --git a/mm/page_frag_cache.c b/mm/page_frag_cache.c
index 8774cb07e630..8b1d35aafcc1 100644
--- a/mm/page_frag_cache.c
+++ b/mm/page_frag_cache.c
@@ -60,6 +60,10 @@ static bool __page_frag_cache_refill(struct page_frag_cache *nc,
 	return true;
 }
 
+/**
+ * page_frag_cache_drain - Drain the current page from page_frag cache.
+ * @nc: page_frag cache from which to drain
+ */
 void page_frag_cache_drain(struct page_frag_cache *nc)
 {
 	if (!nc->va)
-- 
2.33.0


