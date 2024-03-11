Return-Path: <linux-kernel+bounces-98471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF914877A8B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F30531C21403
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176969446;
	Mon, 11 Mar 2024 05:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U1+uLZHd"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88AB8F41;
	Mon, 11 Mar 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134668; cv=fail; b=KaWUMbOrlF4tkRhFDIwjs7m4H6abLRtxEMWQNbdOdRIyQ3vA/sHA273jonBoAB9JTmygc2sJ0QxXt/no/rbE3pCG2Hd3oJpx6xQuPc0vgl1DxQqHSQae5abS/YfvODWkMINa0AeaSfBIUhbaHe7NByOh4pYQsjRcMZMNQQzYY0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134668; c=relaxed/simple;
	bh=2d9OS0Evc5f8gd9aqnRwqQXJNCuPfki9teo4E6D5ouQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UxeoPxDHRnU748rrMixchnuNjrnTJd6ZkdHt5h7z32v/gf2kA6/vL4SGupPhvSJ23jfkCfYJQHxlUFaDSdA9iY7ojzxvcmuKeZfS8rEZ6UjKcuFmHITi79E4h4jM0BdYRuSCxKgT544ZDLcGXiw2EPsHLku4IShJ/cEsFUZEY2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U1+uLZHd; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igg5VQshRn4i/ILNAxFoXTfM45ZaAK7LiJkwM5gEG/4/ub+OvMbdJTT59l0nYdM26iNsF8AJzmM864UQhxWRrnqh0ITOfKTWCN3LjU0uKtxYHXrJQMvwVrIVR5VUcRJxPQ3vbWa/b3CNW9QZNPglEEUNHxe94uAmjjKhmhJqe4xM36fFCRwhW3JPY+GXxgIpeA1kvozIW1xCNXcxEeAdfWfn+drBVYsvZLDHh/QFvzmEBsMaWWumLWCkapS44495yjG2xAYjeBStlehwbd+oC5HC674Ynr8hbYLTYVI6CCz0vw0rbGu5nMpJaKO1BuWhehF2taBEHjjMDO8jBG8EYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2bfgA2bu20dr6qIZjZof6WK+txAjgULEdL2PxmLZuKc=;
 b=ZuU0EbaLmivxYhJ/FcS6ElgxgY1FIhwKJU9Ub6wVcykndD5uVYcrViCksXagBbO+RpXdjVzoFehQmsSrkYxmw/2wuTQHfny8wP1KxVOGMzUmUgOhj7LuX84jeRiaJd2WAs1A3U0PZaE8JEDvDEETLmABEwcqtLG3qttdGpWVi9s5dnlhFawP98xrFY3lj9an/DQbURAl33fKAAHV3Wpt6AAw8lF1sPWdZ9ndtNUbcQ5e5R3ZM49PSv44oCNwzciLUmHldrTPmt5psrxBLw9tu0vVsJNVuRC1JTZRc7B5FOMwejLJhamqlGYqJusjC1K+LjFf//4OE3b2G5YjuDyIYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2bfgA2bu20dr6qIZjZof6WK+txAjgULEdL2PxmLZuKc=;
 b=U1+uLZHdyANl8pkHOkwSTtrcSfp0OmYyuDF5hhJ31q1Q+bzq4xQLsL/Lqfr8roSAc/I7GwwOy5qo8WQS2DOSyZ48YBcEwDILWVohC800VDk5IGkIQLo5hS80canm2sz0ETk8h2c1GYJfovk+thtPanQTArPlHh9nySbZEXdLC3Y=
Received: from MN2PR01CA0025.prod.exchangelabs.com (2603:10b6:208:10c::38) by
 SA1PR12MB8843.namprd12.prod.outlook.com (2603:10b6:806:379::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.34; Mon, 11 Mar 2024 05:24:23 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::14) by MN2PR01CA0025.outlook.office365.com
 (2603:10b6:208:10c::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 05:24:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 11 Mar 2024 05:24:22 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 00:24:18 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 3/4] perf vendor events amd: Add Zen 5 metrics
