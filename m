Return-Path: <linux-kernel+bounces-139280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CD58A00E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56B63B2605A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FFC184105;
	Wed, 10 Apr 2024 19:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WzpIdH2Z"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B886E1836FD
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712778555; cv=fail; b=G69YrioFae+B77kMJRZd0y5Xgq9dB+vltmQU0baV7HQag2gJTI8Uix148hmM9nf4GLSz08ibSkOQNvAXX2C8tqSA/UpDKYabTUNcQKO0DI2S25dqEgw6bz7zIeYoL2cpgA82SQIUnAV6fx1Mhv6kZftEin8O7tCBz9vETmvBkXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712778555; c=relaxed/simple;
	bh=Ci7haoYRr8687r9aOJ7Q6dVen6tkZHVaVnv4Defj3dQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlNp9WYRlOv7G0q5PiJ/JaYhGJEvB3dGfsCJV+zJe+OGO200XYPfUBFoejfdgoT+IP7XThJSUB/0RLG7ON2PvUAXKwIGvTEAGRW2dtHSB8CIQkSs2/Yr2hqSAQRKAXHy7C9qypc2qOe24NQL56KSwMdvCbXuHTDwJJ5uB/7cE2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WzpIdH2Z; arc=fail smtp.client-ip=40.107.223.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HeXhF0Gq8r5kfAGnxVhbsDAsPXAiEhZ3WOCglTzGxMVBt7IUnbgrGoE59QLOTuWVBOfk9P5iyJTyIECkn5SN6eXqVEBOi/9OqY8oqIwCrQvPc1s9Z3CQaPRe2ulOWO3GekTaZiqzqNUNLmWRIHQahY+lUrg7UBCHnCPCWDNXjjSaMFGef7LVCeyli4pn0W5yhB9aEol45zE0AlKAqcsOw+ooWNAsv10Tl09kOH2Yp8Lh6vPwGIQprto+c7zglPbDb2J8uvl/dbzoxgJOwTW84c/ifuoUQ6zTObslfYLzjPJ1FryNuW/i6MGwlZF97AelwYua0ifgR8P5V7r81O3Kww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJcvBdWX17XntXG7nnPBUo+yiX3g7hqZkIUkQ22tiy8=;
 b=ZPrAw+Qyj83DqJhQ1xW44DUWMnn6+/1hcXhx90u02/lO5kCNFgbLVODdx5LS3oVyh65O3EcYL97TGNiuZ8ur7NrdYQF5VkaqZaRS/tOhcLvek0mXEkTPtx51aDRB49UDPezCmFTVm0RJurcqEcNFBAuvtIlPO7o6f4922qPaW/Fu5gHsykCq/gcFaSDAt+dC0REYrLGXpFuGMS/qvTMYWXHpsPV0n3l5FadEK8IFVAnCw2k5JIhaS/Z+tRonny7WYXDoE9rPl4ljwWf0yfD+xa3YeugILLjNV+R9rue3dliKvxwkG+D69eCArUqpL5trPndWqbLSgQYRd+2szA9WHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJcvBdWX17XntXG7nnPBUo+yiX3g7hqZkIUkQ22tiy8=;
 b=WzpIdH2Z3wBMrgtb52wZ+6MJNT76sDX58kBQB9y8ak/ShILVBAeJiHExU0343Z/uQq7E7Go9otCJKaEq8hIChUtTqY1OjySaocJ8yFiyC25gLkYBhwIes/Q9Y5YinyRNJGauBNuyubVdZ8ZpYdfPvmMQjXVrHUd8lzrLdnVxXz8=
