Return-Path: <linux-kernel+bounces-154647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F5B8ADF16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DBD61C22FAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12A458229;
	Tue, 23 Apr 2024 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zi7E/0Z+"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A4854BFE;
	Tue, 23 Apr 2024 07:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713859152; cv=fail; b=J9ZR5gaAw439E7e2FruL+YXj615cgm1vPUEytmQR4ay8AGy2M14fFyLYeiDDwg6a5GOeLS6bao5OWzUGQ35pXI1Ufo3iC/4JQ0Hk510EJHO9DZXV89+6uw20XqzCmYofRauaSkOZxd94Gb+bD+4JZc1BVp06GxFX51auyQggndA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713859152; c=relaxed/simple;
	bh=ckwcOBVNDuF40QHvqaELwzXzB6I9pFsprYsdpq4lBWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3zv44bcsucsCmEEa4OVvQJsKvpdkRbi/qSYYeJi44z6Vx7FWQBlKNkjFxWbn27qezKCJeQcz6/CHKEYcBznhxSi0PwnDfuzGR1Cx+W/yic3AO/+3TOohGfDyM0AYpmkCf49aY3aIlzeKma2HBULqEn98fZtqwn2a2pkOFL1prQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zi7E/0Z+; arc=fail smtp.client-ip=40.107.237.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QrQuXYi4hw+C7o8UdutHPI5jAf1ublzUgkm0tAWm9714oKjZO0Hp5GDRf2L7AGmMuNku5eqLibVLue260K9VyeTAoYq3VvASgPK+MCeLF73vex6qID45O6oi1w3I38eMdQAecmIaXTDWGs4sO1dyIPKdzRjaUYIGLwOlzzo7tdmLZntjbuXw9/pNtnx8kukPvm5A1pU2tkLBi5PusLiuWRU87Rp58FDiJRlWDYqDsRQXxz/jQwo6qdIo754nLLvtYxByv14r/uZcTLiQxI/88XudVx0jiUZ45T9rnNe2JD5h3wM2z+/rUc2L2O/xtr+o8PcZcNx1kKyuwMhjBjvGrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7Nnj+wrL8I671SDCrz9Xga9ZXP4NJdoC+h1QNGeU94=;
 b=nYKqyKz5s2ilW37RNMKtZIDdertcVP+CscU/TeG4FJ5PZUYoJPFHAy4XnrBRC1RIZz3Vi2xr3ASwGEM1G8zRXx2ca/4F3CIUEaNh/UaiDqeYbk0/qKPolocyBsaCqhecPFK4XMakmkJrXL58dSVVZuKx1qiED38FXdUvhJr8SbwgfofLT9UGDohyzX1rFaUCFotGLrIbIadCbwi9QuScMa/N9aLcRdVou2J0fQZPaJG5/AShplD8BFxVq3+0XGJJ11SR5Vfv0FEqeUob0K6lHOYJj638luftxKv57Fbnt2W55lzq9rgGskRNHXpV5ENbE+WyF54Dyr3cVyyUQKHynw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7Nnj+wrL8I671SDCrz9Xga9ZXP4NJdoC+h1QNGeU94=;
 b=Zi7E/0Z+MtFMCr6T+UmhTxvjWpTj6ROURFIWzHu/zz+Rv4grE54n4Payi1QJE4lHxy/j4i4eKaeUGAw9uOgsYVd6R7PC05xP51mkvbMam+KE7Mcruo9cgOQgSZsNnmUb7yAn0D7w5bvj+rOWR4o7B6Dnl7iIa6BXydnkFkBHnyU=
