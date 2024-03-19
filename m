Return-Path: <linux-kernel+bounces-107819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC64880218
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 797B4B22CC4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17BA4839E5;
	Tue, 19 Mar 2024 16:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d8ni1KDF"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2044.outbound.protection.outlook.com [40.107.101.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814682D74;
	Tue, 19 Mar 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865013; cv=fail; b=llsQpAnjwMc4bj0Rfcm0m97pZGsa02R0E27lu9IqJ0By42Y94wJk8IC/boK2DgwRfGhGoV3G95ePf+ERkSFukwDNevVewuzBtOOpox/3EMfxEo/1CkezP7k8AoFwx8f+to2NDnPdRc1NcKNNgVaO64G17PWNTn4AFmUskiHQyIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865013; c=relaxed/simple;
	bh=43sJFie43S8D0F/Xmv1X8e9Z+qR00SSOtEb9dyssnSQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b6mILMY4PMsvKPUd8noVzqv/QTBiiyHysMo0Fpr/kOjHZPgPOGSozrhERLtRWJp06JLCJMLJvBQNSdVD4LL532e3GRuLbKYTR6ZqBUXD8/1mPV/sK1FISVqthKLdX/souFfFaZwfPHMRYuGZQeQJe9iwf3JLy5YxbVjwXQ9z+Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=d8ni1KDF; arc=fail smtp.client-ip=40.107.101.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgNZBRUJAQ5i1kG0V1idL40cUTU/7SwSVjM55Gl+QNWMtutEf9unS6cJzUPXZs8f1xCeie1pu5g8DPgCpUq3/NPFugKpGKnyelHU7cZOw0LY0rqSisj2CP20gjfN0mB3E/qcXuPUH/2mpPiUVcH29pLT3pJsWUwE6XuJSKEfo6pVRWCxSMjXKkN5fP5lbypgaGj7Axo5Pf5n6wSXvkXrBvdlD0yjwi9dBdh9E19nOCdAJcG0gMS3VXkslbMQpk/JbP99MiS9KxvvSdOYHE2fpb75vrVBoMCKuT6PlnlE6zyVE6lWgK5mzGxGAfyT/H2z8YcgvdOdOcGoqUDFp31ijg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cy8U6Tz3rji2F1uzA/ahnRewaaihw/iY/A/yyQGB9JY=;
 b=n8ZIi32hF1xoC1pZGvLRc0/NbXRugkz53riWysXp385Oti47NFhAQd+AN7/9+xzOwtZ1Y+reOpO2jT3ekUK149vxNDAxIe9lFmQcGcah7lrS5S9GZ0eoQF+7+LtbJNxRv8UnOrlslGG4TcdOkdsLONCENAie2pc4wsfepp8csZfNvPSMaugNrdvSYw4yN9jNY8LopPWgysYqQjKSFUuf8m00qn8VVwUweSXj5iVZykPebZtEcdrtrVl0RCeoCPypxi3zqvCZwPIeCCQqdDs8PUwD0th5UpnSzhUDrYp/3hXp9/xErRZToTb3uzvkEF2cvtoq8BTTyqlusJsVAe8n0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cy8U6Tz3rji2F1uzA/ahnRewaaihw/iY/A/yyQGB9JY=;
 b=d8ni1KDFcB4j5XCePU2Ixkilw933Aw7PmjaynFEU1JEWCyOINTXvgeBxw29C3ruGNjG+SAnC28fl2z11O0xkTr5IM47SKbHM3uRp1DyZTDNXeAdepFxQUNxZMlQl8c0K/vcV0b5hI7dq2twvoHdDWstkX1L4B0UsqpF/xtc/MEFiumqc/sXEH42bj2bHCj096lZvhHs2lK9fqlJci01IHuJ9rpmNRCLm93gl++sVUHqGp1qv2Ap0wnmkbFYTrHvDPTYf12gsFNv0Y9f74ngjcknT/KlFdQW8YPBBGuu9g6mYAFnCHabjLZ5FiMbWNCfxABDeywip0E79HYFwizuvuw==
Received: from PH2PEPF00003849.namprd17.prod.outlook.com (2603:10b6:518:1::66)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 16:16:46 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2a01:111:f403:f910::) by PH2PEPF00003849.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26 via Frontend
 Transport; Tue, 19 Mar 2024 16:16:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 16:16:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 19 Mar
 2024 09:16:23 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 19 Mar
 2024 09:16:22 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 19
 Mar 2024 09:16:21 -0700
