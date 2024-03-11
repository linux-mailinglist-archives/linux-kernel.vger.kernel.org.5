Return-Path: <linux-kernel+bounces-98469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B89AE877A89
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A90B61C211DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A28F4A;
	Mon, 11 Mar 2024 05:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gf5PdqlB"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3ECC8E2;
	Mon, 11 Mar 2024 05:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710134636; cv=fail; b=FVViuGR66lfFrdwdo4vYXP8H+sOMj94/swnDPnYjKPfnM/Z+3cekR4+qs41wXqgac5SFzeCV4yoVbcMoQ0p8bNESD/oI96MOZdNXYeTaGsqJ7rudcKSOlXqH9GSImeaCcIeVrEVu16da2/xtfma3E1jEk1e0kO/9aKmY8QFxpZo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710134636; c=relaxed/simple;
	bh=e2MFbbJ9pWgGmCsTO3EKj61p+cDsyvvGaZZyu9acCTM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GE0yDw+LS9qjM1JT7kSztVZQC38r/kYdHvDOH94+fCfmMEo4bI6Jyq45+RHqUYc2Tukh9u5mnVDjsZh/xk4qWEXhQ159hA11zOo4wfo+HqycVvuX5SNZCit5iPEbzsp6DqYmYQ3T9/smg9M/g9uZMCEDQmidvt2cYZjIOuAIx7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gf5PdqlB; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=asut2I3bxMifA4uiWYSEl0DgsD7HqVSgodbvnej5I4rWq2xgKynw6QSP1/celSeFdXzencxpSPH7lcbD3G5hyIv5QJCMStgdIl22m4lwahuEJ2jNK+ykO6/7gQiw+TiSdTyrELFMWkEVHv6tb/5dUh3GRROC9fiE6kiJIPDia0Zq6QqWkZtV0HDd1KEZXpUwlHUH8S1/JovQxB3c22VeNKa4UEViGHp8IYsagZFTi5QmQ8czT499Mb3M0ZtTSilI776jihVDUDFZHxcYMPFLoh3YsiYm/4C4TY9g+B6wlwhNTxCKRDJBN+YyfAM/651I/eN1fZfk85oMap+2mMH9Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfsNHAViyp9Cp4iUeTVZ9UAcn8FqCqt+C6KF3YA+e0Q=;
 b=cWWnUmlO3niqWWiCZM55I6Xlq7Q/62e6ydbXD4V083aPZ/Zg9GdC6Wt++Xwf6lYR5Nr+tkdPIt1V4tbBMc1gHf1zxJWDKYn/EAlIjJrwyAD565jEf/iR8rPGklCGloyjQWTPpYwdeeUTBVqcOE/l+Bn2MidGnnmU50sFGapZyhyJAtfXMz6HLyS0kc/C1+rkHjdLlfm8Y4uwghmWdiOZ6dkz8ZMnwFdXGQoPROw4Tp42Lv/QhcnBbt6Svo9Lj2he8eKwNtbYj8as2k/sIX3YtQIddPj1xq+hTtvpgo+HwgLDvAdgi07iIQV0RtDYTQiVRVRQ6ICUY0a0iqFuHZXwwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bfsNHAViyp9Cp4iUeTVZ9UAcn8FqCqt+C6KF3YA+e0Q=;
 b=gf5PdqlBh6dCfTOaVUTKp5S3rA1M22/mWa1WL9pnFxTVWxxslsOxWWsV5i8q+UcoBAAvi9YH3cRYBU1gYotdBlcjdQNW6+tlsSHlw/HXilL6ftZ6zyxhuh7o6JCwb32jH/v2r4smfftcQeF/kZcP3kU1AaMZ/XHHwEVA2oP7hzU=
