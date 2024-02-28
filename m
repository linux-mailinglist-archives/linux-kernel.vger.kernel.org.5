Return-Path: <linux-kernel+bounces-85338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8227786B466
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45881C21680
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712401649A7;
	Wed, 28 Feb 2024 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fq+AlfDB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CAC15F314;
	Wed, 28 Feb 2024 16:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709136764; cv=none; b=A9Lr8OJic2FztRnq+Ie7/hMOlzI+AFVNtB06DZWkFcO95lMpZb3gBFCq+49ivWrQ/NOoI+C+ibcoataXGsRSkdc4ztgW8BdO9FlAMIMhHIC/pAUr3BUYsO2t0J1cvXkizX7uez0kcty0OqC+8SmJ2BoISZwKZQohHYyHYIAt1r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709136764; c=relaxed/simple;
	bh=SQctvRJ39Y6FTztBS6nvv5clzEQieh9m50qo+ZNGlrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JeztCtDyUJfX6ANe6v/1unnjQUjrMx77K9iVFlM5vYpSLEf4Ylvg2B5KZQ9Mr0VJesMAWG0Jm3dIm+DNYFinRanndsehrzcS2KanO58NpVgWVnVGl6aiSb0oJM91XypJG+OBZaK3TxUEc1MQHGdaMatyRl2a7d6XS7Cp47h4jk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fq+AlfDB; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709136763; x=1740672763;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SQctvRJ39Y6FTztBS6nvv5clzEQieh9m50qo+ZNGlrY=;
  b=fq+AlfDB4XAmYzlERJuB7hsJv35g50vTG7K5qIlyWiT6sVpjpZ7qkDtP
   /0neexrC66iM8Vvmn/goqBDdPddZUfWETmta9tfkQY5Q0cmdVNFek6tos
   ehlyNDabQIJU+bYH/R8TLx89U/MzAxshX4ISrUXewz3SF67lnjO2wFJnr
   4hjC/g+c3L2FcILPyWhnyNbNMM9wwlZOovcGO+6SkeMCOQKQsRUCqYgSY
   gqQjYg1gA0mhI9pWooOoO6hwRA3GcZTiDG6fyosScYjoMwz6Eyf2qfpxN
   xEj+MuA9xTDDMROnZ+0KqoxP2eRflYfKaZ1GXiZXjo5+vq9hUbTkVINRJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14185465"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14185465"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 08:12:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7418106"
Received: from fl31ca102ks0602.deacluster.intel.com (HELO gnr-bkc.deacluster.intel.com) ([10.75.133.163])
  by orviesa010.jf.intel.com with ESMTP; 28 Feb 2024 08:12:37 -0800
From: weilin.wang@intel.com
To: weilin.wang@intel.com,
	Ian Rogers <irogers@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Perry Taylor <perry.taylor@intel.com>,
	Samantha Alt <samantha.alt@intel.com>,
	Caleb Biggers <caleb.biggers@intel.com>
Subject: [RFC PATCH v2 5/6] perf stat: Add retire latency print functions to print out at the very end of print out
Date: Wed, 28 Feb 2024 11:12:26 -0500
Message-ID: <20240228161227.484886-6-weilin.wang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240228161227.484886-1-weilin.wang@intel.com>
References: <20240228161227.484886-1-weilin.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weilin Wang <weilin.wang@intel.com>

Add print out functions so that users could read retire latency values.

Signed-off-by: Weilin Wang <weilin.wang@intel.com>
---
 tools/perf/util/stat-display.c | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index bfc1d705f437..e2996ba67bfe 100644
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
+	list_for_each_entry(t, retire_lats, nd) {
+		if (newline)
+			do_new_line_std(config, os);
+		fprintf(out, "%'*.2f %-*s", COUNTS_LEN, t->val, EVNAME_LEN, t->name);
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
+	list_for_each_entry(t, retire_lats, nd) {
+		fprintf(out, "%f%s%s%s%s%ld%s%d\n", t->val, sep, sep, t->name, sep,
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
+	list_for_each_entry(t, retire_lats, nd) {
+		fprintf(out, "\"retire_latency-value\" : \"%f\", ", t->val);
+		fprintf(out, "\"event-name\" : \"%s\"", t->name);
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


