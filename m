Return-Path: <linux-kernel+bounces-104928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2899F87D5FE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C34C1C20EA9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DB454F93;
	Fri, 15 Mar 2024 21:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D33dmYC/"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2059.outbound.protection.outlook.com [40.107.93.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03854524C3;
	Fri, 15 Mar 2024 21:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710537382; cv=fail; b=PrjOkOOOdfajJvsDD0J128Z1Zx605MaHBnRz7DFXcyAFOD2Jqz7ahpVpQ2gvNqC5H0fbOHhio4luCheKb4mB1CMFSkGOS9Sw8qCyDicTsLnONQoDGYHsji7zdUBHY8ORzRn5ru7F2lgjSwjYkiWV7EI2NG4kc6cUg20fTH/RGwg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710537382; c=relaxed/simple;
	bh=6sF7qy8PS+a8W+NPl4Ep0P00bX+WJf5susRGkG+mGgA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OwW3Zqvr6B5yXqYeBm8NCwLYmmHsTeLILIMb2E0FyCszOwRgATC1Jt+D47hWzQPpEgd4pBpt3eKZQlmpBzl8P++Z9XpoLFKEBsnv9uMVLiYD2HESTnCxVH0yckNJ6xn5yVG4AzYolKr1pJZPYnb9Nrt/GkcdQP/mTFih69sfMDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D33dmYC/; arc=fail smtp.client-ip=40.107.93.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSDbontWSTQ29LjigBYN1zoW345+qdDA/h9SMoMGnsuiG83cuK3FBoY30LTmusgR+qOsuFMvkl5ZME2srrH7x40FaA48mipF8w1FNrwcqBa/mP8kZBqpd4B0Uy1Ax4zWpFExu090NRfJggVIQ33bviw+kvAhBlXNeCNV/Arq5YCnNC/xx7MU3o7F0n0nTMdm/fOqRfUrEMjYLVOr1X+LhaPSyzyLu3P6Gna0tkAWR5dBxvjNBuInlrK3oXf/hyu3wyQgHoXTDB2K6sshL2u4nSQ2gZNfRRG8HZzhM4frHzV9rRGeOhhFOwIy0wnQ9zxa6LJKsbk28IM7nOiajQbWrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqv+Knr7fIg09mX5uMLKwGowajJsnIHuU9QcUK1DxNA=;
 b=mFWcwq2QVap8dWrRiz/I+8MGOJQ1zzJFh8D1jZyfizj7xch490dX8BafxHG1pIT/AkQnHvwUuIfEdRdWrB+oy4ZwmI+CtIwKpnA+yLM4B8zg+/a6K8dYM2oGtszKuVIzyqX6uVqBekEkXOzsXFPYBNj/0I7NQdKY1tJHhmYQODMHEzxU4tSuzfoouekMKt1BEeS/dRR6iIOHawjIYkBJvtTSYtBBGmYIcUugxysrJ4ED8KaQpmFu7GAw7KRI5dlP0hpW8C/X8JJ6hIEsSHJdYvOH/xBX0/BQ//yXgpyyF23uRshsDsr1R9Qdq5MdcNg5mnpkY9wGoBGmu8q1VdrU9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqv+Knr7fIg09mX5uMLKwGowajJsnIHuU9QcUK1DxNA=;
 b=D33dmYC/pPNapkG+fSqARyT6pYJMuxvvZ1lZ47rlyMkTwhxtU2sHJMdueLOL269wRr876xZqws1rLRzl+j2z3mwDdstcXmtDp2dTjibbW0OnraLNiFLyUJ6kzRueRg+mO2xYcRcQL2AcO5eETUs6hzNk2V9WJ4L7Wt1DfsnJhIc=
