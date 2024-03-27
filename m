Return-Path: <linux-kernel+bounces-121513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ACA588E919
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C4F323C6C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFAF1411D2;
	Wed, 27 Mar 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OW++ry41"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3AF137C58;
	Wed, 27 Mar 2024 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553093; cv=none; b=i3A/MBtQyc8uxXSPyF83Cg03IPpLmQ/EdxV30XOnShy1aTDVR44Ajsp2QkfIAmoXvDXXKDeYva+d4iLEFAzYpESdkiZO3dq4gkeXVnhBpAfRcwpP1oWFiE9Dx/VmaGSOq8KWUOTERnM+Ah7DpdqeqRjFLoqyKhZV2KDbWyDzz7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553093; c=relaxed/simple;
	bh=nlAv8DcC/nsFTR/JMjfsbTOZRgfJCpZQWTDLxH5GJ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgYR1XtV9l5wRPKJB0kNX4pLK1LTFfMo7wOcImFWl0wZG1fiY4STUufVdQMnxZL8BkKJBNqObss2DtrEHJzERn/Gx6HVX618H0VdsJp+5N41FnsGFHZsHxrGTEK/Q2ilYAqX0TSja8PEC6dikCYBCgbyhldujh6kYA3oDZosp+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OW++ry41; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711553091; x=1743089091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nlAv8DcC/nsFTR/JMjfsbTOZRgfJCpZQWTDLxH5GJ+w=;
  b=OW++ry419FY1ANmKwhVc3xqCQK8F4QFcWfvQARmXZgmfoyzxO//cIM6u
   jQX894rrx282Hh68SppIQZ6p1wDrQF36kvBRdXrkW95EVCv73KqzbmjEN
   1jFWMpT52Js+ggjEa/v7OcV3vgeoIpuOdotsbqA7bBDV7fUwkyNUDkvRE
   Pr90Qei7opwRsnBaGF8Aaa+ZbYm1b/m/rozaHFScFdlEmTDV0SZ0GsTtd
   hfJgmzBP+zCjCQBoo+9vdyWkaxYrpS7JwDrQkR7Ov6xLFHcUmGjwVnLPD
   NKfGVGPZhLFjfvxZxSjRNCmgcnlOM4b25DRwhpifCXQutXahyYLKfZKDJ
   w==;
X-CSE-ConnectionGUID: cTOZcIBRSCCJciD9dY+wEA==
X-CSE-MsgGUID: Xq6S+T4XTmyZ0rx4ZPSGcQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6518096"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6518096"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 08:24:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="16414091"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa008.fm.intel.com with ESMTP; 27 Mar 2024 08:24:40 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Yury Norov <yury.norov@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH net-next v6 02/21] lib/test_bitmap: add tests for bitmap_{read,write}()
Date: Wed, 27 Mar 2024 16:23:39 +0100
Message-ID: <20240327152358.2368467-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
References: <20240327152358.2368467-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexander Potapenko <glider@google.com>

Add basic tests ensuring that values can be added at arbitrary positions
of the bitmap, including those spanning into the adjacent unsigned
longs.

Two new performance tests, test_bitmap_read_perf() and
test_bitmap_write_perf(), can be used to assess future performance
improvements of bitmap_read() and bitmap_write():

[    0.431119][    T1] test_bitmap: Time spent in test_bitmap_read_perf:	615253
[    0.433197][    T1] test_bitmap: Time spent in test_bitmap_write_perf:	916313

(numbers from a Intel(R) Xeon(R) Gold 6154 CPU @ 3.00GHz machine running
QEMU).

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 lib/test_bitmap.c | 179 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 172 insertions(+), 7 deletions(-)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 6b2b33579f56..9198e93b7985 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -60,18 +60,17 @@ static const unsigned long exp3_1_0[] __initconst = {
 };
 
 static bool __init
