Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355627A0753
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjINO30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240011AbjINO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:29:24 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FB4110;
        Thu, 14 Sep 2023 07:29:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=em55uAgcAABxO4ujVfYwl8I7AAR79UbJEdGgD6aJYWQkCpHpcwjS8t0I/cGga/IOZoKk+Npuu/HqNT6atfa7wv2aq5jogahJ4c3gdy+APn4/HvnJxcFYTSt4cpzIForBH8cmVUa6DU29A/uAyTeY32oNr8UVdCbd82NwPKlxmIcDId5+MVUaKGN2JBab7Qr1ODlJdlP3J7lMI2mTRMjXwru8rg13P1Q/CrtLZtdu7V0jaG39N0I8LHlqzemkWTHKL+qarC1JMMPoVH58MTPboEyaCeM8+8c1afajVR0YZp1gVsewRY89fRYNHvjdYg7qEdXiVkKw5Hllj/5K8eGb+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cX0TiGt8sPR/7d9wQa+rwjxiuTN0AN+4ZeVCzEOt5BM=;
 b=kcCkZaRc83XRaPNDJ+l5KrP6Rd+dAXTbusoOQYbHOZ7Xmp9IbusSJ4MyYZBMcjmstV+RKnyBTxrejcwXj+8LDpMS7iKZMW1/uePsTxVRokNuLKRrTKEFfTwD53nphTMa4kVmOgayfntVtTJXPyCqceWCuic3A8uagDnx7mAg1ZVoQgHfCIIV9Y+RJJdutsiBGfYK3HO1qaceCcGoGC2HB/c4kQgBfA2o7oEdQIshf2AxvFyY6kJ2hxe88TywWOoEHM5FhoDXSMEThzTx8p015b3J+R9r61aV+ATUT9bGyvOxd8kHsxEGWPylIln+qY8p/48sSbmgS0RQbC+DVB8Z0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cX0TiGt8sPR/7d9wQa+rwjxiuTN0AN+4ZeVCzEOt5BM=;
 b=ix9VbtfqoCV8/BGALF5+b6OkeC09UaEPVhz4nYoz5lwrVLzxk+VCT+l5MAzWXIxj5bGRAL7T4Xoo38NjhWaiQwk6O4IhBnR2iHNdrDJw90siS3sXyYYwP+c5eXoznBRupdL+vyAOSBOUKBn9Tq567sNLU4ra2LzKPA2NGlk/Sy8=
Received: from MW4PR04CA0288.namprd04.prod.outlook.com (2603:10b6:303:89::23)
 by CH0PR12MB5388.namprd12.prod.outlook.com (2603:10b6:610:d7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 14:29:17 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::f) by MW4PR04CA0288.outlook.office365.com
 (2603:10b6:303:89::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 14:29:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Thu, 14 Sep 2023 14:29:17 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:29:09 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
CC:     <x86@kernel.org>, <peterz@infradead.org>, <leitao@debian.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <leit@fb.com>,
        <dcostantino@meta.com>, <jhladky@redhat.com>, <eranian@google.com>,
        <ananth.narayan@amd.com>, <ravi.bangoria@amd.com>,
        <santosh.shukla@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 2/2] perf/x86/amd/core: Fix overflow reset on hotplug
