Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886E57AE4F7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 07:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjIZFUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 01:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjIZFUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 01:20:32 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFB9D7;
        Mon, 25 Sep 2023 22:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695705625; x=1727241625;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JNhOP0h4Wmvb7AtoOm+qvjG9Eh0xhQGc8R2E+oO+zNM=;
  b=HYrP7gRNwuPuH2loLskcgJ1okqzq4Dp1u93tOPg0J6hexFP6+Ga9MK2r
   T8eXZuPGT4nnbXqyJRKs6cMWi5+kHkWGBTKIT+1s8xy0j7aZzfdB5i3So
   WG0KKdMGyWO0KYnKZv/VW027QVl5ABrOGAl1D3s/FvdrC8DvMwpry3Eff
   WmxUjMdN9xuM7IIJkf5w46c4axnDw2n9yd0bTNmA+Aa+RQ11Z5xigdCNA
   QqyHMp1z0pKoCZJ8R2+R3gWo4K5ekOXd0Ud36vKnf9zjzQ6E/SKxdjE3i
   BtnDKFPT+PffaGIY3PzHqWvz4l9gZ/j6/c04QQWgCBI8YdDVRsaTTvOEQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371820573"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="371820573"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 22:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="783824216"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="783824216"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 25 Sep 2023 22:20:20 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E7E8117D; Tue, 26 Sep 2023 08:20:18 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Yury Norov <yury.norov@gmail.com>, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>,
        Srinivas Neeli <srinivas.neeli@amd.com>,
        Michal Simek <michal.simek@amd.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: [PATCH v1 2/5] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
Date:   Tue, 26 Sep 2023 08:20:04 +0300
Message-Id: <20230926052007.3917389-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
In-Reply-To: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
References: <20230926052007.3917389-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These helpers are the optimized versions of the bitmap_remap()
where one of the bitmaps (source or destination) is of sequential bits.

See more in the kernel documentation of the helpers.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/bitmap.h |  9 ++++++
 lib/bitmap.c           | 70 ++++++++++++++++++++++++++++++++++++++++++
 lib/test_bitmap.c      | 23 ++++++++++++++
 3 files changed, 102 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1516ff979315..87013b9a7dd8 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -60,6 +60,8 @@ struct device;
  *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
  *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
  *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
+ *  bitmap_scatter(dst, src, mask, nbits)	*dst = map(dense, sparse)(src)
+ *  bitmap_gather(dst, src, mask, nbits)	*dst = map(sparse, dense)(src)
  *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
  *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
  *  bitmap_onto(dst, orig, relmap, nbits)       *dst = orig relative to relmap
