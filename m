Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C7E77FBFC
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 18:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353694AbjHQQWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 12:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353678AbjHQQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 12:22:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DCF173F;
        Thu, 17 Aug 2023 09:22:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hk3BaxTw8MAGrklmnJ2Kbdy76hZi2ZR0xvqq6TNXhy4hVPGyy0J6hVMQz0zpe4B5BcoIsTtyNz2RTRX8de/Pm5KT72GAIhyAGueAdJpFhROZcA7UVHLMYyCAYvjsSRkLbwpcr4hJ2TfGmgHGEFwsmXXcA/cxZ2sYK33uTi75S96k61wskPlyHhH9SJgmToJsOma7tBdINke2f0ZvG4JETyn8vE2djYnycFuhJyKBgzt3/VbWKSnEtM9qwS5t+ujBdcRfw2tHrGlNWkjBvy9KfzOdZqIS5TA1nP1VE692zfgf1sqjHLw98kSow99zMgCuhiOESJPs4ILP6NeQZSNNQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cDBQ2pomVxBkBdTBrk2BWYgBQ6S+N0dH83Rww5va224=;
 b=lPsSpZs5TgRe8U5pYzfHzd+RNEunFwlA7LJB2wYa+6QEb9tSir3HrcHe3oRnafokUcUyi+Zc9IQyIcbRDBLvDuA7VCr4DJGdEiBAKEgYXZmA3VDtRb+aJ50GneuVl8dH2rv6S/iYwUgqQt1pRW5SUEEU4ffaBnD6RWoUzagpD/MEKeLoL6ATtEhOV1bNmQtPF2DFVGzxMxHXLhIcfwNMrH0fXaeTcr2t2/j8JfDkOAhuS3hYWpvNiXDEUrXrP4UgNZgxQ9i4WRnmT6Vn9Xty47kVKkBgCYniaDBk9ZeqCKer1qVxX6Hq6Ll938HuL55lv/zmmq7FozzdndHK7+DDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cDBQ2pomVxBkBdTBrk2BWYgBQ6S+N0dH83Rww5va224=;
 b=cQyyJRMChb1zk1TM/95m158WChHgjoOK/mZzdiUDZqTtRceoFS18jT0G7LbJQ2GdZmQyZThDMdOZUHXphpKAhWKrHXDvmGpbANap0ASkzM7dAIkAjQoJDDGb7j0PwEyTsqGRF7oVL/qIOPBbaIExj0sy+8Kq0phZrq3RgagEe3xSbUygvXKbmsG+Cmq1i58g1O770/0VkbYN7exdXM2ysaRL/mebE9lcxg34EreSqXTfxwdoksinLMcyEqbNwi9KhENVxPi/JFs/hB6ek1JWUSGw7N9ywdGftdnqJ2TsymUHQUHEMJARkmcDeu31y8u5s/I34Vca/YCm4e2XgsB06A==
Received: from CY5PR19CA0119.namprd19.prod.outlook.com (2603:10b6:930:64::13)
 by LV3PR12MB9117.namprd12.prod.outlook.com (2603:10b6:408:195::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 16:22:21 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:930:64:cafe::9c) by CY5PR19CA0119.outlook.office365.com
 (2603:10b6:930:64::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Thu, 17 Aug 2023 16:22:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.209) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 16:22:20 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Thu, 17 Aug 2023
 09:22:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Thu, 17 Aug
 2023 09:22:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Thu, 17 Aug
 2023 09:22:05 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Thu, 17 Aug 2023 12:21:59 -0400
