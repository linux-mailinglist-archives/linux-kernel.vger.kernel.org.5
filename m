Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7542277E3C2
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343698AbjHPOhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343672AbjHPOgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:36:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFA2716
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692196605; x=1723732605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RJQpqVhp/J0JVh9w0dugk99Po3YUskR+nXFrDSlLI1E=;
  b=hJOoshkVhD2cSVWWFrAXOGUEkFud2Btf0Bqv8ABJ949HY4/AV3rLzXsB
   hWxPL1ozJwSQE6Wbw+A2zGg5js/WqtRORMpZuby2WH3yIwDWBfjNWWZpQ
   3hrAcvkYXY+GfdqpLq6eIJtsJ4dSh+cmPsCag3RcfQX7BTl1z98LiM+eR
   0wBiiDpXxargOiA4H2fxO8qujjs6Iv+m3PTTW0h95h9gy0vdmtU3X2bcN
   ZySxytpYX62uTHOPXpKGp51ERR4ERYbXbJzHtDubT1ZR7BEMh+CTcYIaK
   7zCcZ1hZUloN6yBPrsB6MIsWozI8hzfT68KMJqJOnz1KZ9YO2hP+Vwmhf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352138637"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="352138637"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 07:36:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="980758845"
X-IronPort-AV: E=Sophos;i="6.01,177,1684825200"; 
   d="scan'208";a="980758845"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2023 07:36:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/6] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag
Date:   Wed, 16 Aug 2023 07:36:24 -0700
Message-Id: <20230816143628.1885281-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230816143628.1885281-1-kan.liang@linux.intel.com>
References: <20230816143628.1885281-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Currently, branch_sample_type !=0 is used to check whether a branch
stack setup is required. But it doesn't check the sample type,
unnecessary branch stack setup may be done for a counting event. E.g.,
perf record -e "{branch-instructions,branch-misses}:S" -j any
Also, the event with the new PERF_SAMPLE_BRANCH_EVT_CNTRS branch sample
type may not require a branch stack setup either.

Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
a branch stack setup. Replace the needs_branch_stack() by checking the
new flag.

The counting event check is implemented here. The later patch will take
the new PERF_SAMPLE_BRANCH_EVT_CNTRS into account.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch

 arch/x86/events/intel/core.c       | 14 +++++++++++---
 arch/x86/events/perf_event_flags.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0f4ce79de4f8..8434315b765f 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2518,9 +2518,14 @@ static void intel_pmu_assign_event(struct perf_event *event, int idx)
 		perf_report_aux_output_id(event, idx);
 }
 
+static __always_inline bool intel_pmu_needs_branch_stack(struct perf_event *event)
+{
+	return event->hw.flags & PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+}
+
 static void intel_pmu_del_event(struct perf_event *event)
 {
-	if (needs_branch_stack(event))
+	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_del(event);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
@@ -2831,7 +2836,7 @@ static void intel_pmu_add_event(struct perf_event *event)
 {
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_add(event);
-	if (needs_branch_stack(event))
+	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
 }
 
@@ -3908,7 +3913,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
 			x86_pmu.pebs_aliases(event);
 	}
 
-	if (needs_branch_stack(event)) {
+	if (needs_branch_stack(event) && is_sampling_event(event))
+		event->hw.flags  |= PERF_X86_EVENT_NEEDS_BRANCH_STACK;
+
+	if (intel_pmu_needs_branch_stack(event)) {
 		ret = intel_pmu_setup_lbr_filter(event);
 		if (ret)
 			return ret;
diff --git a/arch/x86/events/perf_event_flags.h b/arch/x86/events/perf_event_flags.h
index 1dc19b9b4426..a1685981c520 100644
--- a/arch/x86/events/perf_event_flags.h
+++ b/arch/x86/events/perf_event_flags.h
@@ -20,3 +20,4 @@ PERF_ARCH(TOPDOWN,		0x04000) /* Count Topdown slots/metrics events */
 PERF_ARCH(PEBS_STLAT,		0x08000) /* st+stlat data address sampling */
 PERF_ARCH(AMD_BRS,		0x10000) /* AMD Branch Sampling */
 PERF_ARCH(PEBS_LAT_HYBRID,	0x20000) /* ld and st lat for hybrid */
+PERF_ARCH(NEEDS_BRANCH_STACK,	0x40000) /* require branch stack setup */
-- 
2.35.1

