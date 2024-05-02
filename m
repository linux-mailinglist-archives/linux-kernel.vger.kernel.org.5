Return-Path: <linux-kernel+bounces-166488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CFC8B9B5A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7D201C2214F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7922484A54;
	Thu,  2 May 2024 13:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YYNPtAB6"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28B983CD7;
	Thu,  2 May 2024 13:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655452; cv=fail; b=Ih/nBN9Sd95zyYecWpEu79x3ALd9YXnBEtsycb/FCNvh1pgmBmVdN/WseAYWvYxD8IxHJGt9k9ebt1J3OlxEooKX2CbT1CrDtrcz+wLcR1IXt9d7E1LG42ZLLe0egMNwpGhTaEt2T36dFuA7+8N+Sfyjj/FQnfhipgtcfvI5Ahc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655452; c=relaxed/simple;
	bh=HeKeVI6KpygkIb8BFBFE+pakQXHevgTfaW1U1phxRZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebiC3Mo7OzXT+7lxMlK6kyO5w7UNVmkj5Iu7b3YQAnJjhJvu64cBCh0b8y36gT+hs0NetEs8J5DwK0sRBxR8pl3iqMkXb6b6UL5bm2kj5PesibKOfepmch725fTJKFveIoICaE1vXGo5YEHIcZvPPYq0gcbbBhSdYH/SwIPLZiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YYNPtAB6; arc=fail smtp.client-ip=40.107.236.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hP/diH3W/LDgV2umxGzDsQCLhMHppxFzbkXke9VlmpvpvL3Y7DONfdEzQ2DkymwZv5PrbLT5pBSkImIiOpGJ2AZ70EG3nfSKBONfdTmba5ovwrpqN0WZftNk6PQxH9npFZSeyNngaGV9vc1OMA+18QPEGHYcX3GoFEy9wQ61yCE1yF2iws+HTAoozvWnY4KKTqzS4i4MJdzHlmn1+54ffPMvBllbCDkLTiI/298G+sSfj6V54f2fR3LNXhQgEUFecRbjVEJpRIVe2vNehfLpcasA6OvQaZqW/2MqyeLQTJ/9BrYvOSX9MuckaAwHArnCphxD3QzW2H/BCUN5HdgLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79LEzeQ+aNXmEq7qPbfwWsE0OxP0u8FWNga/WfXvwpg=;
 b=RVZxeuqx+PcfLDsgMV6A5GE7ZveLYgFQUSObcCvp3yPWNQUQXgOki6HYDzM8KeIi+7b4k0wmCDcjxT/EGjxfYpvo97O1oBxEqZJHL7pWxYg6j2C7DiJ3D6vD9FPcMCjQNOu1OJqarJJknarw3o2NTt4AyDQRGPXqTv91tQjav2mVyIQyPjvbxrXFWIxw5TZe505SwPty4AjLlhOHtHbluKLEdbnRbDMMvqxk0ZyNNKEJgjO84zi4mF3qeU4Q0f7BEgWQds7ekBbUZQHTnBthq9zjxDe9e60eRg6ZPBaPfULL7qGEjr9/fHvG8kPxUclA+7j5sTpm9liV/ehtKnTgug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79LEzeQ+aNXmEq7qPbfwWsE0OxP0u8FWNga/WfXvwpg=;
 b=YYNPtAB6GhSFF40ZFrp9F0a2kXxEAKSKyUhqm6a9lYRVqclD+tVFJJuqRl83uYVdzaMuVpsHgbFdDc9Qe4NQS+HetZ156f9Qy6GK3dAUm3Acc8QmdhW9XmkZ7INF3UTQE2WzJsNqZ+GRJjwZWGrHMEKNv/EnzbuhyZCShNMZRVw=
