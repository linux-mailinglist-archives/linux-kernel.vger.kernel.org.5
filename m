Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403237ACE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbjIYCjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjIYCiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:52 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B3F10B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:36 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-d868d8363e6so2154086276.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609514; x=1696214314; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jMPtW3pZJxX1hohu3538oy2bndPs8CNuEF5Ud1QaLi0=;
        b=Y8OEr0O5w+oWE2/XFTJ50v+ShoM5FnB43Y+gyj17GBRlRiFssUqeu1F7RLoqiX4cCo
         PJV6bXlRyANinbbxuw8UzVOfVWAYAcKRNMnjVAtQLhPZMAMRJJVFHUd3spcS+lYbW2sy
         RlxC2ZquIAZ9dzlL+B/6laAbpNI9Dr99rOYdvpqXnM64UL9TtSQe7eBjbUUGMVFOWoIa
         Z9Qfa+/taQZhCIh6T4VH9jAKpYt4C4fTGqNFjKIDD3CeMRwoYyIbUWlxq9wRp1AOMG0I
         Q+tKVNNVRSpfuR+8pFA8ThoiGYeIG+pO9O5uS3OU+kINhqQXpTwWsa8ksXszO8qsfmJT
         20FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609514; x=1696214314;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jMPtW3pZJxX1hohu3538oy2bndPs8CNuEF5Ud1QaLi0=;
        b=DjnVaqWSyJHfKriagn8gTGg/HZgcsV/zC3+/gFVk30h9+26vaa/ENavIJbMWE5Yyhc
         FXds/NXi2zuLV9kGq9/uynLMimBwX9wAgY/ouo8Jwrjy7ed7XG6rfGkyk7DX3BHzEJAt
         XwolmE7DiMAeLN5L6e1NNOOhzUJoNnjeZ+ahnmV5Vfd2yOecO9RvBSJ48beBGN1DNoW8
         eVeeyt+3IkN30h0kh7HRT4ii0qAfc3+JeRzuB1ZGj5SAINNVUYIT+adMBHDM/j4bE/W7
         HA/CJ8U0g2lHC4hOOY2FwcglGIpI6afBVrKDtrMeuDa/9OcPp1cQb30r6+TnkMJVR+sE
         WGcA==
X-Gm-Message-State: AOJu0YwBLjoLfjKyttY725W2CKIDNJ+kCg7jzNEluklAmfl4IkCOPIyV
        hgSjDa/QPqy4qyivA0y1QoyE2RRMpjo=
X-Google-Smtp-Source: AGHT+IHKFslh6mrWbC67+VZpVB15LCSjaxV0XuIa5bWEBKeTkcKBVLlw7tHduMoMH4KcrkbwUCnx3Q==
X-Received: by 2002:a25:e082:0:b0:d81:41b1:448c with SMTP id x124-20020a25e082000000b00d8141b1448cmr4954181ybg.43.1695609514332;
        Sun, 24 Sep 2023 19:38:34 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id v3-20020a25c503000000b00d814d8dfd69sm2001110ybe.27.2023.09.24.19.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:34 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 8/8] bitmap: move bitmap_*_region() functions to bitmap.h
Date:   Sun, 24 Sep 2023 19:38:17 -0700
Message-Id: <20230925023817.782509-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925023817.782509-1-yury.norov@gmail.com>
References: <20230925023817.782509-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that bitmap_*_region() functions are implemented as thin wrappers
around others, it's worth to move them to the header, as it opens room
for compile-time optimizations.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 63 ++++++++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 63 ------------------------------------------
 2 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..9b097f83d785 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -216,9 +216,6 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
-int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
-void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
 
 #ifdef __BIG_ENDIAN
 void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
@@ -518,6 +515,66 @@ static inline void bitmap_next_set_region(unsigned long *bitmap,
 	*re = find_next_zero_bit(bitmap, end, *rs + 1);
 }
 
