Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A909B809133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443634AbjLGTYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443303AbjLGTXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:23:54 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC2C10DC;
        Thu,  7 Dec 2023 11:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701977040; x=1733513040;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QVlIun+x/zTN7Nk+iIQmAHUfj+TS02eKqQOTDnYg8xg=;
  b=MuGyOXuO0hIDMXLXFSCufABkIIBg0uCT9ZwBI6Ae7ld7mi0hu3XNNLeh
   +eTOoSb3RyrIVxozZoZgMNiwy3/na0lzUZjpLFq5IPOvftTVvt5pigz1r
   mGQMOFY2Q/o/4xJ6H0bs50FZFd1sQN9gE0kH9CHGzH6LKycnJeXbTmwEt
   wt6z0lh3VYdLLoP2yzvcTvBQ4dUyu8M6bEhB6uqJFcVCEVxM7IYXZEdWs
   tVWf3STNRjXy67cw0Q7joRrS6XXGzLdR2G7a0AyanLsC3/FeSn47z+QBw
   jjfrgR4AhCqcC882NwxSXMQfq9HjCHujNW4BaRlWBJVGgV5ONm0VMmRi4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="425431785"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="425431785"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 11:23:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="721589171"
X-IronPort-AV: E=Sophos;i="6.04,258,1695711600"; 
   d="scan'208";a="721589171"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 07 Dec 2023 11:23:57 -0800
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
Subject: [PATCH V2 5/5] perf mem: Clean up is_mem_loads_aux_event()
Date:   Thu,  7 Dec 2023 11:23:38 -0800
Message-Id: <20231207192338.400336-6-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231207192338.400336-1-kan.liang@linux.intel.com>
References: <20231207192338.400336-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The aux_event can be retrieved from the perf_pmu now. Implement a
generic support.

Reviewed-by: Ian Rogers <irogers@google.com>
Tested-by: Ravi Bangoria <ravi.bangoria@amd.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/arch/x86/util/mem-events.c | 23 ++++-------------------
 tools/perf/util/mem-events.c          | 14 ++++++++++++--
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/tools/perf/arch/x86/util/mem-events.c b/tools/perf/arch/x86/util/mem-events.c
index b776d849fc64..62df03e91c7e 100644
--- a/tools/perf/arch/x86/util/mem-events.c
+++ b/tools/perf/arch/x86/util/mem-events.c
@@ -1,11 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
-#include "util/pmu.h"
-#include "util/pmus.h"
-#include "util/env.h"
-#include "map_symbol.h"
-#include "mem-events.h"
 #include "linux/string.h"
-#include "env.h"
+#include "util/map_symbol.h"
+#include "util/mem-events.h"
+#include "mem-events.h"
+
 
 #define MEM_LOADS_AUX		0x8203
 
@@ -28,16 +26,3 @@ struct perf_mem_event perf_mem_events_amd[PERF_MEM_EVENTS__MAX] = {
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
index 0d174f161034..d418320e52e3 100644
--- a/tools/perf/util/mem-events.c
+++ b/tools/perf/util/mem-events.c
@@ -103,9 +103,19 @@ static const char *perf_pmu__mem_events_name(int i, struct perf_pmu *pmu)
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
 
 int perf_pmu__mem_events_parse(struct perf_pmu *pmu, const char *str)
-- 
2.35.1

