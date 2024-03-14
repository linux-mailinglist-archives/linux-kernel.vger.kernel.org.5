Return-Path: <linux-kernel+bounces-103170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D81C987BBDD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524DB1F2168F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B9F6EB64;
	Thu, 14 Mar 2024 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CVGkalM/"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2856CDB5;
	Thu, 14 Mar 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710415491; cv=fail; b=XyLaSu7s5GO17UW8sgJEHErrDMW9+mHqFsOG7ZOQZDXJjljz2nOolg6uOz06hDbQu19GrYi7J2Y5fJkVVmpW/RZOhQgmqLKlA1xK6qFLA0O1eqTW1Fcn7QyRmNf8RBGcGEpNsuIe8z76XDOITOtmoWu9kX/+7Slrst914SG6DQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710415491; c=relaxed/simple;
	bh=DMAFmfGSxwCrrCHvH7TevwU4uy6OFeeLUqKDDb2Cp24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/htwcYxduY7IFNaelhQwwrZgu2yoObjGaXpAs42GD4JwsdcUFdeD20FhxYf2iLEuYOHW9P+cEcndzvXRrHWHnXz6Kg6AwrbIC52jMGSS9yM0SakY0Gn0JEZ9RiXykeDpMf5iEr3jRCHJbKRAGQHtMe3S9uXv7AmzJ6q13aNkro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CVGkalM/; arc=fail smtp.client-ip=40.107.223.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPCEiUgCH19ZH0kgG19h8PEaQH5mjlVg5CmETCXxomBst5xjbZafL0PI/pJai57IR4h47jPf4r1OlZ+b0RHV5IXuceVgTtC1x86EqOVL1HkIMTZcSMUC/+D1WEdGvWd21VfaRCrOYlucg0eR9tRgNnMnykva6SCkAoTw5s2D7vYmaykpETIRLJw6SMka1Aghgn+CS0/AxINu6TkF4F3y1QYritQm7u1hfThmcL0oCVxV0zR/XcFKtAmgCY0tYUM35xFJStJQnNc0lRqFxAp6f1xFsn4zJ1Q7m1hNPYiQx36C7sC+TsnHRi6rYCTo9evAq4fCDxL4pEAv2MhJQQGbMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nizar6aJ0ncSrbLL8KjFmbwHIBpPM30Rln6KLSRWYqE=;
 b=LvSXVoeS/WjpNRfQKNGNCJjoPZaZGHfdzcNm5QrNtd5j3FOgNxrOlZ7p0ol9m7uAA7Rxn/SqH/J00LuVsCGb2O9cUgcxk3nQF4mdlIbQ9EsjsVtTVRSVeCifF6NfkSFe19kNgp2F/yUl5/Og/uZ0wBLV9RUWMY2/sb1DnyWDTh8mQEjzKMvFVRowFKhCLDy0js5qfKBcKNIEmZfZH3bUNPyv3N3yO9S/W9nE4P+x9En0+jYwFLIGtcnCF99XJqMPfwd8r1Si/txpB7vrV080WdWcKABGZFTFZz/nmnUm3nc9iAWn/0zWuuOgAPKNaqZJiB45NSDU13JnScOu7kF0RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nizar6aJ0ncSrbLL8KjFmbwHIBpPM30Rln6KLSRWYqE=;
 b=CVGkalM/DotbjZH4HpXWqZ7iI7XwaOqr7ZXS96rOeak+dCTrIswjNY0Rh40Ly9yU3qXulPlSDjiv/TbbeW54zTfSyYFzJslR7Fx27vcPwX64iuYxwt/BGMxytWegPh0QazeKdTH1WsJyKlyCP2AIJPiPDT/z3A7MUXsmhK+7F2A=