Received: from MN2PR07CA0030.namprd07.prod.outlook.com (2603:10b6:208:1a0::40)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 21:16:16 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::cb) by MN2PR07CA0030.outlook.office365.com
 (2603:10b6:208:1a0::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22 via Frontend
 Transport; Fri, 15 Mar 2024 21:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Fri, 15 Mar 2024 21:16:16 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 16:16:16 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 15 Mar
 2024 14:16:15 -0700
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Fri, 15 Mar 2024 16:16:14 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <ben.levinsky@amd.com>,
	<tanmay.shah@amd.com>
CC: <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] drivers: remoteproc: add Versal and Versal-NET support
Date: Fri, 15 Mar 2024 14:15:33 -0700
Message-ID: <20240315211533.1996543-4-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240315211533.1996543-1-tanmay.shah@amd.com>
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 345e9870-1a4e-4b1c-9d2d-08dc453526a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Hj90QT88PnDPP/nUgGTXdmN5QyBa+wzUe9sompPy5Lp9QqvEfzvoaKVX+mBXvkG4sD1GpDC0ac7BI0PR7mlFsZkrK8ehB1DvLu+e4E973RwRGcWaysu4Gx/qeCSGH/t52mTBautf1u2Yu7cNTYqmG1QnxftyHBvFNeelDEptyzsHceXvkO6fIGbi8RoV+wjgbtToYHYPow1ve0W7n3Ek+GbpCt0muzkE6pql86knBEacl8sP2POtPTIIEy2yYD5McsSbpI4BA3XvuEa+dQa9Zc0LUY/i/U544Wc+CvGh6vRJ5/BHOjss2WsoLbozRW411fTur/3lTODlF1nCOnuJ0aaIch58eevuJ4aqd/25EcP8IW4uo5wKyTxyun32dYmsrWRuqAJrgFjikj10rrnhoZe8oTiCwN6wLX0mX4EFgBRid765ue4AIAwTGZdFosWzv8sBMBKgPc8YZRPOURvrjjDeYc+6KCGCQPYUWLFMzqTax9SV8/NTjNtmf6oCcxtVisZq/76snUbxVU6bgR29DquOobsA+MrgX3aOGCRJJ7OX+NQbBQ1rHKuthvY+zPIIgAwvsASJWSCZZAAk34G/AAKFOdX35sOBSsDFPFGNx5l3NPdn35i88d3vSzmayihldzqZbYLhW3qFd4yL+Neq/RskB3gCINmXqdOi69g2B6Ej6R/LLEMAA3alLrxyAlQAZHjRgGuoMv2RwyR7sZGuBiQv4tzKjbjm5jMZRIPT2Ez1Xg3O0+omB1HiUaPae80D
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 21:16:16.3270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 345e9870-1a4e-4b1c-9d2d-08dc453526a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

AMD-Xilinx Versal and Versal-NET are successor of ZynqMP platform. ZynqMP
remoteproc driver is mostly compatible with new platforms except few
platform specific differences.

Versal has same IP of cortex-R5 cores hence maintained compatible string
same as ZynqMP platform. However, hardcode TCM addresses are not
supported for new platforms and must be provided in device-tree as per
new bindings. This makes TCM representation data-driven and easy to
maintain. This check is provided in the driver.

For Versal-NET platform, TCM doesn't need to be configured in lockstep
mode or split mode. Hence that call to PMC firmware is avoided in the
driver for Versal-NET platform.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index d4a22caebaad..193bc159d1b4 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -323,9 +323,12 @@ static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
 		return ret;
 	}
 
-	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
-	if (ret < 0)
-		dev_err(r5_core->dev, "failed to configure TCM\n");
+	/* TCM configuration is not needed in versal-net */
+	if (device_is_compatible(r5_core->dev, "xlnx,zynqmp-r5f")) {
+		ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
+		if (ret < 0)
+			dev_err(r5_core->dev, "failed to configure TCM\n");
+	}
 
 	return ret;
 }
@@ -933,10 +936,17 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	int ret, i;
 
 	r5_core = cluster->r5_cores[0];
+
+	/*
+	 * New platforms must use device tree for TCM parsing.
+	 * Only ZynqMP uses hardcode TCM.
+	 */
 	if (of_find_property(r5_core->np, "reg", NULL))
 		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
-	else
+	else if (of_machine_is_compatible("xlnx,zynqmp"))
 		ret = zynqmp_r5_get_tcm_node(cluster);
+	else
+		ret = -EINVAL;
 
 	if (ret) {
 		dev_err(dev, "can't get tcm, err %d\n", ret);
@@ -1198,6 +1208,7 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
 /* Match table for OF platform binding */
 static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
 	{ .compatible = "xlnx,zynqmp-r5fss", },
+	{ .compatible = "xlnx,versal-net-r52fss", },
 	{ /* end of list */ },
 };
 MODULE_DEVICE_TABLE(of, zynqmp_r5_remoteproc_match);
-- 
2.25.1


