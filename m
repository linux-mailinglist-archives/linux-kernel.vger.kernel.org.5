Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847518120D1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442530AbjLMVgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 16:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjLMVgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:36:44 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D2FD0;
        Wed, 13 Dec 2023 13:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702503410; x=1734039410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wuxih5kxzunVAuhYR0tbSjKsKpQAlm8S+2cJPq2Ei9E=;
  b=Hsr2moDPObkKKOJKfYyH/9HYa7pazQd9OC7VcJQcLMLXG/Bk6wuUDove
   2JARuiR7SU3a7o/j0Dk9foIFH4gFddSdQFHsEobxnmwHiZ8Aq0JYXpDeo
   5mf98i+8cCugsmDfcUXVkJQiawh4IgwD+Lek7rWGXFDuhQfJ7iI8AGWWK
   V+EfB/dDCt+CVurnu+vDNRZEqWvYEkmIC7a9rY4fa3ZVpeioRXYrEv7jJ
   cHcD+mXBx9I1AE0XtJuqbI3mp15MxZIBCk9S88F6LXRLoohgz9AlB+SZb
   iEZ1TOFY8GOcdIfaHTG6e0Kl8r+n2iFOcbAZdaeLyA+czQ3vEKxoGPUtc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="8426585"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="8426585"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 13:36:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="723811718"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="723811718"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orsmga003.jf.intel.com with ESMTP; 13 Dec 2023 13:36:48 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 2/2] perf top: Uniform the event name for the hybrid machine
Date:   Wed, 13 Dec 2023 13:36:33 -0800
Message-Id: <20231213213633.1088026-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231213213633.1088026-1-kan.liang@linux.intel.com>
References: <20231213213633.1088026-1-kan.liang@linux.intel.com>
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

It's hard to distinguish the default cycles events among hybrid PMUs.
For example,

 $perf top
Available samples
385 cycles:P
903 cycles:P

The other tool, e.g., perf record, uniforms the event name and adds the
hybrid PMU name before opening the event. So the events can be easily
distinguished. Apply the same methodology for the perf top as well.

The record__uniquify_name() will be invoked by both record and top.
Move it to util/record.c

With the patch
 $perf top
Available samples
148 cpu_atom/cycles:P/
1K cpu_core/cycles:P/

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

New patch to address the display concern
https://lore.kernel.org/lkml/e9383607-1e43-4c1a-9512-29f27784d035@linux.intel.com/

 tools/perf/builtin-record.c | 28 +---------------------------
 tools/perf/builtin-top.c    |  1 +
 tools/perf/util/record.c    | 25 +++++++++++++++++++++++++
 tools/perf/util/record.h    |  2 ++
 4 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..a096422a4a14 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2216,32 +2216,6 @@ static void hit_auxtrace_snapshot_trigger(struct record *rec)
 	}
 }
 
-static void record__uniquify_name(struct record *rec)
-{
-	struct evsel *pos;
-	struct evlist *evlist = rec->evlist;
-	char *new_name;
-	int ret;
-
-	if (perf_pmus__num_core_pmus() == 1)
-		return;
-
-	evlist__for_each_entry(evlist, pos) {
-		if (!evsel__is_hybrid(pos))
-			continue;
-
-		if (strchr(pos->name, '/'))
-			continue;
-
-		ret = asprintf(&new_name, "%s/%s/",
-			       pos->pmu_name, pos->name);
-		if (ret) {
-			free(pos->name);
-			pos->name = new_name;
-		}
-	}
-}
-
 static int record__terminate_thread(struct record_thread *thread_data)
 {
 	int err;
@@ -2475,7 +2449,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (data->is_pipe && rec->evlist->core.nr_entries == 1)
 		rec->opts.sample_id = true;
 
-	record__uniquify_name(rec);
+	record__uniquify_name(rec->evlist);
 
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index cce9350177e2..4e8296654280 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	record__uniquify_name(top->evlist);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 9eb5c6a08999..5b4be3c72cbc 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -289,3 +289,28 @@ int record__parse_freq(const struct option *opt, const char *str, int unset __ma
 	opts->user_freq = freq;
 	return 0;
 }
+
+void record__uniquify_name(struct evlist *evlist)
+{
+	struct evsel *pos;
+	char *new_name;
+	int ret;
+
+	if (perf_pmus__num_core_pmus() == 1)
+		return;
+
+	evlist__for_each_entry(evlist, pos) {
+		if (!evsel__is_hybrid(pos))
+			continue;
+
+		if (strchr(pos->name, '/'))
+			continue;
+
+		ret = asprintf(&new_name, "%s/%s/",
+			       pos->pmu_name, pos->name);
+		if (ret) {
+			free(pos->name);
+			pos->name = new_name;
+		}
+	}
+}
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index a6566134e09e..9b520ab784bc 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -8,6 +8,7 @@
 #include <linux/stddef.h>
 #include <linux/perf_event.h>
 #include "util/target.h"
+#include "util/evlist.h"
 
 struct option;
 
@@ -85,6 +86,7 @@ extern const char * const *record_usage;
 extern struct option *record_options;
 
 int record__parse_freq(const struct option *opt, const char *str, int unset);
+void record__uniquify_name(struct evlist *evlist);
 
 static inline bool record_opts__no_switch_events(const struct record_opts *opts)
 {
-- 
2.35.1