Message-ID: <20230817162159.242087-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|LV3PR12MB9117:EE_
X-MS-Office365-Filtering-Correlation-Id: c4b4b2c4-7d6e-4162-aff1-08db9f3e21bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s9vuI94qsKd7AUhUtAqzGEa47x1GiSjalzvI7UkKcZkvj3EanYgPwWgEdk+CZ1oYmt/+IuRgDeUMgjl1g11jU5qDs8Ybw83U2grwneO7Xblqla+EhV9eAF7WZCBf1/SBVD5/2M1th8VBkp/T1MhheYVe5Vl2CtkvstgyyX56MLEG7CUNH1Uk3OSfWKo0dcS2pTE3lHMZl23/1h0CjZgp+vIJUtZMieYN1ZsbGU9Prvpf1IwxgVAsx7B0eqBWymYbqEZ2e/JfRQWG3huH8qHWxs+Brgyzi98GrtrK13ZMO0PhPBzAftnPukA5ijIUTUYcZfjstj1tmnaqlXwIgAnaMQr/9SBScdXDpaSw/nRdDwRoj4N6S6gpLtMn0mUt7R2jXcjjanIpUQfAq0T5V9xi5amNx1FtztQr34cMEPAfVBwKreSzwpt/0Xn7X5wtnc0gggsIg6goLe6gKpQXO0R1rgQXwB3J9B5MrxCky/60MJeOfAhs2tNtRUXz8++b8ySYI7tjz2Ucm0KoWA8kYdGmYyXI0TCDqLuCyrNXJLIz+PNtw+k7aQ3AKPZygL4aidgVPZdEXT4d0AMKG81ZNRvA608iXXS1LxkdBXbbpp3j45LMIduki9LfG2NiP6Qr9xZPZ8wRuHQQ1ezqCcP3nwaPi9ISitMclYflUfWewZKeHLdo9Y6hhVnOzEVkbrd5nSco3uydCQyU48qvM+yQ4l7LttJk4jZ4Rkz3ASucomr0MsridJ0AZwFtWDZyP4SVyaaMe3QXC060/GKdKoW4qP1Vpg==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(83380400001)(426003)(336012)(36860700001)(47076005)(478600001)(70586007)(70206006)(7696005)(54906003)(316002)(6666004)(110136005)(5660300002)(2616005)(1076003)(26005)(4326008)(8936002)(8676002)(41300700001)(86362001)(36756003)(7636003)(82740400003)(356005)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 16:22:20.4388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4b4b2c4-7d6e-4162-aff1-08db9f3e21bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9117
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit implements the runtime PM operations to disable eMMC
card clock when idle.

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v8->v9:
    - Address Adrian's comment to do the pm_runtime_put() in
      dwcmshc_resume() instead; Error path changes not included yet.
v7->v8:
    - Address Ulf's comment (option-1);
    - Updates for Adrian's comment to remove the force_suspend/resume
      in dwcmshc_resume()/dwcmshc_suspend(); Add comments for
      dwcmshc_resume()/dwcmshc_suspend();
v6->v7:
    - Address Ulf's comment;
v5->v6:
    - Address Adrian's more comments and add coordination between
      runtime PM and system PM;
v4->v5:
    - Address Adrian's comment to move the pm_enable to the end to
      avoid race;
v3->v4:
    - Fix compiling reported by 'kernel test robot';
v2->v3:
    - Revise the commit message;
v1->v2:
    Updates for comments from Ulf:
    - Make the runtime PM logic generic for sdhci-of-dwcmshc;
v1: Initial version.
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 76 +++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..3b40f55ce2a4 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 
@@ -548,9 +549,13 @@ static int dwcmshc_probe(struct platform_device *pdev)
 
 	host->mmc->caps |= MMC_CAP_WAIT_WHILE_BUSY;
 
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
 	err = sdhci_setup_host(host);
 	if (err)
-		goto err_clk;
+		goto err_rpm;
 
 	if (rk_priv)
 		dwcmshc_rk35xx_postinit(host, priv);
@@ -559,10 +564,15 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_setup_host;
 
+	pm_runtime_put(dev);
+
 	return 0;
 
 err_setup_host:
 	sdhci_cleanup_host(host);
+err_rpm:
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
 err_clk:
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
@@ -602,9 +612,13 @@ static int dwcmshc_suspend(struct device *dev)
 	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
+	pm_runtime_get_sync(dev);
+
 	ret = sdhci_suspend_host(host);
-	if (ret)
+	if (ret) {
+		pm_runtime_put(dev);
 		return ret;
+	}
 
 	clk_disable_unprepare(pltfm_host->clk);
 	if (!IS_ERR(priv->bus_clk))
@@ -642,11 +656,65 @@ static int dwcmshc_resume(struct device *dev)
 			return ret;
 	}
 
-	return sdhci_resume_host(host);
+	ret = sdhci_resume_host(host);
+	if (ret)
+		return ret;
+
+	pm_runtime_put(dev);
+
+	return 0;
 }
 #endif
 
-static SIMPLE_DEV_PM_OPS(dwcmshc_pmops, dwcmshc_suspend, dwcmshc_resume);
+#ifdef CONFIG_PM
+
+static void dwcmshc_enable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if ((ctrl & SDHCI_CLOCK_INT_EN) && !(ctrl & SDHCI_CLOCK_CARD_EN)) {
+		ctrl |= SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	if (ctrl & SDHCI_CLOCK_CARD_EN) {
+		ctrl &= ~SDHCI_CLOCK_CARD_EN;
+		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+	}
+}
+
+static int dwcmshc_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	dwcmshc_disable_card_clk(host);
+
+	return 0;
+}
+
+static int dwcmshc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+
+	dwcmshc_enable_card_clk(host);
+
+	return 0;
+}
+
+#endif
+
+static const struct dev_pm_ops dwcmshc_pmops = {
+	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
+	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
+			   dwcmshc_runtime_resume, NULL)
+};
 
 static struct platform_driver sdhci_dwcmshc_driver = {
 	.driver	= {
-- 
2.30.1

