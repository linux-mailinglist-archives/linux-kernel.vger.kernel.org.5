Return-Path: <linux-kernel+bounces-69141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0728584F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E0F91F224C6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 18:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B71B134CFE;
	Fri, 16 Feb 2024 18:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ulxz1eJs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC5133997;
	Fri, 16 Feb 2024 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708107317; cv=fail; b=dTOTfwke3kfjPrHO44C8Opp7Qf5gG3z7nXbYBBfvmeN8/ioloP9gyQK5bbHgY9sRTyDK5jkh403eLS5Vc1EIdsFMmPnI9eD1PzU9GYwxib7cTC4UyGj1aH+Q3MJKp/PpzZ5SR2lfONDH52pTmzEf1vhq5uk0iqFhYqxVaBbkphE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708107317; c=relaxed/simple;
	bh=UjLXP4RF9xi9qUcf3iu9fD7znx+6726YykI/3qKAqCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fUFlrhTS4JTscLYDTSaq7421kh3ZBinXUHp8Xjq5fbntEWIC7IIgqq4lpzW0QRy1GlwIe2Bne+qnNkXYZ/gtA/dvvaaFYU5j8e2s1QWzzud5scAbJs5GzEhCfqJMW1hR5Xz19pITfkrRl9mz9DK4POlNOid3p29pOL4pSB/yOq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Ulxz1eJs; arc=fail smtp.client-ip=40.107.94.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/yys7Oy6IOZTivSnGO8Jt5wegAIkIglCApPjhthDpvZfwG+i/PspJ2TZo8IQXvHTTnvrWzBwDNg3C913bxd4+fTVJhxGQboNxA5eMI+3DwCGe/vfWQ95j1WeoGHjtxRCRnmLTWL0WTdstD8IOEQNOlJG0M1n/TjxgcQekjPSXFRJjQW4G3tqgk9ZH4pcT+QhvPNaOddqhbe6WUXeOCZ4mLByjtkU+aGlI8xYgrResrRlrjNMfjsTWbUi90YwpHg064qNeMu7GvaLBub0oOW407pnq1UWT4gnYRyCIFF+BykTExmD9iGbC0DAo7/4opr1Kk/2Nuchk8n9i6oDsZcCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sWKfyDEcrt6KqAxqFuSBMCCC52qJNpdYpv7/KjofOJY=;
 b=QksYlv99MGz9XXh3aortdfA+83rl7OmEzdi8G0xivuHZmFNgQqBBV7AHe2vAgmNas06Sfpd1nX4i2P/6kIHIjL95RVlaKQlN69N5mTV8YzRlc8Ug5eELwoHlkloPDQbV6Jh/qxC9p4zRnbbsb37SW7QKZCk8qbL16TuB96qCnztt9ZwewwqZvCYxMs1aMyDVdju9cklvStsE17/I0gdK8ebucLe2yUCSVLYZznW0qnKLobIsnplTRuXv5eX8lCni98HFzDQOOn4L287CRUNB3JhZGJu+1go0ZbAKCnSzjwpTgfWAVjPESakiVBbyQuyFsnq06IogVkPAzLCwZWl8nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sWKfyDEcrt6KqAxqFuSBMCCC52qJNpdYpv7/KjofOJY=;
 b=Ulxz1eJs0zUajYUIxHQLvXxqHarx61KDGM0UcS5neObeGq/+guJoxhdNZEHh04WxmriKsMaaDzt2UCYR0aSafWnNTEsmZunXuPjugh6nnksZkaXLXrud0e0pcxNi3ez2gexHwGIgIPW/lzYWqN4uxHvjMTtPwLHeuwbmSpa8J8c=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by DS0PR12MB9446.namprd12.prod.outlook.com (2603:10b6:8:192::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15; Fri, 16 Feb
 2024 18:15:12 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::bd) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Fri, 16 Feb 2024 18:15:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Fri, 16 Feb 2024 18:15:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 12:15:12 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 16 Feb
 2024 10:15:11 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 12:15:09 -0600
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <p.zabel@pengutronix.de>,
	<axboe@kernel.dk>, <michal.simek@amd.com>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH v3] ata: ahci_ceva: fix error handling for Xilinx GT PHY support