@@ -208,6 +210,12 @@ int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
+
+unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
+		const unsigned long *mask, unsigned int nbits);
+unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
+		const unsigned long *mask, unsigned int nbits);
+
 void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
 int bitmap_bitremap(int oldbit,
@@ -216,6 +224,7 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
+
 int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
 void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
 int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 935e0f96e785..31cfc7846aae 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -942,6 +942,76 @@ int bitmap_parse(const char *start, unsigned int buflen,
 }
 EXPORT_SYMBOL(bitmap_parse);
 
+/**
+ * bitmap_scatter - Scatter a bitmap according to the given mask
+ * @dst: scattered bitmap
+ * @src: gathered bitmap
+ * @mask: bits to assign to in the scattered bitmap
+ * @nbits: number of bits in each of these bitmaps
+ *
+ * Scatters bitmap with sequential bits according to the given @mask.
+ *
+ * Example:
+ * If @src bitmap = 0x005a, with @mask = 0x1313, @dst will be 0x0302.
+ *
+ * Or in binary form
+ * @src			@mask			@dst
+ * 0000000001011010	0001001100010011	0000001100000010
+ *
+ * (Bits 0, 1, 2, 3, 4, 5 are copied to the bits 0, 1, 4, 8, 9, 12)
+ *
+ * Returns: the weight of the @mask.
+ */
+unsigned int bitmap_scatter(unsigned long *dst, const unsigned long *src,
+			    const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int bit;
+	int n = 0;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(bit, dst, test_bit(n++, src));
+
+	return n;
+}
+EXPORT_SYMBOL(bitmap_scatter);
+
+/**
+ * bitmap_gather - Gather a bitmap according to given mask
+ * @dst: gathered bitmap
+ * @src: scattered bitmap
+ * @mask: bits to extract from in the scattered bitmap
+ * @nbits: number of bits in each of these bitmaps
+ *
+ * Gathers bitmap with sparse bits according to the given @mask.
+ *
+ * Example:
+ * If @src bitmap = 0x0302, with @mask = 0x1313, @dst will be 0x001a.
+ *
+ * Or in binary form
+ * @src			@mask			@dst
+ * 0000001100000010	0001001100010011	0000000000011010
+ *
+ * (Bits 0, 1, 4, 8, 9, 12 are copied to the bits 0, 1, 2, 3, 4, 5)
+ *
+ * Returns: the weight of the @mask.
+ */
+unsigned int bitmap_gather(unsigned long *dst, const unsigned long *src,
+			   const unsigned long *mask, unsigned int nbits)
+{
+	unsigned int bit;
+	int n = 0;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(bit, mask, nbits)
+		__assign_bit(n++, dst, test_bit(bit, src));
+
+	return n;
+}
+EXPORT_SYMBOL(bitmap_gather);
+
 /**
  * bitmap_pos_to_ord - find ordinal of set bit at given position in bitmap
  *	@buf: pointer to a bitmap
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 1f2dc7fef17f..f43a07679998 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -50,6 +50,9 @@ static const unsigned long exp2[] __initconst = {
 static const unsigned long exp2_to_exp3_mask[] __initconst = {
 	BITMAP_FROM_U64(0x008000020020212eULL),
 };
+static const unsigned long exp2_to_exp3_maskg[] __initconst = {
+	BITMAP_FROM_U64(0x00000000000001ffULL),
+};
 /* exp3_0_1 = (exp2[0] & ~exp2_to_exp3_mask) | (exp2[1] & exp2_to_exp3_mask) */
 static const unsigned long exp3_0_1[] __initconst = {
 	BITMAP_FROM_U64(0x33b3333311313137ULL),
@@ -357,6 +360,25 @@ static void __init test_replace(void)
 	expect_eq_bitmap(bmap, exp3_1_0, nbits);
 }
 
+static void __init test_bitmap_sg(void)
+{
+	unsigned int nbits = 64;
+	DECLARE_BITMAP(bmap, 1024);
+	unsigned int w;
+
+	bitmap_zero(bmap, 1024);
+	w = bitmap_gather(bmap, exp2_to_exp3_mask, exp2_to_exp3_mask, nbits);
+	expect_eq_uint(bitmap_weight(exp2_to_exp3_mask, nbits), w);
+	expect_eq_uint(bitmap_weight(bmap, 1024), w);
+	expect_eq_bitmap(bmap, exp2_to_exp3_maskg, nbits);
+
+	bitmap_zero(bmap, 1024);
+	w = bitmap_scatter(bmap, exp2_to_exp3_maskg, exp2_to_exp3_mask, nbits);
+	expect_eq_uint(bitmap_weight(exp2_to_exp3_maskg, nbits), w);
+	expect_eq_uint(bitmap_weight(bmap, 1024), w);
+	expect_eq_bitmap(bmap, exp2_to_exp3_mask, nbits);
+}
+
 #define PARSE_TIME	0x1
 #define NO_LEN		0x2
 
@@ -1228,6 +1250,7 @@ static void __init selftest(void)
 	test_fill_set();
 	test_copy();
 	test_replace();
+	test_bitmap_sg();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
 	test_bitmap_parse();
-- 
2.40.0.1.gaa8946217a0b

