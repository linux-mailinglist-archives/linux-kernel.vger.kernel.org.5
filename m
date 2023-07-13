Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA12752846
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbjGMQ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbjGMQ2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:28:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C4E82D48
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKrzGanyiyC099mjlFA5dr2WMY6zoHlA/Ps7wwq3mKc=;
        b=CE9zNZ1Vh1m/tadz+yFt5ilxcE0nOOc7Ro2lZjztDOIJqhjxTEpJZ5USjw9LgJ5wL8iaAh
        ja4fB7Y+2C9Vl1Ogif0QVvyc9R+8E1UtYgPWPdiK4WrWRrTQ2Ikn4TNEQT2YZhZ5VafyLS
        iivOdSm9oDLFzHFdg4VTTX8FNSIKgPE=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-uS_nGkuyPOWnyQ1E_6rU1w-1; Thu, 13 Jul 2023 12:28:00 -0400
X-MC-Unique: uS_nGkuyPOWnyQ1E_6rU1w-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-78a5bbabf67so221771241.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:28:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265680; x=1691857680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QKrzGanyiyC099mjlFA5dr2WMY6zoHlA/Ps7wwq3mKc=;
        b=VOyU20qf6QFlqQl7lHet1Z00+GHDGvGOZmYeTs0Qxsf/zSUl6J1qhUB8HYsOLKQZxr
         MISBOLBPK2+hVg9Rc/s+nuwn9e+at8b9jkY5TmS5GgaoKQVz6PJATc29cB+jCJjyDvY5
         XYZLfYA3R2DfjeUYDIfJ2RrfTuT++rIuwU5SQ+sa9uNHP6wRT65/3gXKCQ4V4hiA5slC
         UE+3alzjvVrn87EUVAfaeIBzkrKKbR4yiK6KftjxCvo4zfHAIP4AZhuHiiALhG103O+b
         iOvK6v38P9FXIlVljs775WhERToHAu39diopB9uxkWh/z3T6BWSLRF5iy8CFuc2frWZv
         fvow==
X-Gm-Message-State: ABy/qLZCuMOuJoYKndP4Rv3g7WyTD1zgklnBfECf9Nem+280Cw81NSaG
        tVaY+eKN6BflyPIHDa6lGGq38d045+QDgpCn7aduKQDa7TbfzuUgvwq0yFoPBScR3j2T1XfAyKk
        i046jlqOG+vuwLZsEDx/0eaw=
X-Received: by 2002:a67:fa09:0:b0:443:a8dd:c416 with SMTP id i9-20020a67fa09000000b00443a8ddc416mr1504657vsq.8.1689265680371;
        Thu, 13 Jul 2023 09:28:00 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFS304p593zeQ6Tj+ewmfzA+4oO/F//5JHItKyA8E3joHp3KNi1JLprPORk3C1nmCCWNPHU/Q==
X-Received: by 2002:a67:fa09:0:b0:443:a8dd:c416 with SMTP id i9-20020a67fa09000000b00443a8ddc416mr1504647vsq.8.1689265680122;
        Thu, 13 Jul 2023 09:28:00 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cf1d1000000b00637873ff0f3sm3206582qvl.15.2023.07.13.09.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:27:59 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v9 3/4] fpga: add an initial KUnit suite for the FPGA Region
Date:   Thu, 13 Jul 2023 18:27:30 +0200
Message-ID: <20230713162731.211669-4-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713162731.211669-1-marpagan@redhat.com>
References: <20230713162731.211669-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
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

