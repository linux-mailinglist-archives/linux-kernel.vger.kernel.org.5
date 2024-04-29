Return-Path: <linux-kernel+bounces-162283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A0B8B590E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D7C1F268E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB066FE20;
	Mon, 29 Apr 2024 12:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rNhix4IG"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31B36D1CE;
	Mon, 29 Apr 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395031; cv=fail; b=mQ0TOA4jQJVFMOUbVjr6Okwekq8R75naNuBaOvYDg76qADUFoq6MSw2UieWt5rIg3mcs0LtUW9mx+VU2rCR3uZuopEdPBCIQLNg/TgZjHU2mt+eQpCfSRZZwzXarJcO4VtsZZ57f0N1ukMscVznCe0+qQd7gTnHPtJfRblAAZ3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395031; c=relaxed/simple;
	bh=647u1z3wRbEbaOeS0NL+K0zW6YDbrE4mrsl+FRUBytA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EtJ2lSv+MudSSu4wi8SA2jK5dLh0pbEUgR3DYXKNDkvZSMu2VatooAreU9TUWvezZZ3mQBEGP2hmRzupP2kUUeno/jKtICX2UMiM01Vvtc69zqa3NV9tDvJOgJuxLmEjM6qQbw2vHH4dtNuBo9GKjhvpLCKpVRRVto/I+W0ov24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rNhix4IG; arc=fail smtp.client-ip=40.107.220.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTRjyAM7GahJKe6HY669c2Yvd0OjrIvk8ZnD+BXta4jeERaZE1u0Vhb1y5BkdHurzAS1yLw7pV1/hyf0EZPQQV2xgaxU6GvTVSbO3bCQRhe9B7vDCbdFwkoW9y7oczL5H3WpA/keKLimCmrsmPOA//L91NRaepxi/Ly2e0rt2JdJfKZH1171gstBqamoc8+Nkz+IpvzaEIzyywimoZ1aFT7Ng9WlUA305DBx0WCp9//QjpqwsZLhjdlWqpJq5B71Y1dcfYZzXNQEGscqTD3bUXZEzbnntVjMsv2aSRLCEdmp9aFgW28uueTdk1CcYv1gaupJzODOPXQc7OUd9v4H+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=niW9aluuRDgXg/9tBkMES3VXIKqefiCWc4+9vax4r99WdatY9QP24m1DsDwYQBp1oHcMVWvFZeHA50Xsxp8ub6rJYhSs/VIXZmiCs4C8HWPOriKKpIGyouvJv+Njsbx6d4YwK5i0oXoaByFYqB+36SdaPx63rLQpGI/Q7L/0zxJ1cQ0Tc4fntKu6xhIELEH8oR+GGTq3nY2Ms6VmuvZj0i6qFvn7vZAa8a9+bXSWZUakqzHVJ3SFycT/uBoReMSADG8CN3sD8+wlcR5pXIj2Vbb8yuzVdbdDU4OHHwLcXWcNsOubbaxryaljcnSRHTN65z4qkRm8WsDdCoNNTMzyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=rNhix4IGyydneQIAH52USFvZdlPBArHBXe/h0RKoE7FS2OVoeJ93E1FbHGgHJzJySlnhrR/O0nxbIdB5iuIeREwmqe5Ijp3WLaQpbxUe0vgKSVFFgNOfh02Ux/JhMCZzUvLfsQ1e1XlwRefrU0S67NZWU+pYJlM3jnVVL/Auq9g=
Received: from MN2PR14CA0028.namprd14.prod.outlook.com (2603:10b6:208:23e::33)
 by CY5PR12MB6525.namprd12.prod.outlook.com (2603:10b6:930:32::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Mon, 29 Apr
 2024 12:50:27 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:23e:cafe::67) by MN2PR14CA0028.outlook.office365.com
 (2603:10b6:208:23e::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:27 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:25 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 2/7] ACPI/NUMA: Remove architecture dependent remainings
