Return-Path: <linux-kernel+bounces-116648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 605B188A1DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8317B1C385F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517C4133425;
	Mon, 25 Mar 2024 10:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nYwJnJ+a"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C4B8565C;
	Mon, 25 Mar 2024 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711351960; cv=fail; b=ExoMqtiB49oBBhyh2j4QscKqg5AvYHbOXgGzeWMQC6YzW3uyFkSAerPFAHr+i4YKTvDnZVOI0NPTm6DemDzzNXgEwsEZ/J0Mtg6JC3Rwie5CEzSTWpyjlti44Ihdj87GoIgrrJbE0zLSt/8DlVjdyOQ3y1V6iRzNU4AA2QRmeMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711351960; c=relaxed/simple;
	bh=J5yBxDbWBJrFPw5TWJNx1osLechcJVFA47QKV9bhGb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PKzzDJA5flM8AsBC2c/fksj2EUmtJsXTVYZVd0h3M2Sbm9gDZvS3B/wj7HXKuk4yOuDBBwvvEDDTVYeEjt371zHsnVTv28/BRvX4eYJm3QGqTEXGzd5kEp/VK4UA9QymTLioB08c1rBOSEcb3jChKfL3yiA9au7rcBQlR1kJ2fk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nYwJnJ+a; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DURxK23QTbLPMdJikcj0MNcTTftkXuwRBZQpCuS1pLYBCloLsx8oIubwR9CB8piS9grGrE07GHTBlOTjgMz6OX7zH62IVOYwzdxwQuTZ3enu1AVKOqPRt0CqMIxwwaSF2D1h/OeEL9BfyL2XyWIx/GSt2T399N1HCrlh/KJaiJEYTX/SJovijVkhiUNqpODSS2GTx44lhp2r08Vq2U/q39R1b/JCiS1OvY5d5zMWuB3BwCkhlLMEB/V08/rFx8P3B1angQFBWoleSufnwmVSmPxL3ekUAIY0H+CQROYC26Foj5euh4stvt/87VHm6aaC6MbYiZ2DLLxnzd6xxrSknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHaCbHytYUyfFhfqC0jEIjuSyQ5FMbgQsvEQoarNp5A=;
 b=A0P9j9U+Ug/Qw3cOC0QdgBWvliN5iVFfCkdERiV+OWisvy+HcURyuPdVP86fikSNiW8henMH4QaGuFXJdNTrGx957+Kmsbb4FRK6rPChiw1tTIO08xYDn4sG/zygRCfkQiCLddNn3ZCo18+Mk48pm3vfmvBF0HPHLMMcgzzUVIiT6+0k0T/e7Xbzrlz/ubpG/OuoT/PsZfSh37HZtEfU8nHZ2CfaP86DN8Qm7PH9dLAL8E8QKOvTar2R0or9MMSqEmBtxwtLIxJwa/LdTMApmSFJP90jppeZMPlveYy/j4y3J5X0Qrb3zDEjIkWTHu8qZ+Cv9IrrO/vOQl5nH7BK6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHaCbHytYUyfFhfqC0jEIjuSyQ5FMbgQsvEQoarNp5A=;
 b=nYwJnJ+a0W34SmExUBJa5kE/4o4PkA6lpcMvobLbqpgF7oG88PAMKdIE3Ueq2J4On7gCS/YhpKmc1zMzUTHI0sT0AhhmHIcN8GuEJgUGuKB5tIgp4uBVFmL+H4AdCEhrevDtu6tyZmTxfn65ERHnsgTV70F35VzgN03SzXQkcnw=
Received: from BN0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:408:ea::12)
 by DS0PR12MB6462.namprd12.prod.outlook.com (2603:10b6:8:c6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 07:32:35 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:ea:cafe::39) by BN0PR04CA0067.outlook.office365.com
 (2603:10b6:408:ea::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 25 Mar 2024 07:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.0 via Frontend Transport; Mon, 25 Mar 2024 07:32:35 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 25 Mar
 2024 02:32:29 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v5 2/2] perf/x86/amd/lbr: Use freeze based on availability
