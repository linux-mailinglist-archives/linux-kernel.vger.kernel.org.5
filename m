Return-Path: <linux-kernel+bounces-60877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B46850A7D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 18:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD7D2283248
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 17:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206FB5C907;
	Sun, 11 Feb 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IFTrqQjW"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C6695C8E8;
	Sun, 11 Feb 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707671874; cv=fail; b=OQ4a9hfxwqL/cjB8dOBGRtwgDyEWYfme96UhX4jzCfXzCATKfBTYB/CXEVClwMcsH/9wHLk9pUZCF0jHTXU0odm9DhBg9acTIqlq421tniUdtr2j+QWaeZG9qcPaVwoNu91TJjJqAimtqhsVPNyxALaOGYgFwwlobDKVC6p1OJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707671874; c=relaxed/simple;
	bh=v/6kfZzCWHiNm5vC7FPHnuwBAam/D9ClaoYnW0ufOG0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtdNehnLvhEGHMuwIopNO0EijSPlQCi5DaGB0olrv1VyPdyirHer6bsCLrzXu40O6bLHX8dxk9m94gZVaNW+rj75shpSewle9cAEs7ylvI9zbj2DNaam7rVIqhLEJIm0VX7qpEVc/P4NQc//iEIEjtW1IEdThZP6WSp0kr3ij7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IFTrqQjW; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcFgulJ3O4SH1Oq4GhFJEOfnDCSTQPusyj2xMfFu31ZgPL3dPj+rm7wzP9ufxUVDNyQ0RWoH95cJOkZWw/8srTuAcrm6bH0cwWjkJowPyu9ypwDRocSP/rFST65UAtHhc2PsrHfUeLaNTswZR2N8hMyTvHfnPeh37GxGKjND5qyhfQe4d1F3/f5blYzAGbq+sLbCX1eiPwMgn5pt1neDpIHKZbOhD33UX6L1fhfTav3zciVNBGzuVhmbkTZoSsCNducldstQLC+H/WLtRC+Xr3RDN0Xp0A4+V2jdTSh/quqmgewyLYY4m5RgizVeUcShGQJSQHdGVpZXN4tRW1fJ2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c4+f2+6GQvj5eZZnVGAaqcl7ZqQEdPgStIAodniK5Y0=;
 b=h7WDaqsLPWUQjQYRIfmPcmupvyOIhV03mcSJ5FwPdan7MGEpc6NQdclB4Af30Y6vLwZCm14YvFbI8yswgFl7KXTwjlx4cy3zn+H0t/tARKms3Q7zCopm9bu6rvt4rELDSMyWQwVsS38Iw7uMYjcjOsHOzPaYNyBLQbUFND7V2bdqw2q8q9/F171Sv4VDsamjyIG3AHve6KoH+tSU++fL7gmkA+alckAZatCaPDiY/zfiyfqZzJeRtrRb8jAGPhWgbCX+NfBZPZSJCW4s1L2JFS8jdKy+fbwyXo5aUFSU4RMj+u4LXon0WIIlD1GrPY8LGJVaJHUhkEPc8AlBHnPW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c4+f2+6GQvj5eZZnVGAaqcl7ZqQEdPgStIAodniK5Y0=;
 b=IFTrqQjWv19kGCofs8b738Q1jAizyw+lyyEJEzo7SuxyfEqFQvBSPJTLPXF/j+zQqzObnrV+3cKoD/rB5bIfUmAA3WhR35cJ3W3bURKhSSt15O1d7gtXgH4YcFfpkYOJlzc5rZ6vfhoSIhdqNFen9mGccUXZtE87ayTcubjY+5MLJYV0Jfz+FWYcDWOPNWpgcfN4SwTV3SeEl4uDQDFUTb2KeKUZaulxsCdCTIK4tNxR4u6tzHDcwvAq5tumBR5x83xxOzdWpNZ9Lmk5/qn4yU3is3FObBhuq2csxPKlIhQBpwPulroxxJ2t7kPgUSbpEPXGpLAiJ9W1plw739ahjw==