+/**
+ * bitmap_release_region - release allocated bitmap region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to release
+ *	@order: region size (log base 2 of number of bits) to release
+ *
+ * This is the complement to __bitmap_find_free_region() and releases
+ * the found region (by clearing it in the bitmap).
+ */
+static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
+{
+	bitmap_clear(bitmap, pos, BIT(order));
+}
+
+/**
+ * bitmap_allocate_region - allocate bitmap region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to allocate
+ *	@order: region size (log base 2 of number of bits) to allocate
+ *
+ * Allocate (set bits in) a specified region of a bitmap.
+ *
+ * Returns: 0 on success, or %-EBUSY if specified region wasn't
+ * free (not all bits were zero).
+ */
+static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+{
+	unsigned int len = BIT(order);
+
+	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
+		return -EBUSY;
+	bitmap_set(bitmap, pos, len);
+	return 0;
+}
+
+/**
+ * bitmap_find_free_region - find a contiguous aligned mem region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@bits: number of bits in the bitmap
+ *	@order: region size (log base 2 of number of bits) to find
+ *
+ * Find a region of free (zero) bits in a @bitmap of @bits bits and
+ * allocate them (set them to one).  Only consider regions of length
+ * a power (@order) of two, aligned to that power of two, which
+ * makes the search algorithm much faster.
+ *
+ * Returns: the bit offset in bitmap of the allocated region,
+ * or -errno on failure.
+ */
+static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
+{
+	unsigned int pos, end;		/* scans bitmap by regions of size order */
+
+	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
+	}
+	return -ENOMEM;
+}
+
 /**
  * BITMAP_FROM_U64() - Represent u64 value in the format suitable for bitmap.
  * @n: u64 value
diff --git a/lib/bitmap.c b/lib/bitmap.c
index cc6180dd6254..1c5d1f5d2071 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,69 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 }
 #endif /* CONFIG_NUMA */
 
-/**
- * bitmap_find_free_region - find a contiguous aligned mem region
- *	@bitmap: array of unsigned longs corresponding to the bitmap
- *	@bits: number of bits in the bitmap
- *	@order: region size (log base 2 of number of bits) to find
- *
- * Find a region of free (zero) bits in a @bitmap of @bits bits and
- * allocate them (set them to one).  Only consider regions of length
- * a power (@order) of two, aligned to that power of two, which
- * makes the search algorithm much faster.
- *
- * Return: the bit offset in bitmap of the allocated region,
- * or -errno on failure.
- */
-int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
-{
-	unsigned int pos, end;		/* scans bitmap by regions of size order */
-
-	for (pos = 0; (end = pos + BIT(order)) <= bits; pos = end) {
-		if (!bitmap_allocate_region(bitmap, pos, order))
-			return pos;
-	}
-	return -ENOMEM;
-}
-EXPORT_SYMBOL(bitmap_find_free_region);
-
-/**
- * bitmap_release_region - release allocated bitmap region
- *	@bitmap: array of unsigned longs corresponding to the bitmap
- *	@pos: beginning of bit region to release
- *	@order: region size (log base 2 of number of bits) to release
- *
- * This is the complement to __bitmap_find_free_region() and releases
- * the found region (by clearing it in the bitmap).
- */
-void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
-{
-	bitmap_clear(bitmap, pos, BIT(order));
-}
-EXPORT_SYMBOL(bitmap_release_region);
-
-/**
- * bitmap_allocate_region - allocate bitmap region
- *	@bitmap: array of unsigned longs corresponding to the bitmap
- *	@pos: beginning of bit region to allocate
- *	@order: region size (log base 2 of number of bits) to allocate
- *
- * Allocate (set bits in) a specified region of a bitmap.
- *
- * Return: 0 on success, or %-EBUSY if specified region wasn't
- * free (not all bits were zero).
- */
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
-{
-	unsigned int len = BIT(order);
-
-	if (find_next_bit(bitmap, pos + len, pos) < pos + len)
-		return -EBUSY;
-	bitmap_set(bitmap, pos, len);
-	return 0;
-}
-EXPORT_SYMBOL(bitmap_allocate_region);
-
 /**
  * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
  * @dst:   destination buffer
-- 
2.39.2