Date:   Thu, 14 Sep 2023 19:58:41 +0530
Message-ID: <882a87511af40792ba69bb0e9026f19a2e71e8a3.1694696888.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com>
References: <3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|CH0PR12MB5388:EE_
X-MS-Office365-Filtering-Correlation-Id: 5925bc99-191d-4517-e548-08dbb52efa21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A60JtOJAsFMSeteWbbcgzCR6JtfzjB5vFD4bwFNbmq3rv8QH4uMWg9TG68IWoS7MDr7pKW2VSkIDIzCJIFtu1GW7Q/e3N2jw90/aMANr58Jrj9f4vOJgEnKgbtxagsi6XPTNsviyvK9W1LSSQMeA3XqMWs+cuDqwUIaoWHyaRRAviPzsawZKJhCysWMLDEoQOUBBAqsIlGY1lGnvvMyN6+2jAzhweDCjYybTFTFGAvYGLA7DAPisMQt4j4wGdkDaQ/8QWWjCyevs2v50T8CttOSSj9Oz3XkX3qBe2KJmsArSnEqSn9CYJ/oZGDLw+FzuJuT3DTTB48YGfp0npqK0cFDpjQZwK5VSteU2s9j2YHKXma1MPqVV+ah8p9+aHLXZjX9cReXC+xMBKl/u8cFLd30OA2xVuNpErM+2hHOG00+327ccIR/6X+5xxZjs2avKY8N49yUHWImncEojiUPKv6zORQqJDM/Hvn+PdRrDYgnhqUw7R4ZFCy8uqGUbmfGNDECdG6txc71mJnle4Sb1na3dE1sJcZ0vQarYuLiRg1jkr1aEtNKF+vlp1Qjrvh/z9RtvrDEsIDsdmowtrB8i+BxmsJPZ4UD5J1Tx79YdjfnTBQU1K5zwsqFsTgx3So5OGeK2j0dAQ3h6UysZxJ38gdp4Z8EVl3VewiB3cXpWIjyomFCB7DTrhGoHKXHr0WLQ7qMlNAoJPU8BNw9jZ9Rsjfup7RoNvjVmpRkt05HQqcyq8HWuGWs6CwxPG6kWyPo6aKsOmL9rwyoj1bS9VhEs4Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199024)(82310400011)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(6666004)(336012)(82740400003)(356005)(16526019)(2616005)(426003)(26005)(110136005)(70586007)(70206006)(54906003)(966005)(478600001)(81166007)(316002)(47076005)(36860700001)(41300700001)(83380400001)(2906002)(86362001)(8676002)(8936002)(5660300002)(44832011)(4326008)(36756003)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:29:17.1143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5925bc99-191d-4517-e548-08dbb52efa21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5388
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernels older than v5.19 do not support PerfMonV2 and the PMI handler
does not clear the overflow bits of the PerfCntrGlobalStatus register.
Because of this, loading a recent kernel using kexec from an older
kernel can result in inconsistent register states on Zen 4 systems.

The PMI handler of the new kernel gets confused and shows a warning when
an overflow occurs because some of the overflow bits are set even if the
corresponding counters are inactive. These are remnants from overflows
that were handled by the older kernel.

During CPU hotplug, the PerfCntrGlobalCtl and PerfCntrGlobalStatus
registers should always be cleared for PerfMonV2-capable processors.
However, a condition used for NB event constaints applicable only to
older processors currently prevents this from happening. Move the reset
sequence to an appropriate place and also clear the LBR Freeze bit.

Fixes: 21d59e3e2c40 ("perf/x86/amd/core: Detect PerfMonV2 support")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

v1: https://lore.kernel.org/all/20230613105809.524535-1-sandipan.das@amd.com/

v2:
 - Rebase on top of tip.

---
 arch/x86/events/amd/core.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b04956cbd085..e24976593a29 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -534,8 +534,12 @@ static void amd_pmu_cpu_reset(int cpu)
 	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
 	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
 
-	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
-	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+	/*
+	 * Clear freeze and overflow bits i.e. PerfCntrGLobalStatus.LbrFreeze
+	 * and PerfCntrGLobalStatus.PerfCntrOvfl
+	 */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR,
+	       GLOBAL_STATUS_LBRS_FROZEN | amd_pmu_global_cntr_mask);
 }
 
 static int amd_pmu_cpu_prepare(int cpu)
@@ -570,6 +574,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	int i, nb_id;
 
 	cpuc->perf_ctr_virt_mask = AMD64_EVENTSEL_HOSTONLY;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -591,8 +596,6 @@ static void amd_pmu_cpu_starting(int cpu)
 
 	cpuc->amd_nb->nb_id = nb_id;
 	cpuc->amd_nb->refcnt++;
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -601,6 +604,7 @@ static void amd_pmu_cpu_dead(int cpu)
 
 	kfree(cpuhw->lbr_sel);
 	cpuhw->lbr_sel = NULL;
+	amd_pmu_cpu_reset(cpu);
 
 	if (!x86_pmu.amd_nb_constraints)
 		return;
@@ -613,8 +617,6 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
-
-	amd_pmu_cpu_reset(cpu);
 }
 
 static inline void amd_pmu_set_global_ctl(u64 ctl)
-- 
2.34.1

