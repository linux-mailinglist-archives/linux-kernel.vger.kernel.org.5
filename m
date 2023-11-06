Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76F8E7E2DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbjKFUNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjKFUMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:12:50 -0500
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312FC10D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:12:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699301565;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J0FZGClDjGLvLD3TemnnZlVkckK/FbBcRM13VFu32PM=;
        b=u66VHtu/jQ8awmrPx0sqAT3awrwRy7LoUZT6YuP/AeVFLTV8z6gU99EDSnmB7b+vlP8GiH
        kLVdU8feP/LvgjDFYRFlJYBJnYVG/BCUZebuMkwHoBpVhV+QpImR3lWmGnjoTkYHo9queI
        m9qLnEnZnW6Qbh8fHp4S9bL0AaSkd1M=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH RFC 15/20] kasan: add mempool tests
Date:   Mon,  6 Nov 2023 21:10:24 +0100
Message-Id: <389467628f04e7defb81cc08079cdc9c983f71a4.1699297309.git.andreyknvl@google.com>
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add KASAN tests for mempool.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan_test.c | 325 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 325 insertions(+)

diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
index 8281eb42464b..9adbcd04259b 100644
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
@@ -798,6 +799,318 @@ static void kmem_cache_bulk(struct kunit *test)
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
+	/* Tell mempool to only use preallocated elements. */
+	mempool_use_prealloc_only(pool);
+
+	/*
+	 * Allocate one element to prevent mempool from freeing elements to the
+	 * underlying allocator and instead make it add them to the element
+	 * list when the tests trigger double-free and invalid-free bugs.
+	 * This allows testing KASAN annotations in add_element().
+	 */
+	elem = mempool_alloc(pool, GFP_KERNEL);
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
+	mempool_use_prealloc_only(pool);
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
+	mempool_use_prealloc_only(pool);
+
+	elem = mempool_alloc(pool, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	return elem;
+}
+
+static void mempool_oob_right_helper(struct kunit *test, mempool_t *pool, size_t size)
+{
+	char *elem;
+
+	elem = mempool_alloc(pool, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, elem);
+
+	OPTIMIZER_HIDE_VAR(elem);
+
+	if (IS_ENABLED(CONFIG_KASAN_GENERIC))
+		KUNIT_EXPECT_KASAN_FAIL(test, elem[size] = 'x');
+	else
+		KUNIT_EXPECT_KASAN_FAIL(test,
+			elem[round_up(size, KASAN_GRANULE_SIZE)] = 'x');
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
+	elem = mempool_alloc(pool, GFP_KERNEL);
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
+	elem = mempool_alloc(pool, GFP_KERNEL);
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
+	elem = mempool_alloc(pool, GFP_KERNEL);
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
@@ -1538,6 +1851,18 @@ static struct kunit_case kasan_kunit_test_cases[] = {
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

