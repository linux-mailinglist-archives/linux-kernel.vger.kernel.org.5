Return-Path: <linux-kernel+bounces-42586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823F684037C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:07:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B461F2276A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F835BAC4;
	Mon, 29 Jan 2024 11:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="I03bmjOW"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095965A0F7;
	Mon, 29 Jan 2024 11:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526421; cv=fail; b=Her0OLNVUxZwokvxR82ba5lNAVvrJogQ97v4Ui0bjYD7LPOT37iCR/NqhBQq78YPkTU51vez1ogBIyaR+TdV80zQ4V69FbTDNji1HOhJ2zdwFPvJd+nR8NgwPrRulZ4xbFs69aGQgPKFrhiSWNo0Lz+uo1+kGttp1NRkFvttYNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526421; c=relaxed/simple;
	bh=x1TZWCu6dynIBSbOD8RL8/h6gbt3uVx5/vLY9/pxHAk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fyo/LPagVjAZNq+JvBmPo665lKJuuJcB3rwKy6xT5vv1aUpYz05K9HMF1esV87fEgwFsmnT89arqO7/TiW05ZBRBWJYdvNjdrwlYS2LiZxl+OJ1n5l9Hldgy/tvH6wY3WbIiOO4WXu7wFsNVXIGYJLdi0bJEWDvRzVFHHyUi7O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=I03bmjOW; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDkhL3EklKTAXbiNu5ox/fyYMP10PZb9NKXveig8RQBIer8aWwOdPzbHjsVL/DRGRLHOkmyAbu1g1GnLuKXM0JmC+1EuRyhVQh/oZupn9kNfcrmJ3WmK0kuOtdprpzerFfRaH1dQD07gEgHdf7KE4/sreYxK15kHHLjvQNC9RVgmlgpSv4nWbKxVtMeZ7wnbY7yjTvQwTRg7DJE6FrKm3gPCsHqEwEm6eE4XvJpi2M24Pkf6yAhO/vulkvSCCT1BA3xgETuoMHLgL4A0feVfU0xJiGIZ3/Y4vZpCLzZTE51jRaipF281xhYQMpGpPKnslBsyTAYF9dCny0y3jToivg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eqxqn2kHV+oLH7wRUXODzvm3WnIbOCipuP0XSA6FRDQ=;
 b=OJEaMAQL9zWAGx8a6Om9+C3Y88U//vTBirZvvk66eeRA6nuEVJkCKvCW/WEorXGQ6eerEmGgZ7kn7V7N3Ibg5tXXLW+bG4Lj3ytyp2ppmjvFiWgcv6lDRezQLtyRPgDOeDnmllF46p+9/a1afN4ctbrhT/Jy0nIo5R+5vL9b6gvz5WvZSfUewl9DmSNWVY6e5KOW0lQ+USFKoZ4+76iDRX3kysJPRaOnlL+DodFsJqOEzJTRQ416mu1do3+2ZU7qsAywYGX1IemoDtnH0iHz1jJze/Q0GCZg2vz1suzkW+sGTFbWDtJCvgi/Ph5bk34Yz46DK+5pLpcukb9cb0MkFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eqxqn2kHV+oLH7wRUXODzvm3WnIbOCipuP0XSA6FRDQ=;
 b=I03bmjOWclGrKRjBC0rFPyRmSs2bG1OcVyNC6zZWtEF3tfDxOeuR0wmCGQlX5+zfCqRr8o9hq4r1KBQY2ao8cIWOZz9DXER05lgnZzpRQL7y9qOa6hlGrhosyPKBHkGephZ8plzr80QeSrTh49FrAoGGuRaU1EmQrUIoLRCCS3Y=
