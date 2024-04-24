Return-Path: <linux-kernel+bounces-157247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9778B0F10
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2A8E1C2372B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBC1116D4EA;
	Wed, 24 Apr 2024 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cFCwu7LO"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2066.outbound.protection.outlook.com [40.107.212.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF591607A2;
	Wed, 24 Apr 2024 15:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973771; cv=fail; b=DVh3PnTsyFegPhxk2N1zCbinJljPHR2pAWELuWI0jbszmUyGERNyKN1XQBv9EEZJ/Cfby9SbDOGFtrxnUBJZ2h45yF28EJINw+vW1JV69eIyufhePGXe/pswd1YHNk/YsDgQIAr9SmmhC82xs1R415pXSrCqCPm5xn8CCC8F56I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973771; c=relaxed/simple;
	bh=GGVOQyQcshRXGn7vgXDtIcG0ullrNrrKkucC9HaihuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rEzdycQhzx5AoEdmgU4GvzarTHNojSJpPvo2OHf1KBUKVV0CAUY7jXS2oB+h87EqXSh467HVgBduslaL2lJDBLn3/NxielBmIooKY+PVukgG4U7puM4HV0RaEZ51GURlBnGYjGTYoARqDHoS9XgvSx+FQ+w3DwBJNnFa+xMTwJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cFCwu7LO; arc=fail smtp.client-ip=40.107.212.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dL7Ef0NPUo2yum6xVZ+Iou6eASVh//t+hrpYBhEnhUbgxfCSqMbuutHSmJtd+s4r4iSVtl5DqlufyZDKUz9umX4rU+/U30e7JjgWLeYefi479pqSXD1NIyMatjmrva1Mgc+JrKgPrTOWTUGqOyI7ACJv/K4yj+6y9qVALUHxl3+Sb206MLXPfKCUuUD9SsHFi4c4I7jb2taqOJkFev+O/ibsNXGF1yb2QSOuiuXgB1Q/JQXGOj5nBFf9O9ladOxrWks3dHlOz0l9RZCRqQTVKZiwDDj/XNn2YgF9CtOcBa7X6sQ3dmQbTqeOLiY0SxKCPkpcFleoVOcM94Gnza7g6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=TqbieWBulcPzqz/ovvlSsKDwuuAADp5bJXGn1NkpCtIOfVxNrfbGnN/OaK+XaMxsByjNR0VhIdI+t2fNxhr8krnTghylK8K1aQVHk1E1avSPKkYIR7gUCbRcVXwsYQiwxrOy6iMSUn5CVPfycU3xwfFw1m0l65OJa3YDZePCzwpnbTUIxdIOI9ewRi2Qm3cqLvHWAcjptiYhXbG5XeEUtLSEDiQaj/230UV+mU+EjZ5kQuxutvR+pfjD7jsqRo9WXtj6eqIKQCbWoZ141KXD6guVcrpeI6z2VfKXl0fP4NnrRZXLUtOmzsxYc+bkySmEdVTmEoyhrRbYiBXRtWP0gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkL7D3UE3FQj+F2O0O6sABtRz51PmXjFWY+kdAxvrYk=;
 b=cFCwu7LOsg3rNl7HK4v7Wrb1W2dEHB2Tqiw7CqKPjgfVsivcm4m442XkW8q1I5vlmHIi2IO47aAcdX/DyhBdQC8YHhAAXOEtzOeyOg14HbswjOkRuUCGPTycDmdF/+YBurPtwETRAUh2KaCR/IvlXtWZtr2sbn5Ba4KurWcACwM=
Received: from BL1PR13CA0336.namprd13.prod.outlook.com (2603:10b6:208:2c6::11)
 by SA0PR12MB7076.namprd12.prod.outlook.com (2603:10b6:806:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 15:49:26 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::73) by BL1PR13CA0336.outlook.office365.com
 (2603:10b6:208:2c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:26 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:22 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v4 5/7] ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Date: Wed, 24 Apr 2024 17:48:44 +0200
