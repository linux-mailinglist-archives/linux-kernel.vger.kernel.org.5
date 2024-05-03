Return-Path: <linux-kernel+bounces-167306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDC78BA783
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439EC1F220B3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33C2A1482FA;
	Fri,  3 May 2024 07:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xOswEqQH"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598211474BE;
	Fri,  3 May 2024 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720652; cv=fail; b=arXotjkQwoegpThm8fFvUK+RZhrxz/YEMniJSsQROcgzIMN/ewF4TZehZk2/Wlv4q57JXUXamewZHkSdJ2qYhYin6PvjHvdm1RUPIetCVEU4zXHiQhwKTH1TWjjh8QKaYyY7aDMdPQvOyxqCBaGODAc7WPfEPyA2Eu6pEOb8daI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720652; c=relaxed/simple;
	bh=sANZw0zs96S03yCMJwoYKyp/SVei6J8Mju6/kBsA7PQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LldureA0Rm05CnyI/ZoURN5fuiTpv2pjcJySV5P2ozlw8WvD9XAGUidbphz0rxZDczyLmEc77ZLjVUqEWHWyQCBzJVYJk+2cP2UmgKJfWNlm35Ug3uM0sqDE4JY6e1NKdsFwf1FCo+XAtY+jK8Gtt9iUKDLgvrsBVolNM3RxqMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOswEqQH; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5InHGhjVRPV5wIyycFEEz4mCA8jUxi0cXmth98s+qfSH3c6LW4Z47Jj2qQ1WsUAXKD+LKnKbetgIEvyzb1FlYq8u8gAfOz19xDgYNunuLggbZIr3MHHCZVzcG3AgpHWWABlfzykzq39uXSQfepaLeKpNxHagwudI0S9svGE5yshPLoBjuP0sl9vTKpliEuZOYxkefl4fyg69+5aRpDxDypdKrj6Td5Lep9xHhkO+ZAvnjmg7Qlu8O4RMe4oNu+E+hAOaPeyhKmQVqda7by254d/ii+84mOzxyQWHXY5ydmTPgfZ+OCKqhVFTDiISf7J85ggM4dJomTI8Wkqfge/Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPcHFvR8tYdWbDLpk3X9RCwb/K9O4f7pW0jWvdsu9VQ=;
 b=Z7N2vNSuNZiQTz96NlCETrPzy45ozqa87FmyxyynN/Thl0gwl8yYVxG7RMPOcmEUCk03RX07LS79YNqzG6RnQxfVn4u9ytoCtusNxxjqZ9/NfIgbO96JgxjWhOHeJ014FpwHhdkKFAwREMBO9ZTEE+r+J8XXWPmShcMCgsZXlAM40yHYPRfAkx2fsgt+w754uaiEGW7p+Kq2FNCrGSb2eVzpZNqy+gTcIupIPQ1mjnIa4uwwn4l6xNqGpDq7wJmEfK98MXSx4zyHIEhaNy+BdGNyS69FW5uRY88C5LbqhJbsVCNno0wZwIxjlfOAv/MTmmaIdCRSBCsNgCuAj6zjVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dPcHFvR8tYdWbDLpk3X9RCwb/K9O4f7pW0jWvdsu9VQ=;
 b=xOswEqQHhUmxMRjBj3ZBXvDz38lLNop5akgu+03iWzwqvMGdISKH+Td2bSgdniTU2xTDVilTEyas3D+S+hyUvCIIEIXmWDKXCZspcLxGf00EItonbDLb9cfw5JmdljTJNVixmLS0PJZOJGiLQjCPu7P4U1ABEU6fZGa36mp9glM=
Received: from CH2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:610:54::20)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.43; Fri, 3 May
 2024 07:17:27 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::33) by CH2PR11CA0010.outlook.office365.com
 (2603:10b6:610:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 07:17:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 07:17:26 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 02:17:21 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 3/4] perf vendor events amd: Add Zen 5 metrics
