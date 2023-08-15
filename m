Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C4677D6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 02:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240637AbjHOX7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbjHOX7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:59:41 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E271E74
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:59:40 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso7818025ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692143979; x=1692748779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s7QZhIQhqfURcDNGbTpEX292MPIPS8rTDA+vu0krQus=;
        b=db2eOjTwlfITl50lWezRcdIpSLh84vwQQgQd750THy3liQ4SiKMChAfNpVedcXikRX
         X3zwDLdgns/fouYuEuqhbrC7A/G1dy/7btzlrPBlS1m0JFhUZ2FlGNLgnZeQhs3GcbLN
         iH9XMRWLoOUmNB9RS1+wfP/ri2YgWlrdruo4tfieyWVNZY3/i4RM4JYw4KjfDFvCHo2a
         giuqmz+6Q8wzR2IjW01L+4b6j6s8ACGSyj2+IaTaQy7q1ZSl7BSy3vCsOx7GWMX1dd5h
         8sSwddTf/tGlbOLBE48nWxfaJ87p5BXXgDZge47ttBvP4dWHyckrwcmCTLFeUDBb6IS9
         8fdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692143979; x=1692748779;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s7QZhIQhqfURcDNGbTpEX292MPIPS8rTDA+vu0krQus=;
        b=SDM+xmEOuE5T5g8nN/M1hS6QpBw/EbqfMLy9za5bslxIGWBv7Nci8pYudfOo3FHbOH
         ZQtIOvXUa6ii49DHB51I1rZinAQrdQJUrda9DAphhmtaSyZvq7XTHrAz/Av8Xywg3Lqd
         6Nf5WlvJp81iv0bA2uOQQqZezLZo441waHzWYgbZDQ12qb89cdhRiefeTB+ZlO57s2M7
         5fp85sU7QvpRx1laaK06/qHz3tK6HKyRUtr6hmKcFol/FmxjIogP+DogCDvGNxQBAGxX
         a8w7GXIvisr92wCyxO97mFmTZger1ju8zZ6iEkNdT5q1vOzbW9/tLJl4RbOIii9qPaBQ
         pOzw==
X-Gm-Message-State: AOJu0YzS9W8VP03WSBvJehGMejYXtDfX12d7pfLduB7P//d+0sRG6r3t
        hmSiH84Bhk/Z/qAMZPT2IBKOr0w358g=
X-Google-Smtp-Source: AGHT+IFSqkhxeuCDdUM+8BNJp+P/b9ulNK3USHDy1k/GQGfVHUT180/M6k5NU3rzXyzb8Z9ZIqQVYA==
X-Received: by 2002:a17:903:2444:b0:1bb:a7bc:37a4 with SMTP id l4-20020a170903244400b001bba7bc37a4mr481076pls.24.1692143979044;
        Tue, 15 Aug 2023 16:59:39 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id j7-20020a170902758700b001b9e9edbf43sm11683856pll.171.2023.08.15.16.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:59:38 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH] bitmap: optimize bitmap_remap()
Date:   Tue, 15 Aug 2023 16:59:34 -0700
Message-Id: <20230815235934.47782-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
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

When 'new' map is empty, i.e. identity mapping, we can simply copy
src to dst, which is significantly faster than setting bits one by
one in a for-loop.

While here, replace set_bit() with non-atomic __set_bit().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 24284caadbcc..bf6b0eea1af8 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1004,20 +1004,24 @@ void bitmap_remap(unsigned long *dst, const unsigned long *src,
 		const unsigned long *old, const unsigned long *new,
 		unsigned int nbits)
 {
-	unsigned int oldbit, w;
+	unsigned int bit, oldbit, w;
 
 	if (dst == src)		/* following doesn't handle inplace remaps */
 		return;
-	bitmap_zero(dst, nbits);
 
 	w = bitmap_weight(new, nbits);
+	if (w == 0) {
+		bitmap_copy(dst, src, nbits);
+		return;
+	}
+
+	bitmap_zero(dst, nbits);
 	for_each_set_bit(oldbit, src, nbits) {
 		int n = bitmap_pos_to_ord(old, oldbit, nbits);
 
-		if (n < 0 || w == 0)
-			set_bit(oldbit, dst);	/* identity map */
-		else
-			set_bit(find_nth_bit(new, nbits, n % w), dst);
+		bit = (n < 0) ? oldbit :	/* identity map */
+				find_nth_bit(new, nbits, n % w);
+		__set_bit(bit, dst);
 	}
 }
 EXPORT_SYMBOL(bitmap_remap);
-- 
2.39.2

