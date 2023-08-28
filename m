Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8794378B770
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbjH1SoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjH1SoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:03 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2EBF
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:59 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-5736caaf151so1284664eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248238; x=1693853038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VTMG7+AqXiKDuJXJ9Y6Nzjcn2Rotqo5yC7DsVnC84Pw=;
        b=K7TRNBXugj8bd+nVVa05uAP6lyYbcOCbOCDwwpOo6trQAi9m9VmGJwVJg3PCDEKjMP
         GxWkWDpS+gYVApv5whYR/pDhKNFS/xXX9MWccmOx47WGdtL58R/jElG0sjmlU15DbHk6
         cvAEkyGXndhdo8EVXhI1oWCmbZL4QDVVAlFJI951wcWKnGNBuM8oVQjFS+T5DVBQafKG
         cD+onDTRJbQ3TS+wptAGMFhf/S0XAKKjA0+fI6cthyGdNRi8yITYjwoWt2PhfWBmmP2m
         kFAkDWv5aCp6jI/XD7PBC9r6tRsTKT4Xd0eXzzVIw2eKhLJetuQDBoE2Aq4lET/ZDIuV
         QrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248238; x=1693853038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VTMG7+AqXiKDuJXJ9Y6Nzjcn2Rotqo5yC7DsVnC84Pw=;
        b=alAZLSMdSbZ+w4LtNRj4VBMyhlZ8kuwaRFpA+85wo6FMFAik7q/0hyfVhx89lnAw9I
         RGZ5YyA0A6MxREECoA6ki5kUNyyIeyi0ofiwmb9kft8l7bL+ngUX/GVVbhc31QOxxMjd
         tYCyaFrYGuZ9pHeWvYjaSNnmeH3jRF9hq70CDHXLiw+AXLcLvvVV4NC6wzL6osHTVS6O
         QSyLUXFAF2+qr8RJ2S0kLMbyFhc9souAQefDo8pnxRvEAaA0fUIK535zbBWj1U38pDD5
         emop+NYkbRfeWkisSpmBaK4i5iRr08y6tk5Hx14fBDWrFNAKHsrlXxeuKsLNeLoC4LaA
         UQlw==
X-Gm-Message-State: AOJu0YwVnzKtK1K8edGqdItRMvVgnhCKpGVDwyoLiEwbVN1qB2EXBGE/
        owFwOfV9h3IoiFGGcpCtgviU8pSC9pg=
X-Google-Smtp-Source: AGHT+IGg+iwbv+Z/nIsQrPx/VWfe901Sv85pYwfmveXlI3XHkb8e2dObNIisqfgSNzQwoRNOpMXUHg==
X-Received: by 2002:a4a:275d:0:b0:571:aceb:26c8 with SMTP id w29-20020a4a275d000000b00571aceb26c8mr11702441oow.3.1693248238157;
        Mon, 28 Aug 2023 11:43:58 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id l11-20020a4ad9cb000000b00565fbd0d4c0sm3928739oou.28.2023.08.28.11.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:43:57 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 01/12] bitmap: add find_nth_bit_from()
Date:   Mon, 28 Aug 2023 11:43:41 -0700
Message-Id: <20230828184353.5145-2-yury.norov@gmail.com>
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

Similarly to find_next_bit(), add a _from flavor for find_nth_bit(). It's
useful when traversing bitmaps in a loop because it allows to not count
bits from the beginning every time.

The test is added as well.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/find.h | 37 +++++++++++++++++++++++++++++++++++++
 lib/find_bit.c       | 29 +++++++++++++++++++++++++++++
 lib/test_bitmap.c    | 10 +++++++++-
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/linux/find.h b/include/linux/find.h
index 5e4f39ef2e72..f7fb88405201 100644
--- a/include/linux/find.h
+++ b/include/linux/find.h
@@ -27,6 +27,8 @@ unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned l
 unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
 					const unsigned long *addr3, unsigned long size,
 					unsigned long n);
+unsigned long __find_nth_bit_from(const unsigned long *addr, unsigned long size,
+					unsigned long start, unsigned long nth);
 extern unsigned long _find_first_and_bit(const unsigned long *addr1,
 					 const unsigned long *addr2, unsigned long size);
 extern unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size);
