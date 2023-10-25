Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D336F7D7556
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 22:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343608AbjJYUQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 16:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234602AbjJYUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 16:16:29 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4AC1111
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 13:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264986; x=1729800986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FWhyaUPjAcNtL3dx8hvUjEBWItLPowPXDz8WeBgls/4=;
  b=YV+ao/fAsLcXHqiUAtCHWJbUcurTszswDa/xMRKHmx2Y+9a6NhA7yg87
   frqi+1NKn3w84EA4WrUEo1b6p/ZQNuaEOTA6hi2zGvQ7WO7rM9xj+z+Jv
   qVqN3lzNofmmLurZ8UMIYGbuVlspniwt+wcMKDxUrqfsFfIVtYxIjpBsN
   0srENp1egUp2DE8a03Dt+Ta0HKtWtvr2JRidO0YRK6IzP7DXX3V0dJW8s
   p20+clkV7PGVlY6+1ggHHV1UJdYqZQcU/NbeHWl3V08Ktn49yUpSZAweW
   GRCJLx3oUptIOqfPUeAyXafqtDfGw0RvIN2tif+XhVLaOIwHgthj/7xEv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="377758236"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="377758236"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="752459092"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="752459092"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga007.jf.intel.com with ESMTP; 25 Oct 2023 13:16:23 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V5 7/8] perf header: Support num and width of branch counters
Date:   Wed, 25 Oct 2023 13:16:25 -0700
Message-Id: <20231025201626.3000228-7-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231025201626.3000228-1-kan.liang@linux.intel.com>
References: <20231025201626.3000228-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

To support the branch counters feature, the information of the maximum
number of supported counters and the width of the counters is exposed
in the sysfs caps folder. The perf tool can use the information to parse
the logged counters in each branch.

Store the information in the perf_env for later usage.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

No changes since V4

 tools/perf/util/env.h    |  5 +++++
 tools/perf/util/header.c | 18 +++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 4566c51f2fd9..48d7f8759a2a 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -46,6 +46,9 @@ struct hybrid_node {
 struct pmu_caps {
 	int		nr_caps;
 	unsigned int    max_branches;
+	unsigned int	br_cntr_nr;
+	unsigned int	br_cntr_width;
+
 	char            **caps;
 	char            *pmu_name;
 };
@@ -62,6 +65,8 @@ struct perf_env {
 	unsigned long long	total_mem;
 	unsigned int		msr_pmu_type;
 	unsigned int		max_branches;
+	unsigned int		br_cntr_nr;
+	unsigned int		br_cntr_width;
 	int			kernel_is_64_bit;
 
 	int			nr_cmdline;
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index d812e1e371a7..9664062ba835 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -3256,7 +3256,9 @@ static int process_compressed(struct feat_fd *ff,
 }
 
 static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
-			      char ***caps, unsigned int *max_branches)
+			      char ***caps, unsigned int *max_branches,
+			      unsigned int *br_cntr_nr,
+			      unsigned int *br_cntr_width)
 {
 	char *name, *value, *ptr;
 	u32 nr_pmu_caps, i;
@@ -3291,6 +3293,12 @@ static int __process_pmu_caps(struct feat_fd *ff, int *nr_caps,
 		if (!strcmp(name, "branches"))
 			*max_branches = atoi(value);
 
+		if (!strcmp(name, "branch_counter_nr"))
+			*br_cntr_nr = atoi(value);
+
+		if (!strcmp(name, "branch_counter_width"))
+			*br_cntr_width = atoi(value);
+
 		free(value);
 		free(name);
 	}
@@ -3315,7 +3323,9 @@ static int process_cpu_pmu_caps(struct feat_fd *ff,
 {
 	int ret = __process_pmu_caps(ff, &ff->ph->env.nr_cpu_pmu_caps,
 				     &ff->ph->env.cpu_pmu_caps,
-				     &ff->ph->env.max_branches);
+				     &ff->ph->env.max_branches,
+				     &ff->ph->env.br_cntr_nr,
+				     &ff->ph->env.br_cntr_width);
 
 	if (!ret && !ff->ph->env.cpu_pmu_caps)
 		pr_debug("cpu pmu capabilities not available\n");
@@ -3344,7 +3354,9 @@ static int process_pmu_caps(struct feat_fd *ff, void *data __maybe_unused)
 	for (i = 0; i < nr_pmu; i++) {
 		ret = __process_pmu_caps(ff, &pmu_caps[i].nr_caps,
 					 &pmu_caps[i].caps,
-					 &pmu_caps[i].max_branches);
+					 &pmu_caps[i].max_branches,
+					 &pmu_caps[i].br_cntr_nr,
+					 &pmu_caps[i].br_cntr_width);
 		if (ret)
 			goto err;
 
-- 
2.35.1

