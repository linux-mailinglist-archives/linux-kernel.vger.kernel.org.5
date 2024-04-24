Return-Path: <linux-kernel+bounces-157245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE5A8B0F08
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A8A295780
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A63D16C86D;
	Wed, 24 Apr 2024 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRn1o1dt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE93B16ABCD;
	Wed, 24 Apr 2024 15:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973763; cv=fail; b=chnKLcoBEUKp6jeyXLwcZrX56DXq19e24cVdDAHPTO628r+Roa6EF3XzGOm6oz8EAKhkD7lC+16iwnsTs6q6NhyJO0gMVAyu7cIxUktwdz1B4RRDwK9r51oyvaRxe1AO07TXn2uI7hgTmGgk/b+O76KJPBH/pjS6uzjrcv7ODrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973763; c=relaxed/simple;
	bh=647u1z3wRbEbaOeS0NL+K0zW6YDbrE4mrsl+FRUBytA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oyTx5tyKtHw7h5tD9U0rB8SwIvxjmsl+XMyNsL6clxBcF19m6n0/z4toRsROdwAaMlQBCmAXcc0o5exfiGl96JEK+CK6v3ZJyGTL7i+Mzky8vLHIijODBkafLJRRnCR7sk+hHHMgL056m/hkyNMUUd3j4hebcFHrelnL0IB9MxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RRn1o1dt; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL4lYMwhnUMVUfdyU8fni5VsPnUJ1OyRwS3xbRJHJkEQDxId9vasd6Vvr8hEDUtgKgLynoYBjwqmK3y2rSv3i4W4ViYbjx59y+kHcmgz6BVWCZpQg+vhmF3gfBmH/lYe5uV4A4ba6BVxrB6B/PVPqJd49sQyAVWQVVBKZI1kWNGXi/bSY9HeVfeCeDKA9uZSTasSs/JsPbslmVpbHZw8Aur96yktirPOc56sa6LfxovTEa8APAsYwxUD3JobKfRZCHxyb3Le0psuUERZalgmmBlXQypN8PsRpoQmQeJDwxm16KKrk4Ky7iZK+RewZz8CsmaXJIK5Vi8sN0skVwV07w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=QL+8wRXmZlmBTLJ3Q6Mbc/vEslp+y1jSjm/71tyXT0DBv01KxgiyFzGEXmkpPhqMw4p+0DrYvh7V+pNFh761xfeK0SIfnejw/Qm9X2vHyYF5r/Np+kzk/r6RLKJFHLTr8yHo1L4GXf1pB3QxYZmGBL1H1ep+kIx/fJRfuewlSu31dsY8+0JwjCzfZ8FDWMsQ0ZVIG6ycYydoQu4OlyDEbqdC8tFpIrCRaOC8LtV8s/IKMAgDEMBbK85V03PSZ5jK5+rYSGTIZrRq++hNNpTRy3pUFUNks17Y6tJ4I/Df2XbjDDk9F02XrrFIh2jQd6aEeUfpYryVaJr9x05UPoqv8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rbiu9B8dMh2GCmUdkxKoTB+BVLOyjvHNhJoJbm+eYlg=;
 b=RRn1o1dt/hXPu8rTsTpDWDWD1J0YOs6tY2QhQ1V6XCITAVQ+d+J2o0e+cCq5OzEmPg/PCKcFqZln8SdGbSolbezQR8eIdg0P3UrfZcUgbCfhp0wVuR1vQlYEqoY59p1ztGTcrK/XkJi4yS/2Q6hdCc26C/t/iALRYBSFD4K+wlo=
Received: from BL1PR13CA0347.namprd13.prod.outlook.com (2603:10b6:208:2c6::22)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 15:49:19 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::b) by BL1PR13CA0347.outlook.office365.com
 (2603:10b6:208:2c6::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22 via Frontend
 Transport; Wed, 24 Apr 2024 15:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 15:49:19 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 10:49:16 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Dave Hansen <dave.hansen@linux.intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	<linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v4 3/7] ACPI/NUMA: Remove architecture dependent remainings
