Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7122C7ACE59
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 04:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjIYCie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 22:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbjIYCib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 22:38:31 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935CDE3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:25 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-59c215f2f4aso68791287b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 19:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695609504; x=1696214304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE9w3X9nRbA61NQ0LUWkuYmpD2CnPoV900gbsiWlryQ=;
        b=Q/jhw3F3ytD9Zjj1S9Xy66DAPkOQNemYrKgTjpIsd0C+oM4663njBNQUMEMrWl6mvu
         KsxLyK1K076wUcaPb1/X84Mnf5IZasRrBnefnhuyPRwVzQNnoaDclEsWG5pr8geLqH1L
         DjCd0OT4ImJhR4mbNjrc4DOlZSAH+SVBrJNULS1w1hgBtZ4rROpQPxpHcF07eXmpzw5W
         zqcx9u5lgwaCkyt44ahYjaBr/8P8BjhjvWwCoGXyIkA+ss7KRCPu5U5AaV8xBFKsUYRP
         Y2j9ebOpqI8NeAR8CRT+6dcG183nowBMTCVUoumlq3IpM59K7biPK+ywk8Eq3I81njFP
         RRtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695609504; x=1696214304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XE9w3X9nRbA61NQ0LUWkuYmpD2CnPoV900gbsiWlryQ=;
        b=ocSWcLripMy6or0eaRSRvlX5sP+YgktXh9nUt/wVjShvL5+Zb7MPBaq2naVrWb5NEb
         9XubNAL0YIyBtAL6MZ2hHPz/dzJHeq+qMPiexxQw4F8QA47lZmaZ1FsBt8FrlcIDesNz
         Eoh/jp89C4QwuX4PMHkVc6yoow3HDra9FHB9Gn3gvoccDPRD1V+3+pEAz7U8zHkvVNrX
         VKOQ+nn3UWOTgqe3gXjWtueaoy3qMCDQ7IrTKKy291dOtbxpbc8btOtzFUsSvnW4EKKP
         gRNCVd3T/8avWOgpR5TiGM1SwCr/iGMmcoJAesZY02uo5HO+gkuEYUgpnk7Q1PF1xnw/
         hAsw==
X-Gm-Message-State: AOJu0YzQj8qZbfVKyCGW5XP70bfM5m2PmGFlAQxm1IRNjL+syXWaL9eI
        NNqLplS8dkx/bDtgtMB4Yy3zZ+qeq5k=
X-Google-Smtp-Source: AGHT+IGzF4Q7w98WjuHf0tgASXy0SRNIfARuuIlexi27LF7C4ROdp4ixnd+y6KocnavMVTVdXvGfoQ==
X-Received: by 2002:a0d:c781:0:b0:59c:aea:d877 with SMTP id j123-20020a0dc781000000b0059c0aead877mr4251199ywd.40.1695609504328;
        Sun, 24 Sep 2023 19:38:24 -0700 (PDT)
Received: from localhost ([2607:fb90:3eac:cd78:b6b5:ba0f:9e64:f2e1])
        by smtp.gmail.com with ESMTPSA id c188-20020a0df3c5000000b0059293c8d70csm2182806ywf.132.2023.09.24.19.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Sep 2023 19:38:24 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v5 2/8] bitmap: add test for bitmap_*_region() functions
Date:   Sun, 24 Sep 2023 19:38:11 -0700
Message-Id: <20230925023817.782509-3-yury.norov@gmail.com>
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

Test basic functionality of bitmap_{allocate,release,find_free}_region()
functions.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5..65f22c2578b0 100644
--- a/lib/test_bitmap.c
+++ b/lib/test_bitmap.c
@@ -330,6 +330,29 @@ static void __init test_copy(void)
 	expect_eq_pbl("0-108,128-1023", bmap2, 1024);
 }
 
+static void __init test_bitmap_region(void)
+{
+	int pos, order;
+
+	DECLARE_BITMAP(bmap, 1000);
+
+	bitmap_zero(bmap, 1000);
+
+	for (order = 0; order < 10; order++) {
+		pos = bitmap_find_free_region(bmap, 1000, order);
+		if (order == 0)
+			expect_eq_uint(pos, 0);
+		else
+			expect_eq_uint(pos, order < 9 ? BIT(order) : -ENOMEM);
+	}
+
+	bitmap_release_region(bmap, 0, 0);
+	for (order = 1; order < 9; order++)
+		bitmap_release_region(bmap, BIT(order), order);
+
+	expect_eq_uint(bitmap_weight(bmap, 1000), 0);
+}
+
 #define EXP2_IN_BITS	(sizeof(exp2) * 8)
 
 static void __init test_replace(void)
@@ -1227,6 +1250,7 @@ static void __init selftest(void)
 	test_zero_clear();
 	test_fill_set();
 	test_copy();
+	test_bitmap_region();
 	test_replace();
 	test_bitmap_arr32();
 	test_bitmap_arr64();
-- 
2.39.2

