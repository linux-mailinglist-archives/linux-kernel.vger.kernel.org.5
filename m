Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587A27784AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 02:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbjHKA5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 20:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjHKA5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 20:57:44 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D212703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:43 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-63cf9eddbc6so12931216d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 17:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691715462; x=1692320262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WF+XFRQyY75Yiz3rWJXa/ttxqCG+kgb/5I5lH/7+He4=;
        b=B7jg4vPE2H2M9zZ9Xn/iaedB22iWvFD+1UdWlOTO7HU7624YurMUZOEIDhyOIx8lvW
         W94BXo6CoxLgmgBJKdNpZ+zmv5kHjQyVrq+GZKKtb4NBWk/GUGI9qZlifhPLGTHVO6iy
         5oE7Cb+/dCwFw8y0qDP72iCO3M07Uazon+1D0zPj+MGSfqi5JUpAO2vb0EF++RLgSR/W
         pBxoQ/xSzUpwUFEHzDNVIGs7Fy5Zg83b5VXxHDoWR4iKJ2yL/iq3gv4SS3zGTT884IKr
         i7zojZoQziKSPPeHmsusPkEA/12RLm7VnTA0TzfKvuhCSTj+9JK4g/w7oA9N5PeQ/mFl
         Rf8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691715462; x=1692320262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WF+XFRQyY75Yiz3rWJXa/ttxqCG+kgb/5I5lH/7+He4=;
        b=JhyGl51SMGySU8mD6y81PfSSuWgsNHg+jHxGMG2nOi9oDMHuMzbrDC1Ix7UEb+7EEa
         R1a6XCbMM50osJtbk3wCVHtOAb2km9gGyhX+awF2wWjbLmriL+dRSbyb0L2mni0Jh1qc
         p1EQdHndTwAptw3qGajan22JoNtca1RoXRcfh1wxrnQkaYgYQzO+T5+OOOaafqKz6LOw
         zc9kviOwUnwY8EKFfNVoEq2e8TBFDTBPE4yrchS1YlaCMymu/frfq7LnzK9vUSc/Es6m
         rUmP9m+My4MtkD6FAA11gYtW+oNarsklS/rm9WdFvC3FX5VbIroHv+vcfWx8iHlhawfL
         eCiA==
X-Gm-Message-State: AOJu0YzMOUTQfGxmfRqHhOM6ATY7UMo0jRLbbAeG6wdfmbImboa8yBIU
        iaqWSsniPyNyBUc9IHPHeBZLHVoZVX4=
X-Google-Smtp-Source: AGHT+IGhoZUkLM2ou/d8yUY5XYzBc5t9reTlUqfzOByzEj/0P3IkKECXTCblRo295hVSkZKGZfCwQw==
X-Received: by 2002:a0c:de06:0:b0:636:1275:8419 with SMTP id t6-20020a0cde06000000b0063612758419mr605433qvk.13.1691715462552;
        Thu, 10 Aug 2023 17:57:42 -0700 (PDT)
Received: from localhost (2603-7080-3d03-3cb9-317d-7087-0f3e-bab3.res6.spectrum.com. [2603:7080:3d03:3cb9:317d:7087:f3e:bab3])
        by smtp.gmail.com with ESMTPSA id l17-20020a0ce091000000b0061b5dbf1994sm839479qvk.146.2023.08.10.17.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 17:57:42 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2 1/6] bitmap: fix opencoded bitmap_allocate_region()
Date:   Thu, 10 Aug 2023 17:57:27 -0700
Message-Id: <20230811005732.107718-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230811005732.107718-1-yury.norov@gmail.com>
References: <20230811005732.107718-1-yury.norov@gmail.com>
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

bitmap_find_region() opencodes bitmap_allocate_region(). Fix it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index ddb31015e38a..3a589016f5e0 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1315,10 +1315,8 @@ int bitmap_find_free_region(unsigned long *bitmap, unsigned int bits, int order)
 	unsigned int pos, end;		/* scans bitmap by regions of size order */
 
 	for (pos = 0 ; (end = pos + (1U << order)) <= bits; pos = end) {
-		if (!__reg_op(bitmap, pos, order, REG_OP_ISFREE))
-			continue;
-		__reg_op(bitmap, pos, order, REG_OP_ALLOC);
-		return pos;
+		if (!bitmap_allocate_region(bitmap, pos, order))
+			return pos;
 	}
 	return -ENOMEM;
 }
-- 
2.39.2

