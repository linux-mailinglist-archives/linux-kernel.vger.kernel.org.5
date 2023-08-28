Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 830D378B773
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjH1So0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjH1SoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:06 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C3B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:03 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-3a7d7de894bso2664204b6e.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248242; x=1693853042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TB/j/ZWZca45fLEWddb9WmisfBlH+TD3Akz3eSDVAc=;
        b=c5KDgZwo4D/k/8kWu/dUfuohPTeeEn+GWExeUTP+FhFsEmj/sXDfarBzv/z5PYfo+9
         G57V3LO8rsOSe10NHJTi96c4vXM8zVdkVYyaE8eLHT19yZ2huNHIenEfM5TiPlQetfCG
         ucYwxWWMyTGDtJFkw5H1QOUF1E/161b0h8OADTklEUIEJcuwfTGPmVWZB3SKrfG9K35o
         IqPYlXhvohGNs2FOHZ3uPoZPFyS/rov1EtBAbBnUUXGdBGREYJvs9t45AQCK4IR1tb5n
         7ZOX+w9Xhm1qNwiw58vPPpuWa1NbbSE/kfbr4qfZ/DD2B1epmUmAPlVsNwE5oARHV/4S
         HMvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248242; x=1693853042;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TB/j/ZWZca45fLEWddb9WmisfBlH+TD3Akz3eSDVAc=;
        b=POMKEIANM1mpzBwh+3q72k0Kj3OzHqElHJbCEJ4jTFROB12aw/oUEvdDqJuUrJz24S
         vrfOhGq3ZHCQ3HVkA5p+FT1CaDMZG32U16yhBM7kWkojlA9XLYy1K2PDMvbSuTD0mHZ/
         r6CGxT7nfewqS5XYXlF55TSO2aZX0cATlDlwACZE3vwO/sjQZvBvQpE1w1aPjCeg22nZ
         Z5ic7Voa/qFaYQHlysNkT2DfPLVxuX1Lwu2Wxk8aK4VnPhsbsiXoW8fK1rEhzxvNXR4g
         cWdb9L70bDPKrEbNxAH/3DsUg/r9UA2xDSSTpzp/BXIiidSupt2kAoADmO4z8M0V2VB1
         WnUQ==
X-Gm-Message-State: AOJu0Yxh5qNfMEOnv5HrtxqnJYxGTuUetAOXWpzfLvaUhHQa7OUyFgAh
        Pz0mlDPjhKyv6JzdmqHdII3NN3X0Nhk=
X-Google-Smtp-Source: AGHT+IFWjZUZX9Q+MuK4PQbP3XZTwypZYKopJUOgpLV3UJyGCOYwnwVovIenTHTJWKfWQ4BnACz3oQ==
X-Received: by 2002:a05:6808:2a7a:b0:3a1:eccc:26da with SMTP id fu26-20020a0568082a7a00b003a1eccc26damr10737881oib.25.1693248242660;
        Mon, 28 Aug 2023 11:44:02 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id k24-20020a544698000000b003a9a2362f66sm2178194oic.16.2023.08.28.11.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:02 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 04/12] bitmap: add test for bitmap_bitremap()
Date:   Mon, 28 Aug 2023 11:43:44 -0700
Message-Id: <20230828184353.5145-5-yury.norov@gmail.com>
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

Similarly to bitmap_remap, test bitmap_bitremap().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index e1c22d399f24..e9211f9a0e67 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -378,6 +378,19 @@ static void __init test_weight(void)
 	}
 }
 
+static __always_inline void __init __test_bitremap(unsigned long *dst, unsigned long *src,
+				unsigned long *old, unsigned long *new, unsigned long nbits)
+{
+	unsigned long oldbit, newbit;
+
+	bitmap_zero(dst, nbits);
+
+	for_each_set_bit(oldbit, src, nbits) {
+		newbit = bitmap_bitremap(oldbit, old, new, nbits);
+		__set_bit(newbit, dst);
+	}
+}
+
 static void __init test_remap(void)
 {
 	DECLARE_BITMAP(dst, 8);
@@ -402,6 +415,9 @@ static void __init test_remap(void)
 	bitmap_remap(dst, src, old, new, 8);
 	expect_eq_bitmap(exp0, dst, 8);
 
+	__test_bitremap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp0, dst, 8);
+
 	/*
 	 * When old mapping is the same as new, source bits are copied to dst.
 	 * Real code must use bitmap_copy() if it's known in advance.
@@ -409,6 +425,9 @@ static void __init test_remap(void)
 	bitmap_remap(dst, src, old, old, 8);
 	expect_eq_bitmap(src, dst, 8);
 
+	__test_bitremap(dst, src, old, old, 8);
+	expect_eq_bitmap(src, dst, 8);
+
 	bitmap_remap(dst, src, new, new, 8);
 	expect_eq_bitmap(src, dst, 8);
 
@@ -419,23 +438,38 @@ static void __init test_remap(void)
 	bitmap_remap(dst, src, empty, new, 8);
 	expect_eq_bitmap(src, dst, 8);
 
+	__test_bitremap(dst, src, empty, new, 8);
+	expect_eq_bitmap(src, dst, 8);
+
 	bitmap_remap(dst, src, old, empty, 8);
 	expect_eq_bitmap(src, dst, 8);
 
+	__test_bitremap(dst, src, old, empty, 8);
+	expect_eq_bitmap(src, dst, 8);
+
 	bitmap_remap(dst, src, empty, empty, 8);
 	expect_eq_bitmap(src, dst, 8);
 
+	__test_bitremap(dst, src, empty, empty, 8);
+	expect_eq_bitmap(src, dst, 8);
+
 	/* Set extra bit in old map to test carry logic */
 	set_bit(5, old);
 	bitmap_remap(dst, src, old, new, 8);
 	expect_eq_bitmap(exp1, dst, 8);
 
+	__test_bitremap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp1, dst, 8);
+
 	/* Map old bits to #7 */
 	bitmap_zero(new, 8);
 	set_bit(7, new);
 	bitmap_remap(dst, src, old, new, 8);
 	expect_eq_bitmap(exp2, dst, 8);
 
+	__test_bitremap(dst, src, old, new, 8);
+	expect_eq_bitmap(exp2, dst, 8);
+
 	bitmap_fill(perf_src, 1000);
 	bitmap_set(perf_old, 0, 500);
 	bitmap_clear(perf_old, 500, 500);
-- 
2.39.2

