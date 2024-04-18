Return-Path: <linux-kernel+bounces-150820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2658AA539
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 00:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 880DF1F22072
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F698199E98;
	Thu, 18 Apr 2024 22:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bqnx3Sxi"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC2D13F443;
	Thu, 18 Apr 2024 22:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713477718; cv=fail; b=TjeO0e+CfzS1L7OsKLzKdII51SLW3lcXoKC80fKAT391YCjni7nzlxBRAscgMdDui8DEgu3nGiBbaTxw1m09qfn8SfaUompqfzZ3ZOsyfNYyW+XFmkO9azZXybp2XhOE5SYcyj8K1q7dBRS9as3oDFHqoUiLNE9QDNhgd3uEiko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713477718; c=relaxed/simple;
	bh=6vMJP2Sfa40s6HljQcX+szegGpiAK/0dZmxG9jupwcw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jjKcJ76H8clplTk9Ov5IG1aeykrjG8QhwPdh1NZ57TpEHh+HleEpn3lrS+iFpIBR04pxii7QOdMUJ4vi+//Iz6f3CKtL4psMNu4Yls4lq4DKwM0JT2wgdR66ZqOCFEx2foT2M9XaUhMyXU6u28XR/WDlJCJS1jC7TddZ8Y2/pvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bqnx3Sxi; arc=fail smtp.client-ip=40.107.100.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mv985PbWtJSC/3/kVrdN/WU/iCMYxyu7GZ7y8P5xaGsLUq/m34oor7pmqWaHfokLIGhe9Ix7ijsCFGyOvaY0kYC9Mg1EPbLJUqlam1NZRokXtmTwTIhzUpT95pKqrdAn97Mnc8W+0XHPBqUwaOP4/TcDrFHpjOMxhEW/zvlrDZZvvF0PsTT8QXOvldmql0Bt/UA/+pXLI5HutG4e8hH8Wkuo7N4OPR83rfvaci/CpRt27n4KFEQMQU+fmS31NdLJJRjSXVSv6wkWoqiup2xGSV8IgerFtAH19ucCbMWpj7NMjc+Y4Uth/80I6ZJe7C9/6vnbYC0cFhiRyxVqPpUMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CC0gjHunM6y+l5O/OoETnjVkPlVkFQyEj7VP/YVcA0k=;
 b=fEe+metYt6TE3+0jnaK2FOpbbeUjmIYlt/Q7DMo4x9MilGWB70STytdHDNx/+Ww5dwq1TlLVW1XPAPjae/Fs8LPBjLW9UIqx2s6mqtYJC9ZS2LeQMP3r8HcjX2HdueM2Fp9ETNslgKkNMK8o5Ocwhzf42hdPpiCPllMBgdwBfRVOqZ9worGii0phHZCjyQzb7dzA+qsJ9xs8GDW+HWm7KZC1eQml5Yf67yc4tcqE7n+xFtRcyDB9ZVNEWpFUArgjyUC/y3yzwIRXAv7MYyYpbigmKwxMCcXzxitAnbzN8iye3T/cM/HDdvC+RoLahRYcnGrUoBADno+S5xXzvYagmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CC0gjHunM6y+l5O/OoETnjVkPlVkFQyEj7VP/YVcA0k=;
 b=bqnx3SxiSs2Zu0C43V17DZrqSN8Hp1qhlWJZDje4xW2i07piiDcBNb+2xebvmhtoumimxIjKkvB2M0/DhEJQ5MHqJ+UcqxP3URFr4EBchFhJ0OkrsGUScvES2aqZjHBXcJMsQAniHyTwzBfHZ0dvAqvqY6yxBxpepzRk/xx42x8=
