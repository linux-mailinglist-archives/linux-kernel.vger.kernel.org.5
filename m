Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A4C812E29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444061AbjLNLHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:07:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443979AbjLNLHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:07:14 -0500
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF2F191
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:01 -0800 (PST)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-333501e22caso6205383f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 03:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702552020; x=1703156820; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z23ZDr01NkgZyjyXcvWE5FnYbJhU70TfuuBALSdMK5s=;
        b=O94Gb3hIlovf0Re2+/vnaVhtSDte358hXAzkCXS636turm0lAFyke2fN7VC2Ygq9mR
         flt2SYBMrk3L9Xg24nv0Xx+r/jnQm8NyQrbSS87U1vCd7/269WZPUVQXe9cGn8EiBguv
         J3+7cyWWzS97Nwmj4Rl71uZkR0LRytpuDNoa0c6wBcxVLgPrIILgiV8CqtJ4WmHE4KUm
         2zknCOY1/H4P+pXSuZUj0YN9Eh//Oi0lEuFqXdag7jQ5xQIYeHYdySIr2r8KkdBfOQgq
         wEjpYD3SGMiIOcI2h8f9g3Eu9IfrWb7p+2Jc+q0lGkxqbHAvi/dVhVPzgxHfdkh88qgx
         HJCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552020; x=1703156820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z23ZDr01NkgZyjyXcvWE5FnYbJhU70TfuuBALSdMK5s=;
        b=uk7x2nPCujgtm5wlh5KwFPP5ne/syRJ8IFWKpp3WmRVeTxnbY11LXrycSh+JPZowSs
         4XB04TV0oSwCcUh2KuDJPlkHkaFP4jqgFqMsx2xM0kCKUYo475JaHHBvMh//iuz/9bek
         Qair3dC+ITYUNnqPjvWydixAE4PWZ7DvdxjidjPg+eCm48As3Mn3BRXi8t20C7YwFxm7
         m6z+9Uxn1bSjkkkOGrhe+iff7zggZ4ShWp7tQhu3kk7B+v0KB8o/GIkuVi4V/dCs0HNf
         KuO4JOEaP206ri++aKnng/PIJad02Mtg2FkbEu6ZQWPwUT1OKnpvW0pEuUChhclWoGSF
         eNOA==
X-Gm-Message-State: AOJu0YxPAlD0NlDRm1M4uN6U5uFpl/Jh9kE/k1ZMUyGz8zkX9T4e6rBu
        5+a7BDb3flrUI9P1CsDt+LPo9Xv4H/E=
X-Google-Smtp-Source: AGHT+IEffuRK7eMhk5v3MPxIHyqDU9QxpDmCoK2fcfSBY82IEhz5qti3EblDU7cstiHLqMSjdDiZR9T2KOI=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:8447:3e89:1f77:ff8a])
 (user=glider job=sendgmr) by 2002:a5d:47ad:0:b0:336:365c:ac3e with SMTP id
 13-20020a5d47ad000000b00336365cac3emr20573wrb.10.1702552019764; Thu, 14 Dec
 2023 03:06:59 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:06:37 +0100
In-Reply-To: <20231214110639.2294687-1-glider@google.com>
Mime-Version: 1.0
References: <20231214110639.2294687-1-glider@google.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Message-ID: <20231214110639.2294687-6-glider@google.com>
Subject: [PATCH v10-mte 5/7] arm64: mte: add a test for MTE tags compression
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that tag sequences containing alternating values are compressed
to buffers of expected size and correctly decompressed afterwards.

Signed-off-by: Alexander Potapenko <glider@google.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>

---
 v10-mte:
  - added Catalin's Acked-by:

 v9:
  - minor changes to Kconfig description

 v8:
  - adapt to the simplified compression algorithm

 v6:
  - add test_decompress_invalid() to ensure invalid handles are ignored;
  - add test_upper_bits(), which is a regression test for a case where
    an inline handle looked like an out-of-line one;
  - add test_compress_nonzero() to ensure a full nonzero tag array is
    compressed correctly;
  - add test_two_ranges() to test cases when the input buffer is divided
    into two ranges.

 v5:
  - remove hardcoded constants, added test setup/teardown;
  - support 16- and 64K pages;
  - replace nested if-clauses with expected_size_from_ranges();
  - call mte_release_handle() after tests that perform
    compression/decompression;
  - address comments by Andy Shevchenko:
    - fix include order;
    - use mtecomp.h instead of function prototypes.

 v4:
  - addressed comments by Andy Shevchenko:
    - expanded MTE to "Memory Tagging Extension" in Kconfig
    - changed signed variables to unsigned where applicable
    - added missing header dependencies

  - addressed comments by Yury Norov:
    - moved test-only declarations from mtecomp.h into this test
    - switched to the new "mte"-prefixed function names, dropped the
      mentions of "EA0"
    - added test_tag_to_ranges_n()

 v3:
  - addressed comments by Andy Shevchenko in another patch:
   - switched from u64 to unsigned long
   - added MODULE_IMPORT_NS(MTECOMP)
   - fixed includes order
