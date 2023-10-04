Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6CE7B8AE3
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 20:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244545AbjJDSlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 14:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244424AbjJDSkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:40:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1AEAB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 11:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696444847; x=1727980847;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ryFIqRU8d+k5vrrd/DhvLkz8QtLNCGDdpOoAexf0NM=;
  b=dFugwkXKFJhBS9nUHccxCylXTkyphj3ZagShiJRVTZd4eOU9mm1cCIhB
   3MkrKT0j86wuURnvFwoV7gqxdFH/YqBW8KEVlQLKnouv0hiBiR/LSNWEk
   WB83CQ57nhcaB3ZmqfjpBxpGAhH6crM5WoiKI/ZmPFKq/SDcT2pqq+4Uq
   c6/GQYSV6YRjXB0Hxz0ttXnk8oa3/vS+lyGi5IrTtHWtHOye1Lppa/K/N
   F82+csyhMicOiTBLVgzmYVb6GttyEqYP+I6rlTxLT9Kytm9HqUlhCnnT4
   V8Kj8VFskLT3XWL8n0D8/c8VJOtu4rXHfeGh1mFhfLjtnS+/JofIOydNo
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="469537709"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="469537709"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 11:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="786626031"
X-IronPort-AV: E=Sophos;i="6.03,201,1694761200"; 
   d="scan'208";a="786626031"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga001.jf.intel.com with ESMTP; 04 Oct 2023 11:40:43 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 6/7] perf header: Support num and width of branch counters
Date:   Wed,  4 Oct 2023 11:40:43 -0700
Message-Id: <20231004184044.3062788-6-kan.liang@linux.intel.com>
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

To support the branch counters feature, the information of the maximum
number of supported counters and the width of the counters is exposed
in the sysfs caps folder. The perf tool can use the information to parse
the logged counters in each branch.

Store the information in the perf_env for later usage.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch

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

