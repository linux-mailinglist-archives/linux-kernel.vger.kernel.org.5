Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C817F752844
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235202AbjGMQ2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjGMQ2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:28:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DD8273B
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689265675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wZhu53F4F7gIlc8a4am6xpj3s/cLtV4xrOxNFzw7tE=;
        b=eq1xcY3i7UKx62RiYTn9XLpvFIlOY9b20jGR/zU3xeNPZyAKTX7fEFpCb2+flEi0ixH/S5
        5q4G2ll4ksli1hCS61mjk48/KOm4UL7rR3xb5ZzyMk/AzqitvGurAaCxBoPc9/gc0rG0Y6
        Bq0x6him6yxtINODPicsJKo+3/te3fo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-8W8LH28yO6K9etXAGNZIgQ-1; Thu, 13 Jul 2023 12:27:54 -0400
X-MC-Unique: 8W8LH28yO6K9etXAGNZIgQ-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e0889cc5so9464796d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:27:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689265673; x=1691857673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8wZhu53F4F7gIlc8a4am6xpj3s/cLtV4xrOxNFzw7tE=;
        b=evtyipurf3DMkem6opNGggFATP6zkhFqBzboMj1kRzXgLeHB7a6clM0jwDThWv6lCM
         hX0Lsm+TfRK/Oa+MsKSJf9x946TosfUnGfgzOEdL1e4sU/qX8zoYiul/PFrLZXDnNCZs
         XA4T8cRkgZtgk6wocnYswSfHqiBjZ4inJzyVVRxiArl43advSKAdtIhHA7v0AhfsrsQ1
         UpHvq2afsoAX862iLX8f/rXlJ2oRguVqkm4K+MfjnyVq4DjyOQHfYNKaCxP7tbriTQ8e
         sx5viHdyWLEnMWax+UA++VMYVcD3DxhyFV7JlBN8N8GW1QRIFV23T9v+bASAiD49iQ2S
         aW4g==
X-Gm-Message-State: ABy/qLYvedg55fwO4AXZEqMBQy64EtDVmZo0i0bhSCnfVvozzI+xF8QI
        asH3PdG31eroypeNcWb/iFSN5AhZLMEtm5HRfJs15JNPw4pl8TaoKLbyACb7bbCJGBkzBhc82Rj
        4P/JN6qBWZA9+IgO52091K1E=
X-Received: by 2002:a0c:b2d7:0:b0:635:e261:798d with SMTP id d23-20020a0cb2d7000000b00635e261798dmr1972032qvf.52.1689265673634;
        Thu, 13 Jul 2023 09:27:53 -0700 (PDT)
X-Google-Smtp-Source: APBJJlF12FVfI5PoOXJsIRIftXNypG/wFxml6HeQCbEi3XRIUK94XR1hskQK6gcwDl30kYKBVYn3zw==
X-Received: by 2002:a0c:b2d7:0:b0:635:e261:798d with SMTP id d23-20020a0cb2d7000000b00635e261798dmr1972019qvf.52.1689265673407;
        Thu, 13 Jul 2023 09:27:53 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-24-242.cust.vodafonedsl.it. [2.34.24.242])
        by smtp.gmail.com with ESMTPSA id u17-20020a0cf1d1000000b00637873ff0f3sm3206582qvl.15.2023.07.13.09.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 09:27:53 -0700 (PDT)
From:   Marco Pagani <marpagan@redhat.com>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>
Cc:     Marco Pagani <marpagan@redhat.com>, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: [PATCH v9 2/4] fpga: add an initial KUnit suite for the FPGA Bridge
Date:   Thu, 13 Jul 2023 18:27:29 +0200
Message-ID: <20230713162731.211669-3-marpagan@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230713162731.211669-1-marpagan@redhat.com>
References: <20230713162731.211669-1-marpagan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The suite tests the basic behaviors of the FPGA Bridge including
the functions that operate on a list of bridges.

Signed-off-by: Marco Pagani <marpagan@redhat.com>
Acked-by: Xu Yilun <yilun.xu@intel.com>
---
 drivers/fpga/tests/fpga-bridge-test.c | 175 ++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)
 create mode 100644 drivers/fpga/tests/fpga-bridge-test.c