---
 arch/arm64/Kconfig           |  11 ++
 arch/arm64/mm/Makefile       |   1 +
 arch/arm64/mm/test_mtecomp.c | 364 +++++++++++++++++++++++++++++++++++
 3 files changed, 376 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5f4d4b49a512e..6a1397a96f2f0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2089,6 +2089,17 @@ config ARM64_MTE_COMP
 	  RLE to conserve heap memory. In the common case compressed tags
 	  occupy 2.5x less memory.
 
+config ARM64_MTE_COMP_KUNIT_TEST
+	tristate "Test tag compression for ARM64 Memory Tagging Extension" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on KUNIT && ARM64_MTE_COMP
+	help
+	  Test MTE compression algorithm enabled by CONFIG_ARM64_MTE_COMP.
+
+	  Ensure that certain tag sequences containing alternating values can
+	  be compressed into pointer-size values and correctly decompressed
+	  afterwards.
+
 config ARM64_SVE
 	bool "ARM Scalable Vector Extension support"
 	default y
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index 46778f6dd83c2..170dc62b010b9 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_TRANS_TABLE)	+= trans_pgd-asm.o
 obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 obj-$(CONFIG_ARM64_MTE_COMP)	+= mtecomp.o
+obj-$(CONFIG_ARM64_MTE_COMP_KUNIT_TEST) += test_mtecomp.o
 KASAN_SANITIZE_physaddr.o	+= n
 
 obj-$(CONFIG_KASAN)		+= kasan_init.o
