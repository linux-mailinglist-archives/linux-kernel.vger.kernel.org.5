Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D150E75B5C9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjGTRkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbjGTRkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:08 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1F1733
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:07 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-56fffdea2d0so10150047b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874806; x=1690479606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk3m7k+eyF/HEh+8Emc9v/tBu8X0A5nY3rtePFTQyzI=;
        b=yuen82uPoZ3tJbBBsgQocm7UlNUmQmKXoIc5PfKNJRK9D/8X+5MbFbx3Pocqqcbcfk
         sNkqbHJudzXLgp+t4oIBhs0mlZNEwiG7Z9MbyLn8U0aothHG2GpCZ5XX89a4i4LbNSTf
         gwObxpo3nrhm7ypSclv71wZ8tIxe/yWVeIQJtqEJyA8UxHTvSb1xAvfPSoEM5Aqyhdhc
         5PEJUQQI0gSpBr2nS0lKnbv9VkCnVcWAb4UwwoMF/HT5PjyYSgL6RlVIj9EanViWBdcZ
         ki9cfNtxau3FCisOBQ8zKbF26CCYBygGeoR+cfUOaZC728vmoerlRdnOpQbgGD0ZF9oo
         QecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874806; x=1690479606;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vk3m7k+eyF/HEh+8Emc9v/tBu8X0A5nY3rtePFTQyzI=;
        b=NHnwbguX5Q/7mbDVsPWyg8dgpgyHFM+sYUI6DanBWLlAd3YrDI7SHBPOxqzyPWre8w
         7bmvqMkA0FHOs8ePHM4fkMymZjDZAxWyxpvNqibA+9+IE4R8MGPCZ4Yr6+W/YZCkAEUI
         +l24yUEpky2Lkrn8k5XCxqKdCFWdjfPd6NzuYfITu/F5yDogRd9kxLiR0EBlhJMfEm6e
         Iq5Cv90gsTMy9/N9QFOmabQT3233fuUPk3w/8in4M/GA30GlDTDJhYr6tKcJ1s1MIIKz
         IOlBZxhx6dmGEAMv3R9xWnmNP+Eun5Q/Uo60GLNETCMkWd/8zK8jCHXNoP/6NJi+9+SS
         H5lQ==
X-Gm-Message-State: ABy/qLarKQ56fZ3WTyuXVTDRPzipMIxjAIFVzWD9TqaRvjTwoEFgYorV
        mc+JGc1BNFPbZhkjYR+BV0yTSRB7OY8=
X-Google-Smtp-Source: APBJJlE9qsJNd/SZTlF6yqfcEtavprHPeEPSeHCKhKejz3urXdprEs4SEXki0m27huyP6wV1J1px7rW17Dw=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a05:6902:1005:b0:cb3:c343:19e5 with SMTP id
 w5-20020a056902100500b00cb3c34319e5mr56992ybt.2.1689874806295; Thu, 20 Jul
 2023 10:40:06 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:53 +0200
In-Reply-To: <20230720173956.3674987-1-glider@google.com>
Mime-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-3-glider@google.com>
Subject: [PATCH v4 2/5] lib/test_bitmap: add tests for bitmap_{set,get}_value()
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

Add basic tests ensuring that values can be added at arbitrary positions
of the bitmap, including those spanning into the adjacent unsigned
longs.

Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
This patch was previously called
"lib/test_bitmap: add tests for bitmap_{set,get}_value_unaligned"
(https://lore.kernel.org/lkml/20230713125706.2884502-3-glider@google.com/)

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
 lib/test_bitmap.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 187f5b2db4cf1..601000c7799df 100644
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
@@ -1222,6 +1234,73 @@ static void __init test_bitmap_const_eval(void)
 	BUILD_BUG_ON(~var != ~BIT(25));
 }
 
+/*
+ * Test bitmap should be big enough to include the cases when start is not in
+ * the first word, and start+nbits lands in the following word.
+ */
+#define TEST_BIT_LEN (BITS_PER_LONG * 3)
+#define TEST_BYTE_LEN (BITS_TO_LONGS(TEST_BIT_LEN) * sizeof(unsigned long))
+static void __init test_set_get_value(void)
+{
+	DECLARE_BITMAP(bitmap, TEST_BIT_LEN);
+	DECLARE_BITMAP(exp_bitmap, TEST_BIT_LEN);
+	/* Prevent constant folding. */
+	volatile unsigned long zero_bits = 0;
+	unsigned long val, bit;
+	int i;
+
+	/* Setting/getting zero bytes should not crash the kernel. */
+	bitmap_write(NULL, 0, 0, zero_bits);
+	val = bitmap_read(NULL, 0, zero_bits);
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
+		bitmap_write(bitmap, 0b10101UL, i, 5);
+		val = bitmap_read(bitmap, i, 5);
+		expect_eq_ulong(0b10101UL, val);
+		bitmap_write(bitmap, 0b101UL, i + 5, 3);
+		val = bitmap_read(bitmap, i + 5, 3);
+		expect_eq_ulong(0b101UL, val);
+		val = bitmap_read(bitmap, i, 8);
+		expect_eq_ulong(0b10110101UL, val);
+	}
+
+	/*
+	 * Check that setting a single bit does not accidentally touch the
+	 * adjacent bits.
+	 */
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		/*
+		 * A 0b10101010 pattern to catch both 0s replaced to 1s and vice
+		 * versa.
+		 */
+		memset(bitmap, 0xaa, TEST_BYTE_LEN);
+		memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);
+		for (bit = 0; bit <= 1; bit++) {
+			bitmap_write(bitmap, bit, i, 1);
+			__assign_bit(i, exp_bitmap, bit);
+			expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+		}
+	}
+
+	/* Ensure setting 0 bits does not change anything. */
+	memset(bitmap, 0xaa, TEST_BYTE_LEN);
+	memset(exp_bitmap, 0xaa, TEST_BYTE_LEN);
+	for (i = 0; i < TEST_BIT_LEN; i++) {
+		bitmap_write(bitmap, ~0UL, i, 0);
+		expect_eq_bitmap(exp_bitmap, bitmap, TEST_BIT_LEN);
+	}
+}
+#undef TEST_BYTE_LEN
+#undef TEST_BIT_LEN
+
 static void __init selftest(void)
 {
 	test_zero_clear();
@@ -1249,6 +1328,8 @@ static void __init selftest(void)
 	test_for_each_clear_bitrange_from();
 	test_for_each_set_clump8();
 	test_for_each_set_bit_wrap();
+
+	test_set_get_value();
 }
 
 KSTM_MODULE_LOADERS(test_bitmap);
-- 
2.41.0.487.g6d72f3e995-goog

