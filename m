Return-Path: <linux-kernel+bounces-6057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 078128193AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875571F26075
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8F741765;
	Tue, 19 Dec 2023 22:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YqrnJgAl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CAD3D0CB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 22:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703025085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gqTGbtVMui+CmtAk7WElvDUhOKijpogQXuGURBykLZ0=;
	b=YqrnJgAlquajDIl5bS/SUbEt3hHi1yePvIngCNhvy5NPjLJtH9NzR2DNcrEbXuO3mTgAfc
	WnRYQEnVKDzcn1NHeUUzpzPRb5b+Jnvi9IT8lvOHAJ8lZl5px1Dta7PJmc5FDtpmw3a9kE
	xUWaYEaCnbJDSFV/GGHi3rjbRbq5pM0=
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
Subject: [PATCH mm 16/21] kasan: add mempool tests
Date: Tue, 19 Dec 2023 23:29:00 +0100
Message-Id: <5fd64732266be8287711b6408d86ffc78784be06.1703024586.git.andreyknvl@google.com>
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

Add KASAN tests for mempool.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes RFC->v1:
- Use read instead of write in oob_right tests to avoid triggering
  slub_debug-detected corruptions.
- Adapt tests for the mempool API change.
---
 mm/kasan/kasan_test.c | 319 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 319 insertions(+)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 8281eb42464b..0ae4e93e9311 100644
--- a/mm/kasan/kasan_test.c
+++ b/mm/kasan/kasan_test.c
@@ -13,6 +13,7 @@
 #include <linux/io.h>
 #include <linux/kasan.h>
 #include <linux/kernel.h>
+#include <linux/mempool.h>
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/module.h>
@@ -798,6 +799,312 @@ static void kmem_cache_bulk(struct kunit *test)
 	kmem_cache_destroy(cache);
 }
 
