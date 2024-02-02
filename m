Return-Path: <linux-kernel+bounces-49089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B5C8465C4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B57F61C22B99
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098D8C8F1;
	Fri,  2 Feb 2024 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QhAi7lLj"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62033BA24
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840729; cv=none; b=Clew1C2r9caxAaJacT0Ac+5RppAOEea/MM4hw+ye2NVR6qC0XkDOFFSbsqfD6LhC0GR4lN/aiAdMQRyBbPl0O1p0mUnoHPEyc+G5X+hliCRKDifUGXcETVRgophebfcsGXncMBtRp84vVJkDrXXTSuh1XpCpw/Zr9ma4+I1Gx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840729; c=relaxed/simple;
	bh=zuKDGBbvC8Z880JPqJda92bCCuSmaTxeQ7yu928nL2s=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=U/e/Dd0c8ajpCNcpzghO0xBPJV63n46d7OYw07h/0FbeYwxJ290QebCXYzIWC5iYWVZmFWNkyRLfinI31C47fAeXbyDXUctO+t/uj+cIiB03Ej6uKyTiqgOYIzMmu7ZiQdgm5EjPY7p7+I0HczWjdkyECWN/lRiglbSJNF2gYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QhAi7lLj; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6040597d005so32101457b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706840726; x=1707445526; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5l+BJ0TTHCM6A4VVZ55heq0k4VpuOGC5eZCLoF5zeOI=;
        b=QhAi7lLj+Jqz4lFXUIeCSIm8zOZjxZHwE+VkC1cCucx+xOr6iAasyDUIVi7AA+e0ln
         fr3uSUNt5Z2emg5LUUCYCzaZn71jwkkss/2uFr9aS0ZXZjFIaKtgKhLE28IrvJ3Wb9r1
         17a4CApQj0onrTaFTBc0F6n9pJ/aXzRe7uXWK2pVKvUd29GYMSdlGDA5rK5PnYSK7Leu
         GlqR9KUJ8smqlyYsN6aO7q0m1XVRpmmLURCm9Uk8T+9+mUm4KVa6izKJ4sCX1YDsNC5Q
         rj8LlAOa+06du87fhAQB8W4H6kn3XvknaH4OvfsvtEGMZx1KTU2/yHjNmrA7BuG76dGd
         VViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840726; x=1707445526;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5l+BJ0TTHCM6A4VVZ55heq0k4VpuOGC5eZCLoF5zeOI=;
        b=aSmRVhOJpi0LkP8WrUMMD/By/9+S3LIQ6pClCWEmLnugLpeu9fahf2yiGy4CXipFT7
         l3hsgInxl/Ur3kNnM0izwc7otA5cU6t9oF7uxH9olKYaQHehzOOf+ti+tD8IGwRLDBdZ
         MB1UQwTB8RfhA9A0EEOmmvWjSrkwPBtI+elj43p22rmRwTnDxwYVxSDBc7fzWazfQu+W
         76Gn4AMCpkk4mKjeCJml5JAf7izeIMCqw5nu0h4wNLgux7SahCoxIxEwCSuqQz5eRa0t
         zfoCr4gpM+3cH81U2qGXukZDkgxey3nM5oV+/j0ujFDRj0Trst1uVzVplaa2FJPkiTBE
         a/JQ==
X-Gm-Message-State: AOJu0Yx0cdQJg5HHC4Pzc0cwmc640fB4tcRPCO6jhtNG39XClYCAlV8u
	KsrJz7ZlIYNry/5QamjEjLYnfyhvzJsB23ikLpBKK2OW3Lv06mZrpiGmQPaq9BTORVHwPbkNLnW
	CNhOqww==
X-Google-Smtp-Source: AGHT+IF5hRDzZTsTh1hvne/IbGcQ4fJ5Y99/oSXQ9O1Kb/A/5KO749r5tyQ8uQXznuUtpGmnGZHNVQyftduS
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a81:4c0d:0:b0:5fb:7e5b:b87f with SMTP id
 z13-20020a814c0d000000b005fb7e5bb87fmr1522384ywa.1.1706840726259; Thu, 01 Feb
 2024 18:25:26 -0800 (PST)
Date: Thu,  1 Feb 2024 18:25:11 -0800
In-Reply-To: <20240202022512.467636-1-irogers@google.com>
Message-Id: <20240202022512.467636-2-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202022512.467636-1-irogers@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 2/3] perf metrics: Compute unmerged uncore metrics individually
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>, 
	John Garry <john.g.garry@oracle.com>, Kaige Ye <ye@kaige.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Stephane Eranian <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"

When merging counts from multiple uncore PMUs the metric is only
computed for the metric leader. When merging/aggregation is disabled,
prior to this patch just the leader's metric would be computed. Fix
this by computing the metric for each PMU.