Received: from CH2PR05CA0005.namprd05.prod.outlook.com (2603:10b6:610::18) by
 CY5PR12MB6454.namprd12.prod.outlook.com (2603:10b6:930:36::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Thu, 14 Mar 2024 11:24:47 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::13) by CH2PR05CA0005.outlook.office365.com
 (2603:10b6:610::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Thu, 14 Mar 2024 11:24:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Thu, 14 Mar 2024 11:24:46 +0000
Received: from llvm-slrz6.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Mar
 2024 06:24:41 -0500
From: Vignesh Balasubramanian <vigbalas@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-toolchains@vger.kernel.org>
CC: <mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<ebiederm@xmission.com>, <keescook@chromium.org>, <x86@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>, <bpetkov@amd.com>,
	<jinisusan.george@amd.com>, <matz@suse.de>, <binutils@sourceware.org>,
	<jhb@FreeBSD.org>, <felix.willgerodt@intel.com>, Vignesh Balasubramanian
	<vigbalas@amd.com>
Subject: [PATCH 1/1] x86/elf: Add a new .note section containing Xfeatures information to x86 core files
Date: Thu, 14 Mar 2024 16:53:28 +0530
Message-ID: <20240314112359.50713-2-vigbalas@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240314112359.50713-1-vigbalas@amd.com>
References: <20240314112359.50713-1-vigbalas@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CY5PR12MB6454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d136a88-2462-4d85-4858-08dc44195ad3
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ODl3pwfLWd2aivzXRW+xFyX82vjQottQ5Y9I/ekMzBdfDdiB3MYHNnOEeorApRmIKv3dNdHFGcgr9x9/AGuKAS7w+y3siGIToEAqJ7tzI70v25/DBATvnqh/8Loj+2ydmMmcfHQabsZ9vhP6r6eOqCToFspYX5pHiXq/aKvWFBxu1h2Ta3BB/4cj0Ey1r/xwDheNwD+lCeWN7V72hib6y2npN9/ly1gjqw9QviMQr2RtF9tqX4W7Yrx4lkbomo3CyrNLldYCRVqA1aYcF8YOYRKONm6uf8x+OfBwaCbNgahsjJm4xG2UPuuH4cMzb6SafktcFaSrkxtxOgwVpib0tHSEslJ8VQvM+SpFsYt33kOwcJ83YI6ydM1GOm0qXctpCbfkRp9zV/MvV+nNYGwoSA9PZJYfUZqlHha49xPfRyjTDhX4Z6hQ+sAFi8gho5cYcx8DhO7DnEiIWQu/8Km08y1EUlweypYP9xngcHSz7Oi8D5cxZCijJSTqA32dqkisyppOTdL1XG66KdJz8TEXSd6b5995HKx51Uwshhr7ziQsM9P/9kU8IaM1IPgSEocysnRDNu0hU+pntJulbXsc5mRWxi4oxL8HBgHqVBpvfgxzZIXwU093tUa4ophYJo3cSKBWdWG29LMuGizZuhk4+jXFdS8Zm1uhJSlUvIPFbD3CeTmzwfaA9ph+O3zpHkh46QkVRdm9gODzIjOjclSXNZt11JCKIqot2MiFyKYQd9uAwRy/fWMc0ZtLqcxmmA6C
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 11:24:46.7497
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d136a88-2462-4d85-4858-08dc44195ad3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6454

Add a new .note section containing type, size, offset and flags of
every xfeature that is present.

This information will be used by the debuggers to understand the XSAVE
layout of the machine where the core file is dumped, and to read XSAVE
registers, especially during cross-platform debugging.

Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
---
 arch/Kconfig                   |   9 +++
 arch/powerpc/Kconfig           |   1 +
 arch/powerpc/include/asm/elf.h |   2 -
 arch/x86/Kconfig               |   1 +
 arch/x86/include/asm/elf.h     |   7 +++
 arch/x86/kernel/fpu/xstate.c   | 101 +++++++++++++++++++++++++++++++++
 include/linux/elf.h            |   2 +-
 include/uapi/linux/elf.h       |   1 +
 8 files changed, 121 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index fd18b7db2c77..3bd8a0b2bba1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -502,6 +502,15 @@ config MMU_LAZY_TLB_SHOOTDOWN
 config ARCH_HAVE_NMI_SAFE_CMPXCHG
 	bool
 
+config ARCH_HAVE_EXTRA_ELF_NOTES
+	bool
+	help
+	  An architecture should select this in order to enable adding an
+	  arch-specific ELF note section to core files. It must provide two
+	  functions: elf_coredump_extra_notes_size() and
+	  elf_coredump_extra_notes_write() which are invoked by the ELF core
+	  dumper.
+
 config ARCH_HAS_NMI_SAFE_THIS_CPU_OPS
 	bool
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a91cb070ca4a..3b31bd7490e2 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -156,6 +156,7 @@ config PPC
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if PPC_RADIX_MMU
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index 79f1c480b5eb..bb4b94444d3e 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -127,8 +127,6 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 /* Notes used in ET_CORE. Note name is "SPU/<fd>/<filename>". */
 #define NT_SPU		1
 
-#define ARCH_HAVE_EXTRA_ELF_NOTES
-
 #endif /* CONFIG_SPU_BASE */
 
 #ifdef CONFIG_PPC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 78050d5d7fac..35e8d1201099 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -104,6 +104,7 @@ config X86
 	select ARCH_HAS_DEBUG_WX
 	select ARCH_HAS_ZONE_DMA_SET if EXPERT
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
+	select ARCH_HAVE_EXTRA_ELF_NOTES
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE
 	select ARCH_MIGHT_HAVE_ACPI_PDC		if ACPI
 	select ARCH_MIGHT_HAVE_PC_PARPORT
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 1fb83d47711f..1b9f0b4bf6bc 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -13,6 +13,13 @@
 #include <asm/auxvec.h>
 #include <asm/fsgsbase.h>
 
+struct xfeat_component {
+	u32 xfeat_type;
+	u32 xfeat_sz;
+	u32 xfeat_off;
+	u32 xfeat_flags;
+} __packed;
+
 typedef unsigned long elf_greg_t;
 
 #define ELF_NGREG (sizeof(struct user_regs_struct) / sizeof(elf_greg_t))
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 117e74c44e75..6e5ea483ec1d 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -13,6 +13,7 @@
 #include <linux/seq_file.h>
 #include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
+#include <linux/coredump.h>
 
 #include <asm/fpu/api.h>
 #include <asm/fpu/regset.h>
@@ -1836,3 +1837,103 @@ int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
 	return 0;
 }
 #endif /* CONFIG_PROC_PID_ARCH_STATUS */
