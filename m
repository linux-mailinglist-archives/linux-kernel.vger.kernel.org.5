Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35B6D774B68
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbjHHUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbjHHUqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:46:09 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2043.outbound.protection.outlook.com [40.107.220.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8B5230FB;
        Tue,  8 Aug 2023 13:23:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GzUvgXlkO0gjf4iuT/sygxfvbjZWLoIN1KoLeh9v3qhTQ3JsnDyqSg4sBZpNcY7siAfzbJsRZEsGuHnyVanfnx8OJNiEuquoliChYPhHTC7WiOoVqiQ8lFG0hVg17Z4zRhwDtfLYbBKvjgAgT4hia/3/fgg3zoHeRQgVb0ZJISYfaSltMIk4ST5CNHhPpK3s4KGtQ7/YsIosNhsA2am+I+QoCqL7pV7Em9hB2wSOnOA32ByNLJhCxgF9xuFd5YHRyyqCTT7mP2yuSlMbqjqGvMVlI6cSNSzRgCd8wxiKPXf9FmzBTvyeZFbllBifvllcxzQfrtokeG7P0hVkZ1audw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLtFUsa8gNlv9ErnjBebs4iAwHDD1smXr7IryL+Swk0=;
 b=aYFtLHkCTP6RruX2lLpWmPCrnSNB9RTo2Aak8yr/JimDC5GUUUzoh98uellXtrvW1yZKo6NFsFSxy/K6QsTP+y/dtSQ6QXjQ0AzpeTWANnnEhsZp0mg/ziAZkbT69+Sz/xDPqZbBjhbfEo/XdlzMVGJar1HrAu/0BlHpxEsE2vdwPnTEFdQgb1sAYWjv4rYqG2vNrZtikVxVje3wCsdjJkbwL/uVnB/szS7arAucAxF0obdywMaj++YHHLmgcHVmdZ+0Q1Ty6C340rHQGE5NbHkJV/pYLpvsrtFUDRO+AzTTyliXtdz/41QwFHINKyDcOZ28BL+LvPmIyeVO4RYxkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLtFUsa8gNlv9ErnjBebs4iAwHDD1smXr7IryL+Swk0=;
 b=GugAv6jN6kgUcpT4f+dKkW1o9nSRHLL58C0pgjtjDOKFZqqFtl45dq2PmldTnYK1NHtvEgGcw3jMGuRRt9sD0b2xpqiEwI1zEpm4aP5QibmtW/1bWiNZ10nWhvgwSOC5gYj/2YsYdt7t/Ksm7IZGR18l8CItSW8j27OqbWE23xBt5+pVakp5bEjeFWsOGvHRiFmeLG27OwnG3spa00iKVafHarf0iJfbjPoecQxy66bbNYa/06EyxDcWWVP8yQ0fi++UgxSUmNJ4djCdeL7M67ChmGjR5iHjZOHlQFxy7yK/kDZnPrAwcoJ+rG4TaQ+Bh2Y+6GrwiTBdJaMkNzsjIQ==
Received: from PH0PR07CA0059.namprd07.prod.outlook.com (2603:10b6:510:e::34)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:23:38 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:510:e:cafe::ed) by PH0PR07CA0059.outlook.office365.com
 (2603:10b6:510:e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 20:23:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 20:23:37 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 8 Aug 2023
 13:23:26 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Tue, 8 Aug 2023
 13:23:25 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.986.37 via Frontend Transport; Tue, 8 Aug
 2023 13:23:24 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v7] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Tue, 8 Aug 2023 16:23:19 -0400
Message-ID: <20230808202319.191434-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 46aa0629-32c2-4175-b1fb-08db984d58f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 49FnR0HuJdcbVJh3ilTnpZY4HjUD/BcNSugsIvHiDyoGlEWtOmr7MVCZbpASo/Z4IWepgAzAAEXP7IZzYB19MEauROv5tKl6+Ik610e1Lsi1nzbklvInsaMqfkZteMqUcFMZ/LZTlr47ryuOMzr1LcwpDysVZZJIXHQ7H1efZhui7QwYqNMwcEQPtWl5mn91cI6mOJLRRzWRaEkynl0jeRwgnCtjkN0mVys1IKAn8HEM2C5Yo9AOgCqmKJaCuGvNSs6Ip54hVh7C1u5xMo1qUuKFTMkieHWNh1osmtnDh9yVlAzjPWdqtYazuYEz2wgS0uFymJtj6mca1WhuVvFokoe4TFVm5eYqdm9qRxQ2281djkWvIogHNJw321b7fQJTTZ17X4sJ9RipZiKrzLn2eYy3RIXod2T25mvvSP4GyxdQ/eVYazLsmvPtuprj9pYxd/cOgl+2zsDypdZyNJQksR49WixQSJG3m3oSLElUjro2CqXF4OAtrKNZ3IoQaYlEsAUAt1m+C/dsYnk6RxwA8AxAsGtjB2gsA9U41XNYQKHpqw42BPpZWl8rtRRfeFi90mcSrokPDQlZaMuPrj+hXE+ilI5KymCq8ZrYBluiCGzkL3N9uE+I3bvpXCto1GgShECPSTAFRRmgsyugKKyWVhL7pGAmFcJdJztdHJZRvOv5ojxdfRibPTjH1VnywynYxRgz53i02eMWHwX64RUe10u9OvNK+T8YbBGEV5K0T3zRspUWDvC0Fyusnnk6qjMcPrFmSMsmKvrz1EwgaSKHyQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(396003)(136003)(1800799003)(186006)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(2616005)(36756003)(26005)(1076003)(7696005)(6666004)(478600001)(356005)(7636003)(110136005)(82740400003)(54906003)(336012)(70586007)(70206006)(4326008)(316002)(41300700001)(426003)(8676002)(5660300002)(8936002)(40460700003)(2906002)(36860700001)(83380400001)(86362001)(47076005)(40480700001)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:23:37.3945
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46aa0629-32c2-4175-b1fb-08db984d58f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 72 ++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..c8e145031429 100644
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

