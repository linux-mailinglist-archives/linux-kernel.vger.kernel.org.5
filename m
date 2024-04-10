Return-Path: <linux-kernel+bounces-139281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D88A00E1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAC091C222D2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7064184106;
	Wed, 10 Apr 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hgFOFrCv"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251AC181D03
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778555; cv=fail; b=lhyI9VcK7P3aTKyYAl9+kC+JJqJYP4yrDzCzvO9oMgg9AkD07ovfQiRB62gRyxk3fP45PgzUQMT9o/HnOfFXIbGAcl93EnklDglFds7Yz3Q21HFDJ78hV1ahbuvc7gEeikoecCGUlaCmhVtf00Q1lb9DczF3FbFgVA6z4gJEs/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778555; c=relaxed/simple;
	bh=o830/DJFL4U106VzIRc/+Qxpt3MtCj9Wj31tTA9JX4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jF3/8AiUVtNMv7D9jPp3J5e9bW5/YJf0Yjr77m+HMLfCjJlDmkQifn3BBnqqR7eatPlVQfGdi0BvhT3r4IaUoL/HOMi6g/3g+dpmv+Rj/2cRClPsDEqyjcnihhLy4ryVoLcC3as9dOpDvu12a2GK2QMcg7tWbgMDSw9rSvlvpyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hgFOFrCv; arc=fail smtp.client-ip=40.107.93.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KG88tcF5mZFhJM9eOoIzRKCF50WcxyC3ktn7v/8C4g0ept1S2pellel2FVUtjx3+OlBLvTNllI8+NJLRPm5+A4z81GKDCJ2VKz454N+FqYj3r7AzDRJ/LTc5/8f+bk0N8AUhDZtapEBLV60mvGwyj0jgJibayKVpvNUTxi4+L5MjMhphOKzKVZjEudwgfsImapek7rp93mve4SzpKIkovfpnCIaD14v3NkniQvqmDTIjRofpVQsu3nF68TbRQuqlvHH2zj+cv8CUUoGIzbil+EfP2w+lZbpDX0B4coCJLCZbSZwLLDCdyIS3N0eyUnOs1Vr/JgiO6pCnLD8CH/i8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9P1w22kGcM/YIuzXKmy4d/dILHBo+JSHWpnaF5lHxI=;
 b=Kvy5cNQMbP8c9m9UkupV/4wDFkyxFsqu3RdXhthqpkJLTQ3C5xP1Uz5t76b2qY1xhDL2Hjf8GsMIwvaFP/KtcEvoB4reGNDyVW12u1xFquLVnr5IuRp5fsFHLn8uJi20OOoM+iVnKk6DX4gvVFgBs2YlS3XtWN19BcoyacpzS5M0JlnZWHdstjakaWRwXmZP4E2fQcXmKZSFX66Ov0LbM02knpfLmh3s/7U502L25XaFdtAlrSVWa222BE/ZJQT6amsrUKXjKl+3f1riavLT3NZG/DBe1g8Tsg7TzQ9o5gkiQmcg1VdTgGgFKpOqKG+fEf0IbOchpInIA1Z0WrRVEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9P1w22kGcM/YIuzXKmy4d/dILHBo+JSHWpnaF5lHxI=;
 b=hgFOFrCvhL9sO4gdpg9+idWmMu9igWCc8YjVuvG0kymR4hlYpHr1Erddv1ixHQkqZnlHLiu2y/df15gTjqEJPLuQouxZRVpkgiHykoCDWYOwIYEWoKhW57mvRHNHMWnCWqgDRbFW1hGCqSom4xIlnRbBoysnqt0TWqc/XL4d6u8=
