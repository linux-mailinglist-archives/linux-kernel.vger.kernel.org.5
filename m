Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEB077D6B6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 01:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240643AbjHOXhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 19:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240621AbjHOXgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 19:36:40 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D1313E
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso4153299b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 16:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692142599; x=1692747399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3AlzGU/to4Xl1KzwzjbqvzpnXCRrEvWt3l9FSMWBlM=;
        b=Y5j3+25u5jV0XpIm0/9JU32Tq++HKy5GE0mQ486AHQDAytaUtGEMxX7V6yjBFsb5w9
         FnL3vqqS7BF0hupHl2Tt4DvE2rt/E01EmVwnjnmT16rmb9naN/qAfB3wj70p0qCveK0P
         f0bHJ+gvbRAIR23Ow+q5hAQU7RkZBnAtSlxCcSnzdwPfiVdUtMIw3sTqA7t2dcLuR2ar
         I5aaXOykvFw3cCEPwVcpsHiGLw0jdX1VoeZdXjRGnfxt5wpirmgEISDbrZbDIH6XWbAk
         yUqVuGpTgGAls+Kd6wmzTA1aJxz5hyh0pN3Lsb5lTmuNzlj8ON8GQtfWDPT7GpGCxSzG
         zxcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692142599; x=1692747399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E3AlzGU/to4Xl1KzwzjbqvzpnXCRrEvWt3l9FSMWBlM=;
        b=Vtm3bVNFPSRULCEBKZwU3lelTEM2/nyasMlSlGbtMblIF6WDnKyibimdHM5Nu11318
         Yenl/KMPdqdwRvrWFjXdQedA7Hj9iOvsbfFkymtrtiIvGyNmwjacfYnNMUUsn/HmeR/d
         OLgxGofMoJeFaTM//XmL008cxhKa9uvaznybnOadXbZ5c6j38bBIRMar1kubUhXdW8CD
         kpogwGVG9LDo+LifOsWhD78Cw/ZUb2GjWwsxQ2+aG0Y8ZPiKCjyRwLHizHf/+Hqjwxw9
         jq5Pkg7jSZ7pobsjorKLWUesXkIkhw8X0RTqPNeoSOaDRE7N9hEwna6jrPyBpfMKBjNT
         rc8w==
X-Gm-Message-State: AOJu0Yy/+nFPzb6E3CEevI94HMu4dvnz2zcnIDTu09VUX/PrsSUN3TEL
        2Ys3xmMrcdSA3QVy0JCR+kpilh7Ew/A=
X-Google-Smtp-Source: AGHT+IEE5u2ZK0cfCsgIWsn8Vz7z1VP+m76K8MG1XeGMDBI+rX5Zl1vqL8JDuf30O2sna5EiFbi9lQ==
X-Received: by 2002:a05:6a00:c92:b0:687:1604:39eb with SMTP id a18-20020a056a000c9200b00687160439ebmr250905pfv.25.1692142598978;
        Tue, 15 Aug 2023 16:36:38 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id i15-20020aa787cf000000b006875df4773fsm771855pfo.163.2023.08.15.16.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Aug 2023 16:36:38 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v3 2/8] bitmap: add test for bitmap_*_region() functions
Date:   Tue, 15 Aug 2023 16:36:22 -0700
Message-Id: <20230815233628.45016-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230815233628.45016-1-yury.norov@gmail.com>
References: <20230815233628.45016-1-yury.norov@gmail.com>
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

Test basic functionality of bitmap_{allocate,release,find_free}_region()
functions.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/test_bitmap.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
index f2ea9f30c7c5..def7d2f9bd14 100644
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
+			expect_eq_uint(pos, BIT(order) < 512 ? BIT(order) : -ENOMEM);
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