Received: from CH0P221CA0044.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::27)
 by IA1PR12MB6065.namprd12.prod.outlook.com (2603:10b6:208:3ef::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.10; Sun, 11 Feb
 2024 17:17:47 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::5f) by CH0P221CA0044.outlook.office365.com
 (2603:10b6:610:11d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.38 via Frontend
 Transport; Sun, 11 Feb 2024 17:17:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Sun, 11 Feb 2024 17:17:47 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 11 Feb
 2024 09:17:45 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Sun, 11 Feb 2024 09:17:45 -0800
Received: from build-petlozup-20240117T042503953.internal (10.127.8.12) by
 mail.nvidia.com (10.126.190.180) with Microsoft SMTP Server id 15.2.1258.12
 via Frontend Transport; Sun, 11 Feb 2024 09:17:45 -0800
From: Petlozu Pravareshwar <petlozup@nvidia.com>
To: <thierry.reding@gmail.com>, <jonathanh@nvidia.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<p.zabel@pengutronix.de>, <dmitry.osipenko@collabora.com>,
	<ulf.hansson@linaro.org>, <kkartik@nvidia.com>, <cai.huoqing@linux.dev>,
	<spatra@nvidia.com>, <linux-tegra@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC: <petlozup@nvidia.com>
Subject: [PATCH V3 1/3] soc/tegra: pmc: Update address mapping sequence for PMC apertures
Date: Sun, 11 Feb 2024 17:17:25 +0000
Message-ID: <20240211171727.914595-1-petlozup@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|IA1PR12MB6065:EE_
X-MS-Office365-Filtering-Correlation-Id: df629d97-6bea-4984-2c2d-08dc2b255e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Ik9caQ3qry0GksR2slkqZfDpGH24I/q6Apx/4I0pzt0wjj/CpT3UvaMw1u+ivIPu8BICcKK6vc1PmhkRWzCDoopuL5z+fAjcrHJRkyZC3qxokIqFX5dML5cw6l3YXOiV/GoTY7y5lCpwj6HuwZVdxX6+VA2x6z7oO6LZLvZbmI4D68jSEVETkR/HSNoihUMm+wgxI5dJeJ5OmH9dnaRkuRUwpLBOv+XWoGsE1YgN6/vlS5aogdGvTlvpzTOI9QlzsbeKZkce+8IZg6GNt0PGIGJ/IXuXwINvXcr2JsS5523vDxcSiJXsbMQ7v49HCCfY8FHL1JouT6QtVspqRTqCMD6OCCaejgAcBfGfgMaseXuQPzY3XTKLkrDyt3j7JKACTAa/pstdu1gUNK9weSRC77UOj+XGc6y7bJAOk6+MTvLr/pTZnAdQZYwcuaFPhemBjmMKYORRPleyhiZgstYvS3KesH0e+PxJ6o/VsyFnUmPb6KzG2oQIpavFm7iy+XxlNEoNUakq9agP+Vc4pbspoqNRmJv5hCM0mzLdNg9JFSXKp9ulNQLomCV0dSRwpt84b6g3pxHeTmNWzOqUw/CCwnv3w6j5Yk+ObttpqOEdPpEjpTAUFm2bPBNHYZYRMJkhOOc3Wsg+u2KJX2zCUGw8zg==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(64100799003)(186009)(451199024)(36840700001)(46966006)(40470700004)(70586007)(82740400003)(7636003)(356005)(921011)(83380400001)(41300700001)(6666004)(478600001)(4326008)(8676002)(426003)(316002)(8936002)(70206006)(26005)(107886003)(110136005)(2616005)(1076003)(336012)(86362001)(36756003)(5660300002)(2906002)(7416002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2024 17:17:47.0304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df629d97-6bea-4984-2c2d-08dc2b255e13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6065

On Tegra SoCs prior to Tegra186, PMC has single address range only.
Starting from and after Tegra186, PMC has additional address ranges
apart from base address range. Currently in PMC driver, we try to
map these additional address ranges on all SoCs and if we fail then
we assume that the range is not valid for an SoC. This change makes
it more explicit on which address ranges are expected to be present
on which SoCs and maps the additional address ranges only on SoCs
from and after Tegra186.

Signed-off-by: Petlozu Pravareshwar <petlozup@nvidia.com>
---
 drivers/soc/tegra/pmc.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 6dfcc7f50ece..0bc983f6b088 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -384,6 +384,7 @@ struct tegra_pmc_soc {
 	bool has_blink_output;
 	bool has_usb_sleepwalk;
 	bool supports_core_domain;
+	bool has_single_mmio_aperture;
 };
 
 /**
@@ -2885,31 +2886,28 @@ static int tegra_pmc_probe(struct platform_device *pdev)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "wake");
-	if (res) {
+	if (pmc->soc->has_single_mmio_aperture) {
+		pmc->wake = base;
+		pmc->aotag = base;
+		pmc->scratch = base;
+	} else {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"wake");
 		pmc->wake = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->wake))
 			return PTR_ERR(pmc->wake);
-	} else {
-		pmc->wake = base;
-	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "aotag");
-	if (res) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"aotag");
 		pmc->aotag = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->aotag))
 			return PTR_ERR(pmc->aotag);
-	} else {
-		pmc->aotag = base;
-	}
 
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "scratch");
-	if (res) {
+		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
+						"scratch");
 		pmc->scratch = devm_ioremap_resource(&pdev->dev, res);
 		if (IS_ERR(pmc->scratch))
 			return PTR_ERR(pmc->scratch);
-	} else {
-		pmc->scratch = base;
 	}
 
 	pmc->clk = devm_clk_get_optional(&pdev->dev, "pclk");
@@ -3300,6 +3298,7 @@ static const struct tegra_pmc_soc tegra20_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra30_powergates[] = {
@@ -3361,6 +3360,7 @@ static const struct tegra_pmc_soc tegra30_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra114_powergates[] = {
@@ -3418,6 +3418,7 @@ static const struct tegra_pmc_soc tegra114_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra124_powergates[] = {
@@ -3562,6 +3563,7 @@ static const struct tegra_pmc_soc tegra124_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const char * const tegra210_powergates[] = {
@@ -3725,6 +3727,7 @@ static const struct tegra_pmc_soc tegra210_pmc_soc = {
 	.num_pmc_clks = ARRAY_SIZE(tegra_pmc_clks_data),
 	.has_blink_output = true,
 	.has_usb_sleepwalk = true,
+	.has_single_mmio_aperture = true,
 };
 
 static const struct tegra_io_pad_soc tegra186_io_pads[] = {
@@ -3922,6 +3925,7 @@ static const struct tegra_pmc_soc tegra186_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct tegra_io_pad_soc tegra194_io_pads[] = {
@@ -4107,6 +4111,7 @@ static const struct tegra_pmc_soc tegra194_pmc_soc = {
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
 	.has_usb_sleepwalk = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct tegra_io_pad_soc tegra234_io_pads[] = {
@@ -4235,6 +4240,7 @@ static const struct tegra_pmc_soc tegra234_pmc_soc = {
 	.pmc_clks_data = NULL,
 	.num_pmc_clks = 0,
 	.has_blink_output = false,
+	.has_single_mmio_aperture = false,
 };
 
 static const struct of_device_id tegra_pmc_match[] = {
-- 
2.34.1


