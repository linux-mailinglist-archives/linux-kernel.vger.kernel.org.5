Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0607AF0ED
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbjIZQkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjIZQkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:40:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B62193
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4eFMXkTSJCSP/LuqcR7rWb5lOePf6Wh6Ne6wvaIuhIA=;
        b=P+ZAMRc8CIz9Q844RmioNuKPEncTqojKhzez+aiCV6dOwJSwDn2dEUzzKJtppGaUoaubsn
        AwmOikOgd9q96oLgyjkyrwMUnYZogMLUp8cA0HiYc7IQPw3u0yzm2S78D/tqjZXCQlXFrX
        v2ofllA0SCQbweQ/y1wio+6N3SFZCec=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-3Oa9ITgwNcG9VWGOncgRRw-1; Tue, 26 Sep 2023 12:39:42 -0400
X-MC-Unique: 3Oa9ITgwNcG9VWGOncgRRw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32337a3929aso1415866f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746381; x=1696351181;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4eFMXkTSJCSP/LuqcR7rWb5lOePf6Wh6Ne6wvaIuhIA=;
        b=qxOrNydS5dE4TSfjs7q574r319udZu4Mdn3wMQBEi3e6xqwjo+0UcrF+F3xUJOWKPP
         rHIZqH/DIDlAWXWSkfY4GHB78SzjpRDzYzW3dKy8mZptkpc4xbJlhbmAh9+5fJgfFGX7
         ymc3SU517n8yZC2/iYRSTAWIM+DjhCR60HK0gQkaGY9+mLE5KpD6z84T9qv9z/fBnN0j
         0kwSBOajye27G+ZranpWxR1zk5EFESSuJD4hDTq+TZnH3GN73v0wQPJqgfmFIS0z8TAd
         W6fmXl5z6j/uvbxnOH9M5T1/Y5tPa7bB3iNXXRwA/HCm/inLJq53umoCcz6/6aahwCUB
         L8+Q==
X-Gm-Message-State: AOJu0Yyy6+Pko/Ht3A2LXqwK2NxwUMOclK1y50wwJNVfvJLNwLxzFlgo
        gyOBfMjRYtnJOOnCXY5dGok0tL+RVqVkdc9fxmW/Mg5tRRhT2pDmRLlD2FuNx6cBw4/24lPCK53
        T4mUtgoTyWvjo9eP2gLHMj80=
X-Received: by 2002:a5d:56c9:0:b0:31f:fe07:fdde with SMTP id m9-20020a5d56c9000000b0031ffe07fddemr9729678wrw.12.1695746380835;
        Tue, 26 Sep 2023 09:39:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUzG68zTc6qAMQk8wPrXZnR6Yg9EbQypSNQDKJk51ynUeeBSq0ziuucyRh1aV70ovihFHzwA==
X-Received: by 2002:a5d:56c9:0:b0:31f:fe07:fdde with SMTP id m9-20020a5d56c9000000b0031ffe07fddemr9729663wrw.12.1695746380594;
        Tue, 26 Sep 2023 09:39:40 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:40 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH 4/4] fpga: add a platform driver to the FPGA Region test suite
Date:   Tue, 26 Sep 2023 18:39:11 +0200
Message-ID: <20230926163911.66114-5-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926163911.66114-1-marpagan@redhat.com>
References: <20230926163911.66114-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a minimal platform driver associated with the parent platform
device used for testing to prevent a null-ptr-deref when try_module_get()
is called by fpga_region_get(). Also, fix a typo in the suite's name.

Fixes: 64a5f972c93d ("fpga: add an initial KUnit suite for the FPGA Region")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-region-test.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index 9f9d50ee7871..5ff688b394f9 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -15,6 +15,8 @@
 #include <linux/platform_device.h>
 #include <linux/types.h>
 
+#include "fpga-test-helpers.h"
+
 struct mgr_stats {
 	u32 write_count;
 };
@@ -132,6 +134,18 @@ static void fpga_region_test_program_fpga(struct kunit *test)
 	fpga_image_info_free(img_info);
 }
 
+TEST_PLATFORM_DRIVER(test_platform_driver);
+
+static int fpga_region_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&test_platform_driver);
+}
+
+static void fpga_region_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&test_platform_driver);
+}
+
 /*
  * The configuration used in this test suite uses a single bridge to
  * limit the code under test to a single unit. The functions used by the
@@ -146,14 +160,15 @@ static int fpga_region_test_init(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	ctx->mgr_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
+							NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
 
 	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
 					  &ctx->mgr_stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
 
-	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
+	ctx->bridge_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
 							   NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
 
@@ -163,7 +178,7 @@ static int fpga_region_test_init(struct kunit *test)
 
 	ctx->bridge_stats.enable = true;
 
-	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
+	ctx->region_pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO,
 							   NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
 
@@ -195,12 +210,13 @@ static void fpga_region_test_exit(struct kunit *test)
 static struct kunit_case fpga_region_test_cases[] = {
 	KUNIT_CASE(fpga_region_test_class_find),
 	KUNIT_CASE(fpga_region_test_program_fpga),
-
 	{}
 };
 
 static struct kunit_suite fpga_region_suite = {
-	.name = "fpga_mgr",
+	.name = "fpga_region",
+	.suite_init = fpga_region_test_suite_init,
+	.suite_exit = fpga_region_test_suite_exit,
 	.init = fpga_region_test_init,
 	.exit = fpga_region_test_exit,
 	.test_cases = fpga_region_test_cases,
-- 
2.41.0