Date: Mon, 29 Apr 2024 14:49:50 +0200
Message-ID: <20240429124955.2294014-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|CY5PR12MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ed3f78c-19ed-4606-0f9a-08dc684af1df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?338ZUXAVv3Og1nFCk4cu48A/vRe/x4RgBsT9saZ90atVSJwRJe8RAlTubu0t?=
 =?us-ascii?Q?WQNssDmcW3IrgHOa7qaH5AIGf8qXKELqriE2BqCpv8+j2aqP5tSnRYQ9CLxg?=
 =?us-ascii?Q?GVYOrGrYeKlmaVYm4qKgJ+0x3EjNjpi8R/4066oFfWR0fg3h1GOKDjpTbyYp?=
 =?us-ascii?Q?LBogya7jBIg/Ln9wIws9dx4GwvJUgjcTLM8CcEimzFzZUYRq6NYWGEpaB95G?=
 =?us-ascii?Q?aR7vGy0MtXp9N48o8//fF3hHpOgnc2vBcQTuKMvlEkMFM8mjBtGhyUcAw3Kc?=
 =?us-ascii?Q?AL3+J9kBgtaiQbJUC/vAmBkS0T9xOCkzeDwOikSezPWmYtuLD6mWhyYDX18Z?=
 =?us-ascii?Q?weSehx76/kmpCCXBrqGIhUbx4ef1xMh1NFcpPSW/RuJzSFB60SOVP6iAiPe9?=
 =?us-ascii?Q?95/aKIcbHxcFdo8bDOIQqVovTGZ4ZjSf5kALyMxLyebW9pq4pbFqIZAloTlI?=
 =?us-ascii?Q?9jHDmy6Nv35PDlgfFLLRAuwfNxe3mCydZ6skD1YytaG5002N4vmGDFPuaGjs?=
 =?us-ascii?Q?SmkTBIiQChJWobtHimVH5FHvr+mMi06F5YDQyP4pbkFk2cmFG1ORQP0+S3jS?=
 =?us-ascii?Q?3ZiAby59T2/XaK+AaUBw7i56lJ6rQs3UAW5wKVNt1NEh5r3ys1dMTXaXwYNn?=
 =?us-ascii?Q?RsTXrE2I8Ab4y7rlZlZOHwEr7E3mS+GgxbqYKkDCyhiV/TrWw33wJJ36J2ue?=
 =?us-ascii?Q?n76KKV9JnhKtTX7azKrVCYZ8iHX9rn/q5phgX0Dx3KUzgq7elYKhUQkS6VlI?=
 =?us-ascii?Q?0dAMjrQssqAQa40cqyc64N/boGmxjqDDfpNK3JIpag+Qj+1arZ3uC9B72N5G?=
 =?us-ascii?Q?Z7uWxKkGjOd9ydiaWNbubcj6AjjpHHzM+dd0+f3MtNWfcmkdeICj0Q1SsB+j?=
 =?us-ascii?Q?DhYru4COpAf1xtIRxc8vPIYTO1KdM+0eetkcAbX9S1ghMtLCaFvfczWUD7Gu?=
 =?us-ascii?Q?USSdM5bS7Ik/HJw8jXAobwAxJ7N/vJ8vXN+s0IDPPOvqNna7FiM+jym+vUrn?=
 =?us-ascii?Q?olXLoKSJ3yr5S9S/UgvkO7vUzEJ7w7Ij6vIGAiCLcRh688JRDf+3RYTL3ctk?=
 =?us-ascii?Q?i8h/Il+pVLll2BwgJsJwOAtU77CfCMUZuP2AJL9W6jt/BELSVBWkgKMqrFwl?=
 =?us-ascii?Q?NbFzf8BFPT6/d1T15hn5YfG5xuonl8YV59I2pCmUGEp/FcaOnGX6ZwUmn4BV?=
 =?us-ascii?Q?63COYmLdI2//+uyDzUjulGZul0YK8IxLNZtJ111/qpWrDMT3nQoEtIdFqKi5?=
 =?us-ascii?Q?sxIGPpk2Lc4XwfwFiq813ClV4D2DXWuDfOxkYkuDqUIE4eHvE7yW78f18vZj?=
 =?us-ascii?Q?MzoqlS9ivCsp/oGxv+buOFDWzKZWF+sTx5093O+Nux+TCd/cJqZ4IiSu/dKA?=
 =?us-ascii?Q?qOuw7nU6gSCD6BKmvAHoEMx8N4mO?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:27.4095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ed3f78c-19ed-4606-0f9a-08dc684af1df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6525

With the removal of the Itanium architecture [1] the last architecture
dependent functions:

 acpi_numa_slit_init(), acpi_numa_memory_affinity_init()

were removed. Remove its remainings in the header files too and make
them static.

[1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 16 ++--------------
 include/linux/acpi.h     |  5 -----
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 3b09fd39eeb4..e4d53e3660fd 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -213,13 +213,12 @@ __weak int __init numa_fill_memblks(u64 start, u64 end)
 	return NUMA_NO_MEMBLK;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
  * not supported at this point.
  */
-void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+static void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 {
 	int i, j;
 
@@ -241,11 +240,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 	}
 }
 
-/*
- * Default callback for parsing of the Proximity Domain <-> Memory
- * Area mappings
- */
-int __init
+static int __init
 acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 {
 	u64 start, end;
@@ -345,13 +340,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	(*fake_pxm)++;
 	return 0;
 }
-#else
-static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
-				   void *arg, const unsigned long table_end)
-{
-	return 0;
-}
-#endif /* defined(CONFIG_X86) || defined (CONFIG_ARM64) */
 
 static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..2c227b61a452 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -242,9 +242,6 @@ static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
 	return gicc->flags & ACPI_MADT_ENABLED;
 }
 
-/* the following numa functions are architecture-dependent */
-void acpi_numa_slit_init (struct acpi_table_slit *slit);
-
 #if defined(CONFIG_X86) || defined(CONFIG_LOONGARCH)
 void acpi_numa_processor_affinity_init (struct acpi_srat_cpu_affinity *pa);
 #else
@@ -267,8 +264,6 @@ static inline void
 acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa) { }
 #endif
 
-int acpi_numa_memory_affinity_init (struct acpi_srat_mem_affinity *ma);
-
 #ifndef PHYS_CPUID_INVALID
 typedef u32 phys_cpuid_t;
 #define PHYS_CPUID_INVALID (phys_cpuid_t)(-1)
-- 
2.39.2


