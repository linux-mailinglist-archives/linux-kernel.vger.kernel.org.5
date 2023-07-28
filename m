Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26DD766D27
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236238AbjG1MYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:24:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbjG1MXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:23:12 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C543F59F0;
        Fri, 28 Jul 2023 05:21:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1Ttqya420T8uExmVAIM2o1rOziqP0IasgEeP4mLQg97fLF74goMVdmqlJ7YiIM+IlyTYSxIY5qxgEk8Z4vNEkg1yLOpDqCDoppeBNoK/FbOvkWu/oZjP0DEjgF4gIx9RMPa4b6xMhVEw60WLfI9pgFs8JjTneLTNeQCbjSDXpnWRmD2hUMR7t/otexabOPKVqBNqw/i8NiQam87+cVhIrlbYtfXwpoiZQ4/lXXVSm6ZB81QqEx1r8ptDQXRX1kg4uA05MrPW852n+PWPMSykm5Sl9fqPsF7UWQCFIL1x73EZl62uQyFJMZgzHEqU3UhDY6Mgm3SaKL6V84xTkt1lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LfOSk08vwUGBSa/EB4oh60SZed4C/QKcPg7Um7FlfAE=;
 b=T5dpIsH1u/3A/wSlJXqd6V0k21s+IxrvG6RT6OOe/Rd/LjbGj2hwDcRRJJIG6W7nz0i+CPDhnGZDlQrVubVd1VviLbdlY2V8vYyYVMlj6NWeQUikL4iLNjqBi3JKS0FZpzL9jsHTsenhHLHplPpW1aRHPVyc+RkwZL7zk9toXiAO6toIcIPCh87mGep7jK3XbIkSKW8Me/8lBmuWOf8JO9MEaKvTO76oXVepOmtaY9l1bGy8iJHd+0gaJk6Ky/fBsUT/24CFP2f66XFrKRBwjSufkWGvHzbEDekJIPu7OnJTB4tMnCHR0BtAMFsMcvqEN9BeyY97+47YroWBEIMLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LfOSk08vwUGBSa/EB4oh60SZed4C/QKcPg7Um7FlfAE=;
 b=AUM+diym131+sUwrWiA0NLW1nkWbJnJ1ZoqW2kkahRRmkvXubQ/451TtoLQr5NQDL1ofJtro17AtDkBzU/YuTZlwbQCIng2FxkDI6vEPUczqoLBDTIryku03XxZvh+obV26v4u01ICpHD2elrGWfx3kdiTGrqHBsTdu7ucs9FhaX2ffgyRwyU1y36swYYkmb6yxEaWMn97jwah9YHnxeKl05WyhxuO5EnVSxziqOpBpx+25md6F+E2xnZGT47m4iNW/AOOp7xdMkUPvj0BZaN9ISXUO3Nw518x2thQAHmL5DqnDszdjhPrzGWK27qVRDTBj6pQgDLCH6Q/pUXc/mVw==
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by BY5PR12MB4968.namprd12.prod.outlook.com (2603:10b6:a03:1d2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 12:21:11 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::f7) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.34 via Frontend
 Transport; Fri, 28 Jul 2023 12:21:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 12:21:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Jul 2023
 05:20:59 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 28 Jul 2023 05:20:59 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Fri, 28 Jul 2023 05:20:58 -0700
From:   Liming Sun <limings@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Thompson <davthompson@nvidia.com>,
        Shawn Lin <shawn.lin@rock-chips.com>
CC:     Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5] mmc: sdhci-of-dwcmshc: Add runtime PM operations
Date:   Fri, 28 Jul 2023 08:20:52 -0400
Message-ID: <20230728122052.296488-1-limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
References: <79137159a833c164ea8ea3f05d8d6d9537db2f42.1683747334.git.limings@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|BY5PR12MB4968:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c8d9676-725c-4f83-3345-08db8f652121
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JL5Qxe0TC2PNKnSanHZ2Y8YFUDGFPj/LEVPHfG5tGzzxbIM4C6k5WSx1GnqifudKCvRLTyyNa4KLmuiMuXcWjcg1eB6GLgYY4gGKj2Ciqr5ReUGlOOIGyM6OkfjROlfXatiNmb9yA1nozChDuUQkejL1865WH2h3evfMT6yIZfMNgWiE9CWI35ystbRiaTbRm3mV2y664KkkzrEhw74FMfd3n8FPqGny0uDknE27VW/xKktHmJIzyV4E7d0ZBLtks7C+Trs/XLLbeeRwoK7M/7Yg4QZ8LQK5F9XbSuPRbnnUt1EH53viYvlq8/q2KSq9CRQSwcvdfRJRKON2wlh9U1FfSfViypBBHKhM4yYiYJVi2dySNQamFKhs0YH8L/zeji56cdodJLMSwAVdPcO1JyGgpd3cX49zP8MZqBqaoc8uZ9YqJziZgfZTWVJhgMtbhq+BCwrPK5NGOiY5chHtUxE1o5Zpv+Ip2dZpmLbjFlHgGRTqEZh3Oh7bk+eoCMikfOT7jjt1tNvWN/D0LmyGi88OyGYB3IbO5K9pZROf2kg9uw9deqgCVysp4TOloefYAURS+xEt+4mTCtP7wSLsLMntU9ARm53Ug5amYIX4Xo7c6X7oAh+N84d3RaWJLHVVqVG68WYiLbr+BHxUIeGxw2xOLiAA27VrzoZ5AyDaYTXzXjwijeOZUITiygIpzRzaSIokGE211uqNIlF8K3uKGje3Kp/aimDWKLaneE9Dy2AcE1Q+fUozsnX5ge/3UM9NZ3tnHPjv4M5WgCdApEcRdg==
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(82310400008)(36840700001)(46966006)(40470700004)(36860700001)(336012)(186003)(1076003)(26005)(2906002)(4326008)(316002)(40480700001)(83380400001)(36756003)(40460700003)(41300700001)(5660300002)(8676002)(8936002)(2616005)(426003)(47076005)(7696005)(6666004)(54906003)(86362001)(7636003)(478600001)(110136005)(82740400003)(70586007)(70206006)(356005)(133343001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 12:21:11.1474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8d9676-725c-4f83-3345-08db8f652121
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4968
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 54 ++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index e68cd87998c8..5cee42d72257 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/sizes.h>
 
@@ -559,6 +560,8 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	if (err)
 		goto err_setup_host;
 
+	devm_pm_runtime_enable(dev);
+
 	return 0;
 
 err_setup_host:
@@ -646,7 +649,56 @@ static int dwcmshc_resume(struct device *dev)
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
+	ctrl |= SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+
+static void dwcmshc_disable_card_clk(struct sdhci_host *host)
+{
+	u16 ctrl;
+
+	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+	ctrl &= ~SDHCI_CLOCK_CARD_EN;
+	sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
+}
+
+static int dwcmshc_runtime_suspend(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	ret = sdhci_runtime_suspend_host(host);
+	if (!ret)
+		dwcmshc_disable_card_clk(host);
+
+	return ret;
+}
+
+static int dwcmshc_runtime_resume(struct device *dev)
+{
+	struct sdhci_host *host = dev_get_drvdata(dev);
+	int ret = 0;
+
+	dwcmshc_enable_card_clk(host);
+	ret = sdhci_runtime_resume_host(host, 0);
+
+	return ret;
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

