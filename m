Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 416D27D6553
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjJYIiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjJYIiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:38:20 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15EE9C
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:38:17 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id ffacd0b85a97d-32d933caa8eso2177511f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698223096; x=1698827896; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7RZQ/S/jTVrRUSUeijWCI7Egf5o6MgvN5jmxkKIprg8=;
        b=NKU8wYhuHe6s/GJVxB4BIoEmOD5bvotR03z7nMzT96bCwduK15eUchUWmYbLVQl5a5
         e9zjE0ktEwUhr8LyYo60OJrDSPHHEorf6Gqu3TwkWSIe73QNSGgIQQyLMbTQp8fiVGAG
         uZlL5HIdsFXd2teynRNC903X8Kb3sIg3rfXsgyBBu5E/jtlh2upQeyIooyLw4WzcXpB8
         eLGjmonvHZaim5f8aTve9DdGViiJvyNI0LTthhIIClZ88pZAUmKKamx5Yegi0KvZlqjX
         KLJDuBTCzS9r0GwW2GAgC6Uok+ntOoek/BPovo78NYQni8Bse7El6BVHOGfGCsxbHUUk
         g8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698223096; x=1698827896;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7RZQ/S/jTVrRUSUeijWCI7Egf5o6MgvN5jmxkKIprg8=;
        b=w850uPjU/0boD15dPs3cMokTz54+cvlf6NGIzZEXyk2FvLGGxdJAOMkKZ+URGgLu9M
         /gilYoDGF3BBbAmFxeubKTlyv5QOqjcZOB4HJNpGBL36LxqGtHEvH4Ma9b8o7SkIMBIi
         CdKP+7o3eF5FDAGVGArNrWRqsuPr/bmGU3bAdTcYN4292vLNCVb/uzvMfRFTj1DpGEHB
         /ccIhVLcUmtuMIYc+WF3NryD9JUTddGYuVYSGJ3EAQUE5NMxrE212Wla4pwC3enc9VME
         5X8HGb4V7UgUOygC3a6pit5frOTBx+Cd0q3duA1x0v64H39N0buj52/RTA+yvo6SiY9Q
         ffnA==
X-Gm-Message-State: AOJu0Yy00ENfRTGKyYa70Wyongv7b/3vogLQnwT3EH0eoZMfnfQ+LXQF
        LfXaBPReCxRb+sV4QIVfOB4eyzOYplc=
X-Google-Smtp-Source: AGHT+IGlsuW5DB8ez+xdDaNO/RoLiN3GRtKDbAcTMTXnB4iQclvYA9zSeoMWDBpcX7wynIpBU3BHci/DSB0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:541d:37f9:e2bc:817b])
 (user=glider job=sendgmr) by 2002:a5d:4d07:0:b0:319:6fc6:151 with SMTP id
 z7-20020a5d4d07000000b003196fc60151mr115747wrt.10.1698223095931; Wed, 25 Oct
 2023 01:38:15 -0700 (PDT)
Date:   Wed, 25 Oct 2023 10:38:11 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.758.gaed0368e0e-goog
Message-ID: <20231025083812.456916-1-glider@google.com>
Subject: [PATCH v9 1/2] lib/bitmap: add bitmap_{read,write}()
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
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

---
This patch was previously part of the "Implement MTE tag compression for
swapped pages" series
(https://lore.kernel.org/linux-arm-kernel/20231011172836.2579017-4-glider@google.com/T/)

This patch was previously called "lib/bitmap: add
bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-2-glider@google.com/)

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
 include/linux/bitmap.h | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..d63d5e4b4ab54 100644
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
@@ -599,6 +603,83 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_read - read a value of n-bits from the memory region
+ * @map: address to the bitmap memory region
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
+ *
+ * Returns: value of nbits located at the @start bit offset within the @map
+ * memory region.
+ *
+ * Note: callers on 32-bit systems must be careful to not attempt reading more
+ * than sizeof(unsigned long).
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
+ * Note: callers on 32-bit systems must be careful to not attempt writing more
+ * than sizeof(unsigned long).
+ */
+static inline void bitmap_write(unsigned long *map,
+				unsigned long value,
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
2.42.0.758.gaed0368e0e-goog