Received: from SN7PR04CA0214.namprd04.prod.outlook.com (2603:10b6:806:127::9)
 by BL1PR12MB5780.namprd12.prod.outlook.com (2603:10b6:208:393::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 19:49:10 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::fe) by SN7PR04CA0214.outlook.office365.com
 (2603:10b6:806:127::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 19:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 19:49:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Apr
 2024 14:49:09 -0500
Received: from fedora.mshome.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 10 Apr 2024 14:49:07 -0500
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
Subject: [PATCH 5/5] x86/pvh: Add 64bit relocation page tables
Date: Wed, 10 Apr 2024 15:48:50 -0400
Message-ID: <20240410194850.39994-6-jason.andryuk@amd.com>
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
Received-SPF: None (SATLEXMB04.amd.com: jason.andryuk@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BL1PR12MB5780:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d54aceb-29a4-4713-b9f4-08dc59974a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7pezkZQ//Se4v0JvD3x4hLYAlIKS3Bh/TWtA8kWmz8yBAAX9Ehu0NYlbuUwnwGyu45WGKNbu4xrGE2nOFjuxmulLWFL2wfwIBrUmYzJZj8Ou4xQuqSmBHo6ut4k1jJkp7VIyKAcLqGYJIwIw8o+6DlGTNuwatYdhnzUI2mRXVCOtYeS/9xHXrnJ91uAKygIrx2NWq2/Y30FSI6gFKjvPv+PjPw6zqff2+0GvGpVxIYvWrqKD0CdASF4gfPzGeFW9rlA6n4Y494lRdvxfj211AQENQ0t+NnAP4/GHiHodSnXWNeEgaAD8cwFa7nh126jhhZaZtvPqyHvpGh8wlmiM/g8qyKgQpCwJQtu/txNg+l7ATuqPu0KmzhqFNANYR9j1Sc/c2g2T6Bg9GVyP8QDXRTXm9aR64yI7mXyANnghBopD0zfIcmBKUPgfG6FjL6RTyzxhtbL7UmMPEJqy821hFIiVqiFqQlRqAirbLnYgLgUwoczspEdfhiD8zPRXRl0jzzsYygy+p8Ns+v/9HcqWJXNctEbSEyN8gxfEqJgOfwYdv8KzWbu85WtYJrBA+p4jARwVO2RxpSBRn3xdqwolJs7SNMg303x8S6eFA4IY3xQdbFTbyVBh0sLYK7JDXEvJgoJz/S5cKGa3e+EGo3SfAYXlnu9d4avPOVoBOPii4667QBVo6KKM+HZ38Xq01wx7JuVe1lEzJodH5sLKdW6/7GXTQDITQ4xHbloT8lxasBfw7Gglx69jUgEnfBjsFOS6DIAPJyPNg2N2r7sUmL6w6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(36860700004)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 19:49:10.2650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d54aceb-29a4-4713-b9f4-08dc59974a6b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5780

The PVH entry point is 32bit.  For a 64bit kernel, the entry point must
switch to 64bit mode, which requires a set of page tables.  In the past,
PVH used init_top_pgt.

This works fine when the kernel is loaded at LOAD_PHYSICAL_ADDR, as the
page tables are prebuilt for this address.  If the kernel is loaded at a
different address, they need to be adjusted.

__startup_64() adjusts the prebuilt page tables for the physical load
address, but it is 64bit code.  The 32bit PVH entry code can't call it
to adjust the page tables, so it can't readily be re-used.

64bit PVH entry needs page tables set up for identity map, the kernel
high map and the direct map.  pvh_start_xen() enters identity mapped.
Inside xen_prepare_pvh(), it jumps through a pv_ops function pointer
into the highmap.  The direct map is used for __va() on the initramfs
and other guest physical addresses.

Add a dedicated set of prebuild page tables for PVH entry.  They are
adjusted in assembly before loading.

Add XEN_ELFNOTE_PHYS32_RELOC to indicate support for relocation
along with the kernel's loading constraints.  The maximum load address,
KERNEL_IMAGE_SIZE - 1, is determined by a single pvh_level2_ident_pgt
page.  It could be larger with more pages.

Signed-off-by: Jason Andryuk <jason.andryuk@amd.com>
---
Instead of adding 5 pages of prebuilt page tables, they could be
contructed dynamically in the .bss area.  They are then only used for
PVH entry and until transitioning to init_top_pgt.  The .bss is later
cleared.  It's safer to add the dedicated pages, so that is done here.
---
 arch/x86/platform/pvh/head.S | 105 ++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index c08d08d8cc92..4af3cfbcf2f8 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -21,6 +21,8 @@
 #include <asm/nospec-branch.h>
 #include <xen/interface/elfnote.h>
 
+#include "../kernel/pgtable_64_helpers.h"
+
 	__HEAD
 
 /*
@@ -102,8 +104,47 @@ SYM_CODE_START_LOCAL(pvh_start_xen)
 	btsl $_EFER_LME, %eax
 	wrmsr
 
+	mov %ebp, %ebx
+	subl $LOAD_PHYSICAL_ADDR, %ebx /* offset */
+	jz .Lpagetable_done
+
+	/* Fixup page-tables for relocation. */
+	leal rva(pvh_init_top_pgt)(%ebp), %edi
+	movl $512, %ecx
+2:
+	testl $_PAGE_PRESENT, 0x00(%edi)
+	jz 1f
+	addl %ebx, 0x00(%edi)
+1:
+	addl $8, %edi
+	decl %ecx
+	jnz 2b
+
+	/* L3 ident has a single entry. */
+	leal rva(pvh_level3_ident_pgt)(%ebp), %edi
+	addl %ebx, 0x00(%edi)
+
+	leal rva(pvh_level3_kernel_pgt)(%ebp), %edi
+	addl %ebx, (4096 - 16)(%edi)
+	addl %ebx, (4096 - 8)(%edi)
+
+	/* pvh_level2_ident_pgt is fine - large pages */
+
+	/* pvh_level2_kernel_pgt needs adjustment - large pages */
+	leal rva(pvh_level2_kernel_pgt)(%ebp), %edi
+	movl $512, %ecx
+2:
+	testl $_PAGE_PRESENT, 0x00(%edi)
+	jz 1f
+	addl %ebx, 0x00(%edi)
+1:
+	addl $8, %edi
+	decl %ecx
+	jnz 2b
+
+.Lpagetable_done:
 	/* Enable pre-constructed page tables. */
-	leal rva(init_top_pgt)(%ebp), %eax
+	leal rva(pvh_init_top_pgt)(%ebp), %eax
 	mov %eax, %cr3
 	mov $(X86_CR0_PG | X86_CR0_PE), %eax
 	mov %eax, %cr0
@@ -197,5 +238,67 @@ SYM_DATA_START_LOCAL(early_stack)
 	.fill BOOT_STACK_SIZE, 1, 0
 SYM_DATA_END_LABEL(early_stack, SYM_L_LOCAL, early_stack_end)
 
+#ifdef CONFIG_X86_64
+/*
+ * Xen PVH needs a set of identity mapped and kernel high mapping
+ * page tables.  pvh_start_xen starts running on the identity mapped
+ * page tables, but xen_prepare_pvh calls into the high mapping.
+ * These page tables need to be relocatable and are only used until
+ * startup_64 transitions to init_top_pgt.
+ */
+SYM_DATA_START_PAGE_ALIGNED(pvh_init_top_pgt)
+	.quad   pvh_level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	.org    pvh_init_top_pgt + L4_PAGE_OFFSET*8, 0
+	.quad   pvh_level3_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	.org    pvh_init_top_pgt + L4_START_KERNEL*8, 0
+	/* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
+	.quad   pvh_level3_kernel_pgt - __START_KERNEL_map + _PAGE_TABLE_NOENC
+SYM_DATA_END(pvh_init_top_pgt)
+
+SYM_DATA_START_PAGE_ALIGNED(pvh_level3_ident_pgt)
+	.quad	pvh_level2_ident_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	.fill	511, 8, 0
+SYM_DATA_END(pvh_level3_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(pvh_level2_ident_pgt)
+	/*
+	 * Since I easily can, map the first 1G.
+	 * Don't set NX because code runs from these pages.
+	 *
+	 * Note: This sets _PAGE_GLOBAL despite whether
+	 * the CPU supports it or it is enabled.  But,
+	 * the CPU should ignore the bit.
+	 */
+	PMDS(0, __PAGE_KERNEL_IDENT_LARGE_EXEC, PTRS_PER_PMD)
+SYM_DATA_END(pvh_level2_ident_pgt)
+SYM_DATA_START_PAGE_ALIGNED(pvh_level3_kernel_pgt)
+	.fill	L3_START_KERNEL,8,0
+	/* (2^48-(2*1024*1024*1024)-((2^39)*511))/(2^30) = 510 */
+	.quad	pvh_level2_kernel_pgt - __START_KERNEL_map + _KERNPG_TABLE_NOENC
+	.quad	0 /* no fixmap */
+SYM_DATA_END(pvh_level3_kernel_pgt)
+
+SYM_DATA_START_PAGE_ALIGNED(pvh_level2_kernel_pgt)
+	/*
+	 * Kernel high mapping.
+	 *
+	 * The kernel code+data+bss must be located below KERNEL_IMAGE_SIZE in
+	 * virtual address space, which is 1 GiB if RANDOMIZE_BASE is enabled,
+	 * 512 MiB otherwise.
+	 *
+	 * (NOTE: after that starts the module area, see MODULES_VADDR.)
+	 *
+	 * This table is eventually used by the kernel during normal runtime.
+	 * Care must be taken to clear out undesired bits later, like _PAGE_RW
+	 * or _PAGE_GLOBAL in some cases.
+	 */
+	PMDS(0, __PAGE_KERNEL_LARGE_EXEC, KERNEL_IMAGE_SIZE/PMD_SIZE)
+SYM_DATA_END(pvh_level2_kernel_pgt)
+
+	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_RELOC,
+		     .long CONFIG_PHYSICAL_ALIGN;
+		     .long LOAD_PHYSICAL_ADDR;
+		     .long KERNEL_IMAGE_SIZE - 1)
+#endif
+
 	ELFNOTE(Xen, XEN_ELFNOTE_PHYS32_ENTRY,
 	             _ASM_PTR (pvh_start_xen - __START_KERNEL_map))
-- 
2.44.0