Date: Mon, 11 Mar 2024 10:53:17 +0530
Message-ID: <017b0abebc24535e3e96fa9f9cc4ba4c11fffb57.1710133771.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1710133771.git.sandipan.das@amd.com>
References: <cover.1710133771.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|SA1PR12MB8843:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b945b02-05df-457f-466d-08dc418b8291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gCZqMncN7HYociuTz7w7ewmnT+mOPRQRiY5LALVyMnL/THf2i1lyIJbIQFdIJfgakBcf6Y0Sofxr9KlZGnYUMykYj45+aB7whSJaCjRuQh0a6cfjMHagOV1tGrNf8XUkqgdxIDs2oco6pV6b+533nZEmdFvLG+vVqjZi5dPJeEWZvMkUf1tFqvlLOZZM8DnAcmbMLED8JhM6ba/n2tj7+LB4sE1b6qrWiM+ME0ZjKcoSKl4kp0YRhkIPMwXtt91dIFsV4y2JTlcGWdZOu+MaOZA89WdGpma9tjwdYxeJelXLTy4N7GOPz5LKl6fTzSvbp7U3t7Y3IQjmPXWscXZgk/CVgXuuqN3+u22gan0xpAkk4Bstwl/EzbVZ7dwwChPDgv3UWm9rhXFQU9zzHT7xi23n5RT0DeWHyDnoqEU3ezM21qzooMMWmrsxnMx40z/vRGWeNaeZdzYlkyU/xeaucfe0wpXOGm3QP9Wf8pbh2lfY26drMHnVxqh6VvKWpSHZo9cMTMMK05puna7FY1zBfAJfND9Kimt8LFo55/pIfJlBXOgEYKuvjo2j32VkdLjbkD1X7JjzZW9/6Kd6i7baNik8EL0WMnhi7uzz4NRtruDGo9t9eEeJepblO+5ZC9fBXdRaPP4/ASutLSnjOoQ+oFoCcUd7/oAQ+C2tKvjQ+UYu+AkLydYIAJGqFtXD14gi
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:24:22.6117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b945b02-05df-457f-466d-08dc418b8291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8843

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
 .../pmu-events/arch/x86/amdzen5/pipeline.json |  98 +++++
 .../arch/x86/amdzen5/recommended.json         | 357 ++++++++++++++++++
 2 files changed, 455 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
