Return-Path: <linux-kernel+bounces-167304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B6A8BA781
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262D22814C1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F795146A7B;
	Fri,  3 May 2024 07:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KF+KNYRB"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4CB146A69;
	Fri,  3 May 2024 07:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720621; cv=fail; b=VNEEA7chuAmusGIek92om0vrbSZWTwv9xjrp/v+mYMjAou94Rz9Hkw8GgHowmYxhwtkckSgxDNiC/IF0kz5RCCkoqsLuzXtrvFUgVGqopX+D4Q3NdD+WnMGzB/sSrSHkwExaiHjiTI8xWXka7VtLcw8tYtRsPVuewWN7wjKsFNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720621; c=relaxed/simple;
	bh=MO4sJX38toIdcYkxxFOAS8L4Kby2SrY+thqNQds+8os=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sdsqIw9wKHj4d8i4zixZ3c8omSATD5+GH+GVYQFMLOzsfkSXEQx6N84S846Ux21GNQRvIETSo7riORvXOsDzktCOG80xjmD+eeRmmc5zd32/iay9DKLX2/1v6sIw4GeZBnirfRc2Pf4oQb8KiOkfqLwXPr3Q8l8TPv2Vj5rW5nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KF+KNYRB; arc=fail smtp.client-ip=40.107.244.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gr1GtnG4kH7e5bRLXcX+8gWuThulyBQqT0KAiDYphBiEO2kBdx8a7YOcmHTFbqwAnnKbgq+jUXWAbhpueW7IPyEb6tnNe3t6w8bIBCDLznkqMSe4QxPuTHFTFvq0ZhuS8JJDuaCRcHkwzvs3wjOoOLa9izmNw2GZqdNwIer0CsbBlkg10r34UbSDIhvYYxMzNZZqjcy3GyaxHOnpujHLtFhQTOzr79N6lC7WyE1l3gZYFSxBWAR7a7gpL8Enrc1+nNDWu2q3u/HOfSPukWK9sQc6RRfceWIG14uhsI+IJvpj+5VJPrmdBrmKL1B0te0G5euR5POhtry7Bs7LfxO5XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJp7xInuNod2hqg1NTm3y+7cwjm8Kpz3OLna/aOQ2EM=;
 b=BjJtnu1kSwfOO8Cyt5LN6i+1XkiPozQNkOJGEgvv3ucpx4hNisE+lr34kTUdpz3oHu3/sxF/W7dGCEv5a8iEzq7sNzLSioH9HL04zWjriPDdb/GHQsWLpCFGtB6fY0UpXCR8qvliSuoVAU9Vmf8lDgMPxzNb/dlQbdmJO/oHKZWA5LvpTT9Cmay9nxyhB0yRm6mOIhUz9/LWYUbBza0dNelonNeLj/3uJ4E3CnLyHHe/gQ0phIIxYepDWT9Pi0Ac0VikLrVOl6B7NHs2gWouMb8Yi7iDv0cPkfvCigbA2CE0U/s4Mte2yJZUiEjXO12uA8kfxV7Se+r0lhN+xxdINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJp7xInuNod2hqg1NTm3y+7cwjm8Kpz3OLna/aOQ2EM=;
 b=KF+KNYRBkvZS15q72GbVZG32G8TLv4NX1tsx9FCiqc6Pp/swCtDa6h168B2vo0oagQndACFyjiDtUYb0TrhjFOpNBCyaXq2IlqQAgvvfnUSIJmJAJInWkzLcYZm+fiaDE9zVoDVApBCsh53+1b4rPbtYMg+/c9UGzJBEOEk0XqU=
Received: from CH2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:610:54::36)
 by IA1PR12MB9064.namprd12.prod.outlook.com (2603:10b6:208:3a8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.45; Fri, 3 May
 2024 07:16:52 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::f7) by CH2PR11CA0026.outlook.office365.com
 (2603:10b6:610:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.31 via Frontend
 Transport; Fri, 3 May 2024 07:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Fri, 3 May 2024 07:16:52 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 3 May
 2024 02:16:46 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH v2 1/4] perf vendor events amd: Add Zen 5 core events
