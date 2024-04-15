Return-Path: <linux-kernel+bounces-145914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D84B88A5CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BFD7285914
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516D91DFEB;
	Mon, 15 Apr 2024 21:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tKBK6JQ7"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22FA156961;
	Mon, 15 Apr 2024 21:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713215378; cv=fail; b=RiVqUMWVFYPF1ltYt8oHmRaRI8oqVQmzPSTbmJ9XkbHW1jOCKmh4mpgW3HimVu9afTtadNd1aDQyyARXic8+fwUKen4qRO4lef/MEO2RB+FDUJvoYYSE/wWwlEY8WFLyDOwqsX2DN2gAJfw2QmHM5f6SB9vEWRXM8dkU67PLBYI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713215378; c=relaxed/simple;
	bh=Ll1Vf5zHveiSjdaoZ/MLX9MYZGlOxSCLhW2FBBNX/LU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MMQeA2/UXq7Tu4jPXavzDO5UBO1uQm+haJXev3n5rGu7C5Maa42leGdkNqUl67oGi84E+LO0I/DKjExxyeYSXoPQl9Xv/CNwlmpJYn/1nnqJFtZA/a8OtAWAZlk9fxmNWC3tOLWSDYPN2J+awSXlzFA0ikc+2vH5oZsZ5IudqLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tKBK6JQ7; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VJnQMDj1a7QurtluceiMfrOx60dAVvQf1MKG/Sv5VyEShFQJ9DDVf0khf/sLOPqpxqF+Ji8P0uCKDkI2aWQIPMForf4C6mnS+zjOmoyb1EZlBbvJCKrWKN3bn/dusAfNoxfLeNgKvH75DlnGvTSEfM/ZmFHixN6ofk9ZoQwYNAMw8kcUf6c5WEiqWAvIHc4y8EXwXtLlL/xdjjLw4yveXGxwp/OqyelGAHWUVyvYw7RvLf4NS3NBkSZ6kZg4Hirloi70kDAB98siU9wNW0gD8o2EIxjzUuW0r4rX2AfnlGRTECN/TvgQMBX2iWTUr6rLFORbMW/Y0X6e96CGaveKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bptdw/nRLL74gnwStM13lZRSxVVYJKyVHK0hqgFL98Y=;
 b=icQv2QvahIuPUlaI4lwZYtTQH5yE0NbYad3dKQPkrk2myN0rVJqF7C1cgE86/vaZqBmTQTDiVniLlKwiu2gtGTzrHwpFmM/TKKSCbuRRusiBeppOfsxMhmauI7cLkOPPwl1g+u9m5ML/N6SWr4OtQpymCi1SLSCmeWehXGaxFI43EAVa1YeFUIjK2tSPg1KYfqVwzL3HXykPrcCedqFVq6dzhoU1A5Z5ZSFJrBrhG1pMIyX8o7xJUCo6pR5YSIQbVsypXU2PCstJNbDmGSKExwVKSLO/2sUF4N8DubzxPtnDQvxtNxBKxfahMUa8yI0PuLg5ywItE0FdPOyRcRX8LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bptdw/nRLL74gnwStM13lZRSxVVYJKyVHK0hqgFL98Y=;
 b=tKBK6JQ7orFlQA4gL3xaBHGGa18JbNBcT+oOe3PAx24WWJy2ruJmzs4Hr1NyduB0xwOCzoWS8mVvGHz7fnC1sgcqaCSR2ntuEki170DqMmLnQiz6BdPx1U6mDRpp6DeO2H6i4LNY8N50bHsJ+KdtBtckf5klGbpf0+S+S2yLpfc=
Received: from BN0PR04CA0054.namprd04.prod.outlook.com (2603:10b6:408:e8::29)
 by PH7PR12MB7210.namprd12.prod.outlook.com (2603:10b6:510:205::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 21:09:34 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:e8:cafe::5c) by BN0PR04CA0054.outlook.office365.com
 (2603:10b6:408:e8::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Mon, 15 Apr 2024 21:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Mon, 15 Apr 2024 21:09:33 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Apr
 2024 16:09:33 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <bp@alien8.de>, <thomas.lendacky@amd.com>, <michael.roth@amd.com>,
	<x86@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/2] x86/sev: Add callback to apply RMP table fixups for kexec.
