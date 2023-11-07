Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4537E36B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbjKGIeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 03:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbjKGIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 03:34:17 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BECC0F3;
        Tue,  7 Nov 2023 00:34:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFR9MIHeXGm0ryN+KNtENWODVGGhNEgFXhAiWdL1rmn24QYukGL2L8Ug5FQlZBPGZ+kCIxkXHw3HpyC/GPKmxKE3JERaOE09wA2+mrfIksHH4gCHAwi9/QS+bfGOIiKl7OcQC1bYwcIxvc1OUeryN3/GOSPC0HWIgTHgFR8RhKMQ83hoXOfiYxHQvh97PO2PJKmx2pVrj8+rYZXlPRkgTfSf4dGmuO+kO0QbYVli5WOBPpQ7NzixE5g5KyFt/3PindRjym3SNTswkOHPaUDGpOMXEhw8IQ4D+RjTri4+IHATXMoQkT2VEairFWeLFxn60VA1ML1a1u/NhDJHgflbyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bOhHTikOsoF0CTkdslwXiC8q/bD6hc7xxoisvKv8U08=;
 b=RkyZgTjJP22cHv0rFQ193E+6O1ww7ucbokyRS2A4Izbh1YMOt3lVZRNpxZGtt8kwIua8TlOIpZjtbY7QiKDbxP0f27iZNegjdRahfYaHfQt6ylVH0kGV57bmBb79Ez0kCZyjAWWxzF2e9l+znZoHzNOlInixPX9/jSriSx7laxX7Swkcq/ioJhj685q9IBLfPXrm0bItdSgsJ1wk6P1vFL/WZ0qKfFIXJ1DEyQWmRUwEdS2jt1lhQcpEmcPlebQFancSPsAi1pGteYCB+EW7GGBoILerBaM+uPtdv47PF1GcNuTSmiUvEUvy9NayezbtB8yRS1qXMa9eSJTwyeMREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bOhHTikOsoF0CTkdslwXiC8q/bD6hc7xxoisvKv8U08=;
 b=R84rzsicILneBKEUBPfZ0tNMLP8/SVptGeG3DM6aoxoWeUPYEF1MOhX61QIFQ8TwG3ApGKcXWXxsx8cnAbFFLbfPqE3SiR4NauydkcdFjjOj9YWTkEF8FPxo/rLuZoCbc7fwyA1StO0opo9U3i13oFn+g/A9GTTePtcWpcqAIY0=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by CY8PR12MB7241.namprd12.prod.outlook.com (2603:10b6:930:5a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 08:34:11 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:408:13f:cafe::87) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29 via Frontend
 Transport; Tue, 7 Nov 2023 08:34:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Tue, 7 Nov 2023 08:34:10 +0000
Received: from BLR-5CG113396H.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 7 Nov
 2023 02:34:03 -0600
From:   Ravi Bangoria <ravi.bangoria@amd.com>
To:     <acme@kernel.org>, <namhyung@kernel.org>
CC:     <ravi.bangoria@amd.com>, <kim.phillips@amd.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
        <irogers@google.com>, <adrian.hunter@intel.com>,
        <kan.liang@linux.intel.com>, <changbin.du@huawei.com>,
        <yangjihong1@huawei.com>, <zwisler@chromium.org>,
        <wangming01@loongson.cn>, <chenhuacai@kernel.org>,
        <kprateek.nayak@amd.com>, <linux-perf-users@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sandipan.das@amd.com>,
        <ananth.narayan@amd.com>, <santosh.shukla@amd.com>
Subject: [PATCH 2/2] perf header: Additional note on AMD IBS for max_precise pmu cap
Date:   Tue, 7 Nov 2023 14:03:31 +0530
Message-ID: <20231107083331.901-2-ravi.bangoria@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231107083331.901-1-ravi.bangoria@amd.com>
References: <20231107083331.901-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|CY8PR12MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: c9376233-6d3a-43d5-5147-08dbdf6c50d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TAaPcx5/PuoHe3WQa4Z9K6dDNwpxTCkjGo2QSgewS6NrcUTKhn4WpeM22Plx6uJakv78YEWS5TRbj5s+GLYlmyt7nRw2ga5J0g8EXLXWY2QPOsJVb21OSGzU79VgbulGHnfHn6HsU7DmCVFjdvujgj3HS5hDnWQNc3xEF6T6GTqxsXm9e1cLB/pzbJJp4Oc1A+gH65kjGX0cPtL7DnY1H5D5obEkShhh92u8Ojh8mOFp4r9WC6Y4UO4GeYlhoNBT0YztCzSpKJo/QnLS4rCkKHXxQRFOw6Muv0VstgRJHjmLfFycdh4AZloaMdIGD/s790IRm5JDCjhiVMwUnPxPpMf8upZbjaMwIbwOcSo+DY8lFIMKJ/Bx6l9bcVIQ4br3zicrRZm+pQU/0z3b2YhNqEy+RBKUod060O7z6YYMSyC50h6c++teUpz/6hyCJj5G92cth4qycsYNaU7nBop9a8FPQgaq478WbFAUqCdRxIkTRV2/pQmN9HiEaae80Ydh5Yb2arCc9YU/UmmtfCUQ0yUMw2jr+604UoaRWf77pBJE9YFs8kWTPag4VeBP2B4hxsGrs7KjTO5osugYg7TkYflFJfxbu4E6Scqewc+c+w4vXSvgb6whCe4ApY7AERaO8PyF329Ya77X+WF0YO4z769OTwl0xis1tl4S1+Tc6BWH59dRVexToK0nGViZw3cZSVHhSPzjMBI8aOSAUq+5bengRLoX3aIPywcfx+yrVBTsxZJWZ0rIzk6Jq9GvV2VIp5K7A+nic2RpOdcxmEoKDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(82310400011)(64100799003)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2616005)(478600001)(6666004)(7696005)(36860700001)(36756003)(86362001)(81166007)(356005)(82740400003)(7416002)(5660300002)(54906003)(70586007)(70206006)(16526019)(336012)(47076005)(83380400001)(26005)(2906002)(41300700001)(426003)(1076003)(110136005)(44832011)(316002)(8676002)(4326008)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 08:34:10.8248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9376233-6d3a-43d5-5147-08dbdf6c50d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7241
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@kernel.org>

