Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA8E752204
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjGMM5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234872AbjGMM5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:40 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD27C1BF2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-57745160c1dso5380217b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253058; x=1691845058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d0jpwRf4aooZIScI07t3xs6wVcncXV8ha+jtsM7z/nQ=;
        b=nFut6631mjTAOgoR2gmPO5GuPVrlue6cjFmK0Ckm5EHc1cyNxNvCm7zUisrJUudi1Q
         RaJfyJrG0ZyT23FTrv4ZQ2u3vCeDeY9i+LFL+UjY3Ji2cDc16BUgWsvwdFpI6dmskqxV
         zN/V0IGNr3ysyGnjLnXraW1y0c5RTebqiT/GgQ57HeRuBFGmUSpeB95fetfLdjYshFGb
         iiGAtpAwoa74rMDdCjZ1VL4Ta9wx8L6QFix6f8AyL/hxxrU7NhonaHUwja4szt1l38Yq
         yiTc6BEfBm1Fug9yt3vIEsAw7Abg6UTXnQGxowd/VeOy+l0ArYkwl7tAJuwQQ/E+b8wj
         Lorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253058; x=1691845058;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0jpwRf4aooZIScI07t3xs6wVcncXV8ha+jtsM7z/nQ=;
        b=fq17y5ugWHfWe8NUmTwVSJwx6zkHX2BDTyEvIruw0nh5iCduOv+tB6/d9lR20C77JC
         nADrGEjjpP2pkP4eqFc0J7hUElALKflto2KmA/udfWLi9dEQ8VUVCfXju5NKIqMlJPVs
         KqkENuPtue+6NsyhZQCuYZru0NYe6P6vW8QJiQ2vCq70suN5XfHyCBv2cNEbEU/dj6ni
         7nJrSx4S8IcqELnQNXjZdXwBmJYxLAz/vFxyU8fxsO3xV/jwvK2WR82TAloRDRcnMiR0
         miHR5e7lKMSMKnAO40lS6Ixb7qV50xrscVZHZ+DSiO8sMRzo4lP5GSEBT21SxoCKPUxb
         cVGA==
X-Gm-Message-State: ABy/qLYAuSvi1D5rdccn/Dong7gXtVW+l0m2bbgeoqKfJByl/WWXMZmG
        AZ/BGw30Q28nCTUnKsMG+NI7RRowZoo=
X-Google-Smtp-Source: APBJJlGyKCfFzAbGHoR0SCihpjFPmM7wQ7XzBgJh44FxsoaT+NNOt//wauHqSchSc/F7MrH99i2cdZIEd4c=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a05:6902:1c4:b0:cab:9746:ef0e with SMTP id
 u4-20020a05690201c400b00cab9746ef0emr6467ybh.12.1689253058041; Thu, 13 Jul
 2023 05:57:38 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:04 +0200
In-Reply-To: <20230713125706.2884502-1-glider@google.com>
Mime-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-5-glider@google.com>
Subject: [v2 4/5] arm64: mte: add a test for MTE tags compression
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com
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
 arch/arm64/Kconfig           |  10 ++
 arch/arm64/mm/Makefile       |   1 +
 arch/arm64/mm/test_mtecomp.c | 175 +++++++++++++++++++++++++++++++++++
 3 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/mm/test_mtecomp.c

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0aa727888e746..9473c1e2e8593 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2101,6 +2101,16 @@ config ARM64_MTE_COMP
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
index 0000000000000..67bef6f28dac4
--- /dev/null
+++ b/arch/arm64/mm/test_mtecomp.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test cases for EA0, the compression algorithm for MTE tags.
+ */
+
+#include <asm/mtecomp.h>
+#include <kunit/test.h>
+#include <linux/slab.h>
+#include <linux/types.h>
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
+	u64 handle;
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
+	u64 handle;
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
+	u64 handle;
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
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Alexander Potapenko <glider@google.com>");
-- 
2.41.0.255.g8b1d071c50-goog