Date: Fri, 3 May 2024 12:46:19 +0530
Message-ID: <668d194241bf0d42dc37f1c5af8131069a0bd82c.1714717230.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|IA1PR12MB9064:EE_
X-MS-Office365-Filtering-Correlation-Id: c921d7df-4fa8-4e36-9cd8-08dc6b41018e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98brYaLLYThGe2Ku+ANo90WiWbgnsowL9Y8mUORE5Aa70ObgafTo/FjWSR9j?=
 =?us-ascii?Q?kP2YVZMQSHb2K5Vr46Ku4KQeV6BkSEy4tuDU17Aj1Lb3M0uKVwa+MOu3htce?=
 =?us-ascii?Q?YLrTLUdrPO1DeBAFu29tirWBgpyO1u9OGc2Ufgm1hLE/ZhAHc9P1SOCml7Bd?=
 =?us-ascii?Q?BUD0hRhYE3Rqeb3hLgC9KWi65hsG9S8kaGITJLjMXVhCIFar4fRLGVtc7Vul?=
 =?us-ascii?Q?FRUIILzXZN0tBFCiCIqwFuxVqNfOmuH1G0gFZ+QlcBu/91JMtfuemLBuZsyE?=
 =?us-ascii?Q?gMZCz1DE5tAQJtfanvuwt5YfpGWyguuK5P1WA9QTdFtsmUZdCUYMS3sCB0YX?=
 =?us-ascii?Q?NJyV4Nd+mgrTuijibpT3DhKS2LMeEUOom4AHcxsK4ilRsIHkaXeqWHbSCtvV?=
 =?us-ascii?Q?1uPNVu6Nry+3HioWR6/HLsCmd7aPh+JNahwJ+gBnitGBnLJyff6sUHZozaRi?=
 =?us-ascii?Q?WMGcwt5iDfXF0iqHy1WgBFfIaTVLBqyesN1nXi7lSzTt3QLL6D9F1MB5OoXs?=
 =?us-ascii?Q?aTrZEByv9wi17+SipoMlpUUo3Te5G9b3gigLnCwOq8V110vXMGZLVKAMvFfE?=
 =?us-ascii?Q?Lo8uwWmSkLTzjeXBFSHiT9f8sq+Tmz8ZjzWKX3wCVxxJi7Iuix//8Hx+Hq9A?=
 =?us-ascii?Q?GYEGObYk9rfouZy8YhY8vc6igysvyIGFwsebYeE/AykVPYWZ6Udw1CoMgjgC?=
 =?us-ascii?Q?2xHcR7bCj1k4gEeGqJ52wuOE7TxT5uYB7pJfS0ZxSOHOEShLaWrqS9sab+Um?=
 =?us-ascii?Q?tPTDBYlau6NJwu/YXI+dB/v0DWDZGyZl2QFiWiZzBxgIvAgC63Q5eSFiySz+?=
 =?us-ascii?Q?va61RiCoDfP8wvTmS6fsdrXV+pHHam+cbIaqng68LPf3RiWNbJVXnSiLbx51?=
 =?us-ascii?Q?9/1ppmByQ+Qc7kXLjZJpPjbsH8gv7F8TBImjnu5bSjYDKwsYAI+8nEXtZsUv?=
 =?us-ascii?Q?3NgPj7M8oeelzWhTbXzh+iSsIqZIwTXMkzxRfg9iOjZ9WWIsZEfNMnr+yvT9?=
 =?us-ascii?Q?e4rJtWtCficr/kV8k7SIyKGUriRDGRmN4GCX7iid64jcZN3Elfiu50ON+1ds?=
 =?us-ascii?Q?luLhfYGOQ/6cl6c2B65x9DC9gUf5fHlOrjBOUr4XpouvnJLokly2RE7Ugioi?=
 =?us-ascii?Q?IpSYDd2Uss7xm/5qLgrgRPNCi0nelS8CylQF/RC+PSLIgqiFRNEfG7OTs6Fc?=
 =?us-ascii?Q?x8rWpXV0j/2qmgbGgHA9lGQuY6MazAsoezvdhF+ZiAQ/k055FftPnNSi80V5?=
 =?us-ascii?Q?WuaHa4O0DL7wcLs5Gd1JTDuDeBVKjsUu5sFp6eb/SHgePf6w/bCQhTx7gZmR?=
 =?us-ascii?Q?awWl/WZK7tyH/rf7sPKeeP8a?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2024 07:16:52.0906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c921d7df-4fa8-4e36-9cd8-08dc6b41018e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9064

