Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63AC47643A6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 04:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbjG0CC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 22:02:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbjG0CCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 22:02:47 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1AC30C8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:35 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-686b643df5dso384952b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 19:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690423354; x=1691028154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJiXy/aSAKGmCQKaY16SsuP/c/XgbaK7793lnhKddOY=;
        b=Q1SUTW6xJiZ/vNrA/wzX08DfryWTulhgAkq/EN/6lNbEANXOVyBy5vq8uxTeZbGFcw
         umbiwfirDCFVQStskPKR9+cwexZK+mEqA5iowAC6QMON4ijCV9E8hBa00diHTK53ZEsJ
         uovpfNZbS3KQ088QeMvLYB6LzCfa9JFryZcHNTYyw7ScN6KSZvlvHjgLDRkVwWAx3Mnq
         EIhJvSO4+0EzSH5cg4l1JbJG01lofbSEip+y1GElamWCDxbzkULuy/zcEgkh4sMYUSFW
         gEVIsbdZo//2a0uU3zvt4jOnAEoXQsZg80lK6n7os6mSlPZAsgaerbLi1EnJMZu4EqUf
         8K2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690423354; x=1691028154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SJiXy/aSAKGmCQKaY16SsuP/c/XgbaK7793lnhKddOY=;
        b=GfX/nVgrD2wTPFaTzocv6BYFQmN1XiYAklYNDoIjrawxxPKbK+4kWH+uuhP/pHz5/q
         8MKZiTqf9yZgK0HLK8wKzeq3+wgYOIB40cnAMsz6DkXCO6BfWi8Eg2QLXg5cZi9JRat3
         vLC+d+HkE1L8hn73GEOPn1YhstsvHqSEwE6f+URm415FZFaeBeDQTA4Jr7+d6p7dmaHM
         NOMN+jcRRs8m9Q44NYHOQR/oaUGJwAyJPZwSz/qy+SChDUepyUFWxhKu/WwTNnIBZgIe
         gRrQdOTdY733hBtWqaqUgT0QipP5Hzy9nNOM4FKASxrd0zMkMRerYCvSOYLsHK89eMyF
         MRuw==
X-Gm-Message-State: ABy/qLadx3nul8nCsDwbHjwXIvxyzxwrazGhi2vy/YkwVQxa8Rgfb2MD
        I5m5a5fvHecSVZXGAGFmu+aikZ6w+ZM6iA==
X-Google-Smtp-Source: APBJJlFhe/VDUbWXklEqRqVigUWiBB6Px7vr2ipeO3qdSh4B705E06Nkxu6ab79wnkqAY++3jDIklQ==
X-Received: by 2002:a05:6a00:cc6:b0:666:8cbb:6e0f with SMTP id b6-20020a056a000cc600b006668cbb6e0fmr3980846pfv.3.1690423353845;
        Wed, 26 Jul 2023 19:02:33 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id t28-20020aa7939c000000b00682b299b6besm258735pfe.70.2023.07.26.19.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 19:02:33 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Date:   Wed, 26 Jul 2023 19:02:07 -0700
Message-Id: <20230727020207.36314-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230727020207.36314-1-yury.norov@gmail.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 include/linux/bitmap.h | 65 ++++++++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 65 ------------------------------------------
 2 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..6c8d28419616 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -216,9 +216,68 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
-int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
-void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
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
+ * Return the bit offset in bitmap of the allocated region,
+ * or -errno on failure.
+ */
+static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
+{
+	unsigned int pos, end;		/* scans bitmap by regions of size order */
+
+	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end)
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
+
+	return -ENOMEM;
+}
+
+/**
+ * bitmap_release_region - release allocated bitmap region
+ *	@bitmap: array of unsigned longs corresponding to the bitmap
+ *	@pos: beginning of bit region to release
+ *	@order: region size (log base 2 of number of bits) to release
+ *
+ * This is the complement to __bitmap_find_free_region() and releases
+ * the found region (by clearing it in the bitmap).
+ *
+ * No return value.
+ */
+static inline void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
+{
+	bitmap_clear(bitmap, pos, pos + BIT(order));
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
+ * Return 0 on success, or %-EBUSY if specified region wasn't
+ * free (not all bits were zero).
+ */
+static inline int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
+{
+	unsigned int nbits = pos + BIT(order);
+
+	if (find_next_bit(bitmap, pos, nbits) < nbits)
+		return -EBUSY;
+	bitmap_set(bitmap, pos, nbits);
+	return 0;
+}
 
 #ifdef __BIG_ENDIAN
 void bitmap_copy_le(unsigned long *dst, const unsigned long *src, unsigned int nbits);
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 7cfe0b442c73..1c5d1f5d2071 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,71 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
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
- * Return the bit offset in bitmap of the allocated region,
- * or -errno on failure.
- */
-int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
-{
-	unsigned int pos, end;		/* scans bitmap by regions of size order */
-
-	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end)
-		if (!bitmap_allocate_region(bitmap, pos, order))
-			return pos;
-
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
- *
- * No return value.
- */
-void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order)
-{
-	bitmap_clear(bitmap, pos, pos + BIT(order));
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
- * Return 0 on success, or %-EBUSY if specified region wasn't
- * free (not all bits were zero).
- */
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order)
-{
-	unsigned int nbits = pos + BIT(order);
-
-	if (find_next_bit(bitmap, pos, nbits) < nbits)
-		return -EBUSY;
-	bitmap_set(bitmap, pos, nbits);
-	return 0;
-}
-EXPORT_SYMBOL(bitmap_allocate_region);
-
 /**
  * bitmap_copy_le - copy a bitmap, putting the bits into little-endian order.
  * @dst:   destination buffer
-- 
2.39.2

