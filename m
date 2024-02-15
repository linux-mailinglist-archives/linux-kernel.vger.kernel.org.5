Return-Path: <linux-kernel+bounces-67459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06162856BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 299561C233D3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C65138493;
	Thu, 15 Feb 2024 18:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tbc22lwr"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D2B1369A5;
	Thu, 15 Feb 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020077; cv=fail; b=u0/mCCdSOVuLTBLzTDu7RxOYkggAeyEdEj+6Kx0sRYK4qJobXXJr83oYkIkE8hJBzLC8FBbH2miWkkrbyTGDQF1Fj5CkeANcg2451kOp4Hz96btI+bBYPYKbV5sTWjjjZz3/OL704nxoV9ZdzXxX7ly2ut24T4IT1DH4NrEkdV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020077; c=relaxed/simple;
	bh=MVMRVO/ILtBmoUsHY4JdVL7WELveHgOfz9xaSMGr5eM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GTJ+OeX0u46iPjpbccQS5edkwxhCSoW7Of5YhdD1z/H0Q0ZJdhh8/ydXOMOo25+miN77ylszbW19YrtIt6hD25GpJhPKQag2SIey3YnDPs6WjT1FZxOebSqEF7mFoOZEalIezmoYir2cNvGHVFdV6ASsYfUpSDUVATaHWP/x0Fc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tbc22lwr; arc=fail smtp.client-ip=40.107.220.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kbct57RwkKH00S8w5zQVLByAFvCwqC526hWhaw8OKpj0VjSKX5JQdSqEeEO1xUOEF5ij7no4g5ct0dw/Fy3Zcb/PsNrUv6eFvjdWdbri4kle9vsenGl/9PDQax6ovubMPhQwfT29UA44vQ4ai0AoGC46D/j7041xJiPg6GDJIJgZzsUgsnfJiVhSmVIibnMszRujr0lTUBPMeSycToqUMONryw9wAh8n60Oash7f6jEUYDy/de3AyGzBwtmm9ek+qFKl+S2Jc5JnzxCwz28yZWGnqvCD3+cN/BlpyAMQOVLOnl/15gSLBFa1J4lvcp3KLOVOC21z4EyN9saYHEWXWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmPGlUAy7OLfGM1BDEVgyGpsJf4fM+ZfuGxBHGv8UI8=;
 b=imAFNddZGK3AuvbMqD/BR0VWLPUwp8guEzoVdAAwlU1SHdBj8/btjRgEZ7EABYaO/0zuR9+HJ82tZFNyZVbFmzH/rucz9KW21IohR5RGulM1blaIMJV/SAhLsL6aouKifLTsBVZ3rA64fgGfSAapgjpmXkDlQyurtR5ZFSp6iDrENSDLquEMJEKxp4YFRUCJH4pGoftP99WnWBmUJ6b+F2YoIwNOX033glDrYnoHbizfOq+5+TQOvhT2dQy5J9jTcOV9gTznTyOg8DbGtnq2zYlgTqMbnLvpESG8kbm/rVmreoshlkFA6/o7PT0iRYh2TlCclHYa6CXGo0T90DRXbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmPGlUAy7OLfGM1BDEVgyGpsJf4fM+ZfuGxBHGv8UI8=;
 b=Tbc22lwr+NRRRqvRrBTkw+vdKP5SrUGyie0H4HaujMITfUByllZPdxAq5/BktWNmhTCHK7W6iinEwUtsMvvQowBXZMGdvCm4lCbiKPoYefoW0W9md2yZkZ114CQ4dp0dw79RO6LFJIoOtCVAvexgL2sePsTR/+2vZwFJ9s31pV0=
Received: from CH0PR03CA0244.namprd03.prod.outlook.com (2603:10b6:610:e5::9)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.28; Thu, 15 Feb
 2024 18:01:13 +0000
