Return-Path: <linux-kernel+bounces-98470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB5E877A8A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 712E51C213A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E15AD2D;
	Mon, 11 Mar 2024 05:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zxSyzURS"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2082.outbound.protection.outlook.com [40.107.100.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C307489;
	Mon, 11 Mar 2024 05:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134650; cv=fail; b=HqjhwhmDk6udr6XZPQsswM9tL2lyaVwo3JHnSygt4zdG/9Onc9f0YH/9roiWVXgh4gDQT7KkTc3JHYpXuN/oZQ0C0qh9+WAfKbTHIDrL2mlYEEWea5jNhTS5jLf7ws3oyRzir52SIFK2wmSTpPx+g3K2yfY9OeUzTODUFHYK4ww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134650; c=relaxed/simple;
	bh=Ncj+hfcr1QLOz03TQa6enfgLG+PbH0RDclGyuTiiHac=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORNYdHJuLP7JuUGG5CWjggDIEJA6RorMua8pdk5MODV/TTCvzKpjSQZUod0cvvmyijiGJJhl9XNArQfZueY5QPt9AhSqjQRfzKzR35NBgsMK/hv6ujqhUbSt5iHxF9xtOM9Mx5o1q+aVRzSwuYMMv/agmmL98KjjhB3xUh/ZyqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zxSyzURS; arc=fail smtp.client-ip=40.107.100.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XbK/k4sjEI/EJf9Zhfr3hFg0pW6vfEVo9g9EsOhZrqLEmqKnCuCIPNjP3xsgF4GRds7M8Y1mGkYdgO3UPu8GRvVEGL8TBPZoD/cZUFQjDSZkg2cIhuuQUuxVydkImK3Vn/LU3zE/1bG7VVNfjPKdHcT12Ya7V4t5RdT3ewEA0/6lXm8azQszshN37p3R6O+tGoZznrr/Y74q3MAzFQuGPxZJQmlw7ApFOd7H5ChDq/7YKaniCSMp1VdCxE9p76irryqjK7FyRT3KrJTfqL3I4NdF9erW5UY3kib2O7DiSNp8+H451Qm1fgc5h///DzZWLAnAh3JwGsls9Tv7qCnSBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YjQVk2acI/G9D6mGDnliyC27EZ74TEX+CrjzvSb628w=;
 b=PscS2yScmkKidaUdfiIr1foPrfWdohQg4668kJcIipbZUVpp9cTgude+YknQSkTFyQ9bgfP/PwC6A+wOcgAhIbCapu6SHQryWSEoAh0uFfks+L7J7APelcKyMJo1reAxHhRCxdCXHee1j1mtayAjifm6zDdH1+sRFOdy2CKltXNoTq8MOAu1Syqe7lO7vv5E/9U1MnSH46AGs1yG4YCAlygSttO5OoDAihFBHWCqVV8JBNVc913/6//B7aXrPuJe+ZgYkAnLcpXyFvtTbD6vEuU99+b3WLmLXGIfYZc8KYccM7wV5SqCDAjkjH9mrWim+INsTcWlnx1EUjn0+KVE4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YjQVk2acI/G9D6mGDnliyC27EZ74TEX+CrjzvSb628w=;
 b=zxSyzURSXdZ5PjR4Iolcx8WjvWR4nOm9qI0Rs/bSPj/UU9m3hYwE7525K9Mjz8/o1oouYeMqJ75VUz6BuzWd5OvgHWqQKMNJ2i2HcoAd992QBCg3cBf08HPaDnbXEItO29uZGUZAYwqln1fHTCsCOUhDAFyoN58hu3EHItcJgZk=
Received: from MN2PR01CA0018.prod.exchangelabs.com (2603:10b6:208:10c::31) by
 CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Mon, 11 Mar
 2024 05:24:05 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:10c:cafe::1a) by MN2PR01CA0018.outlook.office365.com
 (2603:10b6:208:10c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 05:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 11 Mar 2024 05:24:05 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 00:24:01 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 2/4] perf vendor events amd: Add Zen 5 uncore events
