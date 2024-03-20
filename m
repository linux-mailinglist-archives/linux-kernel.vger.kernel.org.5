Return-Path: <linux-kernel+bounces-109320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D31C88178E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:51:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B9A91F22FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F2685624;
	Wed, 20 Mar 2024 18:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cNcTsD6B"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4F87E761;
	Wed, 20 Mar 2024 18:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960688; cv=fail; b=PxZUIcKKG3eh5+MoDYQSMhBwJMgqvlg7q7f+ZzIZtow17Trl14MCX8rp4QaGE8UCW15wUXlQnIKl3Xn/++gJRebI6xsOr1iNbtLOC+cDKdEX3NSu+m0+RcWb9RniYrPE8qLgxhrULUM32sftQ7ag1+NN1tvtdlDfrHNq3zw7ZXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960688; c=relaxed/simple;
	bh=QL6LUfGbBvqM2VmpMbNIGzG4RZldo7wnzry4JqknHHQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H6hzArDvarqOoIk5J1YmEOFbcAGKNnUWSg7wR3ED2NVUCr7xV3pRj7AlnLoZ/4PNDIHuPYcmbXeo6Bq2801YbdvBeBGNAcHBBP886A5ms+DOH3gZjNNo1hQoP/n2ScTzKWEDybK3zOzqNExe1QLjc00I0Kp4cNoHu328c6qiJzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cNcTsD6B; arc=fail smtp.client-ip=40.107.92.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lp5Z1YWAndcTNw8r8xuAgZNZW5hjQBkfgroG9FEX8meX3NUDNMcx0bgLPFRIoU0KKCYJGz0TKk2zXqFeOmZNaFXH3jAo8OKpSTM6gqlUgMig3vneB+iKswMwUu1o5UST5yq0hC1VuZtxqbECtmuPNs+7E4EanEmtcdGGksBUmXYB2JusmllR3zcjhzS2UOrTo99igIrxOPaBj3WlPuNiPrv6Snc+TXdV4MFwSBVMjI+1DZA86pOvWQFnbfdNTUPDMUigEGgjQ7uWRr8NFHKX6K1puDuG821s2FBS0xQhgzXAE+rL7jdh6ITm+zo5XyGdB3Sc4BrgkQYc5rPkHD+PTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ma8YFtmZnEaob7U2yh3b0TZ/t+JLsnMIydYBktWEgaU=;
 b=fj0FjShV+fbl2zVZBh+10Ba8JDJ2bHDO3GpaxtPbpO2HvzeE8O0E1GqJihSoEZCTwLyjoWu1FIRXscp5sngdkg9MrXpSQO+WNrPDxGPAjVPNjsEvvuEjezlg8OEYiufCm3v4HovxyySjQkHbm0Jd4+LY3Dco9YiKcJdnD2U5Tm4GjG9VaEYU2KohM831HG+QRi8foJDQFo6JJlUDODjRQrBHLWk5A+Xjs3bISaiqbFGmBirUOApc7LEWHK+LfJWunTamRvH6f6eGorDPvUkHcYqKtzU5LtnK/0hQ/ufpu+U+2e5AApwe3oDq8E4WMqIaphfnUVqAKS6guHhAwv4nUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ma8YFtmZnEaob7U2yh3b0TZ/t+JLsnMIydYBktWEgaU=;
 b=cNcTsD6BWMQ0+QrLtXY+Yy0Cdvl1iTwj0kzM/L0WCrUNwDoXBp0DuKChiqmXgohFBXiN+ygkN567K04242XQAWLYdSHYtwJvcHs+oRSIcRs86yC/aeCYIxJc4UoLW/WUVgtt1AnaktCyJW/LrcR5Jc4DW3v/V+mZIjMewGbQ8zg=