Received: from CH1PEPF0000A348.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::43) by CH0PR03CA0244.outlook.office365.com
 (2603:10b6:610:e5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Thu, 15 Feb 2024 18:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A348.mail.protection.outlook.com (10.167.244.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Thu, 15 Feb 2024 18:01:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 12:01:10 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 15 Feb
 2024 10:01:10 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 15 Feb 2024 12:01:08 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <p.zabel@pengutronix.de>,
	<axboe@kernel.dk>, <michal.simek@amd.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Radhey Shyam
 Pandey" <radhey.shyam.pandey@amd.com>
Subject: [PATCH v2] ata: ahci_ceva: fix error handling for Xilinx GT PHY support
Date: Thu, 15 Feb 2024 23:31:00 +0530
Message-ID: <1708020060-1439879-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A348:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: 58573354-2014-49e9-c972-08dc2e5018cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iPEtflGDivXdjpjLkCTYuDxHpMw3cLjNSuO80vyvdvp2yQPx6kgdJ1az16Lk1d5YKLJEoD1H6zIW0lrvpdf3ifaKnD8mt/7y1TVnSMXXPNwHNCXvsH7qLysepo2ZP2Rd7QTufppywUOTbbenHhC19o1/OHkKJ6ph1ZJWNnyyfiMfCZ3406wfBlwsg+bdoPw1nZrlZdWLkJT5HKdMkpdFWpVX+Bx6bLdNqbASBEb4ZAD8Tspb9DF6gA0VXqvQM0z0Tp3Q0SQRfBRWbufQDLExk401mOz/AArb+ma20sGv9HDeLWi6NP6v3fGB6XGNjya+DAjn2oKIF68QqwSRiI/fZaAGgF2HfR0Ei5NoBtL64mzR6DsY4M9QevQXmEPxPF+j3dxQwXISbnwudv3U4p/dp5HqTYhtdurN1bJN9cLwFJ7HJ77+PMpMLvpRNf8S4TB0+jtnR3YAmaD/wJ+rwv9vpMSM56GOhMznsvbDyM1sYeRJYLYDulWzcXtBA8vtq6pJYYeC/or3jiICWY2C93c3ehj1HYfPtJM2ueEySri4dicXdVYayXXjHFTlWACyPXddW3PAPaKWArnW7aodKvNS9VkZIiaD/GIAYtYsEM//Y2T+nANjyD2n9aEz4ILK2mx4H7pYrr6+Sfc9VbRJn2H5x3yL+DiftUQf1C5raLixf1M=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(82310400011)(36860700004)(1800799012)(186009)(451199024)(64100799003)(46966006)(40470700004)(6666004)(478600001)(41300700001)(8676002)(8936002)(2906002)(4326008)(5660300002)(70586007)(54906003)(70206006)(110136005)(316002)(86362001)(6636002)(336012)(426003)(356005)(81166007)(83380400001)(2616005)(26005)(82740400003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2024 18:01:12.7323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58573354-2014-49e9-c972-08dc2e5018cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A348.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
error path.

To fix it create a wrapper ceva_ahci_platform_enable_resources() API which
is a customized version of ahci_platform_enable_resources() and inline with
SATA IP programming sequence it does:

- Assert SATA reset
- Program PS GTR phy
- Bring SATA by de-asserting the reset
- Wait for GT lane PLL to be locked

It switches to ceva_ahci_platform_enable_resources() in resume path
as same SATA programming sequence (as in probe) should be followed.

It also cleanup mix usage of ahci_platform_enable_resources() and custom
implementation in probe function as both are not required.

Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:

- Create wrapper ceva_ahci_platform_enable_resources()
- Remove legacy ahci_platform_enable_resources() and its related code.
- Modified commit description and merge 1/2 and 2/2 fix as it is
  automatically done when reusing ahci_platform_enable_resources()
  logic.
- Drop Reviewed-by: Damien Le Moal <dlemoal@kernel.org> tag.
---
 drivers/ata/ahci_ceva.c | 125 +++++++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 46 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 64f7f7d6ba84..c04f5033f981 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -88,7 +88,6 @@ struct ceva_ahci_priv {
 	u32 axicc;
 	bool is_cci_enabled;
 	int flags;
-	struct reset_control *rst;
 };
 
 static unsigned int ceva_ahci_read_id(struct ata_device *dev,
@@ -189,6 +188,60 @@ static const struct scsi_host_template ahci_platform_sht = {
 	AHCI_SHT(DRV_NAME),
 };
 
+static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
+{
+	int rc, i;
+
+	rc = ahci_platform_enable_regulators(hpriv);
+	if (rc)
+		return rc;
+
+	rc = ahci_platform_enable_clks(hpriv);
+	if (rc)
+		goto disable_regulator;
+
+	/* Assert the controller reset */
+	rc = ahci_platform_assert_rsts(hpriv);
+	if (rc)
+		goto disable_clks;
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_init(hpriv->phys[i]);
+		if (rc)
+			goto disable_rsts;
+	}
+
+	/* De-assert the controller reset */
+	ahci_platform_deassert_rsts(hpriv);
+
+	for (i = 0; i < hpriv->nports; i++) {
+		rc = phy_power_on(hpriv->phys[i]);
+		if (rc) {
+			phy_exit(hpriv->phys[i]);
+			goto disable_phys;
+		}
+	}
+
+	return 0;
+
+disable_rsts:
+	ahci_platform_deassert_rsts(hpriv);
+
+disable_phys:
+	while (--i >= 0) {
+		phy_power_off(hpriv->phys[i]);
+		phy_exit(hpriv->phys[i]);
+	}
+
+disable_clks:
+	ahci_platform_disable_clks(hpriv);
+
+disable_regulator:
+	ahci_platform_disable_regulators(hpriv);
+
+	return rc;
+}
+
 static int ceva_ahci_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -203,47 +256,19 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	cevapriv->ahci_pdev = pdev;
-
-	cevapriv->rst = devm_reset_control_get_optional_exclusive(&pdev->dev,
-								  NULL);
-	if (IS_ERR(cevapriv->rst))
-		dev_err_probe(&pdev->dev, PTR_ERR(cevapriv->rst),
-			      "failed to get reset\n");
-
 	hpriv = ahci_platform_get_resources(pdev, 0);
 	if (IS_ERR(hpriv))
 		return PTR_ERR(hpriv);
 
-	if (!cevapriv->rst) {
-		rc = ahci_platform_enable_resources(hpriv);
-		if (rc)
-			return rc;
-	} else {
-		int i;
-
-		rc = ahci_platform_enable_clks(hpriv);
-		if (rc)
-			return rc;
-		/* Assert the controller reset */
-		reset_control_assert(cevapriv->rst);
-
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_init(hpriv->phys[i]);
-			if (rc)
-				return rc;
-		}
-
-		/* De-assert the controller reset */
-		reset_control_deassert(cevapriv->rst);
+	hpriv->rsts = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								NULL);
+	if (IS_ERR(hpriv->rsts))
+		dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
+			      "failed to get reset\n");
 
-		for (i = 0; i < hpriv->nports; i++) {
-			rc = phy_power_on(hpriv->phys[i]);
-			if (rc) {
-				phy_exit(hpriv->phys[i]);
-				return rc;
-			}
-		}
-	}
+	rc = ceva_ahci_platform_enable_resources(hpriv);
+	if (rc)
+		return rc;
 
 	if (of_property_read_bool(np, "ceva,broken-gen2"))
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
@@ -252,52 +277,60 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
 					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
 					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read OOB timing value for COMWAKE from device-tree*/
 	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
 					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
 					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy BURST timing value from device-tree */
 	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
 					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
 		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
 					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
 		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/* Read phy RETRY interval timing value from device-tree */
 	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
 					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
 		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
 					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
 		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
-		return -EINVAL;
+		rc = -EINVAL;
+		goto disable_resources;
 	}
 
 	/*
@@ -335,7 +368,7 @@ static int __maybe_unused ceva_ahci_resume(struct device *dev)
 	struct ahci_host_priv *hpriv = host->private_data;
 	int rc;
 
-	rc = ahci_platform_enable_resources(hpriv);
+	rc = ceva_ahci_platform_enable_resources(hpriv);
 	if (rc)
 		return rc;
 
-- 
2.34.1


