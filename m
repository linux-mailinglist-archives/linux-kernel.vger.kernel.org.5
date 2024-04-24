Return-Path: <linux-kernel+bounces-157243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 498438B0F04
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F281F216B2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93FBF168AE5;
	Wed, 24 Apr 2024 15:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jDCdF9nr"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2087.outbound.protection.outlook.com [40.107.100.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E241635D1;
	Wed, 24 Apr 2024 15:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973759; cv=fail; b=fx+Isd52qNlJrIsetdmCR8sgLRhy/EBgHgcGGO1sW9p71WkaHRo6UR+cNhg+CvfF5vcOr6UQOhtdd0RBR9P5mJ5GO7MG7A7qrVjqFPu+xWTpSAN0lsN7xHf20HkVVIK/zbQI/PjIynQFdMgk3o741lWtIrR28hMxUEBfmyLzGmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973759; c=relaxed/simple;
	bh=dd0tKGKBoKI1rwsSWTq7OWwHw4VnHS6sPoRxGqOtTN8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGGeDc9ojCHUVa6bpYVZy7VDneAnPmh2x+uaWs0yXZgAiPE9swPcWtzlkGzHArlVp96W65SfTaYFtSS4IHiTZAel6YDQyHPSxagXRe+ZYR44ak9hxO3iZngQ9cZP5qRdCPPc4C5Dgeyzfq101QdOVuv16w577mvgdJcpCJl1HA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jDCdF9nr; arc=fail smtp.client-ip=40.107.100.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iE4llrQprReHH3kPh728Oa/7UOcAHRQGrvozCsemybuLhmWgt8xctIOB2sqKYzP+S4FBIiuuHlsN0MdExcIpA+1gu2B7QnprOenYnT21xY0oIcDgf0dUj0mDQpNw2oLMCnazY+aT3piM29Y83Ew3H04XqC1kRIw5HzFUZnAt5yKdV7vQrLadwCCJ+bKMyteWov4Gz7EHcpfpB+LjPH+VTdqexzKKUKY/9DRVD58E9WpTx1ytNcX1i1uv09aQcZNisirbAnrROI0IoD8n5E4994oO2JKnqjz6CfIAnlCjulidphZdS2bZPTJKo1ChvzO3KqTV3osJT91hgKEHyoOr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UvaCGtiHWaORjixNRU9ZbaKC4cBZaEY/1U0UPRPmq0E=;
 b=E/vQgUtC1g+oMJOALIiFTp5hVYaZkZJ2Ap9NoXkhYXGA5lF6LMXGT2JrtPweHNveZg1Ex4HW4F5oHQjr4IOrQdZW1/PGEM3w9+M+kPBHGh0HNu8jpl4ARyPo44tUg/yV1u+OqILcOt6A9EQ7JC0DyLlSiMAaQr4MEDCNYTU9DUg8sy3BpDLAw4JQvB0OuHcOL0dc+dxVR9j3K3aVdn6jp72om6UbvmJHSIdOXiNj2Pu1ckfWuVHGMDNZK4mG/XPj5+gwtFR67emsI8VQs7oR8uMqa0PJRFgo+JSqPElGWzT5Ph2i6Oi1bq92WVSU05uP8+wb5GNfku29d8ti7twwJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UvaCGtiHWaORjixNRU9ZbaKC4cBZaEY/1U0UPRPmq0E=;
 b=jDCdF9nrZa+6PeHdmSE1K80ufDhtxZG+auC0kuAjJxdz9kEoFlu6B0m5L+f5V7DYaVs3XwMDmu3zNu03vZXhw/3cmUDBCHb4Qpb5oNi2i82aCn48DHRMSJNkXXOZBUGCpQfXDxvHmsWbF8Pq8nbeOo0/tmZhjPeam8PqlXz4aII=