Date: Fri, 16 Feb 2024 23:44:57 +0530
Message-ID: <1708107297-1798828-1-git-send-email-radhey.shyam.pandey@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DS0PR12MB9446:EE_
X-MS-Office365-Filtering-Correlation-Id: aadf3a48-79aa-4bc0-6ade-08dc2f1b37a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VxA8TR9et7l1GVwCvpbOTUwARmgOlu0jyctDbDKrTcMT/RhP9G2FK0Ee4tuCqTrTdorJpXIwhpGDym5s3Z0jO7Qf0/Gyhf9KgtZ5H+pHr0fotZFGnG5Tw+8328AhKojbE66ltHOWCBcwrvlP2Pc1bXsHFSjhKB4Bmi1xZ43npwuFRID7E3H5JJ9ugwI7yQCniXoOBuqjHl2hoLgy6DQgfRxTAWlK+BdAxBr9jthyj2kV0YCgWb9DH85A3j91gZN3Fs1ldpEtxa3l7pnLE5Hwo0+FpqMSwhyA9hRaPCdXLcJB7Wx26wWDdxX3KoSpx6igFIhTcRXkNLvfJQVFy2embLDh6uq/O8jATb1MmgjUNPqEGhYstkbObKn+rRVKoGmjiIffSelBdJj6ly0k5zf1XN0/cqBPtOGTtHkHeIycA/pY5wmeh22hNdCqdz8XtyciPvOSaAyXIlVctKnIbzZArNGyGbptSqZ6d7MjQD8KWGtK4BPeMnrVLFPIADiQDpTWl4LCYk4r5twDWPSgjZJmvRy37euM120zzMaNZ8lhmPKLWBWhGysqGBqG+rUCjcJtH7BrspUxlIUdsAkcoNWNNivBj5VUJ5Z+ET/ISG6oPC3u6Szm6veA6o/s7rxZwS0GWouIqOa5OIhh4Y6NfQ5wLVHcJbdgjEjId29CuGeeM4E=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(1800799012)(186009)(36860700004)(82310400011)(64100799003)(451199024)(40470700004)(46966006)(478600001)(41300700001)(110136005)(6636002)(316002)(6666004)(54906003)(356005)(82740400003)(81166007)(36756003)(26005)(86362001)(2616005)(83380400001)(426003)(336012)(8676002)(2906002)(4326008)(8936002)(5660300002)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 18:15:12.3574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aadf3a48-79aa-4bc0-6ade-08dc2f1b37a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9446

Platform clock and phy error resources are not cleaned up in Xilinx GT PHY
error path.

To fix introduce the function ceva_ahci_platform_enable_resources() which
is a customized version of ahci_platform_enable_resources() and inline with
SATA IP programming sequence it does:

- Assert SATA reset
- Program PS GTR phy
- Bring SATA by de-asserting the reset
- Wait for GT lane PLL to be locked

ceva_ahci_platform_enable_resources() is also used in the resume path
as the same SATA programming sequence (as in probe) should be followed.
Also cleanup the mixed usage of ahci_platform_enable_resources() and custom
implementation in the probe function as both are not required.

Fixes: 9a9d3abe24bb ("ata: ahci: ceva: Update the driver to support xilinx GT phy")
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
Changes for v3:
- Modified commit description as suggested by Damien Le Moal.
- Add missing return in dev_err_probe("failed to get reset")
  pointed by Niklas.

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
index 64f7f7d6ba84..11a2c199a7c2 100644
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
+	hpriv->rsts = devm_reset_control_get_optional_exclusive(&pdev->dev,
+								NULL);
+	if (IS_ERR(hpriv->rsts))
+		return dev_err_probe(&pdev->dev, PTR_ERR(hpriv->rsts),
+				     "failed to get reset\n");
 
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
-
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


