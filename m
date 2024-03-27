Return-Path: <linux-kernel+bounces-120831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0888DEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED8E21C268E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEE213A267;
	Wed, 27 Mar 2024 12:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ocxp9Kvt"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664512F59E
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541326; cv=none; b=c8JBsFaN2bL7L/ebeDxOUZ+BaQmQpXXJ0Cnc+tkAmNoAQ/Ne0OJaNiemAVxDhrDAORNwgHSTsW8sjUEmtE9ywgQtrqC3P/1eNbVXzuHteQ2SjnVPWxn4anrv80DLvdSooXNCp892sbwmSgcWK8bpi069rDdzxFFAbZGMmkSaKGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541326; c=relaxed/simple;
	bh=YxJ+QA/6XuU3osPC5/Qxx/5mKVJCLnVdTXqMJCytxJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JO2PUHS5PG36Yo2NT9WckUJKF0j4CWrc1Ms6xA9SVFkcXvUZFGwbYjlleHBPaWAdHtuguUuCGsiRbkcE9AbiF3R4d/2I0xBZYblrvbzgyUl9PMewpjDl12nDKekbUeuZO/XRLYT6+BQWR8lWrYQd6zmEjH9z+AgHQbI0y5zdmSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ocxp9Kvt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711541323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ItomEgLv28WUD6jaiAYWwN8p2rpJktwWWUzWfeqvDNw=;
	b=Ocxp9Kvt3WBfIcnNMiy60RC7nxsGSVsgHMO/bgITn/XWPHyxe29vtteQa/vCiliO7QmXjW
	JPu6xudrJyaLCrU5FUZJ5e+u8Bh9M7/Nuwewtft413Yz97DshPh4XdZt/6QC30gUlA4uCu
	bFkQRArRfdkT9wz+tf3EqNHC5WDyi04=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-BINKbuvGMhmEyfDriL6YlA-1; Wed, 27 Mar 2024 08:08:42 -0400
X-MC-Unique: BINKbuvGMhmEyfDriL6YlA-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-78a43601cddso386753585a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 05:08:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711541322; x=1712146122;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ItomEgLv28WUD6jaiAYWwN8p2rpJktwWWUzWfeqvDNw=;
        b=HTJImTYwR2wiJyxMrgSsEoAgQ5G8z4l2f6OLrB2ARy4IN8fmm5CgDC90eJVRnNJ2G7
         ObEaItVs+qwCCYiO5EJ04/Vw+jQ5tdoAYzxZRH+ZcjuKF0WKF0ZZ3fUU70O+7P5IwFNa
         xN0h2eI+JaqfsIsVaemmN4TVtYNbpU9wGKt2SE0rk4LphRK8qXtoOzuIEAzx+hYgqrP3
         wK2ghF6gC+Is0TJVuF4MZu7ebGP4SZmQfvTjTdgZYIguPjVWC1HQZHY6WF3AsqyPQQwc
         thOKKV9VI9u2gDHMz/+ESXvO1vzfadnFJa49uK/ORSct+bWNQBj7w62W3fRmWcDdYP6J
         L4Cg==
X-Forwarded-Encrypted: i=1; AJvYcCUtzjNIelKg45TSXPqVP5mj6eMnaNT8/RT75uhoNzJDaQrv4kbw00MhwFf1p15nD1X6NALNqZU1W9wGoEW/1pGXKuolS+Qba9IWuDzQ
X-Gm-Message-State: AOJu0YzAYHXaeKQtrMxo3rQA0x8UyVPg4cdhZwmZ8s2JrluaCMW7tY1K
	3UOjr09ntfcEdPJAmrOmtg0o4IjdGXfcENb6a13lWh55J3+xuAocrA8sM3Md7SK+3hAnu9RJIIp
	JZRduoasXTD1F0WB5qQepGHvTKcQ1LE2D9B7bcSkODGHZjCiRJ0Ujr5rGDRRz
X-Received: by 2002:a05:620a:a12:b0:789:e71e:2692 with SMTP id i18-20020a05620a0a1200b00789e71e2692mr3912278qka.48.1711541321754;
        Wed, 27 Mar 2024 05:08:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt/f3cTrkOy702r2FqG3aXaBs2frYu0NpFj+2J2eoStZAs4AEY8C3spyK8IPpgIcgI9W2G2g==
X-Received: by 2002:a05:620a:a12:b0:789:e71e:2692 with SMTP id i18-20020a05620a0a1200b00789e71e2692mr3912257qka.48.1711541321479;
        Wed, 27 Mar 2024 05:08:41 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-30-89.cust.vodafonedsl.it. [2.34.30.89])
        by smtp.gmail.com with ESMTPSA id dy50-20020a05620a60f200b00789ef21c9b8sm3845919qkb.65.2024.03.27.05.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 05:08:41 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: tests: use KUnit devices instead of platform devices
Date: Wed, 27 Mar 2024 13:08:17 +0100
Message-ID: <20240327120818.148430-1-marpagan@redhat.com>
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

Signed-off-by: Marco Pagani <marpagan@redhat.com>
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