new file mode 100644
index 000000000000..36dc76b793ae
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/pipeline.json
@@ -0,0 +1,98 @@
+[
+  {
+    "MetricName": "total_dispatch_slots",
+    "BriefDescription": "Total dispatch slots (up to 8 instructions can be dispatched in each cycle).",
+    "MetricExpr": "8 * ls_not_halted_cyc"
+  },
+  {
+    "MetricName": "frontend_bound",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because the frontend did not supply enough instructions/ops.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation",
+    "BriefDescription": "Fraction of dispatched ops that did not retire.",
+    "MetricExpr": "d_ratio(de_src_op_disp.all - ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of backend stalls.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.backend_stalls, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "smt_contention",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because the other thread was selected.",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.smt_contention, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring",
+    "BriefDescription": "Fraction of dispatch slots used by ops that retired.",
+    "MetricExpr": "d_ratio(ex_ret_ops, total_dispatch_slots)",
+    "MetricGroup": "PipelineL1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_latency",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a latency bottleneck in the frontend (such as instruction cache or TLB misses).",
+    "MetricExpr": "d_ratio((8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "frontend_bound_bandwidth",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of a bandwidth bottleneck in the frontend (such as decode or op cache fetch bandwidth).",
+    "MetricExpr": "d_ratio(de_no_dispatch_per_slot.no_ops_from_frontend - (8 * cpu@de_no_dispatch_per_slot.no_ops_from_frontend\\,cmask\\=0x8@), total_dispatch_slots)",
+    "MetricGroup": "PipelineL2;frontend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_mispredicts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to branch mispredicts.",
+    "MetricExpr": "d_ratio(bad_speculation * ex_ret_brn_misp, ex_ret_brn_misp + bp_redirects.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "bad_speculation_pipeline_restarts",
+    "BriefDescription": "Fraction of dispatched ops that were flushed due to pipeline restarts (resyncs).",
+    "MetricExpr": "d_ratio(bad_speculation * bp_redirects.resync, ex_ret_brn_misp + bp_redirects.resync)",
+    "MetricGroup": "PipelineL2;bad_speculation_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_memory",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls due to the memory subsystem.",
+    "MetricExpr": "backend_bound * d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete)",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "backend_bound_cpu",
+    "BriefDescription": "Fraction of dispatch slots that remained unused because of stalls not related to the memory subsystem.",
+    "MetricExpr": "backend_bound * (1 - d_ratio(ex_no_retire.load_not_complete, ex_no_retire.not_complete))",
+    "MetricGroup": "PipelineL2;backend_bound_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_fastpath",
+    "BriefDescription": "Fraction of dispatch slots used by fastpath ops that retired.",
+    "MetricExpr": "retiring * (1 - d_ratio(ex_ret_ucode_ops, ex_ret_ops))",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "retiring_microcode",
+    "BriefDescription": "Fraction of dispatch slots used by microcode ops that retired.",
+    "MetricExpr": "retiring * d_ratio(ex_ret_ucode_ops, ex_ret_ops)",
+    "MetricGroup": "PipelineL2;retiring_group",
+    "ScaleUnit": "100%"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
new file mode 100644
index 000000000000..986f8b2b2d5b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/recommended.json
@@ -0,0 +1,357 @@
+[
+  {
+    "MetricName": "branch_misprediction_ratio",
+    "BriefDescription": "Execution-time branch misprediction ratio (non-speculative).",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "all_data_cache_accesses_pti",
+    "BriefDescription": "All data cache accesses per thousand instructions.",
+    "MetricExpr": "ls_dispatch.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses_pti",
+    "BriefDescription": "All L2 cache accesses per thousand instructions.",
+    "MetricExpr": "(l2_request_g1.all_no_prefetch + l2_pf_hit_l2.l2_hwpf + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_ic_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 instruction cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.cacheable_ic_read / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l1_dc_misses_pti",
+    "BriefDescription": "L2 cache accesses from L1 data cache misses (including prefetch) per thousand instructions.",
+    "MetricExpr": "l2_request_g1.all_dc / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache accesses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_hit_l2.l1_dc_l2_hwpf + l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "all_l2_cache_misses_pti",
+    "BriefDescription": "All L2 cache misses per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3.l2_hwpf + l2_pf_miss_l2_l3.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_fill_miss / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache misses from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ls_rd_blk_c / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache misses from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "(l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf + l2_pf_miss_l2_l3.l1_dc_l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "all_l2_cache_hits_pti",
+    "BriefDescription": "All L2 cache hits per thousand instructions.",
+    "MetricExpr": "(l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2.l2_hwpf) / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_ic_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 instruction cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.ic_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l1_dc_miss_pti",
+    "BriefDescription": "L2 cache hits from L1 data cache misses per thousand instructions.",
+    "MetricExpr": "l2_cache_req_stat.dc_hit_in_l2 / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf_pti",
+    "BriefDescription": "L2 cache hits from L2 cache hardware prefetcher per thousand instructions.",
+    "MetricExpr": "l2_pf_hit_l2.l1_dc_l2_hwpf / instructions",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "1e3"
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
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_local_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for local DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_near * 10) / l3_xi_sampled_latency_requests.dram_near",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "l3_read_miss_latency_for_remote_dram",
+    "BriefDescription": "Average L3 read miss latency (in core clocks) for remote DRAM.",
+    "MetricExpr": "(l3_xi_sampled_latency.dram_far * 10) / l3_xi_sampled_latency_requests.dram_far",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
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
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_remote_node_pti",
+    "BriefDescription": "L1 data cache fills from a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.far_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.local_all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_data_cache_fills_from_different_ccx_pti",
+    "BriefDescription": "L1 data cache fills from another CCX cache in any NUMA node per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.remote_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "all_l1_data_cache_fills_pti",
+    "BriefDescription": "All L1 data cache fills per thousand instructions.",
+    "MetricExpr": "ls_any_fills_from_sys.all / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_local_l2_pti",
+    "BriefDescription": "L1 demand data cache fills from local L2 cache per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_l2 / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_same_ccx_pti",
+    "BriefDescription": "L1 demand data cache fills from within the same CCX per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.local_ccx / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.near_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_near_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in the same NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_near / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_cache_pti",
+    "BriefDescription": "L1 demand data cache fills from another CCX cache in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.far_cache / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_demand_data_cache_fills_from_far_memory_pti",
+    "BriefDescription": "L1 demand data cache fills from DRAM or MMIO in a different NUMA node per thousand instructions.",
+    "MetricExpr": "ls_dmnd_fills_from_sys.dram_io_far / instructions",
+    "MetricGroup": "l1_dcache",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_itlb_misses_pti",
+    "BriefDescription": "L1 instruction TLB misses per thousand instructions.",
+    "MetricExpr": "(bp_l1_tlb_miss_l2_tlb_hit + bp_l1_tlb_miss_l2_tlb_miss.all) / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_itlb_misses_pti",
+    "BriefDescription": "L2 instruction TLB misses and instruction page walks per thousand instructions.",
+    "MetricExpr": "bp_l1_tlb_miss_l2_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l1_dtlb_misses_pti",
+    "BriefDescription": "L1 data TLB misses per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "l2_dtlb_misses_pti",
+    "BriefDescription": "L2 data TLB misses and data page walks per thousand instructions.",
+    "MetricExpr": "ls_l1_d_tlb_miss.all_l2_miss / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3"
+  },
+  {
+    "MetricName": "all_tlbs_flushed_pti",
+    "BriefDescription": "All TLBs flushed per thousand instructions.",
+    "MetricExpr": "ls_tlb_flush.all / instructions",
+    "MetricGroup": "tlb",
+    "ScaleUnit": "1e3"
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
+    "PerPkg": "1"
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
+    "MetricName": "umc_cas_cmd_read_ratio",
+    "BriefDescription": "Ratio of memory controller CAS commands for reads.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.rd, umc_cas_cmd.all)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "umc_cas_cmd_rate",
+    "BriefDescription": "Memory controller CAS command rate.",
+    "MetricExpr": "d_ratio(umc_cas_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_activate_cmd_rate",
+    "BriefDescription": "Memory controller ACTIVATE command rate.",
+    "MetricExpr": "d_ratio(umc_act_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  },
+  {
+    "MetricName": "umc_precharge_cmd_rate",
+    "BriefDescription": "Memory controller PRECHARGE command rate.",
+    "MetricExpr": "d_ratio(umc_pchg_cmd.all * 1000, umc_mem_clk)",
+    "MetricGroup": "memory_controller",
+    "PerPkg": "1"
+  }
+]
-- 
2.34.1