Received: from MN2PR10CA0030.namprd10.prod.outlook.com (2603:10b6:208:120::43)
 by SJ2PR12MB7865.namprd12.prod.outlook.com (2603:10b6:a03:4cc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 05:23:49 +0000
Received: from BL6PEPF0001AB50.namprd04.prod.outlook.com
 (2603:10b6:208:120:cafe::5) by MN2PR10CA0030.outlook.office365.com
 (2603:10b6:208:120::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 05:23:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB50.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Mon, 11 Mar 2024 05:23:48 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 00:23:43 -0500
From: Sandipan Das <sandipan.das@amd.com>
To: <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
	<namhyung@kernel.org>, <mark.rutland@arm.com>,
	<alexander.shishkin@linux.intel.com>, <jolsa@kernel.org>,
	<irogers@google.com>, <adrian.hunter@intel.com>, <eranian@google.com>,
	<ravi.bangoria@amd.com>, <ananth.narayan@amd.com>, <sandipan.das@amd.com>
Subject: [PATCH 1/4] perf vendor events amd: Add Zen 5 core events
Date: Mon, 11 Mar 2024 10:53:15 +0530
Message-ID: <0d18c3a93083f12481f27dcc5f5795877fa02b90.1710133771.git.sandipan.das@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB50:EE_|SJ2PR12MB7865:EE_
X-MS-Office365-Filtering-Correlation-Id: b3df7526-507f-4f20-cdd6-08dc418b6e33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+N6YzhrullWHVgyKqJRCNDhPGpxjmxXQYn/UJsMcWJVm0vIIXdr7eD5qBgtsmWRkHPZFubebDsm047zzu3P+TUQOjWtQl0oDB9WXvoWoBjvK1z6MGthvwW0oG5/H81DroO9BbG2DU1sXk1Eq7iOL59Lz7jhSgCT8+/j5ZQnc8sOvEk7XcE7JN6Gh2YTlmgCLYnCZyV9/yqVMMIjOptaQEFsu3ldm+H7YDDiPc4TTEJHmmybXTLef7AHfR+MbwswUWW88I0wJFybWRBOo6GUD50zuWMUSe6PkcxoE0VQsXFT/6hpdZfiKCjgTx6rqjRGrYfblX3vAjtVkzMAaT+BYHdvAj2Ybh9EwbDTV767ulVKfMi1LaAZediNCDY+uvjWOFvlDzr0d+ByHvKgXXu8xFW+S9WRVzqlix19YkMzgMzi/SPvCriAM6sXB/WYk2EXebxgSaFy4Dx30vxejkfqzLSQtlYilzuLXLcpZmcyqAwqyAXkDXiCfNgmMxK0WR3YbZDwsyAwRwgn91hmF6Tv+HGprBmelMwWaJ5V2xy5H/FZ8EjG/dknr/ZoBTCKVlR3QryNDYiaa2mFqrtAd2FMGWl0982c9B5xE1W9GCZujKxdzjx+iyXrvJV8HEHIF8xDvRcuOhTZxwHftqXgmutOI+2UYvP+Y9lcx9rYW4h4SRAnLezCB00xpqKHCsyNba8ox39xUY2COodCRYQm8DSonIA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 05:23:48.4447
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3df7526-507f-4f20-cdd6-08dc418b6e33
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB50.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7865

Add core events taken from Section 1.4 "Core Performance Monitor
Counters" of the Performance Monitor Counters for AMD Family 1Ah Model
00h-0Fh Processors document available at the link below. This
constitutes events which capture information on op dispatch, execution
and retirement, branch prediction, L1 and L2 cache activity,
TLB activity, etc.

Link: https://bugzilla.kernel.org/attachment.cgi?id=305974
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---
 .../pmu-events/arch/x86/amdzen5/branch.json   |  82 ++
 .../pmu-events/arch/x86/amdzen5/cache.json    | 605 +++++++++++++
 .../pmu-events/arch/x86/amdzen5/core.json     | 122 +++
 .../arch/x86/amdzen5/floating-point.json      | 830 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen5/memory.json   | 180 ++++
 .../pmu-events/arch/x86/amdzen5/other.json    | 168 ++++
 6 files changed, 1987 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/branch.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/cache.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/core.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/memory.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen5/other.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/branch.json b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
new file mode 100644
index 000000000000..208c646c59ca
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/branch.json
@@ -0,0 +1,82 @@
+[
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
+    "BriefDescription": "Instruction decoder corrects the predicted target and resteers the branch predictor."
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
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/cache.json b/tools/perf/pmu-events/arch/x86/amdzen5/cache.json
new file mode 100644
index 000000000000..03d62bb6824b
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/cache.json
@@ -0,0 +1,605 @@
+[
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
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/core.json b/tools/perf/pmu-events/arch/x86/amdzen5/core.json
new file mode 100644
index 000000000000..a56a41828bd4
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/core.json
@@ -0,0 +1,122 @@
+[
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
+    "EventName": "ls_not_halted_cyc",
+    "EventCode": "0x76",
+    "BriefDescription": "Core cycles not in halt."
+  },
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
+    "EventName": "ls_not_halted_p0_cyc.p0_freq_cyc",
+    "EventCode": "0x120",
+    "BriefDescription": "Reference cycles (P0 frequency) not in halt .",
+    "UMask": "0x1"
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
+    "EventName": "ex_ret_fused_instr",
+    "EventCode": "0x1d0",
+    "BriefDescription": "Retired fused instructions."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
new file mode 100644
index 000000000000..cb95a2e3e4c3
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/floating-point.json
@@ -0,0 +1,830 @@
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
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/memory.json b/tools/perf/pmu-events/arch/x86/amdzen5/memory.json
new file mode 100644
index 000000000000..d7329023a8e9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/memory.json
@@ -0,0 +1,180 @@
+[
+  {
+    "EventName": "ls_bad_status2.stli_other",
+    "EventCode": "0x24",
+    "BriefDescription": "Store-to-load conflicts (load unable to complete due to a non-forwardable conflict with an older store).",
+    "UMask": "0x02"
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
+    "EventName": "ls_tlb_flush.all",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLB Flushes.",
+    "UMask": "0xff"
+  },
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
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen5/other.json b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
new file mode 100644
index 000000000000..9d49a23622e9
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen5/other.json
@@ -0,0 +1,168 @@
+[
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
+  },
+  {
+    "EventName": "de_op_queue_empty",
+    "EventCode": "0xa9",
+    "BriefDescription": "Cycles when the op queue is empty. Such cycles indicate that the front-end is not delivering instructions fast enough."
+  },
+  {
+    "EventName": "de_src_op_disp.decoder",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops fetched from instruction cache and dispatched.",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "de_src_op_disp.op_cache",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops fetched from op cache and dispatched.",
+    "UMask": "0x02"
+  },
+  {
+    "EventName": "de_src_op_disp.loop_buffer",
+    "EventCode": "0xaa",
+    "BriefDescription": "Ops dispatched from loop buffer.",
+    "UMask": "0x04"
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
+    "EventName": "de_dis_ops_from_decoder.disp_op_type.any_integer_dispatch",
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
+    "EventName": "de_dispatch_stall_cycle_dynamic_tokens_part1.int_phy_flag_reg_file_rsrc_stall",
+    "EventCode": "0xae",
+    "BriefDescription": "Cycles where a dispatch group is valid but does not get dispatched due to an integer physical flag register file resource stall.",
+    "UMask": "0x08"
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
-- 
2.34.1


