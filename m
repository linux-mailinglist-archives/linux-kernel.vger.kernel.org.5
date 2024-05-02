Return-Path: <linux-kernel+bounces-166487-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7948B9B57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08553B21E42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EA6824A7;
	Thu,  2 May 2024 13:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OR96MOx9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EF484A4C;
	Thu,  2 May 2024 13:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714655442; cv=fail; b=Ch/g2rxdMK2WECamzdqOW7ex+9JxZXLqWS/WwDhT+61m38BJcxwXKf3y6E0Aa+A0c9sUKKZZeYS9LzpwJm7G/6CTna8NWgPdNQMcIqkqwWf6sUwnWH3yAHF4ZZVIIYsDYa/6fq1cwBXjxkxbVzSVDYZl4AecDReerYABDyvi8Io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714655442; c=relaxed/simple;
	bh=w9bhUqg6oqAtYJnC+gvdjbA2FR9qwJ8cIsGDaNiKjE0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UdfZS6dZ5TJbUwUxKUNEOQyBHsOe3ggJj1y3G8WwkZFhdJzOeuL5TdROeEUcr/y7MKmK69mpzJjv/6vEFnOwJrQ15ey6MYXPIfQCMquJ2hfDnJDByVnzy2Lto8ecaoPDxad1n45a/5K3FIIwEIw4EJbx0AAETVRSqV/4VQfVXDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OR96MOx9; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1dm1noD3ulkcxJdQCCRz0y9ykGL6kkyz19al/mydF79+QpRKit4tBC5TB4KWvaE8uuRjKIgJfo54Fj+K+6Q84RTOHH5nykStjrPLsRJaTcpkjqBP5W6bUWoAzSdLIA+UF4yYqRcsF7F306vzMk1CvC1RK09vXhtPjJgbfi9Xe2ebGHIrQf2bPPNhhpBP8S0JpIsVLzW15neQZmgk6wafbSvW3LWrXBs6maLKzRX6c1MhHIjpLxLZHARlNLn9kc8XiWrG8lj+kOlnjq5EP5q7WXLYE+xRRJNrTZA0+oX9eaINTGJOcHzJqqHFjyyjx/BRJdFdiranF/4Qp2p9n4yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H0fBmZ+MpiN8madmmxMpxrrfw202+Ko/QzP2gtvv7ZA=;
 b=Qm+tVVIarLFoV24tIXAS2Nw95G1qDMB5uBsXe2JHxERbjYizB91doTEANpMeaHTzu2pxjwgcVrmBecD6y00/H7UAm1T1aUNnFuYKsSfy43i7iEIPKknSn7ocDNb0KqhNetUN41dA42xDfZqmZLxEzDEEi6JKIJi0oDMCsu3QZy6ItlLyhP30B0pVdmNaMuspWbY1uPNjXiJvcAqBrMAHDBQCFK0g8nXhRGL00QWEdzcc31CCd4c5Mg9bO1bBbh8E5U8zwfHdRq+xsRHJp+vwyqXM9G6QSlNG+6xKdx01zkkU2x513tx9a2smpBbYfx2seYnJeQLrCVLFICSkrDyMUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H0fBmZ+MpiN8madmmxMpxrrfw202+Ko/QzP2gtvv7ZA=;
 b=OR96MOx9tcBcbql6jaSBCUelkJjzUFyGUUa3iolA2SHMNTPjMQGjA2R8Q7tYKPZ6WKwZtz2Djbh0yosY+wlYEyLVwur0td40CaJp4V47/BHa4jihr8ATsZYHLk+rGvTAGZl34F2NgP2/xkikdy+biQvF73UIkgYJCNHcsJbr+wo=
