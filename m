Return-Path: <linux-kernel+bounces-125317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D856F8923E9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 20:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA071F2462F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4C713AD00;
	Fri, 29 Mar 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ICirVCke"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48780137928;
	Fri, 29 Mar 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739573; cv=none; b=lbmDiA5fG3mq8sWVFJdoYpkpF4tGRljWxStjDMwD3BnjiEv4TvpstunN5m0LgF+hEC8PeQrI4ilrjudyuJU4GV7MN7QASivClGMF0ll497b7u4dpkc0KfR40wg14lvN6jKOWJczdt670BwlwIdPnV3UCtAe5l152egYUCmtk6TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739573; c=relaxed/simple;
	bh=J9fUAQZWkixjtehQmnGr1yigtsctKtXiiA3rek8znyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dNachbhVhqG+wfK/EJBGIAXC3DKWpr5Z4F2o+7Iix4gGHdUSvgfmWN4v07daEyaXv6oj+Tg3NZeHf3GY0aaaH8ndNojeBTRR/bkXKUCHCaxYJKUOm1oWuZBLd5k2U29/EhmyaXajo6YTHVFuvQxd0+Vt0qQkiA+uAzgNf7J8WMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ICirVCke; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711739571; x=1743275571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J9fUAQZWkixjtehQmnGr1yigtsctKtXiiA3rek8znyk=;
  b=ICirVCkerIR0Bv5c1P0bixoJTuEBek9r6PYNsJGZtH+jMksZH4l/7Dw2
   uh7QMkNfastdbzsbEruTHQe81XMNiXHmo4c/up1wBN8hcKvwiEQjGCi7n
   jtqvWhZNX5tpotQ9uozQXDpKdXGsoIx3k6FzuW0Q+AwB3Lc2/MpQNkwYX
   pMreffM45X7JNXDUsDPahwHEAJspBhMf4J/IdJxSIsVvDW1uj7t+Fa2d2
   Dc44J9W8qddxrplZvnYSLHj7OR4Ng2Z5PHJNcnX4kXaGn0MeuNH1YXHwq
   iFECFos/ip+q387XToaURWA9tmhPOTdvnzv61kTAR2NquKoTJUO77wsHt
   A==;
X-CSE-ConnectionGUID: D4cJGdG5QbmUKKrjGc1/jA==
X-CSE-MsgGUID: OEmQoRIxTletT2avIY3O0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7531732"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7531732"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 12:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="54506862"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa001.jf.intel.com with ESMTP; 29 Mar 2024 12:12:46 -0700
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Namhyung Kim <namhyung@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions to print out at the very end of print out
Date: Fri, 29 Mar 2024 15:12:23 -0400
Message-ID: <20240329191224.1046866-5-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329191224.1046866-1-weilin.wang@intel.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add print out functions so that users could read retire latency values.

Example output:
In this simple example, there is no MEM_INST_RETIRED.STLB_HIT_STORES sample.
Therefore, the MEM_INST_RETIRED.STLB_HIT_STORES:p retire_latency value, count
and sum are all 0.

 Performance counter stats for 'system wide':

       181,047,168      cpu_core/TOPDOWN.SLOTS/          #      0.6 %  tma_dtlb_store
         3,195,608      cpu_core/topdown-retiring/
        40,156,649      cpu_core/topdown-mem-bound/
         3,550,925      cpu_core/topdown-bad-spec/
       117,571,818      cpu_core/topdown-fe-bound/
        57,118,087      cpu_core/topdown-be-bound/
            69,179      cpu_core/EXE_ACTIVITY.BOUND_ON_STORES/
             4,582      cpu_core/MEM_INST_RETIRED.STLB_HIT_STORES/
        30,183,104      cpu_core/CPU_CLK_UNHALTED.DISTRIBUTED/
        30,556,790      cpu_core/CPU_CLK_UNHALTED.THREAD/
           168,486      cpu_core/DTLB_STORE_MISSES.WALK_ACTIVE/
              0.00 MEM_INST_RETIRED.STLB_HIT_STORES:p       0        0

       1.003105924 seconds time elapsed

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-display.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..6c043d9c9f81 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -21,6 +21,7 @@
 #include "iostat.h"
 #include "pmu.h"
 #include "pmus.h"
+#include "metricgroup.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -34,6 +35,7 @@
 #define COMM_LEN     16
 #define PID_LEN       7
 #define CPUS_LEN      4
+#define RETIRE_LEN    8
 
 static int aggr_header_lens[] = {
 	[AGGR_CORE] 	= 18,
@@ -426,6 +428,67 @@ static void print_metric_std(struct perf_stat_config *config,
 	fprintf(out, " %-*s", METRIC_LEN - n - 1, unit);
 }
 
+static void print_retire_lat_std(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	bool newline = os->newline;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		if (newline)
+			do_new_line_std(config, os);
+		fprintf(out, "%'*.2f %-*s", COUNTS_LEN, t->val, EVNAME_LEN, t->event.name);
+		fprintf(out, "%*ld %*d\n", RETIRE_LEN, t->count,
+			 RETIRE_LEN, t->sum);
+	}
+}
+
+static void print_retire_lat_csv(struct perf_stat_config *config,
+				 struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+	const char *sep = config->csv_sep;
+
+	list_for_each_entry(t, retire_lats, event.nd) {
+		fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->event.name, sep,
+			t->count, sep, t->sum);
+	}
+}
+
+static void print_retire_lat_json(struct perf_stat_config *config,
+				  struct outstate *os)
+{
+	FILE *out = os->fh;
+	struct tpebs_retire_lat *t;
+	struct list_head *retire_lats = &config->tpebs_results;
+
+	fprintf(out, "{");
+	list_for_each_entry(t, retire_lats, event.nd) {
+		fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->val);
+		fprintf(out, "\"event-name\" : \"%s\"", t->event.name);
+		fprintf(out, "\"sample-counts\" : \"%ld\"", t->count);
+		fprintf(out, "\"retire_latency-sum\" : \"%d\"", t->sum);
+	}
+	fprintf(out, "}");
+}
+
+static void print_retire_lat(struct perf_stat_config *config,
+			     struct outstate *os)
+{
+	if (!&config->tpebs_results)
+		return;
+	if (config->json_output)
+		print_retire_lat_json(config, os);
+	else if (config->csv_output)
+		print_retire_lat_csv(config, os);
+	else
+		print_retire_lat_std(config, os);
+}
+
 static void new_line_csv(struct perf_stat_config *config, void *ctx)
 {
 	struct outstate *os = ctx;
@@ -1609,6 +1672,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
 		break;
 	}
 
+	print_retire_lat(config, &os);
+
 	print_footer(config);
 
 	fflush(config->output);
-- 
2.43.0