diff --git a/arch/arm64/mm/test_mtecomp.c b/arch/arm64/mm/test_mtecomp.c
new file mode 100644
index 0000000000000..e8aeb7607ff41
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for MTE tags compression algorithm.
+ */
+
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <kunit/test.h>
+
+#include <asm/mtecomp.h>
+
+#include "mtecomp.h"
+
+/* Per-test storage allocated in mtecomp_test_init(). */
+struct test_data {
+	u8 *tags, *dtags;
+	unsigned short *r_sizes;
+	size_t r_len;
+	u8 *r_tags;
+};
+
+/*
+ * Split td->tags to ranges stored in td->r_tags, td->r_sizes, td->r_len,
+ * then convert those ranges back to tags stored in td->dtags.
+ */
+static void tags_to_ranges_to_tags_helper(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+
+	mte_tags_to_ranges(td->tags, td->r_tags, td->r_sizes, &td->r_len);
+	mte_ranges_to_tags(td->r_tags, td->r_sizes, td->r_len, td->dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(td->tags, td->dtags, MTE_PAGE_TAG_STORAGE),
+			0);
+}
+
+/*
+ * Test that mte_tags_to_ranges() produces a single range for a zero-filled tag
+ * buffer.
+ */
+static void test_tags_to_ranges_zero(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	tags_to_ranges_to_tags_helper(test);
+
+	KUNIT_EXPECT_EQ(test, td->r_len, 1);
+	KUNIT_EXPECT_EQ(test, td->r_tags[0], 0);
+	KUNIT_EXPECT_EQ(test, td->r_sizes[0], MTE_GRANULES_PER_PAGE);
+}
+
+/*
+ * Test that a small number of different tags is correctly transformed into
+ * ranges.
+ */
+static void test_tags_to_ranges_simple(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	const u8 ex_tags[] = { 0xa, 0x0, 0xa, 0xb, 0x0 };
+	const unsigned short ex_sizes[] = { 1, 2, 2, 1,
+					    MTE_GRANULES_PER_PAGE - 6 };
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	td->tags[0] = 0xa0;
+	td->tags[1] = 0x0a;
+	td->tags[2] = 0xab;
+	tags_to_ranges_to_tags_helper(test);
+
+	KUNIT_EXPECT_EQ(test, td->r_len, 5);
+	KUNIT_EXPECT_EQ(test, memcmp(td->r_tags, ex_tags, sizeof(ex_tags)), 0);
+	KUNIT_EXPECT_EQ(test, memcmp(td->r_sizes, ex_sizes, sizeof(ex_sizes)),
+			0);
+}
+
+/* Test that repeated 0xa0 byte produces MTE_GRANULES_PER_PAGE ranges of length 1. */
+static void test_tags_to_ranges_repeated(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+
+	memset(td->tags, 0xa0, MTE_PAGE_TAG_STORAGE);
+	tags_to_ranges_to_tags_helper(test);
+
+	KUNIT_EXPECT_EQ(test, td->r_len, MTE_GRANULES_PER_PAGE);
+}
+
+/* Generate a buffer that will contain @nranges of tag ranges. */
+static void gen_tag_range_helper(u8 *tags, int nranges)
+{
+	unsigned int i;
+
+	memset(tags, 0, MTE_PAGE_TAG_STORAGE);
+	if (nranges > 1) {
+		nranges--;
+		for (i = 0; i < nranges / 2; i++)
+			tags[i] = 0xab;
+		if (nranges % 2)
+			tags[nranges / 2] = 0xa0;
+	}
+}
+
+/*
+ * Test that mte_tags_to_ranges()/mte_ranges_to_tags() work for various
+ * r_len values.
+ */
+static void test_tag_to_ranges_n(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	unsigned int i, j, sum;
+
+	for (i = 1; i <= MTE_GRANULES_PER_PAGE; i++) {
+		gen_tag_range_helper(td->tags, i);
+		tags_to_ranges_to_tags_helper(test);
+		sum = 0;
+		for (j = 0; j < td->r_len; j++)
+			sum += td->r_sizes[j];
+		KUNIT_EXPECT_EQ(test, sum, MTE_GRANULES_PER_PAGE);
+	}
+}
+
+/*
+ * Check that the tag buffer in test->priv can be compressed and decompressed
+ * without changes.
+ */
+static void *compress_decompress_helper(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+
+	handle = mte_compress(td->tags);
+	KUNIT_EXPECT_EQ(test, (unsigned long)handle & BIT_ULL(63), 0);
+	if (handle) {
+		KUNIT_EXPECT_TRUE(test, mte_decompress(handle, td->dtags));
+		KUNIT_EXPECT_EQ(test, memcmp(td->tags, td->dtags, MTE_PAGE_TAG_STORAGE),
+				0);
+	}
+	return handle;
+}
+
+/* Test that a zero-filled array is compressed into inline storage. */
+static void test_compress_zero(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	handle = compress_decompress_helper(test);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_TRUE(test, mte_is_compressed(handle));
+}
+
+/* Test that a 0xaa-filled array is compressed into inline storage. */
+static void test_compress_nonzero(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+
+	memset(td->tags, 0xaa, MTE_PAGE_TAG_STORAGE);
+	handle = compress_decompress_helper(test);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_TRUE(test, mte_is_compressed(handle));
+}
+
+/*
+ * Test that two tag ranges are compressed into inline storage.
+ *
+ * This also covers a special case where both ranges contain
+ * `MTE_GRANULES_PER_PAGE / 2` tags and overflow the designated range size.
+ */
+static void test_two_ranges(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+	unsigned int i;
+	size_t r_len = 2;
+	unsigned char r_tags[2] = { 0xe, 0x0 };
+	unsigned short r_sizes[2];
+
+	for (i = 1; i < MTE_GRANULES_PER_PAGE; i++) {
+		r_sizes[0] = i;
+		r_sizes[1] = MTE_GRANULES_PER_PAGE - i;
+		mte_ranges_to_tags(r_tags, r_sizes, r_len, td->tags);
+		handle = compress_decompress_helper(test);
+		KUNIT_EXPECT_TRUE(test, mte_is_compressed(handle));
+	}
+}
+
+/*
+ * Test that a very small number of tag ranges ends up compressed into 8 bytes.
+ */
+static void test_compress_simple(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	td->tags[0] = 0xa0;
+	td->tags[1] = 0x0a;
+
+	handle = compress_decompress_helper(test);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_TRUE(test, mte_is_compressed(handle));
+}
+
+/*
+ * Test that a buffer containing @nranges ranges compresses into @exp_size
+ * bytes and decompresses into the original tag sequence.
+ */
+static void compress_range_helper(struct kunit *test, int nranges,
+				  bool exp_inl)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+
+	gen_tag_range_helper(td->tags, nranges);
+	handle = compress_decompress_helper(test);
+	KUNIT_EXPECT_EQ(test, mte_is_compressed(handle), exp_inl);
+}
+
+static inline size_t max_inline_ranges(void)
+{
+#if defined CONFIG_ARM64_4K_PAGES
+	return 6;
+#elif defined(CONFIG_ARM64_16K_PAGES)
+	return 5;
+#else
+	return 4;
+#endif
+}
+
+/*
+ * Test that every number of tag ranges is correctly compressed and
+ * decompressed.
+ */
+static void test_compress_ranges(struct kunit *test)
+{
+	unsigned int i;
+	bool exp_inl;
+
+	for (i = 1; i <= MTE_GRANULES_PER_PAGE; i++) {
+		exp_inl = i <= max_inline_ranges();
+		compress_range_helper(test, i, exp_inl);
+	}
+}
+
+/*
+ * Test that invalid handles are ignored by mte_decompress().
+ */
+static void test_decompress_invalid(struct kunit *test)
+{
+	void *handle1 = (void *)0xeb0b0b0100804020;
+	void *handle2 = (void *)0x6b0b0b010080402f;
+	struct test_data *td = test->priv;
+
+	/* handle1 has bit 0 set to 1. */
+	KUNIT_EXPECT_FALSE(test, mte_decompress(handle1, td->dtags));
+	/*
+	 * handle2 is an inline handle, but its largest_idx (bits 1..3)
+	 * is out of bounds for the inline storage.
+	 */
+	KUNIT_EXPECT_FALSE(test, mte_decompress(handle2, td->dtags));
+}
+
+/*
+ * Test that compressed inline tags cannot be confused with out-of-line
+ * pointers.
+ *
+ * Compressed values are written from bit 0 to bit 63, so the size of the last
+ * tag range initially ends up in the upper bits of the inline representation.
+ * Make sure mte_compress() rearranges the bits so that the resulting handle does
+ * not have 0b0111 as the upper four bits.
+ */
+static void test_upper_bits(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	void *handle;
+	unsigned char r_tags[6] = { 7, 0, 7, 0, 7, 0 };
+	unsigned short r_sizes[6] = { 1, 1, 1, 1, 1, 1 };
+	size_t r_len;
+
+	/* Maximum number of ranges that can be encoded inline. */
+	r_len = max_inline_ranges();
+	/* Maximum range size possible, will be omitted. */
+	r_sizes[0] = MTE_GRANULES_PER_PAGE / 2 - 1;
+	/* A number close to r_sizes[0] that has most of its bits set. */
+	r_sizes[r_len - 1] = MTE_GRANULES_PER_PAGE - r_sizes[0] - r_len + 2;
+
+	mte_ranges_to_tags(r_tags, r_sizes, r_len, td->tags);
+	handle = compress_decompress_helper(test);
+	KUNIT_EXPECT_TRUE(test, mte_is_compressed(handle));
+}
+
+static void mtecomp_dealloc_testdata(struct test_data *td)
+{
+	kfree(td->tags);
+	kfree(td->dtags);
+	kfree(td->r_sizes);
+	kfree(td->r_tags);
+}
+
+static int mtecomp_test_init(struct kunit *test)
+{
+	struct test_data *td;
+
+	td = kmalloc(sizeof(struct test_data), GFP_KERNEL);
+	if (!td)
+		return 1;
+	td->tags = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	if (!td->tags)
+		goto error;
+	td->dtags = kmalloc(MTE_PAGE_TAG_STORAGE, GFP_KERNEL);
+	if (!td->dtags)
+		goto error;
+	td->r_len = MTE_GRANULES_PER_PAGE;
+	td->r_sizes = kmalloc_array(MTE_GRANULES_PER_PAGE,
+				    sizeof(unsigned short), GFP_KERNEL);
+	if (!td->r_sizes)
+		goto error;
+	td->r_tags = kmalloc(MTE_GRANULES_PER_PAGE, GFP_KERNEL);
+	if (!td->r_tags)
+		goto error;
+	test->priv = (void *)td;
+	return 0;
+error:
+	mtecomp_dealloc_testdata(td);
+	return 1;
+}
+
+static void mtecomp_test_exit(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+
+	mtecomp_dealloc_testdata(td);
+}
+
+static struct kunit_case mtecomp_test_cases[] = {
+	KUNIT_CASE(test_tags_to_ranges_zero),
+	KUNIT_CASE(test_tags_to_ranges_simple),
+	KUNIT_CASE(test_tags_to_ranges_repeated),
+	KUNIT_CASE(test_tag_to_ranges_n),
+	KUNIT_CASE(test_compress_zero),
+	KUNIT_CASE(test_compress_nonzero),
+	KUNIT_CASE(test_two_ranges),
+	KUNIT_CASE(test_compress_simple),
+	KUNIT_CASE(test_compress_ranges),
+	KUNIT_CASE(test_decompress_invalid),
+	KUNIT_CASE(test_upper_bits),
+	{}
+};
+
+static struct kunit_suite mtecomp_test_suite = {
+	.name = "mtecomp",
+	.init = mtecomp_test_init,
+	.exit = mtecomp_test_exit,
+	.test_cases = mtecomp_test_cases,
+};
+kunit_test_suites(&mtecomp_test_suite);
+
+MODULE_IMPORT_NS(MTECOMP);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.43.0.472.g3155946c3a-goog

