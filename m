Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5E227ACE57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjIYCjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjIYCil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:41 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56ECC2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:33 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-59c0d329a8bso65664497b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609513; x=1696214313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USSwqheS6xjeGLXrIzVAWyRVvgy5mA+TT5DY1kqnK10=;
        b=OoEMze3KpYE6JRaLsxCH2NT8kHMDu2O7ghGLEYlgZF7BkkAapwkg13kvJNwpw6q7YW
         TKhLsBcppyjvKvwHPwuAaOACkcfS+1rRw07FuawZlRIO+uF9BCFk/fLuzfWyf7ErrSHf
         3RxZiyEbKgo5EC3JPT9ZwT544IX8SDaCcBvDs2X3lxdRgswIWtPzuCu3/zbEoZo/Mk32
         j+Dzkg/CYyhMZVRPTvrnwAwToUH/dmA0Y3dZT1pMe2GPVGtbKYeqSfIsV1pSvKQzUEEX
         P0E8JzlgyRQGqvL4H5QuXJk7mhnjHJegUDUT1RBPXl15nBR+ouemKUQEqAk7E4VGKskF
         5vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609513; x=1696214313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USSwqheS6xjeGLXrIzVAWyRVvgy5mA+TT5DY1kqnK10=;
        b=lcWqDCmaL59A+Q4iZKQd6Rp1kzgbMJda3rlGkpyVsMTJAkVAsrtu8Fg4dWYg4Ku6jE
         ch3+pJ/zOhYgRyV8CU90TZ0CxSUPiV8oFqY38hidfiQfw/8eKvW+IiloIv3h6HGA6W3s
         oCwD2s1rTwsbPvsvVL265FHnXFZxvhcQHRKCiVfKzk32vEXdahvvlZG0mNSw22bEcSD/
         P2JFI+nacn6K4ROb3gjsdL9NkCK06Rsu+PMSLtJvYgVA60YIIX/1hOtefUn08tmef7mT
         YXt5LmiOJmt+GlnhoPSTBuwP8ui18cAcUIXt1kN8bmUVzHgEB6SxAWyJT0XnVfF3qa1+
         muig==
X-Gm-Message-State: AOJu0YwVPEBPyYSqo1ztVKgALG1TSG33D3JnU3wBMivByUlMAJH9FV4I
        BMVbVMIS4RBzt3ztLKTf4L3ePI16T1k=
X-Google-Smtp-Source: AGHT+IGoUFXhlCGy2AGMzphXLvIo8Wswri6KOjhVXNBCobsN1nQ7IxIsPyXt4KQxyGfFufKxJPnpIQ==
X-Received: by 2002:a81:7b44:0:b0:570:7b4d:f694 with SMTP id w65-20020a817b44000000b005707b4df694mr5081345ywc.3.1695609512710;
        Sun, 24 Sep 2023 19:38:32 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id k128-20020a816f86000000b00583803487ccsm2177190ywc.122.2023.09.24.19.38.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:32 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 7/8] bitmap: drop _reg_op() function
Date:   Sun, 24 Sep 2023 19:38:16 -0700
Message-Id: <20230925023817.782509-8-yury.norov@gmail.com>
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

Now that all _reg_op() users are switched to alternative functions,
_reg_op() machinery is not needed anymore.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 76 ----------------------------------------------------
 1 file changed, 76 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9345a6ffe39d..cc6180dd6254 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1220,82 +1220,6 @@ void bitmap_fold(unsigned long *dst, const unsigned long *orig,
 }
 #endif /* CONFIG_NUMA */
 
-/*
- * Common code for bitmap_*_region() routines.
- *	bitmap: array of unsigned longs corresponding to the bitmap
- *	pos: the beginning of the region
- *	order: region size (log base 2 of number of bits)
- *	reg_op: operation(s) to perform on that region of bitmap
- *
- * Can set, verify and/or release a region of bits in a bitmap,
- * depending on which combination of REG_OP_* flag bits is set.
- *
- * A region of a bitmap is a sequence of bits in the bitmap, of
- * some size '1 << order' (a power of two), aligned to that same
- * '1 << order' power of two.
- *
- * Return: 1 if REG_OP_ISFREE succeeds (region is all zero bits).
- *	   0 in all other cases and reg_ops.
- */
-
-enum {
-	REG_OP_ISFREE,		/* true if region is all zero bits */
-	REG_OP_ALLOC,		/* set all bits in region */
-	REG_OP_RELEASE,		/* clear all bits in region */
-};
-
-static int __reg_op(unsigned long *bitmap, unsigned int pos, int order, int reg_op)
-{
-	int nbits_reg;		/* number of bits in region */
-	int index;		/* index first long of region in bitmap */
-	int offset;		/* bit offset region in bitmap[index] */
-	int nlongs_reg;		/* num longs spanned by region in bitmap */
-	int nbitsinlong;	/* num bits of region in each spanned long */
-	unsigned long mask;	/* bitmask for one long of region */
-	int i;			/* scans bitmap by longs */
-	int ret = 0;		/* return value */
-
-	/*
-	 * Either nlongs_reg == 1 (for small orders that fit in one long)
-	 * or (offset == 0 && mask == ~0UL) (for larger multiword orders.)
-	 */
-	nbits_reg = 1 << order;
-	index = pos / BITS_PER_LONG;
-	offset = pos - (index * BITS_PER_LONG);
-	nlongs_reg = BITS_TO_LONGS(nbits_reg);
-	nbitsinlong = min(nbits_reg,  BITS_PER_LONG);
-
-	/*
-	 * Can't do "mask = (1UL << nbitsinlong) - 1", as that
-	 * overflows if nbitsinlong == BITS_PER_LONG.
-	 */
-	mask = (1UL << (nbitsinlong - 1));
-	mask += mask - 1;
-	mask <<= offset;
-
-	switch (reg_op) {
-	case REG_OP_ISFREE:
-		for (i = 0; i < nlongs_reg; i++) {
-			if (bitmap[index + i] & mask)
-				goto done;
-		}
-		ret = 1;	/* all bits in region free (zero) */
-		break;
-
-	case REG_OP_ALLOC:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] |= mask;
-		break;
-
-	case REG_OP_RELEASE:
-		for (i = 0; i < nlongs_reg; i++)
-			bitmap[index + i] &= ~mask;
-		break;
-	}
-done:
-	return ret;
-}
-
 /**
  * bitmap_find_free_region - find a contiguous aligned mem region
  *	@bitmap: array of unsigned longs corresponding to the bitmap
-- 
2.39.2

