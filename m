Return-Path: <linux-kernel+bounces-107215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E0287F95E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529901F21EF7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091FF54645;
	Tue, 19 Mar 2024 08:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5T3nOQY9"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2040.outbound.protection.outlook.com [40.107.94.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A52B5380D;
	Tue, 19 Mar 2024 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836334; cv=fail; b=TYLmA9Tb0SGZ5GvTflzTx/cFx5E+OhcQlgPu/GunCHu0+ncXkJbsDEQRfP9TBFXve616XTcQLVI4my8uJjNE4Y05GAXVj5pGgAESxDeuw4fb4mq5puDsCil83TqDrJ7PIV8wVef9jn+p4O+1r/2WCPptiT12IBYwW2i9Mq0j+nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836334; c=relaxed/simple;
	bh=lVsiaL2C9f2ZbsmLd/i/ZtCXIHi9g9110VouYwzZO+Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3eHhiuv5t2xkQr5cQl9dL6E1Wmg80P3WGbYLP0FdlYwgjHp95geK8p9eTbL99OCVzGO0Lh4zOn/WwF2OqicZmOB4tj3sTBOzCRlnSqat6gjjBs/EBkrCUTDgpfoH7kpKS7noaxvi+6jATO9PhJ4DNkiEG3y1UoUaDXTHOUmeqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5T3nOQY9; arc=fail smtp.client-ip=40.107.94.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DKuHEHJJkscvZ1jvtJdumkDwsLKQGBFgB8i+S2TaEYvLWYXllH2qKJxLWh0HYpGBeaTDrJ3uMT9gG1DDy5Pyl6U+r3vCKWVYgstfGjHS4bP9SgHn45RKBPniYsK0tXUGY5aCubFVEBCiMxaLAMaVxiADwnPiehUDoPm4JtrJVPVq+ZAbGQGSm2J/pvrcGMO0Hl88mhSAoE6oFaaw8tGnIKPUviBtABQITJDUAjs02v7BeRJRQ92EaVBlFIM0m1/flIWxeh3hLWTPUsXTUOYwKEISC1GpSPBHbjvunwE1PnzsGWk3ooa96y9urglQKtfUcoHgD2N8J1mbJDvMm0ox1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lW0r52/KoIogDCsFxLgJo5NGleM7ZDYXyprPiOzSiKU=;
 b=fzFYMAYBLhxUmnXYZxyJQV+b4L7KSwp/LclPjSFdCJSXgh+QZJzb1tWdxGTFOUTZpAY50aoigyBydxG4k5PIXl2MtjudOPpQUcU+OqotWrhU2nJP+XbaRaCuqcEqHhBIAqpI8J3u9v4Cm40vxP/imVklnDCHsWzpoGT7ZFHO6fCc1T9ohRHPvuSYcvTiiVJG+zrwy4se8aPKikrk0SAEhsrN6VEEVuwPf7OvpcDZt9vkcSWPZyCTt5mPsUKb+7JqXy76yJQIamglsOd8htdEDlGezY1rMyxFbWDQ7Z64qNZZ+ozIu4/mtJE8zW6lloV625rAJ9cQ+YmruuBz3j8Fxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lW0r52/KoIogDCsFxLgJo5NGleM7ZDYXyprPiOzSiKU=;
 b=5T3nOQY96FraBgZQEYVBV2JLyp2QM+gVXq0i7Pn9o/FAFEjHopC4bMAoIFbEiXZ04dhrWIuIz44K55V1I3JAMQN/Cm5VSQ0RZDW3mDo5Otd5Bwkj0j9iew5WzgA2Fv34nrJhwy70toIbEh5RmZkY9sLeSfUO/s3WWgUOJSjp4QE=
Received: from DS7PR05CA0083.namprd05.prod.outlook.com (2603:10b6:8:57::29) by
 LV3PR12MB9168.namprd12.prod.outlook.com (2603:10b6:408:19a::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Tue, 19 Mar 2024 08:18:50 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:8:57:cafe::b6) by DS7PR05CA0083.outlook.office365.com
 (2603:10b6:8:57::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.12 via Frontend
 Transport; Tue, 19 Mar 2024 08:18:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:18:49 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 03:18:43 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v4 1/2] x86/cpufeatures: Add dedicated feature word for CPUID leaf 0x80000022[EAX]
