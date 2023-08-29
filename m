Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F4F78BCEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235484AbjH2CkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:40:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjH2Cjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:39:31 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9991A139
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a7ca8720a0so2790329b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693276767; x=1693881567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g42DUtsBxnSEETRjQXgjfdgHF/buczC6BRWDqCJjhA0=;
        b=Cf0JH8p2x8C70jKgyngGTXQiAAL5zCkHB8UYH9IkE2Jzk4REncTiLbetbx5uAYj1hO
         xiSV13H5JL9F4JCfK8wB67F3xmvTAO80crVUGufVcR3Pw0hfknBHX30m1Qm4YXJcQFeX
         jbLjlbY/kN6Q7F820xsb+N3RhBuetl/kQ3dC2FpXoSmeqUvsDPcp4k8C38qhU9cBgf8P
         wLScZlS+1fnkHhfInpEszdosXem4Sez3EDrtgyx+dM5qeDkdLe2en1bYaS2Uh4MlhwvB
         dfRbXupkOjewicm2RG6EReONyOjQ4IjqzkGi6c1mJHBlh7lYTzhAjG8HZGFZaDZ0cTYn
         AAlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693276767; x=1693881567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g42DUtsBxnSEETRjQXgjfdgHF/buczC6BRWDqCJjhA0=;
        b=Q6x+4ae09+lDE2gdad9QF9h6ycfk6FlajHwq1xRMdnae3cuzXxYweCo32EVfkCb7Qf
         uGWgUomdevqnS0XSJnpMmTQTdYIpD79TTzxDs1c2/8UIIa88lSf5JtcacVePLr7Bf4/0
         tY/VST/2UZfwPjwVUtyyyTh3o4tbsJG5w61V1LOo2Sim/WOKqRGv6X6il8DO15wy7fK1
         4CA5whEZtSVMQbJshzrE8ud5Gr/FTjiN3N7lvz/UpiHzibaAqEy393VnLeunR4Iz9Onz
         tIpSng6UCB/5a7KDoDNtCNoBfKbVY39us1t/brMZnqqsF9jlFtfekGY84QlVswVf6hr8
         ZwyA==
X-Gm-Message-State: AOJu0Ywr4Y+MLb7mSTRIJXr+JHXnXRguaKeJvEUGnHprGEI3SX2yGU5L
        +SNQjf4l5L4rHp4DR++XOmO5+zr3VxY=
X-Google-Smtp-Source: AGHT+IH+AalN1i/+uZ3a1Dai6xtwBR6Sq2P3ovwC6VmsUpQqpY6/UgkpDAWIDLQj4Qmz0JYc8jsd5g==
X-Received: by 2002:a05:6808:1a1c:b0:3a4:35bb:edae with SMTP id bk28-20020a0568081a1c00b003a435bbedaemr14573506oib.29.1693276767505;
        Mon, 28 Aug 2023 19:39:27 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:c222:580f:7592:7110])
        by smtp.gmail.com with ESMTPSA id e9-20020aca2309000000b003a724566afdsm4046407oie.20.2023.08.28.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 19:39:27 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v4 8/8] bitmap: move bitmap_*_region() functions to bitmap.h
Date:   Mon, 28 Aug 2023 19:39:11 -0700
Message-Id: <20230829023911.64335-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230829023911.64335-1-yury.norov@gmail.com>
References: <20230829023911.64335-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that bitmap_*_region() functions are implemented as thin wrappers
around others, it's worth to move them to the header, as it opens room
for compile-time optimizations.

CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 63 ++++++++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 63 ------------------------------------------
 2 files changed, 60 insertions(+), 66 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 1516ff979315..973ae5b11c70 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -216,9 +216,6 @@ void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 		unsigned int sz, unsigned int nbits);
-int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order);
-void bitmap_release_region(unsigned long *bitmap, unsigned int pos, int order);
-int bitmap_allocate_region(unsigned long *bitmap, unsigned int pos, int order);
 
 int bitmap_print_to_pagebuf(bool list, char *buf,
 				   const unsigned long *maskp, int nmaskbits);
@@ -594,6 +591,66 @@ static inline void bitmap_set_value8(unsigned long *map, unsigned long value,
 	map[index] |= value << offset;
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
+ * Return: 0 on success, or %-EBUSY if specified region wasn't
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
+/*
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
+ * Return: the bit offset in bitmap of the allocated region,
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
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/lib/bitmap.c b/lib/bitmap.c
index ab730ce52d21..65a6d5d47d81 100644
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
 unsigned long *bitmap_alloc(unsigned int nbits, gfp_t flags)
 {
 	return kmalloc_array(BITS_TO_LONGS(nbits), sizeof(unsigned long),
-- 
2.39.2

