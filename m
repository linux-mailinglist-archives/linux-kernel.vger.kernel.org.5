Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671EB7BB99F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 15:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjJFNqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 09:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232530AbjJFNpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 09:45:53 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EEAA19F
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 06:45:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59e8ebc0376so29390987b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696599936; x=1697204736; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FVc3w80Slds1rDJeGDtC5d5l1mYuX/jp9UzDI84XpOg=;
        b=v3UbX2CqS7W30A+nhyshcgQVxcFgh2c7QdExDVSdunWpt0UDi6FRpnwSLCyJIGFn0W
         ye6zGHTb/Kz2OvEozN3jkHEkt0htrlykzF8orwyGP5uWDoBw83TqMSVJ7dgAWaSNJ0pZ
         ViqIpNh6lCJWiI/HPlDIScpJYgaEfarFyGLW0fljnPJCs0tj50SCmYpnMwkXqCg2l16F
         +p0oNzsYsqTCoT+q4ErM7BnQqYcEi4CMRL83LZnWw6X/THYPrbdYBYkkujpx9OEo5v8a
         6ijNjpgfrMv9YdDodVVbSvdXV56alkB+ND72WPqhEXEMOjd960C4oIPGteZu94MOmx07
         yHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696599936; x=1697204736;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FVc3w80Slds1rDJeGDtC5d5l1mYuX/jp9UzDI84XpOg=;
        b=HI34eIFh5jev0SoqNYRijUSb3AOMK/rEr1WsSmZD55xgh6ruG+D81jAIlmITYc33X+
         x6IwLzKgoXD+VGa2t2JoVYlaZ6jvdnXV8/E0mPOUaIJG5t9sV8GAjR4ThjDfoFbKO1k9
         k3gIg+el1+SAeepZEMd5xdFPYBxu7Jkj8BBX3Dl+4qHeDbzBTUJyDBFEAbLpE3kSW9Qa
         Gqpn2sJIi+htxuNL8PauSoDayROlffJ4A3JYeFYTrAaMREoI2RmfXuHi5EW5+HZ4q3ut
         Q5KfwLlPGk/nY9hivfPMj9vcEs+ebVALHg6iRM8P/mAltaF+2/DjCOiG/jM3Am11S9Rp
         6bHQ==
X-Gm-Message-State: AOJu0YyAstYQNeEvZ+dxEZ89z+BGMQxv9bC0nkEe/5dEQVOe4UC+qis3
        7AufFNKqv+GZRJRRPcQR13qe49XC4hc=
X-Google-Smtp-Source: AGHT+IGBAwP4WDOXMvPWUp8IcF7MTJBHGAe+KbBVrfCsWOIPDnl6zmllpTVlILvsZDLh/Z18+aAlyE1J9ho=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:2691:23e9:f01f:964])
 (user=glider job=sendgmr) by 2002:a05:6902:13cc:b0:d91:8876:2040 with SMTP id
 y12-20020a05690213cc00b00d9188762040mr133955ybu.5.1696599936015; Fri, 06 Oct
 2023 06:45:36 -0700 (PDT)
Date:   Fri,  6 Oct 2023 15:45:25 +0200
In-Reply-To: <20231006134529.2816540-1-glider@google.com>
Mime-Version: 1.0
References: <20231006134529.2816540-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231006134529.2816540-2-glider@google.com>
Subject: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com, catalin.marinas@arm.com, will@kernel.org,
        pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com
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
This patch was previously called "lib/bitmap: add
bitmap_{set,get}_value()"
(https://lore.kernel.org/lkml/20230720173956.3674987-2-glider@google.com/)

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
 include/linux/bitmap.h | 68 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..e72c054d21d48 100644
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
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG
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
@@ -599,6 +630,43 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, nonzero, up to BITS_PER_LONG.
+ *
+ * bitmap_write() behaves similarly to @nbits calls of assign_bit(), i.e. bits
+ * beyond @nbits are ignored:
+ *
+ *   for (bit = 0; bit < nbits; bit++)
+ *           assign_bit(start + bit, bitmap, val & BIT(bit));
+ */
+static inline void bitmap_write(unsigned long *map,
+				unsigned long value,
+				unsigned long start, unsigned long nbits)
+{
+	size_t index = BIT_WORD(start);
+	unsigned long offset = start % BITS_PER_LONG;
+	unsigned long space = BITS_PER_LONG - offset;
+	unsigned long mask;
+
+	if (unlikely(!nbits))
+		return;
+	mask = BITMAP_LAST_WORD_MASK(nbits);
+	value &= mask;
+	if (space >= nbits) {
+		map[index] &= ~(mask << offset);
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
2.42.0.609.gbb76f46606-goog

