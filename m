Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A297BC25C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233823AbjJFWqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233835AbjJFWql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:46:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201E1FF;
        Fri,  6 Oct 2023 15:46:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1872C433C7;
        Fri,  6 Oct 2023 22:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632398;
        bh=6B0cZHMB1exiAQqLY9icWVKtCsobM8n83RegPN7tJS0=;
        h=From:To:Cc:Subject:Date:From;
        b=FQFvh+XaByAhOzqc8MS8PydtwxcGlF7exql8HYT9JrpgZh+e0DFwoFHmota1Vu3Z0
         NC6E9g0qBXKR+t6qTJRW77IGasRu8VTkBoJSex+BSPcycJnUY8ebz0t2A2mLDgGzFM
         5KdIgtc+eDCeR7pSS7SaHyVeXdFOsp3l12mUwRxKHHvoySGHGF21PlKteqhy/2PHGm
         XwVOnjeKviJ6tSdYPh5sq7OrZDPydwDZID2n2gjOX9mvRwH2moB/z4jWmCks1kbwre
         NuUN4vX5bjauFFjQ8BdlftPIXJIU5CO8s7XgOcpiI6No8W0BPnYIrcuUdj77xZydcX
         KzGQO1mDcnmqg==
Received: (nullmailer pid 445128 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
        Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@amd.com>
Cc:     linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] fpga: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:33 -0500
Message-Id: <20231006224633.445035-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/fpga/altera-hps2fpga.c     | 12 +++---------
 drivers/fpga/xilinx-pr-decoupler.c | 15 ++++-----------
 2 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/fpga/altera-hps2fpga.c b/drivers/fpga/altera-hps2fpga.c
index aa758426c22b..578663503297 100644
--- a/drivers/fpga/altera-hps2fpga.c
+++ b/drivers/fpga/altera-hps2fpga.c
@@ -24,7 +24,8 @@
 #include <linux/kernel.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
@@ -127,18 +128,11 @@ static int alt_fpga_bridge_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct altera_hps2fpga_data *priv;
-	const struct of_device_id *of_id;
 	struct fpga_bridge *br;
 	u32 enable;
 	int ret;
 
-	of_id = of_match_device(altera_fpga_of_match, dev);
-	if (!of_id) {
-		dev_err(dev, "failed to match device\n");
-		return -ENODEV;
-	}
-
-	priv = (struct altera_hps2fpga_data *)of_id->data;
+	priv = (struct altera_hps2fpga_data *)device_get_match_data(dev);
 
 	priv->bridge_reset = of_reset_control_get_exclusive_by_index(dev->of_node,
 								     0);
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 208d9560f56d..0c012d0f616d 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -10,8 +10,10 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
-#include <linux/of_device.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/fpga/fpga-bridge.h>
 
 #define CTRL_CMD_DECOUPLE	BIT(0)
@@ -81,7 +83,6 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
 
-#ifdef CONFIG_OF
 static const struct xlnx_config_data decoupler_config = {
 	.name = "Xilinx PR Decoupler",
 };
@@ -100,11 +101,9 @@ static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
 	{},
 };
 MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
-#endif
 
 static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 {
-	struct device_node *np = pdev->dev.of_node;
 	struct xlnx_pr_decoupler_data *priv;
 	struct fpga_bridge *br;
 	int err;
@@ -113,13 +112,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	if (np) {
-		const struct of_device_id *match;
-
-		match = of_match_node(xlnx_pr_decoupler_of_match, np);
-		if (match && match->data)
-			priv->ipconfig = match->data;
-	}
+	priv->ipconfig = device_get_match_data(&pdev->dev);
 
 	priv->io_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->io_base))
-- 
2.40.1

