Return-Path: <linux-kernel+bounces-60879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7809F850A84
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33E1728339B
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836A85CDCD;
	Sun, 11 Feb 2024 17:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q8GVHTWg"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198335C5FE;
	Sun, 11 Feb 2024 17:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671920; cv=fail; b=KbrsCERFhnNrfkhJ2/uMwpSB+VsdmYPqf9OQdToOYk4XVCGLxqDelwGVeQoKsVGKuort+X/p67vSKfiz7pNjgM8jpV/nN4L+qXswC/zNzHhrAQHFTkS6wfcLUCK8eQyzlFyc56XAT83YznOlgdGUkvT6LgqSNBFh2avhzBqZI/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671920; c=relaxed/simple;
	bh=30YSgSNNoNq+yMHs0WYAIXa5CLC43HFXJJ3q/ku6Icc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIDg01Cwtj3dCnML5UiI6kd89jyvfmXyj8xNAHd+mhAvwk411cl4K0Lhqc1je0n8CtqrsNhXmmRttRaf0kDamloBTa29InRlmbRijtaMr7iqQ4N9tdXBDKELYQrKF71CBBBmbuGNVmNKxpEuABXaTh7tHGUb3wFws8yyiPCDNH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q8GVHTWg; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lqV2iQfHSZv2IrtJA5Zxy2VqSokctm+xWmmL7Y6cW95NiffaE4wLbzc5EjBbLFhE27DyLnAZLGdTllvSi2G5lzwiGU9Z8/dz5tfhQ5Ax3Tjpp4HaIARXBuS56Sn7mDYT5HNtLoM4KneFgK3j5ByM+PdAxuce6GlAtwWp6MxnQPstHyt1kirOdWYyHyyEj9q8ZJsKCXPFExECfTuWl9gNn1SHi00l/fobb/N0oEyxr3kKpmT+kEdMbCTkc/rIhm+o7xJHqT3TUw8a4A5YtB3lDDfDdROClvAfBbo08fJxbGZLpA+sFoGmr/KC5Oc3npczHEO5YrlvGUeJWwt/JDF8/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T25CKw4yoNxJRPj4qH1FP6xAkXLE8KmGIjCHeZ1zeNw=;
 b=S1TgwLrdSb2JTIqzKTETLL5ocMfbLtH3YuXZcUxI5uzHknIQ1eQmZHqrgW9JnZ4Kb9diI3Xd8p3hae7OxbCIm2ss8ClmMA+S4NiLt7vJp72MspZTNV3dUy+i71cpseI25lKKNqlLtxQRLKcF2CeHHJ6wZjpLLz8hLJQ199bfKSkMwmgKmToO8tZfCXHxbu9eWupq8Owj4asnwiYPt1R+59ZXOoefkLlDdw9GW3lt8p/YHcVxD++dWYPwo93hz6NavJg95bmBkShcXJUDGCTx9b1uLEBI+tbo+vRUIV3kkX1RfgU3bcLNZMRvWx3roEjJeijxDY/3uJhrsj+Dh1cyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T25CKw4yoNxJRPj4qH1FP6xAkXLE8KmGIjCHeZ1zeNw=;
 b=q8GVHTWga28WPg7WdYej/C/m13xlSFtOx7r1hZPfAMDPrIWGY3I2kUxn8ltCehbFvvbHVPqiP3zXrpoqYSzOffOc9mWwBlxWRL5NscR1nE82pvTIX7y8bcd10iN6ON6XCQZL2bdqDPvl41dR2ZZ2F4qkWMjj+0t8+DtEq8w0EH5Iq1/1Tqm+yI8nOSz+rtXis2oK2O8Oodb+JwPecplu3gjTi4pvFEtZJdXiL5IBO9Rf9z2AYn0BE223+rEeflVFXbQpSLK2Bmlq2gwtASK3ZckmZNIltAsKGM8QVODpQbcBGXU5iNhUpE6dwOKNPd8TvyLnTa97Jz88csdTYjwmSA==
