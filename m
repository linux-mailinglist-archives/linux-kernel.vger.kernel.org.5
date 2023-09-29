Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC3977B3691
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjI2PWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233552AbjI2PWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:22:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0873BBF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696000887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6vekRvbFuhbc4qXIoy5r5sKVR277TKztySBeIjCszjQ=;
        b=YkO6UYGvOvLZwYAx7VHjqVQwFsXVSv6MHDfjtM4zzUYTOcYv3FsJnyLRbB02+zOPCjVMPb
        9aKReMMi4K3YIENzitwUOand7FwcwjEjqyHMSrchuhxRL3wEqOXjDtYuXL2vAyFc4Q7o+e
        41mN5JqCtiG544uEiF7bMAsJiVBqmTA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-bU7GacFBPjuewLPxMfOhIg-1; Fri, 29 Sep 2023 11:21:25 -0400
X-MC-Unique: bU7GacFBPjuewLPxMfOhIg-1
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-49093c3acacso8104711e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696000885; x=1696605685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vekRvbFuhbc4qXIoy5r5sKVR277TKztySBeIjCszjQ=;
        b=CSAkSuahnSPYyamZoqCZ66t7Ue4+bNf+ZjWB22XeYDIdjI9kTMG4D/pTH+YeMDum/e
         Di0DCGNwlIqKq02g2IN1iglWfE573ITcWDi4h+HghzDyQuNt/HcPmYI2cAgxj30d8fSI
         Co4knmiimSgxrtUXmyn9c/U+epPwGM426D3klzYBxwjRiqMz3XQkoE72rGFHSr9NUZ+j
         qbBepmhkv7mwZTw8LtWIEwRxa3b1K8XQSNE/RLQ0eSRwDNyx1ErSx1Kau0mLvTz3bQuZ
         j9tsVY9kAkpab8y/Isebqmq15HaHncJkr/LSv6jRJLTmKbyWdknYlmderiWtNBMg3UTq
         EtoA==
X-Gm-Message-State: AOJu0YzgCSyrJPJ+/4pGKclkExOQ1HWjhSFGKA6N60IIqumifgokeLPV
        nrJNTbXU0uSbm52sKuPQ4OaUkhanTzsqDm6iZjoN9UTC6aL2+F+FA76xuR0W64IzzTAtCGcX+7x
        Ro54xa/DciFQCwVeObG8BTxs=
X-Received: by 2002:a05:6122:32cd:b0:49c:37a1:2358 with SMTP id ck13-20020a05612232cd00b0049c37a12358mr4322982vkb.14.1696000885103;
        Fri, 29 Sep 2023 08:21:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4gs4hEWcYKxSY0LaVxjaPFVuWUAi9sKJYkYSyuIRz/F7CcNcZSPh09BHPm2a9q2Pylaeasg==
X-Received: by 2002:a05:6122:32cd:b0:49c:37a1:2358 with SMTP id ck13-20020a05612232cd00b0049c37a12358mr4322964vkb.14.1696000884850;
        Fri, 29 Sep 2023 08:21:24 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id bq14-20020a05622a1c0e00b00419801b1094sm287053qtb.13.2023.09.29.08.21.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 08:21:24 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH v2 2/4] fpga: add a platform driver to the FPGA Manager test suite
Date:   Fri, 29 Sep 2023 17:20:55 +0200
Message-ID: <20230929152057.85047-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230929152057.85047-1-marpagan@redhat.com>
References: <20230929152057.85047-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