Date: Fri, 3 May 2024 12:46:21 +0530
Message-ID: <ee21ff77d89efa99997d3c2ebeeae22ddb6e7e12.1714717230.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1714717230.git.sandipan.das@amd.com>
References: <cover.1714717230.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 294deeeb-f2b4-4daf-c721-08dc6b41162a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n7+wcAAyKD099a5kFodHOQAp8Yig4xPqmBtvvSLj3N3RNsR2PJzbZiI+yXV/?=
 =?us-ascii?Q?u12edc8nAUeMVkrM/bu3UE8hPjyiEVRO6dT8nnHNp3bRbUfo20uj2BHZoY4U?=
 =?us-ascii?Q?rDLLGFobwaRZ3MB43/YG+FkkTqOfKdV/RE2SpAiHEbe8WCZJ30z5gtcwzw66?=
 =?us-ascii?Q?vnI7C1ih5J6SQFEo1N5Mv21avWMfIRXahMm6obO4L1pFL16w2DTqYHmH+ZsP?=
 =?us-ascii?Q?YgRD4L+Rz0Tm9hpd+XAolfgcKkIogh7kzUeNloT9ykdSLheWQYNYpCYeAGXT?=
 =?us-ascii?Q?FsksDQ1Yu9wjPtXgc5aWZy94CXy8RFaOALrzCOxUJ/QTo9JNxh5qTyQXvzKU?=
 =?us-ascii?Q?M5fjWfzVR3Tor3swkVAMujXzJyIcSriE90Fai/1DOERqRscU8xCpCIUYM7KG?=
 =?us-ascii?Q?NLsV6nskOYk/6E+GrApD9/Pc6CPVikt5kDp6JHOBgld8FzQ4CwLv2v3AUlMh?=
 =?us-ascii?Q?dv7E/z6WQeAbLkrvYKaYDG6sQc39abmpeAZwjMFiIpKu8uV9Nq9TH5cHqgJP?=
 =?us-ascii?Q?/bbPWDLSmQXJ5CQmnxCV59etkEmMYgxUEe5K/XNUKtfmkFOGLrqLAmnoA7hT?=
 =?us-ascii?Q?hYuQZORCOxPkQTpGC5C7fxsgN3OjNaAJJS8BN++LtsGqL7pIRr+uEgkqmO6D?=
 =?us-ascii?Q?aFzBXfdgmUPSwW/GR9M6jbLDRttJWhWiMbDOw2eMR1+9geTijP/D9CGW+kK3?=
 =?us-ascii?Q?LL3rTctX9X2eL/vhCML8KRt4lTpLHm3FgUx9NGZO0HtTkPrMxwf7QYyfMTOI?=
 =?us-ascii?Q?gi52LI8H9Tx1LC25CdB/BXG8W7w8YfUD6v6aDushGX4Jweb4J3ubrsmxeSGa?=
 =?us-ascii?Q?szBvDZ99NyQrY9BHCXeSj710mTIa8yGqYRIp7X19pS7TG1UBhkoapfQY3Wp1?=
 =?us-ascii?Q?N0cq9U8jd8eKEr2t590zRnRnbNVutZauCe5THxGOVpQhRXAaCbKb7ofO3Mjj?=
 =?us-ascii?Q?BwZsBAcAfjun0Qbal8Uh4m2x0mgxGayZSv57gdfLjujf/pFmjIFTyFdSSHdk?=
 =?us-ascii?Q?j8E55FgxiM55mRzROwyl5Y3qcsYFOesHK/aIXb+5lkLm31TkBRZmZnVab7k2?=
 =?us-ascii?Q?84psrlVIn30nqa4DF4GlwRQaWAYLk5mUmx3o1Vdh02dkkAzwkJAyY+C/q2uJ?=
 =?us-ascii?Q?aQJF/YRhtLFBevA3UzdjAUNkQigot38euJsAbo2ZwTAinUyFaJSIE9Wraafo?=
 =?us-ascii?Q?hmsnnvksBWIDjFlMK+5M51+lorMpCOZvN2v1wOIuaapKW64+OtW17+fod0WY?=
 =?us-ascii?Q?ItMTyqInPCHti5foAO9SSUkfud/J8KZ20WXy1lehclHmi9ONhduIHopwOmGN?=
 =?us-ascii?Q?EbwnXduou/AzUnk8GkOct5ia?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:17:26.6841
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 294deeeb-f2b4-4daf-c721-08dc6b41162a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322

