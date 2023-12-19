Return-Path: <linux-kernel+bounces-6055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A183A8193A6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED1728660D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A54340BF2;
	Tue, 19 Dec 2023 22:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CZpopGBZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64AE3D0C4
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vw9Ju+XsuH7jTh0rV53QjnTfccLPGDaCnQHzua8vht8=;
	b=CZpopGBZsYX+uocBYMIAfDP7PDv7NGAgHL88CMPaHeNmC1Jd3UkHAbZqq1SXvnp8qR3PRk
	ko3vkaTQDOJV582w6cY6Jpq7gGMvDm6ekS2hgFsxwAQMhisoeEHQlLiOfoxsL6ydfk5Smi
	uW9JPOVYPoMNbIRTQbjw3x7wa9H6dN4=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Evgenii Stepanov <eugenis@google.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Lobakin <alobakin@pm.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 15/21] mempool: introduce mempool_use_prealloc_only
Date: Tue, 19 Dec 2023 23:28:59 +0100
Message-Id: <a14d809dbdfd04cc33bcacc632fee2abd6b83c00.1703024586.git.andreyknvl@google.com>
In-Reply-To: <cover.1703024586.git.andreyknvl@google.com>
References: <cover.1703024586.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

Introduce a new mempool_alloc_preallocated API that asks the mempool to
only use the elements preallocated during the mempool's creation when
allocating and to not attempt allocating new ones from the underlying
allocator.

This API is required to test the KASAN poisoning/unpoisoning
functionality in KASAN tests, but it might be also useful on its own.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes RFC->v1:
- Introduce a new mempool_alloc_preallocated API instead of adding a flag
  into mempool_t.
---
 include/linux/mempool.h |  1 +
 mm/mempool.c            | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/mempool.h b/include/linux/mempool.h
index 4aae6c06c5f2..7be1e32e6d42 100644
--- a/include/linux/mempool.h
+++ b/include/linux/mempool.h
@@ -51,6 +51,7 @@ extern mempool_t *mempool_create_node(int min_nr, mempool_alloc_t *alloc_fn,
 extern int mempool_resize(mempool_t *pool, int new_min_nr);
 extern void mempool_destroy(mempool_t *pool);
 extern void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask) __malloc;
+extern void *mempool_alloc_preallocated(mempool_t *pool) __malloc;
 extern void mempool_free(void *element, mempool_t *pool);
 
 /*
diff --git a/mm/mempool.c b/mm/mempool.c
index 103dc4770cfb..cb7b4b56cec1 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -456,6 +456,43 @@ void *mempool_alloc(mempool_t *pool, gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(mempool_alloc);
 
+/**
+ * mempool_alloc_preallocated - allocate an element from preallocated elements
+ *                              belonging to a specific memory pool
+ * @pool:      pointer to the memory pool which was allocated via
+ *             mempool_create().
+ *
+ * This function is similar to mempool_alloc, but it only attempts allocating
+ * an element from the preallocated elements. It does not sleep and immediately
+ * returns if no preallocated elements are available.
+ *
+ * Return: pointer to the allocated element or %NULL if no elements are
+ * available.
+ */
+void *mempool_alloc_preallocated(mempool_t *pool)
+{
+	void *element;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pool->lock, flags);
+	if (likely(pool->curr_nr)) {
+		element = remove_element(pool);
+		spin_unlock_irqrestore(&pool->lock, flags);
+		/* paired with rmb in mempool_free(), read comment there */
+		smp_wmb();
+		/*
+		 * Update the allocation stack trace as this is more useful
+		 * for debugging.
+		 */
+		kmemleak_update_trace(element);
+		return element;
+	}
+	spin_unlock_irqrestore(&pool->lock, flags);
+
+	return NULL;
+}
+EXPORT_SYMBOL(mempool_alloc_preallocated);
+
 /**
  * mempool_free - return an element to the pool.
  * @element:   pool element pointer.
-- 
2.25.1


