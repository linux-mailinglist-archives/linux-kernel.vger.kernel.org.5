Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E40BC7B9F5A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbjJEOWW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232371AbjJEOUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:20:20 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061f.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eab::61f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76DCD4EF7;
        Wed,  4 Oct 2023 22:26:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zij66N1wJS5G/NfiODgrrYDvRl/uRPaaSWSG0TON7GcSxyCxJEYa21f1UhBV0hekYfkjekQVjprpD2pyykgvv+JxkMfq54bqgoI9R/uCeeBPuPjAJdsIXwZKSWC8aoYUjwJiUGHf7uAi51bP3iKzq07+9+7dZxettU4V1YDL82HZUmNU5xlr761I8eJUwz7vfoIJM2fG9pgubNpSSsmDDVtem46l0wgqUbFaSRDIOR3+h6ACxkRvbR2oL26vIoy/l8LCocViIAUHIGwyfyghIgK3vGVznF44GbzpRiJ4MBKtBGocId6c6o7DvYPLtav59hce42CGlm/MdLZeNZhxhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUdMjEm7deVyT2kl20ILuy91w+wua2S02CT89YQQHXI=;
 b=ZBbNy8i6XtC6mw8TzGXE8ErOmVM5I5nM4qdJZd5dmumG1xXXZgQAIOiYvjFwacWXausktx3efDx7SbQVIXRt22ccIbmmUdV7QDEiitCkb2ISQIp9Pa2WdkG9R7vJYtvSFYx74xjWDunFvlSDiQ6rd5gAqUZOSgGbdyDYSkXfaLZU0NJxx+w96/Ey3eq3d3+jHVAn3FG6CMCpRw1Bh0vqyuVFxbnJ69KqsA+P+l/NtyrVUI2d0AOqbNMVYHWWAdp3CBgKiPnjDIxPInNLWdpuUzUhVpaytcdBtDTjYd3HapyZnbwf3j+2UT++jZ66OzQ2XZnTg2i+tSxVwha/go07tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uUdMjEm7deVyT2kl20ILuy91w+wua2S02CT89YQQHXI=;
 b=s5xEkKKUf6KHL+Q+iMH/omiN9EE/hEBGhNX++eMiPZhR+xmJTPKJK2pFBQQ09UQ0ySncsbfvDtQMRiPJlAjxuX1kae8IapulU1MqSDMh8ZvRJO5aQ6iLCQMbFYPM7LECD2w5Db4KUVZlTqVBWS/UjaH/26QoCNaNhhcyLOlLSgE=
