Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55FA7561B4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjGQLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjGQLhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:37:35 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670A10FB
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:27 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-99388334de6so250018966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689593846; x=1692185846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxhXbzRzEXNMQJKI4jN/6duvQjIZi8dRPcJNuvEcxk0=;
        b=Yj3KZF9xhrnATVqtjzVrgRfACSYo06veH+hKGbTh+/ol0JW3he8L6TOacW/5oHw3VU
         z04ah5o2UotYtUIJYGqwDIJMe3tWSLWEsM8PP+UOGP1oWE8aLis64hG4VYzJNf8hb5F/
         KYn0Q9gbMYYc26OeWLOSkWZbkiFezxR7alAwcgc7iCsjIG0VsDvwG0z6oBE8r8ZjqpZu
         Hotz0uK+/VLUyK16NP8my5LEQiw32jw4bZk1/nJMpMubSXWSUAbXTjQ+s9XJ3rA78Csr
         sWzjaTZxBk0fz8cAkeaBjhDoTxfBt5qD6XBWLrgPyLWdaFVx0+xrgfKEAF46b4wjJCvT
         IviQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689593846; x=1692185846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dxhXbzRzEXNMQJKI4jN/6duvQjIZi8dRPcJNuvEcxk0=;
        b=WZHJca7CMilEfmV8vbZ9BmvIVlZyZnrI6+T8KIDJUHGcJ3rNam3lWP9TzNm858Dzxz
         +Zq1Z2zIvdMJ6h1excUiTB79HGu21ZmwcveSFOXolZT5psAdTXF7j+sT/kY3JOvc0NDT
         cwbtAY/bdFw50UZn5+rQWmnCtDD48H+uxaIFdxgSJPW497p9jCLfuW28rg61xWzPYwc0
         q+haOtWdsk6shHOw+S9EZ37l8hab4EP+TcGkp99Er57Tbrb3Z36MITM0nCpKKg6sUlwc
         WcU+pAsL5JNbUtH7m9VjPhnDoZUZffnwu8vEVFmt/GUZfKzJuX7lpaaKtM1AvFfanjDp
         68fw==
X-Gm-Message-State: ABy/qLbCHHCmFtSTlzxQ33/n/KlsRF3PE0U4OepsNzOGLscO7KG9y62C
        V8UWSvaIHfoeOlwRbu0KQMaKWgqdkLM=
X-Google-Smtp-Source: APBJJlGm2UePumXkWS+bdhj8++/Jeg8XaImbmk1a+fI2d0xDNPSayzlPwJspz5MQe5WKzuZGOQMFzDIiitg=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:3b6e:8102:6db8:d83f])
 (user=glider job=sendgmr) by 2002:a17:907:270d:b0:994:4edd:34a2 with SMTP id
 w13-20020a170907270d00b009944edd34a2mr30786ejk.2.1689593846330; Mon, 17 Jul
 2023 04:37:26 -0700 (PDT)
Date:   Mon, 17 Jul 2023 13:37:07 +0200
In-Reply-To: <20230717113709.328671-1-glider@google.com>
Mime-Version: 1.0
References: <20230717113709.328671-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230717113709.328671-5-glider@google.com>
Subject: [PATCH v3 4/5] arm64: mte: add a test for MTE tags compression
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
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

---
 v3:
  - addressed comments by Andy Shevchenko in another patch:
   - switched from u64 to unsigned long
   - added MODULE_IMPORT_NS(MTECOMP)
   - fixed includes order
---
 arch/arm64/Kconfig           |  10 ++
 arch/arm64/mm/Makefile       |   1 +
 arch/arm64/mm/test_mtecomp.c | 177 +++++++++++++++++++++++++++++++++++
 3 files changed, 188 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 52cdc7603cf7c..a6f1a36e8d27b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2103,6 +2103,16 @@ config ARM64_MTE_COMP
 	  128-byte tag buffers corresponding to 4K pages can be compressed using
 	  the EA0 algorithm to save heap memory.
 
