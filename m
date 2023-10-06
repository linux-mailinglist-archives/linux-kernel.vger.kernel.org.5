Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728297BC25A
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbjJFWq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233805AbjJFWq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:46:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6709F;
        Fri,  6 Oct 2023 15:46:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410B4C433C7;
        Fri,  6 Oct 2023 22:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632384;
        bh=D9nd/T1QbYtvFd+kC/X4Q1OtVD/3HpjeGmA8YdjLW20=;
        h=From:To:Cc:Subject:Date:From;
        b=KtoakUqVnLPmvv9T3lObN9A7LSeFB/+nVzId9ubHHKSxu5dzFdCX/fZIwudFomtab
         zKfMsWQ8ZcdmzjLPMZFgSqyd07i2NV/Tc/ZciZHlT1AEFQksLdF6Mn3bIixUJoBHrY
         WeTd7S0mG2NKVP5AXzWq+8h8A5dvX6XuXURf/jzHTJawtLHFZHScfhX14yPfkD8wca
         /FdOmgH9BsCADIKWJ2Tn9JWol1p2PeKFNZ0vW6VsYPnGFeTe3/iwFB+wQo4HCmAuQ0
         +wOJgRcBNTCcYwploTNibIIoOoyLQ4cZprvyIgF9XxRbJr1mYxFwqthoUH1PaJk1se
         kjGrOJN+W0QuQ==
Received: (nullmailer pid 444811 invoked by uid 1000);
        Fri, 06 Oct 2023 22:46:22 -0000
From:   Rob Herring <robh@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] pmdomain: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:46:13 -0500
Message-Id: <20231006224614.444488-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/pmdomain/actions/owl-sps.c     | 16 +++++-----------
 drivers/pmdomain/imx/gpc.c             |  7 +++----
 drivers/pmdomain/rockchip/pm-domains.c | 13 ++++---------
 3 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/pmdomain/actions/owl-sps.c b/drivers/pmdomain/actions/owl-sps.c
index 73a9e0bb7e8e..3a586d1f3256 100644
--- a/drivers/pmdomain/actions/owl-sps.c
+++ b/drivers/pmdomain/actions/owl-sps.c
@@ -8,8 +8,10 @@
  * Copyright (c) 2017 Andreas Färber
  */
 
+#include <linux/mod_devicetable.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/pm_domain.h>
 #include <linux/soc/actions/owl-sps.h>
 #include <dt-bindings/power/owl-s500-powergate.h>
@@ -96,24 +98,16 @@ static int owl_sps_init_domain(struct owl_sps *sps, int index)
 
 static int owl_sps_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	const struct owl_sps_info *sps_info;
 	struct owl_sps *sps;
 	int i, ret;
 
-	if (!pdev->dev.of_node) {
-		dev_err(&pdev->dev, "no device node\n");
-		return -ENODEV;
-	}
-
-	match = of_match_device(pdev->dev.driver->of_match_table, &pdev->dev);
-	if (!match || !match->data) {
+	sps_info = device_get_match_data(&pdev->dev);
+	if (!sps_info) {
 		dev_err(&pdev->dev, "unknown compatible or missing data\n");
 		return -EINVAL;
 	}
 
-	sps_info = match->data;
-
 	sps = devm_kzalloc(&pdev->dev,
 			   struct_size(sps, domains, sps_info->num_domains),
 			   GFP_KERNEL);
diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
index 90a8b2c0676f..114f44ca07dd 100644
--- a/drivers/pmdomain/imx/gpc.c
+++ b/drivers/pmdomain/imx/gpc.c
@@ -7,9 +7,10 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 
@@ -403,9 +404,7 @@ static int imx_gpc_old_dt_init(struct device *dev, struct regmap *regmap,
 
 static int imx_gpc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id =
-			of_match_device(imx_gpc_dt_ids, &pdev->dev);
-	const struct imx_gpc_dt_data *of_id_data = of_id->data;
+	const struct imx_gpc_dt_data *of_id_data = device_get_match_data(&pdev->dev);
 	struct device_node *pgc_node;
 	struct regmap *regmap;
 	void __iomem *base;
diff --git a/drivers/pmdomain/rockchip/pm-domains.c b/drivers/pmdomain/rockchip/pm-domains.c
index d5d3ecb38283..9b76b62869d0 100644
--- a/drivers/pmdomain/rockchip/pm-domains.c
+++ b/drivers/pmdomain/rockchip/pm-domains.c
@@ -9,11 +9,13 @@
 #include <linux/iopoll.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/pm_clock.h>
 #include <linux/pm_domain.h>
+#include <linux/property.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/of_clk.h>
-#include <linux/of_platform.h>
 #include <linux/clk.h>
 #include <linux/regmap.h>
 #include <linux/mfd/syscon.h>
@@ -857,7 +859,6 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 	struct device_node *node;
 	struct device *parent;
 	struct rockchip_pmu *pmu;
-	const struct of_device_id *match;
 	const struct rockchip_pmu_info *pmu_info;
 	int error;
 
@@ -866,13 +867,7 @@ static int rockchip_pm_domain_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "missing pmu data\n");
-		return -EINVAL;
-	}
-
-	pmu_info = match->data;
+	pmu_info = device_get_match_data(dev);
 
 	pmu = devm_kzalloc(dev,
 			   struct_size(pmu, domains, pmu_info->num_domains),
-- 
2.40.1

