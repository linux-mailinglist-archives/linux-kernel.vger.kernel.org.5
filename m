Return-Path: <linux-kernel+bounces-125265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A5E892306
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC531F2326C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8DF1369AD;
	Fri, 29 Mar 2024 17:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6U9HXoS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B639A130A5C
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711734542; cv=none; b=Z/TeA6twLhxHF57deWa9dYucPrz4ZmqvSXUBL/gd05Ybddv6AQk4C78WMKPDGse5tKOjlir9IC49evyANWCaczzh116XMzv5hQEPEM8yUSnB+ZQnJ9DR73ZKYsbDAjwDTFxaP27FK1G2VHVvyxc0KgW2fVJ/TcMQfueNNjKedHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711734542; c=relaxed/simple;
	bh=hj9hOImV1PfvC/82oQt/yA1gKOF4IgcDzJ0K0x4tNRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KvV5SpE7oh14dRbCkxG1nphOCQx22NZQ4bk6h5/TXjzJ0PoZEaTRx50Zytv7z3gFNiDXEcH03thV7XoGZ2UO9kPye937h5Uu29LJXsibj17JR9Wu6oANht991+bMTinx/6GSG2wpkeisrDggTh0IcHXDAvh0iaZ1c0Qde9Dt4z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X6U9HXoS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711734539;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7DU/v5b5o5Hgx8oROSy6ozmjhxBFQ8Ejk72oaMjpGl8=;
	b=X6U9HXoSagmOBx2VqUyok85FIM0MK9z6cX7R/SByDjki/n5O2grjwVo9NNktMXLq1+MuVX
	qGLlBeAQsq/hGbipspdYP30p11pPOLvChy6qF4q/HehcBimc8qE3N5L8fcmT8NC1ihAzy0
	UKfcrWLvXjz4t1QPk1IanFGdPhSVxR8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-Utz1zE9OOS6iHio9a4pUyQ-1; Fri, 29 Mar 2024 13:48:58 -0400
X-MC-Unique: Utz1zE9OOS6iHio9a4pUyQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6964043b5f1so27547466d6.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 10:48:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711734537; x=1712339337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7DU/v5b5o5Hgx8oROSy6ozmjhxBFQ8Ejk72oaMjpGl8=;
        b=i+Jl70b8pgVsTgroHWDKNlFXUVy5KTxIPU1d33xabt+sPHi4QmJjOSpgmEoUv86Pbe
         ZljhU3Gp6MuMX7YIg4C5cBTG5EvF0/5QR4avY3b2JrJK2KPAXyf+20wZqd4OmE4TkYUn
         cLOxo61f2FBBS/wl61E4kuk+q+PeDHYT1hrRnKY0SHxC/i5jyYukv5KvgFr8vKPF+0N/
         +Cwsakub6HXsCplMirO9oLuxD+N7VBmHiL8tjjpYZMzOO0fG6LZ8hVobABWD2SXH2pmQ
         TIGv/+niomZB2cXFj4PPSJNd76zqUY0IJE0s8aSVxLAuA8M16n1SSak/tjx2QfezxQaa
         bZAw==
X-Forwarded-Encrypted: i=1; AJvYcCWuoae7EoxHVPYajGQdAmhQvkGMPD0bvCOIyWoP7s80hSwqHJX/OLyH5EA82RDTdJYT0Lw1RKZa3U8W/AP/Ji6cVjlJ3ZOdieq2VN2J
X-Gm-Message-State: AOJu0Yxwu3qws+ZM+DniGAo5V6sSnXboXKw2sv7R4V5T1XAWya9b0jhE
	1MM7QHupZl814MamN20kIj6b+UiySDZI6UJ8gOqx9/tc/UCa/dXwbYp0iOdOA7rPHxZqiz3qLCD
	+5FUt3uxZaGLOn1N2QHAGveowSC7l+RZ3f7vAOv3zVq0FnmGd7AN7qjeOHvWV
