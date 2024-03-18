Return-Path: <linux-kernel+bounces-106676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B4387F1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:11:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D153B21628
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1ED05A7A2;
	Mon, 18 Mar 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5NGiaLiX"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E32E5A4FE;
	Mon, 18 Mar 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796191; cv=fail; b=fCmBez3YbEwsDIGoFAcemZiT6vTxXc+YVhdw3VMALoKXDmszC8DQTsf0TidHLjRONxkDasqIFYtIK6oSC+oyTAA31znaXqlOjYWILth0KeyG/ekcjB6xOmsBZBl0jqfXsFGUVr0QXQc7NWHkhgsIOPR15oUZnNIiDRQzAQ3urpA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796191; c=relaxed/simple;
	bh=KNZGmdsVCrLf3seRR2GfWIW1FELjR4OvC92jm/nXvNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqTxYgQ/RaQPt5YKujrebkxdESQTgKYdndaUAm/XfKJoM1XiD75/zUtKG/nkJKqVYsDU/bp4GOL1EyooGqdUS5nb+kns/+rI4U+kWKKm43S0OVSXciJqhTO4QUDcMga/SttDoWcKRTFlUMyHWwSU/5npEyjh+wcoZoPy3xTRqV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5NGiaLiX; arc=fail smtp.client-ip=40.107.220.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqnaixNS3jRPKCkgph9YK9hPUYAn29q3GijOOgLrrDnyvx9R45WbAzEUjdC7c52sqolo8KQQptyXlhEkvzKwoLlQN590EfKHkYhGwNQLZsFeuOrVQpnYCNtjUYppF8W1SgIwaMhQXOpl3WA0gqSJKavE6fT5+bHgPOQZtrIlcfflYIT+EiHsw3S/46H0R+GOztvFKWq7VxVNu60Jty51BadVcPCMYCfDMHQAgykAW/XzI0jCBdC5iOWvCT0lb70uml/cINpDg7Tso6eNudjJbA5CR6K3lujgPcL3zktTlcD6hmawT04epxK9Mp+qCgHVnoBmYn3tdRCrSGuTa8bm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDxjGRs+Pnxp2qPVtzcKnQXIHHdNTBtT0ek0PmSYo4U=;
 b=OoR1dchD/D9UL+OtQnWYAQkyezmkKMRc6olmRmVnsCzrysKmmgQ0QgIduDe1WlxmpYI87SA++hmkjT4jg345Ruwy1SY8gUK7/2SIHDhsYW8L3Zl2DZRST5swXKrTKJULxFADFTWFrm+1uLavTXLIzMzqQW1gTB4ZStqfAEH62Bwe2A+BF0bdZUZLMlitkWIzUYg1mwZbDUFUfk/MmPSwSc+naHxr11dbacObu4K+bwsozWEJ3Ry+KUo+d+8jITO7cK8Jt5xemzQ8NPyyBJNGgLUoAT41Z2fXuMrEYOJwpZ8Jn42QBNtRjGHSUZltgkl6K19VMl5poSOhI1IKjsvf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDxjGRs+Pnxp2qPVtzcKnQXIHHdNTBtT0ek0PmSYo4U=;
 b=5NGiaLiXO38JPH9Xbu+BH37FNrOr25cRG0q5qmHmjSvp/gQh7PHeodz4bTXOtjlyH/hlNzJlB1HoQxjzxleAoEXIJr2Cef2Mt84uPhZOlGc+NV7x3tIlZoysfDtGRP35htSsj0vlLZ65ZvcKtNqkFd/UMj2QyUhG09fBcrEXt1c=
Received: from DS7PR06CA0020.namprd06.prod.outlook.com (2603:10b6:8:2a::21) by
 DS7PR12MB6333.namprd12.prod.outlook.com (2603:10b6:8:96::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.23; Mon, 18 Mar 2024 21:09:48 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:2a:cafe::7b) by DS7PR06CA0020.outlook.office365.com
 (2603:10b6:8:2a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Mon, 18 Mar 2024 21:09:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Mon, 18 Mar 2024 21:09:47 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 18 Mar
 2024 16:09:38 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH 3/3] ACPI/NUMA: Remove architecture dependent remainings
Date: Mon, 18 Mar 2024 22:09:03 +0100
Message-ID: <20240318210904.2188120-5-rrichter@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318210904.2188120-1-rrichter@amd.com>
References: <20240318210904.2188120-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|DS7PR12MB6333:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f380fa9-0f50-4715-0e8a-08dc478fbe52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xkxZ+qX//aGx2SwF9DFZDZh2TaLpDfDiKmRLkazKMIX67wnFxx7a4bpzSAs/Tf1nhajC5cptbcCuF75GcDAupyZu58vCpvE4zJWem9DZISG/sYjk5Dow1iVVC2xwGfMNrNTlqLgpphfixh3oaaTKSoEAhCtjNNM3ZeO+MF9rqy56vfVNag5bcl3QEAVXL4xvMSI9/mCRyf5EjsFlBxIuVp02N1/66egR6TKVygaafLRcEAmHhDAAiLHa3xYjSZbj+W3WeMc6FpZ1NmewZ98M4Rj0/sRoiBUR8hw6k3+OBP4y+Fgj8nRPILMz0ULqerFPt5QcBMdTSNFN/UCbedLH3sXdu6ppOb4mZU2SmIQlPDuif52qPQOoOWeyJgnRSj27fYM0j1V6/729uGKl2ao1nHDgSQRsKsttLvVK4PH/AiGgmT7EvImJM4GhQONL5LpHtuqVFMzkhij6i4gqP8PmspBxL+lIM0krLtroG3Q6nbrDXY7vp79i384PEukkvHfyQzQODyYPSkTcJQ0wziLMkKqVP+6SK/IuUDs3XFb3kn2sldWhTStV5sEitBBBmIVbRMUyxCRY9rJbNseit9pR8/66QG0I5E73e+9RSLKQSYXzv4KuEfOzSNBJ5Er4QeZfbEECWUdjUpHJgmhGQg8juk2CPt57TTKbe5j8f4fx6hn8NJADS/WYOIXJsb83OQLLW5LK718VtagGaXU0hKCAsw9Y6nPHm2T+ju5Gi4y06MnonQteAvAut9xLrPkUS7eh
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 21:09:47.6425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f380fa9-0f50-4715-0e8a-08dc478fbe52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6333

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


