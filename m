Return-Path: <linux-kernel+bounces-162285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F518B5910
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F18428CB4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A0674BEB;
	Mon, 29 Apr 2024 12:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xmubwddv"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE99745ED;
	Mon, 29 Apr 2024 12:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395041; cv=fail; b=I2LPcA9JYxp4Gv7UjVdiuEfEHd0Lq/AZZhHOgW4hm1DMnhHyTbEQkCO8PpkY0DRnKoJ+s82DzH/FFy/edjqhAe0mB/+/KpDezK6kbTgCBY9jaShDTy/aTi87TyUr//2QLwbjlrb0ihl+yqAQlTHvpTvqtQekN/n8h76uGmEjrOs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395041; c=relaxed/simple;
	bh=GGVOQyQcshRXGn7vgXDtIcG0ullrNrrKkucC9HaihuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjZjLWM0Of3ekTpBnSBBew4+ZpOj/bVVPm5SgxMd6Ii8r9ec5JC2old4nh+qQwmk6nyxqV+Pij5rqoGDnPiKNZ1wA9gpLTRmpI0ThQ+TjS9ZoayH5Sfn+W9KBN48CkI/m9rG6BYeigNOy3FDYPpv9THqiLXFiXPzEushphJloGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xmubwddv; arc=fail smtp.client-ip=40.107.236.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7MWsxpxoSxoEGBtxsLFbKuus79x+QcifUDgRfMGFAhQRHBtukkJxriMCBGkEepT5w0gm8BsEAfWuO/dElvzRJpz49xF3wLWCFmeYFUnQzaxILR3lGstLZ6O1/KdSslUJ6KfIqHHZfaSI6IfE9QebnEZv89EHGBBK4/BvqXfoz8VHktR3zRoKEAnzuRa7DkoOnw73ib+mW6Y7ZydxIE6hakYl5FNzrEBkNh++EseG+BWFzyBAvR2Ff2lqwgO3AGfJ0W0iQDvDBf3q2rYHqQBY+w5fIgS5Z63VNgKPGrGOTRSlZtjOJXPU77UMlXVTcqOY6DlMSMDKpv70LZsf5Br4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=ggxpZkpgtvQ0PjdXDU17GTz/YDyMLQL3sGzocybybV+lf6mUcRpz57KMyhNk0csDyNNXK3E0fIEHrz8yd5+AqzCcrV1gLRy14DqcUP6VXh60J0Q1wBjcqkeKsGVG5BOg68ITipvl46RNhV7ZnzUSdJ2jgrCcZa2DL9nG/9vlnrfmxF4TZ2m0IYPNBgYaF6Yxh27pj1OFvbMlAtiJA08devlL+1kC46q7nakF8Tt2lg9nCpjOsPgxYPQQ/6aTbMql618L3ee+FcwQyCT9z9GMFX+z2ki3XINVQKPk3da9csxxtIsazc7zNod5mxZsrNnI4JTx3ePtCPOBcy1RRDJNuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=xmubwddvKeqD2Wx3LUlPCRGFcWkns4lx9Rj83aeQ3D27w9lQ8mmjKaSw1iEF2uihshdLZOUHZ9M5iO0BNtEuF6PQja/aB90wQjfKyyFtxssP8ozlWDjLr0kY14yc6fxJa1xX4MOZ+F+vwFCNPtzHNfWC6Ajkb+p+nlseYBAQbiQ=
Received: from BN9P221CA0023.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::11)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 12:50:33 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:10a:cafe::b8) by BN9P221CA0023.outlook.office365.com
 (2603:10b6:408:10a::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:33 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:31 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v5 4/7] ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Date: Mon, 29 Apr 2024 14:49:52 +0200
