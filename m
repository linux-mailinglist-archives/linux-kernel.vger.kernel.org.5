Return-Path: <linux-kernel+bounces-151533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ABD8AB022
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 16:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E04F285494
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 14:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D676C130AD2;
	Fri, 19 Apr 2024 14:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OW9plUay"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41558130E5B;
	Fri, 19 Apr 2024 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535373; cv=fail; b=ZB5jvOOrYscNZTw7pJNmokIqdtcddHXiLDuIXfCp4Z2eSIWHYhtLsyJDdi5fT38gaDKQ19sNA1kdKxZm3VEscph0duntDpREJLLRUMC9m8eKBvmHRT1J1rm0nPTaOG8QiEKGWMYxQlWl4AGjXwYaKG/PdFvXJP2pB7wqsN2zhRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535373; c=relaxed/simple;
	bh=nrg5p98izyopO9HGKONQg/HJ6PetVNP07gVz7ax+tPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pYj4qMZK+FzfgBX05LNzZ4BFbFB9JiCCi/plJa+1Q4lo8YyWJAxyk9UGijlbXUiWWqYoEJJIgo05q+0EQvhXg3EA1DWyYUuUtVgnPytV/PbjCvvsKPxL3Efie533Ls5c/kcm4lShXKoVJd6+roOr+B/rp8+Q7c+kefYoMuaTvu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OW9plUay; arc=fail smtp.client-ip=40.107.243.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYpmoOO3ecaYMVJ9eJcBcCd9mo+xp6ur9J3t4vAte8Msb0IIfYGoOnxGsA9POMlZNIs+8AJhmmdTEdYGxyn4WUihf5v2H22Fq3eKHK0LjOTUHY5pDFKGbXPoVVGyWgFSdWfbyjicpmn3MnB1pVexmnrHAlEfzDItZh5a5PbwAg0pyvADijGqKbAAkgtfCiobtWnNfLP9Kd3osT/V1fhfFYb4axVEFvnpq6Sx5Sjfvbktf+xM7fzyUHbkOkjyPUCoEnL7D/EO9Vv1KloaRadxquStjusfN+wqWXdV/OcmujuIUB1U0JomNBJrPxpN4atBrifj+JK9+EOu6f0EHqIZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbcpqRHhqAWK8pl+5CSG/nVtZt2DDdnrbIyz9cLFvmI=;
 b=RpL8A0t957mm+1DHisnb2sAfDVUcwRMUck3wFqTXpWF7sEBQFAo/ROK6a1uCGNzYMruGtq5gjSQ1mu05GOaJiAIgkf8j9mEjJqlTJzd6ECFCCBK4nfxjZq/3A3b+dV9LZOw6451uigVR0hDgYatfo3SZZuq1jv//bczQ25rw1s7XrWFRKnkFpuzrueiZvWokR7lz0Rlszvk2t1t77fMD+B/356R8zA/iC0nVgBCVknPPH/n3NNASfl79hA0PhfHC3MIWjn3wOQbb1CU986a615sXKc2+lWboTW7fLLZnkRVhN3xX5z9oqhgBJKEHsZvdiS/bdOtjbBOYGjUHOw0avA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbcpqRHhqAWK8pl+5CSG/nVtZt2DDdnrbIyz9cLFvmI=;
 b=OW9plUayywGq28H2w93Cf5/cvM9SChYLnru7A0SD+eToWk/Pagyb4SDqZy7bj92+luhpyhGaPkuMaxKlKqv/ZkcqEGPjBXPzvkuEkxwIF9QOkWxHZ2eBALUAAxG8n42wPJV/muZor/Cz2QZ17PgK8wvdPODQZFjKWyDFYeBCN4c=
Received: from CH5P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::11)
 by CH3PR12MB7524.namprd12.prod.outlook.com (2603:10b6:610:146::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 14:02:42 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::9a) by CH5P221CA0020.outlook.office365.com
 (2603:10b6:610:1f2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.31 via Frontend
 Transport; Fri, 19 Apr 2024 14:02:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 14:02:42 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Apr
 2024 09:02:31 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v3 3/5] ACPI/NUMA: Remove architecture dependent remainings
