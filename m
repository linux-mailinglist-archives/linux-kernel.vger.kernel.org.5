Return-Path: <linux-kernel+bounces-2739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEA5816130
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41C30B23BD4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4EE47A44;
	Sun, 17 Dec 2023 17:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nspm5gwX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D6547F47;
	Sun, 17 Dec 2023 17:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I49QaEYsvo0dskWCzTdYZiyVh2Sy3SqZ13Ta7SYqmG6XSwiMUgaV5WEbIABrEcR61PaXLW4cnP3butX1Fq9a8IugYUx92h2tBcBjJmdBiCjlajTaIvzGt1er2Q2S/c0htl/DbIFmVfPqKUGj/r0vcPOwR8aOLSsb6onqjeq+syFNSYIiIYSc4hVWxPF4BBVeo7aUgNrZ2WvlWAj/kjXstvpn4vG6FR7bJKhxWhJZ+2Q0YPO5T/aU2XmT7O5XKZhji7bibB432hycCUqjzWYZmw4SvGFWJnGO1LfHPbzCnqdV+phQeuc41Igm9ITtLfy9d6Wa+KOFGK5zELn+3fOJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tV4uGHwqLjarhGvfZYQ9bTWmlI9hqRdeI+LjEqCl/Iw=;
 b=D2g0Xa8SdKhnBVPwt7F6G22oV7fBvdQ/1OP51uTOkbSSkcTuqzx4r+YEjdadpiE5eH2LTtlIC5+y4fb2IXe5X2to56M0eU6FvPJXe+3pmrDHLSn96rdeInnJDYc6uSaD9m/VdOfA7vGcI8p1KnFzMKPAS8L7OhEI7pFvt3cM3BBEq30lY7eM8z7eBAcn5dvdE/V+cN6bbtmTUkjAF2a4ufjSaWPFEBLGHSyZ0LiG3IiKQ0IkvHsSfFhSGLLe6S3SMPB48DStPWBQeEVxTn4dN5OQZiD4GlWH7kkaHgEUcR3DakD2kV8vIjQIBpy2FUWIG4AW60uSejgY4SOWxishug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tV4uGHwqLjarhGvfZYQ9bTWmlI9hqRdeI+LjEqCl/Iw=;
 b=nspm5gwXekz7icpAPRvluWsGykoGVYberFbIAqi9GiA/6jFcF65u5QEN6V5TUTpEANpFUxYamYK28DE6dlm8ga61hfXLQxcw6vOqBGrAiG98UyjGPMO/7fjVbAvjq3DpZjru/LB22E40AHbxx5Ljy5V3lb2ZIuc3sCwRS0Po4+Y=
Received: from MN2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:208:1b4::23)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Sun, 17 Dec
 2023 17:26:17 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:1b4:cafe::63) by MN2PR15CA0010.outlook.office365.com
 (2603:10b6:208:1b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Sun, 17 Dec 2023 17:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Sun, 17 Dec 2023 17:26:16 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 17 Dec
 2023 11:26:11 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/3] perf/x86/amd/lbr: Use freeze based on availability
Date: Sun, 17 Dec 2023 22:55:43 +0530
Message-ID: <1d9106579c7781746ca39860bda8061c56d6dc48.1702833179.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1702833179.git.sandipan.das@amd.com>
References: <cover.1702833179.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 27cce6f0-b367-4689-0eec-08dbff2546d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7A0tf2gw+Zgt3ISpA/zYBaM/NIy2FBVFWj/LKN2mVlUbir9t8/3stvfRWONwGP3SHiBBiNTcjIyuRtiCmOgVde/BN/gRWZDMKmrU1zA/k3n+9T5NT1xxGCehTq1gKBhv5+Jr9z13iyS0cvG+yHHq+qvOe66fLDop8VLYikcMBlS53SF//FFteDCv48pcIgYJ58P0Jcd6HgyQc+j4miW78mH4bEG2i5jx2KOiNJlCkYAfbFAZy9Z0Sr+W06xk5xa92MBraqcr9GRtdZ9VgQIp4GzHNwaKMWCj5HGykk4FCdG26Hh5lY/Ot3zXTSoTAYPHEtq7n8aaM5Xm6SK8tk2NHd2yGKTVatsS6ThGiobUVCluEjD+Zyna+cy3Vj8G3x0jmBUrXGsVzZck+V2PhtDzQgVXqGRcgn4tByKZeJss0PzlL/dK1gIciAccvtmYm87h76tjUSIeCgDTs4mUExeqMv2FUA+T2VlAttdYOT6hAvVSSjAxRJ1ldZHbvSVlF1GaNb9PUeSjknU4vdBD3bsfCTsUNF2DoRicZFBdRo/ytGyLRPQ/uxUDLrJwg8nbiJGgDHObHP6WnPm7zX0+Lcy9CXtANOyeR7JedZlr67Pz7EF39EeLxHdKxvvIShDTCtaWTCpQhmUjQDETmtpx17JoLW0aQPRZJBTWAT7VI7+gcBqEIIixUjMlDL4nZuJVJXNRYdn53yr+yqAm6w7v7qOZ4fEno2Rvvn1Vp1cdkfi+9Rl2H8WZxVxXf+LeoyfNELFxpFWyVtXHVLGn6IjuyvBPFw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(46966006)(40470700004)(36840700001)(40480700001)(478600001)(2616005)(70206006)(336012)(426003)(83380400001)(6666004)(316002)(70586007)(54906003)(110136005)(5660300002)(44832011)(47076005)(7696005)(8676002)(8936002)(4326008)(36860700001)(26005)(16526019)(40460700003)(2906002)(81166007)(356005)(7416002)(82740400003)(41300700001)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2023 17:26:16.9698
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27cce6f0-b367-4689-0eec-08dbff2546d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

Currently, it is assumed that LBR Freeze is supported on all processors
which have CPUID leaf 0x80000022[EAX] bit 1 set. This is incorrect as
the feature availability is additionally dependent on CPUID leaf
0x80000022[EAX] bit 2 being set which may not be set for all Zen 4
processors. Define a new feature bit for LBR and PMC freeze and set the
freeze enable bit (FLBRI) in DebugCtl (MSR 0x1d9) conditionally.

It should still be possible to use LBR without freeze for profile-guided
optimization of user programs by using an user-only branch filter during
profiling. When the user-only filter is enabled, branches are no longer
recorded after the transition to CPL 0 upon PMI arrival. When branch
entries are read in the PMI handler, the branch stack does not change.

E.g.

  $ perf record -j any,u -e ex_ret_brn_tkn ./workload

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Cc: stable@vger.kernel.org
---
 arch/x86/events/amd/core.c         |  4 ++--
 arch/x86/events/amd/lbr.c          | 16 ++++++++++------
 arch/x86/include/asm/cpufeatures.h |  2 +-
 arch/x86/kernel/cpu/scattered.c    |  1 +
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 4ee6390b45c9..ffdfaee08b08 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -905,8 +905,8 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
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
index eb31f850841a..110e34c59643 100644
--- a/arch/x86/events/amd/lbr.c
+++ b/arch/x86/events/amd/lbr.c
@@ -400,10 +400,12 @@ void amd_pmu_lbr_enable_all(void)
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
 
@@ -416,10 +418,12 @@ void amd_pmu_lbr_disable_all(void)
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
index 4af140cf5719..9790e906d5e5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	( 3*32+18) /* "" AMD LBR and PMC Freeze */
 #define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
 #define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
 #define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
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


