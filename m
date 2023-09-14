Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013027A0751
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 16:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240146AbjINO3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 10:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240125AbjINO3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 10:29:05 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D1C110;
        Thu, 14 Sep 2023 07:29:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rd3rOLIy7Lx+fy5gJ9HA6MgAut1KfCS8uVDoQK3w0zPs1la2SMt+Z0KHkrlKzCv9ZTpcQkBcLWQGHaYNqIw/YffVERZEi75IWVxL7lsgRz4JIA92GpJpCQEDEoRZ57GJ5foAu4hSsp54MbmMkCQsubWWfFMaO/TuyQNcAO+XH9N9qju/qwMiP/aj7seiwJvFmennBF6VDWovmhAu4C72wxKJ1c69HINidtDjnv3FVQhiUWqEAu4zfucVFETg9Y8N/haXJ78ctivNA1y4wxfwJP4QkYDt8pwCjykMNILnSJ/FDMxbNChTRvZAUM7gkZ7zdlTrqlwyNKPskx9hXcnecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSYofqRRm126+9g84X3ZveMylelL/22rTu1GVEicA2Y=;
 b=AjxkgFppTKg1DKutCPr2DKz/lgZdDEpH/3M8qRlOU35RiVwFjL3u21Z9t+EaGEUiw/oqI3FSojFKuTeMyWKRqwkpG6bzBXLWcMqy6ab3mTBSOQdtlInoQyOcoGd7ErfVqGptzkmmYShTJk1J4ifYO98Edx5IceG2ZcYVqCZFwxl7c3sh5WBEfl60LFDDGinzDh7CoX0nGtDDraTYs2XQ9fQJKTwhz4d/gc1PdnqDmFAUrqCyefB14NDuh9eFCGo5hcUmZg5dv2DNFmf8bEIao69DV1TH/XN3wyJkAQ5fFmu+z/yizEcgRHBk4asMpxDdkJQKzFOuh3yyGNnzobLL9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSYofqRRm126+9g84X3ZveMylelL/22rTu1GVEicA2Y=;
 b=MCcK748r4Liz/Nkeepne/Z4twNBOC+K/FJG6aCY/a6IEBuszRcMTmphOOyX7NHufdOyd88H0JhnkuHhz66EGGxPC1Iu036v0SqtlU2q1fwthh66SD54GOXyVhMdpBA/rjw6IRbGiY80qgPxbYZ1IKJ+29iW4A3zAkYhSF7NvSu8=
