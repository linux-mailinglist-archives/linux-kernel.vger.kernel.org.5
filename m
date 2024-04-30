Return-Path: <linux-kernel+bounces-163679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1108B6E42
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6178C283E5C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E741A0AE3;
	Tue, 30 Apr 2024 09:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZMgbyegc"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54701A0AE0;
	Tue, 30 Apr 2024 09:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468953; cv=fail; b=nliXvBu/ZKNbHFNns2bp7ql6N5OPZ3iySd/hX9EmNes9y/E8IVrs1eaCp9vPn5arYzO0c6kAmRoV6iDCo4eYyw5B5a7wtqWjO9A1uyn1O8WGy+P369v8Jv0MOqLPM7h6gd2ixcV3LXDsKwH0zqiha32kH5y5oELs4KlgCzQKyV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468953; c=relaxed/simple;
	bh=SIYEEElKuNiNg6p8LKxSLm/beuI9GIhsW32SbcLMK/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drLspRc1tbjKztqNfpWuQ5vTyu56XkeAvtg88E+7vRmMWU69ltDglQL8eXGz7TUtD4RM6WlqXf1CSDHS9+yL6QbtMUx7bkGD1aZsebGFV1VIdGO5HwbkovVuFW4dBAU9AI32Ws3TLuwR8VJHg5YMgeTXnGHp+d6bLxgZavGAYCw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZMgbyegc; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XE341uuqXIOl+CGx91aXyRAolPCoCGIZi1p87vAFQnvEyTjYM3gXeMBEPewl9+HHp53BW8asytjAWiemNoGzQ+gRpD0/F7MMOv15npnuFNomj8331ryjdad9WKo/lNP0vJci1Rxcw6TmnLgqPO0GTNncGba6GhyRKJJ4MgEDFBj0QlHbPugdIl6chx+kxKXS8bWOLlrNbmNGMU9eZ7O1uvj0re9IzO7pOj0S6ODSFF5qlU1JR1Bg6q9/t1/yTZVN5EuA92KOJbWxrTV8lNY2ce+hMxGouSLmBnflfVJb69Qku1fLCYQN6Hdv48ItVyp8Lrj2PLc7e+SQpTb+uyFWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wdhZDafrpMV2qpF3fVdIuPSmWqxpJHX2I2fP4tJiH9k=;
 b=Mg2WL+5C4JIE7qh6PQOBN4P/L/FRTa06puca/ltp0SEm1cyCpJjtzCosbITImJuksuo0pJkLcVMr9EInN4DF/VeTYFWFIMy5ESio8pOOAnNomSdNrSrgShmGuDqNUSKmnF996CAp2Y59fp6isYi300A3QYCjSkVVYj5in+ww8+9R6XDHwc3YsXxWPA8jPCNKbgM4klK4pVxF3BmNNbmlyOXOG616w2TDnn44hIVPBfb+TZEGQ9YWajn3XkFtERtoXTQSpTehyaVXuMpYmtGuSVZu0vqHK/01Cz5j3+FrlO6UdGqx76utx9FI98pPaaE34GvE4QR4HIxSvWNZuffyXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wdhZDafrpMV2qpF3fVdIuPSmWqxpJHX2I2fP4tJiH9k=;
 b=ZMgbyegcL9q5I6hz3sl3QNU5sgtGvyz0MlkAneS5B+UxjBFMYUrTVCu+QvipUMgLgs9JSkEXd1coBDM6H4386iFcrpuI3lxZVkKCyZO3YMzM7/ZeMwDNs4dw39omEPSLyH84dysFT89PrWhh7s7XraLolXwpygcmQISE5BMtZ4c=