Received: from DS7PR03CA0076.namprd03.prod.outlook.com (2603:10b6:5:3bb::21)
 by CYXPR12MB9444.namprd12.prod.outlook.com (2603:10b6:930:d6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 11:06:57 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::46) by DS7PR03CA0076.outlook.office365.com
 (2603:10b6:5:3bb::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Mon, 29 Jan 2024 11:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Mon, 29 Jan 2024 11:06:56 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 05:06:51 -0600
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@redhat.com>,
	<acme@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<namhyung@kernel.org>, <adrian.hunter@intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <eranian@google.com>, <irogers@google.com>,
	<mario.limonciello@amd.com>, <ravi.bangoria@amd.com>,
	<ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v3 1/3] perf/x86/amd/lbr: Use freeze based on availability
Date: Mon, 29 Jan 2024 16:36:24 +0530
Message-ID: <12f378d5c9459e765c6c3a14b092e6f91da596e3.1706526029.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1706526029.git.sandipan.das@amd.com>
References: <cover.1706526029.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|CYXPR12MB9444:EE_
X-MS-Office365-Filtering-Correlation-Id: 9906cb89-158d-4e81-3d19-08dc20ba6889
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	46KpmL5D49VKh4UgyRAhJ+yocCQ3M8MlB1kKDQ6KH7EKy8cdyKCztvE6NZ5zG7gX6EX7euyFjkREqn79kV4gqE299keM+sBNLPllHXMhZlK5TISsLRib2fmFdWQyKcEYMDrTnhe69hjr2bfDveOQ5Rre3f49wPXvNdwvcyTPrevCAvOKIyH/51cx5MM3HZDxcQ+wcRaeYM32/h3eXsoLDD382xcXJ8n8twKDbZ966xVktq9ORd6oyKjJuIfN6en+M6mdDBwLZBX2gobm6hmzwH3qQ3qB7cUosua/j2TKjmJ27lZRE0Ei4dhIsAWxPGy1ld/SHtAFojuUvGtnCePnCCwNsgvyPi2XQ14N1KleNc4Gvey0lgf7cEdBfUTJDmf7hTfbqCpvObzYsXrTlEBuD9s1+uOno55VSVzE1okuaL2fmzwtsx2n/C1oIyNKt2cvmfvLWIWjXo16jIvnFNK+nyqmTBMtHhYhBK+CoPq29FUyhL6e13ZcGvlKifE8GGfBvfw/Si9GDW7mAHOiM4MKr329h2veJGyKfWetNo+ooeXo0TVY/dmYw9P6/bZY3FX0uIGVfWwAxgps0aHBcw+J+XUA+if+am6XGPOCwR4fv/j4IJgMiaphu477YrO0E8Ym5w2K/DiUwrDzB60BzJygYj90u/+3QmRUGwP6WEh9GQExPjGLRX/95wxe1FBlxbWz72laz0YK6N6lZ6l2G1FeVO0ppcLvyv/LhAEsYoO5kEKJxqsvBA5PgJD4oYsQpRy28UOjeSoPR+N/ylb0/aGvSg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799012)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(2616005)(83380400001)(8676002)(426003)(16526019)(26005)(336012)(41300700001)(4326008)(7416002)(5660300002)(8936002)(36756003)(2906002)(44832011)(316002)(54906003)(110136005)(70206006)(70586007)(86362001)(6666004)(478600001)(356005)(47076005)(81166007)(40480700001)(40460700003)(82740400003)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 11:06:56.8816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9906cb89-158d-4e81-3d19-08dc20ba6889
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9444

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

Since the feature bit is visible under flags in /proc/cpuinfo, it can be
used to determine the feasibility of use-cases which require LBR Freeze
to be supported by the hardware such as profile-guided optimization of
kernels.

Fixes: ca5b7c0d9621 ("perf/x86/amd/lbr: Add LbrExtV2 branch record support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
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
index 4af140cf5719..e47ea31b019d 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -97,7 +97,7 @@
 #define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
 #define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
 #define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-/* FREE, was #define X86_FEATURE_LFENCE_RDTSC		( 3*32+18) "" LFENCE synchronizes RDTSC */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	( 3*32+18) /* AMD LBR and PMC Freeze */
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


