Return-Path: <linux-kernel+bounces-167305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E098BA782
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D8A41C21775
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:17:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63E2146A8F;
	Fri,  3 May 2024 07:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EYMewYZC"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE03C146A75;
	Fri,  3 May 2024 07:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720639; cv=fail; b=XPoHjbhcKE6WW8rs6Cs1JgcF98rG2kkbNAbLhQtlLpLMrsMLE//kF73soBnDA5FrCmxnvAQZzzojdZxK7wQpgHmDUi6U7IAe72PgCYU+qmE+KFGbxlRk1K8PzEz4eahRVCM4nEOTSKGG9InjDNaFOGp/cbqEBZvRUZj4/TBL1mM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720639; c=relaxed/simple;
	bh=6tPAooDm+OY8rgEXGzmSHnECj3VL/jvv4paJwtUhl60=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkctSEcd49A+4dUNYsjRNKLMPPb8VS+GF0ENH0H2VKbiXITc1MgJvIxFFDrw93aotVv3nsTvDZWDKu2GKN8zIZNNgJpFcbkgKxOGpMggNPQVSz+DYJzxqbtqG4OIrybrqJJEUZddUtvB7jQqLRT/cVoPKOWGdG13WIHT3WJFKcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EYMewYZC; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK8QGWJ8onvprMcDt5ODks0rcZ+a99/04m/Xcu3CJPcwZNAcwt5f5llULr+icvubvk7gUYtt4FY0s/lbPkGuZoGKnlTfp5bnDyVPD5j5jUVki0Nb6RrT4iz/PYNsn0jqU79KlM/k5ESEKJ1aJAAo8ZGBKfINHz5/YbjT/PtweeR+c3Xva8XWdoSGEUGqo2y6av5N2EwDB3mmIC2HGygfix0OpxrIMJFlSKufd7NAswA0NgDFOEYMl8RVpyjGohF0F9G8D2TKsJADe5Y2oDPFQncvsYxkGK//kLq7OckSe1BwfLbX73A6fqizoJGRbI/DFihhUIVyakaY19p6752cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhY3QpV7eirevm1wpCvOmiV24sWAMtcTpT8zlMIT63g=;
 b=hM+nkjqnWQpB5/1bd3FH4xDjjKmpYAph63EDoQRK7OSSWd3DhAvEmy49lyLJA38Iu4ejZ/TdbIS/heculdjdrFCCqZ8bacVmy92VZ1ZkB1FW3/fOFuqCAyg5jKjMgU5+Y7dSQo+m2o5h9iNhixfxMqfufXLTCFL0x0+s1cXLKZuaNuR2tH81W8SZr127IL9Wv9bFTuTOk1fXGVtVyM0Yt6z50PqW+y1/HJTw1k09a0RHbvquzlyD/aTpw/zLQEyhh4Qw/gQNS9T9xJeDoYgTrmOO+1OSG6avHVIJNtDfhLcb2TyFULT4TEic6jBekWAbcWnZjBM+SVyWJhocAoebDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IhY3QpV7eirevm1wpCvOmiV24sWAMtcTpT8zlMIT63g=;
 b=EYMewYZCeFx5jBl/6LFCBRbXPhZyHYnpgKxSZ4qlCpPSD5FPWMSB8kqxcfUuSVtcZ6T+r5ce9nEvcfQ5lxb7wKi1QAx1LvqSh+cja37todPpP+2xh7TfInAZw0G9Fwcd+jNkhpGpEF/mKnVPBMMmbjR7odp6USu+zzu2geYEz/4=
Received: from CH2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:610:54::20)
 by CH0PR12MB8549.namprd12.prod.outlook.com (2603:10b6:610:182::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Fri, 3 May
 2024 07:17:14 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::c7) by CH2PR11CA0010.outlook.office365.com
 (2603:10b6:610:54::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.30 via Frontend
 Transport; Fri, 3 May 2024 07:17:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 07:17:14 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 02:17:04 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 2/4] perf vendor events amd: Add Zen 5 uncore events
