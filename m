Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16277D2FBF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 12:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbjJWKYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 06:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233328AbjJWKYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 06:24:17 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE501712
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:23:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so30786427b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 03:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698056628; x=1698661428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yB8dGWcosl0aftMr2buS4345MY8v0YGnzg8FiIVcKA4=;
        b=AfCjbbwnCjGVwHAshJTai0dIJo2mLQYeu7ivKtU8wTkZ4SNiJwrEgB5vbDE53WEsen
         sAHPMN+UNIlcFOppk9CrGwsJ/6pOorBvYSeydq5Vk+fWvv2BgDeiCY8N7oxKKANhkSvQ
         urrz9iuFqyAuN4dy53GkusNqpYApvL015xAm/GY4Vvua6cBHkKQbUtWmcgUtDfrGpJ56
         9KZStWoG3x0a6SfdW9QymjEcuc2yqIKB33DyftPqO8vwR3CXdrOv4xsh+PmMNFPiHmOW
         caGNuHeqbuFC+cXJi06gKRFpQbTI9NGAdlm4d6QT0qOITFWL18DOURgPkUUjPBQvZb18
         32nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698056628; x=1698661428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yB8dGWcosl0aftMr2buS4345MY8v0YGnzg8FiIVcKA4=;
        b=OaJD85TTlOKxsw3Ol095AIsUDP49K1VjSz7sdVa7r83J9AGE80LW24H8pOPRG1/FNs
         pExfip3E3URp74vRTp+1RkJmGZz4VLzFhF+qp4QWl0B5pfxwwVhUYyXI1bBj3lTCSYiv
         pEEtG4KT1HnL1NJqLXZQ7P3+lFjJ7SsvJWS7aaaDoCteaOus6GF/55LByZqpKUUxFrQM
         PhLqkiqSeGv8utvJEBqHVjW3V2A0cLWB2mHG0HbrNiQrcQcrhkfv4H3CcYwZkAeen7et
         ekFxgkpcYvHmJ/XSR1nujOpdPRTlajZsKP8OZ2bpLrGAJa7BudfwD2DF9/HiqpLVFMLo
         5tKA==
X-Gm-Message-State: AOJu0Yyde21K0NZ/3bqSexT5wx4+LG6CR4nL7clDVrXTOWwV1UcYDgAO
        LPk20AyWU+BPXkZOgZxsnK+GbLox5Kc=
X-Google-Smtp-Source: AGHT+IHxE1Y52g9oxl2ZVWIL5HoldfUlKJKihjsGxYrZTgaAPEJq1zBw6IHEwa6dVtR0B7F0wTuoOH+JoF4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:348e:9a:326e:345e])
 (user=glider job=sendgmr) by 2002:a81:4f0f:0:b0:5a7:b4d5:5f27 with SMTP id
 d15-20020a814f0f000000b005a7b4d55f27mr239217ywb.5.1698056628103; Mon, 23 Oct
 2023 03:23:48 -0700 (PDT)
Date:   Mon, 23 Oct 2023 12:23:27 +0200
In-Reply-To: <20231023102327.3074212-1-glider@google.com>
Mime-Version: 1.0
References: <20231023102327.3074212-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231023102327.3074212-2-glider@google.com>
Subject: [PATCH v8 2/2] lib/test_bitmap: add tests for bitmap_{read,write}()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic tests ensuring that values can be added at arbitrary positions
of the bitmap, including those spanning into the adjacent unsigned
longs.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
This patch was previously part of the "Implement MTE tag compression for
swapped pages" series
(https://lore.kernel.org/linux-arm-kernel/20231011172836.2579017-4-glider@google.com/T/)

This patch was previously called
"lib/test_bitmap: add tests for bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-3-glider@google.com/)
and
"lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
(https://lore.kernel.org/lkml/20230713125706.2884502-3-glider@google.com/)

v8:
 - as requested by Andy Shevchenko, add tests for reading/writing
   sizes > BITS_PER_LONG

v7:
 - as requested by Yury Norov, add performance tests for bitmap_read()
   and bitmap_write()

v6:
 - use bitmap API to initialize test bitmaps
 - as requested by Yury Norov, do not check the return value of
   bitmap_read(..., 0)
 - fix a compiler warning on 32-bit systems

v5:
 - update patch title
 - address Yury Norov's comments:
   - rename the test cases
   - factor out test_bitmap_write_helper() to test writing over
     different background patterns;
   - add a test case copying a nontrivial value bit-by-bit;
   - drop volatile

v4:
 - Address comments by Andy Shevchenko: added Reviewed-by: and a link to
   the previous discussion
 - Address comments by Yury Norov:
   - expand the bitmap to catch more corner cases
   - add code testing that bitmap_set_value() does not touch adjacent
     bits
   - add code testing the nbits==0 case
   - rename bitmap_{get,set}_value() to bitmap_{read,write}()

v3:
 - switch to using bitmap_{set,get}_value()
 - change the expected bit pattern in test_set_get_value(),
   as the test was incorrectly assuming 0 is the LSB.
---
 lib/test_bitmap.c | 174 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 174 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5d..ba567f53feff1 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -71,6 +71,17 @@ __check_eq_uint(const char *srcfile, unsigned int line,
 	return true;
 }
 
+static bool __init
+__check_eq_ulong(const char *srcfile, unsigned int line,
+		 const unsigned long exp_ulong, unsigned long x)
+{
+	if (exp_ulong != x) {
+		pr_err("[%s:%u] expected %lu, got %lu\n",
+			srcfile, line, exp_ulong, x);
+		return false;
+	}
+	return true;
+}
 
 static bool __init
 __check_eq_bitmap(const char *srcfile, unsigned int line,
@@ -186,6 +197,7 @@ __check_eq_str(const char *srcfile, unsigned int line,
 	})
 
 #define expect_eq_uint(...)		__expect_eq(uint, ##__VA_ARGS__)
+#define expect_eq_ulong(...)		__expect_eq(ulong, ##__VA_ARGS__)
 #define expect_eq_bitmap(...)		__expect_eq(bitmap, ##__VA_ARGS__)
 #define expect_eq_pbl(...)		__expect_eq(pbl, ##__VA_ARGS__)
 #define expect_eq_u32_array(...)	__expect_eq(u32_array, ##__VA_ARGS__)
@@ -1222,6 +1234,165 @@ static void __init test_bitmap_const_eval(void)
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
+				val = bitmap_read(bitmap, i, nbits);
+				(void)val;
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
@@ -1237,6 +1408,9 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+	test_bitmap_read_write();
+	test_bitmap_read_perf();
+	test_bitmap_write_perf();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.42.0.655.g421f12c284-goog

