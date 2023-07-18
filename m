Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380BF757CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232611AbjGRNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232304AbjGRNHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:07:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5721BD6
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689685417;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKrzGanyiyC099mjlFA5dr2WMY6zoHlA/Ps7wwq3mKc=;
        b=hHOesXMuQjvxds3BtRSFNyvPQILL4uMPYasJXLxk2iE0NrX4AcqLVqWEg79qPMWSPFraJu
        OqWQ5LUAeVWYot9SEAM+0gjqwgTI5uhuggFMnJ/frBGxzvlmRoPRkK6JbNvzCSzOMK/3LZ
        alPrfZrv9aN06Diu4VF7QqwWyDiBh4o=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-Jru30iqiOl6CPEYG9OKBag-1; Tue, 18 Jul 2023 09:03:36 -0400
X-MC-Unique: Jru30iqiOl6CPEYG9OKBag-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-763c36d4748so532875685a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 06:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689685415; x=1692277415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKrzGanyiyC099mjlFA5dr2WMY6zoHlA/Ps7wwq3mKc=;
        b=lBulA4MTi+Z3+rfdtUoyG1cILN+x6uyHBNsDM6APx7Gv8/fKK84EzMlEQoO667X3Rk
         5pu0rvJ0DJc+PIp/cDoJVnvuJ2vmTNTuaSNPRiLUq/o8qbqGFI8iQL2YZweGGs9L3Hav
         AwyGMznIWtCcxadsgZSWaNQVKIUGapwsfINRDFvV/8DogtZvhZQMuYU5XIha8E9Zav4R
         tKNxDT8oBy4gypzPxCt7TQKY2JkWiRuxcMj3znlqP3NmrT88qSORoE8zqEK5Y8jgu28T
         oxPyqwmscQJ5MMyvnn5Kql2ZNtm7PxUOl4HWNoye1Rd92WqhscTZALx6QZYCoDtI7ciw
         hTuQ==
X-Gm-Message-State: ABy/qLZYN6gX16kh0JQr+JNQELMBwx+AHgdSykxHp16EVN9AbTJdnEhk
        vUPjEbv6INcADf/R5GdqmYlXnbT88b7tu7P1tU6W8PbucRzMeTtQAztixiPFUirIrPZzNUApqbZ
        qB++Cq+hTaIXELqI44PCvi7c=
X-Received: by 2002:a05:620a:8e86:b0:767:4068:1e06 with SMTP id rf6-20020a05620a8e8600b0076740681e06mr8879884qkn.78.1689685415519;
        Tue, 18 Jul 2023 06:03:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFaeqg1ayhBysqxVfP8vAtMWz+eH01RMsR2pwY78oqTa4Zb/qLOP3VDwVSaoavURH4B7NcS2w==
X-Received: by 2002:a05:620a:8e86:b0:767:4068:1e06 with SMTP id rf6-20020a05620a8e8600b0076740681e06mr8879869qkn.78.1689685415276;
        Tue, 18 Jul 2023 06:03:35 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-27-228.cust.vodafonedsl.it. [2.34.27.228])
        by smtp.gmail.com with ESMTPSA id h18-20020a05620a10b200b00765ab6d3e81sm550221qkk.122.2023.07.18.06.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 06:03:35 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v10 3/4] fpga: add an initial KUnit suite for the FPGA Region
Date:   Tue, 18 Jul 2023 15:03:03 +0200
Message-ID: <20230718130304.87048-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230718130304.87048-1-marpagan@redhat.com>
References: <20230718130304.87048-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suite tests the basic behaviors of the FPGA Region including
the programming and the function for finding a specific region.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/tests/fpga-region-test.c | 211 ++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-region-test.c

