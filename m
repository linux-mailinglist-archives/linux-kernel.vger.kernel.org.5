Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248C67AABE1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbjIVIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjIVIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:09 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E73CC4
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:58 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59bf252a83aso24311297b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370137; x=1695974937; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=E6HfQ9ajoFejClPit+nbh4c2FH86MesGxxER+WNLYXg=;
        b=FipK+GnXe2J2eyclLSVD9C9jz5T9FkViVdQxkil007GSvHmnlMfjRTsFEdHNxbxZQg
         iKWL/GzJJ8fJnf0m7cqdhiczrqtq8Pu28b1lerc2SHbAyM0Pc8hX6sCyR7apRrHw5I5z
         m9F6/Rc5XCpfPX/0z0uEw63waz0MRF8f3aIC3zBuaFrp/MkicX4RDso7mss8qW4fcXlE
         8rB55W+GIS8oCos2gvC0A4qPiP0yLhFSG2lPQJQfBND+mwstVx1Q86QsLnhTYnz+BTNR
         rzMpPKIBR0OresxeSJRK8WiFp7pWwaoHfsvDJkth07rQaI0ahCsAdkCRucxUPeKF35jA
         Y25g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370137; x=1695974937;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E6HfQ9ajoFejClPit+nbh4c2FH86MesGxxER+WNLYXg=;
        b=emH/ajXq2fHe06AIgcWMK7iGlVbdc/iOXvfWStnWokRv99Oj3JM/D4iymStTntwIOI
         u6NZhX1LsoSe6jro0pEuPu+I7nANphVnSCGQCObzMqz+G2qo4GrKQIWksUXOHDkwuVqk
         2jv1aDVHRmbpRi6P4/kshxVwaxvXcBmaSssM8CBXBQIp/iHJQtiUAgJh55zx8QKPipss
         MA1BuS7BCKaFLYnCdF31C+jAjORlrAo2LZ4VHF0bWSID3GMNfgqo6FrupmKTTrmseVMY
         e9bdRmq54b8fKZgIB6rJfo5fah2BquiH2uulE+RrT/q3RovKv8S1MX3DkRYI6MP+YBL5
         HsmQ==
X-Gm-Message-State: AOJu0Yw8lXadTQc16C044IMKAlqC4+bDMVNz8d8/FN9HhBEVTLw/MPkM
        F6Ac9ut61iO079U1f57b0A8LKB/q6qM=
X-Google-Smtp-Source: AGHT+IEdiD//2jsP7Hipwjz6LYsrL0lV7yx6GCLEvY13BgHGKc4ggEzfLi5fB/Luw3/AsSlbbzCaIuJUQOY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a81:af1c:0:b0:59b:db15:498c with SMTP id
 n28-20020a81af1c000000b0059bdb15498cmr119630ywh.10.1695370137358; Fri, 22 Sep
 2023 01:08:57 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:44 +0200
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Mime-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-3-glider@google.com>
Subject: [PATCH v5 2/5] lib/test_bitmap: add tests for bitmap_{read,write}()
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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
This patch was previously called
"lib/test_bitmap: add tests for bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-3-glider@google.com/)
and
"lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
(https://lore.kernel.org/lkml/20230713125706.2884502-3-glider@google.com/)

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
 lib/test_bitmap.c | 115 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf1..ea66e39b29a4e 100644
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
@@ -1222,6 +1234,108 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+/*
+ * Test bitmap should be big enough to include the cases when start is not in
+ * the first word, and start+nbits lands in the following word.
+ */
+#define TEST_BIT_LEN (1000)
+#define TEST_BYTE_LEN (BITS_TO_BYTES(TEST_BIT_LEN))
+
+/*
+ * Helper function to test bitmap_write() overwriting the chosen byte pattern.
+ */
+static void __init test_bitmap_write_helper(unsigned char pattern)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
+	unsigned long w, r, bit;
+	int i, n, nbits;
+
+	/*
+	 * Check that setting a single bit does not accidentally touch the
+	 * adjacent bits.
+	 */
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		/*
+		 * A 0b10101010 pattern to catch both 0s replaced to 1s
+		 * and vice versa.
+		 */
+		memset(bitmap, pattern, TEST_BYTE_LEN);
+		memset(exp_bitmap, pattern, TEST_BYTE_LEN);
+		for (bit = 0; bit <= 1; bit++) {
+			bitmap_write(bitmap, bit, i, 1);
+			__assign_bit(i, exp_bitmap, bit);
+			expect_eq_bitmap(exp_bitmap, bitmap,
+					 TEST_BIT_LEN);
+		}
+	}
+
+	/* Ensure setting 0 bits does not change anything. */
+	memset(bitmap, pattern, TEST_BYTE_LEN);
+	memset(exp_bitmap, pattern, TEST_BYTE_LEN);
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_write(bitmap, ~0UL, i, 0);
+		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+	}
+
+	for (nbits = BITS_PER_LONG; nbits >= 1; nbits--) {
+		w = 0xdeadbeefdeadbeefUL >> (BITS_PER_LONG - nbits);
+		for (i = 0; i <= TEST_BIT_LEN - nbits; i++) {
+			memset(bitmap, pattern, TEST_BYTE_LEN);
+			memset(exp_bitmap, pattern, TEST_BYTE_LEN);
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
+	unsigned char pattern[3] = {0x00, 0xaa, 0xff};
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	unsigned long zero_bits = 0;
+	unsigned long val;
+	int i, pi;
+
+	/*
+	 * Setting/getting zero bytes should not crash the kernel.
+	 * READ_ONCE() prevents constant folding.
+	 */
+	bitmap_write(NULL, 0, 0, READ_ONCE(zero_bits));
+	val = bitmap_read(NULL, 0, READ_ONCE(zero_bits));
+	expect_eq_ulong(0, val);
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
+	for (pi = 0; pi < sizeof(pattern); pi++)
+		test_bitmap_write_helper(pattern[pi]);
+}
+#undef TEST_BYTE_LEN
+#undef TEST_BIT_LEN
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1237,6 +1351,7 @@ static void __init selftest(void)
 	test_bitmap_cut();
 	test_bitmap_print_buf();
 	test_bitmap_const_eval();
+	test_bitmap_read_write();
 
 	test_find_nth_bit();
 	test_for_each_set_bit();
-- 
2.42.0.515.g380fc7ccd1-goog