Received: from CH2PR05CA0004.namprd05.prod.outlook.com (2603:10b6:610::17) by
 LV2PR12MB5919.namprd12.prod.outlook.com (2603:10b6:408:173::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Thu, 2 May
 2024 13:10:47 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::d4) by CH2PR05CA0004.outlook.office365.com
 (2603:10b6:610::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 13:10:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:10:46 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:10:44 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "kernel test
 robot" <oliver.sang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v7 4/4] ACPI/NUMA: Squash acpi_numa_memory_affinity_init() into acpi_parse_memory_affinity()
Date: Thu, 2 May 2024 15:10:12 +0200
Message-ID: <20240502131012.2385725-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502131012.2385725-1-rrichter@amd.com>
References: <20240502131012.2385725-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|LV2PR12MB5919:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbd913b-954a-43bc-9c55-08dc6aa947ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|36860700004|376005|7416005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6iVJr7Z50oNixksMslMzAQXGvnFuTg0gOW8Ybr27eM3US2hcjJR/MpM5q0mv?=
 =?us-ascii?Q?l7kaOt8z5bbLVBd1BKBCLj3tr4RWnkakXCEHrTHSMSPkB79xLzepqg/Pe2Le?=
 =?us-ascii?Q?DaTCtxQKC/02abthEDWnx2Ok8Enx7ZwoLJ7B/N0LuigL8QAOxayAdQbjV1Sa?=
 =?us-ascii?Q?DGBGyuFaDASgSrOn1de+SaMB9dPDqzBq98PqfCxWqw8GBWkUVUM2gNiGxJjN?=
 =?us-ascii?Q?AtKjd6nGyVcl8msYNsrIy9eLZXVuoKVNWot+XivPXVLcAfgZ9F4f1Cl1Rq5L?=
 =?us-ascii?Q?RyIlv0+ijhhTcZpc82+cR+mODWYBZu+0qYlHgHSx90MrXGJ1XUYT5UtZ9URK?=
 =?us-ascii?Q?Cy+SEc5UvPd4jNYdO+YHOLyj47pZAS07qxKTXeMjtYyOvgarRg2DiDv/RKlw?=
 =?us-ascii?Q?Cqkqu7CXfyUPLlBCmrN8rGuyeYH7FR07DoVbEwSWlWoieb7zWUQfc2m5lyQo?=
 =?us-ascii?Q?YGb6YJLA0R7kI5HUy2Kqrv8G4o3p8jNtOLqZYIihSKgVzdR7NvaneBS++Vww?=
 =?us-ascii?Q?otCv7VKkyao6Km1MFGsoO3DPjtq7Z5vItXlLQUsb2HlnJ7EaLwa8F55KDIOx?=
 =?us-ascii?Q?EWok3n9PWXBubbq28J2boDf/rWLyw6jy8p/YHP+A19MFbmQkeBYHGTMSKvRY?=
 =?us-ascii?Q?WD7a4BnM7fpylWomc2gCadPVpgN4AO4HNQiawHfmQUUwrBBiiWa/gV3yE7ha?=
 =?us-ascii?Q?FBP/hhg4gF0F2YE6PVXCtCgyceM0TaHzpuEXl6fI7By8/cHf7CmLtPrWLQNh?=
 =?us-ascii?Q?x1UkytOkZfoF/JQYlOPEQlgvGTXBZk9tobF3r5dZQlVimdEizCyRbG8fj9Cw?=
 =?us-ascii?Q?cGK8cnYwv4EbjKVCT8pok1It6NdEua0fMbgGUG6m/GVjYpNInND9PWZq/i1f?=
 =?us-ascii?Q?h0YP8rq31n/m0FigjQC6u3n3yC/HS1DEcHXnr8qlk6emKa/YjLxGsKbKGPZA?=
 =?us-ascii?Q?p4CSRz3sKhrc6bG+0e/313fc/b28vzxVpbJBVUvDUF8wW1Ner+oM/Qb4OD7V?=
 =?us-ascii?Q?Ulb1xRn6CeGga/pLacg88+lHV94U8gSobWVcvHq7FmHkiX3ZbjXKw6Agl3hY?=
 =?us-ascii?Q?CIy0KuTJStswz3CZpar8VrPgbu3Z6e1FcarbI/OSaghzaz8l6AvqqsKX22Is?=
 =?us-ascii?Q?+jQGum/MOq3SRyaxIMS47Ha2X7gG8HFk70PaHcKbRJffwFDp4V5WPca6Gus5?=
 =?us-ascii?Q?O7otTSZSwm42tbCld6tMt6Pmor6YZKhROTL64nN7VAzZjpX2cOHRp9gSls5m?=
 =?us-ascii?Q?qEoi66z9efebfrdnKdwWu9e85Ap1upEg0bIcvqjxfOTmhCfYLUdPJox4Qhxh?=
 =?us-ascii?Q?RHr9+snBGxFJ6u8FB6NOZ11j?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:10:46.9094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbd913b-954a-43bc-9c55-08dc6aa947ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5919

After removing architectural code the helper function
acpi_numa_memory_affinity_init() is no longer needed. Squash it into
acpi_parse_memory_affinity(). No functional changes intended.

While at it, fixing checkpatch complaints in code moved.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202403220943.96dde419-oliver.sang@intel.com
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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


