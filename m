Return-Path: <linux-kernel+bounces-142030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDC8A266F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5025F1C2240E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A1C3F8E4;
	Fri, 12 Apr 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EYE2nZQW"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2071.outbound.protection.outlook.com [40.107.100.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43A93D56D;
	Fri, 12 Apr 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902974; cv=fail; b=Z9+VehKvPnVaPMwGhThr1hpfA6EfYnnsAUCwn9DChuUTx5ANQcujuebIaY/eT1JwLexybAcjXtbz+axriEyxQvT5vbOVnpTBNPKtMODn+I+T+mHa7I8KWWdiZHecQhADFopr5d990OAQrqYlZfCqVRjL9GtfJJQdRUABzRTgXYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902974; c=relaxed/simple;
	bh=3gs8Dm02Oj4iVkp6cJP6+vcEnEXoYvzGoyoKZCNGUCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A6nQQu0QfpYNJUeBllgMNe5FGfTp1LFYnvwXS4aqs4rN4FjN0kWEAp+nai1dKMtSIPAqG05/rqPdXb59V4Z0bOxDIs0GoDvhWmkBBtfCdoKIfg4awV/S+C/krAm4CDtRdWYAwOEZW1d8vAd7C68yBQMMPby9B1z7eTHkx6iqli8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EYE2nZQW; arc=fail smtp.client-ip=40.107.100.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op3Od9YWkm5JNzmFik7bJsXj+RwMAqqRClX1TLUXUQPQWsqjdCh2v1UM2bkCKqG7MbpKMjDk1+VlzB2RZtws/sy2eaTZcG47WGPbPMvHp3PjJXam/FzWHfaqw58jp8LlsUKISIx1661CcUlPPwn/8lUCAnmIjHqDJj4qSrRjDlTa3aHTmMjxCo2jRu91Lin4qP99px7uFWH3roRHCfsiVN5R44Y4lRPpz1S0KJLrpGk8NR7jUHa1SxDch8cp3MjOwoef+pgeDVe8/bShNVsXgZoGvtuq1ZJNxsm5m+PQi979435Y2BVcTTn1ujyru1APVAy30rb8L4wy401grPacNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoMfjj/r3RpV87uh0Lgpl5r4ZcSpAimGOOXIkEgJpx0=;
 b=mcua+7+dR3vltNremYLqjNmOeoZC8smSH8ZeHqttMSPd7BVPcUcZu9dKD92jKNN0fBOa6livMXhEJAXJM+VwQq1LAmdQ0wn7dG9/+Mui+H/vuo5LdcVLhQiwYEufWkUm+sKNNMsjAOnmEIt4pTjrzF47fHf8Ct7zn9Ms7t8DiYqsmBqiClf6UwQ1ovFiL3muOZ9ozHMpdas0U24pllaPdWg+xKOZHLGF3BhTe/l2B+3z3PwwtrWnIclg977FAdjjSU/BPxXxD2kystm6cW94tUq5p77DYc/ku8RUr8tJKhMJqjlXSNeCSK+xRYnt7dM7E72yAax/e5gNqg2CM6CTxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoMfjj/r3RpV87uh0Lgpl5r4ZcSpAimGOOXIkEgJpx0=;
 b=EYE2nZQWPxCt0kfz+PC2IDamD2wheYAkAPFCfA6LQuoIc3dPg9KlhIaDweY+bBBuLTKwWtf9Vtcqs6Ey01cq5Su3v8efkvtsIzqaNWMK7v54NjvVMwVUMnEgSKWpfnVYZnDesCmP2+iPDJGiMQp8doMoDf2CAD1sy1G5iXT57+Q=
