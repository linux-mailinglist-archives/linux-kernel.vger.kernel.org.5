Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324887521FF
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjGMM5f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234712AbjGMM5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:57:32 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71F626B0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:29 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-51e52b1fb4fso439114a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689253048; x=1691845048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=G3X9aMNtf+Y4a1BkuoJTavkrfHeiL0YXiMZI9eN5sqI=;
        b=SdKzR7yTSRRtkPH8PaZdS44fFu2DNGPv2/dy6ooEfMC7KJ2FOiE5d/H6k3NmPaBm4O
         amJ2UuqzibTpzA8DKvuhZxz1Sss1X4pLbm9EFZq/uOLe3QJvWpnJQrcAsBCpnWPqt4oE
         g64n0rY7HOaFQe0pg1Uin9savcYzWGMBM2Z7Wum8Xa6yIhZ+HEbUaUKwoPUIKGZlU8RA
         zlJY9rkKJ3DJKlpadBNHtcnDefxevG7PGdH9J+mbkOQKX7WFxfimK/ImWb0LWPwkwY3z
         9a8z/PRJDF3l0fJ4S6L5esnKmpUi7uxVMp34zTDhtDoAmSIaJgbArKdR6Y1rfRrFKUte
         U1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689253048; x=1691845048;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G3X9aMNtf+Y4a1BkuoJTavkrfHeiL0YXiMZI9eN5sqI=;
        b=Rgox4YWTHBLUBGkqy2iPczWUqypJXsjZAqZWVK7TGAwlEtjR5rBCzI7GhJszjv9UCK
         gyb0Dyx/c+3N/BvMH3EWxfxjj4lCIl93d+X5oeYDsdzC2AZFjNmJ/PXS3S3LQUNquBB4
         Z5rhTy9RXmBg0WB6BcOysGtRHQ2L64fHRW0DvtVsBWdZFMfEnk/jL+7Q+JtieT99K1Y9
         PZVlSNs3tuJqSUt8eHl87Zt2JQq9jGA22UCiqkWCNJqbcAlhljGmZJQ6Y2TqBcaAEmni
         rrwAVgxDGKsgJpKQHMoN4JOhJdYpjyaZ4/K6KeRzaURPPN3cVkzq5rJ1jjdUvl7j6mK9
         I6Nw==
X-Gm-Message-State: ABy/qLZ6H58jEninRFsdDP8/CtOkl6ezGNkXd2jpjBc0BSlt2epppv/4
        0vPcpe3144VLJa6ZnR4ib1Si8UzVz+8=
X-Google-Smtp-Source: APBJJlEzRUl9pOBtatK4TP7+ubEzsIeS9vByW92Acf7+09gdvZcE2hYQqa4F1F4VhS3O4Pv4tFWgxxihdQs=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:7a88:66b7:31e5:7d85])
 (user=glider job=sendgmr) by 2002:a50:99d3:0:b0:50b:c88a:f7cd with SMTP id
 n19-20020a5099d3000000b0050bc88af7cdmr8273edb.4.1689253048201; Thu, 13 Jul
 2023 05:57:28 -0700 (PDT)
Date:   Thu, 13 Jul 2023 14:57:01 +0200
In-Reply-To: <20230713125706.2884502-1-glider@google.com>
Mime-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230713125706.2884502-2-glider@google.com>
Subject: [v2 1/5] lib/bitmap: add bitmap_{set,get}_value_unaligned()
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

The two new functions allow setting/getting values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

Suggested-by: Yury Norov <yury.norov@gmail.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 include/linux/bitmap.h | 63 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..8e36ce07bafd4 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -77,6 +77,8 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_get_value_unaligned(map, start, nbits)  Get value up to BITS_PER_LONG
+ *  bitmap_set_value_unaligned(map, value, start, nbits)  Set value up to BITS_PER_LONG
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -583,6 +585,35 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
 }
 
+/**
+ * bitmap_get_value_unaligned - get an @nbits-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the value; may not be a multiple of 8
+ * @nbits: number of bits to get
+ *
+ * Returns the @nbits-sized value located at the @start bit offset within the
+ * @map memory region.
+ */
+static inline unsigned long bitmap_get_value_unaligned(const unsigned long *map,
+						       unsigned long start,
+						       unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	const unsigned long carry = (offset + nbits) % BITS_PER_LONG;
+	unsigned long hi, lo, result;
+
+	if (offset + nbits <= BITS_PER_LONG) {
+		result = map[index] >> (BITS_PER_LONG - offset - nbits);
+		return result & BITMAP_LAST_WORD_MASK(nbits);
+	}
+
+	hi = map[index] & BITMAP_LAST_WORD_MASK(BITS_PER_LONG - offset);
+	lo = map[index + 1] & BITMAP_FIRST_WORD_MASK(BITS_PER_LONG - carry);
+	lo >>= (BITS_PER_LONG - carry);
+	return (hi << carry) | lo;
+}
+
 /**
  * bitmap_set_value8 - set an 8-bit value within a memory region
  * @map: address to the bitmap memory region
@@ -599,6 +630,38 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_set_value_unaligned - set an @nbits-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: the value up to BITS_PER_LONG bits (will be clamped to @nbits)
+ * @start: bit offset of the value; may not be a multiple of 8
+ * @nbits: number of bits to set
+ */
+static inline void bitmap_set_value_unaligned(unsigned long *map,
+					      unsigned long value,
+					      unsigned long start,
+					      unsigned long nbits)
+{
+	const size_t index = BIT_WORD(start);
+	const unsigned long offset = start % BITS_PER_LONG;
+	unsigned long mask = BITMAP_LAST_WORD_MASK(nbits);
+	const unsigned long carry = (offset + nbits) % BITS_PER_LONG;
+
+	value &= mask;
+	if (offset + nbits <= BITS_PER_LONG) {
+		value <<= (BITS_PER_LONG - offset - nbits);
+		mask <<= (BITS_PER_LONG - offset - nbits);
+		map[index] &= ~mask;
+		map[index] |= value;
+		return;
+	}
+	map[index] &= ~BITMAP_LAST_WORD_MASK(BITS_PER_LONG - offset);
+	map[index] |= (value >> (carry));
+	value &= BITMAP_LAST_WORD_MASK(carry);
+	map[index + 1] &= ~BITMAP_FIRST_WORD_MASK(BITS_PER_LONG - carry);
+	map[index + 1] |= value << (BITS_PER_LONG - carry);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.41.0.255.g8b1d071c50-goog

