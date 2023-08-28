Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1978B775
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbjH1So3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjH1SoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:09 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3417B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:06 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a36b52b4a4so1932224b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248245; x=1693853045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ILiXnngfnpSXcy8/UYRmE0PAU6XZ+LgZEWRToIxyalw=;
        b=sevmt5hHeWtnfIgvXbsYIXsPTHGIFOGCYwBF3DlxQ7XwZ4rBsmGuAAiW6DGpJd9Qco
         LdmhRA5IMU0sEHBm8BY9G+AXw1J/FCXUwqzdBLSabbri+iJ5V0caSNkG7ThuTQ99+msS
         a5KzQntqxOnVH+vd4Rxqr+Pg6oNeoEbdyrAqelAHd/OInbsXD9bcyTc4137aqOhb3s86
         Wyr9zks/yVTIUkiblCf7OnFmNS6lpkxLEE0AHVlncXMr7aSz1DBbHR/XsOM0UkKuDgqz
         2YLKnjT0LDx55rR/qOk2KZYP5HYlOf9JBhj0MVHpoE/ET695FbhpOS1Ghr9xZkr1euZE
         wyXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248245; x=1693853045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ILiXnngfnpSXcy8/UYRmE0PAU6XZ+LgZEWRToIxyalw=;
        b=cvOg8Nj40saZxWAca41RRznu1XFDE0CSWkrvUrIAskqayHfnBybt9Hfo88GUFUHDCL
         i4I8fM8C1WcavPyUZ46OF/lpJVZgpdnXce3dOg2jJ5MxaZyha6NmAaw5YUrRRllGwtP8
         xNI9/2i30GqAb80pvb+8ylaWwu8RIenlh87qmGH7mCCt7y3L/1luAx7OMhlrJjiPjiDS
         Y76vxyicbY6t189W1bteceQCIuJ9Pt53vKIxSkO86sJBot7ZobAxMl3i3+A1yRHsIwel
         7yugAiKgDEuBRCqiKuKx0SiUCAQm5/rk7r/QlKhkWFfjyU/PKA1SPW6HFwzk6CEaIhfe
         mx2Q==
X-Gm-Message-State: AOJu0YwKd+CdKCvy/kr138P2Tsmuj/jOvhr1bKutxK+AOt/YnVKNS/jy
        nJwWh9xdMp3tdcdbVGr+iQL1f1BKct4=
X-Google-Smtp-Source: AGHT+IH00igx/EL9+HVJ5wdZmo53lXN84sIekHslWeQ90jsoEQGMJaHGB2BdYwntULBa5VPUm/2Y6Q==
X-Received: by 2002:a05:6808:13c1:b0:3a7:551c:a863 with SMTP id d1-20020a05680813c100b003a7551ca863mr342141oiw.10.1693248245633;
        Mon, 28 Aug 2023 11:44:05 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id bl3-20020a056808308300b003a7a422cb6asm3684705oib.37.2023.08.28.11.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:05 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 06/12] bitmap: add small_cont_nbits() optimization for bitmap_remap()
Date:   Mon, 28 Aug 2023 11:43:46 -0700
Message-Id: <20230828184353.5145-7-yury.norov@gmail.com>
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

