Return-Path: <linux-kernel+bounces-163680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACACA8B6E44
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6201B2816DC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E0D1A0B0A;
	Tue, 30 Apr 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pN+7Ibzh"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FBD19DF76;
	Tue, 30 Apr 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468955; cv=fail; b=OaZ4nF5uymnHvAGx7ol3VHL030aONzQqZoEwhmcVKeaBoAN9Py6CEtwtquNh2cNnJyKT8M3pMC0v3x99O5fTh5DeWsIeBH5MPPXMu8q44vOjkh0UVu7O5Q+6REOjzfGDecYePUeMXs747/8/L8k2/w+DxWnkb8m1fIuAU6iSjp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468955; c=relaxed/simple;
	bh=647u1z3wRbEbaOeS0NL+K0zW6YDbrE4mrsl+FRUBytA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G0q44wSqflItSEPVfx0e2GymkL0hXFiHXlTujRGbFuMZVT0qXsT0jrEW2HEkBV1+UNyN7/Ng6c+2bXsGy0ioaTaQ8k2KquVtyi4Nj6R5iiOM1KSvqq0qPI6qVoYliDJjC0fNmL/4GECdI3O56S7f6SJyEvdrcMpIxmKcO4ES8Gs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pN+7Ibzh; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6q5LHws0ZZ+SO2KfHacdoVx+OtEUGBL7mbGtVKpCV4k5WqTmAGRn10ynQ60pIUBFack6T4f7uR+jjGTHJth/trecDWQkBluFYonKBmZiiDK8srlMWKI07wVi5ggpddo7tKhE1UtI/pujE6qcAwLjDBNxtzs/xERnZduNXBo+B1iPMMZHNSEti+RICk5QRurtmT8SgKoZbG6kEU4UQHUvjocQ13ZiWxUEUO7ybll6xmoQTddS3xZwHk6rmj+ynA0qNnVNH2EbNiyoO4FGpCXdiRKL1r3U1PWRNOhr3Bxjny2g8hMtnYCduskQNCedjFksQS33sn5lLxPytHg6/2Vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=OjIwK+DqHo9DwHgUPyzkG20u6BUcyZa9w6Qg/rE2xcCEeP4ysmeWeWK5nO/ehZMcQhQ/pD3kBCdpeUF9F/5GB+shDQ2qVs9YWCLalo00R3lx6swd6rehKAG/42pVypDHSIMLMlict6kCHMifMj5fHp4RQ8MYxxCqrLwlY5G/Tlb+5IZ/OiwaAmZALQS1OOVv4+EXsdy4ba38kGA0PchyQNJhEArTiYprP7OwXaHdXJbsFOFXN/3vB/NiTU1Nfc0+3MSl51LqtNaG9hLgClJSmDno3yIe5gi1i6woeW7t0Jbxf7jKnD6UqAcq//xINunCJ2FZMLnyXK58Bb4++wchLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=pN+7Ibzh7YHiFA6HUeRzncQo+KPnowFnrNxtURNj43wbWtBMZcLqI8e6JDx76TiS+q6Je37Zi0J2jG4JivLRtUf2a9znhV2EMoQnPD2uBsE783sg5whgScNo22pOIPZh77ty5RtXxaY9ElMBwTzH2OeZACq/6bLajEahBUPTEEM=
Received: from CY5PR17CA0013.namprd17.prod.outlook.com (2603:10b6:930:17::34)
 by LV2PR12MB5918.namprd12.prod.outlook.com (2603:10b6:408:174::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:30 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::ae) by CY5PR17CA0013.outlook.office365.com
 (2603:10b6:930:17::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:29 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:27 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v6 2/7] ACPI/NUMA: Remove architecture dependent remainings