Received: from CH5P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::7)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 13:10:37 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::a9) by CH5P221CA0014.outlook.office365.com
 (2603:10b6:610:1f2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Thu, 2 May 2024 13:10:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 2 May 2024 13:10:36 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 2 May
 2024 08:10:33 -0500
From: Robert Richter <rrichter@amd.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, Robert Richter <rrichter@amd.com>, Derick Marks
	<derick.w.marks@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Len Brown <lenb@kernel.org>
Subject: [PATCH v7 1/4] x86/numa: Fix SRAT lookup of CFMWS ranges with numa_fill_memblks()
Date: Thu, 2 May 2024 15:10:09 +0200
Message-ID: <20240502131012.2385725-2-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: a087797f-9cb1-40dd-207d-08dc6aa94214
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|1800799015|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j3uveNV40hoaS3+KBIYWHp5776UTqdoyLmbmDDwIJaG6ib9VpS7AOYMVDaIW?=
 =?us-ascii?Q?yuhRepUWv+Ke7BdZo8wbPFp5F4n9O9fRAfVAnszaSNoKOKGzXkZ7y8+n0eri?=
 =?us-ascii?Q?Ul4pw1ps4etK2Ct+iqdOFT96xieAJ79/ZNw0occvScav9jA3dgDez6/WCHQu?=
 =?us-ascii?Q?VGXDKU8ZhB5sxIVJhSgHLh7qi1GN6LSwULBJj2STjc/WF3jlGiak/5TdKauS?=
 =?us-ascii?Q?nPeASMej38Wlt4Llj8w+vhizOOvgu2vXV10q7iCXH/Qk1vp3x4lRAFAVJBSA?=
 =?us-ascii?Q?biiBopVk6ioRi+ou9XfiS4Pw4xsImfHolWAPSW7jZrp0hkEbZLQVh5HLYGfU?=
 =?us-ascii?Q?96sZX/xcWyzmyCCbewdVRAcux9CAgIHLodOKcUsyYX4k9/tdagza0DbkdPKN?=
 =?us-ascii?Q?QVdaBgUGTiVyYasxLLwnNEZw7MOvJU2wHXmo4ZiF53RlluNu5sKlJB70JESV?=
 =?us-ascii?Q?rLhB8JilPPqfiSdAA+TRLjujZM7Oig0NNmcmohzNAYgLh153gy7R7rFdkY5w?=
 =?us-ascii?Q?6iWmYX71VKQaTae4el35E1e06FyepMEYA+wiu7oHjeHytxs4wae0Be3zYJP5?=
 =?us-ascii?Q?/rsefpr1pQ3J9pYdiqaH2SIigTpAr/+1QlxY7JUl7Po+XdCyz8eUiG/IEkSQ?=
 =?us-ascii?Q?q5WHjQ4D4JcvuYau6XSRQNje5J8HDDqFGS9AFmnqlTNnvmrG+qQJXMiuADGq?=
 =?us-ascii?Q?lLs4zoT/wC6JWB6UnTr4dukMvhRpdQUdcCJ9NsuDSfY24uP+y9wmLrRJsGDm?=
 =?us-ascii?Q?MYGiWhN1i6rsQ7ysubS2cQNt/E3z7IRX27IYMkNuzBPCxEyuW+SQsdTzVjB7?=
 =?us-ascii?Q?C/WcC6jKJZISv1gazYpmFAKeCtQW8JFHuv8NHqzGfMX6t/BYNf+Z7NinUWKX?=
 =?us-ascii?Q?wXm7gKSuU8LzsARTx6uon+Mk0w26PbSiOfSarTDrtZRkEZePMWuOjuEXqx+t?=
 =?us-ascii?Q?Gq52gJzlcJqzAmrWAhjTeRam3Ic3WWWFUHk6Sf2YZZ3IrxE1vqymVXJv8wNT?=
 =?us-ascii?Q?P+wZDJy5AlY+wgKrhdfH3qDHMQikIqhbUeO3z+0hWs33u9Wt+YzI1GIBZDkL?=
 =?us-ascii?Q?x5yamneURymfoG1JpQvoL5WkMYTnogMDIdVDT4FCqr1OiTl1i8VjKakNRE3c?=
 =?us-ascii?Q?zWvxVTdzUG5wPp6+6ij0TN3GmVkQ3uFJaaOJk3E6V77pjfFLXrRV42ust5/Q?=
 =?us-ascii?Q?OMRGoVQosKBFZX4sRo0EYt8Bexy28SeSiYHL671jAiLJH4T9xVm+iOnoA9yI?=
 =?us-ascii?Q?nruS8vjgohYO6e7l/xhu5sI3kFNgTf7oQz4mVb3oqOeadKi7egEa0a+4YBnh?=
 =?us-ascii?Q?KfHBv8rtx1nOh5Lh4NDlSIuJuUkGRW71fAaZiXPH2flgZg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 13:10:36.9775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a087797f-9cb1-40dd-207d-08dc6aa94214
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

For configurations that have the kconfig option NUMA_KEEP_MEMINFO
disabled, numa_fill_memblks() only returns with NUMA_NO_MEMBLK (-1).
SRAT lookup fails then because an existing SRAT memory range cannot be
found for a CFMWS address range. This causes the addition of a
duplicate numa_memblk with a different node id and a subsequent page
fault and kernel crash during boot.

Fix this by making numa_fill_memblks() always available regardless of
NUMA_KEEP_MEMINFO.

As Dan suggested, the fix is implemented to remove numa_fill_memblks()
from sparsemem.h and alos using __weak for the function.

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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
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