X-Received: by 2002:ac8:5795:0:b0:431:849a:1b3a with SMTP id v21-20020ac85795000000b00431849a1b3amr3311984qta.41.1711734537292;
        Fri, 29 Mar 2024 10:48:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlqCk3Cc/WLzrhYE892imHmeVXgy7ZOTlx44L9zB7elXuZU1oiEKM3GMuPfGXGo4y+tVfFBA==
X-Received: by 2002:ac8:5795:0:b0:431:849a:1b3a with SMTP id v21-20020ac85795000000b00431849a1b3amr3311965qta.41.1711734536929;
        Fri, 29 Mar 2024 10:48:56 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id ef12-20020a05622a53cc00b0043123c8b6a6sm1822645qtb.4.2024.03.29.10.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 10:48:56 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	Russ Weight <russ.weight@linux.dev>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] fpga: tests: use KUnit devices instead of platform devices
Date: Fri, 29 Mar 2024 18:48:47 +0100
Message-ID: <20240329174849.248243-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

KUnit now provides helper functions to create fake devices, so use them
instead of relying on platform devices.

Other changes: remove an unnecessary white space in the fpga region suite.

Reviewed-by: Russ Weight <russ.weight@linux.dev>
Signed-off-by: Marco Pagani <marpagan@redhat.com>
---

v2:
- Add reviewed-by Russ Weight
---
 drivers/fpga/tests/fpga-bridge-test.c | 33 ++++++++++-----------
 drivers/fpga/tests/fpga-mgr-test.c    | 16 +++++------
 drivers/fpga/tests/fpga-region-test.c | 41 +++++++++++++--------------
 3 files changed, 44 insertions(+), 46 deletions(-)

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
index 1d258002cdd7..2f7a24f23808 100644
--- a/drivers/fpga/tests/fpga-bridge-test.c
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -7,8 +7,8 @@
  * Author: Marco Pagani <marpagan@redhat.com>
  */
 
+#include <kunit/device.h>
 #include <kunit/test.h>
-#include <linux/device.h>
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/module.h>
 #include <linux/types.h>
