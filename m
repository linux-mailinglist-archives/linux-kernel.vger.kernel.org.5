Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C19C75B5CC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGTRk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjGTRkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:22 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE6AC271E
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:13 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-992e6840901so133130166b.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874812; x=1690479612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFdlPS8QU525qbseVaI8WzYFYY2eCpYrAzmO7CfAnMA=;
        b=gJXMrH2tT491ow+xnauMdpysCLCAJ+RDEqD/SLy8C4UJb3ZHOSt+HPScELWiPnd6Hl
         EgPVzLs9fAJxMtb9Wq/SxTw3WytI13SVmdB8ORp+iTzTCcxDvlsKylsoui07QxQDInAD
         /9FMahDgy322UqZZ75gamiyd8g0G2vz5W/jVlwICHmroyaH/dHKSYTV4aNFxQC03JJna
         likRyW3LmN0QMyvv1FGPqtSV36h9M+3NjKDniqhaokMRI7LAP642BRS+yNxhzF59nEa2
         P45LzS/pBT/tgHOWdHlIvkWorFdwQgBTOK2XkBkRvE60ydAvvvczDdq0r/nO1GulTWSP
         Bbbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874812; x=1690479612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFdlPS8QU525qbseVaI8WzYFYY2eCpYrAzmO7CfAnMA=;
        b=QFwtr8IhU4kMi/A/F/LcHSI1E2zvSMTsgdB2+NdGFKc5r4nV5UCJWI333g4td2N3xQ
         L5K5Ts78ofB0bAr6SrYM1UeTZUSn8AS9CmBz70PrybWPfBDPoxFSQ2b2i3Im5ON8K5YC
         /xscwAnGly4bJIgcxw/u2pXnjzbEFfXL175VxmbxlnzoKOsNdXY3kRUbAgGSzrPtCn2M
         hA90igDy5kJY/bMezl3sC2XGq+HR6+L9aFo1z4GzfgKb+2zpeuodUOnMBERP2TLmg7s6
         3NMam2vaJmSFxYS1bIUPWtKnq+lCDEFSkZpxYhw65eCVmFtTXLXTnTID9PUX/O21hTQg
         koiQ==
X-Gm-Message-State: ABy/qLYYv+bOF4+a89CFnHJPqMrjYS/i9YTImrvyqzxHbqp2laf9n2Td
        byOZfgBkOIM0XFEfxIAtFhyKvlsp1M8=
X-Google-Smtp-Source: APBJJlElRD+VfI5teixL3w8qtS/2YeCEI0Sjn5/koYwrP6GxqBQLWhchia4hn1WKPns4amyXNoZ983lWI+Q=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a17:907:2ccc:b0:98e:4bf5:8fd6 with SMTP id
 hg12-20020a1709072ccc00b0098e4bf58fd6mr28414ejc.6.1689874812257; Thu, 20 Jul
 2023 10:40:12 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:55 +0200
In-Reply-To: <20230720173956.3674987-1-glider@google.com>
Mime-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-5-glider@google.com>
Subject: [PATCH v4 4/5] arm64: mte: add a test for MTE tags compression
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
 arch/arm64/mm/test_mtecomp.c | 217 +++++++++++++++++++++++++++++++++++
 3 files changed, 228 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 3ac6e302b1509..2432475003054 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2102,6 +2102,16 @@ config ARM64_MTE_COMP
 
 	  128-byte tag buffers corresponding to 4K pages can be compressed to save heap memory.
 
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
index 0000000000000..185eb6cb73650
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for MTE tags compression algorithm.
+ */
+
+#include <linux/bits.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <kunit/test.h>
+#include <linux/types.h>
+
+#include <asm/mtecomp.h>
+
+/* Functions exported from mtecomp.c for this test. */
+void mte_tags_to_ranges(u8 *tags, u8 *out_tags, unsigned short *out_sizes,
+			size_t *out_len);
+void mte_ranges_to_tags(u8 *r_tags, unsigned short *r_sizes, size_t r_len,
+			u8 *tags);
+
+/*
+ * Test that mte_tags_to_ranges() produces a single range for a zero-filled tag
+ * buffer.
+ */
+static void test_tags_to_ranges_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	unsigned short r_sizes[256];
+	size_t r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 1);
+	KUNIT_EXPECT_EQ(test, r_tags[0], 0);
+	KUNIT_EXPECT_EQ(test, r_sizes[0], 256);
+	mte_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
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
+	const unsigned short ex_sizes[] = { 1, 2, 2, 1, 250 };
+	unsigned short r_sizes[256];
+	size_t r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0, 128);
+	tags[0] = 0xa0;
+	tags[1] = 0x0a;
+	tags[2] = 0xab;
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 5);
+	KUNIT_EXPECT_EQ(test, memcmp(r_tags, ex_tags, sizeof(ex_tags)), 0);
+	KUNIT_EXPECT_EQ(test, memcmp(r_sizes, ex_sizes, sizeof(ex_sizes)), 0);
+	mte_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Test that repeated 0xa0 byte produces 256 ranges of length 1. */
+static void test_tags_to_ranges_repeated(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	unsigned short r_sizes[256];
+	size_t r_len = 256;
+	u8 r_tags[256];
+
+	memset(tags, 0xa0, 128);
+	mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+	KUNIT_EXPECT_EQ(test, r_len, 256);
+	mte_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/* Generate a buffer that will contain @nranges of tag ranges. */
+static void gen_tag_range_helper(u8 *tags, int nranges)
+{
+	unsigned int i;
+
+	memset(tags, 0, 128);
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
+	unsigned short r_sizes[256];
+	u8 tags[128], dtags[128];
+	unsigned int i, j, sum;
+	size_t r_len = 256;
+	u8 r_tags[256];
+
+	for (i = 1; i <= 256; i++) {
+		gen_tag_range_helper(tags, i);
+		mte_tags_to_ranges(tags, r_tags, r_sizes, &r_len);
+		sum = 0;
+		for (j = 0; j < r_len; j++)
+			sum += r_sizes[j];
+		KUNIT_EXPECT_EQ(test, sum, 256);
+		mte_ranges_to_tags(r_tags, r_sizes, r_len, dtags);
+		KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+	}
+}
+
+/* Test that a zero-filled array is compressed into inline storage. */
+static void test_compress_zero(struct kunit *test)
+{
+	u8 tags[128], dtags[128];
+	unsigned long handle;
+
+	memset(tags, 0, 128);
+	handle = mte_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, mte_decompress(handle, dtags));
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
+	handle = mte_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	/* Tags are stored inline. */
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), 8);
+	KUNIT_EXPECT_TRUE(test, mte_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
+}
+
+/*
+ * Test that a buffer containing @nranges ranges compresses into @exp_size
+ * bytes and decompresses into the original tag sequence.
+ */
+static void compress_range_helper(struct kunit *test, int nranges,
+				  size_t exp_size)
+{
+	u8 tags[128], dtags[128];
+	unsigned long handle;
+
+	gen_tag_range_helper(tags, nranges);
+	handle = mte_compress(tags);
+	KUNIT_EXPECT_EQ(test, handle & BIT_ULL(63), 0);
+	KUNIT_EXPECT_EQ(test, mte_storage_size(handle), exp_size);
+	KUNIT_EXPECT_TRUE(test, mte_decompress(handle, dtags));
+	KUNIT_EXPECT_EQ(test, memcmp(tags, dtags, 128), 0);
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
+	KUNIT_CASE(test_tag_to_ranges_n),
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
2.41.0.487.g6d72f3e995-goog

