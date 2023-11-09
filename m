Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F317E6CF0
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234518AbjKIPLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbjKIPLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:11:18 -0500
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120B035AB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 07:11:16 -0800 (PST)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9bea60bd1adso245098066b.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 07:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699542674; x=1700147474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ep1qJd3r3CicksEB8/VS0CthWKnz6BMcAhHrRuSJk70=;
        b=QJ7XlpWaG7fCDWTud3QVeuIu3vJGVW1L6iIlIggxrlQb1bV4zkN6Z69j2keJiTbiRC
         kkXnVY1fX1CsAfT8W8WNjzHBEiBRdsSl9A3obcf3nYZ1uXUK+jrFmHfduR43iUIk+7Bo
         dti9C0tdAfBZGO6NkcS2JxFNHWvnmFAgZquFLVc4j4HpbqviFVW+a9WShGG+Njsx1SZs
         YmNF8Bfzi5fhCCl2o1hViHIP3lm11P+z/ONr5Eu6F7xxR/S5O8qPcdRbYRdpYZlYTcLd
         WK/pJJUuu/H1HjG9yGks/wl2Xne3Rf3xhg7ItFAOG3lClOh5hEQ6bbUeZqHr5qQhi/GR
         VfwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699542674; x=1700147474;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ep1qJd3r3CicksEB8/VS0CthWKnz6BMcAhHrRuSJk70=;
        b=bEXQ41Vy2dShDxiGy5FyPjOeJCEMOTyqZVTOBEoBnJ26K7NTXLTSDFKIcDGDOMVvsI
         3fHsh9/ozmURp6nnpM27zpWmrojmpgr/E3LAgufoWEWuRqm8VNMpOkSNWB83i/LgDux6
         qqkQDGiJj38vgxbKMvPcW6c+gjp3MGHfJgERNvrVkSXOXvBFlLzqaYHft0g70wDFv5OP
         BRdTbPG3qtLGjaeEHXb+pRZud9eg3bjIEVS4ginuldlM5aBme5uTPsxXHxxGgJwbEnKS
         tSBbW9SQiLKUIVdb6UEKCZcRlX0LsqqDPrjxOBBdNdPzv6PGbr7XWcnLrxXO5tviURl3
         sSQg==
X-Gm-Message-State: AOJu0YxlBO9WhVV31hizanCAOsut17K5NT3jdjY+dd6wxfksiT9OPHNW
        hGQkklDsdqNpl91fZ42wpcMh/yTcc1A=
X-Google-Smtp-Source: AGHT+IEiflMT9gNcyi8oG+hBojxdMUjX7PqQ5j936LfU7yCowVQPVRqjTxMkAe/yIXx6Gw+1KQwBGJrtslY=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c5e3:4628:e996:9f03])
 (user=glider job=sendgmr) by 2002:a17:907:b90:b0:9dd:9808:bed1 with SMTP id
 ey16-20020a1709070b9000b009dd9808bed1mr91850ejc.7.1699542674589; Thu, 09 Nov
 2023 07:11:14 -0800 (PST)
Date:   Thu,  9 Nov 2023 16:11:04 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231109151106.2385155-1-glider@google.com>
Subject: [PATCH v12 1/3] lib/bitmap: add bitmap_{read,write}()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Syed Nayyar Waris <syednwaris@gmail.com>

The two new functions allow reading/writing values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a number of changes and simplifications:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value());
 - bitmap_get_value()/bitmap_set_value() are renamed to bitmap_read()
   and bitmap_write();
 - some redundant computations are omitted.

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

---
This patch was previously part of the "Implement MTE tag compression for
swapped pages" series
(https://lore.kernel.org/linux-arm-kernel/20231011172836.2579017-4-glider@google.com/T/)

This patch was previously called "lib/bitmap: add
bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-2-glider@google.com/)

v11:
 - rearrange whitespace as requested by Andy Shevchenko,
   add Reviewed-by:, update a comment

v10:
 - update comments as requested by Andy Shevchenko

v8:
 - as suggested by Andy Shevchenko, handle reads/writes of more than
   BITS_PER_LONG bits, add a note for 32-bit systems

v7:
 - Address comments by Yury Norov, Andy Shevchenko, Rasmus Villemoes:
   - update code comments;
   - get rid of GENMASK();
   - s/assign_bit/__assign_bit;
   - more vertical whitespace for better readability;
 - more compact code for bitmap_write() (now for real)

v6:
 - As suggested by Yury Norov, do not require bitmap_read(..., 0) to
   return 0.

v5:
 - Address comments by Yury Norov:
   - updated code comments and patch title/description
   - replace GENMASK(nbits - 1, 0) with BITMAP_LAST_WORD_MASK(nbits)
   - more compact bitmap_write() implementation

v4:
 - Address comments by Andy Shevchenko and Yury Norov:
   - prevent passing values >= 64 to GENMASK()
   - fix commit authorship
   - change comments
   - check for unlikely(nbits==0)
   - drop unnecessary const declarations
   - fix kernel-doc comments
   - rename bitmap_{get,set}_value() to bitmap_{read,write}()
---
 include/linux/bitmap.h | 77 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..7dd00e2e6d539 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -77,6 +77,10 @@ struct device;
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -599,6 +603,79 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of @nbits bits located at the @start bit offset within the
+ * @map memory region. For @nbits = 0 and @nbits > BITS_PER_LONG the return
+ * value is undefined.
+ */
+static inline unsigned long bitmap_read(const unsigned long *map,
+					unsigned long start,
+					unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long value_low, value_high;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return 0;
+
+	if (space >= nbits)
+		return (map[index] >> offset) & BITMAP_LAST_WORD_MASK(nbits);
+
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves as-if implemented as @nbits calls of __assign_bit(),
+ * i.e. bits beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           __assign_bit(start + bit, bitmap, val & BIT(bit));
+ *
+ * For @nbits == 0 and @nbits > BITS_PER_LONG no writes are performed.
+ */
+static inline void bitmap_write(unsigned long *map, unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index;
+	unsigned long offset;
+	unsigned long space;
+	unsigned long mask;
+	bool fit;
+
+	if (unlikely(!nbits || nbits > BITS_PER_LONG))
+		return;
+
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	offset = start % BITS_PER_LONG;
+	space = BITS_PER_LONG - offset;
+	fit = space >= nbits;
+	index = BIT_WORD(start);
+
+	map[index] &= (fit ? (~(mask << offset)) : ~BITMAP_FIRST_WORD_MASK(start));
+	map[index] |= value << offset;
+	if (fit)
+		return;
+
+	map[index + 1] &= BITMAP_FIRST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.42.0.869.gea05f2083d-goog

