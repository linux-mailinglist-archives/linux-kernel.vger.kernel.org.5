Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8277EE87
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 03:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347416AbjHQBGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 21:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347396AbjHQBGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 21:06:39 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D77C1BE8;
        Wed, 16 Aug 2023 18:06:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P//Y1YBy0WzTstTMymh7uhXIRf5kfHhfkYJdfLZW1/QT2s7qOsrveeGGl3FDqnzBXlS7LVhws95bS3eQaf0VHrCRdm888GL9s/a3bjnMfV3X8XZGd9C1im9rKlu5BHgoFf1o/0m6TP4/cO77+U8cpiaVQK4EchNn9ij5m5a9/DngjKHU78IzLit1sUT9ThwgUu/j+WlIE0zU2uwutYpmFXKIdYeG88VawcPSQGrYASmIs1Cd8pj8AtCeFWrXwl0FZ1d5cGHA/52t7VATaG27a/aoRdpICzkHtnNPrzwfUyHnET4fLczgNrzfv812fwlyavzJ+23Oe49ud3iYChkn9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJWoXBcB0j4T8BIolxXXcbKy12r0ao87roLqdCKrq+g=;
 b=Ev1G0ZiyDTJIvC0q0zMVJmJsT3X157gmDp03VqRrg5L5aopgt06BxUnRCuWDcFpQ0Atxb8NPVvydsELGQbc+ILilNOW+1SXS+/vG0eF1yOI7kRv7xck8h7tk5azSrUKB/8DtIHNWZfcQ/gSPEo4R66nsCbadLtXaeXDJMeR/4Q0ZXeCOfFYZNWk/lSmuh1Qbe4j9ncfUyz0P9QvrOI/SrnfXDESJgKajXPS5TCZKfMs+cfBgYdG8ezD1kyn/MkwokmOPA8voAezsAx7gPTtgDkfgEbVmZYxHee04jpry7vzHxTpynuQmQAhEQDVdjNpiTbCFHxpRfdWR4lzL0WFU1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJWoXBcB0j4T8BIolxXXcbKy12r0ao87roLqdCKrq+g=;
 b=C3Ii4HOdIcOqZIjJjowrW4weNPPbxkjSQbSHcvF/lBCirQkhgqYy+XBhNiuCvB5l/+NHUwl/J0P56OaaZklOUOQZB0EZdiRvv7tAh5UHt9D4BmpL1Dq59PaX3bqRrtZPQ6+GhTKfEUUuCi/cwg8KHepKaCWTUVRe2y33gLAG5QjPqVe5heOY7INIpY4I0L0XQW7Tnl8nswWJZ4s4F/Vg1BpuRN7mrMCsSmprpc2LjO8Eu2v40JPU9rLRJ+5QRt8QncOa4FVl/UaN8UEm2ISEhb4UT0tT6/XnkInc9Pd3vBzUEWPIUKAIfEKjKk1+nSHKqBXnYRoOhH9WECG0/T/qRA==
Received: from DS7PR05CA0021.namprd05.prod.outlook.com (2603:10b6:5:3b9::26)
 by DS0PR12MB7828.namprd12.prod.outlook.com (2603:10b6:8:14b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Thu, 17 Aug
 2023 01:06:35 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::c0) by DS7PR05CA0021.outlook.office365.com
 (2603:10b6:5:3b9::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Thu, 17 Aug 2023 01:06:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.14 via Frontend Transport; Thu, 17 Aug 2023 01:06:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 16 Aug 2023
 18:06:20 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 16 Aug
 2023 18:06:20 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Wed, 16 Aug
 2023 18:06:19 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v8] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Wed, 16 Aug 2023 21:06:08 -0400
Message-ID: <20230817010608.211329-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|DS0PR12MB7828:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a88d4e-c32b-4273-d254-08db9ebe33b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y55r/5wNxlx/5HBHYxTYrtvpCcHURGwjdRaKR50uG0qCbjk+hEjV8wcPgGVgSQEfPyPnYycJC+wcssQnlP9y6ofT5u81rekT6U61xkHU5PeGw0AaPE5AE7Z4xrlpWjXoGvDiFRyRglPt3FKkCkrF+63D88it8DUB+fKiiBhnQhLw8pn9V6FGfS+GfeEb0v61nFYnx6E8cjQeURFXC/YIaXFXHhiZu/I9H0PVO50QezKxHP5AKm+tJUJfLGakKSVyrd2YgRhG6+Au9KGf3juPY2thG2TJAgKZMU0X8y/xeQNN2xLcrXw9sAddOZ9bL4NIeK1ss0bxGo5fNjJXLBZwhrYDhI8Czni2u6nR8BsPivz2EXWqp7EA3roDT2o4DGqA4OqBogFW6o5fnBjdetPHlfizIIrR+br3Mi/TPVq6den5QVdSeCwZFJhM36eNa5PafLpM8EtXo3wUYKZrSemQFsjKBt15ZnszgATh3CSbw7wiMXxKSIbwX0PhzP/N6HGgYlcYET+ZuEti5Ncf2a1zd/tkZS89sJk2Y+jHJJiHyoWrbGnyEkOaV8O5U7CXBhN/Wi574mpLZLlek6Ju5twJpXCQUBSVLQf8YjVNyVY48Oo+7Vwh/POA9dejxc+XwrhfhxmmbpLrUqdhCQrWTpgY/WcSrT/ONexrjoC5HVIt0b5J7429kZ1Ixi+nyW9a3CvTNr25dQeSLTf/BKvj67LnH/R40tGv5GZVhkWL7xPkPZ34LWkmdIP6t0PPDp3sCIsOXIDpVvfxAGoCzWNOocHjWw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(451199024)(1800799009)(186009)(82310400011)(36840700001)(46966006)(40470700004)(7636003)(316002)(110136005)(54906003)(356005)(82740400003)(70586007)(70206006)(5660300002)(41300700001)(36860700001)(47076005)(4326008)(8936002)(8676002)(26005)(2906002)(40460700003)(83380400001)(40480700001)(426003)(336012)(478600001)(86362001)(7696005)(36756003)(6666004)(1076003)(2616005)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 01:06:35.0245
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a88d4e-c32b-4273-d254-08db9ebe33b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7828
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
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
v7->v8:
    - Address Ulf's comment (option-1);
    - Updates for Adrian;s comment to remove the force_suspend/resume
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
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..2196218c9d79 100644
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
@@ -594,6 +604,10 @@ static int dwcmshc_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_PM_SLEEP
+/*
+ * Note, runtime suspend changes only SDHCI_CLOCK_CARD_EN which has no effect on
+ * system suspend.
+ */
 static int dwcmshc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -602,9 +616,11 @@ static int dwcmshc_suspend(struct device *dev)
 	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
+	pm_runtime_get_sync(dev);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
-		return ret;
+		goto err_suspend;
 
 	clk_disable_unprepare(pltfm_host->clk);
 	if (!IS_ERR(priv->bus_clk))
@@ -614,9 +630,15 @@ static int dwcmshc_suspend(struct device *dev)
 		clk_bulk_disable_unprepare(RK35xx_MAX_CLKS,
 					   rk_priv->rockchip_clks);
 
+err_suspend:
+	pm_runtime_put_noidle(dev);
 	return ret;
 }
 
+/*
+ * Note, system resume leaves SDHCI_CLOCK_INT_EN off which is consistent with
+ * either runtime suspended or runtime resumed.
+ */
 static int dwcmshc_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -646,7 +668,55 @@ static int dwcmshc_resume(struct device *dev)
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