+config ARM64_MTE_COMP_KUNIT_TEST
+	tristate "Test tag compression for ARM64 MTE" if !KUNIT_ALL_TESTS
+	default KUNIT_ALL_TESTS
+	depends on KUNIT && ARM64_MTE_COMP
+	help
+	  Test EA0 compression algorithm enabled by CONFIG_ARM64_MTE_COMP.
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
index 0000000000000..bb71c6224e34a
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for EA0, the compression algorithm for MTE tags.
+ */
+
+#include <kunit/test.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/mtecomp.h>
+
+/*
+ * Test that ea0_tags_to_ranges() produces a single range for a zero-filled tag
+ * buffer.
+ */
+static void test_tags_to_ranges_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 1);
+	KUNIT_EXPECT_EQ(test, r_tags[0], 0);
+	KUNIT_EXPECT_EQ(test, r_sizes[0], 256);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that a small number of different tags is correctly transformed into
+ * ranges.
+ */
+static void test_tags_to_ranges_simple(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	const u8 ex_tags[] = { 0xa, 0x0, 0xa, 0xb, 0x0 };
+	const short ex_sizes[] = { 1, 2, 2, 1, 250 };
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	tags[0] = 0xa0;
+	tags[1] = 0x0a;
+	tags[2] = 0xab;
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 5);
+	KUNIT_EXPECT_EQ(test, memcmp(r_tags, ex_tags, sizeof(ex_tags)), 0);
+	KUNIT_EXPECT_EQ(test, memcmp(r_sizes, ex_sizes, sizeof(ex_sizes)), 0);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Test that repeated 0xa0 byte produces 256 ranges of length 1. */
+static void test_tags_to_ranges_repeated(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	short r_sizes[256];
+	int r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0xa0, 128);
+	ea0_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 256);
+	ea0_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Test that a zero-filled array is compressed into inline storage. */
+static void test_compress_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	unsigned long handle;
+
+	memset(tags, 0, 128);
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that a very small number of tag ranges ends up compressed into 8 bytes.
+ */
+static void test_compress_simple(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	unsigned long handle;
+
+	memset(tags, 0, 128);
+	tags[0] = 0xa0;
+	tags[1] = 0x0a;
+	tags[2] = 0xab;
+
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Generate a buffer that will contain @nranges of tag ranges, test that it
+ * compresses into @exp_size bytes and decompresses into the original tag
+ * sequence.
+ */
+static void compress_range_helper(struct kunit *test, int nranges, int exp_size)
+{
+	u8 tags[128], dtags[128];
+	unsigned long handle;
+	int i;
+
+	memset(tags, 0, 128);
+
+	if (nranges > 1) {
+		nranges--;
+		for (i = 0; i < nranges / 2; i++)
+			tags[i] = 0xab;
+		if (nranges % 2)
+			tags[nranges / 2] = 0xa0;
+	}
+
+	handle = ea0_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	KUNIT_EXPECT_EQ(test, ea0_storage_size(handle), exp_size);
+	KUNIT_EXPECT_TRUE(test, ea0_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that every number of tag ranges is correctly compressed and
+ * decompressed.
+ */
+static void test_compress_ranges(struct kunit *test)
+{
+	int i, exp_size;
+
+	for (i = 1; i <= 256; i++) {
+		if (i < 7)
+			exp_size = 8;
+		else if (i < 12)
+			exp_size = 16;
+		else if (i < 24)
+			exp_size = 32;
+		else if (i < 47)
+			exp_size = 64;
+		else
+			exp_size = 128;
+		compress_range_helper(test, i, exp_size);
+	}
+}
+
+static struct kunit_case mtecomp_test_cases[] = {
+	KUNIT_CASE(test_tags_to_ranges_zero),
+	KUNIT_CASE(test_tags_to_ranges_simple),
+	KUNIT_CASE(test_tags_to_ranges_repeated),
+	KUNIT_CASE(test_compress_zero),
+	KUNIT_CASE(test_compress_simple),
+	KUNIT_CASE(test_compress_ranges),
+	{}
+};
+
+static struct kunit_suite mtecomp_test_suite = {
+	.name = "mtecomp",
+	.test_cases = mtecomp_test_cases,
+};
+kunit_test_suites(&mtecomp_test_suite);
+
+MODULE_IMPORT_NS(MTECOMP);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.41.0.255.g8b1d071c50-goog

