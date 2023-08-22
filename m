Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91581784AE9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 22:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHVUAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 16:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbjHVT77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 15:59:59 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748EACFF;
        Tue, 22 Aug 2023 12:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GLu5ofsCAXeEh2aoXgUn8nv2x8modcA8XArSeO75wTZI2WwLCIxVSSiPxK9bDaADcX1k0qU9KZcbYWJs7HBzJbHAa58tj1iC4+Uh+hipUUKatIg3Im8EOWHkLDjU7AMZEPELrxR+NKKOft+JXP6yWfyLBadUCnWM0sTLtl9H+wOZ6nYSkT4dbbtVOX2DMgf7KKgi+phmJw54Em3nHwbHeHvBhvGteJUpU3e24rMv1hgeQiL8sU/pP97w+Y+GgRSUfjnn4K4zJWH5lYDG4yuowXCSqPLNa4gW5cmqlGyic3y76GFMWRqYpOMD2+2J5UZkXgxUfe9nRnXztN+AFnLqzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/RGRiFfBNAKK+oxbpumZZawq7JXgfSjiDOOYXahG29E=;
 b=EJJ6j5ZpotpmRfXNRY6HiurtgDOunMX7bGe2Ac7rzdPmrdzyZIHYK0IyCaMlvYPWb5y6O/lq48J3lK5amUp6orogWjXCotWVuYkmEnFRkkTXR8giwKdiZJo62QfR/Xjb6EHBUIFQipAo6SPcrZ3cMH9iC9mJBBDuIL9vmkJ1dsfhngCNKgEjrGXxA+SLacSa0YHQ2mQtgxhz9uSuk6IIH6GyFk9lk+6RcJM9z9jDSo4GiCmM5bgCN/IGSVQUsCu09Nmn/iqjn5pPXfgkwXO1RTNO1CEThlVu/gHPlnHIoGIhAGnCAncsMZB7SNn3XNwATDV55n7xaYGzrjp+9xjEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/RGRiFfBNAKK+oxbpumZZawq7JXgfSjiDOOYXahG29E=;
 b=nCps7pvjROkCAKng3WsNu7rzL3oWjBZDyrjEl48C56tsdgrtF7kV5Ao72/jiRXBZb7qoTh1NRhCXfp19cd2vFGaNOwA1CZi/LvVzjE9STXs4GpdDc3FPJZItrx+p/IRM5HYGY2VIghtZz8LlnmYqY+nDZGA9iqOkmpaKg1f0UX3+IoyeTSCRadTxbkUAcCMpvejkaStPTZaHBuej3xaEbkzVebySjltUaJWxroaxYC7oIdt7GsPzUAqDlFYfcYlocs9Pw/HhDOZjg1MOThhDtrTIDThk6hixFmQ7lQKvkJl5oqxnjiMaV5DtLN9LD2DtKFc2BsNXkSSaFYhgwjoWvw==
Received: from CY5PR22CA0031.namprd22.prod.outlook.com (2603:10b6:930:1d::15)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 19:59:50 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::1) by CY5PR22CA0031.outlook.office365.com
 (2603:10b6:930:1d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Tue, 22 Aug 2023 19:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.15 via Frontend Transport; Tue, 22 Aug 2023 19:59:49 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Tue, 22 Aug 2023
 12:59:35 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Tue, 22 Aug 2023 12:59:34 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Tue, 22 Aug 2023 12:59:34 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v10 2/2] This commit implements the runtime PM operations to disable eMMC card clock when idle.
Date:   Tue, 22 Aug 2023 15:59:29 -0400
Message-ID: <20230822195929.168552-2-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c34d793-f699-428e-575e-08dba34a57af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jrDTVwuwzkUAws//bFgTE5La7XaQ5t483IGRkONQ0Mxf/9HzY7KcL546vVbzMTuvYFuz+vK3QgclBJlTKgChJHsmb1+3MTX6cgkeR7z2NQI9KHHRlADy3z7vA7k4GuDEUmSgnvOBg58Y+usqnnk6YOEeF/lWWP8k3j6gAulXsEe2HZdxU7kAL2CbrBfKO51OWaFHbpQFpoWupe34e6lRyKt9/slgavxwi25oyxKvD1tI/R5+9THoCpaKFMtiikvi9C+pyqygpX4x4SFtadw/OJHBQfxQtatFc7qkQ61eNGFtfCtyv+cpjMhPwYDUmO5TAJEn2ogzN6IEjhsgVvKf3syaVUkww8AMp7wifEhqyEbABYXu70R1uYQCVRWRtv156+Itl3K7nUhoZH3xlf3c9uxdadRgNzOIV2NIIS2pGWrPzqSBD2naBvINmqTQys3Ac2/9RNVrFsTP6+JV3L3aC1wU6t1oI0ZFvwxkiZFHgYl/JXZe9PJvEY4NB2cCe3cicM1tlIvOnFLe25G5m/gM6M4bRXhVxWfr5tQFzRuQZiqO9A7Idbs1TvsCvg1RWRKiSS6IbzTxkSwjadf1cAF/+8fe/foZ+WSuCjNvTkuUmsCp50vVUJ6RrNm7lSQMAs5iOUQf+P8bxW7r5OhyNfJ+yu5649yU9kJfGtMPZmKb7kP7c/LygP1kqW6qemBTuUQc3eLJJc4HT5RB6+0CxjmRThaPxpDt57hS2756zeCiH+8H09psrV/0gdr/zwBosSpm
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39860400002)(346002)(186009)(1800799009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(54906003)(70586007)(70206006)(316002)(110136005)(8936002)(8676002)(2616005)(4326008)(1076003)(40460700003)(41300700001)(7636003)(82740400003)(356005)(478600001)(36756003)(6666004)(7696005)(40480700001)(2906002)(83380400001)(86362001)(47076005)(36860700001)(336012)(426003)(5660300002)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 19:59:49.5823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c34d793-f699-428e-575e-08dba34a57af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
v9->v10:
    - Simplify the changes with pm_runtime_resume() in
      dwcmshc_suspend().
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 64 ++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index bc332a035032..3a3bae6948a8 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
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
@@ -600,6 +610,8 @@ static int dwcmshc_suspend(struct device *dev)
 	struct rk35xx_priv *rk_priv = priv->priv;
 	int ret;
 
+	pm_runtime_resume(dev);
+
 	ret = sdhci_suspend_host(host);
 	if (ret)
 		return ret;
@@ -659,7 +671,55 @@ static int dwcmshc_resume(struct device *dev)
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

