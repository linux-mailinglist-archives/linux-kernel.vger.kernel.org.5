Return-Path: <linux-kernel+bounces-166490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A638B9B5D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A2E1C22060
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6FD8625A;
	Thu,  2 May 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xperB7mq"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193B184DE8;
	Thu,  2 May 2024 13:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655461; cv=fail; b=itMArb7Eca2xUWBSLV3avl10EAx/aZF4iur6UrbFRfL7RG/xJ5SY4vVB+tn8Q0md4gkJoyuHVY97hl7QUTyxaYNDO8zY6oNTqYk4kZLXF/yJwFrGlet1qJrqLQ0Yl6L4g/w55Sd7/NlDYOBsczQlKq7sCrxTUsV2guRLnlPRzQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655461; c=relaxed/simple;
	bh=iXR8lCBOw2pJcxMMYwjFI6zH6Ru+QQkAbcZ6VaO+tl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nLhW5ydHIU2DUzueaILAE4OuxNU/Sm2fZbw8bKLnIoh/DNOVEifVTfGFqgOgilEnnNgHGQuckx7wF8dk3BEX49Y04A1VJeDoxId+wkC0ZZdojenjVXuNQ17c1pNAYzZOxN31epDbYML7rPQhA5dAYksIGGJBaxOts7YdzHap/UA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xperB7mq; arc=fail smtp.client-ip=40.107.95.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ngx46zBKZRrubqALD1OLwOz9SQ45cvROOojLbwbVfIvMxQ519fJzAF/2rxqicycRBb84iudzBU7EWKE0cHXqQqcLh5HSGqnIKO+APVGIjnAgXZCinhgNBg3UwWSR8z3lJeb09K9rj/q8H43anSMwh5HDVi/2HXd0c300m4PrjyCR08jh1Zv7J0GYOWlNaAkNYuvk9nOqKvWrY+bvhyZ5gaBW/WTdLRkRJUPHRR1uCoFp/UXNqLB5UmiIaHm1w3qufAuOZ2+PcUrkE2aORoc4Z9I+A/1HrX9zyMuaqpiI7f2Z94GkYHUOULVio8ueYq7OwhGAe4KJmT0/92fslyroGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzYUJuAYKm1do27SYeL+f93Xc9Dgs4ObFK3fmIQdZgA=;
 b=nZBpHZFlcew5tR+7IaQpENtJf/tu9FCHUbsPiwRNT2q46/UKDNICZJAEQTwFtnV2Mm6yL3V7Q/guitWHnbJdV7xeIgUKgKf9lnw/iW7AHbnAkM7OY0X9IDhdnHgO0DF9tf8hrhw4iABdAL8ZCtWG5CeLxaS6dILgfrhiQgqiRsugcDcS9UYPRazFP+d0X1AHzyATltRCjSUNWChUuY0ItLOgFIDfF3i0FOYhw6B082bXG1ddMxysnebifI41QE/ZLz6kQ+UtbZsAZ8bWe8bvH5nSjBXDgzRPiZeY3nAYgTd6ubUI5rqC4e0VbGEHMxsr1GM2GeKrK9eTu9R2UMVOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzYUJuAYKm1do27SYeL+f93Xc9Dgs4ObFK3fmIQdZgA=;
 b=xperB7mqxzQFj9cQpS7ElWfVWLgD0f7KjYnn/9/9yG0iVQ90sLGKZ6V/OVskwH2cRu0jSVNeTFFOe5/Te9P6K3/gEVPdATNdgPKxrgQn0h2uDNvUHckXwGH/99NRq9f5ejf9CuY1kgzk3axQ+N0QRM/nOTpsHH9R/qPAhJQxXHA=
Received: from CH2PR05CA0023.namprd05.prod.outlook.com (2603:10b6:610::36) by
 SN7PR12MB7979.namprd12.prod.outlook.com (2603:10b6:806:32a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 13:10:41 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:0:cafe::ed) by CH2PR05CA0023.outlook.office365.com
 (2603:10b6:610::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29 via Frontend
 Transport; Thu, 2 May 2024 13:10:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:10:40 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:10:37 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v7 2/4] ACPI/NUMA: Remove architecture dependent remainings