Date: Tue, 19 Mar 2024 13:48:16 +0530
Message-ID: <846eebace0aea3a600b81b06bddd0024e5ac1350.1710836172.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710836172.git.sandipan.das@amd.com>
References: <cover.1710836172.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|LV3PR12MB9168:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3786c4-df4d-4996-c77a-08dc47ed34c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fvEn5mrJQQKVohdMR9A41aowRC0iDJwkZ/w5ZPyFeyWVXq1qEReKqB/1D9vNFkbs+NMnQtfMCOFt8l2hd4f55D2BMzWBxMnR3uYvjESUb6y2HOy4hrpQL4rH1IW15/qtPClb3CsVGB2mVURg23dly7682hWJAIypSc1GKceupb0DSCyaAVUEb4eeZR1ZuDhQxD5QPBz+Ma9N0HG5hwAPc6zRAGJOqY8oeRGUgvPKCHYr7unm2X4NIMJ3oA5kCIFiuCnJQSit54HVnb/00J0Apx6pB4WBn5q3otKXpEIK31jFRajWuqGVcpDlip+Vqik44XwpBqQjbHh1KOYa4RHXntCUiyTLODAehXS/oQqu86Pv93aq871VQSQHWldnj6whcE73mA7Le1KRoRAGsHpEclpA1Pf37P62NKFVJ0JA3s5wr0/TAzrdhWvX+5R3sCAv6B8osuUNToNnEls0jNrYGuUA1heWx5jhXIWlmRTKdNtjtVUPTSsgXUCFWpsedBIDUDfq/TyqEtAlF+2jolhNV5kOviiuOJEYEwyO4ZT9RDqgUu+plTErG58JfZN+QT0PENpbGuYjNnlVyQfB5oYCjcDF+25zE0EbvQrJOqJ2JJsf8VbpU4Xqraeb7iF1v/7Zdp0UyzNEMKzTYoeTnLRj8065mnglrSW0yMxuvdid6TgvQ/a9KSgue0lelUJQg+yJe/VgEeubSJU9qgWVObRnP4YBdYnIWERusnLb9Yb0nVbj+8vjAT2Lb0GmoURPbVYW
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:18:49.7003
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3786c4-df4d-4996-c77a-08dc47ed34c7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9168

Move the existing scattered performance monitoring related feature bits
from CPUID leaf 0x80000022[EAX] into a dedicated word since additional
bits will be defined from the same leaf in the future. This includes
X86_FEATURE_PERFMON_V2 and X86_FEATURE_AMD_LBR_V2.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/include/asm/cpufeature.h        |  7 +++++--
 arch/x86/include/asm/cpufeatures.h       | 10 +++++++---
 arch/x86/include/asm/disabled-features.h |  3 ++-
 arch/x86/include/asm/required-features.h |  3 ++-
 arch/x86/kernel/cpu/common.c             |  3 +++
 arch/x86/kernel/cpu/scattered.c          |  2 --
 arch/x86/kvm/cpuid.c                     |  5 +----
 arch/x86/kvm/reverse_cpuid.h             |  1 -
 8 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/cpufeature.h b/arch/x86/include/asm/cpufeature.h
index a1273698fc43..68dd27d60748 100644
--- a/arch/x86/include/asm/cpufeature.h
+++ b/arch/x86/include/asm/cpufeature.h
@@ -33,6 +33,7 @@ enum cpuid_leafs
 	CPUID_7_EDX,
 	CPUID_8000_001F_EAX,
 	CPUID_8000_0021_EAX,
+	CPUID_8000_0022_EAX,
 };
 
 #define X86_CAP_FMT_NUM "%d:%d"
@@ -91,8 +92,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(REQUIRED_MASK, 21, feature_bit) ||	\
 	   REQUIRED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define DISABLED_MASK_BIT_SET(feature_bit)				\
 	 ( CHECK_BIT_IN_MASK_WORD(DISABLED_MASK,  0, feature_bit) ||	\
@@ -116,8 +118,9 @@ extern const char * const x86_bug_flags[NBUGINTS*32];
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 18, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 19, feature_bit) ||	\
 	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 20, feature_bit) ||	\