-__check_eq_uint(const char *srcfile, unsigned int line,
-		const unsigned int exp_uint, unsigned int x)
+__check_eq_ulong(const char *srcfile, unsigned int line,
+		 const unsigned long exp_ulong, unsigned long x)
 {
-	if (exp_uint != x) {
-		pr_err("[%s:%u] expected %u, got %u\n",
-			srcfile, line, exp_uint, x);
+	if (exp_ulong != x) {
+		pr_err("[%s:%u] expected %lu, got %lu\n",
+			srcfile, line, exp_ulong, x);
 		return false;
 	}
 	return true;
 }
 
-
 static bool __init
 __check_eq_bitmap(const char *srcfile, unsigned int line,
 		  const unsigned long *exp_bmap, const unsigned long *bmap,
@@ -185,7 +184,8 @@ __check_eq_str(const char *srcfile, unsigned int line,
 		result;							\
 	})
 
-#define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
+#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
+#define expect_eq_uint(x, y)		expect_eq_ulong((unsigned int)(x), (unsigned int)(y))
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
@@ -1286,6 +1286,168 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+/*
+ * Test bitmap should be big enough to include the cases when start is not in
+ * the first word, and start+nbits lands in the following word.
+ */
+#define TEST_BIT_LEN (1000)
+
+/*
+ * Helper function to test bitmap_write() overwriting the chosen byte pattern.
+ */
+static void __init test_bitmap_write_helper(const char *pattern)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(pat_bitmap, TEST_BIT_LEN);
+	unsigned long w, r, bit;
+	int i, n, nbits;
+
+	/*
+	 * Only parse the pattern once and store the result in the intermediate
+	 * bitmap.
+	 */
+	bitmap_parselist(pattern, pat_bitmap, TEST_BIT_LEN);
+
+	/*
+	 * Check that writing a single bit does not accidentally touch the
+	 * adjacent bits.
+	 */
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+		bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+		for (bit = 0; bit <= 1; bit++) {
+			bitmap_write(bitmap, bit, i, 1);
+			__assign_bit(i, exp_bitmap, bit);
+			expect_eq_bitmap(exp_bitmap, bitmap,
+					 TEST_BIT_LEN);
+		}
+	}
+
+	/* Ensure writing 0 bits does not change anything. */
+	bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+	bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_write(bitmap, ~0UL, i, 0);
+		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+	}
+
+	for (nbits = BITS_PER_LONG; nbits >= 1; nbits--) {
+		w = IS_ENABLED(CONFIG_64BIT) ? 0xdeadbeefdeadbeefUL
+					     : 0xdeadbeefUL;
+		w >>= (BITS_PER_LONG - nbits);
+		for (i = 0; i <= TEST_BIT_LEN - nbits; i++) {
+			bitmap_copy(bitmap, pat_bitmap, TEST_BIT_LEN);
+			bitmap_copy(exp_bitmap, pat_bitmap, TEST_BIT_LEN);
+			for (n = 0; n < nbits; n++)
+				__assign_bit(i + n, exp_bitmap, w & BIT(n));
+			bitmap_write(bitmap, w, i, nbits);
+			expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+			r = bitmap_read(bitmap, i, nbits);
+			expect_eq_ulong(r, w);
+		}
+	}
+}
+
+static void __init test_bitmap_read_write(void)
+{
+	unsigned char *pattern[3] = {"", "all:1/2", "all"};
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned long zero_bits = 0, bits_per_long = BITS_PER_LONG;
+	unsigned long val;
+	int i, pi;
+
+	/*
+	 * Reading/writing zero bits should not crash the kernel.
+	 * READ_ONCE() prevents constant folding.
+	 */
+	bitmap_write(NULL, 0, 0, READ_ONCE(zero_bits));
+	/* Return value of bitmap_read() is undefined here. */
+	bitmap_read(NULL, 0, READ_ONCE(zero_bits));
+
+	/*
+	 * Reading/writing more than BITS_PER_LONG bits should not crash the
+	 * kernel. READ_ONCE() prevents constant folding.
+	 */
+	bitmap_write(NULL, 0, 0, READ_ONCE(bits_per_long) + 1);
+	/* Return value of bitmap_read() is undefined here. */
+	bitmap_read(NULL, 0, READ_ONCE(bits_per_long) + 1);
+
+	/*
+	 * Ensure that bitmap_read() reads the same value that was previously
+	 * written, and two consequent values are correctly merged.
+	 * The resulting bit pattern is asymmetric to rule out possible issues
+	 * with bit numeration order.
+	 */
+	for (i = 0; i < TEST_BIT_LEN - 7; i++) {
+		bitmap_zero(bitmap, TEST_BIT_LEN);
+
+		bitmap_write(bitmap, 0b10101UL, i, 5);
+		val = bitmap_read(bitmap, i, 5);
+		expect_eq_ulong(0b10101UL, val);
+
+		bitmap_write(bitmap, 0b101UL, i + 5, 3);
+		val = bitmap_read(bitmap, i + 5, 3);
+		expect_eq_ulong(0b101UL, val);
+
+		val = bitmap_read(bitmap, i, 8);
+		expect_eq_ulong(0b10110101UL, val);
+	}
+
+	for (pi = 0; pi < ARRAY_SIZE(pattern); pi++)
+		test_bitmap_write_helper(pattern[pi]);
+}
+
+static void __init test_bitmap_read_perf(void)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned int cnt, nbits, i;
+	unsigned long val;
+	ktime_t time;
+
+	bitmap_fill(bitmap, TEST_BIT_LEN);
+	time = ktime_get();
+	for (cnt = 0; cnt < 5; cnt++) {
+		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
+			for (i = 0; i < TEST_BIT_LEN; i++) {
+				if (i + nbits > TEST_BIT_LEN)
+					break;
+				/*
+				 * Prevent the compiler from optimizing away the
+				 * bitmap_read() by using its value.
+				 */
+				WRITE_ONCE(val, bitmap_read(bitmap, i, nbits));
+			}
+		}
+	}
+	time = ktime_get() - time;
+	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+}
+
+static void __init test_bitmap_write_perf(void)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned int cnt, nbits, i;
+	unsigned long val = 0xfeedface;
+	ktime_t time;
+
+	bitmap_zero(bitmap, TEST_BIT_LEN);
+	time = ktime_get();
+	for (cnt = 0; cnt < 5; cnt++) {
+		for (nbits = 1; nbits <= BITS_PER_LONG; nbits++) {
+			for (i = 0; i < TEST_BIT_LEN; i++) {
+				if (i + nbits > TEST_BIT_LEN)
+					break;
+				bitmap_write(bitmap, val, i, nbits);
+			}
+		}
+	}
+	time = ktime_get() - time;
+	pr_err("Time spent in %s:\t%llu\n", __func__, time);
+}
+
+#undef TEST_BIT_LEN
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1303,6 +1465,9 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+	test_bitmap_read_write();
+	test_bitmap_read_perf();
+	test_bitmap_write_perf();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.44.0