Date: Mon, 25 Mar 2024 13:01:45 +0530
Message-ID: <69a453c97cfd11c6f2584b19f937fe6df741510f.1711091584.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1711091584.git.sandipan.das@amd.com>
References: <cover.1711091584.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS0PR12MB6462:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b4132fd-c58d-4779-0d28-08dc4c9dbd9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YY21UAIrvHRLlRMW8SxE92ZupU4ECLKVrHb35142nUqK+5Tkne8aKhXV0ZFcxsgq5i0yhBaIc1M9i2RxGoCXeSEfmbT/MqLNXUQJ/DLKWAcloL97FzE135fazDZBO5khzEueq+sHwILm4wl236SUgcZ800UJyRSHJsF8ugkGWtLrpIR184bNkL+eHRRty2d4KMsbXFtLWBAbG3iaGigm0QFXeCroEjeJ8KY2WPgo4yWJKMF79Rjjc91BpbZECm6gdz9srAd8medL9K9Saw1Zxfobny6iSJ2p4dK01ZBDXlcDnx5AXtjmerCoFCR7b5vc1CFoPLqNpbxVRrB9C7DOaoMTlk3DB6+5BjZYLLzZ1lIK0WhwZmr85iQsZzfYfDSF5OT/U0mecy0qk5ZepNyfU2L4ZGyBQ+lCo93TrOBrpV2UdBR7S0p1slZmKp3yKXNML5Q7MCJnCRLkjbCHv47ETqeBqdJ5O1ZfWx98nvnrZTwss2wkcLpL6oUKpZnQ+nwjSS+6oc6TD13Xn5doXoDHvgRlnKT4YSVkGYLQWsNFpd/tLEpNG27hwebPbgBOY6BnVdhpZOPctzv9z5+ouDcuA91R0m68pDB252NfXOixC4PweNgCxbqpSfkxwJW6rHRPkru78ch7bZsaxH7SbH3PEsSDHFg4C5PH9/s26bJGOjWYBmMxaeObhNzdkE26yDvqPy2TTtHZKwdx5IFdsuEJfqZPUdTKtoN/ofqcoJTxsdU=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 07:32:35.4061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b4132fd-c58d-4779-0d28-08dc4c9dbd9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6462

Currently, it is assumed that LBR Freeze is supported on all processors
when X86_FEATURE_AMD_LBR_V2 is available i.e. CPUID leaf 0x80000022[EAX]
bit 1 is set. This is incorrect as the availability of the feature is
additionally dependent on CPUID leaf 0x80000022[EAX] bit 2 being set.
This may not be the case for all Zen 4 processors. Define a new feature
bit for LBR and PMC freeze and set the freeze enable bit (FLBRI) in
DebugCtl (MSR 0x1d9) conditionally.

It should still be possible to use LBR without freeze for profile-guided
optimization of user programs by using an user-only branch filter during
profiling. When the user-only filter is enabled, branches are no longer
recorded after the transition to CPL 0 upon PMI arrival. When branch
entries are read in the PMI handler, the branch stack does not change.

E.g.

  $ perf record -j any,u -e ex_ret_brn_tkn ./workload

Since the feature bit is visible under flags in /proc/cpuinfo, it can be
used to determine the feasibility of use-cases which require LBR Freeze
to be supported by the hardware such as profile-guided optimization of
kernels.

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/core.c         |  4 ++--
 arch/x86/events/amd/lbr.c          | 16 ++++++++++------
 arch/x86/include/asm/cpufeatures.h |  8 ++++++++
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index aec16e581f5b..5692e827afef 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -904,8 +904,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	if (!status)
 		goto done;
 
-	/* Read branch records before unfreezing */
-	if (status & GLOBAL_STATUS_LBRS_FROZEN) {
+	/* Read branch records */
+	if (x86_pmu.lbr_nr) {
 		amd_pmu_lbr_read();
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
diff --git a/arch/x86/events/amd/lbr.c b/arch/x86/events/amd/lbr.c
index 4a1e600314d5..5149830c7c4f 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -402,10 +402,12 @@ void amd_pmu_lbr_enable_all(void)
 		wrmsrl(MSR_AMD64_LBR_SELECT, lbr_select);
 	}
 
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl | DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg | DBG_EXTN_CFG_LBRV2EN);
 }
 
@@ -418,10 +420,12 @@ void amd_pmu_lbr_disable_all(void)
 		return;
 
 	rdmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg);
-	rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
-
 	wrmsrl(MSR_AMD_DBG_EXTN_CFG, dbg_extn_cfg & ~DBG_EXTN_CFG_LBRV2EN);
-	wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+
+	if (cpu_feature_enabled(X86_FEATURE_AMD_LBR_PMC_FREEZE)) {
+		rdmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl);
+		wrmsrl(MSR_IA32_DEBUGCTLMSR, dbg_ctl & ~DEBUGCTLMSR_FREEZE_LBRS_ON_PMI);
+	}
 }
 
 __init int amd_pmu_lbr_init(void)
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 4d850a780f7e..a38f8f9ba657 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -459,6 +459,14 @@
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
 
+/*
+ * Extended auxiliary flags: Linux defined - for features scattered in various
+ * CPUID levels like 0x80000022, etc.
+ *
+ * Reuse free bits when adding new feature flags!
+ */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
+
 /*
  * BUG word(s)
  */
diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
index 0dad49a09b7a..a515328d9d7d 100644
--- a/arch/x86/kernel/cpu/scattered.c
+++ b/arch/x86/kernel/cpu/scattered.c
@@ -49,6 +49,7 @@ static const struct cpuid_bit cpuid_bits[] = {
 	{ X86_FEATURE_BMEC,		CPUID_EBX,  3, 0x80000020, 0 },
 	{ X86_FEATURE_PERFMON_V2,	CPUID_EAX,  0, 0x80000022, 0 },
 	{ X86_FEATURE_AMD_LBR_V2,	CPUID_EAX,  1, 0x80000022, 0 },
+	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
 	{ 0, 0, 0, 0, 0 }
 };
 
-- 
2.34.1


