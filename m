Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA8D7C5A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbjJKR2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231956AbjJKR2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:28:46 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0508F
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:44 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so41190276.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 10:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697045324; x=1697650124; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nI0HTgriMF6qPeJyUiAWZNrj0o9oAYviJ9iKh7dKc=;
        b=w/FTKiKE52Fmb5nq6QK/xg6CIiTd073XN3fokce6XFoGykBJH2p2hrLgCdfByvpbz7
         I4sevIdL3vTnA518qMKdtxeBt2PucsxtY7j9IExvN83ew6q2kNkbbCJ++L0b8W5HLvKU
         HBtB1zBHLdZfsUS24sAJYhl+ETPIP4Vp32FMnBZkAcv5TXHNIiKidDkw4l/GkCrr84F7
         hyKeQ09YYmPExKw79SnUvMdvPeuvVGCWBu08jG6sFcusDbn6+PyZmawQpcwcJhewwUw/
         qxsGqOCpv5R2Rg+YMhWu6h2oKxX3dnMw1EqAvqhSgcy9YN6yNCG9DYu6gpIJNys4zVOT
         0bFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697045324; x=1697650124;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d+nI0HTgriMF6qPeJyUiAWZNrj0o9oAYviJ9iKh7dKc=;
        b=c9YNN+3H15ZiPXkW8WBS60/7brpBbLCaChI+JpCyDf0pbKhmYqwIsKfs7vF3V0TRzS
         X1rdXdFsjOF7nF6HjuXDrGdHSLpXiv7Xv7Vp62LVg9zeUoF5SEVdzI8LCDHV1zdHYkCH
         dsVx76mT0KK615sKA6xXe3e6hPzHDO0SknVjY6elths5KDy64NFDnONju3na89Kgt/PW
         vZEPZa5TYrZogiskWaAZuoQtx7lZGALul6FR9Tt5z9pjTcB0CHY7ZhKsq4P9AOvW+Eq8
         mFfSIv+Y1ciVQ1ijkImwOuCRaE0KjlF9DfFNTws78AO6bQUPUk4J5wFu9nOGihsEbMpQ
         3aAA==
X-Gm-Message-State: AOJu0Yz7lhq1xgETr0ErQ+emm9up2C6iHUu4IqjJano/6rOgZs9dYvfg
        RwVdaPS8bcrr/BIaYEeGdzGxeiu5keA=
X-Google-Smtp-Source: AGHT+IHy1hZu+BqPEBfEz2UPILp141PTPuGZ0odR5sOF+8g1dBGxjIYuTkjZH2SQKV8QdVpkGIpYiq7xhO4=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:fe58:8292:66f9:d221])
 (user=glider job=sendgmr) by 2002:a05:6902:52d:b0:d13:856b:c10a with SMTP id
 y13-20020a056902052d00b00d13856bc10amr374491ybs.3.1697045324159; Wed, 11 Oct
 2023 10:28:44 -0700 (PDT)
Date:   Wed, 11 Oct 2023 19:28:31 +0200
In-Reply-To: <20231011172836.2579017-1-glider@google.com>
Mime-Version: 1.0
References: <20231011172836.2579017-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.609.gbb76f46606-goog
Message-ID: <20231011172836.2579017-2-glider@google.com>
Subject: [PATCH v7 1/5] lib/bitmap: add bitmap_{read,write}()
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/linux/bitmap.h | 75 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1efb..c413e2ecb6286 100644
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
@@ -599,6 +603,77 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
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
+	if (unlikely(!nbits))
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
2.42.0.609.gbb76f46606-goog