Received: from DM5PR07CA0111.namprd07.prod.outlook.com (2603:10b6:4:ae::40) by
 DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.33; Thu, 5 Oct 2023 05:26:35 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::74) by DM5PR07CA0111.outlook.office365.com
 (2603:10b6:4:ae::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.26 via Frontend
 Transport; Thu, 5 Oct 2023 05:26:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Thu, 5 Oct 2023 05:26:33 +0000
Received: from sindhu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 00:26:27 -0500
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
Subject: [PATCH v2 5/6] perf/x86/amd/uncore: Add memory controller support
Date:   Thu, 5 Oct 2023 10:53:15 +0530
Message-ID: <b25f391205c22733493abec1ed850b71784edc5f.1696425185.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: f3d22065-a943-4f72-4427-08dbc563a37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GCqYyR6j/Zf5gY+GZyk02G7u6iK2dd2h2lp16jGIpD1zHR5YRt0/716M2Kk+2rdFPvX0HiyaEhyfBx8GSEPrjblyUjsTACXoY77yoR8EhWT4+wzLShCkG1XAif4nLWumNsT9wT++1FiOITLAyVA09h6udfjklcwHoKkuGZXm69WX/2ReQNVClFKmjqsMllet/hLQkr9TmdS5SyMmgrN0OlGvKqtGhS+bDuFPxReKWNJZxVN5+PcImmaMk14UXF7okhWHGlw6HIOAmc7aBCxvGcIZ3Z2FT1O1AZlPN6RomWXt1k/zycgb76OzgLFp5fiT/t6v47Dnv2itAWYvYqqkkXGUyJRLv8Qh4LcyezjmICh96oLENBgqisaulPbOJgCbkMsYgtOtDS6ky14nXWvivRodjZpFGZuyWB0BeGI8cWtWGK4EVq4bkluAuVY/W7HLTqTaZJRWjy5VpNN2ODpc6mjN/MJoDhyaLiLLXmCqgqKMo1kymJqC1xfDntNyVm7JGI5hiOh795Wep+mixQeKGUsPsLMSH8YLW7q9CHqjVIRGALzSnqjwAqNoRxMRWTaL2+4qM+3A4ylcWPXmZF6WJNwjW3U5BLFVNkim7bdNCoVjs7QuIbvlYTsVwTyph8QKzgQjUrRntgcGe1kwIRLZDKWQ9nhRvqInLXw4ej6zXRbelRD5pUfiViaz2btJQS+1HYLuuQskxXOcaYBNY/brHz8uvbZsaHFWj2ShfdEZnZQjLwJuD95yfIZ1IOjgP1+TjVVMOUI4I2aIytqFlj2+Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(82310400011)(451199024)(1800799009)(186009)(36840700001)(46966006)(40470700004)(110136005)(54906003)(70206006)(40480700001)(70586007)(316002)(36860700001)(41300700001)(44832011)(40460700003)(426003)(336012)(7416002)(2906002)(36756003)(83380400001)(7696005)(6666004)(26005)(5660300002)(4326008)(8936002)(8676002)(16526019)(2616005)(81166007)(82740400003)(356005)(478600001)(47076005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 05:26:33.6940
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3d22065-a943-4f72-4427-08dbc563a37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unified Memory Controller (UMC) events were introduced with Zen 4 as a
part of the Performance Monitoring Version 2 (PerfMonV2) enhancements.
An event is specified using the EventSelect bits and the RdWrMask bits
can be used for additional filtering of read and write requests.

As of now, a maximum of 12 channels of DDR5 are available on each socket
and each channel is controlled by a dedicated UMC. Each UMC, in turn,
has its own set of performance monitoring counters.

Since the MSR address space for the UMC PERF_CTL and PERF_CTR registers
are reused across sockets, uncore groups are created on the basis of
socket IDs. Hence, group exclusivity is mandatory while opening events
so that events for an UMC can only be opened on CPUs which are on the
same socket as the corresponding memory channel.

For each socket, the total number of available UMC counters and active
memory channels are determined from CPUID leaf 0x80000022 EBX and ECX
respectively. Usually, on Zen 4, each UMC has four counters.

MSR assignments are determined on the basis of active UMCs. E.g. if
UMCs 1, 4 and 9 are active for a given socket, then

  * UMC 1 gets MSRs 0xc0010800 to 0xc0010807 as PERF_CTLs and PERF_CTRs
  * UMC 4 gets MSRs 0xc0010808 to 0xc001080f as PERF_CTLs and PERF_CTRs
  * UMC 9 gets MSRs 0xc0010810 to 0xc0010817 as PERF_CTLs and PERF_CTRs

If there are sockets without any online CPUs when the amd_uncore driver
is loaded, UMCs for such sockets will not be discoverable since the
mechanism relies on executing the CPUID instruction on an online CPU
from the socket.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 arch/x86/events/amd/uncore.c      | 156 +++++++++++++++++++++++++++++-
 arch/x86/include/asm/msr-index.h  |   4 +
 arch/x86/include/asm/perf_event.h |   9 ++
 3 files changed, 168 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 318982951dd2..9b444ce24108 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -55,6 +55,7 @@ struct amd_uncore_pmu {
 enum {
 	UNCORE_TYPE_DF,
 	UNCORE_TYPE_L3,
+	UNCORE_TYPE_UMC,
 
 	UNCORE_TYPE_MAX
 };
@@ -286,7 +287,7 @@ static struct device_attribute format_attr_##_var =			\
 DEFINE_UNCORE_FORMAT_ATTR(event12,	event,		"config:0-7,32-35");
 DEFINE_UNCORE_FORMAT_ATTR(event14,	event,		"config:0-7,32-35,59-60"); /* F17h+ DF */
 DEFINE_UNCORE_FORMAT_ATTR(event14v2,	event,		"config:0-7,32-37");	   /* PerfMonV2 DF */
-DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3 */
+DEFINE_UNCORE_FORMAT_ATTR(event8,	event,		"config:0-7");		   /* F17h+ L3, PerfMonV2 UMC */
 DEFINE_UNCORE_FORMAT_ATTR(umask8,	umask,		"config:8-15");
 DEFINE_UNCORE_FORMAT_ATTR(umask12,	umask,		"config:8-15,24-27");	   /* PerfMonV2 DF */
 DEFINE_UNCORE_FORMAT_ATTR(coreid,	coreid,		"config:42-44");	   /* F19h L3 */
@@ -296,6 +297,7 @@ DEFINE_UNCORE_FORMAT_ATTR(threadmask2,	threadmask,	"config:56-57");	   /* F19h L
 DEFINE_UNCORE_FORMAT_ATTR(enallslices,	enallslices,	"config:46");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(enallcores,	enallcores,	"config:47");		   /* F19h L3 */
 DEFINE_UNCORE_FORMAT_ATTR(sliceid,	sliceid,	"config:48-50");	   /* F19h L3 */
+DEFINE_UNCORE_FORMAT_ATTR(rdwrmask,	rdwrmask,	"config:8-9");		   /* PerfMonV2 UMC */
 
 /* Common DF and NB attributes */
 static struct attribute *amd_uncore_df_format_attr[] = {
@@ -312,6 +314,13 @@ static struct attribute *amd_uncore_l3_format_attr[] = {
 	NULL,
 };
 
+/* Common UMC attributes */
+static struct attribute *amd_uncore_umc_format_attr[] = {
+	&format_attr_event8.attr,       /* event */
+	&format_attr_rdwrmask.attr,     /* rdwrmask */
+	NULL,
+};
+
 /* F17h unique L3 attributes */
 static struct attribute *amd_f17h_uncore_l3_format_attr[] = {
 	&format_attr_slicemask.attr,	/* slicemask */
@@ -349,6 +358,11 @@ static struct attribute_group amd_f19h_uncore_l3_format_group = {
 	.is_visible = amd_f19h_uncore_is_visible,
 };
 
+static struct attribute_group amd_uncore_umc_format_group = {
+	.name = "format",
+	.attrs = amd_uncore_umc_format_attr,
+};
+
 static const struct attribute_group *amd_uncore_df_attr_groups[] = {
 	&amd_uncore_attr_group,
 	&amd_uncore_df_format_group,
@@ -367,6 +381,12 @@ static const struct attribute_group *amd_uncore_l3_attr_update[] = {
 	NULL,
 };
 
+static const struct attribute_group *amd_uncore_umc_attr_groups[] = {
+	&amd_uncore_attr_group,
+	&amd_uncore_umc_format_group,
+	NULL,
+};
+
 static __always_inline
 int amd_uncore_ctx_cid(struct amd_uncore *uncore, unsigned int cpu)
 {
@@ -835,6 +855,133 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	return amd_uncore_ctx_init(uncore, cpu);
 }
 
+static int amd_uncore_umc_event_init(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int ret = amd_uncore_event_init(event);
+
+	if (ret)
+		return ret;
+
+	hwc->config = event->attr.config & AMD64_PERFMON_V2_RAW_EVENT_MASK_UMC;
+
+	return 0;
+}
+
+static void amd_uncore_umc_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (flags & PERF_EF_RELOAD)
+		wrmsrl(hwc->event_base, (u64)local64_read(&hwc->prev_count));
+
+	hwc->state = 0;
+	wrmsrl(hwc->config_base, (hwc->config | AMD64_PERFMON_V2_ENABLE_UMC));
+	perf_event_update_userpage(event);
+}
+
+static
+void amd_uncore_umc_ctx_scan(struct amd_uncore *uncore, unsigned int cpu)
+{
+	union cpuid_0x80000022_ebx ebx;
+	union amd_uncore_info info;
+	unsigned int eax, ecx, edx;
+
+	if (pmu_version < 2)
+		return;
+
+	cpuid(EXT_PERFMON_DEBUG_FEATURES, &eax, &ebx.full, &ecx, &edx);
+	info.split.aux_data = ecx;	/* stash active mask */
+	info.split.num_pmcs = ebx.split.num_umc_pmc;
+	info.split.gid = topology_die_id(cpu);
+	info.split.cid = topology_die_id(cpu);
+	*per_cpu_ptr(uncore->info, cpu) = info;
+}
+
+static
+int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
+{
+	DECLARE_BITMAP(gmask, UNCORE_GROUP_MAX) = { 0 };
+	u8 group_num_pmus[UNCORE_GROUP_MAX] = { 0 };
+	u8 group_num_pmcs[UNCORE_GROUP_MAX] = { 0 };
+	union amd_uncore_info info;
+	struct amd_uncore_pmu *pmu;
+	int index = 0, gid, i;
+
+	if (pmu_version < 2)
+		return 0;
+
+	/* Run just once */
+	if (uncore->init_done)
+		return amd_uncore_ctx_init(uncore, cpu);
+
+	/* Find unique groups */
+	for_each_online_cpu(i) {
+		info = *per_cpu_ptr(uncore->info, i);
+		gid = info.split.gid;
+		if (test_bit(gid, gmask))
+			continue;
+
+		__set_bit(gid, gmask);
+		group_num_pmus[gid] = hweight32(info.split.aux_data);
+		group_num_pmcs[gid] = info.split.num_pmcs;
+		uncore->num_pmus += group_num_pmus[gid];
+	}
+
+	uncore->pmus = kzalloc(sizeof(*uncore->pmus) * uncore->num_pmus,
+			       GFP_KERNEL);
+	if (!uncore->pmus) {
+		uncore->num_pmus = 0;
+		goto done;
+	}
+
+	for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
+		for (i = 0; i < group_num_pmus[gid]; i++) {
+			pmu = &uncore->pmus[index];
+			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
+			pmu->num_counters = group_num_pmcs[gid] / group_num_pmus[gid];
+			pmu->msr_base = MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
+			pmu->rdpmc_base = -1;
+			pmu->group = gid;
+
+			pmu->ctx = alloc_percpu(struct amd_uncore_ctx *);
+			if (!pmu->ctx)
+				goto done;
+
+			pmu->pmu = (struct pmu) {
+				.task_ctx_nr	= perf_invalid_context,
+				.attr_groups	= amd_uncore_umc_attr_groups,
+				.name		= pmu->name,
+				.event_init	= amd_uncore_umc_event_init,
+				.add		= amd_uncore_add,
+				.del		= amd_uncore_del,
+				.start		= amd_uncore_umc_start,
+				.stop		= amd_uncore_stop,
+				.read		= amd_uncore_read,
+				.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+				.module		= THIS_MODULE,
+			};
+
+			if (perf_pmu_register(&pmu->pmu, pmu->pmu.name, -1)) {
+				free_percpu(pmu->ctx);
+				pmu->ctx = NULL;
+				goto done;
+			}
+
+			pr_info("%d %s counters detected\n", pmu->num_counters,
+				pmu->pmu.name);
+
+			index++;
+		}
+	}
+
+done:
+	uncore->num_pmus = index;
+	uncore->init_done = true;
+
+	return amd_uncore_ctx_init(uncore, cpu);
+}
+
 static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 	/* UNCORE_TYPE_DF */
 	{
@@ -850,6 +997,13 @@ static struct amd_uncore uncores[UNCORE_TYPE_MAX] = {
 		.move = amd_uncore_ctx_move,
 		.free = amd_uncore_ctx_free,
 	},
+	/* UNCORE_TYPE_UMC */
+	{
+		.scan = amd_uncore_umc_ctx_scan,
+		.init = amd_uncore_umc_ctx_init,
+		.move = amd_uncore_ctx_move,
+		.free = amd_uncore_ctx_free,
+	},
 };
 
 static int __init amd_uncore_init(void)
diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 1d111350197f..dc159acb350a 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -637,6 +637,10 @@
 /* AMD Last Branch Record MSRs */
 #define MSR_AMD64_LBR_SELECT			0xc000010e
 
+/* Fam 19h MSRs */
+#define MSR_F19H_UMC_PERF_CTL		0xc0010800
+#define MSR_F19H_UMC_PERF_CTR		0xc0010801
+
 /* Fam 17h MSRs */
 #define MSR_F17H_IRPERF			0xc00000e9
 
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 85a9fd5a3ec3..2618ec7c3d1d 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -112,6 +112,13 @@
 	(AMD64_PERFMON_V2_EVENTSEL_EVENT_NB	|	\
 	 AMD64_PERFMON_V2_EVENTSEL_UMASK_NB)
 
+#define AMD64_PERFMON_V2_ENABLE_UMC			BIT_ULL(31)
+#define AMD64_PERFMON_V2_EVENTSEL_EVENT_UMC		GENMASK_ULL(7, 0)
+#define AMD64_PERFMON_V2_EVENTSEL_RDWRMASK_UMC		GENMASK_ULL(9, 8)
+#define AMD64_PERFMON_V2_RAW_EVENT_MASK_UMC		\
+	(AMD64_PERFMON_V2_EVENTSEL_EVENT_UMC	|	\
+	 AMD64_PERFMON_V2_EVENTSEL_RDWRMASK_UMC)
+
 #define AMD64_NUM_COUNTERS				4
 #define AMD64_NUM_COUNTERS_CORE				6
 #define AMD64_NUM_COUNTERS_NB				4
@@ -232,6 +239,8 @@ union cpuid_0x80000022_ebx {
 		unsigned int	lbr_v2_stack_sz:6;
 		/* Number of Data Fabric Counters */
 		unsigned int	num_df_pmc:6;
+		/* Number of Unified Memory Controller Counters */
+		unsigned int	num_umc_pmc:6;
 	} split;
 	unsigned int		full;
 };
-- 
2.34.1