+
+/*
+ * Dump type, size, offset and flag values for every xfeature that is present.
+ */
+static int dump_xsave_layout_desc(struct coredump_params *cprm)
+{
+
+	struct xfeat_component xc;
+	int num_records = 0;
+	int i;
+
+	/* XFEATURE_FPU and XFEATURE_SSE, both are fixed legacy states. */
+	for (i = 0; i < FIRST_EXTENDED_XFEATURE; i++) {
+		xc.xfeat_type = i;
+		xc.xfeat_sz = xstate_sizes[i];
+		xc.xfeat_off = xstate_offsets[i];
+		xc.xfeat_flags = xstate_flags[i];
+
+		if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
+			return 0;
+		num_records++;
+	}
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features) {
+		xc.xfeat_type = i;
+		xc.xfeat_sz = xstate_sizes[i];
+		xc.xfeat_off = xstate_offsets[i];
+		xc.xfeat_flags = xstate_flags[i];
+
+		if (!dump_emit(cprm, &xc, sizeof(struct xfeat_component)))
+			return 0;
+		num_records++;
+	}
+
+	return num_records;
+}
+
+static int get_xsave_desc_size(void)
+{
+	/* XFEATURE_FP and XFEATURE_SSE, both are fixed legacy states */
+	int xfeatures_count = 2;
+	int i;
+
+	for_each_extended_xfeature(i, fpu_user_cfg.max_features)
+		xfeatures_count++;
+
+	return xfeatures_count * (sizeof(struct xfeat_component));
+}
+
+int elf_coredump_extra_notes_write(struct coredump_params *cprm)
+{
+	const char *owner_name = "LINUX";
+	int num_records = 0;
+	struct elf_note en;
+
+	en.n_namesz = strlen(owner_name) + 1;
+	en.n_descsz = get_xsave_desc_size();
+	en.n_type = NT_X86_XSAVE_LAYOUT;
+
+	if (!dump_emit(cprm, &en, sizeof(en)))
+		return 1;
+	if (!dump_emit(cprm, owner_name, en.n_namesz))
+		return 1;
+	if (!dump_align(cprm, 4))
+		return 1;
+
+	num_records = dump_xsave_layout_desc(cprm);
+	if (!num_records) {
+		pr_warn("Error adding XSTATE layout ELF note. XSTATE buffer in the core file will be unparseable.");
+		return 1;
+	}
+
+	/* Total size should be equal to the number of records */
+	if ((sizeof(struct xfeat_component) * num_records) != en.n_descsz) {
+		pr_warn("Error adding XSTATE layout ELF note. The size of the .note section does not match with the total size of the records.");
+		return 1;
+	}
+
+	if (!dump_align(cprm, 4))
+		return 1;
+
+	return 0;
+}
+
+/*
+ * Return the size of new note.
+ */
+int elf_coredump_extra_notes_size(void)
+{
+	const char *fullname = "LINUX";
+	int size = 0;
+
+	/* NOTE Header */
+	size += sizeof(struct elf_note);
+	/* name + align */
+	size += roundup(strlen(fullname) + 1, 4);
+	size += get_xsave_desc_size();
+
+	return size;
+}
diff --git a/include/linux/elf.h b/include/linux/elf.h
index c9a46c4e183b..5c402788da19 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -65,7 +65,7 @@ extern Elf64_Dyn _DYNAMIC [];
 struct file;
 struct coredump_params;
 
-#ifndef ARCH_HAVE_EXTRA_ELF_NOTES
+#ifndef CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES
 static inline int elf_coredump_extra_notes_size(void) { return 0; }
 static inline int elf_coredump_extra_notes_write(struct coredump_params *cprm) { return 0; }
 #else
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 9417309b7230..3325488cb39b 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -411,6 +411,7 @@ typedef struct elf64_shdr {
 #define NT_X86_XSTATE	0x202		/* x86 extended state using xsave */
 /* Old binutils treats 0x203 as a CET state */
 #define NT_X86_SHSTK	0x204		/* x86 SHSTK state */
+#define NT_X86_XSAVE_LAYOUT	0x205	/* XSAVE layout description */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
 #define NT_S390_TIMER	0x301		/* s390 timer register */
 #define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
-- 
2.43.0