+	   CHECK_BIT_IN_MASK_WORD(DISABLED_MASK, 21, feature_bit) ||	\
 	   DISABLED_MASK_CHECK					  ||	\
-	   BUILD_BUG_ON_ZERO(NCAPINTS != 21))
+	   BUILD_BUG_ON_ZERO(NCAPINTS != 22))
 
 #define cpu_has(c, bit)							\
 	(__builtin_constant_p(bit) && REQUIRED_MASK_BIT_SET(bit) ? 1 :	\
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f0337f7bcf16..028f333dc530 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -13,7 +13,7 @@
 /*
  * Defines x86 CPU feature bits
  */
-#define NCAPINTS			21	   /* N 32-bit words worth of info */
+#define NCAPINTS			22	   /* N 32-bit words worth of info */
 #define NBUGINTS			2	   /* N 32-bit bug flags */
 
 /*
@@ -94,7 +94,7 @@
 #define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
+/* FREE!				( 3*32+17) */
 #define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
@@ -209,7 +209,7 @@
 #define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
 #define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
 #define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
+/* FREE!				( 7*32+20) */
 #define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
 #define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
 #define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
@@ -459,6 +459,10 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
+#define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
+#define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index da4054fbf533..c492bdc97b05 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -155,6 +155,7 @@
 #define DISABLED_MASK18	(DISABLE_IBT)
 #define DISABLED_MASK19	(DISABLE_SEV_SNP)
 #define DISABLED_MASK20	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define DISABLED_MASK21	0
+#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
index 7ba1726b71c7..e9187ddd3d1f 100644
--- a/arch/x86/include/asm/required-features.h
+++ b/arch/x86/include/asm/required-features.h
@@ -99,6 +99,7 @@
 #define REQUIRED_MASK18	0
 #define REQUIRED_MASK19	0
 #define REQUIRED_MASK20	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 21)
+#define REQUIRED_MASK21	0
+#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
 
 #endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ba8cf5e9ce56..771e32a517f5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1039,6 +1039,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 	if (c->extended_cpuid_level >= 0x80000021)
 		c->x86_capability[CPUID_8000_0021_EAX] = cpuid_eax(0x80000021);
 
+	if (c->extended_cpuid_level >= 0x80000022)
+		c->x86_capability[CPUID_8000_0022_EAX] = cpuid_eax(0x80000022);
+
 	init_scattered_cpuid_features(c);
 	init_speculation_control(c);
 
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..b5b1ce0bd493 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -47,8 +47,6 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_MBA,		CPUID_EBX,  6, 0x80000008, 0 },
 	{ X86_FEATURE_SMBA,		CPUID_EBX,  2, 0x80000020, 0 },
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
-	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
-	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index adba49afb5fe..f9bcbb0626bd 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -773,10 +773,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SBPB);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_IBPB_BRTYPE);
 	kvm_cpu_cap_check_and_set(X86_FEATURE_SRSO_NO);
-
-	kvm_cpu_cap_init_kvm_defined(CPUID_8000_0022_EAX,
-		F(PERFMON_V2)
-	);
+	kvm_cpu_cap_check_and_set(X86_FEATURE_PERFMON_V2);
 
 	/*
 	 * Synthesize "LFENCE is serializing" into the AMD-defined entry in
diff --git a/arch/x86/kvm/reverse_cpuid.h b/arch/x86/kvm/reverse_cpuid.h
index aadefcaa9561..c69d05cedf42 100644
--- a/arch/x86/kvm/reverse_cpuid.h
+++ b/arch/x86/kvm/reverse_cpuid.h
@@ -15,7 +15,6 @@ enum kvm_only_cpuid_leafs {
 	CPUID_12_EAX	 = NCAPINTS,
 	CPUID_7_1_EDX,
 	CPUID_8000_0007_EDX,
-	CPUID_8000_0022_EAX,
 	CPUID_7_2_EDX,
 	NR_KVM_CPU_CAPS,
 
-- 
2.34.1