Date: Fri, 3 May 2024 12:46:20 +0530
Message-ID: <e11e8d9d1af34a0fb565fc9d1c4a05f569c39ddc.1714717230.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|CH0PR12MB8549:EE_
X-MS-Office365-Filtering-Correlation-Id: 622753c7-9dfb-4a0c-828e-08dc6b410ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|1800799015|376005|36860700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b0bT4TAIQgqoRTGaY9fDi2sffZxhU8/7cM0WnAmcLV7UsIywfdQFuq8csBto?=
 =?us-ascii?Q?ukYPvL2mkkjXV2NyfVXR9MC0qFTliCmsK21klh1ZJ/m6BzmTDZ7C+YEuZsl/?=
 =?us-ascii?Q?7La6c74c7zchspU8EPZI2pl08+Cl3k1VlQ85wvL9Y0VuH4w1NL8Suy/54ccs?=
 =?us-ascii?Q?nTuuBPduqW/kkg0D7kmAFEw5bUuuHIfJdhuxrowFmPR7mXq48MoxrMzIq/QP?=
 =?us-ascii?Q?EgZh5nfkvPEznabpjEPFrjcpECVgulBo+kyvyzq+lVRRI053j+oM6A3lbENt?=
 =?us-ascii?Q?6xeg9lFWc4Y/vG2fZfitYwFDiqGM7kVBouBo6DNj1lss1aRk2Z8v1nv0tuLS?=
 =?us-ascii?Q?KkaW1avo7IQ/B8oFtAMM5t83Q6DCwgNJUKgD9rZeZvz2Jvk05y3aQaBm8GSv?=
 =?us-ascii?Q?NFyZIZGbG5uMJWNtsx89AJPesQW1lqWuKxGxRv0zJLHmAh6M3Ypo3SbGKshi?=
 =?us-ascii?Q?T8HRxkqaPUyjsPEViVOUJQY1V3ay5uND78CvmDVe/TTeJ8Jdnu56pAQHF0FX?=
 =?us-ascii?Q?YV/8uA69pTD5vqIgaPQJf6d5y+pupEm4TnT96nimBFhvH6fZzobnFSKY/DBW?=
 =?us-ascii?Q?qilQCyJpndkysuWezP5VcPUtmxZkJDy/whWgd7RCq/oE+cmLLCHTmrojO02b?=
 =?us-ascii?Q?EGoTVPuroJDPudXz56JUUaO+BYgJCXF2B5aLqXA/1XLe9K2nVdZtEj0sdsfs?=
 =?us-ascii?Q?u/Z8Y7nZVACnM5j6KAvr0ajEAGs4r/gOYRWz1gXPB+sPl/VjWdgZ8FbHd99k?=
 =?us-ascii?Q?STorP42uT6/LQekyfNlR/QQYwu/BD2kDF0xkMK9oZubcmQrftWiLSrroaCoU?=
 =?us-ascii?Q?EDRUu5WrVrKnbUgZKs1DvKqafT+0KXpcjKU9urPy+rtYKnR7Yl0Jfz8wTJkT?=
 =?us-ascii?Q?IAV1jX0aqben5VHAfiNJ+C9uqnjZqdCyaCvyUso4YiW2N9EoiJwO2bmba1W7?=
 =?us-ascii?Q?Sbsee2kddRLdZj4jlVgY60T3zYrjFZsWfF0ZIkTPIUakTzoKTxB4kvoq02ZR?=
 =?us-ascii?Q?3sh23mJyvQQoEQ+4AAJfpdlS5D1mbJWMGsxCRP1Zsne+jeXyvOKdjcvc30NE?=
 =?us-ascii?Q?9i3huLNwrGmyZ7cWgXY8RhdD/qOTR6V6whD5uGmBjWmLtOx2yXgRn4c5JO3/?=
 =?us-ascii?Q?22ey5hhKOfjUMsetKI819Jb75rdBrNQZReWVNoLAqf89NysaTyJ66uoyqmsM?=
 =?us-ascii?Q?0SpXPaDz/BNkNLU6LBxGHPZ8WTXhzkjt225pEPPuLoysWnc9pJ5UlD9XVMgX?=
 =?us-ascii?Q?UCNlFdTKIcSOyLOfVRcNNuoUJ6BQSIuyLCqBaXTyFVEFxgJQ0wwBzVxltRGo?=
 =?us-ascii?Q?wWNkBnh/fk+nWB4O/6gBXimU?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:17:14.4967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 622753c7-9dfb-4a0c-828e-08dc6b410ee9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8549

Add uncore events taken from Section 1.5 "L3 Cache Performance Monitor
Counters" and Section 2 "UMC Performance Monitors" of the Performance
Monitor Counters for AMD Family 1Ah Model 00h-0Fh Processors document
available at the link below. This constitutes events which capture L3
cache and UMC command activity.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen5/l3-cache.json | 177 ++++++++++++++++++
 .../arch/x86/amdzen5/memory-controller.json   | 101 ++++++++++
 2 files changed, 278 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json
new file mode 100644
index 000000000000..b50fe14d4520
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/l3-cache.json
@@ -0,0 +1,177 @@
+[
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
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json b/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
new file mode 100644
index 000000000000..1a629fc9474a
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/memory-controller.json
@@ -0,0 +1,101 @@
+[
+  {
+    "EventName": "umc_mem_clk",
+    "PublicDescription": "Number of memory clock (MEMCLK) cycles.",
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
+    "PublicDescription": "Number of clock cycles used by the data bus.",
+    "EventCode": "0x14",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.rd",
+    "PublicDescription": "Number of clock cycles used by the data bus for reads.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x1",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  },
+  {
+    "EventName": "umc_data_slot_clks.wr",
+    "PublicDescription": "Number of clock cycles used by the data bus for writes.",
+    "EventCode": "0x14",
+    "RdWrMask": "0x2",
+    "PerPkg": "1",
+    "Unit": "UMCPMC"
+  }
+]
-- 
2.34.1