Add metrics taken from Section 1.2 "Performance Measurement" of the
Performance Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors
document available at the link below.

The recommended metrics are sourced from Table 1 "Guidance for Common
Performance Statistics with Complex Event Selects".

The pipeline utilization metrics are sourced from Table 2 "Guidance
for Pipeline Utilization Analysis Statistics". These are useful for
finding performance bottlenecks by analyzing activity at different
stages of the pipeline. There are metric groups available for Level 1
and Level 2 analysis.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen5/pipeline.json |  99 +++++
 .../arch/x86/amdzen5/recommended.json         | 345 ++++++++++++++++++
 2 files changed, 444 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
new file mode 100644
index 000000000000..d860bf599cf2
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
@@ -0,0 +1,99 @@
+[
+  {
+    "MetricName": "total_dispatch_slots",
+    "BriefDescription": "Total dispatch slots (up to 8 instructions can be dispatched in each cycle).",
+    "MetricExpr": "8 * ls_not_halted_cyc",
+    "ScaleUnit": "1slots"
+  },
+  {
+    "MetricName": "frontend_bound",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "bad_speculation",
+    "BriefDescription": "Percentage of dispatched ops that did not retire.",
+    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "backend_bound",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of backend stalls.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "smt_contention",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because the other thread was selected.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring",
+    "BriefDescription": "Percentage of dispatch slots used by ops that retired.",
+    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "frontend_bound_by_latency",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
+    "MetricExpr": "d_ratio((8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "frontend_bound_by_bandwidth",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "bad_speculation_from_mispredicts",
+    "BriefDescription": "Percentage of dispatched ops that were flushed due to branch mispredicts.",
+    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + bp_redirects.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "bad_speculation_from_pipeline_restarts",
+    "BriefDescription": "Percentage of dispatched ops that were flushed due to pipeline restarts (resyncs).",
+    "MetricExpr": "d_ratio(bad_speculation * bp_redirects.resync, ex_ret_brn_misp + bp_redirects.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%ops"
+  },
+  {
+    "MetricName": "backend_bound_by_memory",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of stalls due to the memory subsystem.",
+    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "backend_bound_by_cpu",
+    "BriefDescription": "Percentage of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
+    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring_from_fastpath",
+    "BriefDescription": "Percentage of dispatch slots used by fastpath ops that retired.",
+    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%slots"
+  },
+  {
+    "MetricName": "retiring_from_microcode",
+    "BriefDescription": "Percentage of dispatch slots used by microcode ops that retired.",
+    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%slots"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
new file mode 100644
index 000000000000..c97874039c1e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
@@ -0,0 +1,345 @@
+[
+  {
+    "MetricName": "branch_misprediction_rate",
+    "BriefDescription": "Execution-time branch misprediction rate (non-speculative).",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "1per_branch"
+  },
+  {
+    "MetricName": "all_data_cache_accesses_pti",
+    "BriefDescription": "All data cache accesses per thousand instructions.",
+    "MetricExpr": "ls_dispatch.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses_pti",
+    "BriefDescription": "All L2 cache accesses per thousand instructions.",
+    "MetricExpr": "(l2_request_g1.all_no_prefetch + l2_pf_hit_l2.l2_hwpf + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_ic_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 instruction cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.cacheable_ic_read / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_dc_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 data cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.all_dc / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache accesses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_hit_l2.l1_dc_l2_hwpf + l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_misses_pti",
+    "BriefDescription": "All L2 cache misses per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_fill_miss / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache misses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l2_cache_hits_pti",
+    "BriefDescription": "All L2 cache hits per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "l2_pf_hit_l2.l1_dc_l2_hwpf / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l3_cache_accesses",
+    "BriefDescription": "L3 cache accesses.",
+    "MetricExpr": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_misses",
+    "BriefDescription": "L3 misses (including cacheline state change requests).",
+    "MetricExpr": "l3_lookup_state.l3_miss",
+    "MetricGroup": "l3_cache"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 read miss latency (in core clocks).",
+    "MetricExpr": "(l3_xi_sampled_latency.all * 10) / l3_xi_sampled_latency_requests.all",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_local_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for local DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_near * 10) / l3_xi_sampled_latency_requests.dram_near",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_remote_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for remote DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_far * 10) / l3_xi_sampled_latency_requests.dram_far",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1ns"
+  },
+  {
+    "MetricName": "op_cache_fetch_miss_ratio",
+    "BriefDescription": "Op cache miss ratio for all fetches.",
+    "MetricExpr": "d_ratio(op_cache_hit_miss.op_cache_miss, op_cache_hit_miss.all_op_cache_accesses)",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "ic_fetch_miss_ratio",
+    "BriefDescription": "Instruction cache miss ratio for all fetches. An instruction cache miss will not be counted by this metric if it is an OC hit.",
+    "MetricExpr": "d_ratio(ic_tag_hit_miss.instruction_cache_miss, ic_tag_hit_miss.all_instruction_cache_accesses)",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_memory_pti",
+    "BriefDescription": "L1 data cache fills from DRAM or MMIO in any NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.dram_io_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_remote_node_pti",
+    "BriefDescription": "L1 data cache fills from a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.far_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.local_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_different_ccx_pti",
+    "BriefDescription": "L1 data cache fills from another CCX cache in any NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.remote_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_l1_data_cache_fills_pti",
+    "BriefDescription": "All L1 data cache fills per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_local_l2_pti",
+    "BriefDescription": "L1 demand data cache fills from local L2 cache per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2 / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 demand data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_itlb_misses_pti",
+    "BriefDescription": "L1 instruction TLB misses per thousand instructions.",
+    "MetricExpr": "(bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss.all) / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_itlb_misses_pti",
+    "BriefDescription": "L2 instruction TLB misses and instruction page walks per thousand instructions.",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l1_dtlb_misses_pti",
+    "BriefDescription": "L1 data TLB misses per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "l2_dtlb_misses_pti",
+    "BriefDescription": "L2 data TLB misses and data page walks per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "all_tlbs_flushed_pti",
+    "BriefDescription": "All TLBs flushed per thousand instructions.",
+    "MetricExpr": "ls_tlb_flush.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3per_1k_instr"
+  },
+  {
+    "MetricName": "macro_ops_dispatched",
+    "BriefDescription": "Macro-ops dispatched.",
+    "MetricExpr": "de_src_op_disp.all",
+    "MetricGroup": "decoder"
+  },
+  {
+    "MetricName": "sse_avx_stalls",
+    "BriefDescription": "Mixed SSE/AVX stalls.",
+    "MetricExpr": "fp_disp_faults.sse_avx_all"
+  },
+  {
+    "MetricName": "macro_ops_retired",
+    "BriefDescription": "Macro-ops retired.",
+    "MetricExpr": "ex_ret_ops"
+  },
+  {
+    "MetricName": "umc_data_bus_utilization",
+    "BriefDescription": "Memory controller data bus utilization.",
+    "MetricExpr": "d_ratio(umc_data_slot_clks.all / 2, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_write_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for writes.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.wr, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_mem_read_bandwidth",
+    "BriefDescription": "Estimated memory read bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.rd * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_write_bandwidth",
+    "BriefDescription": "Estimated memory write bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.wr * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_mem_bandwidth",
+    "BriefDescription": "Estimated combined memory bandwidth.",
+    "MetricExpr": "(umc_cas_cmd.all * 64) / 1e6 / duration_time",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1MB/s"
+  },
+  {
+    "MetricName": "umc_activate_cmd_rate",
+    "BriefDescription": "Memory controller ACTIVATE command rate.",
+    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  },
+  {
+    "MetricName": "umc_precharge_cmd_rate",
+    "BriefDescription": "Memory controller PRECHARGE command rate.",
+    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "1per_memclk"
+  }
+]
-- 
2.34.1