Received: from CH2PR03CA0026.namprd03.prod.outlook.com (2603:10b6:610:59::36)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 07:59:06 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::5c) by CH2PR03CA0026.outlook.office365.com
 (2603:10b6:610:59::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.35 via Frontend
 Transport; Tue, 23 Apr 2024 07:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 07:59:05 +0000
Received: from pyuan-Chachani-VN.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Apr 2024 02:58:59 -0500
From: Perry Yuan <perry.yuan@amd.com>
To: <rafael.j.wysocki@intel.com>, <Mario.Limonciello@amd.com>,
	<viresh.kumar@linaro.org>, <gautham.shenoy@amd.com>,
	<Borislav.Petkov@amd.com>, <Ray.Huang@amd.com>, <Alexander.Deucher@amd.com>
CC: <Xinmei.Huang@amd.com>, <oleksandr@natalenko.name>, <Xiaojian.Du@amd.com>,
	<Li.Meng@amd.com>, <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 6/8] cpufreq: amd-pstate: get transition delay and latency value from ACPI tables
Date: Tue, 23 Apr 2024 15:58:22 +0800
Message-ID: <81aafa46533637984cc9c80f90faf5498a7308c9.1713858800.git.perry.yuan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713858800.git.perry.yuan@amd.com>
References: <cover.1713858800.git.perry.yuan@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 39172584-af73-49d4-6adf-08dc636b3fa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gPrEsdNZkaMZPQOBAcNXOcd23dfEOg0IQXNyHPV28+isDh95eTQsWC3ukCOi?=
 =?us-ascii?Q?BZQzQmtmyaC8SkLZySeQJZ6c5zXeE3Vw84zypv8UzKPwxkbr9xVecD08hOSq?=
 =?us-ascii?Q?9bAamQYJjigPwSok39jQdj5mhsIQjNmwumH4jOWTgQaoN6CKvBJlJVmfcLKB?=
 =?us-ascii?Q?f0a8yReee13evptusfkUSjb+YG8dVP9O1jXF2P0Zmqqn5vbwk55WQULoZMBe?=
 =?us-ascii?Q?LuIMBfUngVQfxwADq3hsvhCWLZH4JFox76Ib1TgRqBM024BZVSTooZtYDCVr?=
 =?us-ascii?Q?aWjzpgOhEwhEbx14fwWteLkqDfNJtYbAZP/SXXlj3PV9EIMp/mZR1oa4V4XA?=
 =?us-ascii?Q?TJJ+AnIrqHLl7uKmR7625sU80SIGNnkhLTC63eozlauk+10a/0XeWbAURYvM?=
 =?us-ascii?Q?L+s5TrawFBc/FUEfC01G9JdxQlktUhgpX5Fc/ui4/e0RoES7O9P19NOR3jFu?=
 =?us-ascii?Q?Fj5mcxCslKuu54t0b6N8lmV+4fJE/at7j6iw48iMPC1AmqVzq3ZZCiuF9MFC?=
 =?us-ascii?Q?y8AP2Mg5W6GRjU/We+mR9LfyZWDeCgPvyaOSiNuUW3nIj/ZyvpBiAxaQD1jq?=
 =?us-ascii?Q?F+OQf4WMX832Ic41vV+r7pPwctfYXmxgAHo937050Cmvt/ChwJ4xwtDdY8FA?=
 =?us-ascii?Q?eG+EnrCuLl50XdaLYXNhQTJxMiB0hoNFWL8ZnJ0SxF/YHTPWIEBzvuNyACJw?=
 =?us-ascii?Q?x41TFmG1z0Sh2H6gxog4vy8aWCUOTyWL9zOCCAXE9fnUc2Du1IOaUPWMXrzu?=
 =?us-ascii?Q?0979ZNpu+2qr3RbEYQvLpwlaWD2ctPrKSlvFxohlKsORW9bQ4L9L/FChiLGb?=
 =?us-ascii?Q?qi1TVQduem9Hvu75pabNbLFrn1RmvphDealQiVVf6ad5ApLzcggZ7QUNqW+H?=
 =?us-ascii?Q?TtanEBYBQx45zULhkTnTMEDfcpEUfs9GoT+GkEpPJTUbWYWCczinSMertu+/?=
 =?us-ascii?Q?rXI/mNo4NHV4vLzT4Y+G8IgwD+bM7Q51gfppE41cm7aMjqLQwrxzxFi5oJKK?=
 =?us-ascii?Q?tRm+GFBb4mxlJb/xUklNQbN2IPtrT+X0a8/EwnNPEGIq6Ajv7i2n13kO5vgP?=
 =?us-ascii?Q?oZkSUtDr3Eux+oW42FtZNGV+lsenkL2z6uUaqFi7303QURyB2soYxY0Q2KsP?=
 =?us-ascii?Q?vEIgEkGcggXuzs5sOmp0gg9XGPcz4vSAr7cwgV/WEi7hVtKf5o0G4v0MQDrh?=
 =?us-ascii?Q?ypKtfwb0Pg/8+T2Dnfj+Hk1SNVqB8Vi+KS9Py5n7725rPDmOIKSdSZEufktU?=
 =?us-ascii?Q?GZjRvg/YcrWPAqr2tk85wZEJRN1Fnc1qYP6vhtQeznQWODiJ2I8x5DivP1sw?=
 =?us-ascii?Q?ory0mmT8ro4tZW5m31MYB7SvD5Gi7EARKNh/KSZnbpoxtTWuhGOQrLl4M7CG?=
 =?us-ascii?Q?ojBvpF0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:59:05.9795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39172584-af73-49d4-6adf-08dc636b3fa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