Message-ID: <20240429124955.2294014-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240429124955.2294014-1-rrichter@amd.com>
References: <20240429124955.2294014-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 8da6316d-e169-43db-04f8-08dc684af59b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|82310400014|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6qKijajPGX2AnymXaXUBfRqrH70NwowfTC8sHafB291IGhX6VklxRhzfkCea?=
 =?us-ascii?Q?SkNSJVBMqQFvbHt2s7nXSOCv1cb9CIRjr8opCLSxrN6CjrkI9QlaQ9xZsOCD?=
 =?us-ascii?Q?M+uipxEQaPffU2w41qpEa1LvHnOzlBPTnspxs1hHaABj4MwPAj+O4eA6ZznR?=
 =?us-ascii?Q?OWGZ6xQ9MbCcT0B0xPvkpCRhUWiCEsrjt3nAZ7IiNUpCpm6debrGvV4wSddR?=
 =?us-ascii?Q?qfcoMY8amIpWbm14qRUaPNg9kSDSkdU/LAtoR1BnI67VAoSW4DO5q1WUmMNm?=
 =?us-ascii?Q?Z0TKFGrQxh46w3mmkexDQKqsHHxDvEOQYgU1ER3KppNpF8PGtfbx05j6ThbR?=
 =?us-ascii?Q?RZXKnzYUd+wuxr/ktnRfaDtomXmlVZdxftdnDV32e5CsYt74cEBbBl9nYPyB?=
 =?us-ascii?Q?v4fqsMIrMq3veIWnQB3BcGf8sK8Ez3c8K2UvDniJjjBrAy/VocsrcuU+zmiI?=
 =?us-ascii?Q?AJHYhOG7TthKDKxHIVMdibM6fkdQE+0X/NNT0xtaRDtQ+57w4la/BPM9ezKC?=
 =?us-ascii?Q?QD5jPWcNnFsOoMJHVl24kpBkM9hUYVR4zLfo+jVfwE6Lmhq8Rpc7tQdWI8TK?=
 =?us-ascii?Q?KFAaQGiUKIIcxMYhiV6j16BuJJE7tr8qAl3H3d0LgKhGZam7LXwr71J6Mz8f?=
 =?us-ascii?Q?baOhCKbSaUcImGrHMjjDzB3eqlOrsxtZnGgL61vYASPAFHgiUq9OoS/A/5YR?=
 =?us-ascii?Q?wTx0IYr0dm6YukCgQhbXmw38BpiDNnQxYEG09TAy9IoZ1cQK/+H/EP4X3Lr9?=
 =?us-ascii?Q?vdj3ILir/zfwwZHjwr84KyhPSMA4Yzp0D1nUSlLpE6Q3yXEndrjDyWXwOJEY?=
 =?us-ascii?Q?sQLiSTtHM1bTz7Xa3Mc/rChXnrGNAyQlU3CVpw4XS03IXSUtmzpiRvAhYiKn?=
 =?us-ascii?Q?NFVLB9tprW28dNH8AwQeRvuGkrMb19sany65Q9wRCtFrkT9U/tmWTja/L/Qk?=
 =?us-ascii?Q?dE3xUc4PGCGyiemwow+x+gYW8Ot04W7qKHfG9rh2sYvFKp8qGgcQWSfZFrzZ?=
 =?us-ascii?Q?3KnbJPsuc+1VltTuXbLlbQwpBji5RO/sWYUU0+Fp1eJOSFaCoSRT4Ubsi1VJ?=
 =?us-ascii?Q?FusFe7CnqR6B3Ms/N4aqv7W0TaK+an1uRTRVqmKwxVvnc+k+C8Ce8h5QK1AY?=
 =?us-ascii?Q?bLqn2DSElZzt1WeF3BGCmg6xotXAmmhohEwjyG58E9fQl8XxLljuJdgUjUIq?=
 =?us-ascii?Q?gYvJvYrvdXL2IaPjYNBz82eZgkF04kutOU3EBf1MMDg9T4NCRLtIwwU8nFyZ?=
 =?us-ascii?Q?aMsHmrgfQ/qb4+zexZq3EIUle+APWTE2NYnIcJS1pC6MfmvXlQnrFdQjFMMs?=
 =?us-ascii?Q?mdBoWLGcPka7sSz1tmbQ3FRN?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:33.6744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8da6316d-e169-43db-04f8-08dc684af59b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

After removing architectural code the helper function
acpi_numa_memory_affinity_init() is no longer needed. Squash it into
acpi_parse_memory_affinity(). No functional changes intended.

While at it, fixing checkpatch complaints in code moved.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 40 +++++++++++++++++-----------------------
 1 file changed, 17 insertions(+), 23 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 430ddcfb8312..e3f26e71637a 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -248,22 +248,30 @@ static int __init acpi_parse_slit(struct acpi_table_header *table)
 	return 0;
 }
 
+static int parsed_numa_memblks __initdata;
+
 static int __init
-acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+acpi_parse_memory_affinity(union acpi_subtable_headers *header,
+			   const unsigned long table_end)
 {
+	struct acpi_srat_mem_affinity *ma;
 	u64 start, end;
 	u32 hotpluggable;
 	int node, pxm;
 
+	ma = (struct acpi_srat_mem_affinity *)header;
+
+	acpi_table_print_srat_entry(&header->common);
+
 	if (srat_disabled())
-		goto out_err;
+		return 0;
 	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
 		pr_err("SRAT: Unexpected header length: %d\n",
 		       ma->header.length);
 		goto out_err_bad_srat;
 	}
 	if ((ma->flags & ACPI_SRAT_MEM_ENABLED) == 0)
-		goto out_err;
+		return 0;
 	hotpluggable = IS_ENABLED(CONFIG_MEMORY_HOTPLUG) &&
 		(ma->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE);
 
@@ -301,11 +309,15 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
 
+	parsed_numa_memblks++;
+
 	return 0;
+
 out_err_bad_srat:
+	/* Just disable SRAT, but do not fail and ignore errors. */
 	bad_srat();
-out_err:
-	return -EINVAL;
+
+	return 0;
 }
 
 static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
@@ -438,24 +450,6 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
 }
 #endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
-static int __initdata parsed_numa_memblks;
-
-static int __init
-acpi_parse_memory_affinity(union acpi_subtable_headers * header,
-			   const unsigned long end)
-{
-	struct acpi_srat_mem_affinity *memory_affinity;
-
-	memory_affinity = (struct acpi_srat_mem_affinity *)header;
-
-	acpi_table_print_srat_entry(&header->common);
-
-	/* let architecture-dependent part to do it */
-	if (!acpi_numa_memory_affinity_init(memory_affinity))
-		parsed_numa_memblks++;
-	return 0;
-}
-
 static int __init acpi_parse_srat(struct acpi_table_header *table)
 {
 	struct acpi_table_srat *srat = (struct acpi_table_srat *)table;
-- 
2.39.2