Received: from CY5PR17CA0030.namprd17.prod.outlook.com (2603:10b6:930:17::19)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 09:22:28 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:17:cafe::32) by CY5PR17CA0030.outlook.office365.com
 (2603:10b6:930:17::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36 via Frontend
 Transport; Tue, 30 Apr 2024 09:22:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 09:22:28 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 04:22:22 -0500
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
Subject: [PATCH v6 1/7] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Tue, 30 Apr 2024 11:21:54 +0200
Message-ID: <20240430092200.2335887-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: b170ef48-ec2a-4b45-2dea-08dc68f70e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|376005|1800799015|82310400014|36860700004|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o6txoVJG4P3FGDTLxo9WwzMy63YGCGL6TfQoI8mynxNG73+n60dw2q1Uq8la?=
 =?us-ascii?Q?kCYcIwi8xErVXQqE6YdFrlw3Mb12oXzvi/bAGHsWeyjqk7kcdJd1LAXi7bas?=
 =?us-ascii?Q?rMzSmaRSqJM9V7r0nZ0Nd98KDk11qBXhdkK2ISGN6l0c3G/jQRAlWCoDv/8F?=
 =?us-ascii?Q?oU9JNcVySQiercFTFCitICe3+v8bjcbkT2UJLokHI7jL63eVVKTunlwBE1q3?=
 =?us-ascii?Q?mJAXOLt0zaLD/vGNhaN7tlJlGEzfhIqJ1HNF1G8GWLkEc+zdiQBtv2KbiBEc?=
 =?us-ascii?Q?ouLaPyMN6FbSmTn+KYgFRK0c0l5ALlQtoICOeHScwB74GUAqbCTZ1Efu7s01?=
 =?us-ascii?Q?cvOzXyMGz1XHFw6K1AKOQN7yR54aHTvxmMuV5qqOJNp8cdAJ8LVdXCVfkE2y?=
 =?us-ascii?Q?I4TtcKttYSmVRQEQZZReojBvDtjGlScrE5WnM/JsnnMMnJVUs8D9steHfGB/?=
 =?us-ascii?Q?9m1wm9UPZUa6ZnQ4e9QlIzGU8gmSPNe+1Rt3GL9M8bSlK/q7YoZeP0s5tSnA?=
 =?us-ascii?Q?6ZBFSzCyYtVwePiY/KM82OLjWA2PcmCIe8TKBWdSk7tF2P/fIPZaS1XhxERR?=
 =?us-ascii?Q?SEvm3tvYi2ftbE/9m6WY9P8mGhxQjKUaZQM0QxZ8EOcx6cCuwdusq/Sd4ak0?=
 =?us-ascii?Q?ZQiIa9pGZzg/fB3z9J6tWxAwXFmlIgMErPLHqPy+9Cj76DYJoAhHqVasJUrU?=
 =?us-ascii?Q?GmQ/EKziHyoJKA7qymVmsYveiLQYOqQH+CtqpKbxePBvk4pUwniuqq3ggKxL?=
 =?us-ascii?Q?ZqxyK3/FLnwRpSCOcJ4Ahwee11HE7Ii+2FTXlICU41ZDd4Ki1MaoibBgWbFY?=
 =?us-ascii?Q?sObaA6HsLmVIqxDxRnTDwgM6i2czBNf67Pltb3+IB0dHmnaicl0V2H5wSfgG?=
 =?us-ascii?Q?YYoc+aZQtDMzLtE/Cttl0sRHn4RUBcov4JUURsSCbw13x5rqYxnhtqxYotfo?=
 =?us-ascii?Q?NAZyDWx+1E9m6tRTKJzK3DlTA95/bVv4CsH78WkOCckJQUeaar5gyj1OYl2v?=
 =?us-ascii?Q?D58XJukEsLQj/9W7TXK36rwfH1Lk7sabecVuCt8kQU3CZupRgRadEQo1+qNd?=
 =?us-ascii?Q?6g3HNn6WMc072/cae265B0AOc9weYAO+Seqh3qbQ+jdlpw0aNL+fSEQLixhA?=
 =?us-ascii?Q?6yoGL8UVzT+wHIbJXSDaw9JJiQnHZtxY8rHjEgu9BxzO+d3vERlHPoRMcM4t?=
 =?us-ascii?Q?l8B7CkZXEMfSpv50CQizTSiexR8Y4NJhk1kcdnHKd423C+gM2bSRrXmGs7/N?=
 =?us-ascii?Q?zSPxCws5vIvAo+evFPwfoOqMsebu6P6nJF8VVHa7J/R8JjEx2vDJbulz+fhV?=
 =?us-ascii?Q?BTj0xw5VgQgVIJgXIVnJMd27jTuHTStky1lqUK+2J3lcug=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(82310400014)(36860700004)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 09:22:28.0760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b170ef48-ec2a-4b45-2dea-08dc68f70e0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624

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
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 arch/x86/include/asm/sparsemem.h | 2 --
 arch/x86/mm/numa.c               | 4 ++--
 drivers/acpi/numa/srat.c         | 5 +++++
 include/linux/numa.h             | 7 +------
 4 files changed, 8 insertions(+), 10 deletions(-)

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
index 915033a75731..1d43371fafd2 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -36,12 +36,7 @@ int memory_add_physaddr_to_nid(u64 start);
 int phys_to_target_node(u64 start);
 #endif
 
-#ifndef numa_fill_memblks
-static inline int __init numa_fill_memblks(u64 start, u64 end)
-{
-	return NUMA_NO_MEMBLK;
-}
-#endif
+int numa_fill_memblks(u64 start, u64 end);
 
 #else /* !CONFIG_NUMA */
 static inline int numa_nearest_node(int node, unsigned int state)
-- 
2.39.2


