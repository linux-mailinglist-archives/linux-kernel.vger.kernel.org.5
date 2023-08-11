Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9556A7784B0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjHKA6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjHKA6s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:58:48 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF3E5270F
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:47 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-40fe3850312so9889521cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715526; x=1692320326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddLmhN15PUj4uyQW+oDahxYwNd51fKztIVjwBzF/ptQ=;
        b=MyIhrapm5pg0ZvgXd8y3on/19UYOWUBhXu1RZbTu6tX/SyV+oEcd+itArGcjAmaoxd
         TNdbTtDJ/LR70ieXCK1POeEsPb4CBbQUW4pZN+v/axywsnJsG+7/7qfvL/ZkChuMYnfW
         irxpyJbmS6AskxC1yE4zV5gN6g4XmOoIF9z0iD6y5cANGI/wYnwswqM6MnJ2gGaEDPTg
         SliQmRFeLMrNzfgfd4JF9sh9heGSnKW0gUUVqT5s1P4GVkwPxdpt/9+H4Z2l80Df0Mog
         xDGS5PLz3TRdFFEkj0LhoBxJjAeShJohN5+UN7Ze/lDoHhKycDypH/QAG5MhXHRQXdRE
         EBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715526; x=1692320326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddLmhN15PUj4uyQW+oDahxYwNd51fKztIVjwBzF/ptQ=;
        b=Z0Oz2+CI4fwAYdeBNJDEu1aLdIL1SDmV0DkyYHpZaipKdK0mmJI7rp4Ozqn64p4mdi
         xPgleWooXEzk2+msq1mMYBHWn4bHzzkcTYgfubXcQMABwHH+Gz2mkUWJ7+gJ+mCDK+e7
         bbrXihr7yAuwem7DRDt7TS3g55X0r1Q4iqxe9fjjhEbJ5QmNU0Qypf2R1Lclhg1dqbYk
         ZZb+dHMStaj/w8NVEYaJ2z8okdDxePoUl+IP3vtg7DDgYbvKbN/oPxlokdgvB4DYjgMa
         Hv35u657Tpi+FqjgmgrAcU7tw2Noszb1pnorFxwvn3IiAwYvPXIr+oMDf1C73fX3gBi7
         eMeg==
X-Gm-Message-State: AOJu0Yz0uP507BI6rv9z58lx3X8GW+Fa6yTCF96OkSJG1gqb506Pye/B
        988zosfwQX/elz3Yhw8j1WLew6hCrxI=
X-Google-Smtp-Source: AGHT+IHlTSXZXC9YLlUWaYjKVTgbjeLZmXZ5sDMzLwdNLrdnPvRasgKsG1GSPAzJI9qkuJUsMtPakQ==
X-Received: by 2002:a05:622a:14:b0:405:5cf5:7bf0 with SMTP id x20-20020a05622a001400b004055cf57bf0mr463636qtw.53.1691715526390;
        Thu, 10 Aug 2023 17:58:46 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id ce11-20020a05622a41cb00b0040fef71dc1esm857965qtb.10.2023.08.10.17.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:58:46 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Date:   Thu, 10 Aug 2023 17:57:32 -0700
Message-Id: <20230811005732.107718-7-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811005732.107718-1-yury.norov@gmail.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
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
 include/linux/bitmap.h | 65 ++++++++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 65 ------------------------------------------
 2 files changed, 62 insertions(+), 68 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 03644237e1ef..aa33fc290619 100644
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
@@ -599,6 +596,68 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
 }
 
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
+	for (pos = 0 ; (end = pos + BIT(order)) <= bits; pos = end)
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ae619523c3ec..1c5d1f5d2071 100644
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
-	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
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

