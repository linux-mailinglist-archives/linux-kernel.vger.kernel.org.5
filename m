Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B88E75B5C8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGTRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjGTRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:40:06 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDDB9E52
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:04 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-994320959f4so73994466b.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874803; x=1690479603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sBTD77nZvv18xeO6UXUxdZ0TBIDcYAZAkWaNswyfelY=;
        b=1yT9HCrQQBAuoPLZ7UGNCLsWKvdxdYuhPi2NOHvNyCTSGgIEes/2FWg7ihwLHAhBfR
         1PeLv9ipNyiodNyHDDK6BSNY8lzNRKw8Oix+MqAbxNmnzi9yiavk+N7YHSIgr0bFHzPs
         8jV8LZHfabUsgSYAepexYCKMLMQ+dZQBsP2w2FU868WrtZgu64b0q/VPbS+dyJeruvFn
         BleAB1+spyaED66wcjfeaBbfoPl03mU6B1mt1b7bDlMZWQrCquq9K2CxeCXPiKIQWf4k
         IKxjpvdbWrbdBgYYm3DhUM1180bxFCEzrpPPJVvTv1C44fNSmbNxAKCG5CH6A9gChutu
         jrtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874803; x=1690479603;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBTD77nZvv18xeO6UXUxdZ0TBIDcYAZAkWaNswyfelY=;
        b=K7N7YvAA6BfU4Hyi8bh9JTFU3uqxrTGz3l2oLDhV7tDY+TGjrs7YRtKfwjVCkV2QbZ
         5jgul+TDWyQTkrqDjQ/quhsmbQBjMe4wuDHqrXgfLyYJ4bDIhycdbgDYqig9gR7eaeVN
         /u9UDDmjikIVRxlE+EUAiquVTB/EgIHss0wxP0DcdlNjwpqrI9bGKUT7rh8DvyKyarSC
         uOoP5G0syDGzt3uyfN9nJbPkpMJwg8VtKhnpRYDtUv46XmdTclfZR2BR6Ay9dElZjFiw
         d9NQKX3bYmVxcsI640N5PzmWPjXsBzGCKJ1mxDUuY0xC8eJ/HHhZkSsObfDEUffdfDSY
         QquQ==
X-Gm-Message-State: ABy/qLbIZQznpQoV/Kb7Bw9bCVgsf3ptwCPNsa/SzdD5urTKNkEAFQUl
        gmrGDHlSzXEdAU1jryZgExtize/qkWo=
X-Google-Smtp-Source: APBJJlFEpqXtUIUruBd5vPcsMxTpgg2Ahl+rkUC7d3QtocVPUnbq6OicKT0NEEeMZUKIzs8vBCw+aHOpe9o=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:c495:c29a:e275:1dfb])
 (user=glider job=sendgmr) by 2002:a50:cc9c:0:b0:51d:e3e6:cc6b with SMTP id
 q28-20020a50cc9c000000b0051de3e6cc6bmr25395edi.6.1689874803086; Thu, 20 Jul
 2023 10:40:03 -0700 (PDT)
Date:   Thu, 20 Jul 2023 19:39:52 +0200
In-Reply-To: <20230720173956.3674987-1-glider@google.com>
Mime-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230720173956.3674987-2-glider@google.com>
Subject: [PATCH v4 1/5] lib/bitmap: add bitmap_{set,get}_value()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        eugenis@google.com, syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
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

From: Syed Nayyar Waris <syednwaris@gmail.com>

The two new functions allow setting/getting values of length up to
BITS_PER_LONG bits at arbitrary position in the bitmap.

The code was taken from "bitops: Introduce the for_each_set_clump macro"
by Syed Nayyar Waris with a couple of minor changes:
 - instead of using roundup(), which adds an unnecessary dependency
   on <linux/math.h>, we calculate space as BITS_PER_LONG-offset;
 - indentation is reduced by not using else-clauses (suggested by
   checkpatch for bitmap_get_value())

Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Syed Nayyar Waris <syednwaris@gmail.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
Link: https://lore.kernel.org/lkml/fe12eedf3666f4af5138de0e70b67a07c7f40338.1592224129.git.syednwaris@gmail.com/
Suggested-by: Yury Norov <yury.norov@gmail.com>
Co-developed-by: Alexander Potapenko <glider@google.com>
Signed-off-by: Alexander Potapenko <glider@google.com>

---
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
 include/linux/bitmap.h | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..bc21c09a2e038 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -76,7 +76,11 @@ struct device;
  *  bitmap_to_arr32(buf, src, nbits)            Copy nbits from buf to u32[] dst
  *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
  *  bitmap_get_value8(map, start)               Get 8bit value from map at start
+ *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
+ *                                              map at start
  *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
+ *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
+ *                                              map at start
  *
  * Note, bitmap_zero() and bitmap_fill() operate over the region of
  * unsigned longs, that is, bits behind bitmap till the unsigned long
@@ -583,6 +587,33 @@ static inline unsigned long bitmap_get_value8(const unsigned long *map,
 	return (map[index] >> offset) & 0xFF;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, up to BITS_PER_LONG
+ *
+ * Returns: value of nbits located at the @start bit offset within the @map
+ * memory region.
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
+	if (unlikely(!nbits))
+		return 0;
+	if (space >= nbits)
+		return (map[index] >> offset) & GENMASK(nbits - 1, 0);
+	value_low = map[index] & BITMAP_FIRST_WORD_MASK(start);
+	value_high = map[index + 1] & BITMAP_LAST_WORD_MASK(start + nbits);
+	return (value_low >> offset) | (value_high << space);
+}
+
 /**
  * bitmap_set_value8 - set an 8-bit value within a memory region
  * @map: address to the bitmap memory region
@@ -599,6 +630,35 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value of nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, up to BITS_PER_LONG
+ */
+static inline void bitmap_write(unsigned long *map,
+				unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+
+	if (unlikely(!nbits))
+		return;
+	value &= GENMASK(nbits - 1, 0);
+	if (space >= nbits) {
+		map[index] &= ~(GENMASK(nbits - 1, 0) << offset);
+		map[index] |= value << offset;
+		return;
+	}
+	map[index] &= ~BITMAP_FIRST_WORD_MASK(start);
+	map[index] |= value << offset;
+	map[index + 1] &= ~BITMAP_LAST_WORD_MASK(start + nbits);
+	map[index + 1] |= (value >> space);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
-- 
2.41.0.487.g6d72f3e995-goog