x86 core pmu exposes supported maximum precision level via max_precise
pmu capability. Although, AMD core pmu does not support precise mode,
certain core pmu events with precise_ip > 0 are allowed and forwarded
to IBS OP pmu. Display a note about this in perf report header and
document the details in the perf-list man page.

Signed-off-by: Arnaldo Carvalho de Melo <acme@kernel.org>
Signed-off-by: Ravi Bangoria <ravi.bangoria@amd.com>
---
 tools/perf/Documentation/perf-list.txt | 12 +++++++-----
 tools/perf/util/env.c                  | 18 ++++++++++++++++++
 tools/perf/util/env.h                  |  2 ++
 tools/perf/util/header.c               |  8 ++++++++
 4 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Documentation/perf-list.txt
index d5f78e125efe..1b90575ee3c8 100644
--- a/tools/perf/Documentation/perf-list.txt
+++ b/tools/perf/Documentation/perf-list.txt
@@ -81,11 +81,13 @@ For Intel systems precise event sampling is implemented with PEBS
 which supports up to precise-level 2, and precise level 3 for
 some special cases
 
-On AMD systems it is implemented using IBS (up to precise-level 2).
-The precise modifier works with event types 0x76 (cpu-cycles, CPU
-clocks not halted) and 0xC1 (micro-ops retired). Both events map to
-IBS execution sampling (IBS op) with the IBS Op Counter Control bit
-(IbsOpCntCtl) set respectively (see the
+On AMD systems it is implemented using IBS OP (up to precise-level 2).
+Unlike Intel PEBS which provides levels of precision, AMD core pmu is
+inherently non-precise and IBS is inherently precise. (i.e. ibs_op//,
+ibs_op//p, ibs_op//pp and ibs_op//ppp are all same). The precise modifier
+works with event types 0x76 (cpu-cycles, CPU clocks not halted) and 0xC1
+(micro-ops retired). Both events map to IBS execution sampling (IBS op)
+with the IBS Op Counter Control bit (IbsOpCntCtl) set respectively (see the
 Core Complex (CCX) -> Processor x86 Core -> Instruction Based Sampling (IBS)
 section of the [AMD Processor Programming Reference (PPR)] relevant to the
 family, model and stepping of the processor being used).
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 44140b7f596a..cbc18b22ace5 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -531,6 +531,24 @@ int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu)
 	return cpu.cpu >= 0 && cpu.cpu < env->nr_numa_map ? env->numa_map[cpu.cpu] : -1;
 }
 
+bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name)
+{
+	char *pmu_mapping = env->pmu_mappings, *colon;
+
+	for (int i = 0; i < env->nr_pmu_mappings; ++i) {
+		if (strtoul(pmu_mapping, &colon, 0) == ULONG_MAX || *colon != ':')
+			goto out_error;
+
+		pmu_mapping = colon + 1;
+		if (strcmp(pmu_mapping, pmu_name) == 0)
+			return true;
+
+		pmu_mapping += strlen(pmu_mapping) + 1;
+	}
+out_error:
+	return false;
+}
+
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap)
 {
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..56aea562c61b 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -174,4 +174,6 @@ struct btf_node *perf_env__find_btf(struct perf_env *env, __u32 btf_id);
 int perf_env__numa_node(struct perf_env *env, struct perf_cpu cpu);
 char *perf_env__find_pmu_cap(struct perf_env *env, const char *pmu_name,
 			     const char *cap);
+
+bool perf_env__has_pmu_mapping(struct perf_env *env, const char *pmu_name);
 #endif /* __PERF_ENV_H */
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index e86b9439ffee..3cc288d14002 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -2145,6 +2145,14 @@ static void print_pmu_caps(struct feat_fd *ff, FILE *fp)
 		__print_pmu_caps(fp, pmu_caps->nr_caps, pmu_caps->caps,
 				 pmu_caps->pmu_name);
 	}
+
+	if (strcmp(perf_env__arch(&ff->ph->env), "x86") == 0 &&
+	    perf_env__has_pmu_mapping(&ff->ph->env, "ibs_op")) {
+		char *max_precise = perf_env__find_pmu_cap(&ff->ph->env, "cpu", "max_precise");
+
+		if (max_precise != NULL && atoi(max_precise) == 0)
+			fprintf(fp, "# AMD systems uses ibs_op// PMU for some precise events, e.g.: cycles:p, see the 'perf list' man page for further details.\n");
+	}
 }
 
 static void print_pmu_mappings(struct feat_fd *ff, FILE *fp)
-- 
2.41.0

