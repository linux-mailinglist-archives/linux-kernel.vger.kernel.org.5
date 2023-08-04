Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10775770C6C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 01:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjHDXai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 19:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjHDXag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 19:30:36 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB494EDD;
        Fri,  4 Aug 2023 16:30:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzaft4xk/VDqgwyLu8cCa+q24AYh0QDc8912bkuAd3wiQFREefNxejk4lYWSpp/iCclh8Q+fR8vZdrtYUm+MxLnEV9o7CTHOiN28U8ED+RyegofJyV36KlHgJ9o2PSeOZnT9ABrE/oiaIPOlyM4wslGdHkUbKji2W6kfRB74rTICUs8UHvRVO+5KcI6jc9qz4Eu+QSYUVZgOlGzlNQlOmYgut6oxsEbgDToxIB/nHZLNXdT6OmMh2a0Gn4+7PXDUonXi9SODM+tD1zEBQzcgNAzdR3enwoGhPKngAkjbE+IeCoklZhp0VV6op73Uld8S42Dow7uVKk9U66PeyDUbRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5qilSTg5Bl3sWFaoP9ceiGU3o6O1QtR1ZoVGH03v4d0=;
 b=Wd+dYgrbvvgnNLVpsrHK4Zx7t/3pyQbETVkXLYtabIy8GdoWbtxJR9psaNlyMLA+apr/z5BoUrxIcFwpWcMebErMWisGnDz8sai4VwT7x8vui6Nnv+b0hLYn2HDOIsZ4l5+gyvqsRbwmKpRrRcFiWADFf3vJnAAW1fipKY55JziDJQISHKJyY2lYK7PKt8TE53MZBKwy6C0HTUKVOjTI8S5oBqK50h242N5HPjT1EWK2BRyVsCB6/zAWlllwKvMZZaCOMyVhBgfCXVMLkd6lOPoqbH3YvkdLNSaI8R3Vn1XElrfoo5+7/HiXy5ivGp48gHzonfaT0101IoHt6I9exQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5qilSTg5Bl3sWFaoP9ceiGU3o6O1QtR1ZoVGH03v4d0=;
 b=NxOXWci12hovxybv1hf7yEIFissiSqie7oPHdD33hbOZm17GhvMZjCmvGfOKTU3U8FCzlWO8Vip9yN0bhIFtIn0i4tIIepOuU0JP2fhQKww+cfDj4eMnx6ZzfWUgLSirrYPm94+uCYlyAuxv5Tb0iEaCGrdgjZPNdkUiPTGRLDcvUeaGjMNCO7mmNylioT4QxBgT7sVG7QNlmHeEEABO8pEvBLPfYwHRs5sA2PZoQ2yUusPE2dcHvd1i/dl5M0olJSD3JpDzflfKoj/c3oGgEkzb5KidUjAkmmu7Zb0lbr7RFw9b7tRBDg015aJQudG96NJ/afCehnrnsG6CuPDZtQ==
Received: from BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49) by
 SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 23:30:33 +0000
Received: from CO1PEPF000042AD.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::9c) by BYAPR01CA0036.outlook.office365.com
 (2603:10b6:a02:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Fri, 4 Aug 2023 23:30:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000042AD.mail.protection.outlook.com (10.167.243.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 23:30:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 16:30:19 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 4 Aug 2023 16:30:18 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 16:30:18 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v6] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Fri, 4 Aug 2023 19:30:15 -0400
Message-ID: <20230804233015.173957-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AD:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: da989d0f-0024-4ee8-8dcd-08db9542cc71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8ddVWGvHaECAQ5ViRpA9u1ULtW26HDc2MJ3ze0LLpUM6US8WHkdh3VEq9Beg5MjIGnaeEcuQHNHKMG3gz6B1+qV8Kbe7vd3qXpa7+f59yUM6QOFtRb0s7q7kvnKgkgTZNoC3DoJpG1QkKv0yiFlLD6c5oIdZHlqPOkMXwN1u+HdPgGwzMHhrPCkzRyFy0gZOHEbYOfjZL3+f3P/kAaZdhKgGkCq1nvMnazFX8TWaqlsltRt1+vQbx8YD/PmmkfZB9S7EUYLzCyziwRDWVngmQtHq9P71vFb7h78vQVatPcyv2L7Xa1P3JkSSmBRFN0nKePyKL+cAHy/NwTh3oYv+vaak2j2ZpZtCCsx9O/lg6v+2pFTKtzcWT/QNxCi0kyzommyNrjRraFIisQo01nY0j52VF6P+wA/qBynql+6cHo1ny/eY5jKpXjeI+9QB7uXsKWbMTfm+zZI1TjG4dx4+NPWU5vhZ0WQ/6QhSEt+vvivlbiypRTy8LI5D+weqmcIp8VZpQMiJ5+Y83xGSL/xBbbNYyw3sMtPLrJVaqsQ/R36pQvUze+bVDhQlwzjbIExMp4ULil1dmqqL71XjQrV1EIWiqiN6mz8K5WTAUGLrMhWlnF9pDYgo6ArDcUaVhIxoNp9398KBczkhcOL2ZflDRCi1QhEHrvGB4wj8TVmQsgqqS3O4W2Uv09kmLebRmVG5jh6oN9RpYihY0Fe/qLvy2KSj7xQexQlqW1TNrqC4yBwMJEhf3qRpWNNi4gVLJYNzg+6VaMeBl8rEG+iHlEZh3Q==
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(376002)(136003)(186006)(1800799003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(2906002)(5660300002)(8676002)(83380400001)(36860700001)(47076005)(41300700001)(70206006)(8936002)(70586007)(4326008)(316002)(6666004)(36756003)(40480700001)(7696005)(54906003)(478600001)(110136005)(86362001)(2616005)(426003)(336012)(356005)(26005)(7636003)(40460700003)(1076003)(82740400003)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 23:30:33.2493
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da989d0f-0024-4ee8-8dcd-08db9542cc71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..aaf66358f626 100644
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
 
+	pm_runtime_put_sync(dev);
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
@@ -606,6 +616,12 @@ static int dwcmshc_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		sdhci_resume_host(host);
+		return ret;
+	}
+
 	clk_disable_unprepare(pltfm_host->clk);
 	if (!IS_ERR(priv->bus_clk))
 		clk_disable_unprepare(priv->bus_clk);
@@ -625,6 +641,10 @@ static int dwcmshc_resume(struct device *dev)
 	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
 	ret = clk_prepare_enable(pltfm_host->clk);
 	if (ret)
 		return ret;
@@ -646,7 +666,55 @@ static int dwcmshc_resume(struct device *dev)
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