Received: from SN7PR04CA0232.namprd04.prod.outlook.com (2603:10b6:806:127::27)
 by SJ1PR12MB6241.namprd12.prod.outlook.com (2603:10b6:a03:458::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.45; Wed, 10 Apr
 2024 19:49:09 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::77) by SN7PR04CA0232.outlook.office365.com
 (2603:10b6:806:127::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 19:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 19:49:06 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:49:06 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:49:05 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 14:49:04 -0500
From: Jason Andryuk <jason.andryuk@amd.com>
To: Juergen Gross <jgross@suse.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
	<hpa@zytor.com>, Stefano Stabellini <sstabellini@kernel.org>, "Oleksandr
 Tyshchenko" <oleksandr_tyshchenko@epam.com>, Paolo Bonzini
	<pbonzini@redhat.com>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>, "Jason
 Andryuk" <jason.andryuk@amd.com>
Subject: [PATCH 4/5] x86/kernel: Move page table macros to new header
Date: Wed, 10 Apr 2024 15:48:49 -0400
Message-ID: <20240410194850.39994-5-jason.andryuk@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240410194850.39994-1-jason.andryuk@amd.com>
References: <20240410194850.39994-1-jason.andryuk@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|SJ1PR12MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: 67010e63-3262-47d2-bed8-08dc5997482a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lf6/4YNvxFSy7vaTA8J4dp6W5kXrhwYlfGr9FCsr7ApDv9IUFrHysrkaFw6t6jWIyXvg0Y/1z0KAXiYx4ITzlC6qLtcqlGumsDkSPRhzxEdSIIKw2SrC1GCFCQGHaDucBVENGlmUZL4TN4pJjH11zbo60Ti49YeJvBQeWBDTwtoA6FIPKUtJKeRURbPBS22oYOpW83Flh/DjuigvFyTeZMzLXqfcADTLzpNP4ZCpBziAS3kcgCrEWMClb/eK+wW0321UwneJftdxtAt81EeFgusPO6WqFe++sh3dkAKsrDkmslnvwXdibJRNqbzk5286l3RwmWebWG+6BJumsehPaDdL1SVA5pGVTJOWJge/iq75ngKzGXLjjGgECmJJSxc7pmbHU7BqR2K8+vsbOqzv3pQskyCCcjOJGyOIxNX2QDTt929+O5mmWyPSW0U2QWUdlp1X+vH1zrI9tGNA/IZPhto5mG1X+N63uBYo+cxLeZDdHvicuW2WWCRABBvCrm09uO4TiCT8wXbDk1d7qnNNLbxEBYkPL1KgOkRdLz9h405rS40SBCTdZhKcFnRfXIalmy7gKGRODBMlUTPi5i9yIhzFR/hqV92XpOGQp9/ByR3++pHHQ/03LjdlGY3TQ85YaqO3OZVmCxCiarAcqiy/JygLO2cPMJKU45P8WEkz2CmysSdyiMvTlGLe5q5kyz3C9lPCtcFHdfsL6diib/xMdfiX5F8IuXXq5Ylr0bhWjgCrpdkrCo7Lq4yQymIDI4Y685QyBa29GckKspg+aP1Kag==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(7416005)(36860700004)(1800799015)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:49:06.4837
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67010e63-3262-47d2-bed8-08dc5997482a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6241

The PVH entry point will need an additional set of prebuild page tables.
Move the macros and defines to a new header so they can be re-used.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
checkpatch.pl gives an error: "ERROR: Macros with multiple statements
should be enclosed in a do - while loop" about the moved PMDS macro.
But PMDS is an assembler macro, so its not applicable.
---
 arch/x86/kernel/head_64.S            | 22 ++--------------------
 arch/x86/kernel/pgtable_64_helpers.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 20 deletions(-)
 create mode 100644 arch/x86/kernel/pgtable_64_helpers.h

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index d4918d03efb4..4b036f3220f2 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -27,17 +27,12 @@
 #include <asm/fixmap.h>
 #include <asm/smp.h>
 
+#include "pgtable_64_helpers.h"
+
 /*
  * We are not able to switch in one step to the final KERNEL ADDRESS SPACE
  * because we need identity-mapped pages.
  */
-#define l4_index(x)	(((x) >> 39) & 511)
-#define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
-
-L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
-L4_START_KERNEL = l4_index(__START_KERNEL_map)
-
-L3_START_KERNEL = pud_index(__START_KERNEL_map)
 
 	.text
 	__HEAD
@@ -619,9 +614,6 @@ SYM_CODE_START_NOALIGN(vc_no_ghcb)
 SYM_CODE_END(vc_no_ghcb)
 #endif
 
-#define SYM_DATA_START_PAGE_ALIGNED(name)			\
-	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
-
 #ifdef CONFIG_PAGE_TABLE_ISOLATION
 /*
  * Each PGD needs to be 8k long and 8k aligned.  We do not
@@ -643,14 +635,6 @@ SYM_CODE_END(vc_no_ghcb)
 #define PTI_USER_PGD_FILL	0
 #endif
 
-/* Automate the creation of 1 to 1 mapping pmd entries */
-#define PMDS(START, PERM, COUNT)			\
-	i = 0 ;						\
-	.rept (COUNT) ;					\
-	.quad	(START) + (i << PMD_SHIFT) + (PERM) ;	\
-	i = i + 1 ;					\
-	.endr
-
 	__INITDATA
 	.balign 4
 
@@ -749,8 +733,6 @@ SYM_DATA_START_PAGE_ALIGNED(level1_fixmap_pgt)
 	.endr
 SYM_DATA_END(level1_fixmap_pgt)
 
-#undef PMDS
-
 	.data
 	.align 16
 
diff --git a/arch/x86/kernel/pgtable_64_helpers.h b/arch/x86/kernel/pgtable_64_helpers.h
new file mode 100644
index 000000000000..0ae87d768ce2
--- /dev/null
+++ b/arch/x86/kernel/pgtable_64_helpers.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PGTABLES_64_H__
+#define __PGTABLES_64_H__
+
+#ifdef __ASSEMBLY__
+
+#define l4_index(x)	(((x) >> 39) & 511)
+#define pud_index(x)	(((x) >> PUD_SHIFT) & (PTRS_PER_PUD-1))
+
+L4_PAGE_OFFSET = l4_index(__PAGE_OFFSET_BASE_L4)
+L4_START_KERNEL = l4_index(__START_KERNEL_map)
+
+L3_START_KERNEL = pud_index(__START_KERNEL_map)
+
+#define SYM_DATA_START_PAGE_ALIGNED(name)			\
+	SYM_START(name, SYM_L_GLOBAL, .balign PAGE_SIZE)
+
+/* Automate the creation of 1 to 1 mapping pmd entries */
+#define PMDS(START, PERM, COUNT)			\
+	i = 0 ;						\
+	.rept (COUNT) ;					\
+	.quad	(START) + (i << PMD_SHIFT) + (PERM) ;	\
+	i = i + 1 ;					\
+	.endr
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __PGTABLES_64_H__ */
-- 
2.44.0