When nbits is less than BITS_PER_LONG, we can handle trivial cases
inline.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 66 ++++++++++++++++++++++++++++++++++++++++--
 lib/bitmap.c           | 49 ++-----------------------------
 2 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 6acbdd2abd0c..486451b80339 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -161,6 +161,8 @@ bool __bitmap_andnot(unsigned long *dst, const unsigned long *bitmap1,
 void __bitmap_replace(unsigned long *dst,
 		      const unsigned long *old, const unsigned long *new,
 		      const unsigned long *mask, unsigned int nbits);
+void __bitmap_remap(unsigned long *dst, const unsigned long *src,
+		const unsigned long *old, const unsigned long *new, unsigned int nbits);
 bool __bitmap_intersects(const unsigned long *bitmap1,
 			 const unsigned long *bitmap2, unsigned int nbits);
 bool __bitmap_subset(const unsigned long *bitmap1,
@@ -211,8 +213,7 @@ int bitmap_parselist(const char *buf, unsigned long *maskp,
 			int nmaskbits);
 int bitmap_parselist_user(const char __user *ubuf, unsigned int ulen,
 			unsigned long *dst, int nbits);
-void bitmap_remap(unsigned long *dst, const unsigned long *src,
-		const unsigned long *old, const unsigned long *new, unsigned int nbits);
+
 int bitmap_bitremap(int oldbit,
 		const unsigned long *old, const unsigned long *new, int bits);
 void bitmap_onto(unsigned long *dst, const unsigned long *orig,
@@ -671,6 +672,67 @@ static inline int bitmap_find_free_region(unsigned long *bitmap, unsigned int bi
 	return -ENOMEM;
 }
 
+/**
+ * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
+ *	@dst: remapped result
+ *	@src: subset to be remapped
+ *	@old: defines domain of map
+ *	@new: defines range of map
+ *	@nbits: number of bits in each of these bitmaps
+ *
+ * Let @old and @new define a mapping of bit positions, such that
+ * whatever position is held by the n-th set bit in @old is mapped
+ * to the n-th set bit in @new. For example lets say that @old has
+ * bits 2 through 4 set, and @new has bits 3 through 5 set:
+ *
+ *	old: 00011100
+ *	     |||///||
+ *	new: 00111000
+ *
+ * This defines the mapping of bit position 2 to 3, 3 to 4 and 4 to 5,
+ * and of all other bit positions unchanged. So if say @src comes into
+ * this routine with bits 1, 3 and 5 set, then @dst should leave with
+ * bits 1, 4 and 5 set:
+ *
+ *	src: 00101010
+ *	       v v v
+ *	old: 00011100
+ *	     |||///||
+ *	new: 00111000
+ *	       vv  v
+ *	dst: 00110010
+ *
+ * In the more general case, allowing for the possibility that the weight
+ * 'w' of @new is less than the weight of @old, map the position of the
+ * n-th set bit in @old to the position of the m-th set bit in @new, where
+ * m == n % w.
+ *
+ * If either of the @old and @new bitmaps are empty, or if @src and
+ * @dst point to the same location, then this routine copies @src
+ * to @dst.
+ *
+ * The positions of unset bits in @old are mapped to themselves
+ * (the identity map).
+ *
+ * Apply the above specified mapping to @src, placing the result in
+ * @dst, clearing any bits previously set in @dst.
+ */
+static inline void bitmap_remap(unsigned long *dst, const unsigned long *src,
+		const unsigned long *old, const unsigned long *new, unsigned int nbits)
+{
+	if (small_const_nbits(nbits)) {
+		if ((*src & BITMAP_LAST_WORD_MASK(nbits)) == 0 ||
+		    (*old & BITMAP_LAST_WORD_MASK(nbits)) == 0 ||
+		    (*new & BITMAP_LAST_WORD_MASK(nbits)) == 0 ||
+		    ((*new ^ *old) & BITMAP_LAST_WORD_MASK(nbits)) == 0) {
+			*dst = *src & BITMAP_LAST_WORD_MASK(nbits);
+			return;
+		}
+	}
+
+	__bitmap_remap(dst, src, old, new, nbits);
+}
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __LINUX_BITMAP_H */
diff --git a/lib/bitmap.c b/lib/bitmap.c
index 30c375bffe8b..2ac48d9bcbc0 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -992,52 +992,7 @@ static int bitmap_pos_to_ord(const unsigned long *buf, unsigned int pos, unsigne
 	return bitmap_weight(buf, pos);
 }
 
-/**
- * bitmap_remap - Apply map defined by a pair of bitmaps to another bitmap
- *	@dst: remapped result
- *	@src: subset to be remapped
- *	@old: defines domain of map
- *	@new: defines range of map
- *	@nbits: number of bits in each of these bitmaps
- *
- * Let @old and @new define a mapping of bit positions, such that
- * whatever position is held by the n-th set bit in @old is mapped
- * to the n-th set bit in @new. For example lets say that @old has
- * bits 2 through 4 set, and @new has bits 3 through 5 set:
- *
- *	old: 00011100
- *	     |||///||
- *	new: 00111000
- *
- * This defines the mapping of bit position 2 to 3, 3 to 4 and 4 to 5,
- * and of all other bit positions unchanged. So if say @src comes into
- * this routine with bits 1, 3 and 5 set, then @dst should leave with
- * bits 1, 4 and 5 set:
- *
- *	src: 00101010
- *	       v v v
- *	old: 00011100
- *	     |||///||
- *	new: 00111000
- *	       vv  v
- *	dst: 00110010
- *
- * In the more general case, allowing for the possibility that the weight
- * 'w' of @new is less than the weight of @old, map the position of the
- * n-th set bit in @old to the position of the m-th set bit in @new, where
- * m == n % w.
- *
- * If either of the @old and @new bitmaps are empty, or if @src and
- * @dst point to the same location, then this routine copies @src
- * to @dst.
- *
- * The positions of unset bits in @old are mapped to themselves
- * (the identity map).
- *
- * Apply the above specified mapping to @src, placing the result in
- * @dst, clearing any bits previously set in @dst.
- */
-void bitmap_remap(unsigned long *dst, const unsigned long *src,
+void __bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		unsigned int nbits)
 {
@@ -1057,7 +1012,7 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 			set_bit(find_nth_bit(new, nbits, n % w), dst);
 	}
 }
-EXPORT_SYMBOL(bitmap_remap);
+EXPORT_SYMBOL(__bitmap_remap);
 
 /**
  * bitmap_bitremap - Apply map defined by a pair of bitmaps to a single bit
-- 
2.39.2