Received: from CH0PR04CA0100.namprd04.prod.outlook.com (2603:10b6:610:75::15)
 by SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.23; Sun, 11 Feb
 2024 17:18:32 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::ef) by CH0PR04CA0100.outlook.office365.com
 (2603:10b6:610:75::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.37 via Frontend
 Transport; Sun, 11 Feb 2024 17:18:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 17:18:32 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 09:18:22 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 11 Feb 2024 09:18:22 -0800
Received: from build-petlozup-20240117T042503953.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Sun, 11 Feb 2024 09:18:22 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V3 3/3] soc/tegra: pmc: Update scratch as an optional aperture
Date: Sun, 11 Feb 2024 17:17:27 +0000
Message-ID: <20240211171727.914595-3-petlozup@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240211171727.914595-1-petlozup@nvidia.com>
References: <20240211171727.914595-1-petlozup@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: 371d86cc-3484-4a6e-9e42-08dc2b257913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2bKquhvJala/6kyPuMSla65bd6v4A9sR27NC+m5C6uJMJp26IhlZ4MK0Nhm03qtaow+tJMer+bpF4gABfgSU0yyjX4xQ7QCNsfj/giP7AItmUuTlrfXLYy4xJMX+ee+MeuHIwbqReHsu7QBafO3bX2xMhzEHnTPgNI6pWLAPSXigcElK9e4edl3NVgNMlDSwJpsCAoaCOtWBSD+2tYRRZtSimCwUjnG4BfoxSb64la45YtplkPMFspYl+aDL0HBFhF04KSVa3OtvEhfUC/eYAimxvQIqvpBL19JWNotKt9whRhISQGLW6uAgRjDHE9JKluIJFqM4mIoo2WCX8boX8xP1udJTT1RIMfsGfJO77HMjrDsbbEqVnmuBLwgousZidYa0zcfQZaFYK+RdcOJ/6WZqu89MnQDMb0ho4uDq2jUYoj7uX4CatWcODIorhPS/TQoEIzUXpHLCYWuhA6iFR+lnTBP1aYz2+EQCq3084v9FuXAKGSBxIfpi3IN0EGd1cl5deQVT3y0fL9xG6I6HsK1z9sefSmeeNjH6T+gyVYhMn6i8UhUnQ4QZZtzfJ0ar9xYyQXTwCgslRM/KuX4G3ITUDgSIZJ+3ihwOX44WzSzjj9fib/VVGbzKnwFbeFHH753QOcxI5GJHOCwKAcIXxg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799012)(40470700004)(36840700001)(46966006)(2906002)(426003)(336012)(2616005)(41300700001)(1076003)(107886003)(478600001)(26005)(7416002)(4326008)(5660300002)(8936002)(8676002)(70586007)(70206006)(83380400001)(921011)(36756003)(110136005)(86362001)(316002)(7636003)(356005)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 17:18:32.3474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371d86cc-3484-4a6e-9e42-08dc2b257913
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649

Scratch address space register is used to store reboot reason. For
some Tegra234 systems, the scratch space is not available to store
the reboot reason. This is because scratch region on these systems
is not accessible by the kernel as restricted by the Hypervisor.
Such systems would delist scratch aperture from PMC DT node.

Hence this change makes scratch as optional aperture and also avoids
registering reboot notifier if scratch address space isn't mapped.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 0bc983f6b088..6948f78c7a4a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2903,11 +2903,16 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 		if (IS_ERR(pmc->aotag))
 			return PTR_ERR(pmc->aotag);
 
+		/* "scratch" is an optional aperture */
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						"scratch");
-		pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
-		if (IS_ERR(pmc->scratch))
-			return PTR_ERR(pmc->scratch);
+		if (res) {
+			pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
+			if (IS_ERR(pmc->scratch))
+				return PTR_ERR(pmc->scratch);
+		} else {
+			pmc->scratch = NULL;
+		}
 	}
 
 	pmc->clk = devm_clk_get_optional(&pdev->dev, "pclk");
@@ -2919,12 +2924,15 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	 * PMC should be last resort for restarting since it soft-resets
 	 * CPU without resetting everything else.
 	 */
-	err = devm_register_reboot_notifier(&pdev->dev,
-					    &tegra_pmc_reboot_notifier);
-	if (err) {
-		dev_err(&pdev->dev, "unable to register reboot notifier, %d\n",
-			err);
-		return err;
+	if (pmc->scratch) {
+		err = devm_register_reboot_notifier(&pdev->dev,
+						    &tegra_pmc_reboot_notifier);
+		if (err) {
+			dev_err(&pdev->dev,
+				"unable to register reboot notifier, %d\n",
+				err);
+			return err;
+		}
 	}
 
 	err = devm_register_sys_off_handler(&pdev->dev,
-- 
2.34.1


