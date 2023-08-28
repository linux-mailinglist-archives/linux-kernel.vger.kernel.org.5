Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4628878B776
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjH1Soa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbjH1SoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:11 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23524B3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:08 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1c4de3b9072so2547124fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248247; x=1693853047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BO9WTCDSdetqwfC+adFwBkJ/NQLbVLN7w9OB2nLu2Hc=;
        b=DLek+L8gCTU0hMcedn9UA3/i0XY1QAITS45X6Ot7ZMKcvuRbZBrW7ljoLCAHxQe9CD
         +ZwSVm1AL50qjt59vQUPGZYruGPhk5OCcTLPUtC9bW7p+JzPRGzWT7xM7TZoY0OXysVx
         XTVPO16r+Az/KqypLw76ul0WyY025xuBzI14JhiAzFWCrYhs5v8ffIJhtHBLPhwG4wGO
         SUJY1lRdvfno2LLT3R+qjiOnrdNiNdd5o8oNvp/8Nu5j4unEQqdVGtDABfWr47ICQOAw
         jAn2ePCpVYCnPpYYpqBdSlv6PXD2acut/gzda4+7O2ziB0CiDhQX4mUJ+az3GuEbtjC8
         pEcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248247; x=1693853047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BO9WTCDSdetqwfC+adFwBkJ/NQLbVLN7w9OB2nLu2Hc=;
        b=j5HUrEZ53FjaX7YZ16MscGVWHwG/dfHWmbLYo27O/zX0eYqW1KCM7kRQHBmatuO2Kc
         Up1O1PVdyy/trpK9z8BS0lgIBauwkEHZ6C8bWkZ5A2b1V++fJIu4gxeQCEtSq4Eh9hgx
         5agmxgszZYyJQMBV0RsiwOSdXr0yqL+0K3uAErVIhXyzSu/IJedsnMBZ8Yf6LZnvinx3
         /H4qEYIR1KdxYuGLtgfDB07sFidIrwFqEp9I8rST2Bur71xxBib3PArBwB5Avu7RLB2D
         U9m5+zOhLsXMz5W+YkxhWFZYgpbcJh8VVkGyDDWdd9V8Rt2XNdUHdQrQtYq3+r3PiWSk
         3C1Q==
X-Gm-Message-State: AOJu0YzUZFDpgfPZ7ciNU5vtsudvZIQx7M70xL9d2Gj40h6rOCVvx1dA
        uw09yyJIyWiK4Ei8QRoMqgB+FyExQjM=
X-Google-Smtp-Source: AGHT+IE/G/wNcyY5+i7oSoidqwFqCa9RNOmaz8F0+1Vn3Ze2ATe1jqHhSeiQH5EYSLzeDuC0fcxjjw==
X-Received: by 2002:a05:6870:414d:b0:1bf:32bf:1913 with SMTP id r13-20020a056870414d00b001bf32bf1913mr11968205oad.43.1693248247059;
        Mon, 28 Aug 2023 11:44:07 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id 67-20020a4a1446000000b005660ff9e037sm4321624ood.25.2023.08.28.11.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 07/12] bitmap: add small_const_nbits() optimization for bitmap_bitremap()
Date:   Mon, 28 Aug 2023 11:43:47 -0700
Message-Id: <20230828184353.5145-8-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
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

When 'bits' is less than BITS_PER_LONG, we can remap a bit inline.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 36 ++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 15 ++-------------
 2 files changed, 36 insertions(+), 15 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 486451b80339..da5030a99af5 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -163,6 +163,8 @@ void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *mask, unsigned int nbits);
 void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new, unsigned int nbits);
+int __bitmap_bitremap(int oldbit,
+		const unsigned long *old, const unsigned long *new, int nbits);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_subset(const unsigned long *bitmap1,
@@ -214,8 +216,6 @@ int bitmap_parselist(const char *buf, unsigned long *maskp,
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
 
-int bitmap_bitremap(int oldbit,
-		const unsigned long *old, const unsigned long *new, int bits);
 void bitmap_onto(unsigned long *dst, const unsigned long *orig,
 		const unsigned long *relmap, unsigned int bits);
 void bitmap_fold(unsigned long *dst, const unsigned long *orig,
@@ -733,6 +733,38 @@ static inline void bitmap_remap(unsigned long *dst, const unsigned long *src,
 	__bitmap_remap(dst, src, old, new, nbits);
 }
 
+/**
+ * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
+ *	@oldbit: bit position to be mapped
+ *	@old: defines domain of map
+ *	@new: defines range of map
+ *	@nbits: number of bits in each of these bitmaps
+ *
+ * A special case of bitmap_remap(), when a single bit remapping is needed.
+ *
+ * Returns: position of remapped bit
+ */
+static inline int bitmap_bitremap(int oldbit,
+		const unsigned long *old, const unsigned long *new, int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		unsigned int w, n;
+
+		if ((*old & BIT(oldbit)) == 0 ||
+		    (*old & BITMAP_LAST_WORD_MASK(nbits)) == 0 ||
+		    (*new & BITMAP_LAST_WORD_MASK(nbits)) == 0 ||
+		    ((*new ^ *old) & BITMAP_LAST_WORD_MASK(nbits)) == 0) {
+			return oldbit;
+		}
+
+		w = bitmap_weight(new, nbits);
+		n = bitmap_weight(old, oldbit);
+		return find_nth_bit(new, nbits, n % w);
+	}
+
+	return __bitmap_bitremap(oldbit, old, new, nbits);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 2ac48d9bcbc0..9ecdc74cb6b4 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1014,18 +1014,7 @@ void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 }
 EXPORT_SYMBOL(__bitmap_remap);
 
-/**
- * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
- *	@oldbit: bit position to be mapped
- *	@old: defines domain of map
- *	@new: defines range of map
- *	@bits: number of bits in each of these bitmaps
- *
- * A special case of bitmap_remap(), when a single bit remapping is needed.
- *
- * Returns: position of remapped bit
- */
-int bitmap_bitremap(int oldbit, const unsigned long *old,
+int __bitmap_bitremap(int oldbit, const unsigned long *old,
 				const unsigned long *new, int bits)
 {
 	int w = bitmap_weight(new, bits);
@@ -1035,7 +1024,7 @@ int bitmap_bitremap(int oldbit, const unsigned long *old,
 	else
 		return find_nth_bit(new, bits, n % w);
 }
-EXPORT_SYMBOL(bitmap_bitremap);
+EXPORT_SYMBOL(__bitmap_bitremap);
 
 #ifdef CONFIG_NUMA
 /**
-- 
2.39.2

