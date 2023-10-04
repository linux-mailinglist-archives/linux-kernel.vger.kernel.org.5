Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25E047B8AD4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:40:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244510AbjJDSkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjJDSks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D7EEC
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444843; x=1727980843;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQgPOe5NH396br31I0Ovdo2DX5aYXqmioMy/hZgz9B0=;
  b=eU1D3wL8ur2DCFx0ESTw6V/dw8mQTumm/cLDOvo7So3O2rzdipF44e63
   D98gv9IhbsnlLOmnla56wAdQuGte3JAv8VPafhBPzsSVRIZJjp/UyuoEK
   VWfCvyRbz65FOR2SDsi5hqaVbotqTb+F31ndNosb7OcAO6M7VKeTBKTp9
   6fGeMRAfOdMy/Gp2FRdaFPgEBeFQgayF+52iKOU9pkd4oLeDPSUNbePgK
   jbDi7L7fl/cTVCPHVGy6c8BUGFQ2BKTiXtHfTQBUSAqUHWxvLJ/1tSI1i
   Eq6+6z2RcqBPF0h666cSG8a+slb6GE9neDwvXMNOUw53vnUpSZkaB8gG2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537681"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537681"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786625991"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786625991"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:42 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/7] perf/x86: Add PERF_X86_EVENT_NEEDS_BRANCH_STACK flag
Date:   Wed,  4 Oct 2023 11:40:39 -0700
Message-Id: <20231004184044.3062788-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231004184044.3062788-1-kan.liang@linux.intel.com>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
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
Also, the event only with the new PERF_SAMPLE_BRANCH_COUNTERS branch
sample type may not require a branch stack setup either.

Add a new flag NEEDS_BRANCH_STACK to indicate whether the event requires
a branch stack setup. Replace the needs_branch_stack() by checking the
new flag.

The counting event check is implemented here. The later patch will take
the new PERF_SAMPLE_BRANCH_COUNTERS into account.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V3

 arch/x86/events/intel/core.c       | 14 +++++++++++---
 arch/x86/events/perf_event_flags.h |  1 +
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 41a164764a84..a99449c0d77c 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2527,9 +2527,14 @@ static void intel_pmu_assign_event(struct perf_event *event, int idx)
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
@@ -2820,7 +2825,7 @@ static void intel_pmu_add_event(struct perf_event *event)
 {
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_add(event);
-	if (needs_branch_stack(event))
+	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
 }
 
@@ -3897,7 +3902,10 @@ static int intel_pmu_hw_config(struct perf_event *event)
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

