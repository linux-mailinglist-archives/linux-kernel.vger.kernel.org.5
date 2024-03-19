Return-Path: <linux-kernel+bounces-107217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E005B87F962
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91118282E69
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E2353E34;
	Tue, 19 Mar 2024 08:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r3VD9Zae"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A215465D;
	Tue, 19 Mar 2024 08:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836353; cv=fail; b=ijy3UxwCUU9eF/snNYbDFR8ALzFy/JVSPbazaqiKjpgxdTyPPf5nlOgKbPkGi656T0ORCfELTI0p5egZlayv37qg62I0AhoMupjKZbxKotOLaB4P+xq/PL4OBBeZFshKhyOpYIOcH9DVd6VOzmimgD5B7pahiLDDV9DgsgykHKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836353; c=relaxed/simple;
	bh=IIZFSs9ZnffxlCzYRu74nJe42YQ7SqTXYJEUkCqfEZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QvM5ax7EmRCn5C2G2dbnt+FCyzErclRWFP6gevALrgNmIAXOSnB7VqvF3x9KCjpEzR1+kdRNPh5p5BvxaWHgsKSwwAMtekCvrY3cw+orJhxyZzDg72a4j6BGtelXvKfgkaXnmj95Ifwu5eq8kbeVCO5IhuRpqjvZFsPMbPWsH6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r3VD9Zae; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QnNBWtcPDMFJi2GOHAjxJXoyt8moEC2AxxPZcpj28nITXbSCwWhFRbPR73d8XBIvsD0lLxpaQAf3deCyj8oCayjIzyvWpFTUHLndg/HeDgRdWN6s32MxBUk2PyQ9KmbkQtLQQOS6XkIVha1PeWL6s1nMZAohmpyYjd1sVZRpoh4gjLJWA09Btp1S16VQpuJxTPlsDgvj6UTe3i70+BPSXVLP36KxjTnvplbOON2R5m3d9jPc2wIw3mXhrz4kxLkA40qgpjslgsJYmM/8Hid+RZ4+b3uiNTmvIJfyFbpcSCt2k8l/jedOMeTKVaKgcGru+BfRx+ZEbPt5fKPSSF20Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqinO6jX4Vziwq8cqlrDQMFxaTsDpwhCpC+oSRHINAM=;
 b=GVNt6b83apvEESEAg1cigWCJRgNOfWm963XOsFcRWIYKbVuJq5p9B5+wxJMZJ7chqlcyfJ7z4Ip2B3jIzEb2Mut1alEsD5g7pNMUJaPJ1vLj4T3X08CyqxjR1F3MKZXo38d0UvcEpwFsiRbqEMQM5z89ZGrXpBXQ1aBS6tTb7K3NvT8Eva92oCPs/YBaFxUkyhv0V8CPB3jrMZ9WRBvzU909dtOVtQbI2Yl4j4HkRuodn1agCTzB3Mrh6RXzxBMk2c6I74C8QjnLKNZJ0dHM9dOmiOIAaQtUBmH1fulY87/iE6MC5/pPuqhKTItrTfhr6o1nt34VWRUdfU17Bc8VPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqinO6jX4Vziwq8cqlrDQMFxaTsDpwhCpC+oSRHINAM=;
 b=r3VD9ZaegWX4dr3MorHA0VIWCtxqP3yJBPYMlByz8qX+mqMRGijpaV2mJSSLlXGV5rAEHmBCd577SMooM2g0eH6awpBgeybipL366p7XxFZ9j1lQewYIGQOgimiuZ+PuVv6Gyq99xKV6M/th7F1vH9EmRwKLpa9ZGnXnS5kaLPg=
Received: from CYXPR03CA0091.namprd03.prod.outlook.com (2603:10b6:930:d3::14)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 08:19:09 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:d3:cafe::b5) by CYXPR03CA0091.outlook.office365.com
 (2603:10b6:930:d3::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27 via Frontend
 Transport; Tue, 19 Mar 2024 08:19:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Tue, 19 Mar 2024 08:19:09 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 19 Mar
 2024 03:19:02 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <peterz@infradead.org>, <mingo@kernel.org>,
	<acme@kernel.org>, <namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <eranian@google.com>,
	<irogers@google.com>, <ravi.bangoria@amd.com>, <ananth.narayan@amd.com>,
	<sandipan.das@amd.com>
Subject: [PATCH v4 2/2] perf/x86/amd/lbr: Use freeze based on availability
Date: Tue, 19 Mar 2024 13:48:17 +0530
Message-ID: <8d47ce56f23dc1eba8f0876b2f32293c2c1c6912.1710836172.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|MW5PR12MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: 02476efb-194a-4421-efad-08dc47ed40a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQXk6v69NKkLm7mIZ3ShxPKstdyF7plz1w/r+hBM3tEO7K4cbA3BYbneweld5ZXjcqeHJifdQ4x5wZCETCV3KP/2YPJ1YGv3/MuP/luN1N/IlgaAvAA4qfVXfbm4soyQ+jour9Y1uXgzHFT0AzS7ji/dgNPbxnV/XgYWRfQt8yF+Bg4tnKBB16oDlqbmxyWOfPtYqvPq+AF8tJBALf2gn/8k9QIIKgYt+Ysrl52isMLuenzuZyq0EmFIr64k2iwbebh1bGpLo0F1lV6xFhn7ujcOT/FhSQ3vV44OeOEwxpC9MoOWidAn1T1QdJgsYzpsJG8IOox+V9qHMSWRbUVHAfT+rt5esNCRoOiDTjbn+9SrOFMcIzAaPv1WKoP21dHP5nhv5q7Lk4XEmiuWQVdau/MLgMEXzWDUolvmKz37+vMBYjYYHsqpvxVf5Ff5eOxp2WQsssWOOgp0SUXwgqJBPMUHdmMqcPbePuNJFEk1JhgHB91y+/4nidzy13GjpugC+wkdwHNKerr68tlfQcxoRGAN9BlrpnGUUARfeC1O5o9iOAMsmV/Xzxu6qY7n9ox/SCLMO9RmJ9uhbYKKx+A0DoRMXrcujGa4qCUZyKBynpDPV5d/gMBa9qnGneEehsbKHDReQsnHFXCa0AFNV+XneJHS+7/GyuqnKVarCmedcMNTDPImqo1S9ndDDdUldljlUNXXrmggcAduKYBCOyT298ERqxHTl72l7PWjAkcwa0OcH02wbPKdkYo5ZHW80VF5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 08:19:09.5824
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02476efb-194a-4421-efad-08dc47ed40a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599

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
 arch/x86/include/asm/cpufeatures.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

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
index 028f333dc530..e57d584601c6 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -462,6 +462,7 @@
 /* AMD-defined performance monitoring features, CPUID level 0x80000022 (EAX), word 21 */
 #define X86_FEATURE_PERFMON_V2		(21*32+ 0) /* AMD Performance Monitoring Version 2 */
 #define X86_FEATURE_AMD_LBR_V2		(21*32+ 1) /* AMD Last Branch Record Extension Version 2 */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 2) /* AMD LBR and PMC Freeze */
 
 /*
  * BUG word(s)
-- 
2.34.1


