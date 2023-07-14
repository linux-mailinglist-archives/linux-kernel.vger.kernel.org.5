Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1FB75382F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 12:30:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236237AbjGNKan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 06:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbjGNKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 06:30:40 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F9B2710
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 03:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689330639; x=1720866639;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jNcBCjfgpKFqqYeQOT7ZSvB8g0ejk/brWSi//NaBOYY=;
  b=kUisoQbmZ+mbESoz5Hl6i01HaJwpEPS9JO+umSH9tRuifDeCtEiBQVyu
   J3K/H4NbpnWc9jo9vjRacLR0VzPNU/kRkJWFVe+WM3w58+RihdIYM1I9M
   4veNJTsCYnFOZNpv+U+UU2Af8qEirwsaI56FOx5Hz6AD2Ss+TsyZf6avV
   /WOp2sFIsRgmIY9p+hIIv6jHM+SOdkWR+rmUPkk/bAe4O6DEYwT9IpmTz
   tnjvqu/2OJyepKXA+YJfkdBe+xng/wyHufaPkGXJFjWyXVWyyXbKdPoTa
   rlzLp/TWSZrWwR3ewrtfUuFxXR8fMWZcdPEP99cFxATdoAoWzdELn02P6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="429206316"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="429206316"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 03:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="751992057"
X-IronPort-AV: E=Sophos;i="6.01,205,1684825200"; 
   d="scan'208";a="751992057"
Received: from silpixa00400294.ir.intel.com ([10.237.222.100])
  by orsmga008.jf.intel.com with ESMTP; 14 Jul 2023 03:30:37 -0700
From:   Wojciech Ziemba <wojciech.ziemba@intel.com>
To:     broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        qat-linux@intel.com, Wojciech Ziemba <wojciech.ziemba@intel.com>
Subject: [PATCH] lib: Introduce KUnit tests for minmax
Date:   Fri, 14 Jul 2023 11:23:53 +0100
Message-Id: <20230714102353.27814-1-wojciech.ziemba@intel.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds KUnit coverage for minmax_array() macros from
<linux/minmax.h>. It assures that these macros compile correctly
and work as expected when different types are used. The test cases
exercise types: s8, u8, s16, u16, s32, u32, s64, u64 with arrays
of random numbers.

Signed-off-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
---
 lib/Kconfig.debug  |  12 +++++
 lib/Makefile       |   1 +
 lib/minmax_kunit.c | 132 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 145 insertions(+)
 create mode 100644 lib/minmax_kunit.c

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..e845876482fb 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2777,6 +2777,18 @@ config SIPHASH_KUNIT_TEST
 	  This is intended to help people writing architecture-specific
 	  optimized versions.  If unsure, say N.
 
+config MINMAX_KUNIT_TEST
+	tristate "KUnit test for minmax" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Builds KUnit tests module for minmax.
+
+	  For more information on KUnit and unit tests in general please refer
+	  to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+	  If unsure, say N.
+
 config TEST_UDELAY
 	tristate "udelay test driver"
 	help
diff --git a/lib/Makefile b/lib/Makefile
index 42d307ade225..950a3f388e6f 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -396,6 +396,7 @@ obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
 obj-$(CONFIG_STRCAT_KUNIT_TEST) += strcat_kunit.o
 obj-$(CONFIG_STRSCPY_KUNIT_TEST) += strscpy_kunit.o
 obj-$(CONFIG_SIPHASH_KUNIT_TEST) += siphash_kunit.o
+obj-$(CONFIG_MINMAX_KUNIT_TEST) += minmax_kunit.o
 
 obj-$(CONFIG_GENERIC_LIB_DEVMEM_IS_ALLOWED) += devmem_is_allowed.o
 