@@ -19,7 +19,7 @@ struct bridge_stats {
 
 struct bridge_ctx {
 	struct fpga_bridge *bridge;
-	struct platform_device *pdev;
+	struct device *dev;
 	struct bridge_stats stats;
 };
 
@@ -43,30 +43,31 @@ static const struct fpga_bridge_ops fake_bridge_ops = {
 /**
  * register_test_bridge() - Register a fake FPGA bridge for testing.
  * @test: KUnit test context object.
+ * @dev_name: name of the kunit device to be registered
  *
  * Return: Context of the newly registered FPGA bridge.
  */
-static struct bridge_ctx *register_test_bridge(struct kunit *test)
+static struct bridge_ctx *register_test_bridge(struct kunit *test, const char *dev_name)
 {
 	struct bridge_ctx *ctx;
 
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+	ctx->dev = kunit_device_register(test, dev_name);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
 
-	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
+	ctx->bridge = fpga_bridge_register(ctx->dev, "Fake FPGA bridge", &fake_bridge_ops,
 					   &ctx->stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
 
 	return ctx;
 }
 
-static void unregister_test_bridge(struct bridge_ctx *ctx)
+static void unregister_test_bridge(struct kunit *test, struct bridge_ctx *ctx)
 {
 	fpga_bridge_unregister(ctx->bridge);
-	platform_device_unregister(ctx->pdev);
+	kunit_device_unregister(test, ctx->dev);
 }
 
 static void fpga_bridge_test_get(struct kunit *test)
@@ -74,10 +75,10 @@ static void fpga_bridge_test_get(struct kunit *test)
 	struct bridge_ctx *ctx = test->priv;
 	struct fpga_bridge *bridge;
 
-	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	bridge = fpga_bridge_get(ctx->dev, NULL);
 	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
 
-	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	bridge = fpga_bridge_get(ctx->dev, NULL);
 	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
 
 	fpga_bridge_put(ctx->bridge);
@@ -105,19 +106,19 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
 	int ret;
 
 	ctx_0 = test->priv;
-	ctx_1 = register_test_bridge(test);
+	ctx_1 = register_test_bridge(test, "fpga-bridge-test-dev-1");
 
 	INIT_LIST_HEAD(&bridge_list);
 
 	/* Get bridge 0 and add it to the list */
-	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
+	ret = fpga_bridge_get_to_list(ctx_0->dev, NULL, &bridge_list);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
 			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
 
 	/* Get bridge 1 and add it to the list */
-	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
+	ret = fpga_bridge_get_to_list(ctx_1->dev, NULL, &bridge_list);
 	KUNIT_EXPECT_EQ(test, ret, 0);
 
 	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
@@ -141,19 +142,19 @@ static void fpga_bridge_test_get_put_list(struct kunit *test)
 
 	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
 
-	unregister_test_bridge(ctx_1);
+	unregister_test_bridge(test, ctx_1);
 }
 
 static int fpga_bridge_test_init(struct kunit *test)
 {
-	test->priv = register_test_bridge(test);
+	test->priv = register_test_bridge(test, "fpga-bridge-test-dev-0");
 
 	return 0;
 }
 
 static void fpga_bridge_test_exit(struct kunit *test)
 {
-	unregister_test_bridge(test->priv);
+	unregister_test_bridge(test, test->priv);
 }
 
 static struct kunit_case fpga_bridge_test_cases[] = {
diff --git a/drivers/fpga/tests/fpga-mgr-test.c b/drivers/fpga/tests/fpga-mgr-test.c
index 6acec55b60ce..125b3a4d43c6 100644
--- a/drivers/fpga/tests/fpga-mgr-test.c
+++ b/drivers/fpga/tests/fpga-mgr-test.c
@@ -7,8 +7,8 @@
  * Author: Marco Pagani <marpagan@redhat.com>
  */
 
+#include <kunit/device.h>
 #include <kunit/test.h>
-#include <linux/device.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/module.h>
 #include <linux/scatterlist.h>
@@ -40,7 +40,7 @@ struct mgr_stats {
 struct mgr_ctx {
 	struct fpga_image_info *img_info;
 	struct fpga_manager *mgr;
-	struct platform_device *pdev;
+	struct device *dev;
 	struct mgr_stats stats;
 };
 
@@ -194,7 +194,7 @@ static void fpga_mgr_test_get(struct kunit *test)
 	struct mgr_ctx *ctx = test->priv;
 	struct fpga_manager *mgr;
 
-	mgr = fpga_mgr_get(&ctx->pdev->dev);
+	mgr = fpga_mgr_get(ctx->dev);
 	KUNIT_EXPECT_PTR_EQ(test, mgr, ctx->mgr);
 
 	fpga_mgr_put(ctx->mgr);
@@ -284,14 +284,14 @@ static int fpga_mgr_test_init(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+	ctx->dev = kunit_device_register(test, "fpga-manager-test-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
 
-	ctx->mgr = devm_fpga_mgr_register(&ctx->pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
+	ctx->mgr = devm_fpga_mgr_register(ctx->dev, "Fake FPGA Manager", &fake_mgr_ops,
 					  &ctx->stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
 
-	ctx->img_info = fpga_image_info_alloc(&ctx->pdev->dev);
+	ctx->img_info = fpga_image_info_alloc(ctx->dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->img_info);
 
 	test->priv = ctx;
@@ -304,7 +304,7 @@ static void fpga_mgr_test_exit(struct kunit *test)
 	struct mgr_ctx *ctx = test->priv;
 
 	fpga_image_info_free(ctx->img_info);
-	platform_device_unregister(ctx->pdev);
+	kunit_device_unregister(test, ctx->dev);
 }
 
 static struct kunit_case fpga_mgr_test_cases[] = {
diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
index baab07e3fc59..bcf0651df261 100644
--- a/drivers/fpga/tests/fpga-region-test.c
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -7,12 +7,12 @@
  * Author: Marco Pagani <marpagan@redhat.com>
  */
 
+#include <kunit/device.h>
 #include <kunit/test.h>
 #include <linux/fpga/fpga-bridge.h>
 #include <linux/fpga/fpga-mgr.h>
 #include <linux/fpga/fpga-region.h>
 #include <linux/module.h>
-#include <linux/platform_device.h>
 #include <linux/types.h>
 
 struct mgr_stats {
@@ -26,11 +26,11 @@ struct bridge_stats {
 
 struct test_ctx {
 	struct fpga_manager *mgr;
-	struct platform_device *mgr_pdev;
+	struct device *mgr_dev;
 	struct fpga_bridge *bridge;
-	struct platform_device *bridge_pdev;
+	struct device *bridge_dev;
 	struct fpga_region *region;
-	struct platform_device *region_pdev;
+	struct device *region_dev;
 	struct bridge_stats bridge_stats;
 	struct mgr_stats mgr_stats;
 };
@@ -91,7 +91,7 @@ static void fpga_region_test_class_find(struct kunit *test)
 	struct test_ctx *ctx = test->priv;
 	struct fpga_region *region;
 
-	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
+	region = fpga_region_class_find(NULL, ctx->region_dev, fake_region_match);
 	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
 
 	put_device(&region->dev);
@@ -108,7 +108,7 @@ static void fpga_region_test_program_fpga(struct kunit *test)
 	char img_buf[4];
 	int ret;
 
-	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
+	img_info = fpga_image_info_alloc(ctx->mgr_dev);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
 
 	img_info->buf = img_buf;
@@ -148,32 +148,30 @@ static int fpga_region_test_init(struct kunit *test)
 	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
 
-	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
+	ctx->mgr_dev = kunit_device_register(test, "fpga-manager-test-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_dev);
 
-	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
-					  &ctx->mgr_stats);
+	ctx->mgr = devm_fpga_mgr_register(ctx->mgr_dev, "Fake FPGA Manager",
+					  &fake_mgr_ops, &ctx->mgr_stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
 
-	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
-							   NULL, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
+	ctx->bridge_dev = kunit_device_register(test, "fpga-bridge-test-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_dev);
 
-	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
+	ctx->bridge = fpga_bridge_register(ctx->bridge_dev, "Fake FPGA Bridge",
 					   &fake_bridge_ops, &ctx->bridge_stats);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
 
 	ctx->bridge_stats.enable = true;
 
-	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
-							   NULL, 0);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
+	ctx->region_dev = kunit_device_register(test, "fpga-region-test-dev");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_dev);
 
 	region_info.mgr = ctx->mgr;
 	region_info.priv = ctx->bridge;
 	region_info.get_bridges = fake_region_get_bridges;
 
-	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
+	ctx->region = fpga_region_register_full(ctx->region_dev, &region_info);
 	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
 
 	test->priv = ctx;
@@ -186,18 +184,17 @@ static void fpga_region_test_exit(struct kunit *test)
 	struct test_ctx *ctx = test->priv;
 
 	fpga_region_unregister(ctx->region);
-	platform_device_unregister(ctx->region_pdev);
+	kunit_device_unregister(test, ctx->region_dev);
 
 	fpga_bridge_unregister(ctx->bridge);
-	platform_device_unregister(ctx->bridge_pdev);
+	kunit_device_unregister(test, ctx->bridge_dev);
 
-	platform_device_unregister(ctx->mgr_pdev);
+	kunit_device_unregister(test, ctx->mgr_dev);
 }
 
 static struct kunit_case fpga_region_test_cases[] = {
 	KUNIT_CASE(fpga_region_test_class_find),
 	KUNIT_CASE(fpga_region_test_program_fpga),
-
 	{}
 };
 

base-commit: b1a91ca25f15b6d7b311de4465854a5981dee3d3
-- 
2.44.0