Make pstate driver initially retrieve the P-state transition delay and
latency values from the BIOS ACPI tables which has more reasonable
delay and latency values according to the platform design and
requirements.

Previously there values were hardcoded at specific value which may
have conflicted with platform and it might not reflect the most
accurate or optimized setting for the processor.

[054h 0084   8]                Preserve Mask : FFFFFFFF00000000
[05Ch 0092   8]                   Write Mask : 0000000000000001
[064h 0100   4]              Command Latency : 00000FA0
[068h 0104   4]          Maximum Access Rate : 0000EA60
[06Ch 0108   2]      Minimum Turnaround Time : 0000

Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Perry Yuan <perry.yuan@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/cpufreq/amd-pstate.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 960fead0b83e..510b5aec42ea 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -756,6 +756,36 @@ static void amd_pstate_update_limits(unsigned int cpu)
 	mutex_unlock(&amd_pstate_driver_lock);
 }
 
+/**
+ * Get pstate transition delay time from ACPI tables that firmware set
+ * instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_delay_us(unsigned int cpu)
+{
+	u32 transition_delay_ns;
+
+	transition_delay_ns = cppc_get_transition_latency(cpu);
+	if (transition_delay_ns == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_DELAY;
+
+	return transition_delay_ns / NSEC_PER_USEC;
+}
+
+/**
+ * Get pstate transition latency value from ACPI tables that firmware
+ * set instead of using hardcode value directly.
+ */
+static u32 amd_pstate_get_transition_latency(unsigned int cpu)
+{
+	u32 transition_latency;
+
+	transition_latency = cppc_get_transition_latency(cpu);
+	if (transition_latency  == CPUFREQ_ETERNAL)
+		return AMD_PSTATE_TRANSITION_LATENCY;
+
+	return transition_latency;
+}
+
 /**
  * amd_pstate_init_freq: Initialize the max_freq, min_freq,
  *                       nominal_freq and lowest_nonlinear_freq for
@@ -848,8 +878,8 @@ static int amd_pstate_cpu_init(struct cpufreq_policy *policy)
 		goto free_cpudata1;
 	}
 
-	policy->cpuinfo.transition_latency = AMD_PSTATE_TRANSITION_LATENCY;
-	policy->transition_delay_us = AMD_PSTATE_TRANSITION_DELAY;
+	policy->cpuinfo.transition_latency = amd_pstate_get_transition_latency(policy->cpu);
+	policy->transition_delay_us = amd_pstate_get_transition_delay_us(policy->cpu);
 
 	policy->min = min_freq;
 	policy->max = max_freq;
-- 
2.34.1


