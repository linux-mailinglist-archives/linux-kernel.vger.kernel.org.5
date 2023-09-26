Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3A37AF0EB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbjIZQkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235346AbjIZQkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A1911F
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746371;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vekRvbFuhbc4qXIoy5r5sKVR277TKztySBeIjCszjQ=;
        b=i+qy6EO/DNqHHEPbjcoN+v0n6W2YgKM2ZAenGx0VbT52qDnWG+RRQD2b+ifaGzR/WX18oO
        fH+RGHMklzL16+vXkiF3PubNWfQYW0MHD/nwa3SR+kmEcR1Lgn0hAQ1AX24gCuvFmrOj96
        sIdkKes9JMkz5kPjrY/swCVFXNT930k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-y_o4KSOGPRqqJ5ZZ7ay0Og-1; Tue, 26 Sep 2023 12:39:29 -0400
X-MC-Unique: y_o4KSOGPRqqJ5ZZ7ay0Og-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-32329974dbdso3694685f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746368; x=1696351168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vekRvbFuhbc4qXIoy5r5sKVR277TKztySBeIjCszjQ=;
        b=xFdRv2JT+mdvuI+9jpI759WgvuxPmXgUBjhPlGSsIT5iMgED8/MtToTjXYppeGWi0r
         SWxBDCqPmh7MVganBOiyEOvF+QgT7ayTV+Ftm8JLpGd0l/FFY1OTfyXGAfSzadJSMn8H
         5o1uJRlI+CHt8zKB55HyC4HOfwFv+o86BrXObbMdhG113sSV3Yty3EFuhaoMx3q+Xlfh
         BY5XYxi1e22VXJ3gR3hgI86qgGZ1JHJA26HUrx+G9M+12Kun28jQqS1w34Vt67eBI7eG
         kJk5oK7Q5fIuObN0cAM78ggO/viVyCJslDOjY7aicHqapZB/5ScY7ul68T1nZO8b7t05
         G43w==
X-Gm-Message-State: AOJu0YyeUGVfCEDInMWKsgdLBm1ovyHyq7WTzuMFdRFwOnaHz/TboanD
        msWZalg7T2wRtLoaV4im27yLEYEhrzM1bwuXIEr3Ot/0hYAfDkMJpCacS9cX26Iau7nndL/g1xR
        vpC8KoaPReqU/9zU7OkBt/iw=
X-Received: by 2002:a05:6000:1c7:b0:31f:bdfd:5d30 with SMTP id t7-20020a05600001c700b0031fbdfd5d30mr10927468wrx.57.1695746368815;
        Tue, 26 Sep 2023 09:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX8EcPEYL9XNbW5emDb2L3Wp36IHDUsyIYnSB9fUqrAGottXlbDsMYpWyM4tCp7IPkDH1AaQ==
X-Received: by 2002:a05:6000:1c7:b0:31f:bdfd:5d30 with SMTP id t7-20020a05600001c700b0031fbdfd5d30mr10927453wrx.57.1695746368621;
        Tue, 26 Sep 2023 09:39:28 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:28 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH 2/4] fpga: add a platform driver to the FPGA Manager test suite
Date:   Tue, 26 Sep 2023 18:39:09 +0200
Message-ID: <20230926163911.66114-3-marpagan@redhat.com>
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
is called by fpga_mgr_get().

Fixes: ccbc1c302115 ("fpga: add an initial KUnit suite for the FPGA Manager")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-mgr-test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 6acec55b60ce..30de474d7def 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -14,6 +14,8 @@
 #include <linux/scatterlist.h>
 #include <linux/types.h>
 
+#include "fpga-test-helpers.h"
+
 #define HEADER_FILL		'H'
 #define IMAGE_FILL		'P'
 #define IMAGE_BLOCK		1024
@@ -277,6 +279,18 @@ static void fpga_mgr_test_img_load_sgt(struct kunit *test)
 	sg_free_table(ctx->img_info->sgt);
 }
 
+TEST_PLATFORM_DRIVER(test_platform_driver);
+
+static int fpga_mgr_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&test_platform_driver);
+}
+
+static void fpga_mgr_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&test_platform_driver);
+}
+
 static int fpga_mgr_test_init(struct kunit *test)
 {
 	struct mgr_ctx *ctx;
@@ -284,7 +298,7 @@ static int fpga_mgr_test_init(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	ctx->pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
 
 	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
@@ -317,6 +331,8 @@ static struct kunit_case fpga_mgr_test_cases[] = {
 
 static struct kunit_suite fpga_mgr_suite = {
 	.name = "fpga_mgr",
+	.suite_init = fpga_mgr_test_suite_init,
+	.suite_exit = fpga_mgr_test_suite_exit,
 	.init = fpga_mgr_test_init,
 	.exit = fpga_mgr_test_exit,
 	.test_cases = fpga_mgr_test_cases,
-- 
2.41.0