Date: Mon, 15 Apr 2024 21:09:24 +0000
Message-ID: <96b2949cf225501d686b47070c7bbad341e160a3.1713212104.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713212104.git.ashish.kalra@amd.com>
References: <cover.1713212104.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|PH7PR12MB7210:EE_
X-MS-Office365-Filtering-Correlation-Id: 41097632-0263-4d3b-4ac8-08dc5d90598d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PRZWcGKVKeRep9CV2lXy0ia0Cv+bvFp+VOPWhdCX6bRm5au2QqSJZogcjfB/AXKQ/4tWkk16NByw7+pDhv1VqF+Ft43mK+45JY97g2emMidizzUcHmKzcqvoX+cZrEOKlkvBVhz1WHiMO14o1bj/5ULjIGxKVDhObktLrCU/2lgmM56mr28hauQuKOe2xYhozz5whANKoCJ4Y7ivxTnBFeMUYMY/S91lWXSq9xipTRv18ghG+pousnB/IoAqKoSiGYPyRbIq3AyZxg0J6MwwKPnRqgFSutOYWtGd9AynAu4L1SaM6iFq/lCEXtSxIe9imka+8EXj5AbBsb/myl8uAhrhsCHqPGB++LNYXvyGpVjYUu9AuWP5L2ewcnDWLujVcXcUvtMoXggtg37HvVngeguuc3jHBTiQ0XUFec2XekzHz2LX9arOuPNWHHxur2pmVtRd4DdkIgvoT/6txFnztyH6twqmRi0yOS29ECxocOnliVY4UczDbjS5NbPGJn87B9s1qdRIIN6zYp2KNXyxCClPCkRrVBMeC81vxDyGPmHtfqs/fxIrWW7NqzUlWTiHAW66hvN3H9QLR7/EAofosy8G+5vXrog6dfGzp5zQkR/soVeHT1q1/+VvWEtXHknH2kZQ13B1attUAxrA82xxAEwNVyuTgxA4xuCPFV9tWuI34jk1/OraTEwdsGxxhLwz0qiBc29J07CbQxn7JxJf1At6E2kf14upCXsdZdM2CDGox1ZuRE4lPwDprKLxDmAd
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 21:09:33.8404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41097632-0263-4d3b-4ac8-08dc5d90598d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7210

From: Ashish Kalra <ashish.kalra@amd.com>

Handle cases where the RMP table placement in the BIOS is
not 2M aligned and then the kexec kernel could try to allocate
from within that chunk and that causes a fatal RMP fault.
Check if RMP table start & end physical range in e820_table
is not aligned to 2MB and in that case use e820__range_update()
to map this range to reserved.

The callback to apply these RMP table fixups needs to be called
after the e820 tables are setup/populated and before the e820 map
has been converted to the standard Linux memory resources and e820 map
is no longer used and modifying it has no effect.

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/mm/mem_encrypt.c  |  3 +++
 arch/x86/virt/svm/sev.c    | 44 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 7f57382afee4..6600ac467cf9 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -269,6 +269,7 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
+void snp_rmptable_e820_fixup(void);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -282,6 +283,7 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
+static inline void snp_rmptable_e820_fixup(void) {}
 #endif
 
 #endif
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 6f3b3e028718..765ce94e4b89 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -102,6 +102,9 @@ void __init mem_encrypt_setup_arch(void)
 	phys_addr_t total_mem = memblock_phys_mem_size();
 	unsigned long size;
 
+	if (cpu_feature_enabled(X86_FEATURE_SEV_SNP))
+		snp_rmptable_e820_fixup();
+
 	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		return;
 
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index ab0e8448bb6e..d999ff7f1671 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -163,6 +163,50 @@ bool snp_probe_rmptable_info(void)
 	return true;
 }
 
+/*
+ * Callback to do any RMP table fixups, needs to be called
+ * after e820__memory_setup(), after the e820 tables are
+ * setup/populated and before e820__reserve_resources(), before
+ * the e820 map has been converted to the standard Linux memory
+ * resources and e820 map is no longer used and modifying it
+ * has no effect.
+ */
+void __init snp_rmptable_e820_fixup(void)
+{
+	u64 pa;
+
+	/*
+	 * Handle cases where the RMP table placement in the BIOS is not 2M aligned
+	 * and then the kexec kernel could try to allocate from within that chunk
+	 * and that causes a fatal RMP fault. Check if RMP table start & end
+	 * physical range in e820_table is not aligned to 2MB and in that case use
+	 * e820__range_update() to map this range to reserved, e820__range_update()
+	 * nicely handles partial range update and also merges any consecutive
+	 * ranges of the same type.
+	 */
+	pa = probed_rmp_base;
+	if (!IS_ALIGNED(pa, PMD_SIZE)) {
+		pa = ALIGN_DOWN(pa, PMD_SIZE);
+		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+			pr_info("Reserving start of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		}
+	}
+
+	pa = probed_rmp_base + probed_rmp_size;
+	if (!IS_ALIGNED(pa, PMD_SIZE)) {
+		pa = ALIGN_DOWN(pa, PMD_SIZE);
+		if (e820__mapped_any(pa, pa + PMD_SIZE, E820_TYPE_RAM)) {
+			pr_info("Reserving end of RMP table on a 2MB boundary [0x%016llx]\n", pa);
+			e820__range_update(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+			e820__range_update_kexec(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+			e820__range_update_firmware(pa, PMD_SIZE, E820_TYPE_RAM, E820_TYPE_RESERVED);
+		}
+	}
+}
+
 /*
  * Do the necessary preparations which are verified by the firmware as
  * described in the SNP_INIT_EX firmware command description in the SNP
-- 
2.34.1


