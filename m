Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F267AF0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjIZQk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjIZQkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:40:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1760BBF
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695746377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bU5dbp4PmbcRGMxxeBcidbIs/vd32ofMq8iILiK+4+o=;
        b=ARFByj3pfgy0AiNK5oJAen2kPF2j/FX1q5YlaHDVS+HZraaCEijScvwrp1ld/IwWLdXvSm
        Psk9dQdO7pV2hM+mumRPDKdcB5LGU7gmVgpwYkFZYSgmlO4cbqtvrd7tUAbUBmxjay0foG
        PvlkJhPod502MdIbEwRQgKiknvezpvk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-5iiAPVJmMaOMeNLyWTZ79A-1; Tue, 26 Sep 2023 12:39:36 -0400
X-MC-Unique: 5iiAPVJmMaOMeNLyWTZ79A-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4054743df06so69287955e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695746375; x=1696351175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bU5dbp4PmbcRGMxxeBcidbIs/vd32ofMq8iILiK+4+o=;
        b=PqHOjkzPmQshVyFTLOR7otdGFIb6D35xZgU5FShOIgv0SDT2PyzYTd9q/aMWrD1nRN
         FKW869kskNvV0wt12vcdxHc4E8PSYHknFUmaA4ZV7ziFQlb8XNw/OMrh71SQihHPg95u
         XmuFWowNunWDswRKJXpU8+1GGFR4u878lTsRUqjAsVup3y9uFi767IrDH3+t9r5SQsr7
         JS3XS9EnNQ/p6YiQQuROnISfYXIUkayzMfopO2G1EDJ0oEjocgCpJUMNCeLIiXG7XEoN
         nh3Pxpz47H087zNUveKM/netHti64wF95YcSXbr7PlNH8RHz5aWIPgZt6MObOofZN9/O
         iHHA==
X-Gm-Message-State: AOJu0Yw5mM470bXbNhAiJJnXlS3Ya/6eMMf0PleF0+os6ThwDVE+6F/4
        zMvDMclamQDnlsbZUMFcSeJmdGVv6kCcusgzBy78TM4MuasIZGo7I95Cq769wWy6r77mbIqcAIR
        W0r85YRJ5PNh/xsSxyvpFEMQ=
X-Received: by 2002:a5d:4a12:0:b0:319:5a7c:6418 with SMTP id m18-20020a5d4a12000000b003195a7c6418mr10305779wrq.43.1695746375047;
        Tue, 26 Sep 2023 09:39:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Qn5SYxz3S2izx2vdfof5gEmi912zq7TwxOe/Jk4swl4vtQThviKly5b00inzBZj4Y0gVmw==
X-Received: by 2002:a5d:4a12:0:b0:319:5a7c:6418 with SMTP id m18-20020a5d4a12000000b003195a7c6418mr10305767wrq.43.1695746374845;
        Tue, 26 Sep 2023 09:39:34 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-58.cust.vodafonedsl.it. [2.34.30.58])
        by smtp.gmail.com with ESMTPSA id w10-20020adfde8a000000b0031fba0a746bsm15171803wrl.9.2023.09.26.09.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 09:39:34 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org, Jinjie Ruan <ruanjinjie@huawei.com>
Subject: [PATCH 3/4] fpga: add a platform driver to the FPGA Bridge test suite
Date:   Tue, 26 Sep 2023 18:39:10 +0200
Message-ID: <20230926163911.66114-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926163911.66114-1-marpagan@redhat.com>
References: <20230926163911.66114-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register a minimal platform driver associated with the parent platform
device used for testing to prevent a null-ptr-deref when try_module_get()
is called by __fpga_bridge_get().

Fixes: 9e6823481e5f ("fpga: add an initial KUnit suite for the FPGA Bridge")
Reported-by: Jinjie Ruan <ruanjinjie@huawei.com>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/fpga-bridge-test.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
index 1d258002cdd7..4bd4ecaa7e90 100644
--- a/drivers/fpga/tests/fpga-bridge-test.c
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -13,6 +13,8 @@
 #include <linux/module.h>
 #include <linux/types.h>
 
+#include "fpga-test-helpers.h"
+
 struct bridge_stats {
 	bool enable;
 };
@@ -53,7 +55,7 @@ static struct bridge_ctx *register_test_bridge(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	ctx->pdev = platform_device_register_simple(TEST_PDEV_NAME, PLATFORM_DEVID_AUTO, NULL, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
 
 	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
@@ -144,6 +146,18 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
 	unregister_test_bridge(ctx_1);
 }
 
+TEST_PLATFORM_DRIVER(test_platform_driver);
+
+static int fpga_bridge_test_suite_init(struct kunit_suite *suite)
+{
+	return platform_driver_register(&test_platform_driver);
+}
+
+static void fpga_bridge_test_suite_exit(struct kunit_suite *suite)
+{
+	platform_driver_unregister(&test_platform_driver);
+}
+
 static int fpga_bridge_test_init(struct kunit *test)
 {
 	test->priv = register_test_bridge(test);
@@ -165,6 +179,8 @@ static struct kunit_case fpga_bridge_test_cases[] = {
 
 static struct kunit_suite fpga_bridge_suite = {
 	.name = "fpga_bridge",
+	.suite_init = fpga_bridge_test_suite_init,
+	.suite_exit = fpga_bridge_test_suite_exit,
 	.init = fpga_bridge_test_init,
 	.exit = fpga_bridge_test_exit,
 	.test_cases = fpga_bridge_test_cases,
-- 
2.41.0