Received: from PH8PR15CA0020.namprd15.prod.outlook.com (2603:10b6:510:2d2::20)
 by MW4PR12MB5627.namprd12.prod.outlook.com (2603:10b6:303:16a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 20 Mar
 2024 18:51:23 +0000
Received: from SA2PEPF000015CD.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::5d) by PH8PR15CA0020.outlook.office365.com
 (2603:10b6:510:2d2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28 via Frontend
 Transport; Wed, 20 Mar 2024 18:51:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Wed, 20 Mar 2024 18:51:23 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 20 Mar
 2024 13:51:22 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 20 Mar 2024 13:51:20 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <dlemoal@kernel.org>, <cassel@kernel.org>, <Markus.Elfring@web.de>
CC: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<git@amd.com>, Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH] ata: ahci_ceva: return of_property_read_u8_array() error code
Date: Thu, 21 Mar 2024 00:21:05 +0530
Message-ID: <1710960665-1391654-1-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CD:EE_|MW4PR12MB5627:EE_
X-MS-Office365-Filtering-Correlation-Id: 5724e175-f00e-42c4-c735-08dc490ebd34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xgX8OEtWyeNHpvmZFO/LOnxfKBv//F6tOH37xeHeN9xu/9Kxt1kJJSOAtx5ByYQfJidBAINMuB79v9qgqNoHipSSayrzUweyMNhHH5EZ6TnVNpT/qehHA7LgB7k+Ij+pb5M8r6PJoAj1uJxlx77/04PKse+qSDtAl1oqd3FNho4U1J/qLGqH6j+KlZ7S687YmcXfzAZOKFTOtwfEWOepJdLz2H3OU3xB5qgke2eoI/oRHpZph5W3GN953ve8teYqzzxkPnam4ujFhKrfgfIV7JjE6BuGtfrMQlOZrkDHsNX4vnsZE1pO6rRRjCD6ahYIpU1yKJzwtvOdicMxS4cdKyrY9+7ROLYt9fFAqdmql9+pjsXKDV0mEd5JD/YTPemMPuVQIB3NclaIkoOw/EjKYTdC76IUYoXeBX6i8+xckssMCzDW81mpoJDXbmUY1UyG/Kb6B2XLCHVtFEWGV6hvMi8QpuopNiboXCGVqKdxi5Q9fuWv4tTCcjm985FmXtRcxDzgy1R87OoKr5xrgdbQ+CPCE8xNz1aFBvHWr7NEdKHLchOTXur5496MzezDeR0mIymkp91bqnnR2P1eVkJ/gZjLnhv6vXxhLXac7Gx41lMpkQJqGb4p2dNWtlk7A7LSWoh8ocPeKAAH7ZwdIRxSMQsbYWlTVrWjpq/LytD0ahPEVvbpt8880S7Ied5utddxM6zGnIiFp/meA2rJFABJvg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 18:51:23.1865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5724e175-f00e-42c4-c735-08dc490ebd34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5627

In the ahci_ceva_probe() error path instead of returning -EINVAL for all
of_property_read_u8_array() failure types return the actual error code.
It removes the redundant -EINVAL assignment at multiple places and
improves the error handling path.

Reported-by: Markus Elfring <Markus.Elfring@web.de>
Closes: https://lore.kernel.org/all/9427c0fd-f48a-4104-ac7e-2929be3562af@web.de/
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/ata/ahci_ceva.c | 48 ++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 11a2c199a7c2..b54ee80c068f 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -274,62 +274,62 @@ static int ceva_ahci_probe(struct platform_device *pdev)
 		cevapriv->flags = CEVA_FLAG_BROKEN_GEN2;
 
 	/* Read OOB timing value for COMINIT from device-tree */
-	if (of_property_read_u8_array(np, "ceva,p0-cominit-params",
-					(u8 *)&cevapriv->pp2c[0], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p0-cominit-params",
+				       (u8 *)&cevapriv->pp2c[0], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p0-cominit-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
-	if (of_property_read_u8_array(np, "ceva,p1-cominit-params",
-					(u8 *)&cevapriv->pp2c[1], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p1-cominit-params",
+				       (u8 *)&cevapriv->pp2c[1], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p1-cominit-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
 	/* Read OOB timing value for COMWAKE from device-tree*/
-	if (of_property_read_u8_array(np, "ceva,p0-comwake-params",
-					(u8 *)&cevapriv->pp3c[0], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p0-comwake-params",
+				       (u8 *)&cevapriv->pp3c[0], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p0-comwake-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
-	if (of_property_read_u8_array(np, "ceva,p1-comwake-params",
-					(u8 *)&cevapriv->pp3c[1], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p1-comwake-params",
+				       (u8 *)&cevapriv->pp3c[1], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p1-comwake-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
 	/* Read phy BURST timing value from device-tree */
-	if (of_property_read_u8_array(np, "ceva,p0-burst-params",
-					(u8 *)&cevapriv->pp4c[0], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p0-burst-params",
+				       (u8 *)&cevapriv->pp4c[0], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p0-burst-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
-	if (of_property_read_u8_array(np, "ceva,p1-burst-params",
-					(u8 *)&cevapriv->pp4c[1], 4) < 0) {
+	rc = of_property_read_u8_array(np, "ceva,p1-burst-params",
+				       (u8 *)&cevapriv->pp4c[1], 4);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p1-burst-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
 	/* Read phy RETRY interval timing value from device-tree */
-	if (of_property_read_u16_array(np, "ceva,p0-retry-params",
-					(u16 *)&cevapriv->pp5c[0], 2) < 0) {
+	rc = of_property_read_u16_array(np, "ceva,p0-retry-params",
+					(u16 *)&cevapriv->pp5c[0], 2);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p0-retry-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
-	if (of_property_read_u16_array(np, "ceva,p1-retry-params",
-					(u16 *)&cevapriv->pp5c[1], 2) < 0) {
+	rc = of_property_read_u16_array(np, "ceva,p1-retry-params",
+					(u16 *)&cevapriv->pp5c[1], 2);
+	if (rc < 0) {
 		dev_warn(dev, "ceva,p1-retry-params property not defined\n");
-		rc = -EINVAL;
 		goto disable_resources;
 	}
 
-- 
2.34.1