Date: Mon, 11 Mar 2024 10:53:16 +0530
Message-ID: <e100c902fd9e1e4f58e3a9c175d572962a9cdd50.1710133771.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|CH3PR12MB8909:EE_
X-MS-Office365-Filtering-Correlation-Id: aa6cfeb6-f5e0-48bf-a792-08dc418b7852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kYgp53b49D7NiifCC/TMcUTFXnN6aPp4pVBgQ9J85sOwB/e58/jknn2rKzTN9rXsD0IyWiEL+4S/IZNCk4kRN+17r3Saqx+5uAZVDPGybX2U98KNpb5cBLxjHxEC2ZnaZ7tk6HgNq9BdHqOvOYUfgA+cU2yGC/J7H9sYZcfLuPP1AxxtfqXwlRNHRM/R0YF4Zv4LmSfv4hiA/NdjIcj/0pMts48+3cWaRC3M2ZwPgI4J4ENSFr2fH67ooyPlOB9mk4p9MtqZtmEvRCinzd1dOEqgykRdILJMHWpzhTyFJgfIaS9IB4ChzroRdGEyr+O4/T2A/TVBF9+mtTFa/ZKsoBN0Ft6ZzcIqah7SF9d/xb7OciEs721fvMaKGV/xT9iIiS7Dgpoe/qCPLBHVdXFzGB7tuuTJhklPYWFdx7iEU4R9SBmZRkPDkwyF13Dh6Jwc71WxSSvX9Z2z8H70Q4nmovJGaBrvgpksY4gO1dDTryyRraDBxYSSj7tAA8GqbD6Hla7Fbt2XGT8kFmcXiuI6lzWmbapVRvLoPfreoBWCrXrTuH5KOb9mhYnqSgquyFprDGlrvBAXHMRvv3NLfXqlMq6RCRBFLwOi/3ZNFPh2pO6i1bA0hamouX2BNnVB1JKLVwkxxmy4k4olJ3AxFHrPI9N6FOODwxU4PcjgOnIyWKzRSfKXKrwrvNaG50FVPOKuCKDiGg6/xdu2CBnSsWTKwg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(82310400014)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:24:05.4241
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa6cfeb6-f5e0-48bf-a792-08dc418b7852
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8909

Add uncore events taken from Section 1.5 "L3 Cache Performance Monitor
Counters" and Section 2 "UMC Performance Monitors" of the Performance
Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors document
available at the link below. This constitutes events which capture L3
cache and UMC command activity.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen5/cache.json    | 175 ++++++++++++++++++
 .../arch/x86/amdzen5/memory-controller.json   | 101 ++++++++++
 2 files changed, 276 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/cache.json
index 03d62bb6824b..930affef8f34 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen5/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/cache.json
@@ -601,5 +601,180 @@
     "EventCode": "0x28f",
     "BriefDescription": "Op cache accesses of all types.",
     "UMask": "0x07"
+  },
+  {
+    "EventName": "l3_lookup_state.l3_miss",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache misses.",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.l3_hit",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache hits.",
+    "UMask": "0xfe",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_lookup_state.all_coherent_accesses_to_l3",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 cache requests for all coherent accesses.",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.dram_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.near_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in the same NUMA node.",
+    "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.far_cache",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from another CCX's cache when the address was in a different NUMA node.",
+    "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_near",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.ext_far",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency when data is sourced from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency.all",
+    "EventCode": "0xac",
+    "BriefDescription": "Average sampled latency from all data sources.",
+    "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_near",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from DRAM in the same NUMA node.",
+    "UMask": "0x01",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.dram_far",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from DRAM in a different NUMA node.",
+    "UMask": "0x02",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.near_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in the same NUMA node.",
+    "UMask": "0x04",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.far_cache",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from another CCX's cache when the address was in a different NUMA node.",
+    "UMask": "0x08",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_near",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in the same NUMA node.",
+    "UMask": "0x10",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.ext_far",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from extension memory (CXL) in a different NUMA node.",
+    "UMask": "0x20",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_xi_sampled_latency_requests.all",
+    "EventCode": "0xad",
+    "BriefDescription": "L3 cache fill requests sourced from all data sources.",
+    "UMask": "0x3f",
+    "EnAllCores": "0x1",
+    "EnAllSlices": "0x1",
+    "SliceId": "0x3",
+    "ThreadMask": "0x3",
+    "Unit": "L3PMC"
   }
 ]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
new file mode 100644
index 000000000000..55263e5e4f69
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
@@ -0,0 +1,101 @@
+[
+  {
+    "EventName": "umc_mem_clk",
+    "PublicDescription": "Number of memory clock cycles.",
+    "EventCode": "0x00",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.all",
+    "PublicDescription": "Number of ACTIVATE commands sent.",
+    "EventCode": "0x05",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.rd",
+    "PublicDescription": "Number of ACTIVATE commands sent for reads.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_act_cmd.wr",
+    "PublicDescription": "Number of ACTIVATE commands sent for writes.",
+    "EventCode": "0x05",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.all",
+    "PublicDescription": "Number of PRECHARGE commands sent.",
+    "EventCode": "0x06",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.rd",
+    "PublicDescription": "Number of PRECHARGE commands sent for reads.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_pchg_cmd.wr",
+    "PublicDescription": "Number of PRECHARGE commands sent for writes.",
+    "EventCode": "0x06",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.all",
+    "PublicDescription": "Number of CAS commands sent.",
+    "EventCode": "0x0a",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.rd",
+    "PublicDescription": "Number of CAS commands sent for reads.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_cas_cmd.wr",
+    "PublicDescription": "Number of CAS commands sent for writes.",
+    "EventCode": "0x0a",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.all",
+    "PublicDescription": "Number of clocks used by the data bus.",
+    "EventCode": "0x14",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.rd",
+    "PublicDescription": "Number of clocks used by the data bus for reads.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.wr",
+    "PublicDescription": "Number of clocks used by the data bus for writes.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  }
+]
-- 
2.34.1


