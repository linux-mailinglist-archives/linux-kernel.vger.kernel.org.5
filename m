Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7927E7AD00B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 08:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbjIYGUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 02:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjIYGUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 02:20:14 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619A0CF6;
        Sun, 24 Sep 2023 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695622802; x=1727158802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=434mI2QGF0/LiDNuizu0YRPTYvUdMUanr80HyTfwaXg=;
  b=gvySYfT9RN+RVqeOiLfgTWMBhSpEepZQiIg992i0XP21+dhj8buqGjc+
   IK1lZy5PFXkwPHmNhXE9cMdEOe0MRbQEUF/0qNcgo3B2xeWTDcV+yNkIq
   Y9LTwpetqkw7Lt2HGj6iLIBQdPA6rZr0FUXHKhkwSdkfmc+HY8coNVZMb
   r509zUcd5qRBJSrx6gxuCE0ntIDr6GY+VaesMgMu2/ZK2onM9JQoGjLH/
   3FFi6jGuFJPLe2jZ2E8/Il4FzR2PoLmo4FhqRtopxy/6fc/Sg8lEKtjfn
   CfdoI7OKGhJRTG5ZtW1sc7K0pFGcJDamhy+NJLFqXLZYTQ+EYSYkmcqFl
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="445279504"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="445279504"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2023 23:19:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="818494395"
X-IronPort-AV: E=Sophos;i="6.03,174,1694761200"; 
   d="scan'208";a="818494395"
Received: from b49691a75598.jf.intel.com ([10.54.34.22])
  by fmsmga004.fm.intel.com with ESMTP; 24 Sep 2023 23:19:20 -0700
From:   weilin.wang@intel.com
To:     weilin.wang@intel.com, Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Perry Taylor <perry.taylor@intel.com>,
        Samantha Alt <samantha.alt@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [RFC PATCH 16/25] perf stat: Update keyword core to default_core to adjust to the changes for events with no unit
Date:   Sun, 24 Sep 2023 23:18:15 -0700
Message-Id: <20230925061824.3818631-17-weilin.wang@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230925061824.3818631-1-weilin.wang@intel.com>
References: <20230925061824.3818631-1-weilin.wang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Weilin Wang <weilin.wang@intel.com>

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/pmu-events/jevents.py | 2 +-
 tools/perf/util/metricgroup.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 5614bc203..d8c2fd258 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -303,7 +303,7 @@ class JsonEvent:
           'cpu_core': 'cpu_core',
           'cpu_atom': 'cpu_atom',
           'ali_drw': 'ali_drw',
-          'Core': 'core',
+          'Core': 'default_core',
       }
       return table[unit] if unit in table else f'uncore_{unit.lower()}'
 
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 2e7a8e315..7884cb036 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -2085,7 +2085,7 @@ static int hw_aware_build_grouping(struct expr_parse_ctx *ctx __maybe_unused,
 		pr_debug("found event %s\n", id);
 		if (!strncmp(id, special_pattern, strlen(special_pattern))) {
 			struct metricgroup__event_info *event;
-			event = event_info__new(id, "core", "0", true);
+			event = event_info__new(id, "default_core", "0", true);
 			if (!event) {
 				ret = -ENOMEM;
 				goto err_out;
-- 
2.39.3