Received: from BL1PR13CA0350.namprd13.prod.outlook.com (2603:10b6:208:2c6::25)
 by PH8PR12MB7375.namprd12.prod.outlook.com (2603:10b6:510:215::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Wed, 24 Apr
 2024 15:49:11 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::4d) by BL1PR13CA0350.outlook.office365.com
 (2603:10b6:208:2c6::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:10 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:07 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	"Dan Williams" <dan.j.williams@intel.com>, Alison Schofield
	<alison.schofield@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v4 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Wed, 24 Apr 2024 17:48:40 +0200
Message-ID: <20240424154846.2152750-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|PH8PR12MB7375:EE_
X-MS-Office365-Filtering-Correlation-Id: 6156c87d-5cf9-4a31-1779-08dc6476158a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|82310400014|376005|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IfuLX8QjiSTebDVPo6AZZU90V599bfGG9V9DEnozNMknf+PS5ctefS37lIpO?=
 =?us-ascii?Q?qIWbeLN5NNqbEp2IkXXXbO4riMiIm6f3KSyIi6LWeymdYxdcmjURsgsIQj6x?=
 =?us-ascii?Q?ztn0VvH+p2FWlgEfcchChF00gLMYwdKKIe682Gb5exTZoILmVVAuurLXI0Mw?=
 =?us-ascii?Q?yDfDVetJfaykEH6HLt4rcNVtkjpGJxdI0leTSujjySK3m+hA9NdUoo0/7yQF?=
 =?us-ascii?Q?bTDVnXMBl4P7CYkWZGsnub+EvgvXVJ52t4HUAXFRCw/ya3H5r59az7Eb6jlH?=
 =?us-ascii?Q?T59vPgxGXSp2iioln1XQIj/Etrz70jETYoS8K33W4DHENuh3jOqrqg4Vd/AW?=
 =?us-ascii?Q?dP8iIcFs5O7X51WMa962mXkA3cjPZuSY9wlPhv5MhErDOncGWJziKpbaSuFV?=
 =?us-ascii?Q?+iHi+VFT1WoTN5aUX+KdtyEBZncWmf6WmYnKvM4+n6Q6O7m7N0294Iy3evZg?=
 =?us-ascii?Q?aeMzQiRb8CqdsheH10lw2C9gh/vQsrV+danjG39YK0UyKgggAnMqHNAXe6s2?=
 =?us-ascii?Q?BuenHTCzhFQ48ryBU0oQyVnInsGu8IIMDdm8iJU5EHewFi7x2iHtcxZ/zsei?=
 =?us-ascii?Q?FOYoo+wjbw3BvzsMXUQ4cKdbUt1yg2eOjHiS/H/ahM1UiCzcIAje2nCKtoYZ?=
 =?us-ascii?Q?FHDljRfb75zRji4YsOialF7Ec23uSofdNUfqxlZhKrlVTIhKJNwJZ2b81guI?=
 =?us-ascii?Q?Q3HkBEubzLl2bUQp2YjlvJHtbZRe/GzaBJIvVYMEKOxSggvItohj2MprCCZt?=
 =?us-ascii?Q?AOIpNqJNQY79zgQ686fTOo2D0fQ0hKI5347z02CLgFABdCCFEasmrHeCJD5O?=
 =?us-ascii?Q?AkZ1lunM06G4BiYydq6dQlGqTWPf4JqCliBXdNUhhJvM3qYzEIwDpNMv3X0r?=
 =?us-ascii?Q?T0frxP/pqYm6NrMcsS3hMubPuRvx8ts5VTauzedEwimBUO6d7fygMQAEd9cJ?=
 =?us-ascii?Q?FK5VYbPIyH/1udFpk7fvD4S2qL+mWbMT8bYJ8cb9BsfRIY1uv/Z86ACHGNtV?=
 =?us-ascii?Q?tucNX0Gl8NpGHImcUoKXZZHMjjyUZTuB6+/PRsqqS+seX7JTXO5u+4iwgK7l?=
 =?us-ascii?Q?HSs2aQXwqhZGzVb1EK4UFQSCOrMns7rj59m7oXUHFmP3NINcrKFOM08b5MU9?=
 =?us-ascii?Q?/xXumd08iaR0rEyGUZVJjk10ltBlNMMhr2l0drF14NNDiLic0g476wh3d7UC?=
 =?us-ascii?Q?ld/5fjIJlyg7iYe1/w/0vheqWJZ8/XGBszsbFUyz+qGNLrDHGWNoeSHUWjuM?=
 =?us-ascii?Q?wrI246XOlaA94aPc2rq+/I17vn9/JEvivY9e+zL627ar1/oDxefd0DnxB9ik?=
 =?us-ascii?Q?k3yDupIP3JX5O4iId7F0kpFjMXUWypUG99FeWdRrJUh6N8fnFNFyrPRSH5I2?=
 =?us-ascii?Q?RBk3Yqp6mK4f8TpSAskYlzEWjVkg?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(82310400014)(376005)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:10.9745
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6156c87d-5cf9-4a31-1779-08dc6476158a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7375

For configurations that have the kconfig option NUMA_KEEP_MEMINFO
disabled, the SRAT lookup done with numa_fill_memblks() fails
returning NUMA_NO_MEMBLK (-1). An existing SRAT memory range cannot be
found for a CFMWS address range. This causes the addition of a
duplicate numa_memblk with a different node id and a subsequent page
fault and kernel crash during boot.

numa_fill_memblks() is implemented and used in the init section only.
The option NUMA_KEEP_MEMINFO is only for the case when NUMA data will
be used outside of init. So fix the SRAT lookup by moving
numa_fill_memblks() out of the NUMA_KEEP_MEMINFO block to make it
always available in the init section.

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too, a message is seen then in the logs:

 kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",

[1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
    CFMWS not in SRAT")

Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---

Also note this patch is intended for stable, please tag it. The next
patch (using __weak instead) fixes the issue too, but is more
complex. So if this patch will not be used for stable it can be
dropped entirely in favour of the next.
---
 arch/x86/include/asm/sparsemem.h | 2 +-
 arch/x86/mm/numa.c               | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..1aaa447ef24b 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,9 +37,9 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif
 extern int numa_fill_memblks(u64 start, u64 end);
 #define numa_fill_memblks numa_fill_memblks
-#endif
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_X86_SPARSEMEM_H */
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 65e9a6e391c0..ce84ba86e69e 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -929,6 +929,8 @@ int memory_add_physaddr_to_nid(u64 start)
 }
 EXPORT_SYMBOL_GPL(memory_add_physaddr_to_nid);
 
+#endif
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
@@ -1001,5 +1003,3 @@ int __init numa_fill_memblks(u64 start, u64 end)
 	}
 	return 0;
 }
-
-#endif
-- 
2.39.2