Message-ID: <20240424154846.2152750-6-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240424154846.2152750-1-rrichter@amd.com>
References: <20240424154846.2152750-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|SA0PR12MB7076:EE_
X-MS-Office365-Filtering-Correlation-Id: a2ee16de-8051-476d-79d4-08dc64761ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?17ZotaIhXAeR2FAj+PiiwuP3OhLu9Y2Wh6gVh1P3UvmALLiyysnMw8alxwpw?=
 =?us-ascii?Q?NN6mEqSWmC/96vJaHX43Jf6Sww3KY38iN//r2D8gPztuH7GVCss8TOszElf0?=
 =?us-ascii?Q?GVBhaYpTozpIThev6NQnE0TwslTKd75mGIGVpbHm1vWKw/AgIzP+czt7nSen?=
 =?us-ascii?Q?ynuB/2PfrLzTPQiFa+mgAZyanrp5pe1nN91uHdjB2Jn9B0kysfXCd1nOGL7f?=
 =?us-ascii?Q?bKwoTrp+JTqf2osdIzP3xwT2Pd0IwfaaRM0hTL/RyeEpBM+CBy/p0vIKgniJ?=
 =?us-ascii?Q?lXxCSRVR8I5yxlhlIAZEltUnt+IBQOhCptbhO4ZaIuML8EtQTBe//BCEXJRL?=
 =?us-ascii?Q?xOIBP1bDZb3GXWSNi6Ac72ch2Y7QvG6LIDKhcz8EP+E26PpulpRrsAznviEO?=
 =?us-ascii?Q?So+n9hUicnJZe5pVcQoujxeqH6zbNgPflBk5qGdCo2YBfg9re+lz539DzB3y?=
 =?us-ascii?Q?43ritUSwl8xMPVsptdGrTbGyU9YTq2Dx52q1VpLIqZ/22BXTNManL3WOLvH+?=
 =?us-ascii?Q?xS/TFS9jmBTaprmVaoa42YqXLaGtO/uhfBurncOPdkAsNLOXsj6E3WIH+QDd?=
 =?us-ascii?Q?9e/2i4QA826kNOU9aCbff59nUtdW+LV/8PGZEql8tcDQBRRq60jw2GyQJ4A6?=
 =?us-ascii?Q?BgsjsnnV0RBv3c1wyGvj4dGC+J4KqCkDvptPTGlfMoMMrb5gCGm2RXZR+ZqU?=
 =?us-ascii?Q?pMN/SnFPOcDwkypFvFWbfyu2zVlbcV8yXT0PxdUSkNDZsdXmWVTWLlUSEeWN?=
 =?us-ascii?Q?ImKO8aTgw+jIOeSrIOi2ifhRhh5IF8lDWx8nCivWhivhUDIdTV2QBsoVxU+q?=
 =?us-ascii?Q?x7HL+pqsKoAK2BNR1XHr3qjjQALcp+9sla6e7gZdjajFucGAidheYfSb9/Et?=
 =?us-ascii?Q?Z939QW/1/qPlygwAY0VeUgLL4f1XkCI8f9cSnmyVAD9txcV0LfeM1pc6GBh2?=
 =?us-ascii?Q?js2qmcp8jkt+hdGfojzRnvuffOpGWOCSs2WLeBsJypNvYpwWc1U4ha5mY8zI?=
 =?us-ascii?Q?YHhfiHc4pxjOE4eCt5uwcl7EYKrJtD2d+El0uoJMfhNrFYFkSI02a//r6IDC?=
 =?us-ascii?Q?eRLOMEsxNk+Q7WEPCzbILn2Iun3hmvvnEqdZZEzASZJrVhx6SCHLBDgnmiHs?=
 =?us-ascii?Q?llU2OrwidifhUNsBT1Lt+opTZcGIqXjLYfytiR82RHfJdZ8tTDxdUh4ZdtS3?=
 =?us-ascii?Q?7rTAKi/F9LZFk7wClmS2b11ns2em6MRgZXyrd1voe15VXQ34b7t86L8tNBX+?=
 =?us-ascii?Q?WTzSjLVHkHD0wQhMxPrICIvf6nyF1IrL8u7s5FiD8QfVqQe+6EwSR38QTmvk?=
 =?us-ascii?Q?scBi+TeKh4Z1cRAWd41n/KZa?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:26.2116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ee16de-8051-476d-79d4-08dc64761ea1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7076

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