diff --git a/drivers/fpga/tests/fpga-bridge-test.c b/drivers/fpga/tests/fpga-bridge-test.c
new file mode 100644
index 000000000000..1d258002cdd7
--- /dev/null
+++ b/drivers/fpga/tests/fpga-bridge-test.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit test for the FPGA Bridge
+ *
+ * Copyright (C) 2023 Red Hat, Inc.
+ *
+ * Author: Marco Pagani <marpagan@redhat.com>
+ */
+
+#include <kunit/test.h>
+#include <linux/device.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/module.h>
+#include <linux/types.h>
+
+struct bridge_stats {
+	bool enable;
+};
+
+struct bridge_ctx {
+	struct fpga_bridge *bridge;
+	struct platform_device *pdev;
+	struct bridge_stats stats;
+};
+
+static int op_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct bridge_stats *stats = bridge->priv;
+
+	stats->enable = enable;
+
+	return 0;
+}
+
+/*
+ * Fake FPGA bridge that implements only the enable_set op to track
+ * the state.
+ */
+static const struct fpga_bridge_ops fake_bridge_ops = {
+	.enable_set = op_enable_set,
+};
+
+/**
+ * register_test_bridge() - Register a fake FPGA bridge for testing.
+ * @test: KUnit test context object.
+ *
+ * Return: Context of the newly registered FPGA bridge.
+ */
+static struct bridge_ctx *register_test_bridge(struct kunit *test)
+{
+	struct bridge_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+
+	ctx->pdev = platform_device_register_simple("bridge_pdev", PLATFORM_DEVID_AUTO, NULL, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->pdev);
+
+	ctx->bridge = fpga_bridge_register(&ctx->pdev->dev, "Fake FPGA bridge", &fake_bridge_ops,
+					   &ctx->stats);
+	KUNIT_ASSERT_FALSE(test, IS_ERR_OR_NULL(ctx->bridge));
+
+	return ctx;
+}
+
+static void unregister_test_bridge(struct bridge_ctx *ctx)
+{
+	fpga_bridge_unregister(ctx->bridge);
+	platform_device_unregister(ctx->pdev);
+}
+
+static void fpga_bridge_test_get(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	struct fpga_bridge *bridge;
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_PTR_EQ(test, bridge, ctx->bridge);
+
+	bridge = fpga_bridge_get(&ctx->pdev->dev, NULL);
+	KUNIT_EXPECT_EQ(test, PTR_ERR(bridge), -EBUSY);
+
+	fpga_bridge_put(ctx->bridge);
+}
+
+static void fpga_bridge_test_toggle(struct kunit *test)
+{
+	struct bridge_ctx *ctx = test->priv;
+	int ret;
+
+	ret = fpga_bridge_disable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_FALSE(test, ctx->stats.enable);
+
+	ret = fpga_bridge_enable(ctx->bridge);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_TRUE(test, ctx->stats.enable);
+}
+
+/* Test the functions for getting and controlling a list of bridges */
+static void fpga_bridge_test_get_put_list(struct kunit *test)
+{
+	struct list_head bridge_list;
+	struct bridge_ctx *ctx_0, *ctx_1;
+	int ret;
+
+	ctx_0 = test->priv;
+	ctx_1 = register_test_bridge(test);
+
+	INIT_LIST_HEAD(&bridge_list);
+
+	/* Get bridge 0 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_0->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_0->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Get bridge 1 and add it to the list */
+	ret = fpga_bridge_get_to_list(&ctx_1->pdev->dev, NULL, &bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_PTR_EQ(test, ctx_1->bridge,
+			    list_first_entry_or_null(&bridge_list, struct fpga_bridge, node));
+
+	/* Disable an then enable both bridges from the list */
+	ret = fpga_bridges_disable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_FALSE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_FALSE(test, ctx_1->stats.enable);
+
+	ret = fpga_bridges_enable(&bridge_list);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+
+	KUNIT_EXPECT_TRUE(test, ctx_0->stats.enable);
+	KUNIT_EXPECT_TRUE(test, ctx_1->stats.enable);
+
+	/* Put and remove both bridges from the list */
+	fpga_bridges_put(&bridge_list);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&bridge_list));
+
+	unregister_test_bridge(ctx_1);
+}
+
+static int fpga_bridge_test_init(struct kunit *test)
+{
+	test->priv = register_test_bridge(test);
+
+	return 0;
+}
+
+static void fpga_bridge_test_exit(struct kunit *test)
+{
+	unregister_test_bridge(test->priv);
+}
+
+static struct kunit_case fpga_bridge_test_cases[] = {
+	KUNIT_CASE(fpga_bridge_test_get),
+	KUNIT_CASE(fpga_bridge_test_toggle),
+	KUNIT_CASE(fpga_bridge_test_get_put_list),
+	{}
+};
+
+static struct kunit_suite fpga_bridge_suite = {
+	.name = "fpga_bridge",
+	.init = fpga_bridge_test_init,
+	.exit = fpga_bridge_test_exit,
+	.test_cases = fpga_bridge_test_cases,
+};
+
+kunit_test_suite(fpga_bridge_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.41.0

