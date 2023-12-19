Return-Path: <linux-kernel+bounces-6058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9758193AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0EEC1C25499
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B247B41854;
	Tue, 19 Dec 2023 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Iwn4kg+j"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-176.mta0.migadu.com (out-176.mta0.migadu.com [91.218.175.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A363D0CE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtcYZCAnAciS7NEDq4A0NBDaIMQC+9FU2xLXkQaUBC0=;
	b=Iwn4kg+js3TZqTZyBEzr5jlkex5ITD9Q+U+eV8TWaTbadaxxhhpExvz32AObLkyzYsWKVo
	MEGpKSGLfb3aHTx+3wLZBhFQ6hI849in9n+2J9o44vahne4V4yCGCqK7fWLB18LfLjC7TQ
	S1SacVIxMXkVgZHMVh+q2zV1q3hj0X0=
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
Subject: [PATCH mm 17/21] kasan: rename pagealloc tests
Date: Tue, 19 Dec 2023 23:29:01 +0100
Message-Id: <f3eef6ddb87176c40958a3e5a0bd2386b52af4c6.1703024586.git.andreyknvl@google.com>
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

Rename "pagealloc" KASAN tests:

1. Use "kmalloc_large" for tests that use large kmalloc allocations.

2. Use "page_alloc" for tests that use page_alloc.

Also clean up the comments.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c | 51 ++++++++++++++++++++++---------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 0ae4e93e9311..230958de7604 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -214,12 +214,13 @@ static void kmalloc_node_oob_right(struct kunit *test)
 }
 
 /*
- * These kmalloc_pagealloc_* tests try allocating a memory chunk that doesn't
- * fit into a slab cache and therefore is allocated via the page allocator
- * fallback. Since this kind of fallback is only implemented for SLUB, these
- * tests are limited to that allocator.
+ * The kmalloc_large_* tests below use kmalloc() to allocate a memory chunk
+ * that does not fit into the largest slab cache and therefore is allocated via
+ * the page_alloc fallback for SLUB. SLAB has no such fallback, and thus these
+ * tests are not supported for it.
  */
-static void kmalloc_pagealloc_oob_right(struct kunit *test)
+
+static void kmalloc_large_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
@@ -235,7 +236,7 @@ static void kmalloc_pagealloc_oob_right(struct kunit *test)
 	kfree(ptr);
 }
 
-static void kmalloc_pagealloc_uaf(struct kunit *test)
+static void kmalloc_large_uaf(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
@@ -249,7 +250,7 @@ static void kmalloc_pagealloc_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
 }
 
-static void kmalloc_pagealloc_invalid_free(struct kunit *test)
+static void kmalloc_large_invalid_free(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE + 10;
@@ -262,7 +263,7 @@ static void kmalloc_pagealloc_invalid_free(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, kfree(ptr + 1));
 }
 
-static void pagealloc_oob_right(struct kunit *test)
+static void page_alloc_oob_right(struct kunit *test)
 {
 	char *ptr;
 	struct page *pages;
@@ -284,7 +285,7 @@ static void pagealloc_oob_right(struct kunit *test)
 	free_pages((unsigned long)ptr, order);
 }
 
-static void pagealloc_uaf(struct kunit *test)
+static void page_alloc_uaf(struct kunit *test)
 {
 	char *ptr;
 	struct page *pages;
@@ -298,15 +299,15 @@ static void pagealloc_uaf(struct kunit *test)
 	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
 }
 
-static void kmalloc_large_oob_right(struct kunit *test)
+/*
+ * Check that KASAN detects an out-of-bounds access for a big object allocated
+ * via kmalloc(). But not as big as to trigger the page_alloc fallback for SLUB.
+ */
+static void kmalloc_big_oob_right(struct kunit *test)
 {
 	char *ptr;
 	size_t size = KMALLOC_MAX_CACHE_SIZE - 256;
 
-	/*
-	 * Allocate a chunk that is large enough, but still fits into a slab
-	 * and does not trigger the page allocator fallback in SLUB.
-	 */
 	ptr = kmalloc(size, GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
 
@@ -404,18 +405,18 @@ static void krealloc_less_oob(struct kunit *test)
 	krealloc_less_oob_helper(test, 235, 201);
 }
 
-static void krealloc_pagealloc_more_oob(struct kunit *test)
+static void krealloc_large_more_oob(struct kunit *test)
 {
-	/* page_alloc fallback in only implemented for SLUB. */
+	/* page_alloc fallback is only implemented for SLUB. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
 	krealloc_more_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 201,
 					KMALLOC_MAX_CACHE_SIZE + 235);
 }
 
-static void krealloc_pagealloc_less_oob(struct kunit *test)
+static void krealloc_large_less_oob(struct kunit *test)
 {
-	/* page_alloc fallback in only implemented for SLUB. */
+	/* page_alloc fallback is only implemented for SLUB. */
 	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
 
 	krealloc_less_oob_helper(test, KMALLOC_MAX_CACHE_SIZE + 235,
@@ -1816,16 +1817,16 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmalloc_oob_right),
 	KUNIT_CASE(kmalloc_oob_left),
 	KUNIT_CASE(kmalloc_node_oob_right),
-	KUNIT_CASE(kmalloc_pagealloc_oob_right),
-	KUNIT_CASE(kmalloc_pagealloc_uaf),
-	KUNIT_CASE(kmalloc_pagealloc_invalid_free),
-	KUNIT_CASE(pagealloc_oob_right),
-	KUNIT_CASE(pagealloc_uaf),
 	KUNIT_CASE(kmalloc_large_oob_right),
+	KUNIT_CASE(kmalloc_large_uaf),
+	KUNIT_CASE(kmalloc_large_invalid_free),
+	KUNIT_CASE(page_alloc_oob_right),
+	KUNIT_CASE(page_alloc_uaf),
+	KUNIT_CASE(kmalloc_big_oob_right),
 	KUNIT_CASE(krealloc_more_oob),
 	KUNIT_CASE(krealloc_less_oob),
-	KUNIT_CASE(krealloc_pagealloc_more_oob),
-	KUNIT_CASE(krealloc_pagealloc_less_oob),
+	KUNIT_CASE(krealloc_large_more_oob),
+	KUNIT_CASE(krealloc_large_less_oob),
 	KUNIT_CASE(krealloc_uaf),
 	KUNIT_CASE(kmalloc_oob_16),
 	KUNIT_CASE(kmalloc_uaf_16),
-- 
2.25.1


