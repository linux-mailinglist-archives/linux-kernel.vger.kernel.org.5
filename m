Return-Path: <linux-kernel+bounces-49088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7898465C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 419F21C21F37
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A301BBA2C;
	Fri,  2 Feb 2024 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IebxjMUz"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081B0C8E2
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 02:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706840726; cv=none; b=rVBJY5RmwHghfCLzlMv4+cHC1Jc+Gocfhmrn55PJLbDTldc9BHWOizhdNWtPILmd0mBPh/FBZl/uJefgiBRy549d+CMHanyhDa++15BDQqIk9HhR7RJQq4NechYMbM2bZgn78+XzpMAPBCdSjkeHO+7+xI7qUj6lxk8L8CkpjKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706840726; c=relaxed/simple;
	bh=Apyf/lQjAeZF0vEZHPtraJm82Drb9RxljHobQP0BUKc=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=oGnwC9/fOyLK7gSwC1mD0E50WC2pPkH8c/S1SLJNiRcic9ODdeswA40OqcUbC4sPopXCjV6lqczzuQ6QRolmWaXRgIzTKp2wVfe+UG3j1UX6iuHjaLMfqP5s1RV6MqnbP2WJjbzHXk2Q2bnPjk5ar5CAHOxrxHn4/+NqbMdclxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IebxjMUz; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6cd10fd4aso2526866276.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 18:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706840724; x=1707445524; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E2lLrgOYSu0z0B0apiOf7xEjXWyA4aM+SFmaQhqseRE=;
        b=IebxjMUzYtuA/N9XWNhWs7eYA/IkqGGebt1XkwNW4MqMSPr7Tx6tZlyQpJs3TPK0lJ
         10TJa1/0dJsgMbfXdpULOZrgECrL36Z/4w22Q6nwBn2ox+r6OGxkof41eW1i3IwBOZGG
         L5rDrdnKTGz6au+tuDkULeFLrkHy80zF06j5kqi+CPNdYGSSZB+ZorulrhqWWf/5dyPv
         M98lBGa+333Bk2BKEa0L31yB2X1dZng4iHMPjLhdlFXiWdNS8QK+chVi3Fc1zSYlnN/5
         o+4V3ACz52UFfyUQMeupDWld6VKqxVsgcbywi6usuVRNsXijEmOlt/eYMdBxVrFqwJYg
         bEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706840724; x=1707445524;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E2lLrgOYSu0z0B0apiOf7xEjXWyA4aM+SFmaQhqseRE=;
        b=I5kqTSIamrrX3lJ4Ocyd8PB4KGvZWV85Iw2AKWVXwM0aXEaqGE8tUFz4jw0buOe4Yi
         llSebBCn2+FEsmscT3s/X/FCClwlTQYes3EsDIa+QiGQmMLAu91WEDnstI4vrfv59B5r
         KbSeVeYDLeLQcIP36lbsNJ/GaMA/oi76+yq4E9QFa6xj2rUTjRd+hShxp5TGYHNfiea0
         xZxJklQNoD3D9R3thiKb2dnj4xJBE20GfoG8sAkW2ycnZfHS+tH4WcUIiDXAoSV/XBzo
         oIZgy2zkAjL8CFwzJCKCXjnfyK+h8Ir7+jaPMzjmU+o3SMSJaMfUOIb7R3YUXxzkxizn
         cLfg==
X-Gm-Message-State: AOJu0YxqN52FpezD/4OJzD3uD4Sl94aQa1otl3ex9J9VQlsHNUgF54i5
	8lApnAQO0KikarMM7y3Os0QZDWUBM17e2D+vJK2HtY/7WIiaG6vJEd8gk35GbNMjWIyG6OCGu40
	gHF1apw==
X-Google-Smtp-Source: AGHT+IEBEN37hliGugDjKjEjzYFsAr8ZyUoTzJc1/RGtBVqo6wdsJhnQWuvrcqGRSXoejhVzxxcOA3Fq/v5C
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:a85f:db1d:a66b:7f53])
 (user=irogers job=sendgmr) by 2002:a05:6902:993:b0:dc2:25fd:eff1 with SMTP id
 bv19-20020a056902099300b00dc225fdeff1mr148001ybb.4.1706840724037; Thu, 01 Feb
 2024 18:25:24 -0800 (PST)
Date: Thu,  1 Feb 2024 18:25:10 -0800
Message-Id: <20240202022512.467636-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v1 1/3] perf stat: Pass fewer metric arguments
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

Pass metric_expr and evsel rather than specific variables from the
struct, thereby reducing the number of arguments. This will enable
later fixes.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 75 +++++++++++++++--------------------
 1 file changed, 33 insertions(+), 42 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e31426167852..f6c9d2f98835 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,23 +355,22 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
