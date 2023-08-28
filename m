Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45BB78B771
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjH1SoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233117AbjH1SoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:04 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 046A8C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:01 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso2491033fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248240; x=1693853040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eh6X7eL440kyl35oBdovKJ2YgsKz4G6HIjTbBBVGh+8=;
        b=TxC9JZBqMYLXPg7C8k6HTi08Al+zDSkxUVeAklo/tyDDRLBnotVGA6HM4f5Mu3a6f9
         BkwEFv97u2PSqW4GQgrJibzrGNvPJWHR98g7hktIFVUyqkISlLkFUGj7IIectzaBcU+d
         5OpAu09Cpw8bJ/BT1FI8ku7y9ZHlusIZbDRDVy1bjg0LA6fnMEIBcdNDFXd+08+iSHUR
         zt4s6+T+5QBCp+hfpf6RD6VDgQdpzoJfTAv7nkhJXVOnUZTEXWGyqtKIrZ52t+zZO3Fx
         5DGRE5xNcimzejV7d3ExuXRbFSiFwt0ZDd4t44wUIkiPWKq8zd6Ky0CWYnUJGzzzLIHO
         eZ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248240; x=1693853040;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eh6X7eL440kyl35oBdovKJ2YgsKz4G6HIjTbBBVGh+8=;
        b=YuzWmMw0B9WKZ++bZeCSOTZDvbKu+nie1AA1+/uD1yC5mdqaaV3f1wyhYinBRh2SvQ
         UjqJo8xfEutx0wZxienN5Gy/q+Ldb9LZ5oNflp65lr8q8BULpwVCzjupUAIuDQisX3hj
         JVQt0OZtbIV5Ywk3i+2ED3tXgHbVVeG9ApHGp/eg8GftZjqrTy0J4dxnS9cyrB3Lp4vx
         qX9v2lJXIK9t3Ar9s1y1YumiNxm2jSWwCi0WmzChlTGfc6kQeUHAqDN+xgWLPpZCZewx
         cNWfT/lvP83tZSYqBV4b1dla32SDCYaj0Xt2YDkeWtKKi8RISv4ij2ifgGmV6aqXkT/N
         E7hQ==
X-Gm-Message-State: AOJu0Yygk1oopUgP5tAxUX3LUOH9tDzjmJ+BDQNcpIFvskMaroUwWxya
        pgSLjpbuGn/1AutuHwJZJt2OmvJ3ulo=
X-Google-Smtp-Source: AGHT+IF+mFPrmiRsSVKId9NVK72PFCqju3DAUAeS439vj9gBkpT2bSVR6obRG5qnomKUPzWBxMA7Gw==
X-Received: by 2002:a05:6870:8a0e:b0:1bb:4bad:ebce with SMTP id p14-20020a0568708a0e00b001bb4badebcemr14484773oaq.27.1693248239897;
        Mon, 28 Aug 2023 11:43:59 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id u38-20020a4a9729000000b0056360466d3esm4308173ooi.48.2023.08.28.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:43:59 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 02/12] bitmap: add bitmap_weight_from()
Date:   Mon, 28 Aug 2023 11:43:42 -0700
Message-Id: <20230828184353.5145-3-yury.norov@gmail.com>
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

Add a _from flavor for bitmap_weight(). It's useful when traversing
bitmaps in a loop to not count bits from the beginning every time.

The test for bitmap_weight{,_from}() is added as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/bitmap.h | 14 ++++++++++++++
 lib/bitmap.c           | 25 +++++++++++++++++++++++++
 lib/test_bitmap.c      | 18 ++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
index 692d0a1dbe92..6acbdd2abd0c 100644
--- a/include/linux/bitmap.h
+++ b/include/linux/bitmap.h
@@ -168,6 +168,8 @@ bool __bitmap_subset(const unsigned long *bitmap1,
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int nbits);
 unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 				 const unsigned long *bitmap2, unsigned int nbits);
+unsigned int __bitmap_weight_from(const unsigned long *bitmap,
+					unsigned int bits, unsigned int start);
 void __bitmap_set(unsigned long *map, unsigned int start, int len);
 void __bitmap_clear(unsigned long *map, unsigned int start, int len);
 
@@ -446,6 +448,18 @@ unsigned long bitmap_weight_and(const unsigned long *src1,
 	return __bitmap_weight_and(src1, src2, nbits);
 }
 
+static __always_inline
+unsigned int bitmap_weight_from(const unsigned long *src, unsigned int nbits, unsigned int start)
+{
+	if (unlikely(start >= nbits))
+		return 0;
+
+	if (small_const_nbits(nbits - start) && nbits / BITS_PER_LONG == start / BITS_PER_LONG)
+		return hweight_long(*src & GENMASK(nbits-1, start));
+
+	return __bitmap_weight_from(src, nbits, start);
+}
+
 static __always_inline void bitmap_set(unsigned long *map, unsigned int start,
 		unsigned int nbits)
 {
diff --git a/lib/bitmap.c b/lib/bitmap.c
index cf77d56cf223..65c64911c92f 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -345,6 +345,24 @@ EXPORT_SYMBOL(__bitmap_subset);
 	w;									\
 })
 
+#define BITMAP_WEIGHT_FROM(FETCH, bits, start)					\
+({										\
+	unsigned long __bits = (bits), val, idx, w = 0, __start = (start), mask;\
+										\
+	mask = BITMAP_FIRST_WORD_MASK(__start);					\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (val = (FETCH) & mask; idx < __bits / BITS_PER_LONG; val = (FETCH))	{\
+		w += hweight_long(val);						\
+		idx++;								\
+	}									\
+										\
+	if (__bits % BITS_PER_LONG)						\
+		w += hweight_long((val) & BITMAP_LAST_WORD_MASK(__bits));	\
+										\
+	w;									\
+})
+
 unsigned int __bitmap_weight(const unsigned long *bitmap, unsigned int bits)
 {
 	return BITMAP_WEIGHT(bitmap[idx], bits);
@@ -358,6 +376,13 @@ unsigned int __bitmap_weight_and(const unsigned long *bitmap1,
 }
 EXPORT_SYMBOL(__bitmap_weight_and);
 
+unsigned int __bitmap_weight_from(const unsigned long *bitmap,
+					unsigned int bits, unsigned int start)
+{
+	return BITMAP_WEIGHT_FROM(bitmap[idx], bits, start);
+}
+EXPORT_SYMBOL(__bitmap_weight_from);
+
 void __bitmap_set(unsigned long *map, unsigned int start, int len)
 {
 	unsigned long *p = map + BIT_WORD(start);
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index 3248ed58a817..a5d823f7589d 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -361,6 +361,23 @@ static void __init test_bitmap_region(void)
 	expect_eq_uint(bitmap_weight(bmap, 1000), 0);
 }
 
+static void __init test_weight(void)
+{
+	DECLARE_BITMAP(bmap, 1024);
+	unsigned int idx, w;
+
+	for (idx = 0; idx < 1024; idx++)
+		__assign_bit(idx, bmap, idx);
+
+	w = bitmap_weight(bmap, 1024);
+	for (idx = 0; idx < 1024; idx++) {
+		unsigned int w1 = bitmap_weight(bmap, idx);
+		unsigned int w2 = bitmap_weight_from(bmap, 1024, idx);
+
+		expect_eq_uint(w1 + w2, w);
+	}
+}
+
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
 static void __init test_replace(void)
@@ -1260,6 +1277,7 @@ static void __init selftest(void)
 	test_copy();
 	test_bitmap_region();
 	test_replace();
+	test_weight();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
 	test_bitmap_parse();
-- 
2.39.2