Add core events taken from Section 1.4 "Core Performance Monitor
Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
00h-0Fh Processors document available at the link below. This
constitutes events which capture information on op dispatch, execution
and retirement, branch prediction, L1 and L2 cache activity,
TLB activity, etc.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../arch/x86/amdzen5/branch-prediction.json   |  93 ++
 .../pmu-events/arch/x86/amdzen5/decode.json   | 115 +++
 .../arch/x86/amdzen5/execution.json           | 174 ++++
 .../arch/x86/amdzen5/floating-point.json      | 812 ++++++++++++++++++
 .../arch/x86/amdzen5/inst-cache.json          |  72 ++
 .../pmu-events/arch/x86/amdzen5/l2-cache.json | 266 ++++++
 .../arch/x86/amdzen5/load-store.json          | 451 ++++++++++
 7 files changed, 1983 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/decode.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/execution.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/load-store.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json b/tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json
new file mode 100644
index 000000000000..2d8d18cb85c1
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/branch-prediction.json
@@ -0,0 +1,93 @@
+[
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_hit",
+    "EventCode": "0x84",
+    "BriefDescription": "Instruction fetches that miss in the L1 ITLB but hit in the L2 ITLB."
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if2m",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.if1g",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.coalesced_4k",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "bp_l1_tlb_miss_l2_tlb_miss.all",
+    "EventCode": "0x85",
+    "BriefDescription": "Instruction fetches that miss in both the L1 and L2 ITLBs (page-table walks are requested) for all page sizes.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 branch prediction overrides existing prediction (speculative)."
+  },
+  {
+    "EventName": "bp_dyn_ind_pred",
+    "EventCode": "0x8e",
+    "BriefDescription": "Dynamic indirect predictions (branch used the indirect predictor to make a prediction)."
+  },
+  {
+    "EventName": "bp_de_redirect",
+    "EventCode": "0x91",
+    "BriefDescription": "Number of times an early redirect is sent to branch predictor. This happens when either the decoder or dispatch logic is able to detect that the branch predictor needs to be redirected."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if4k",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 4k or coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if2m",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 2M pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.if1g",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for 1G pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit.all",
+    "EventCode": "0x94",
+    "BriefDescription": "Instruction fetches that hit in the L1 ITLB for all page sizes.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "bp_redirects.resync",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the branch predictor caused by resyncs.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "bp_redirects.ex_redir",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the branch predictor caused by mispredicts.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "bp_redirects.all",
+    "EventCode": "0x9f",
+    "BriefDescription": "Redirects of the branch predictor."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/decode.json b/tools/perf/pmu-events/arch/x86/amdzen5/decode.json
new file mode 100644
index 000000000000..d0eff7f2a3ea
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/decode.json
@@ -0,0 +1,115 @@
+[
+  {
+    "EventName": "de_op_queue_empty",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles where the op queue is empty. Such cycles indicate that the front-end is not delivering instructions fast enough."
+  },
+  {
+    "EventName": "de_src_op_disp.x86_decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from x86 decoder.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_src_op_disp.op_cache",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from op cache.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_src_op_disp.all",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from any source.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.any_fp_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Number of ops dispatched to the floating-point unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dis_ops_from_decoder.any_integer_dispatch",
+    "EventCode": "0xab",
+    "BriefDescription": "Number of ops dispatched to the integer execution unit.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.int_phy_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to an integer physical register file resource stall.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.load_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a lack of load queue tokens.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.store_queue_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a lack of store queue tokens.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.taken_brnch_buffer_rsrc",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a taken branch buffer resource stall.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.fp_sch_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a floating-point non-schedulable queue token stall.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.al_tokens",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of ALU tokens.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.ag_tokens",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of agen tokens.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.ex_flush_recovery",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to a pending integer execution flush recovery.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part2.retq",
+    "EventCode": "0xaf",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to unavailability of retire queue tokens.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.no_ops_from_frontend",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts dispatch slots left empty because the front-end did not supply ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.backend_stalls",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts ops unable to dispatch because of back-end stalls.",
+    "UMask": "0x1e"
+  },
+  {
+    "EventName": "de_no_dispatch_per_slot.smt_contention",
+    "EventCode": "0x1a0",
+    "BriefDescription": "In each cycle counts ops unable to dispatch because the dispatch cycle was granted to the other SMT thread.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "de_additional_resource_stalls.dispatch_stalls",
+    "EventCode": "0x1a2",
+    "BriefDescription": "Counts additional cycles where dispatch is stalled due to a lack of dispatch resources.",
+    "UMask": "0x30"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/execution.json b/tools/perf/pmu-events/arch/x86/amdzen5/execution.json
new file mode 100644
index 000000000000..5a46d3db74e7
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/execution.json
@@ -0,0 +1,174 @@
+[
+  {
+    "EventName": "ex_ret_instr",
+    "EventCode": "0xc0",
+    "BriefDescription": "Retired instructions."
+  },
+  {
+    "EventName": "ex_ret_ops",
+    "EventCode": "0xc1",
+    "BriefDescription": "Retired macro-ops."
+  },
+  {
+    "EventName": "ex_ret_brn",
+    "EventCode": "0xc2",
+    "BriefDescription": "Retired branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_misp",
+    "EventCode": "0xc3",
+    "BriefDescription": "Retired branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn",
+    "EventCode": "0xc4",
+    "BriefDescription": "Retired taken branch instructions (all types of architectural control flow changes, including exceptions and interrupts)."
+  },
+  {
+    "EventName": "ex_ret_brn_tkn_misp",
+    "EventCode": "0xc5",
+    "BriefDescription": "Retired taken branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_brn_far",
+    "EventCode": "0xc6",
+    "BriefDescription": "Retired far control transfers (far call/jump/return, IRET, SYSCALL and SYSRET, plus exceptions and interrupts). Far control transfers are not subject to branch prediction."
+  },
+  {
+    "EventName": "ex_ret_near_ret",
+    "EventCode": "0xc8",
+    "BriefDescription": "Retired near returns (RET or RET Iw)."
+  },
+  {
+    "EventName": "ex_ret_near_ret_mispred",
+    "EventCode": "0xc9",
+    "BriefDescription": "Retired near returns mispredicted. Each misprediction incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_brn_ind_misp",
+    "EventCode": "0xca",
+    "BriefDescription": "Retired indirect branch instructions mispredicted (only EX mispredicts). Each misprediction incurs the same penalty as a mispredicted conditional branch instruction."
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.x87",
+    "EventCode": "0xcb",
+    "BriefDescription": "Retired x87 instructions.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.mmx",
+    "EventCode": "0xcb",
+    "BriefDescription": "Retired MMX instructions.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_ret_mmx_fp_instr.sse",
+    "EventCode": "0xcb",
+    "BriefDescription": "Retired SSE instructions (includes SSE, SSE2, SSE3, SSSE3, SSE4A, SSE41, SSE42 and AVX).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_ret_ind_brch_instr",
+    "EventCode": "0xcc",
+    "BriefDescription": "Retired indirect branch instructions."
+  },
+  {
+    "EventName": "ex_ret_cond",
+    "EventCode": "0xd1",
+    "BriefDescription": "Retired conditional branch instructions."
+  },
+  {
+    "EventName": "ex_div_busy",
+    "EventCode": "0xd3",
+    "BriefDescription": "Number of cycles the divider is busy."
+  },
+  {
+    "EventName": "ex_div_count",
+    "EventCode": "0xd4",
+    "BriefDescription": "Divide ops executed."
+  },
+  {
+    "EventName": "ex_no_retire.empty",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire due  to the lack of valid ops in the retire queue (may be caused by front-end bottlenecks or pipeline redirects).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_no_retire.not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire while the oldest op is waiting to be executed.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_no_retire.other",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire caused by other reasons (retire breaks, traps, faults, etc.).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ex_no_retire.thread_not_selected",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire because thread arbitration did not select the thread.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ex_no_retire.load_not_complete",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire while the oldest op is waiting for load data.",
+    "UMask": "0xa2"
+  },
+  {
+    "EventName": "ex_no_retire.all",
+    "EventCode": "0xd6",
+    "BriefDescription": "Cycles with no retire for any reason.",
+    "UMask": "0x1b"
+  },
+  {
+    "EventName": "ex_ret_ucode_instr",
+    "EventCode": "0x1c1",
+    "BriefDescription": "Retired microcoded instructions."
+  },
+  {
+    "EventName": "ex_ret_ucode_ops",
+    "EventCode": "0x1c2",
+    "BriefDescription": "Retired microcode ops."
+  },
+  {
+    "EventName": "ex_ret_msprd_brnch_instr_dir_msmtch",
+    "EventCode": "0x1c7",
+    "BriefDescription": "Retired branch instructions mispredicted due to direction mismatch."
+  },
+  {
+    "EventName": "ex_ret_uncond_brnch_instr_mispred",
+    "EventCode": "0x1c8",
+    "BriefDescription": "Retired unconditional indirect branch instructions mispredicted."
+  },
+  {
+    "EventName": "ex_ret_uncond_brnch_instr",
+    "EventCode": "0x1c9",
+    "BriefDescription": "Retired unconditional branch instructions."
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Ops tagged by IBS.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_tagged_ops_ret",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Ops tagged by IBS that retired.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ex_tagged_ibs_ops.ibs_count_rollover",
+    "EventCode": "0x1cf",
+    "BriefDescription": "Ops not tagged by IBS due to a previous tagged op that has not yet signaled interrupt.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ex_ret_fused_instr",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired fused instructions."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
new file mode 100644
index 000000000000..9204bfb1d69e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
@@ -0,0 +1,812 @@
+[
+  {
+    "EventName": "fp_ret_x87_fp_ops.add_sub_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point add and subtract ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.mul_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point multiply ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.div_sqrt_ops",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point divide and square root ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_x87_fp_ops.all",
+    "EventCode": "0x02",
+    "BriefDescription": "Retired x87 floating-point ops of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.add_sub_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point add and subtract ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mult_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point multiply ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.div_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point divide and square root ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.mac_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point multiply-accumulate ops (each operation is counted as 2 ops).",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.bfloat16_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point bfloat16 ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.scalar_single_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point scalar single-precision ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.packed_single_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point packed single-precision ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.scalar_double_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point scalar double-precision ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.packed_double_flops",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point packed double-precision ops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "fp_ret_sse_avx_ops.all",
+    "EventCode": "0x03",
+    "BriefDescription": "Retired SSE and AVX floating-point ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.x87_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired x87 floating-point ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.mmx_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired MMX floating-point ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.scalar_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired scalar floating-point ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_128_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 128-bit floating-point ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_256_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 256-bit floating-point ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.pack_512_uops_retired",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired packed 512-bit floating-point ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_retired_by_width.all",
+    "EventCode": "0x08",
+    "BriefDescription": "Retired floating-point ops of all widths.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point divide ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point square root ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point convert ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point blend ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.scalar_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired scalar floating-point ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_add",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_sub",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mul",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_mac",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_div",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point divide ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_sqrt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point square root ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_cmp",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_cvt",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point convert ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_blend",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point blend ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_shuffle",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_logical",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_other",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.vector_all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired vector floating-point ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_ops_retired_by_type.all",
+    "EventCode": "0x0a",
+    "BriefDescription": "Retired floating-point ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer add.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shift ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer pack ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer multiply ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.mmx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired MMX integer ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_add",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_sub",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mul",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mac",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_aes",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer AES ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_sha",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer SHA ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_cmp",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_clm",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer CLM ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_shift",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shift ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_mov",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer MOV ops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_shuffle",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_pack",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer pack ops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_logical",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_other",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.sse_avx_all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE and AVX integer ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "sse_avx_ops_retired.all",
+    "EventCode": "0x0b",
+    "BriefDescription": "Retired SSE, AVX and MMX integer ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point divide ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point square root ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point convert ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point blend ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp128_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 128-bit packed floating-point ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_add",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_sub",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mul",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_mac",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_div",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point divide ops.",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_sqrt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point square root ops.",
+    "UMask": "0x60"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_cmp",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_cvt",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point convert ops.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_blend",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point blend ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_shuffle",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_logical",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_other",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.fp256_all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired 256-bit packed floating-point ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "fp_pack_ops_retired.all",
+    "EventCode": "0x0c",
+    "BriefDescription": "Retired packed floating-point ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer add ops.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer subtract ops.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply ops.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer multiply-accumulate ops.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_aes",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer AES ops.",
+    "UMask": "0x05"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_sha",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer SHA ops.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer compare ops.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_clm",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer CLM ops.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shift ops.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer MOV ops.",
+    "UMask": "0x0a"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0x0b"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer pack ops.",
+    "UMask": "0x0c"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer logical ops.",
+    "UMask": "0x0d"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer ops of other types.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "packed_int_op_type.int128_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 128-bit packed integer ops of all types.",
+    "UMask": "0x0f"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_add",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer add ops.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_sub",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer subtract ops.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mul",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply ops.",
+    "UMask": "0x30"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mac",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer multiply-accumulate ops.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_cmp",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer compare ops.",
+    "UMask": "0x70"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_shift",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shift ops.",
+    "UMask": "0x90"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_mov",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer MOV ops.",
+    "UMask": "0xa0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_shuffle",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer shuffle ops (may include instructions not necessarily thought of as including shuffles e.g. horizontal add, dot product, and certain MOV instructions).",
+    "UMask": "0xb0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_pack",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer pack ops.",
+    "UMask": "0xc0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_logical",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer logical ops.",
+    "UMask": "0xd0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_other",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer ops of other types.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "packed_int_op_type.int256_all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired 256-bit packed integer ops of all types.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "packed_int_op_type.all",
+    "EventCode": "0x0d",
+    "BriefDescription": "Retired packed integer ops of all types.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "fp_disp_faults.x87_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for x87 fills.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "fp_disp_faults.xmm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for XMM fills.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_fill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM fills.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "fp_disp_faults.ymm_spill_fault",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults for YMM spills.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "fp_disp_faults.sse_avx_all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types for SSE and AVX ops.",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "fp_disp_faults.all",
+    "EventCode": "0x0e",
+    "BriefDescription": "Floating-point dispatch faults of all types.",
+    "UMask": "0x0f"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
new file mode 100644
index 000000000000..ad75e5bf9513
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/inst-cache.json
@@ -0,0 +1,72 @@
+[
+  {
+    "EventName": "ic_cache_fill_l2",
+    "EventCode": "0x82",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from the L2 cache."
+  },
+  {
+    "EventName": "ic_cache_fill_sys",
+    "EventCode": "0x83",
+    "BriefDescription": "Instruction cache lines (64 bytes) fulfilled from system memory or another cache."
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.fetch_tagged",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetches tagged by Fetch IBS. Not all tagged fetches result in a valid sample and an IBS interrupt.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.sample_discarded",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetches discarded after being tagged by Fetch IBS due to reasons other than IBS filtering.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.sample_filtered",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetches discarded after being tagged by Fetch IBS due to IBS filtering.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ic_fetch_ibs_events.sample_valid",
+    "EventCode": "0x188",
+    "BriefDescription": "Fetches tagged by Fetch IBS that result in a valid sample and an IBS interrupt.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_hit",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache hits.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.instruction_cache_miss",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache misses.",
+    "UMask": "0x18"
+  },
+  {
+    "EventName": "ic_tag_hit_miss.all_instruction_cache_accesses",
+    "EventCode": "0x18e",
+    "BriefDescription": "Instruction cache accesses of all types.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_hit",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache hits.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "op_cache_hit_miss.op_cache_miss",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache misses.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "op_cache_hit_miss.all_op_cache_accesses",
+    "EventCode": "0x28f",
+    "BriefDescription": "Op cache accesses of all types.",
+    "UMask": "0x07"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json
new file mode 100644
index 000000000000..d1de51a02922
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/l2-cache.json
@@ -0,0 +1,266 @@
+[
+  {
+    "EventName": "l2_request_g1.group2",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of non-cacheable type (non-cached data and instructions reads, self-modifying code checks).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_request_g1.l2_hw_pf",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: from hardware prefetchers to prefetch directly into L2 (hit or miss).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_request_g1.prefetch_l2_cmd",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: prefetch directly into L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_request_g1.cacheable_ic_read",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: instruction cache reads.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_request_g1.ls_rd_blk_c_s",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache shared reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_x",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache stores.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_request_g1.rd_blk_l",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests: data cache reads including hardware and software prefetch.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_request_g1.all_dc",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types from L1 data cache (including prefetches).",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_request_g1.all_no_prefetch",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of common types not including prefetches.",
+    "UMask": "0xf1"
+  },
+  {
+    "EventName": "l2_request_g1.all",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 cache requests of all types.",
+    "UMask": "0xf7"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized_nc",
+    "EventCode": "0x61",
+    "BriefDescription": "L2 cache requests: non-coherent, non-cacheable LS sized reads.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_request_g2.ls_rd_sized",
+    "EventCode": "0x61",
+    "BriefDescription": "L2 cache requests: coherent, non-cacheable LS sized reads.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_wcb_req.wcb_close",
+    "EventCode": "0x63",
+    "BriefDescription": "Write Combining Buffer (WCB) closures.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache request miss in L2.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache hit non-modifiable line in L2.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_fill_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: instruction cache hit modifiable line in L2.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for instruction cache hits.",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for instruction cache access.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_c",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache request miss in L2.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache misses.",
+    "UMask": "0x09"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache store or state change hit in L2.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_s",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache read hit non-modifiable line in L2.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_l_hit_x",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache read hit modifiable line in L2.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ls_rd_blk_cs",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) with status: data cache shared read hit in L2.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data cache hits.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache hits.",
+    "UMask": "0xf6"
+  },
+  {
+    "EventName": "l2_cache_req_stat.dc_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data cache access.",
+    "UMask": "0xf8"
+  },
+  {
+    "EventName": "l2_cache_req_stat.all",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cache requests (not including L2 prefetch) for data and instruction cache access.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l2_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_dc_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_hit_l2.l1_dc_l2_hwpf",
+    "EventCode": "0x70",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which hit in the L2 cache and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l2_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_dc_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_hit_l3.l1_dc_l2_hwpf",
+    "EventCode": "0x71",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 cache but hit in the L3 cache and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l2_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L2 hardware prefetchers.",
+    "UMask": "0x1f"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_dc_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L1 data hardware prefetchers.",
+    "UMask": "0xe0"
+  },
+  {
+    "EventName": "l2_pf_miss_l2_l3.l1_dc_l2_hwpf",
+    "EventCode": "0x72",
+    "BriefDescription": "L2 prefetches accepted by the L2 pipeline which miss the L2 as well as the L3 caches and are generated from L1 data and L2 hardware prefetchers.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.local_ccx",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.near_cache",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.dram_io_near",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.far_cache",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.dram_io_far",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.alternate_memories",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "l2_fill_rsp_src.all",
+    "EventCode": "0x165",
+    "BriefDescription": "L2 cache fills from all types of data sources.",
+    "UMask": "0xde"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
new file mode 100644
index 000000000000..af2fdf1f55d6
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/load-store.json
@@ -0,0 +1,451 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Store-to-load conflicts (load unable to complete due to a non-forwardable conflict with an older store).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_locks.bus_lock",
+    "EventCode": "0x25",
+    "BriefDescription": "Retired Lock instructions which caused a bus lock.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_ret_cl_flush",
+    "EventCode": "0x26",
+    "BriefDescription": "Retired CLFLUSH instructions."
+  },
+  {
+    "EventName": "ls_ret_cpuid",
+    "EventCode": "0x27",
+    "BriefDescription": "Retired CPUID instructions."
+  },
+  {
+    "EventName": "ls_dispatch.ld_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory load operations dispatched to the load-store unit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dispatch.store_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory store operations dispatched to the load-store unit.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dispatch.ld_st_dispatch",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory load-store operations dispatched to the load-store unit.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dispatch.all",
+    "EventCode": "0x29",
+    "BriefDescription": "Number of memory operations dispatched to the load-store unit.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "ls_smi_rx",
+    "EventCode": "0x2b",
+    "BriefDescription": "SMIs received."
+  },
+  {
+    "EventName": "ls_int_taken",
+    "EventCode": "0x2c",
+    "BriefDescription": "Interrupts taken."
+  },
+  {
+    "EventName": "ls_stlf",
+    "EventCode": "0x35",
+    "BriefDescription": "Store-to-load-forward (STLF) hits."
+  },
+  {
+    "EventName": "ls_st_commit_cancel2.st_commit_cancel_wcb_full",
+    "EventCode": "0x37",
+    "BriefDescription": "Non-cacheable store commits cancelled due to the non-cacheable commit buffer being full.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_mab_alloc.load_store_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for load-store allocations.",
+    "UMask": "0x3f"
+  },
+  {
+    "EventName": "ls_mab_alloc.hardware_prefetcher_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for hardware prefetcher allocations.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_mab_alloc.all_allocations",
+    "EventCode": "0x41",
+    "BriefDescription": "Miss Address Buffer (MAB) entries allocated by a Load-Store (LS) pipe for all types of allocations.",
+    "UMask": "0x7f"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_l2",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.local_ccx",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.near_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_near",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.far_cache",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.dram_io_far",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.alternate_memories",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_dmnd_fills_from_sys.all",
+    "EventCode": "0x43",
+    "BriefDescription": "Demand data cache fills from all types of data sources.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_l2",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_ccx",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.local_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from local L2 cache or L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.near_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_near",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.remote_cache",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from cache of another CCX when the address was in the same or a different NUMA node.",
+    "UMask": "0x14"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_far",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.dram_io_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in any NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.far_all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either cache of another CCX, DRAM or MMIO when the address was in a different NUMA node (same or different socket).",
+    "UMask": "0x50"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.all_dram_io",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from either DRAM or MMIO in any NUMA node (same or different socket).",
+    "UMask": "0x48"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.alternate_memories",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_any_fills_from_sys.all",
+    "EventCode": "0x44",
+    "BriefDescription": "Any data cache fills from all types of data sources.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 4k pages.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 2M pages.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_hit",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB hits for 1G pages.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_4k_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 4k pages.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_coalesced_page_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for coalesced pages. A coalesced page is a 16k page created from four adjacent 4k pages.",
+    "UMask": "0x20"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_2m_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 2M pages.",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.tlb_reload_1g_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for 1G pages.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all_l2_miss",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses with L2 DTLB misses (page-table walks are requested) for all page sizes.",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "ls_l1_d_tlb_miss.all",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB misses for all page sizes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_misal_loads.ma64",
+    "EventCode": "0x47",
+    "BriefDescription": "64B misaligned (cacheline crossing) loads.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_misal_loads.ma4k",
+    "EventCode": "0x47",
+    "BriefDescription": "4kB misaligned (page crossing) loads.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchT0 (move data to all cache levels), T1 (move data to all cache levels except L1) and T2 (move data to all cache levels except L1 and L2).",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_w",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchW (move data to L1 cache and mark it modifiable).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.prefetch_nta",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of type PrefetchNTA (move data with minimum cache pollution i.e. non-temporal access).",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_pref_instr_disp.all",
+    "EventCode": "0x4b",
+    "BriefDescription": "Software prefetch instructions dispatched (speculative) of all types.",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "wcb_close.full_line_64b",
+    "EventCode": "0x50",
+    "BriefDescription": "Number of events that caused a Write Combining Buffer (WCB) entry to close because all 64 bytes of the entry have been written to.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.data_pipe_sw_pf_dc_hit",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a data cache hit.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.mab_mch_cnt",
+    "EventCode": "0x52",
+    "BriefDescription": "Software prefetches that did not fetch data outside of the processor core as the PREFETCH instruction saw a match on an already allocated Miss Address Buffer (MAB).",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_inef_sw_pref.all",
+    "EventCode": "0x52",
+    "BriefDescript6ion": "Software prefetches that did not fetch data outside of the processor core for any reason.",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_l2",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.local_ccx",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.near_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from cache of another CCX in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.far_cache",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from cache of another CCX in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.alternate_memories",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_sw_pf_dc_fills.all",
+    "EventCode": "0x59",
+    "BriefDescription": "Software prefetch data cache fills from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_l2",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from local L2 cache.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.local_ccx",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from L3 cache or different L2 cache in the same CCX.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.near_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in the same NUMA node.",
+    "UMask": "0x04"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_near",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in the same NUMA node.",
+    "UMask": "0x08"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.far_cache",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from cache of another CCX when the address was in a different NUMA node.",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.dram_io_far",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from either DRAM or MMIO in a different NUMA node (same or different socket).",
+    "UMask": "0x40"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.alternate_memories",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from extension memory.",
+    "UMask": "0x80"
+  },
+  {
+    "EventName": "ls_hw_pf_dc_fills.all",
+    "EventCode": "0x5a",
+    "BriefDescription": "Hardware prefetch data cache fills from all types of data sources.",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "ls_alloc_mab_count",
+    "EventCode": "0x5f",
+    "BriefDescription": "In-flight L1 data cache misses i.e. Miss Address Buffer (MAB) allocations each cycle."
+  },
+  {
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Core cycles not in halt."
+  },
+  {
+    "EventName": "ls_tlb_flush.all",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes.",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "ls_not_halted_p0_cyc.p0_freq_cyc",
+    "EventCode": "0x120",
+    "BriefDescription": "Reference cycles (P0 frequency) not in halt .",
+    "UMask": "0x1"
+  }
+]
-- 
2.34.1


