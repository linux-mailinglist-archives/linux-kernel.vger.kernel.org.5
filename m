Return-Path: <linux-kernel+bounces-6054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318798193A5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3BED285C07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF783FB39;
	Tue, 19 Dec 2023 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fbafFq1j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE023D0BC
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZKMuCi1Fs+yi8i1iMj8jEYKxpwLo+oL8GkzWTmOTGSI=;
	b=fbafFq1jlKC1cw8l0es+kRgSLJMag+jZz1zaVwws6qJ/XwEE/QAU3b2QRQ4d4gY3ik5ERb
	tj3mXVFI3saO1VRCl/G6F+6cQtebPvlWXWmXRbKaD42JplnE469NR+x6bSXKkfuSwR+j0Y
	wmoNA/R34bjTYOY+bjg9F2pqKV9n4xU=
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
Subject: [PATCH mm 14/21] mempool: use new mempool KASAN hooks
Date: Tue, 19 Dec 2023 23:28:58 +0100
Message-Id: <d36fc4a6865bdbd297cadb46b67641d436849f4c.1703024586.git.andreyknvl@google.com>
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

Update the mempool code to use the new mempool KASAN hooks.

Rely on the return value of kasan_mempool_poison_object and
kasan_mempool_poison_pages to prevent double-free and invalid-free bugs.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/mempool.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 1fd39478c85e..103dc4770cfb 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -112,32 +112,34 @@ static inline void poison_element(mempool_t *pool, void *element)
 }
 #endif /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
 
-static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
+static __always_inline bool kasan_poison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
-		kasan_mempool_poison_object(element);
+		return kasan_mempool_poison_object(element);
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_poison_pages(element, (unsigned long)pool->pool_data,
-				   false);
+		return kasan_mempool_poison_pages(element,
+						(unsigned long)pool->pool_data);
+	return true;
 }
 
 static void kasan_unpoison_element(mempool_t *pool, void *element)
 {
 	if (pool->alloc == mempool_kmalloc)
-		kasan_unpoison_range(element, (size_t)pool->pool_data);
+		kasan_mempool_unpoison_object(element, (size_t)pool->pool_data);
 	else if (pool->alloc == mempool_alloc_slab)
-		kasan_unpoison_range(element, kmem_cache_size(pool->pool_data));
+		kasan_mempool_unpoison_object(element,
+					      kmem_cache_size(pool->pool_data));
 	else if (pool->alloc == mempool_alloc_pages)
-		kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
-				     false);
+		kasan_mempool_unpoison_pages(element,
+					     (unsigned long)pool->pool_data);
 }
 
 static __always_inline void add_element(mempool_t *pool, void *element)
 {
 	BUG_ON(pool->curr_nr >= pool->min_nr);
 	poison_element(pool, element);
-	kasan_poison_element(pool, element);
-	pool->elements[pool->curr_nr++] = element;
+	if (kasan_poison_element(pool, element))
+		pool->elements[pool->curr_nr++] = element;
 }
 
 static void *remove_element(mempool_t *pool)
-- 
2.25.1