-static int prepare_metric(struct evsel **metric_events,
-			  struct metric_ref *metric_refs,
+static int prepare_metric(const struct metric_expr *mexp,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
 	int i;
 
-	for (i = 0; metric_events[i]; i++) {
+	for (i = 0; mexp->metric_events[i]; i++) {
 		char *n;
 		double val;
 		int source_count = 0;
 
-		if (evsel__is_tool(metric_events[i])) {
+		if (evsel__is_tool(mexp->metric_events[i])) {
 			struct stats *stats;
 			double scale;
 
-			switch (metric_events[i]->tool_event) {
+			switch (mexp->metric_events[i]->tool_event) {
 			case PERF_TOOL_DURATION_TIME:
 				stats = &walltime_nsecs_stats;
 				scale = 1e-9;
@@ -391,19 +390,20 @@ static int prepare_metric(struct evsel **metric_events,
 				pr_err("Invalid tool event 'max'");
 				abort();
 			default:
-				pr_err("Unknown tool event '%s'", evsel__name(metric_events[i]));
+				pr_err("Unknown tool event '%s'",
+				       evsel__name(mexp->metric_events[i]));
 				abort();
 			}
 			val = avg_stats(stats) * scale;
 			source_count = 1;
 		} else {
-			struct perf_stat_evsel *ps = metric_events[i]->stats;
+			struct perf_stat_evsel *ps = mexp->metric_events[i]->stats;
 			struct perf_stat_aggr *aggr = &ps->aggr[aggr_idx];
 
 			if (!aggr)
 				break;
 
-                        if (!metric_events[i]->supported) {
+			if (!mexp->metric_events[i]->supported) {
 				/*
 				 * Not supported events will have a count of 0,
 				 * which can be confusing in a
@@ -419,19 +419,19 @@ static int prepare_metric(struct evsel **metric_events,
 				 * reverse the scale before computing the
 				 * metric.
 				 */
-				val = aggr->counts.val * (1.0 / metric_events[i]->scale);
-				source_count = evsel__source_count(metric_events[i]);
+				val = aggr->counts.val * (1.0 / mexp->metric_events[i]->scale);
+				source_count = evsel__source_count(mexp->metric_events[i]);
 			}
 		}
-		n = strdup(evsel__metric_id(metric_events[i]));
+		n = strdup(evsel__metric_id(mexp->metric_events[i]));
 		if (!n)
 			return -ENOMEM;
 
 		expr__add_id_val_source_count(pctx, n, val, source_count);
 	}
 
-	for (int j = 0; metric_refs && metric_refs[j].metric_name; j++) {
-		int ret = expr__add_ref(pctx, &metric_refs[j]);
+	for (int j = 0; mexp->metric_refs && mexp->metric_refs[j].metric_name; j++) {
+		int ret = expr__add_ref(pctx, &mexp->metric_refs[j]);
 
 		if (ret)
 			return ret;
@@ -441,14 +441,8 @@ static int prepare_metric(struct evsel **metric_events,
 }
 
 static void generic_metric(struct perf_stat_config *config,
-			   const char *metric_expr,
-			   const char *metric_threshold,
-			   struct evsel **metric_events,
-			   struct metric_ref *metric_refs,
-			   char *name,
-			   const char *metric_name,
-			   const char *metric_unit,
-			   int runtime,
+			struct metric_expr *mexp,
+			struct evsel *evsel,
 			   int aggr_idx,
 			   struct perf_stat_output_ctx *out)
 {
@@ -465,55 +459,55 @@ static void generic_metric(struct perf_stat_config *config,
 
 	if (config->user_requested_cpu_list)
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
-	pctx->sctx.runtime = runtime;
+	pctx->sctx.runtime = mexp->runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
+	i = prepare_metric(mexp, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
 	}
-	if (!metric_events[i]) {
-		if (expr__parse(&ratio, pctx, metric_expr) == 0) {
+	if (!mexp->metric_events[i]) {
+		if (expr__parse(&ratio, pctx, mexp->metric_expr) == 0) {
 			char *unit;
 			char metric_bf[64];
 
-			if (metric_threshold &&
-			    expr__parse(&threshold, pctx, metric_threshold) == 0 &&
+			if (mexp->metric_threshold &&
+			    expr__parse(&threshold, pctx, mexp->metric_threshold) == 0 &&
 			    !isnan(threshold)) {
 				color = fpclassify(threshold) == FP_ZERO
 					? PERF_COLOR_GREEN : PERF_COLOR_RED;
 			}
 
-			if (metric_unit && metric_name) {
-				if (perf_pmu__convert_scale(metric_unit,
+			if (mexp->metric_unit && mexp->metric_name) {
+				if (perf_pmu__convert_scale(mexp->metric_unit,
 					&unit, &scale) >= 0) {
 					ratio *= scale;
 				}
-				if (strstr(metric_expr, "?"))
+				if (strstr(mexp->metric_expr, "?"))
 					scnprintf(metric_bf, sizeof(metric_bf),
-					  "%s  %s_%d", unit, metric_name, runtime);
+					  "%s  %s_%d", unit, mexp->metric_name, mexp->runtime);
 				else
 					scnprintf(metric_bf, sizeof(metric_bf),
-					  "%s  %s", unit, metric_name);
+					  "%s  %s", unit, mexp->metric_name);
 
 				print_metric(config, ctxp, color, "%8.1f",
 					     metric_bf, ratio);
 			} else {
 				print_metric(config, ctxp, color, "%8.2f",
-					metric_name ?
-					metric_name :
-					out->force_header ?  name : "",
+					mexp->metric_name ?
+					mexp->metric_name :
+					out->force_header ?  evsel->name : "",
 					ratio);
 			}
 		} else {
 			print_metric(config, ctxp, color, /*unit=*/NULL,
 				     out->force_header ?
-				     (metric_name ? metric_name : name) : "", 0);
+				     (mexp->metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
 		print_metric(config, ctxp, color, /*unit=*/NULL,
 			     out->force_header ?
-			     (metric_name ? metric_name : name) : "", 0);
+			     (mexp->metric_name ?: evsel->name) : "", 0);
 	}
 
 	expr__ctx_free(pctx);
@@ -528,7 +522,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -630,10 +624,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 
 		if ((*num)++ > 0)
 			out->new_line(config, ctxp);
-		generic_metric(config, mexp->metric_expr, mexp->metric_threshold,
-			       mexp->metric_events, mexp->metric_refs, evsel->name,
-			       mexp->metric_name, mexp->metric_unit, mexp->runtime,
-			       aggr_idx, out);
+		generic_metric(config, mexp, evsel, aggr_idx, out);
 	}
 
 	return NULL;
-- 
2.43.0.594.gd9cf4e227d-goog


