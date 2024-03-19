Return-Path: <linux-kernel+bounces-107495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C3B87FD4A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2422F1C21E0F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B6AD7FBBB;
	Tue, 19 Mar 2024 12:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GKnI6DPX"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013A17FBA6;
	Tue, 19 Mar 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849661; cv=fail; b=KI2aQ0d7Z5eV5aZ/US96tyH0oTFdJ/1T32LLk1Uuxqe2huF6D17DQ3w30SUBuoyFR1GwK4shS7E+J3zSkgjCm7aowFgFmIp5qwitqB62zsxVngirdHJX81lESMN87UYZkQy89bhKuZ/GjD6D2KdQhqQYMgb5asR5o3uMBzgwUow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849661; c=relaxed/simple;
	bh=KNZGmdsVCrLf3seRR2GfWIW1FELjR4OvC92jm/nXvNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aJdg+wgc6ygkq+8ggKtrpxsa7iH1XzlvWq84ahpgeJTpjR78XVwv80FfdmWssNGi1EuTdD7A5TgDu96G6yWS5dEcXWdDke5e2Uto/VtGH1tlJjDhAsp3OiBQs8N/nw64v1cXdMUcFLElFgS1OYxyqxyldhPpJ1VWk3l3px14D60=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GKnI6DPX; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YY/qIbtqGsBZshVVhghDdMn0TZ5IY/TuAi9PbjVZAfISOwb8aucv9vANCh14q4IJxFVw+ii+5Yt1uS2kf0gHDm2sQhIhzh4EBGwckOzTqiDNk3gdY8rDtcBOc8RtxiBqTAGpTY+OkidmVlrDdqehf5J24CwOYrt/MSXNiVfitIfzSmVaLEw2vwTUhb6d43wzIFK8k2fwgmuI+Nc+34rQkgj3aj/adspPrtRF9d3GKgCNcJWnjcypeBxWWYIfIAgcFn4drxJlivbQMYQoK3qrY+29n7/tkwegBM5a/LmGXIpDSYanHteU9utkkC5BNkPGobZJ8vVWaMxhTwoEa3ynmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDxjGRs+Pnxp2qPVtzcKnQXIHHdNTBtT0ek0PmSYo4U=;
 b=BKe+ulz22RQMyVnYPTV1gh8oMAb61dvQA8tZWx/+fNbCh3W3ocj15BldTefxTpaNwjbD/JkgLRRDrb6kj02D/7D6mWE22/2zQYcKEvx8xGCHfIPxhzOQ2y8TxlD4UjU8rpMUK5DohJeAh+ry8tWnJbG2co6Dux6s17vO5ooP001zapcZkIj0GHWMFBlAV1reJaURiKJrwFiISIFrG1oyWe7jgI2CI1lh3m/4h1m/A0RxM1RjLU+MwK46sx3E2ihkW4lcRyW/gqmxzyWss26nflDF26qlme7nx+KaCegGT26sEUziLThEg+3g4xG5TgHZEF/Gt05P6+fM6JFubTWbMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDxjGRs+Pnxp2qPVtzcKnQXIHHdNTBtT0ek0PmSYo4U=;
 b=GKnI6DPXNGbE0+65P+ZdLJEImLR9vi8Uo1BsluoTTLJnbb6MB60IVWetfoys7SkT92dbTNkAAt3x/vQdDPxy2S7wtL9bFFMHsqN+wfuIbG7VVpAGPsM5q0mcr7p/Ii4KDePHbHclvTtLocIX0OCjFay5lRGrzmTw8EVTW6SHe5c=