From: Liming Sun <limings@nvidia.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, David Thompson <davthompson@nvidia.com>, Shawn Lin
	<shawn.lin@rock-chips.com>
CC: Liming Sun <limings@nvidia.com>, <linux-mmc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/1] sdhci-of-dwcmshc: disable PM runtime in dwcmshc_remove()
Date: Tue, 19 Mar 2024 12:16:16 -0400
Message-ID: <b9155963ffb12d18375002bf9ac9a3f98b727fc8.1710854108.git.limings@nvidia.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 624b1095-43bd-41c5-5eae-08dc482ff846
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fJwz4DMw37NmQkz/wuEeK4D2ggshEkPFDzmtc1vLzH/KZWB9gIqi1ZA/nIRbSZEuDW0ZGwbccl5zA34rwXb7xxOvbqXUL9FylLWalkJZVlswsSGWBwWvRl7WfRkA1WNznLnQ/VP7w2dHL1Z3cj8seuzvksszC79jxoVnt4BcIUPr3us/zBEByrcWeacubYEVPD7T+iftQ9UgMmvhURKFTIWHTTSauZ//q51ZEfQfELc1NfDJYMTs05UDbUTriUYZOy1B0bnvAiU2KVGji2AQyIuOJIAqAN3fptGavh0SDJSKGx4kBv1F/kjhuIQX2x12lgAsrZtEJTERQ2RwQtpW6d+qSGoaHsN9QngDUWVrUf7afFrbEkeKwJ27Vuq75QH0xMXtx2Sk31xWu7eq9UALlJFsXhQVExz3UTuDmOy+jq+6ZWjeABAEKipFfzvg17OzcyVrakYJu1KXenflEt7lrzaW30NbT8ON4GFc2dJf4rcxoCOxYQPoLUpQj0W1vwtCzujt+YWCA7y7E9SY6jMTDq3QWAm8Ni5g90CshhT0tApDrKBtsaPHH6PdI0CkU4RaD7BeHsTiIYCDu2zgmotK9hbOGwJt62J2rjiRse9pTtbteaAZ7cQ8K3gggENTNWi39B76sywVMdI9NFikEI+a/XBtNUfEcM9ZEyXoKuM/IGZobSyIQGgKis3lwGks51BkedfSfMd1La7h9PAW+prjPwuMNyOGy4MQmPmwtt3DP2eITA39c519cFE6vXqWDzvo
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 16:16:44.4698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 624b1095-43bd-41c5-5eae-08dc482ff846
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176

This commit disables PM runtime in dwcmshc_remove() to avoid the
error message below when reloading the sdhci-of-dwcmshc.ko

  sdhci-dwcmshc MLNXBF30:00: Unbalanced pm_runtime_enable!

Fixes: 48fe8fadbe5e ("mmc: sdhci-of-dwcmshc: Add runtime PM operations")
Reviewed-by: David Thompson <davthompson@nvidia.com>
Signed-off-by: Liming Sun <limings@nvidia.com>
---
 drivers/mmc/host/sdhci-of-dwcmshc.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ab4b964d4058..1d8f5a76096a 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -999,6 +999,17 @@ static int dwcmshc_probe(struct platform_device *pdev)
 	return err;
 }
 
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
 static void dwcmshc_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
@@ -1006,8 +1017,14 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	struct dwcmshc_priv *priv = sdhci_pltfm_priv(pltfm_host);
 	struct rk35xx_priv *rk_priv = priv->priv;
 
+	pm_runtime_get_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
 	sdhci_remove_host(host, 0);
 
+	dwcmshc_disable_card_clk(host);
+
 	clk_disable_unprepare(pltfm_host->clk);
 	clk_disable_unprepare(priv->bus_clk);
 	if (rk_priv)
@@ -1099,17 +1116,6 @@ static void dwcmshc_enable_card_clk(struct sdhci_host *host)
 	}
 }
 
-static void dwcmshc_disable_card_clk(struct sdhci_host *host)
-{
-	u16 ctrl;
-
-	ctrl = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
-	if (ctrl & SDHCI_CLOCK_CARD_EN) {
-		ctrl &= ~SDHCI_CLOCK_CARD_EN;
-		sdhci_writew(host, ctrl, SDHCI_CLOCK_CONTROL);
-	}
-}
-
 static int dwcmshc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
-- 
2.30.1


