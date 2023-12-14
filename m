Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5057781337C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 15:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573409AbjLNOqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 09:46:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjLNOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 09:46:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF24C127;
        Thu, 14 Dec 2023 06:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702565210; x=1734101210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W+QcQYPBRRILXjXpljiq/9qSGzmY+l3Ffaxs/VbS0Pw=;
  b=PLelfZiRhENXQ7Ea5Ms4qAVqT33bUMhOuLQqra7gW/FJHwN8RNQowZu1
   k6fN0vP8h/6O1IJy7pNeBW3FgATi5FKofpAM2kTRiFNe64NTjaZ+mm7sj
   qOF+MoKhoKZS0tlTcIKIx9gUQcNbylTNuWEfTJ7rQLuWrs5B8XROwFY4H
   kTbOrGBEJfIcyAzWGQqgDkESx4byK+SF2z7T4520M8fC0F39d+c7JYFoy
   k1NKFbXsEq14MbWib/Yx92g66P4i1xQHJMps077XrNFI0FHS0fSIJ006/
   G8kk/mqo6JCkQywiK2tpbD9LHgyt1ChRpwDzksZyGU1jUPe3smSNpM7x2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="16676498"
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="16676498"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 06:46:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,275,1695711600"; 
   d="scan'208";a="22434530"
Received: from kanliang-dev.jf.intel.com ([10.165.154.102])
  by orviesa001.jf.intel.com with ESMTP; 14 Dec 2023 06:46:45 -0800
From:   kan.liang@linux.intel.com
To:     acme@kernel.org, irogers@google.com
Cc:     namhyung@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        marcan@marcan.st, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V4 2/2] perf top: Uniform the event name for the hybrid machine
Date:   Thu, 14 Dec 2023 06:46:12 -0800
Message-Id: <20231214144612.1092028-2-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20231214144612.1092028-1-kan.liang@linux.intel.com>
References: <20231214144612.1092028-1-kan.liang@linux.intel.com>
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

The evlist__uniquify_name() will be invoked by both record and top.
Move it to util/evlist.c

With the patch
 $perf top
Available samples
148 cpu_atom/cycles:P/
1K cpu_core/cycles:P/

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---

Changes since V3:
- rename the function to evlist__uniquify_name() and move it to
  util/evlist.c. (Namhyung)
- Add Reviewed-by from Ian
  (The change is just a rename and relocation. I think the tag still
  stands. Please let me know if there are other opinions.)

 tools/perf/builtin-record.c | 28 +---------------------------
 tools/perf/builtin-top.c    |  1 +
 tools/perf/util/evlist.c    | 25 +++++++++++++++++++++++++
 tools/perf/util/evlist.h    |  1 +
 4 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index dcf288a4fb9a..3a7e7484995d 100644
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
+	evlist__uniquify_name(rec->evlist);
 
 	/* Debug message used by test scripts */
 	pr_debug3("perf record opening and mmapping events\n");
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index cce9350177e2..cd64ae44ccbd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1299,6 +1299,7 @@ static int __cmd_top(struct perf_top *top)
 		}
 	}
 
+	evlist__uniquify_name(top->evlist);
 	ret = perf_top__start_counters(top);
 	if (ret)
 		return ret;
diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index e36da58522ef..fda411ab41e7 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -2518,3 +2518,28 @@ void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_lis
 	}
 	perf_cpu_map__put(user_requested_cpus);
 }
+
+void evlist__uniquify_name(struct evlist *evlist)
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
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index 98e7ddb2bd30..cb91dc9117a2 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -442,5 +442,6 @@ struct evsel *evlist__find_evsel(struct evlist *evlist, int idx);
 int evlist__scnprintf_evsels(struct evlist *evlist, size_t size, char *bf);
 void evlist__check_mem_load_aux(struct evlist *evlist);
 void evlist__warn_user_requested_cpus(struct evlist *evlist, const char *cpu_list);
+void evlist__uniquify_name(struct evlist *evlist);
 
 #endif /* __PERF_EVLIST_H */
-- 
2.35.1