diff --git a/lib/minmax_kunit.c b/lib/minmax_kunit.c
new file mode 100644
index 000000000000..00ec175156d6
--- /dev/null
+++ b/lib/minmax_kunit.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2023 Intel Corporation
+ *
+ * KUnit test cases for minmax.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <kunit/test.h>
+
+#include <linux/kernel.h>
+#include <linux/minmax.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+#define MINMAX_ARR_TEST(type, op, expected)				\
+	static const type expected_##op##_##type = expected;		\
+static void op##_array_##type##_test(struct kunit *test)		\
+{									\
+	type value = op##_array(test_vector_##type,			\
+				  ARRAY_SIZE(test_vector_##type));	\
+	KUNIT_EXPECT_EQ(test, value, expected_##op##_##type);		\
+}
+
+/* type 's8' */
+static const s8 test_vector_s8[] = {
+	1, 85, -112, -61, 6, 0, 117, -55, 68, -55, 23, 1, -100, 55, -118
+};
+
+MINMAX_ARR_TEST(s8, min, -118)
+MINMAX_ARR_TEST(s8, max, 117)
+
+/* type 'u8' */
+static const u8 test_vector_u8[] = {
+	209, 145, 131, 180, 88, 97, 240, 170, 148, 158, 35, 226, 14, 244, 2
+};
+
+MINMAX_ARR_TEST(u8, min, 2)
+MINMAX_ARR_TEST(u8, max, 244)
+
+/* type 's16' */
+static const s16 test_vector_s16[] = {
+	2641, 30296, -15090, 11371, 13995, 28244, 27482, -7239, -9036, -3147,
+	22065, 2097, -26854, -8633, 13366
+};
+
+MINMAX_ARR_TEST(s16, min, -26854)
+MINMAX_ARR_TEST(s16, max, 30296)
+
+/* type 'u16' */
+static const u16 test_vector_u16[] = {
+	50102, 58387, 42350, 33531, 32109, 65525, 25985, 31889, 14772, 7296,
+	48242, 53340, 33594, 19856, 45544
+};
+
+MINMAX_ARR_TEST(u16, min, 7296)
+MINMAX_ARR_TEST(u16, max, 65525)
+
+/* type 's32' */
+static const s32 test_vector_s32[] = {
+	979885732L, 885950778L, -1450966230L, -1624192399L, -1753023734L,
+	530868381L, 656215973L, 630677997L, 391000329L, 1253640357L,
+	438040531L, -993355872L, 585127620L, -1068766240L, 147051568L
+};
+
+MINMAX_ARR_TEST(s32, min, -1753023734L)
+MINMAX_ARR_TEST(s32, max, 1253640357L)
+
+/* type 'u32' */
+static const u32 test_vector_u32[] = {
+	2161504111UL, 1183092838UL, 1728689175UL, 2309150449UL, 3735269177UL,
+	1550306875UL, 2147576091UL, 4187089172UL, 545942284UL, 1969608375UL,
+	2624877400UL, 3029665375UL, 1293120185UL, 3801307680UL, 1161238802UL
+};
+
+MINMAX_ARR_TEST(u32, min, 545942284UL)
+MINMAX_ARR_TEST(u32, max, 4187089172UL)
+
+/* type 's64' */
+static const s64 test_vector_s64[] = {
+	-8438490804591620000LL, 8025377321703520000LL, 3208690154945970000LL,
+	-2321767394263770000LL, -1278489889635390000LL, 2190470827346570000LL,
+	-2022822382784580000LL, 6599789147713410000LL, 3949996236706410000LL,
+	-8261935734503760000LL, 661645293834217000LL, 8346383784731440000LL,
+	-3443819189603500000LL, 7985744187902840000LL, 5083298007916820000LL
+};
+
+MINMAX_ARR_TEST(s64, min, -8438490804591620000LL)
+MINMAX_ARR_TEST(s64, max, 8346383784731440000LL)
+
+/* type 'u64' */
+static const u64 test_vector_u64[] = {
+	8249683091780880000ULL, 13192984997103100000ULL, 17673970905507700000ULL,
+	11101419446779000000ULL, 7059417167478820000ULL, 17488355550255500000ULL,
+	1592214570100350000ULL, 4324504718429290000ULL, 9233486922226120000ULL,
+	17205873265072200000ULL, 15951973546886800000ULL, 8694358874973410000ULL,
+	11857168979503600000ULL, 15015693759541800000ULL, 4758196429468010000ULL
+};
+
+MINMAX_ARR_TEST(u64, min, 1592214570100350000ULL)
+MINMAX_ARR_TEST(u64, max, 17673970905507700000ULL)
+#undef MINMAX_ARR_TEST
+
+static struct kunit_case minmax_array_test_cases[] = {
+	KUNIT_CASE(min_array_s8_test),
+	KUNIT_CASE(max_array_s8_test),
+	KUNIT_CASE(min_array_u8_test),
+	KUNIT_CASE(max_array_u8_test),
+	KUNIT_CASE(min_array_s16_test),
+	KUNIT_CASE(max_array_s16_test),
+	KUNIT_CASE(min_array_u16_test),
+	KUNIT_CASE(max_array_u16_test),
+	KUNIT_CASE(min_array_s32_test),
+	KUNIT_CASE(max_array_s32_test),
+	KUNIT_CASE(min_array_u32_test),
+	KUNIT_CASE(max_array_u32_test),
+	KUNIT_CASE(min_array_s64_test),
+	KUNIT_CASE(max_array_s64_test),
+	KUNIT_CASE(min_array_u64_test),
+	KUNIT_CASE(max_array_u64_test),
+	{}
+};
+
+static struct kunit_suite minmax_test_suite = {
+	.name = "minmax_array",
+	.test_cases = minmax_array_test_cases,
+};
+kunit_test_suite(minmax_test_suite);
+
+MODULE_AUTHOR("Intel");
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("KUnit test module for minmax");
-- 
2.38.1