Date: Tue, 30 Apr 2024 11:21:55 +0200
Message-ID: <20240430092200.2335887-3-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430092200.2335887-1-rrichter@amd.com>
References: <20240430092200.2335887-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|LV2PR12MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: d456b1b8-15da-4192-5cb3-08dc68f70f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|36860700004|82310400014|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m2Q+RCMB8cr9yOJKZIDkY5btF2gXAf8INSUmagj5WbB6FnO/n+ydE9rSP76h?=
 =?us-ascii?Q?QSmvxQ9YexYXyCySY+7kPSktVyo6BM6nY2GtIqa7ZbZES11gBXwjmF1s+OyP?=
 =?us-ascii?Q?J/5PHCmKaBWLzAHgyEdQcrFvW0J6OID0e1Rp2bTmpUITPA4+K5WhgYKXi7LQ?=
 =?us-ascii?Q?2Bn8t+9LBR5qpysJ73uO/GaYk6/l0dbARTSqYH9rq2Fp3qcf9S8ToeKmxtbt?=
 =?us-ascii?Q?+2kNCs9ANbwWdMrTg2pTjaM4VQi/8yiJwXxc2nSu2xhTH9c6vmaYp+gfn5Lq?=
 =?us-ascii?Q?/c16zHk6uEUoD3evZYLTxWIJw2Ic5yLhP/pUAYOAj/55cMQUxjDteO6h0AIr?=
 =?us-ascii?Q?6Jzr+wuvMLUXQaTF5i/i7nGxu4VxFAA9enV1i1VVFmoxr2bYpzK873nmGB3/?=
 =?us-ascii?Q?wsXUPKHScmQh1U4M3Gqyh50zyVOeIlQtOMAmfSxdPOxKRKHT6wDwVEAD39uV?=
 =?us-ascii?Q?jCfTuB0ZhCg6N7GHj1Svirvw5SqwzvJsW2KN7Sczw1S4ouNvnfaX7URzA1E7?=
 =?us-ascii?Q?WU1eTrl6yk0rJ36rPVsP4gHLxZ/rNfz6D4cjrDZeqXTI9CR+Aa4fvL8F6CWB?=
 =?us-ascii?Q?MRtLEbLhL5BTCQVjTADdQtNHp8zPyUaHTPnoFryHgEj3VA+Y0m7zFmPfgSgZ?=
 =?us-ascii?Q?f1mPavAt0tSDGSMeMveNTkPbacULK7kwg0dTEFfeDJRkIqj9dn76rdn4KxCd?=
 =?us-ascii?Q?BHnaV0ScPObpaqpgHFJVyZsbyjVl3Ss4iSiaISuWILEQIi9lQn1lIuo+2/J2?=
 =?us-ascii?Q?4GKQIUi4PIcIBHOnyJA2hQAZorstbMzwQRCdJnVgbkQZ+gYT7Mn05NLrbue5?=
 =?us-ascii?Q?/rs6I3GkpJjjB+QU1skMUl3IdWaWbi/vJ26hGfuF/CiSGPJa+ntVKnJhWvQO?=
 =?us-ascii?Q?4f3UXs8ygd0MftTzdTdSmtAbZNJhBvGKWLJS3JggryA42SsNcfBLwchYUUTq?=
 =?us-ascii?Q?KrRwc8RQ2K71RuT+G4Iykb98WDdrhmrFaMC46r8WxB/t8LMCpWYmBUjNXp4D?=
 =?us-ascii?Q?cFXK/HplTZsXW04x+FWr1Vtr0rzOVA37166JYypEaVukeZHvnsRFpd8x/ac0?=
 =?us-ascii?Q?9KTN8szx1VFXJONKXqD1hwQsjiFcge6Nr/8aKnTTRgyRjYVab/2Upqzhlogb?=
 =?us-ascii?Q?/UCd/3Q0l7O0z0by71CJ2Icb+uXoBVHG3EbS2jQtl0YR6z0fpiMxjShF2ErW?=
 =?us-ascii?Q?gOg+SpSrUyyNfM2L5CFEthiLREdEgwWOK6nGHPJaw67QSFn9JWPJWtK7t5C8?=
 =?us-ascii?Q?8aR+OfNTOHSylyRKb+wjSlHMKCPwYtuTlB4RptkmpP8PKYQ1xf6Fp3a70obj?=
 =?us-ascii?Q?ioyNVmPv7Dt9xHtYhgnm0JzxdSOXEIFeTz9GBFhy2GX41qiSlpvMYh/vyGW8?=
 =?us-ascii?Q?KGcIdLYUPe2bHNWMIWURJgYjB7em?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(36860700004)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:29.8885
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d456b1b8-15da-4192-5cb3-08dc68f70f21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5918

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


