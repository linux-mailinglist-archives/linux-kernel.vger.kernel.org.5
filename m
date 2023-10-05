Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A697B9F16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjJEOR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbjJEOQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:16:01 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on20626.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::626])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEB1D4EF1;
        Wed,  4 Oct 2023 22:26:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErQpUDBvtGGQUWvuQvxpNv1bXzPqHXZidUQ5Y4ruHAnuEc06hzptgyxHfD3C5iY2PuAL4zYT75C6HGfJi7uSP6fYOQuUmOZun45oDKIO0GMtDAmf+2NpyM0/TW42DaE9ofrQd5YE4z80v/q+Le4SdPCJRd+T20mE08bueoGmkwfpewbpucQvYi8RCeXSgJNrg5r4Guha1nf+mnBujJd8hiMLlktx5K5Vhb+B0yqXyEcjv5imtA1omQ/9IUX1hbT0Xl7nlwq4yHQJKRBeKObRzKCYlY6F68xL1fnLZbbmz1myDivXcv3c6yaNKWvrVc3h1/rjFG/M89ltTFjpJlkguQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LVlPFoNlbno4/HbumKBlL+FDU30UKhtlZ5NY6J/E0i0=;
 b=Fkl7mYkWalYmdZFctX04gHfPYtctWtpoIGBX4UvFXX3/RBkXxcw4guIqeRetoyTVF8LPT/ufnCVHPwFEY00x80rKhOJkgCU46H/9uU9i6WGKDomThZktjUh5IcAYDwi/t10f3vQmUhR+PaqvkFKIVFFxlYECWTls1ay+nEVysa+nOoO/v+vHD5seJh7qBszu12l9ycZSJ6pxVJBFpqMi4yfbvIB0rFXTeB2TG9dZcyCt38EECCrSp+bXq1KoPWlIQXv7hhwJjccjcMjZWxWaqcTa2sdbD5UtIsHpowulIg21avRoWoedfuUvElCwuMLO+QNrwOov8/i+MEslsFNTFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LVlPFoNlbno4/HbumKBlL+FDU30UKhtlZ5NY6J/E0i0=;
 b=HWWrk35IoZNvlj3DH3mRiaqg3y6LCMVTDEuwQUrdO+JTsmSfbKEhGCIVIspRdr/oPdbrAEHh3modsS3smL23GExxp//3KM7cbya9pJ1CwFbJRKoLz5HS87s+Rll4YuAahlVoGKA+dMq2dnBuH9k3W2i/VR0vohS5qQwROLdli6s=
