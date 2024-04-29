Return-Path: <linux-kernel+bounces-162282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB608B590B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA02928C467
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29B154905;
	Mon, 29 Apr 2024 12:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T5u0lZWf"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2065.outbound.protection.outlook.com [40.107.94.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F1F6BB21;
	Mon, 29 Apr 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395028; cv=fail; b=dglsyKTchN6DAaOYw4bW2feWVBzMuLWybbpprVyrwNRj486isvw2f/vGFrwLGQ8JQqUbN2LNQmwVbANuWcQtG/xbulQ+jPT2CMTeuarpkfrYIqDbHy9je5P17kY7KL3Sp0udqRiW3R7/yrWxK36JUy2Z+rOqxpORlNfp+F9mOBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395028; c=relaxed/simple;
	bh=D0EgKNsViWPGirm0vRf+BbuUtRsNYZo+qPvI5eXn3fI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tnsdZdJZx0/Hj/emb9Ub/EHZMJjTMJWTF7XyWGDRrP8MHGoBhbRApbPFJTSzmvKocIboudFQkwcChs0EtsCN+JbYhI6Gz7JpPHiF3ZDCZRXw/wJCBtGgkHyv3oYWpphCU2S3Vqf1qFZGmeUwDPinflRhoPY+h+osZOV1Qvi0XzY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T5u0lZWf; arc=fail smtp.client-ip=40.107.94.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOSOCHNRV2ML4AKNltxi8FUmS8R6WZyn1EfvqXMBPzC5W0Lao3yIPo88ZWSnxSHY/K5CsrNGljfCcLUnoSHco5rYS3+d+LQnx7ZuXibmXray3F38jw9G6lDwt9oZ53T7+KZxXOezQRKEkPA/4LPCbQu+EVGwh8pxRYmOJkOXKCZbRBTyU/OZXukyJ0rpMomxKMWIYHMT9fKvZ2yIo/012HprAW0nGutg3BXfmb9W0gXh/zcABoozz1o3r/L6+F2g80OrnFsEMZYMb4qT1rwMBmC8s/tOpKrmcMYmdPH9zMT9r93QUmn7oGnweKQoMtyRUUC1TzHR9E7DjFDWjQpUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAcRLDG52+dxQ48kKx4pP7l7qSQQuXuinCGC7cvq/AU=;
 b=ac6hXHrXlePZM2XoiNhNc2KDoYYAO+V8excA85p3YIW6vMFlt3JWXYyUfIrIVJ92KkphefrSaYUk4Fab/4BkuJ/jHjw3u9GABkugfoc9tGTlX+Et2VJXhxa/FuJQwSXOkT7sT93VzDDRXH+SmQK4158wN4oB3Jv4GdGjcBDnUKlwzcuFnucmEInqTaOs6as00PEDJ3Bcb2YwcuiZIIbdnbCJF7Q5U2aWD3SaquCj82jFBZCe3Veek63OP2DOxlyijVJo52jtQGjxKgD/gby/7AuhV24prWEvGBAwhuPmdsqX6RJCYQF7W9oEobp5QZBM/tbFjA19QKKsFvggVR2p2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAcRLDG52+dxQ48kKx4pP7l7qSQQuXuinCGC7cvq/AU=;
 b=T5u0lZWfI2g51P77Q8TDQ8jGZTQy+/7MEWVmGx73+DRhe633eLlk7UmbzkoOc07huDgpubea5M0J4RMw4tdVglj6PW5mrOkM2sUsO9a+BvollA/S3+b6UuF8MBcjM3jvheaTwsEI8s8Z4UPugggQluZeLUQoftgYcTZa7P3Jmco=