diff --git a/drivers/fpga/tests/fpga-region-test.c b/drivers/fpga/tests/fpga-region-test.c
new file mode 100644
index 000000000000..9f9d50ee7871
--- /dev/null
+++ b/drivers/fpga/tests/fpga-region-test.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Region
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/fpga/fpga-region.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/types.h>
+
+struct mgr_stats {
+	u32 write_count;
+};
+
+struct bridge_stats {
+	bool enable;
+	u32 cycles_count;
+};
+
+struct test_ctx {
+	struct fpga_manager *mgr;
+	struct platform_device *mgr_pdev;
+	struct fpga_bridge *bridge;
+	struct platform_device *bridge_pdev;
+	struct fpga_region *region;
+	struct platform_device *region_pdev;
+	struct bridge_stats bridge_stats;
+	struct mgr_stats mgr_stats;
+};
+
+static int op_write(struct fpga_manager *mgr, const char *buf, size_t count)
+{
+	struct mgr_stats *stats = mgr->priv;
+
+	stats->write_count++;
+
+	return 0;
+}
+
+/*
+ * Fake FPGA manager that implements only the write op to count the number
+ * of programming cycles. The internals of the programming sequence are
+ * tested in the Manager suite since they are outside the responsibility
+ * of the Region.
+ */
+static const struct fpga_manager_ops fake_mgr_ops = {
+	.write = op_write,
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	if (!stats->enable && enable)
+		stats->cycles_count++;
+
+	stats->enable = enable;
+
+	return 0;
+}
+
+/*
+ * Fake FPGA bridge that implements only enable_set op to count the number
+ * of activation cycles.
+ */
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set,
+};
+
+static int fake_region_get_bridges(struct fpga_region *region)
+{
+	struct fpga_bridge *bridge = region->priv;
+
+	return fpga_bridge_get_to_list(bridge->dev.parent, region->info, &region->bridge_list);
+}
+
+static int fake_region_match(struct device *dev, const void *data)
+{
+	return dev->parent == data;
+}
+
+static void fpga_region_test_class_find(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_region *region;
+
+	region = fpga_region_class_find(NULL, &ctx->region_pdev->dev, fake_region_match);
+	KUNIT_EXPECT_PTR_EQ(test, region, ctx->region);
+}
+
+/*
+ * FPGA Region programming test. The Region must call get_bridges() to get
+ * and control the bridges, and then the Manager for the actual programming.
+ */
+static void fpga_region_test_program_fpga(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+	struct fpga_image_info *img_info;
+	char img_buf[4];
+	int ret;
+
+	img_info = fpga_image_info_alloc(&ctx->mgr_pdev->dev);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, img_info);
+
+	img_info->buf = img_buf;
+	img_info->count = sizeof(img_buf);
+
+	ctx->region->info = img_info;
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 1, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 1, ctx->bridge_stats.cycles_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	ret = fpga_region_program_fpga(ctx->region);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_EQ(test, 2, ctx->mgr_stats.write_count);
+	KUNIT_EXPECT_EQ(test, 2, ctx->bridge_stats.cycles_count);
+
+	fpga_bridges_put(&ctx->region->bridge_list);
+
+	fpga_image_info_free(img_info);
+}
+
+/*
+ * The configuration used in this test suite uses a single bridge to
+ * limit the code under test to a single unit. The functions used by the
+ * Region for getting and controlling bridges are tested (with a list of
+ * multiple bridges) in the Bridge suite.
+ */
+static int fpga_region_test_init(struct kunit *test)
+{
+	struct test_ctx *ctx;
+	struct fpga_region_info region_info = { 0 };
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->mgr_pdev = platform_device_register_simple("mgr_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->mgr_pdev);
+
+	ctx->mgr = devm_fpga_mgr_register(&ctx->mgr_pdev->dev, "Fake FPGA Manager", &fake_mgr_ops,
+					  &ctx->mgr_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->mgr));
+
+	ctx->bridge_pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->bridge_pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->bridge_pdev->dev, "Fake FPGA Bridge",
+					   &fake_bridge_ops, &ctx->bridge_stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	ctx->bridge_stats.enable = true;
+
+	ctx->region_pdev = platform_device_register_simple("region_pdev", PLATFORM_DEVID_AUTO,
+							   NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->region_pdev);
+
+	region_info.mgr = ctx->mgr;
+	region_info.priv = ctx->bridge;
+	region_info.get_bridges = fake_region_get_bridges;
+
+	ctx->region = fpga_region_register_full(&ctx->region_pdev->dev, &region_info);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->region));
+
+	test->priv = ctx;
+
+	return 0;
+}
+
+static void fpga_region_test_exit(struct kunit *test)
+{
+	struct test_ctx *ctx = test->priv;
+
+	fpga_region_unregister(ctx->region);
+	platform_device_unregister(ctx->region_pdev);
+
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->bridge_pdev);
+
+	platform_device_unregister(ctx->mgr_pdev);
+}
+
+static struct kunit_case fpga_region_test_cases[] = {
+	KUNIT_CASE(fpga_region_test_class_find),
+	KUNIT_CASE(fpga_region_test_program_fpga),
+
+	{}
+};
+
+static struct kunit_suite fpga_region_suite = {
+	.name = "fpga_mgr",
+	.init = fpga_region_test_init,
+	.exit = fpga_region_test_exit,
+	.test_cases = fpga_region_test_cases,
+};
+
+kunit_test_suite(fpga_region_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.41.0