Received: from BL0PR01CA0013.prod.exchangelabs.com (2603:10b6:208:71::26) by
 BN9PR12MB5353.namprd12.prod.outlook.com (2603:10b6:408:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33; Thu, 5 Oct
 2023 05:25:48 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:71:cafe::7d) by BL0PR01CA0013.outlook.office365.com
 (2603:10b6:208:71::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Thu, 5 Oct 2023 05:25:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 05:25:48 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 00:25:42 -0500
From:   Sandipan Das <sandipan.das@amd.com>
To:     <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <x86@kernel.org>
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <irogers@google.com>,
        <adrian.hunter@intel.com>, <tglx@linutronix.de>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
        <eranian@google.com>, <ananth.narayan@amd.com>,
        <ravi.bangoria@amd.com>, <santosh.shukla@amd.com>,
        <sandipan.das@amd.com>
Subject: [PATCH v2 4/6] perf/x86/amd/uncore: Add group exclusivity
Date:   Thu, 5 Oct 2023 10:53:14 +0530
Message-ID: <937d6d71010a48ea4e069f4904b3116a5f99ecdf.1696425185.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696425185.git.sandipan.das@amd.com>
References: <cover.1696425185.git.sandipan.das@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|BN9PR12MB5353:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bba36d5-453f-4493-3690-08dbc563887c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /u3zoD/R6E24IiRHuF+ZkKnJcE5hoGCbmI6QxTQIm5lPRRkRQ4rY0oxCNvElr2hsQyCKkl6HyvaPs+JFbIO5YMG0+UshIOsfYA1DZ/KYr9/WLNJalvv8FVLzyq/or+E6vM0rGKvjLwKUmtZ7R95nOnByQJf5oJJb9duNehKZuNDebOh8IHqsdaHTathRMXai6fsRGqiuZon7zTnBj7lIifkcTrdhdAHVohw/scinOraUIYQudVPN++mqzScxE3uJthadr3bw7khOz0QDrs4s0sFqQKXXcoiLjqawYTOZRJKEYCIBANdc3Wnpy57wkGvIoHHLa2jm10BrTdgmoXe2FWa7Eh0TWAFz+0xAEG8KE166A+ccMp+xOaHRnXFcWqF+6vI76ZPtJ0Wh7iFvKU4KuhOTVAT/es8oYrr2vLMfNm869EOj2sG7xedhZoaTGpN9K8cw/x7V28snoDxqsVXwKQKWJvTo1GnLMMNoLpDck+p9iVOGTBs2S8+oamNFgaa3int8ixJIttKvQGC8SdOHbnOMpxrCPz2srbiOYtH477fLq2AZaqwLD+QNdvKLtk/YzQG76N35w9wOlTj1YoOPcUIS2ng9Qal0+1F7njfF7Zevh6MOlDi7Wv9VcIjLVGVJD8MprCyYjhiLbf1TG7tMxb8ETSs9bWbVnow7UTH2uyIBJSOJPilbmUeoGgS1QWYKGy4ytdLlVGfoGMFJQYkzugTWVa5OtLhqaHNmYFojAKuqFAXme9k2XNzYROp2MGcTTZeQkSfVSG6YfmCO32CbJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(451199024)(1800799009)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(110136005)(2616005)(70206006)(7696005)(41300700001)(316002)(54906003)(70586007)(44832011)(8676002)(4326008)(5660300002)(16526019)(26005)(8936002)(6666004)(478600001)(336012)(426003)(40460700003)(7416002)(82740400003)(2906002)(83380400001)(47076005)(36756003)(356005)(36860700001)(40480700001)(81166007)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:25:48.5020
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bba36d5-453f-4493-3690-08dbc563887c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5353
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, it may be necessary to restrict opening PMU events to a
subset of CPUs. E.g. Unified Memory Controller (UMC) PMUs are specific
to each active memory channel and the MSR address space for the PERF_CTL
and PERF_CTR registers is reused on each socket. Thus, opening events
for a specific UMC PMU should be restricted to CPUs belonging to the
same socket as that of the UMC. The "cpumask" of the PMU should also
reflect this accordingly.

Uncore PMUs which require this can use the new group attribute in struct
amd_uncore_pmu to set a valid group ID during the scan() phase. Later,
during init(), an uncore context for a CPU will be unavailable if the
group ID does not match.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 2fe623923034..318982951dd2 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -27,6 +27,7 @@
 
 #define COUNTER_SHIFT		16
 #define UNCORE_NAME_LEN		16
+#define UNCORE_GROUP_MAX	256
 
 #undef pr_fmt
 #define pr_fmt(fmt)	"amd_uncore: " fmt
@@ -45,6 +46,7 @@ struct amd_uncore_pmu {
 	int num_counters;
 	int rdpmc_base;
 	u32 msr_base;
+	int group;
 	cpumask_t active_mask;
 	struct pmu pmu;
 	struct amd_uncore_ctx * __percpu *ctx;
@@ -61,6 +63,7 @@ union amd_uncore_info {
 	struct {
 		u64	aux_data:32;	/* auxiliary data */
 		u64	num_pmcs:8;	/* number of counters */
+		u64	gid:8;		/* group id */
 		u64	cid:8;		/* context id */
 	} split;
 	u64		full;
@@ -371,6 +374,13 @@ int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
 	return info->split.cid;
 }
 
+static __always_inline
+int amd_uncore_ctx_gid(struct amd_uncore *uncore, unsigned int cpu)
+{
+	union amd_uncore_info *info = per_cpu_ptr(uncore->info, cpu);
+	return info->split.gid;
+}
+
 static __always_inline
 int amd_uncore_ctx_num_pmcs(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -409,18 +419,23 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct amd_uncore_ctx *curr, *prev;
 	struct amd_uncore_pmu *pmu;
-	int node, cid, i, j;
+	int node, cid, gid, i, j;
 
 	if (!uncore->init_done || !uncore->num_pmus)
 		return 0;
 
 	cid = amd_uncore_ctx_cid(uncore, cpu);
+	gid = amd_uncore_ctx_gid(uncore, cpu);
 
 	for (i = 0; i < uncore->num_pmus; i++) {
 		pmu = &uncore->pmus[i];
 		*per_cpu_ptr(pmu->ctx, cpu) = NULL;
 		curr = NULL;
 
+		/* Check for group exclusivity */
+		if (gid != pmu->group)
+			continue;
+
 		/* Find a sibling context */
 		for_each_online_cpu(j) {
 			if (cpu == j)
@@ -603,6 +618,7 @@ void amd_uncore_df_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_NB;
+	info.split.gid = 0;
 	info.split.cid = topology_die_id(cpu);
 
 	if (pmu_version >= 2) {
@@ -641,6 +657,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
+	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
 	if (pmu_version >= 2) {
 		*df_attr++ = &format_attr_event14v2.attr;
@@ -734,6 +751,7 @@ void amd_uncore_l3_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
 
 	info.split.aux_data = 0;
 	info.split.num_pmcs = NUM_COUNTERS_L2;
+	info.split.gid = 0;
 	info.split.cid = get_llc_id(cpu);
 
 	if (boot_cpu_data.x86 >= 0x17)
@@ -770,6 +788,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
+	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
 
 	if (boot_cpu_data.x86 >= 0x17) {
 		*l3_attr++ = &format_attr_event8.attr;
-- 
2.34.1