On a SkylakeX:
Before:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               82,217      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.2 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               61,395      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               81,570      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU18             113,886      UNC_M_CAS_COUNT.RD [uncore_imc_2]
CPU0               62,330      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              66,942      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               75,489      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU18              27,958      UNC_M_CAS_COUNT.RD [uncore_imc_3]
CPU0               55,864      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              38,727      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4]
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               75,423      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU18             104,527      UNC_M_CAS_COUNT.RD [uncore_imc_5]
CPU0               57,596      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              56,777      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,440,851 ns   duration_time

       1.003440851 seconds time elapsed
```

After:
```
$ perf stat -A -M memory_bandwidth_total -a sleep 1

 Performance counter stats for 'system wide':

CPU0               88,968      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      9.5 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_0] #      0.0 MB/s  memory_bandwidth_total
CPU0               59,498      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_0]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_1] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_1]
CPU0               88,635      UNC_M_CAS_COUNT.RD [uncore_imc_2] #      9.5 MB/s  memory_bandwidth_total
CPU18             117,975      UNC_M_CAS_COUNT.RD [uncore_imc_2] #     11.5 MB/s  memory_bandwidth_total
CPU0               60,829      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU18              62,105      UNC_M_CAS_COUNT.WR [uncore_imc_2]
CPU0               82,238      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      8.7 MB/s  memory_bandwidth_total
CPU18              22,906      UNC_M_CAS_COUNT.RD [uncore_imc_3] #      3.6 MB/s  memory_bandwidth_total
CPU0               53,959      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU18              32,990      UNC_M_CAS_COUNT.WR [uncore_imc_3]
CPU0                    0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU18                   0      UNC_M_CAS_COUNT.RD [uncore_imc_4] #      0.0 MB/s  memory_bandwidth_total
CPU0                    0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU18                   0      UNC_M_CAS_COUNT.WR [uncore_imc_4]
CPU0               83,595      UNC_M_CAS_COUNT.RD [uncore_imc_5] #      8.9 MB/s  memory_bandwidth_total
CPU18             110,151      UNC_M_CAS_COUNT.RD [uncore_imc_5] #     10.5 MB/s  memory_bandwidth_total
CPU0               56,540      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU18              53,816      UNC_M_CAS_COUNT.WR [uncore_imc_5]
CPU0        1,003,353,416 ns   duration_time
```

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/metricgroup.c |  2 ++
 tools/perf/util/stat-shadow.c | 31 +++++++++++++++++++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index ca3e0404f187..c33ffee837ca 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -44,6 +44,8 @@ struct metric_event *metricgroup__lookup(struct rblist *metric_events,
 	if (!metric_events)
 		return NULL;
 
+	if (evsel->metric_leader)
+		me.evsel = evsel->metric_leader;
 	nd = rblist__find(metric_events, &me);
 	if (nd)
 		return container_of(nd, struct metric_event, nd);
diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index f6c9d2f98835..1be23b0eee2f 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -356,6 +356,7 @@ static void print_nsecs(struct perf_stat_config *config,
 }
 
 static int prepare_metric(const struct metric_expr *mexp,
+			  const struct evsel *evsel,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
@@ -398,8 +399,29 @@ static int prepare_metric(const struct metric_expr *mexp,
 			source_count = 1;
 		} else {
 			struct perf_stat_evsel *ps = mexp->metric_events[i]->stats;
-			struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
+			struct perf_stat_aggr *aggr;
 
+			/*
+			 * If there are multiple uncore PMUs and we're not
+			 * reading the leader's stats, determine the stats for
+			 * the appropriate uncore PMU.
+			 */
+			if (evsel && evsel->metric_leader &&
+			    evsel->pmu != evsel->metric_leader->pmu &&
+			    mexp->metric_events[i]->pmu == evsel->metric_leader->pmu) {
+				struct evsel *pos;
+
+				evlist__for_each_entry(evsel->evlist, pos) {
+					if (pos->pmu != evsel->pmu)
+						continue;
+					if (pos->metric_leader != mexp->metric_events[i])
+						continue;
+					ps = pos->stats;
+					source_count = 1;
+					break;
+				}
+			}
+			aggr = &ps->aggr[aggr_idx];
 			if (!aggr)
 				break;
 
@@ -420,7 +442,8 @@ static int prepare_metric(const struct metric_expr *mexp,
 				 * metric.
 				 */
 				val = aggr->counts.val * (1.0 / mexp->metric_events[i]->scale);
-				source_count = evsel__source_count(mexp->metric_events[i]);
+				if (!source_count)
+					source_count = evsel__source_count(mexp->metric_events[i]);
 			}
 		}
 		n = strdup(evsel__metric_id(mexp->metric_events[i]));
@@ -461,7 +484,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = mexp->runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(mexp, pctx, aggr_idx);
+	i = prepare_metric(mexp, evsel, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -522,7 +545,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, /*evsel=*/NULL, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
-- 
2.43.0.594.gd9cf4e227d-goog


