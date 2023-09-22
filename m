Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94047AABE8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjIVIJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjIVIJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:12 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24DC10C7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:03 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bf37b7734so28036767b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370143; x=1695974943; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QO5mfEasjHX0NR/arjcV00dOpfY7EEoHsjugtLpi5E=;
        b=3ygtYUtKm0+6DI6L77n3qMjKRHcaJVA/dwq5QdssB6VftHUSUu2xs1gjBxanZZsfg+
         ipIJjGJZMKNutVYKNKiEb2iwmM7dftlbp7+6Vhn+GptdOPpH/nEAE+CXamrbUAE59ywL
         xj0Hn07XkQ7hq9y1nsgRldk+rOipsl2TpLKRThK7cP4q0uIXJRkEBOUmsCcRKrTeRX5L
         NwuKrB1kxB3neQX8Ejnuo1SZ1XJPvTrmR4tF38YCideNvsB3cXi+mRyBsJVsXnhcAavZ
         1Q/g+xWwoHHN/Qp+2prtvPxgn7t4eQ9+D9xoKL2192x/iL7YH/h0WQp5KOVRn9rPJFfX
         lyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370143; x=1695974943;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QO5mfEasjHX0NR/arjcV00dOpfY7EEoHsjugtLpi5E=;
        b=cAaaIhtCidbYIEtkPdV8JLAiKHU+1HKtvUkkHo6LQbk/6HAml61pjBUTqdXWx8EWoT
         u3cq0uYqHKF2AdvLevLKoi/LCRqW7qsATfrS/pj52Jainr0JmI0tN25TFfz4H+CAr0Zk
         sK1ljE3r6U6kWZgXCpE0NsMH4kZhiwPqL2BBlpXCqadGbJLgdTBVKC5NVQBT6KBf2FgT
         PcLWedolEhQTHZ5akCwwRKjP4DAztTCpuyzboiew+zPyTdSk0v4dh5cnsnqUdVlrACoB
         cnQESvKjjnO6s74NSbKMXZWf6/eZR1Y75DvSLUsnq6S4FkB/Cxf9sOFJSr1fD72xbk5l
         iq2Q==
X-Gm-Message-State: AOJu0Yw6XT1S56QgvBIMrwlwH9gMnbeJX4U1TWtWt9JfB9Ce1IbY3Vz9
        MbrklWdG8bC1MTE4j4NIaHdctEkatOs=
X-Google-Smtp-Source: AGHT+IHrud/yOPjAF9NSmt6x8qB3a4umVmkVlXQUA3JKsm6S+s3XkApQDce/90OMuQ64tXoLcZPaoAyO5Do=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a81:d105:0:b0:59c:b9b:8940 with SMTP id
 w5-20020a81d105000000b0059c0b9b8940mr116755ywi.8.1695370142882; Fri, 22 Sep
 2023 01:09:02 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:46 +0200
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Mime-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-5-glider@google.com>
Subject: [PATCH v5 4/5] arm64: mte: add a test for MTE tags compression
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that tag sequences containing alternating values are compressed
to buffers of expected size and correctly decompressed afterwards.

Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 arch/arm64/Kconfig           |  10 ++
 arch/arm64/mm/Makefile       |   1 +
 arch/arm64/mm/test_mtecomp.c | 287 +++++++++++++++++++++++++++++++++++
 3 files changed, 298 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d4fb3b8d11d77..ffe3bec89df82 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2104,6 +2104,16 @@ config ARM64_MTE_COMP
 	  RLE to conserve heap memory. In the common case compressed tags
 	  occupy 2.5x less memory.
 
+config ARM64_MTE_COMP_KUNIT_TEST
+	tristate "Test tag compression for ARM64 Memory Tagging Extension" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on KUNIT && ARM64_MTE_COMP
+	help
+	  Test MTE compression algorithm enabled by CONFIG_ARM64_MTE_COMP.
+
+	  Ensure that tag sequences containing alternating values are compressed
+	  to buffers of expected size and correctly decompressed afterwards.
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
index 0000000000000..2a4a53daa7b1b
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,287 @@
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
+static unsigned long compress_decompress_helper(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	unsigned long handle;
+
+	handle = mte_compress(td->tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	KUNIT_EXPECT_TRUE(test, mte_decompress(handle, td->dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(td->tags, td->dtags, MTE_PAGE_TAG_STORAGE),
+			0);
+	return handle;
+}
+
+/* Test that a zero-filled array is compressed into inline storage. */
+static void test_compress_zero(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	unsigned long handle;
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	handle = compress_decompress_helper(test);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), 8);
+	mte_release_handle(handle);
+}
+
+/*
+ * Test that a very small number of tag ranges ends up compressed into 8 bytes.
+ */
+static void test_compress_simple(struct kunit *test)
+{
+	struct test_data *td = test->priv;
+	unsigned long handle;
+
+	memset(td->tags, 0, MTE_PAGE_TAG_STORAGE);
+	td->tags[0] = 0xa0;
+	td->tags[1] = 0x0a;
+
+	handle = compress_decompress_helper(test);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), 8);
+	mte_release_handle(handle);
+}
+
+/*
+ * Test that a buffer containing @nranges ranges compresses into @exp_size
+ * bytes and decompresses into the original tag sequence.
+ */
+static void compress_range_helper(struct kunit *test, int nranges,
+				  size_t exp_size)
+{
+	struct test_data *td = test->priv;
+	unsigned long handle;
+
+	gen_tag_range_helper(td->tags, nranges);
+	handle = compress_decompress_helper(test);
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), exp_size);
+	mte_release_handle(handle);
+}
+
+static size_t expected_size_from_ranges(unsigned int ranges)
+{
+#if defined CONFIG_ARM64_4K_PAGES
+	unsigned int range_exp[4] = { 6, 11, 23, 46 };
+#elif defined(CONFIG_ARM64_16K_PAGES)
+	unsigned int range_exp[6] = { 5, 9, 19, 39, 78, 157 };
+#elif defined(CONFIG_ARM64_64K_PAGES)
+	unsigned int range_exp[8] = { 4, 8, 17, 34, 68, 136, 273, 546 };
+#endif
+	unsigned int i;
+	size_t size = 8;
+
+	for (i = 0; i < ARRAY_SIZE(range_exp); i++) {
+		if (ranges <= range_exp[i])
+			return size;
+		size <<= 1;
+	}
+	return size;
+}
+
+/*
+ * Test that every number of tag ranges is correctly compressed and
+ * decompressed.
+ */
+static void test_compress_ranges(struct kunit *test)
+{
+	size_t exp_size;
+	unsigned int i;
+
+	for (i = 1; i <= MTE_GRANULES_PER_PAGE; i++) {
+		exp_size = expected_size_from_ranges(i);
+		compress_range_helper(test, i, exp_size);
+	}
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
+	KUNIT_CASE(test_compress_simple),
+	KUNIT_CASE(test_compress_ranges),
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
2.42.0.515.g380fc7ccd1-goog