Received: from MN2PR08CA0021.namprd08.prod.outlook.com (2603:10b6:208:239::26)
 by SN7PR12MB6689.namprd12.prod.outlook.com (2603:10b6:806:273::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Mon, 29 Apr
 2024 12:50:24 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:239:cafe::a0) by MN2PR08CA0021.outlook.office365.com
 (2603:10b6:208:239::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Mon, 29 Apr 2024 12:50:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.0 via Frontend Transport; Mon, 29 Apr 2024 12:50:24 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 29 Apr
 2024 07:50:20 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, "H. Peter Anvin" <hpa@zytor.com>, Len Brown
	<lenb@kernel.org>
Subject: [PATCH v5 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Mon, 29 Apr 2024 14:49:49 +0200
Message-ID: <20240429124955.2294014-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|SN7PR12MB6689:EE_
X-MS-Office365-Filtering-Correlation-Id: a5177eb5-eb36-4746-df9b-08dc684aefe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400014|376005|1800799015|7416005|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JJ7miuYy056nPvoggz2d+WG6EXRl1iCnvEHoLlz3Hgg/PrPLWZ0g7jyEyYiL?=
 =?us-ascii?Q?whaDnl0XfF7rZz5CtaC32oymrCIDa+iXMACqVonQu2c/ze+fVcneihtOOXLv?=
 =?us-ascii?Q?EOnS2lrVJ8M12ImvINX+Gl3I1qsH925eMdu4gGsVtcTo5w38eaC23zN0wd+2?=
 =?us-ascii?Q?QSo1oi4SOQy2XngBkplwHyDx6tnY6iGXCS/07bEMHrf1QYHBfUzoq0ZdVTlO?=
 =?us-ascii?Q?UrU6hYPXXxGQ4zGTue/auz/TZMS6tUn3eH20N6A2Uh/bCBG5TpBNR1BBKF3n?=
 =?us-ascii?Q?XEtZRFUVaDLW/34829JXkF9NBvXrtQ5F5nxnPWjEAf4thVxMbkarkKu1YW/X?=
 =?us-ascii?Q?hYojNqLg3H9u0sBLcunSHwBPkAh4oLk2pXqsH5JsqX6gyaSKcPGQeokgMi4/?=
 =?us-ascii?Q?gCLluMjSrSvizhz6fK07557CW4dJQXERh4Dp3XxDAW0Icg5f8iFRb4OuvZj8?=
 =?us-ascii?Q?+MItWTY/Yx35gHSMeLeGMVI+0BiM+/wNnxGO+2tvbnyIzigjGrnVKTuxqftz?=
 =?us-ascii?Q?Dblb/Ior70JZun4+kCEXdnj3issqCL5uWPz0a+J7T4cnBAPX40wZsaqRFzmA?=
 =?us-ascii?Q?Ds4C/WkUqJZ+VEly6jYUr2RH9xfQ41KBfrkXTLZzKY/NOV+8PlRGmwIZ9wsY?=
 =?us-ascii?Q?tlswardODXnG0F7c/Thi1hOaGIn2xe0FcyMyZe+84lHvE6jpQLfvZawk4rE7?=
 =?us-ascii?Q?lM9mT1/VfssoHs/s2T1G8bFISm6qq/XyCroPF/bL5i2JCR5ILdvZOJezvHk3?=
 =?us-ascii?Q?HG12vpUWqGXV1ljohgB0AFTQ9Z/YrZWBX7X5xxg7VA+umrRKCZ/Qf3DCsfe/?=
 =?us-ascii?Q?VYvv6HfKZVTsnxmKHvA1+h4df/6e2KB43ytkNaNFjsQbXMoeUXY8/WVFPay6?=
 =?us-ascii?Q?nVYqpszQ/xh1qOu3kvWeGx5g7v0BUYWJ65fTx1h4FRb8ThscDuZmWjDiUTjl?=
 =?us-ascii?Q?IL+o51SAkne9xcf/z1DaeIcvJs3SfbxIfOG7JqCL7+CDqcm8j7MJmFrKVCJT?=
 =?us-ascii?Q?SX+BGbm6zDWZsCtGAPdolxQfCpHHHl5j/LKJTdn0MkrWgzpdfAhSXgQGTlHr?=
 =?us-ascii?Q?nMv2OOi3iklKd7KWkdKlbkdFcRRCj54VME16k68lLTT8VWah5QqA5Ne8PVpy?=
 =?us-ascii?Q?CHCobN5ii1A5XZu0aKznomhFpOTvDRLGrKodusRGQlgBZGJDyYZGrOgl0Ryk?=
 =?us-ascii?Q?GbolLqS2flTyxOPEGK4YZWfUTRZon25tG2eEt0ozh80oMfJw31rVZail8h6A?=
 =?us-ascii?Q?IwEhUOzGsriqi03TctaVfZRJdgTOI1VLBBRNMpwi4uoxXEWhPEzPWFrUGHnJ?=
 =?us-ascii?Q?KvNFGlg5q/dvv1xb0r89+fNMss4VMRIPnD/Dt6fLFJdOng=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 12:50:24.1249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5177eb5-eb36-4746-df9b-08dc684aefe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6689

For configurations that have the kconfig option NUMA_KEEP_MEMINFO
disabled numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
SRAT lookup fails then because an existing SRAT memory range cannot be
found for a CFMWS address range. This causes the addition of a
duplicate numa_memblk with a different node id and a subsequent page
fault and kernel crash during boot.

Fix this by making numa_fill_memblks() always available regardless of
NUMA_KEEP_MEMINFO.

The fix also removes numa_fill_memblks() from sparsemem.h using
__weak.

From Dan:

"""
It just feels like numa_fill_memblks() has absolutely no business being
defined in arch/x86/include/asm/sparsemem.h.

The only use for numa_fill_memblks() is to arrange for NUMA nodes to be
applied to memory ranges hot-onlined by the CXL driver.

It belongs right next to numa_add_memblk(), and I suspect
arch/x86/include/asm/sparsemem.h was only chosen to avoid figuring out
what to do about the fact that linux/numa.h does not include asm/numa.h
and that all implementations either provide numa_add_memblk() or select
the generic implementation.

So I would prefer that this do the proper fix and get
numa_fill_memblks() completely out of the sparsemem.h path.

Something like the following which boots for me.
"""

Note that the issue was initially introduced with [1]. But since
phys_to_target_node() was originally used that returned the valid node
0, an additional numa_memblk was not added. Though, the node id was
wrong too, a message is seen then in the logs:

 kernel/numa.c:  pr_info_once("Unknown target node for memory at 0x%llx, assuming node 0\n",

[1] commit fd49f99c1809 ("ACPI: NUMA: Add a node and memblk for each
    CFMWS not in SRAT")

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/66271b0072317_69102944c@dwillia2-xfh.jf.intel.com.notmuch/
Fixes: 8f1004679987 ("ACPI/NUMA: Apply SRAT proximity domain to entire CFMWS window")
Cc: Derick Marks <derick.w.marks@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
Authorship can be changed to Dan's if he wants to but that needs his
Signed-off-by.
---
 arch/x86/include/asm/numa.h      | 1 +
 arch/x86/include/asm/sparsemem.h | 2 --
 arch/x86/mm/numa.c               | 4 ++--
 drivers/acpi/numa/srat.c         | 5 +++++
 include/linux/numa.h             | 7 -------
 5 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index ef2844d69173..12a93a3466c4 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -26,6 +26,7 @@ extern s16 __apicid_to_node[MAX_LOCAL_APIC];
 extern nodemask_t numa_nodes_parsed __initdata;
 
 extern int __init numa_add_memblk(int nodeid, u64 start, u64 end);
+extern int __init numa_fill_memblks(u64 start, u64 end);
 extern void __init numa_set_distance(int from, int to, int distance);
 
 static inline void set_apicid_to_node(int apicid, s16 node)
diff --git a/arch/x86/include/asm/sparsemem.h b/arch/x86/include/asm/sparsemem.h
index 1be13b2dfe8b..64df897c0ee3 100644
--- a/arch/x86/include/asm/sparsemem.h
+++ b/arch/x86/include/asm/sparsemem.h
@@ -37,8 +37,6 @@ extern int phys_to_target_node(phys_addr_t start);
 #define phys_to_target_node phys_to_target_node
 extern int memory_add_physaddr_to_nid(u64 start);
 #define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
-extern int numa_fill_memblks(u64 start, u64 end);
-#define numa_fill_memblks numa_fill_memblks
 #endif
 #endif /* __ASSEMBLY__ */
 
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
diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
index e45e64993c50..3b09fd39eeb4 100644
--- a/drivers/acpi/numa/srat.c
+++ b/drivers/acpi/numa/srat.c
@@ -208,6 +208,11 @@ int __init srat_disabled(void)
 	return acpi_numa < 0;
 }
 
+__weak int __init numa_fill_memblks(u64 start, u64 end)
+{
+	return NUMA_NO_MEMBLK;
+}
+
 #if defined(CONFIG_X86) || defined(CONFIG_ARM64) || defined(CONFIG_LOONGARCH)
 /*
  * Callback for SLIT parsing.  pxm_to_node() returns NUMA_NO_NODE for
diff --git a/include/linux/numa.h b/include/linux/numa.h
index 915033a75731..8485d98e554d 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -36,13 +36,6 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
-#endif
-
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
 {
-- 
2.39.2