+static void *mempool_prepare_kmalloc(struct kunit *test, mempool_t *pool, size_t size)
+{
+	int pool_size = 4;
+	int ret;
+	void *elem;
+
+	memset(pool, 0, sizeof(*pool));
+	ret = mempool_init_kmalloc_pool(pool, pool_size, size);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * Allocate one element to prevent mempool from freeing elements to the
+	 * underlying allocator and instead make it add them to the element
+	 * list when the tests trigger double-free and invalid-free bugs.
+	 * This allows testing KASAN annotations in add_element().
+	 */
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	return elem;
+}
+
+static struct kmem_cache *mempool_prepare_slab(struct kunit *test, mempool_t *pool, size_t size)
+{
+	struct kmem_cache *cache;
+	int pool_size = 4;
+	int ret;
+
+	cache = kmem_cache_create("test_cache", size, 0, 0, NULL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, cache);
+
+	memset(pool, 0, sizeof(*pool));
+	ret = mempool_init_slab_pool(pool, pool_size, cache);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	/*
+	 * Do not allocate one preallocated element, as we skip the double-free
+	 * and invalid-free tests for slab mempool for simplicity.
+	 */
+
+	return cache;
+}
+
+static void *mempool_prepare_page(struct kunit *test, mempool_t *pool, int order)
+{
+	int pool_size = 4;
+	int ret;
+	void *elem;
+
+	memset(pool, 0, sizeof(*pool));
+	ret = mempool_init_page_pool(pool, pool_size, order);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	return elem;
+}
+
+static void mempool_oob_right_helper(struct kunit *test, mempool_t *pool, size_t size)
+{
+	char *elem;
+
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	OPTIMIZER_HIDE_VAR(elem);
+
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test,
+			((volatile char *)&elem[size])[0]);
+	else
+		KUNIT_EXPECT_KASAN_FAIL(test,
+			((volatile char *)&elem[round_up(size, KASAN_GRANULE_SIZE)])[0]);
+
+	mempool_free(elem, pool);
+}
+
+static void mempool_kmalloc_oob_right(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 128 - KASAN_GRANULE_SIZE - 5;
+	void *extra_elem;
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_oob_right_helper(test, &pool, size);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_kmalloc_large_oob_right(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
+	void *extra_elem;
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_oob_right_helper(test, &pool, size);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_slab_oob_right(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 123;
+	struct kmem_cache *cache;
+
+	cache = mempool_prepare_slab(test, &pool, size);
+
+	mempool_oob_right_helper(test, &pool, size);
+
+	mempool_exit(&pool);
+	kmem_cache_destroy(cache);
+}
+
+/*
+ * Skip the out-of-bounds test for page mempool. With Generic KASAN, page
+ * allocations have no redzones, and thus the out-of-bounds detection is not
+ * guaranteed; see https://bugzilla.kernel.org/show_bug.cgi?id=210503. With
+ * the tag-based KASAN modes, the neighboring allocation might have the same
+ * tag; see https://bugzilla.kernel.org/show_bug.cgi?id=203505.
+ */
+
+static void mempool_uaf_helper(struct kunit *test, mempool_t *pool, bool page)
+{
+	char *elem, *ptr;
+
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	mempool_free(elem, pool);
+
+	ptr = page ? page_address((struct page *)elem) : elem;
+	KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[0]);
+}
+
+static void mempool_kmalloc_uaf(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 128;
+	void *extra_elem;
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_uaf_helper(test, &pool, false);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_kmalloc_large_uaf(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
+	void *extra_elem;
+
+	/* page_alloc fallback is only implemented for SLUB. */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_uaf_helper(test, &pool, false);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_slab_uaf(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 123;
+	struct kmem_cache *cache;
+
+	cache = mempool_prepare_slab(test, &pool, size);
+
+	mempool_uaf_helper(test, &pool, false);
+
+	mempool_exit(&pool);
+	kmem_cache_destroy(cache);
+}
+
+static void mempool_page_alloc_uaf(struct kunit *test)
+{
+	mempool_t pool;
+	int order = 2;
+	void *extra_elem;
+
+	extra_elem = mempool_prepare_page(test, &pool, order);
+
+	mempool_uaf_helper(test, &pool, true);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_double_free_helper(struct kunit *test, mempool_t *pool)
+{
+	char *elem;
+
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	mempool_free(elem, pool);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, mempool_free(elem, pool));
+}
+
+static void mempool_kmalloc_double_free(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 128;
+	char *extra_elem;
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_double_free_helper(test, &pool);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_kmalloc_large_double_free(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
+	char *extra_elem;
+
+	/* page_alloc fallback is only implemented for SLUB. */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_double_free_helper(test, &pool);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_page_alloc_double_free(struct kunit *test)
+{
+	mempool_t pool;
+	int order = 2;
+	char *extra_elem;
+
+	extra_elem = mempool_prepare_page(test, &pool, order);
+
+	mempool_double_free_helper(test, &pool);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_kmalloc_invalid_free_helper(struct kunit *test, mempool_t *pool)
+{
+	char *elem;
+
+	elem = mempool_alloc_preallocated(pool);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	KUNIT_EXPECT_KASAN_FAIL(test, mempool_free(elem + 1, pool));
+
+	mempool_free(elem, pool);
+}
+
+static void mempool_kmalloc_invalid_free(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = 128;
+	char *extra_elem;
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_kmalloc_invalid_free_helper(test, &pool);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+static void mempool_kmalloc_large_invalid_free(struct kunit *test)
+{
+	mempool_t pool;
+	size_t size = KMALLOC_MAX_CACHE_SIZE + 1;
+	char *extra_elem;
+
+	/* page_alloc fallback is only implemented for SLUB. */
+	KASAN_TEST_NEEDS_CONFIG_ON(test, CONFIG_SLUB);
+
+	extra_elem = mempool_prepare_kmalloc(test, &pool, size);
+
+	mempool_kmalloc_invalid_free_helper(test, &pool);
+
+	mempool_free(extra_elem, &pool);
+	mempool_exit(&pool);
+}
+
+/*
+ * Skip the invalid-free test for page mempool. The invalid-free detection only
+ * works for compound pages and mempool preallocates all page elements without
+ * the __GFP_COMP flag.
+ */
+
 static char global_array[10];
 
 static void kasan_global_oob_right(struct kunit *test)
@@ -1538,6 +1845,18 @@ static struct kunit_case kasan_kunit_test_cases[] = {
 	KUNIT_CASE(kmem_cache_oob),
 	KUNIT_CASE(kmem_cache_accounted),
 	KUNIT_CASE(kmem_cache_bulk),
+	KUNIT_CASE(mempool_kmalloc_oob_right),
+	KUNIT_CASE(mempool_kmalloc_large_oob_right),
+	KUNIT_CASE(mempool_slab_oob_right),
+	KUNIT_CASE(mempool_kmalloc_uaf),
+	KUNIT_CASE(mempool_kmalloc_large_uaf),
+	KUNIT_CASE(mempool_slab_uaf),
+	KUNIT_CASE(mempool_page_alloc_uaf),
+	KUNIT_CASE(mempool_kmalloc_double_free),
+	KUNIT_CASE(mempool_kmalloc_large_double_free),
+	KUNIT_CASE(mempool_page_alloc_double_free),
+	KUNIT_CASE(mempool_kmalloc_invalid_free),
+	KUNIT_CASE(mempool_kmalloc_large_invalid_free),
 	KUNIT_CASE(kasan_global_oob_right),
 	KUNIT_CASE(kasan_global_oob_left),
 	KUNIT_CASE(kasan_stack_oob),
-- 
2.25.1