Date: Wed, 24 Apr 2024 17:48:42 +0200
Message-ID: <20240424154846.2152750-4-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc9021f-eb06-4b89-57df-08dc64761a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+OvQaahEyw9jjWFNe62WUZYto192QNCU/ncdZCTlveTUpbak26AH/uNwPqMg?=
 =?us-ascii?Q?V9B02qIgUfitK/dt9UglDPJVJcXrPtL7y4cJJEG98oL8QdbERV47n1i0437y?=
 =?us-ascii?Q?MHb2VS8wYXmWnsDq+t5Hal2lIl9jUbYpYH0WZLiHL+2KOAS+H3bn3E2oAhCl?=
 =?us-ascii?Q?kRKD9puO4+dDJRjHajKUiqbmwiQP5QIwixohd3B8J+HwcgjXM3E7RsAalyrh?=
 =?us-ascii?Q?cje07veV/mlOXcIZxzWfZlcCW7QmshnuhYSIwCgV0Y+EAuopeasioWt2ed5Q?=
 =?us-ascii?Q?M62qBwlTFyGqGcZrqnJ1l4RlXowvzrPRvvDcNTBr0chFmMtFYcF3Y64Ab+wS?=
 =?us-ascii?Q?cXijp/YMKxLfZowKydfusSxtsuJSGQem3GHSb86o+0PjDcMyQZs5AvRwtbAt?=
 =?us-ascii?Q?tUxtCB2bC/9TIEfiuAhgkEW8NXg4/lZ1vXoU37ANOAUdumXENem5+uSAScs7?=
 =?us-ascii?Q?lYXesQ+FDbaqXr6RvzUMHkZ3sKZo/wB/UbQKi9hNPHDZgr77jBRB1ouJgb47?=
 =?us-ascii?Q?VR8oq/fIXgba4WhocxbJuXEcestUHNL4hDLefdn4KNO6r15KkdceVSH8/lg4?=
 =?us-ascii?Q?VaogfbSqnKUPlH4TrKwPsD9hQ/gBWcunWz6nkDNzmQRg3X5KHRmP96Eeszk1?=
 =?us-ascii?Q?WyRF8xXk7rYIj9KM0YmzoOji5WtYOPj3ft2DAraMLp/qU83G+s/XyKuPs51D?=
 =?us-ascii?Q?COyGli9LXXi7CqWm1ljmxHKSHCAK5cvC0q25ZQq7TJv53a611GuXxs0FzIfc?=
 =?us-ascii?Q?19vr9kmM15cuOpPlIQSzwmc/I7+IcK/Wrh1++cNwY9yUSiBfuXPhPc8JX00M?=
 =?us-ascii?Q?p/T85wdJm4movTsp36rrDQ5dutO0cRjWV4v90aTIllMKn3DxoM3hiMiZhRj9?=
 =?us-ascii?Q?oBWJJSMtu14TUs1WOkXzTgTRWPG28tmKprdD0xLGEZSkRy2IpvaiHotYRppK?=
 =?us-ascii?Q?gXFSk3t87vHIFX7DAFzCRqh74kjF56y7gmW5o59KbfTjjCHj4lDNQDh8t6Vy?=
 =?us-ascii?Q?g49muC+ysLh+ELg2eEVroYArQE1w82rFVm5M6ngy1e6O+Om57i8tIqjNqPbj?=
 =?us-ascii?Q?Sz84zPKUtdFX507zfs19m+4gj6YHvhqdcyJnyM24FjmX1S9RkHl5FmBbkC/N?=
 =?us-ascii?Q?MFPyNgNEp98nCzm5GuZF1AIWiAsACaZcMj+zldWl6avFCMP9SeZE5hVzi7RX?=
 =?us-ascii?Q?xKSZGciC0oIaKRW8xdfF++DO99iA0jtBiAib90zGBXW8FNJgUxE4m1uo8X4j?=
 =?us-ascii?Q?PxsNj5kNb5LB/+6GgbJIO4Y/ArcLa2Q3/8swSQbRSn9buV64np+4eQBS48Ck?=
 =?us-ascii?Q?6c4pXdnLmxd6CoUXP/bsLswxPc3PfiEcHVzRu1gTpIKgebPp8J1nT8RZnG98?=
 =?us-ascii?Q?N5gxVdl3fSQMm1g8jcnPH+j1Ol/W?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 15:49:19.0214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc9021f-eb06-4b89-57df-08dc64761a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

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


