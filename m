Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F02B17AABEE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbjIVIJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjIVIJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:09:01 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 769D2CC3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:55 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81ff714678so2554890276.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695370134; x=1695974934; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Elogy5+qJLTNkCkBSFtWFfKDNFj74CbHYILaVC5jihg=;
        b=0GcVYMl7twYtfjutYXgqAJSbiTT/vcDXiio2QOjMt5s0rtQ3gQng4zjEwjSAS1lfPA
         0oxdCdF9bYNkdInjHy92YSIcRd0PqUyqqm+CmqjmLrUTB1OT3tQLk13a9Ipgee5iAu1t
         rIIDC5M3NN9RDkvcf6/chRf3ulgjiO8d/Wfqup3IGcJv1XkJ+YMeKck7yVsSdEqgsbYb
         HAs4iUsIqWA0wnpsepIiwayR86huK4R13RS0RUo7v80AaDvb4+mWyZvkukzzBytq5PON
         UlqojhBdbxpXr1aZHasBHeIZZVncw2C1RcUIf3X2skS6WDiyRYS7p1A7M3hpdHNba0IB
         M7xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695370134; x=1695974934;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Elogy5+qJLTNkCkBSFtWFfKDNFj74CbHYILaVC5jihg=;
        b=IweEgGYVqYVJqGgcGK8O9kr+f+vD+3zG/5YKOuBgnfDU/DSB/zpzMYhLf2ylbFLcVs
         LKRYAEkKQxpUeMdmW6dFRyqVOlJQSBcqhZHeTZjG8LxvCsdpJliLd5+p4P/RVc7vJdn0
         umWWEcwXgF0K1nwSCNFj9KW4ja0zmK5Q/Odp/l1W9VeoL/rWT+DIRFzKVd9l8XhBvA5t
         TWWZarl5dcu5DpwXsx8hftOA0QiloVrd2lmifi+qBjQYTHDDjfkEr3PHXhhX2mMiqals
         2p07oALk1WUz6G3jeg3BOQQLsl2th3CrQns0p3PtvdoTdiP4Mk/ZAiKLKOmdyG6cvhEn
         2/Rg==
X-Gm-Message-State: AOJu0YxBL/K1XIdbT8zaqGt3+Dfr+vqzPW0zt4IsW/1QwVAhoWkaD7CR
        65YV8nRS7ESogGW5G5U4gUJp5LkLpKM=
X-Google-Smtp-Source: AGHT+IEIg08sMWgsU2dpUwbs8V0A/UbOXdfFwC4vUM4CEL6+zIIR7/9FfGEhDr5Ikm90mlPDMGYtHnmXj1M=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:4da0:80d4:9480:7d5c])
 (user=glider job=sendgmr) by 2002:a25:f43:0:b0:d81:754a:7cbb with SMTP id
 64-20020a250f43000000b00d81754a7cbbmr101892ybp.11.1695370134613; Fri, 22 Sep
 2023 01:08:54 -0700 (PDT)
Date:   Fri, 22 Sep 2023 10:08:43 +0200
In-Reply-To: <20230922080848.1261487-1-glider@google.com>
Mime-Version: 1.0
References: <20230922080848.1261487-1-glider@google.com>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922080848.1261487-2-glider@google.com>
Subject: [PATCH v5 1/5] lib/bitmap: add bitmap_{read,write}()
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
index 03644237e1efb..25998a3a4b2b9 100644
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
@@ -599,6 +630,43 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
+/**
+ * bitmap_write - write n-bit value within a memory region
+ * @map: address to the bitmap memory region
+ * @value: value to write, clamped to nbits
+ * @start: bit offset of the n-bit value
+ * @nbits: size of value in bits, up to BITS_PER_LONG.
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
2.42.0.515.g380fc7ccd1-goog

