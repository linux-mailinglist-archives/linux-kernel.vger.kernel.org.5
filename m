Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFF2807937
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:14:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442907AbjLFUNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442887AbjLFUNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:13:32 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FA41A5;
        Wed,  6 Dec 2023 12:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701893617; x=1733429617;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sDPNIp9IXTZNk2JbRgBfRXncy7cROcPc5+X7nvCxRM0=;
  b=Rm4RPvVD9f7MNq5+3vW8wb7VqF5AYzvL+Z6lUVqLgQhAkHtPTdazcJgf
   YxhDk7MPMuwWCzdNwRhqdZzpS8H+BuhvYfHTHrXy1QoIWbjR0ftm+nRmS
   yBn7zfGdFKQiOHb430mSlTMosclqiegcF2pI7PI3Ukwvca0QfosQkcOGw
   y5QfcUvY7kngAvgSru80A4ouTnI9ZSCrTIrPtGO+2xNOqOjI3ekPVpWvP
   6wNOCowXVBcUhRIcrDLBuHxTxJI9pVHs4pBQOYKx/fiRLT8R6EME3XZs1
   +TQG7oivcsqibRik73IkdV00F/DC/B9oVrqIMiwe604t+CK3Q5AmFMlic
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="458445588"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="458445588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 12:13:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="944766683"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="944766683"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2023 12:13:32 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com, peterz@infradead.org,
        mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, john.g.garry@oracle.com, will@kernel.org,
        james.clark@arm.com, mike.leach@linaro.org, leo.yan@linaro.org,
        yuhaixin.yhx@linux.alibaba.com, renyu.zj@linux.alibaba.com,
        tmricht@linux.ibm.com, ravi.bangoria@amd.com,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 5/6] perf mem: Clean up is_mem_loads_aux_event()
Date:   Wed,  6 Dec 2023 12:13:23 -0800
Message-Id: <20231206201324.184059-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231206201324.184059-1-kan.liang@linux.intel.com>
References: <20231206201324.184059-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The aux_event can be retrieved from the perf_pmu now. Implement a
generic support.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 13 -------------
 tools/perf/util/mem-events.c          | 14 ++++++++++++--
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b776d849fc64..71ffe16de751 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -28,16 +28,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
 	E(NULL,		NULL,		NULL,	false,	0),
 	E("mem-ldst",	"%s//",		NULL,	false,	0),
 };
-
-bool is_mem_loads_aux_event(struct evsel *leader)
-{
-	struct perf_pmu *pmu = perf_pmus__find("cpu");
-
-	if (!pmu)
-		pmu = perf_pmus__find("cpu_core");
-
-	if (pmu && !perf_pmu__have_event(pmu, "mem-loads-aux"))
-		return false;
-
-	return leader->core.attr.config == MEM_LOADS_AUX;
-}
diff --git a/tools/perf/util/mem-events.c b/tools/perf/util/mem-events.c
index 9ea9e9a868c4..336d1109b3a5 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -103,9 +103,19 @@ static const char *perf_mem_events__name(int i, struct perf_pmu *pmu)
 	return NULL;
 }
 
-__weak bool is_mem_loads_aux_event(struct evsel *leader __maybe_unused)
+bool is_mem_loads_aux_event(struct evsel *leader)
 {
-	return false;
+	struct perf_pmu *pmu = leader->pmu;
+	struct perf_mem_event *e;
+
+	if (!pmu || !pmu->mem_events)
+		return false;
+
+	e = &pmu->mem_events[PERF_MEM_EVENTS__LOAD];
+	if (!e->aux_event)
+		return false;
+
+	return leader->core.attr.config == e->aux_event;
 }
 
 int perf_mem_events__parse(struct perf_pmu *pmu, const char *str)
-- 
2.35.1