Date: Thu, 2 May 2024 15:10:10 +0200
Message-ID: <20240502131012.2385725-3-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR12MB7979:EE_
X-MS-Office365-Filtering-Correlation-Id: afc424f4-509e-4822-c9d5-08dc6aa9441f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ISWHm1iZ1NT8GGsggDcSIs5DQSE+gZvijXWGXkx364wX2L9NvrPY6Xry41St?=
 =?us-ascii?Q?gmfXLiKGWdRZtbEoaE8ePBQprd8ixzI0vfJkb6/pPBb/mRDvcPxyDK8PkV/S?=
 =?us-ascii?Q?FWeQiEgu/IsY6YwNx5mKmHuwuEHLjZ2pVKe5ZuBHNhDombQA8PtY3W66IptV?=
 =?us-ascii?Q?hu5zbBvdLp3gsrUL8pqYZ+Vo6Xb8V1EaYz2XltKtz5GQ0VdtfPnAkKVYNBS2?=
 =?us-ascii?Q?4MveFUcyDbXu4LTTRjbST9kfX4/xmosaa1gq6lgGo/PNoR4MoEBUaQ3n1Z7P?=
 =?us-ascii?Q?j2byETzZcSbGyq+S1n+MEon0WpJZVjfAPclmxFOGHb3qonjvB/VyqUIEUHyC?=
 =?us-ascii?Q?KPdbp+IPY9MDU2lfLn10FqABlgXcZCnfKeXh7buNdw8uYAH3mjvSiWCkIT3z?=
 =?us-ascii?Q?yNxQj6EehTc/RgmL+PNyiBJeWjKRdacwX72b4p1Wosp3m9bxh2EAvEuqVlQi?=
 =?us-ascii?Q?+LMja29J4BywKL30ReW0FEusu/yDDausSGafIVOXKx1TFWHDbpVPhErFiCT0?=
 =?us-ascii?Q?MpSwcTCWYKpSKsr6dGmQ6R0AiW2Bp+YLsaalIUEokWdUkfOJwUfem+35UWlL?=
 =?us-ascii?Q?CkgAlJEZPtIzgaUhG0ne/QzY/vTWwNfrUMHV/CA3bBxqBtU6OXKtmifxlBLf?=
 =?us-ascii?Q?gMj3ra1lhOnTROugpzFTBGEk7yxDOgAsPookBtmhyhD5QcjeV5gAF6yRkd1a?=
 =?us-ascii?Q?wYNhcSmPEDZUouohQseRtV6KP8e9MFOb/hAjgT1qR5rQyOmC0DIxLublV6iK?=
 =?us-ascii?Q?9W0k+xjzKfAjTI0tssyyJru0nRnfZ/QXSesKxJIpp4ih4JAxA3071t9/mDuN?=
 =?us-ascii?Q?c+pSUUIjVJbroqTYhhERDUAONSNpO6bBmCZysazG6p02sKU8FM7U5ZiKhmQW?=
 =?us-ascii?Q?7SA4cSZ3D/B1taQjUJlKRU3I8PhFaHFghr0nd2pyt+oSVCYDrRYl1QP7C3s5?=
 =?us-ascii?Q?3/bo3PamEOuQTFZa/fLI5ChCbKA6s6sooq3qVXWfKGPzxFHfEYOwVU60m48q?=
 =?us-ascii?Q?Tk+XzQY4eWq+TwkMqxMvDl6QSRUFEt61xH6xvnr64hNSR2wTDwkRNogUZuEO?=
 =?us-ascii?Q?Oio6rQMy9rPyN0XJFy8b7i7ZfgJYiZj75NcDn69LmEThAru0ml7Sv6eBHkBr?=
 =?us-ascii?Q?JUnEwf2pACmk11/5201pITyUDom/kHZnhzt++cwF1FwTkXCvs+yfW1++Ob+u?=
 =?us-ascii?Q?BEij4alxT5/i88l9/SxKYqRBD+Apx/f6ghs/XpUcVlnhxiawGwaAuHSIeZPS?=
 =?us-ascii?Q?/usjPJLG3xgnXpqah8R4/TND23O48P1ExBAYEBfTmASM/YHotmKdjqQKeu4Q?=
 =?us-ascii?Q?vpN9bKwiU22K5vRjho15eHuZwz3/obyWpgRORlSOCW4Fkiq/+SYVFbL53sLe?=
 =?us-ascii?Q?1Imx3bUSjSeQ5fzO7u/IelLRVlJl?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:10:40.4094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afc424f4-509e-4822-c9d5-08dc6aa9441f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7979

With the removal of the Itanium architecture [1] the last architecture
dependent functions:

 acpi_numa_slit_init(), acpi_numa_memory_affinity_init()

were removed. Remove its remainings in the header files too and make
them static.

[1] commit cf8e8658100d ("arch: Remove Itanium (IA-64) architecture")

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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