Received: from CH2PR07CA0037.namprd07.prod.outlook.com (2603:10b6:610:5b::11)
 by DM4PR12MB5722.namprd12.prod.outlook.com (2603:10b6:8:5d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 12:00:57 +0000
Received: from CH1PEPF0000AD7E.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::2d) by CH2PR07CA0037.outlook.office365.com
 (2603:10b6:610:5b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20 via Frontend
 Transport; Tue, 19 Mar 2024 12:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7E.mail.protection.outlook.com (10.167.244.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 12:00:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 07:00:55 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v2 3/3] ACPI/NUMA: Remove architecture dependent remainings
Date: Tue, 19 Mar 2024 13:00:25 +0100
Message-ID: <20240319120026.2246389-4-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240319120026.2246389-1-rrichter@amd.com>
References: <20240319120026.2246389-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7E:EE_|DM4PR12MB5722:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d920ba-331f-4633-39ab-08dc480c3cc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q27NAso0DdBrUak0JDKZP6a/xXRbOvXYyOip0R8+uL9eiZBAS7sIHrrF9TiOwd2Vd1DWlwu4LSx7zZoVhcCwcQUO7sGFKJ8FmTN//mpS5WzHqRjSSNiGRq+rv4Q22jvO6igBjHJcc6z+98s9qFszi21Mw0XU5Si/0EHa1zDMMq1WZxry27bHF6rDsOT4LASXT2tbJX8rUb3MTxpXDUmSwClOt//WAb9WIjGcgx2116pQGBVsLAab/5e6qxNHWS85E4XtSVDxqqv7666ixm7kYFc96hxBg5KHTTi7ADkr6CZ2lzw3fxm50JweiFVMOEDKMzYkM3YHPKPMWuLOUEesOg4OhSKFTOJYkTxrRRxQMC9wBnYQP0rgejXDJdyugnjQN8jYMF8M2gb5ZO/f55dWTDFJKDglgLZu3/tObSHyNhCYZ24We99uHfN7eTixlhWZK5w/L3w8U4ljSKQKxdi6W8uSbLtfAo3elbxfr69OYNlbtRJDiV+2dqxHsOqfI+F0aT4u7I7pUXSb2ho2KfWbJ0ELMn6mjT4M2SRGQTONIGsXRwQNG9uUZXMW6a8DtN79AJl4EhXvoIypD7335wwpVtt5peKtW+xaes2MVsjkio7w+6+p+Q6VhcPw+OV39e0FMVlikdmP8lgaLEH277HGX5VewK63aSqLu3VjwIAo/ZUYTSLEwIewB615ehTolwaghOHyiw6YVh+XeAayiS/U4LyxUkX35lkCCy4qPIk6wAX5vd+KbNttRo+7rFOg+erv
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 12:00:57.5795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d920ba-331f-4633-39ab-08dc480c3cc7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5722

With the removal of the Itanium architecture [1] the last architecture
dependent functions:

 acpi_numa_slit_init(), acpi_numa_memory_affinity_init()

were removed. Remove its remainings in the header files too an make
them static.

[1] cf8e8658100d arch: Remove Itanium (IA-64) architecture

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/acpi/numa/srat.c | 68 +++++++++++++---------------------------
 include/linux/acpi.h     |  5 ---
 2 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index 50ae8557e8d1..910609a9754b 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -208,16 +208,21 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
-#if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
  * I/O localities since SRAT does not list them.  I/O localities are
  * not supported at this point.
  */
-void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
+static int __init acpi_parse_slit(struct acpi_table_header *table)
 {
+	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
 	int i, j;
 
+	if (!slit_valid(slit)) {
+		pr_info("SLIT table looks invalid. Not used.\n");
+		return -EINVAL;
+	}
+
 	for (i = 0; i < slit->locality_count; i++) {
 		const int from_node = pxm_to_node(i);
 
@@ -234,19 +239,25 @@ void __init acpi_numa_slit_init(struct acpi_table_slit *slit)
 				slit->entry[slit->locality_count * i + j]);
 		}
 	}
+
+	return 0;
 }
 
-/*
- * Default callback for parsing of the Proximity Domain <-> Memory
- * Area mappings
- */
-int __init
-acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
+static int __initdata parsed_numa_memblks;
+
+static int __init
+acpi_parse_memory_affinity(union acpi_subtable_headers * header,
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
 		goto out_err;
 	if (ma->header.length < sizeof(struct acpi_srat_mem_affinity)) {
@@ -293,6 +304,8 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
 
 	max_possible_pfn = max(max_possible_pfn, PFN_UP(end - 1));
 
+	parsed_numa_memblks++;
+
 	return 0;
 out_err_bad_srat:
 	bad_srat();
@@ -448,27 +461,6 @@ static int __init acpi_parse_cfmws(union acpi_subtable_headers *header,
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
-
-static int __init acpi_parse_slit(struct acpi_table_header *table)
-{
-	struct acpi_table_slit *slit = (struct acpi_table_slit *)table;
-
-	if (!slit_valid(slit)) {
-		pr_info("SLIT table looks invalid. Not used.\n");
-		return -EINVAL;
-	}
-	acpi_numa_slit_init(slit);
-
-	return 0;
-}
 
 void __init __weak
 acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
@@ -559,24 +551,6 @@ acpi_parse_gi_affinity(union acpi_subtable_headers *header,
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
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 2a7c4b90d589..5f6472a7997c 100644
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