Date: Fri, 19 Apr 2024 16:02:01 +0200
Message-ID: <20240419140203.1996635-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240419140203.1996635-1-rrichter@amd.com>
References: <20240419140203.1996635-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CH3PR12MB7524:EE_
X-MS-Office365-Filtering-Correlation-Id: 058eea64-851f-4b61-0290-08dc60796185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xGldNgZzmO7i5TH9XDIEdOhYh/scY+/SZ23LNRlHaqCCNIx/wOl+kitmPn6Y?=
 =?us-ascii?Q?JDnoULxa3GiuuPVJPl82oJg6Du8gDwbylGMRrAW0SF6X6Ti0ZOZn7LrrStmm?=
 =?us-ascii?Q?rOhe65yLS6tROBIRmLcfR3avDQobvg9vOsxEASOqUObYxA28r6rEl953n/q3?=
 =?us-ascii?Q?Aba0SLLqsFwcRClG6YHSAwmCHFWWWoCySjndIdc95ZLIrQgq8+43p9ms2VhL?=
 =?us-ascii?Q?JDAzhq/W3SJaNUbW6wVyDsv8+2xRF4/Fi7SdAfnwJPF9bnVNS96yz01JpL2s?=
 =?us-ascii?Q?9qUwff3mIpWLgNtrt95wNNnhHL15mC8h7VhrPDI8/AnJkR43H8Hp0yy6+gsm?=
 =?us-ascii?Q?Skp4kPECDHqpmjKCXFIqsUP8tPjH1k36ygtEa2GQn4qVyO82hBv95zFN7AXf?=
 =?us-ascii?Q?IR9cgP4Q/irHGVrLGXjv1Sd9CcyGu8Avl09MalFIb2h2kPeSbU1dYqmkdGqH?=
 =?us-ascii?Q?WZxXeWYkvvGKzl3huQsx0gu4GVrIRjh8J+XRb77OmLmkDWHVS2RsML28vse0?=
 =?us-ascii?Q?JPUXRFKDNeUu8IPNqYgDQ2VwZ/uXczD0qrLZNTJzucCgGUlMc53uxZDkRYwh?=
 =?us-ascii?Q?imv/nINH2biEeH3WUvcoL69pRk7qCMzjNDvKKoNraHwgLjjb/7OBAztth15C?=
 =?us-ascii?Q?xPEvkEceToRrjBxftQWwQGFqK71nl1tqhyOjTmAJs4jVxt9b9ozq4GNSk1bn?=
 =?us-ascii?Q?NebiBPXfGeaLfRjv3BNlhVkaRqLzOdpt5/024B97FOV8oJoMl3rYL4STDJbz?=
 =?us-ascii?Q?nrXkz3FS14PLh2SA+tT3iHIsKjlwyCusTru32Hn1Co5d65+eAXWOdAS3m3c8?=
 =?us-ascii?Q?ZZDb5XmFKAYpDTQK3F2yTrEcE5R7hFFBmiPdZOLiwQyUjPAPUhyd494kx8AU?=
 =?us-ascii?Q?ewCwT5qyB9fQMduZR5NWxhmpLn/YdyvxYjbbUWu3nINqvsEGAcCEom2HKmI2?=
 =?us-ascii?Q?EaJURD+nCtp66cXm6ufuW6UVAYNe8ONK9b27Ox88yJW588xiFNyXmRfn3TzD?=
 =?us-ascii?Q?vFbhR7XSSeMzG1ZU+xO2v4jeUPz/P/Q14OYGGM/EfPd08hqHoGZNi2JW2Mfw?=
 =?us-ascii?Q?sDJe+W/yJU/E1Q3Fqj3X+OqnCmI8VD93h9in6CP50J2TDOVgaSoQkIcYPo06?=
 =?us-ascii?Q?RUZgVU4UehuC2V+M3pRWdgh00NyLT57BG9Otb+qmK6WRjcrjN+RQLVBaSpDt?=
 =?us-ascii?Q?dGV9+K9U5hFRNfeG5/pn/etrWfMNEukjcFXt1oaqSflxD29hpVKciVujRHfJ?=
 =?us-ascii?Q?Rg/z1myomVqHB4fe4HXz8WONJQiPK6W6qtMdlDFUiuQMYXl9Sop1gyPDpecj?=
 =?us-ascii?Q?tMHkrVGEgSFZeB2R8NtUIkT14rhvTMuenz6I7pk85WVgs2ukqZQOnpCxfTle?=
 =?us-ascii?Q?vO5M9UbLWSHy7i1E5ShJOJlMc6Hx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(82310400014)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 14:02:42.1621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058eea64-851f-4b61-0290-08dc60796185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7524

With the removal of the Itanium architecture [1] the last architecture
dependent functions:

 acpi_numa_slit_init(), acpi_numa_memory_affinity_init()

were removed. Remove its remainings in the header files too an make
them static.

[1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 17 ++---------------
 include/linux/acpi.h     |  5 -----
 2 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 43417b4920da..bd0e2d342ba2 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -208,13 +208,12 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
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
 
@@ -236,11 +235,7 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
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
@@ -456,14 +451,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
 	(*fake_pxm)++;
 	return 0;
 }
-#else
-static inline void acpi_table_print_cedt(void) {}
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