Received: from CH2PR20CA0020.namprd20.prod.outlook.com (2603:10b6:610:58::30)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 06:22:50 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::80) by CH2PR20CA0020.outlook.office365.com
 (2603:10b6:610:58::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Fri, 12 Apr 2024 06:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 12 Apr 2024 06:22:49 +0000
Received: from amd-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Apr 2024 01:22:44 -0500
From: Vignesh Balasubramanian <vigbalas@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-toolchains@vger.kernel.org>
CC: <mpe@ellerman.id.au>, <npiggin@gmail.com>, <christophe.leroy@csgroup.eu>,
	<aneesh.kumar@kernel.org>, <naveen.n.rao@linux.ibm.com>,
	<ebiederm@xmission.com>, <keescook@chromium.org>, <x86@kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mm@kvack.org>, <bpetkov@amd.com>,
	<jinisusan.george@amd.com>, <matz@suse.de>, <binutils@sourceware.org>,
	<jhb@FreeBSD.org>, <felix.willgerodt@intel.com>, Vignesh Balasubramanian
	<vigbalas@amd.com>
Subject: [PATCH 1/1] Replace macro "ARCH_HAVE_EXTRA_ELF_NOTES" with kconfig
Date: Fri, 12 Apr 2024 11:51:39 +0530
Message-ID: <20240412062138.1132841-2-vigbalas@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412062138.1132841-1-vigbalas@amd.com>
References: <20240412062138.1132841-1-vigbalas@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: a39d16ba-3462-4003-b0ab-08dc5ab8fa3b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5bNdaFtCdTin7BgnTBMtNnmTPhjPstxzKGBUK5D09lScaEGXpAHwApr8Z9ETctKYOmvokcMa6/7ncHjbh1pg3bS5O5tNBtyHoL4YR6UQdWyJeTKbxTJtte6GZHdiuoBPp/0EBNDw8vH6CLM1uAPrm8dlIMG2ULRQzCoK82MjSh01/g9mqTEZDQnh6KZ81OPEq72yP8U2q0JX2xJP9VT1J0OSOl/UG+dq66oYauxz6yl7AMqUnNgVlGkBgenFeIao20YMxzKc0dKSuWWjRapQKZ7scSR9nnwuUBUsEbAFmZImLeX0Ny0BB/2JgQFkWlxBGI7JmiKldDFT7V8beuyKiudU/YKzyN6KGqU0RjztvfGBY0iYYvRmBoyVF+raXLKMQtpcBgGL/y0sDh0+oqLB6Vc7Mm02Yum7kqNWHtihVOOMOEj3A8pa1X7C0mjDOYMoTIQaU5n+7c5R5ZjETKXq+ORSqFQWRutXh/ajRgqFtKCfgTY9t+PTp8qlf5MBfnrwuqnOveQSdp8EVKVetV0KNIIUpcxOIZd4Wl0YpzsDxZgJPdvKM8mWwMRPOjO8q62uudSh0z+2pFDsUVeFS5KVosFnJn8bVVXeWt8Id6UctCMhUK0/pxpxumH72oRkIh0ceQwrJeU3nhI9YM5fPb8r1F8EaqcALkLlxeTgLyveqbbCxIycoJmZZEfqMzlVbVmD9RQXzd11HYAVqKnZ4adX1nsPRvkxkY3fUZfElzKA8wP/DzTdTJHTqivsxz+pNE11
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 06:22:49.7684
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a39d16ba-3462-4003-b0ab-08dc5ab8fa3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916

"ARCH_HAVE_EXTRA_ELF_NOTES" enables an extra note section in the
core dump. Kconfig variable is preferred over ARCH_HAVE_* macro.

Co-developed-by: Jini Susan George <jinisusan.george@amd.com>
Signed-off-by: Jini Susan George <jinisusan.george@amd.com>
Signed-off-by: Vignesh Balasubramanian <vigbalas@amd.com>
---
 arch/Kconfig                   | 9 +++++++++
 arch/powerpc/Kconfig           | 1 +
 arch/powerpc/include/asm/elf.h | 2 --
 include/linux/elf.h            | 2 +-
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 9f066785bb71..143f021c8a76 100644
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
index 1c4be3373686..c45fa9d7fb76 100644
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
-- 
2.34.1


