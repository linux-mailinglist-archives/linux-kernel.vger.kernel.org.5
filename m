Return-Path: <linux-kernel+bounces-9028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D22381BF65
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 21:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32798288EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 20:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDEC7690D;
	Thu, 21 Dec 2023 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KmqU694Z"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C2745E9
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 20:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703189167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=itOhYdVtqZdvAR7o0Q16gEQdZUJ+zDuxto8wg6YMX5U=;
	b=KmqU694Zt6wu9nrYTkctmmkfBJq7NuWGLfuL6LQc4yRHrVvgSk9TrEaIkENsIsxAhzy0iD
	M5jyxL69O1qWaiZjFMO8J3Kk4OIyyumpmCcqjeJvbednSEB0sn4BUCn5787rVS16/+WTWn
	vHxsZcIZaRd0Vg3+r7Go8wBuNHm2nL0=
From: andrey.konovalov@linux.dev
To: Marco Elver <elver@google.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	kasan-dev@googlegroups.com,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 10/11] kasan: remove SLUB checks for page_alloc fallbacks in tests
Date: Thu, 21 Dec 2023 21:04:52 +0100
Message-Id: <c82099b6fb365b6f4c2c21b112d4abb4dfd83e53.1703188911.git.andreyknvl@google.com>
In-Reply-To: <cover.1703188911.git.andreyknvl@google.com>
References: <cover.1703188911.git.andreyknvl@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Andrey Konovalov <andreyknvl@google.com>

A number of KASAN tests rely on the fact that calling kmalloc with a size
larger than an order-1 page falls back onto page_alloc.

This fallback was originally only implemented for SLUB, but since
commit d6a71648dbc0 ("mm/slab: kmalloc: pass requests larger than order-1
page to page allocator"), it is also implemented for SLAB.

Thus, drop the SLUB checks from the tests.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c | 26 ++------------------------
 1 file changed, 2 insertions(+), 24 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 496154e38965..798df4983858 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -215,7 +215,7 @@ static void kmalloc_node_oob_right(struct kunit *test)
 
 /*
  * Check that KASAN detects an out-of-bounds access for a big object allocated
- * via kmalloc(). But not as big as to trigger the page_alloc fallback for SLUB.
+ * via kmalloc(). But not as big as to trigger the page_alloc fallback.
  */
 static void kmalloc_big_oob_right(struct kunit *test)
 {
@@ -233,8 +233,7 @@ static void kmalloc_big_oob_right(struct kunit *test)
 /*
  * The kmalloc_large_* tests below use kmalloc() to allocate a memory chunk
  * that does not fit into the largest slab cache and therefore is allocated via
- * the page_alloc fallback for SLUB. SLAB has no such fallback, and thus these
- * tests are not supported for it.
+ * the page_alloc fallback.
  */
 
 static void kmalloc_large_oob_right(struct kunit *test)
@@ -242,8 +241,6 @@ static void kmalloc_large_oob_right(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -258,8 +255,6 @@ static void kmalloc_large_uaf(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 	kfree(ptr);
@@ -272,8 +267,6 @@ static void kmalloc_large_invalid_free(struct kunit *test)
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
 
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -407,18 +400,12 @@ static void krealloc_less_oob(struct kunit *test)
 
 static void krealloc_large_more_oob(struct kunit *test)
 {
-	/* page_alloc fallback is only implemented for SLUB. */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	krealloc_more_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 201,
 					KMALLOC_MAX_CACHE_SIZE + 235);
 }
 
 static void krealloc_large_less_oob(struct kunit *test)
 {
-	/* page_alloc fallback is only implemented for SLUB. */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	krealloc_less_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 235,
 					KMALLOC_MAX_CACHE_SIZE + 201);
 }
@@ -1144,9 +1131,6 @@ static void mempool_kmalloc_large_uaf(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
 	void *extra_elem;
 
-	/* page_alloc fallback is only implemented for SLUB. */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
 
 	mempool_uaf_helper(test, &pool, false);
@@ -1215,9 +1199,6 @@ static void mempool_kmalloc_large_double_free(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
 	char *extra_elem;
 
-	/* page_alloc fallback is only implemented for SLUB. */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
 
 	mempool_double_free_helper(test, &pool);
@@ -1272,9 +1253,6 @@ static void mempool_kmalloc_large_invalid_free(struct kunit *test)
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
 	char *extra_elem;
 
-	/* page_alloc fallback is only implemented for SLUB. */
-	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
-
 	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
 
 	mempool_kmalloc_invalid_free_helper(test, &pool);
-- 
2.25.1