Received: from MN2PR02CA0011.namprd02.prod.outlook.com (2603:10b6:208:fc::24)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Thu, 18 Apr
 2024 22:01:52 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:fc:cafe::48) by MN2PR02CA0011.outlook.office365.com
 (2603:10b6:208:fc::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.26 via Frontend
 Transport; Thu, 18 Apr 2024 22:01:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 22:01:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 17:01:51 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 17:01:51 -0500
Received: from xsjtanmays50.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 18 Apr 2024 17:01:50 -0500
From: Tanmay Shah <tanmay.shah@amd.com>
To: <andersson@kernel.org>, <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Tanmay
 Shah <tanmay.shah@amd.com>
Subject: [PATCH] drivers: remoteproc: xlnx: Add Versal and Versal-NET support
Date: Thu, 18 Apr 2024 15:01:25 -0700
Message-ID: <20240418220125.744322-1-tanmay.shah@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: tanmay.shah@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c0a92c5-8256-43db-d75b-08dc5ff3275c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7iLpwKQONFtZZtq3OtyglGelZL3Q0tV4LsXS9rr5fgSej/ldg+dtN9CcsR1b+Ury4Hb96gbjnx8aII6n2gTGyszVCAIlaXrvIagZXngHLmfnUJ19U3FmTfg+ZBLVsBZtwFDpxo3xGZw4YBNww7Q36oofC+PDMmLZxmeIT4F4X4dC4onxqQ6mlBvyPGC+QEXAXwAQ0oEmITAGlID/POG6qcDRPE5hUK9VsM4oQhVw1csF0jHOWGG6vrO07bOI1vnAk9ro0z/PM0SCFsl112r0ieUWxrSpI8X2TYxAHrVlSwiQ+VOTNBkMbA7yFE/TNtwpEImFN7PI5Sf2dp8+4bN/Xi5qA3tfWF1lEF3ei/7IKryyMvSip/ORZ8ihfO10H6yDauoI6CC1bJZfE0JH07VQKSI/c9eNxtno4v7J6NU5qA0CrJP9ijK7anqVQtlgYAu42OFu75zdOd2+8OdicO3FehTPC1/NOfG/Bw6HPGWol4342yLN0SY24/VsU6ZByj/eYy1YsNHx26uDDtiqxSx1sxfXsCD+gMW94rQ4fvW7aosEOtciRsmaobQ3TBkf529/n1suHCOCN8rWc5iU7C82z1LOTUctoObFltqnZgf3u4fuGGJ56fzpHPTvta16Dm6th5PEkfr7SjVgCBu8agtT4fsnvqG0ANtNntpK6+z7DAxcCqWD4fdQXZ9mq2v4K3saujxJiV3mm5pOBN/ZnAgvzbU+Z8Ca3CR66DD1jpcvZ32mob3waGSrsAg+aYcdJXj1
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 22:01:52.1386
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c0a92c5-8256-43db-d75b-08dc5ff3275c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

AMD-Xilinx Versal platform is successor of ZynqMP platform.
Real-time Processing Unit R5 cluster IP on Versal is same as
of ZynqMP Platform. Power-domains ids for Versal platform is
different than ZynqMP.

AMD-Xilinx Versal-NET platform is successor of Versal platform.
Versal-NET Real-Time Processing Unit has two clusters and each
cluster contains dual core ARM Cortex-R52 processors. Each R52
core is assigned 128KB of TCM memory.

Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
---
 drivers/remoteproc/xlnx_r5_remoteproc.c | 53 ++++++++-----------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/drivers/remoteproc/xlnx_r5_remoteproc.c b/drivers/remoteproc/xlnx_r5_remoteproc.c
index 7b1c12108bff..a6d8ac7394e7 100644
--- a/drivers/remoteproc/xlnx_r5_remoteproc.c
+++ b/drivers/remoteproc/xlnx_r5_remoteproc.c
@@ -300,36 +300,6 @@ static void zynqmp_r5_rproc_kick(struct rproc *rproc, int vqid)
 		dev_warn(dev, "failed to send message\n");
 }
 
-/*
- * zynqmp_r5_set_mode()
- *
- * set RPU cluster and TCM operation mode
- *
- * @r5_core: pointer to zynqmp_r5_core type object
- * @fw_reg_val: value expected by firmware to configure RPU cluster mode
- * @tcm_mode: value expected by fw to configure TCM mode (lockstep or split)
- *
- * Return: 0 for success and < 0 for failure
- */
-static int zynqmp_r5_set_mode(struct zynqmp_r5_core *r5_core,
-			      enum rpu_oper_mode fw_reg_val,
-			      enum rpu_tcm_comb tcm_mode)
-{
-	int ret;
-
-	ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
-	if (ret < 0) {
-		dev_err(r5_core->dev, "failed to set RPU mode\n");
-		return ret;
-	}
-
-	ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id, tcm_mode);
-	if (ret < 0)
-		dev_err(r5_core->dev, "failed to configure TCM\n");
-
-	return ret;
-}
-
 /*
  * zynqmp_r5_rproc_start()
  * @rproc: single R5 core's corresponding rproc instance
@@ -941,7 +911,7 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 	/* Maintain backward compatibility for zynqmp by using hardcode TCM address. */
 	if (of_find_property(r5_core->np, "reg", NULL))
 		ret = zynqmp_r5_get_tcm_node_from_dt(cluster);
-	else
+	else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss"))
 		ret = zynqmp_r5_get_tcm_node(cluster);
 
 	if (ret) {
@@ -960,12 +930,21 @@ static int zynqmp_r5_core_init(struct zynqmp_r5_cluster *cluster,
 			return ret;
 		}
 
-		ret = zynqmp_r5_set_mode(r5_core, fw_reg_val, tcm_mode);
-		if (ret) {
-			dev_err(dev, "failed to set r5 cluster mode %d, err %d\n",
-				cluster->mode, ret);
+		ret = zynqmp_pm_set_rpu_mode(r5_core->pm_domain_id, fw_reg_val);
+		if (ret < 0) {
+			dev_err(r5_core->dev, "failed to set RPU mode\n");
 			return ret;
 		}
+
+		if (of_find_property(dev_of_node(dev), "xlnx,tcm-mode", NULL) ||
+		    device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
+			ret = zynqmp_pm_set_tcm_config(r5_core->pm_domain_id,
+						       tcm_mode);
+			if (ret < 0) {
+				dev_err(r5_core->dev, "failed to configure TCM\n");
+				return ret;
+			}
+		}
 	}
 
 	return 0;
@@ -1022,7 +1001,7 @@ static int zynqmp_r5_cluster_init(struct zynqmp_r5_cluster *cluster)
 		ret = of_property_read_u32(dev_node, "xlnx,tcm-mode", (u32 *)&tcm_mode);
 		if (ret)
 			return ret;
-	} else {
+	} else if (device_is_compatible(dev, "xlnx,zynqmp-r5fss")) {
 		if (cluster_mode == LOCKSTEP_MODE)
 			tcm_mode = PM_RPU_TCM_COMB;
 		else
@@ -1212,6 +1191,8 @@ static int zynqmp_r5_remoteproc_probe(struct platform_device *pdev)
 
 /* Match table for OF platform binding */
 static const struct of_device_id zynqmp_r5_remoteproc_match[] = {
+	{ .compatible = "xlnx,versal-net-r52fss", },
+	{ .compatible = "xlnx,versal-r5fss", },
 	{ .compatible = "xlnx,zynqmp-r5fss", },
 	{ /* end of list */ },
 };

base-commit: 912ebe48bec5927e2049e91b0e8a9cc682a709d2
-- 
2.25.1