Received: from BYAPR05CA0058.namprd05.prod.outlook.com (2603:10b6:a03:74::35)
 by DS0PR12MB9345.namprd12.prod.outlook.com (2603:10b6:8:1a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.39; Thu, 14 Sep
 2023 14:28:58 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::73) by BYAPR05CA0058.outlook.office365.com
 (2603:10b6:a03:74::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 14:28:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 14:28:57 +0000
Received: from sindhu.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 09:28:49 -0500
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
Subject: [PATCH v2 1/2] perf/x86/amd: Do not WARN on every IRQ
Date:   Thu, 14 Sep 2023 19:58:40 +0530
Message-ID: <3540f985652f41041e54ee82aa53e7dbd55739ae.1694696888.git.sandipan.das@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS0PR12MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b41464e-b60a-4450-dfce-08dbb52eee87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0nwbGT8L0XkfQkjKGCK54A0HemuzpsZL28ogts7LfJc2uYBuvijUZv4SyKMKMmfXFbhy5OiEXyJWaJFvfCs5vof2Er9QuZHqricMu+EVAdJrdzATbcZUIc0EpEqu395BhJPpdWKxjKY8SCR77xUB171ymQd622zL0/WgdhH4fMHkubeqtts2o7aPq85vNRLqjG02DaO84vHRD6E5467yXvGYwnN7f7hgZ6Q4kAqB81MeaASpU1JQ3onXf7soo0sqhCMDgyCRV3aC76czMaMxBr9kaM2BBewAkdEAYKzNlMo4FnNuiZrmZqfPhp30A16AxLdmx/wBTuhGcwZnZCZoeL+aHtGvpXh83jD28KAVeDzST73QgliV2vRUyuGGElGiGi/2u1aDf5CxCwucO9s4PUkamhrItIGwsMTKAS1JryGAuyv3Xp3ef0S9Wl01pyo7FJEezTDq5FaXdXlj5le3Ab25+YQD5Fsym9A7MnmNzo1yp8mwoayvTIKNcER+57fUOHneVFaNQycW2wx5s9pZdoFuIFcrb//wk6hP1KBXw5VXeI66sedg5pihJ+vMazR7yCp7VhBtBOXql5r44mPZrvR2SdGWMYlu+cMg6dGPdFONBRmKccT7c6RyToyppCPYAGUMUQ+rcJPzk8zTd7FuY4LzrxyKwORVrVM5FfzvQtDPeZi9ItqTRqx4+DYk1vLYr2VCDpQ2eI80WsVgi9v9HXVfbMxfNdH8SuW0K+gRiPlWco/H+5x0HGE++F3CMDVl1rUjzsVmjM7ETxA59CQiWmlEzDPL3yp37iiS9cWBfLs=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(136003)(39860400002)(376002)(1800799009)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(26005)(8676002)(4326008)(316002)(6666004)(8936002)(356005)(40480700001)(81166007)(82740400003)(2616005)(44832011)(478600001)(5660300002)(54906003)(110136005)(70206006)(70586007)(41300700001)(16526019)(966005)(83380400001)(426003)(336012)(47076005)(7416002)(2906002)(36860700001)(40460700003)(86362001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 14:28:57.6499
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b41464e-b60a-4450-dfce-08dbb52eee87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9345
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

Zen 4 systems running buggy microcode can hit a WARN_ON() in the PMI
handler, as shown below, several times while perf runs. A simple
`perf top` run is enough to render the system unusable.

WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0

This happens because the Performance Counter Global Status Register
(PerfCntGlobalStatus) has one or more bits set which are considered
reserved according to the "AMD64 Architecture Programmer’s Manual,
Volume 2: System Programming, 24593". The document can be found at
https://www.amd.com/system/files/TechDocs/24593.pdf

To make this less intrusive, warn just once if any reserved bit is set
and prompt the user to update the microcode. Also sanitize the value to
what the code is handling, so that the overflow events continue to be
handled for the number of counters that are known to be sane.

Going forward, the following microcode patch levels are recommended
for Zen 4 processors in order to avoid such issues with reserved bits.

  Family=0x19 Model=0x11 Stepping=0x01: Patch=0x0a10113e
  Family=0x19 Model=0x11 Stepping=0x02: Patch=0x0a10123e
  Family=0x19 Model=0xa0 Stepping=0x01: Patch=0x0aa00116
  Family=0x19 Model=0xa0 Stepping=0x02: Patch=0x0aa00212

Commit f2eb058afc57 ("linux-firmware: Update AMD cpu microcode") from
the linux-firmware tree has binaries that meet the minimum required
patch levels.

Fixes: 7685665c390d ("perf/x86/amd/core: Add PerfMonV2 overflow handling")
Reported-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
[sandipan: add message to prompt users to update microcode]
[sandipan: rework commit message and call out required microcode levels]
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
---

v1: https://lore.kernel.org/all/20230616115316.3652155-1-leitao@debian.org/

v2:
 - Use pr_warn_once() instead of WARN_ON_ONCE() to prompt users to
   update microcode
 - Rework commit message and add details of minimum required microcode
   patch levels.

---
 arch/x86/events/amd/core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index abadd5f23425..b04956cbd085 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -884,7 +884,7 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 	struct hw_perf_event *hwc;
 	struct perf_event *event;
 	int handled = 0, idx;
-	u64 status, mask;
+	u64 reserved, status, mask;
 	bool pmu_enabled;
 
 	/*
@@ -909,6 +909,14 @@ static int amd_pmu_v2_handle_irq(struct pt_regs *regs)
 		status &= ~GLOBAL_STATUS_LBRS_FROZEN;
 	}
 
+	reserved = status & ~amd_pmu_global_cntr_mask;
+	if (reserved)
+		pr_warn_once("Reserved PerfCntrGlobalStatus bits are set (0x%llx), please consider updating microcode\n",
+			     reserved);
+
+	/* Clear any reserved bits set by buggy microcode */
+	status &= amd_pmu_global_cntr_mask;
+
 	for (idx = 0; idx < x86_pmu.num_counters; idx++) {
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
-- 
2.34.1