@@ -237,6 +239,41 @@ unsigned long find_nth_bit(const unsigned long *addr, unsigned long size, unsign
 	return __find_nth_bit(addr, size, n);
 }
 
+/**
+ * find_nth_bit_from - find N'th set bit in a memory region starting at @off
+ * @addr: The address to start the search at
+ * @size: The maximum number of bits to search
+ * @off: The offset to start search
+ * @n: The number of set bit, which position is needed, counting from 0
+ *
+ * The following is semantically equivalent:
+ *	 idx = find_nth_bit_from(addr, size, off, 0);
+ *	 idx = find_next_bit(addr, size, off);
+ *
+ * Return: the bit number of the N'th set bit.
+ * If no such, returns @size.
+ */
+static __always_inline
+unsigned long find_nth_bit_from(const unsigned long *addr, unsigned long size,
+				unsigned long start, unsigned long n)
+{
+	if (n >= size - start)
+		return size;
+
+	if (small_const_nbits(size - start) && size / BITS_PER_LONG == start / BITS_PER_LONG) {
+		unsigned long val, idx = start / BITS_PER_LONG;
+
+		val =  addr[idx] & GENMASK(size - 1, start);
+		if (val == 0)
+			return size;
+
+		val = idx * BITS_PER_LONG + fns(val, n);
+		return val < size ? val : size;
+	}
+
+	return __find_nth_bit_from(addr, size, start, n);
+}
+
 /**
  * find_nth_and_bit - find N'th set bit in 2 memory regions
  * @addr1: The 1st address to start the search at
diff --git a/lib/find_bit.c b/lib/find_bit.c
index 32f99e9a670e..49959b51df8c 100644
--- a/lib/find_bit.c
+++ b/lib/find_bit.c
@@ -164,6 +164,35 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
 }
 EXPORT_SYMBOL(__find_nth_and_andnot_bit);
 
+#define FIND_NTH_BIT_FROM(FETCH, size, start, nth)				\
+({										\
+	unsigned long mask, idx, tmp, w, sz = (size), __start = (start), n = (nth);\
+										\
+	if (unlikely(__start >= sz || n > sz - __start))			\
+		goto out;							\
+										\
+	mask = BITMAP_FIRST_WORD_MASK(__start);					\
+	idx = __start / BITS_PER_LONG;						\
+										\
+	for (tmp = (FETCH) & mask; (w = hweight_long(tmp)) <= n; tmp = (FETCH)) {\
+		if ((idx + 1) * BITS_PER_LONG >= sz)				\
+			goto out;						\
+		idx++;								\
+		n -= w;								\
+	}									\
+										\
+	sz = min(idx * BITS_PER_LONG + fns(tmp, n), sz);			\
+out:										\
+	sz;									\
+})
+
+unsigned long __find_nth_bit_from(const unsigned long *addr, unsigned long size,
+					unsigned long start, unsigned long nth)
+{
+	return FIND_NTH_BIT_FROM(addr[idx], size, start, nth);
+}
+EXPORT_SYMBOL(__find_nth_bit_from);
+
 #ifndef find_next_and_bit
 unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
 					unsigned long nbits, unsigned long start)
diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index def7d2f9bd14..3248ed58a817 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -223,7 +223,7 @@ static void __init test_zero_clear(void)
 
 static void __init test_find_nth_bit(void)
 {
-	unsigned long b, bit, cnt = 0;
+	unsigned long i, b, bit, cnt = 0;
 	DECLARE_BITMAP(bmap, 64 * 3);
 
 	bitmap_zero(bmap, 64 * 3);
@@ -260,6 +260,14 @@ static void __init test_find_nth_bit(void)
 		b = find_nth_bit(exp1, EXP1_IN_BITS, cnt++);
 		expect_eq_uint(b, bit);
 	}
+
+	for (i = 0; i < EXP1_IN_BITS; i++) {
+		bit = i; cnt = 0;
+		for_each_set_bit_from(bit, exp1, EXP1_IN_BITS) {
+			b = find_nth_bit_from(exp1, EXP1_IN_BITS, i, cnt++);
+			expect_eq_uint(b, bit);
+		}
+	}
 }
 
 static void __init test_fill_set(void)
-- 
2.39.2

