Return-Path: <linux-kernel+bounces-54300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8184AD78
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707AA283CC9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 04:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C52A77635;
	Tue,  6 Feb 2024 04:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bbieBiMO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38A077642
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 04:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707193928; cv=none; b=VHbdkz47B0leQN6RmFVCz2YQu40eiMPrgi4WPPSBqm+fmJCYsF3CAMKd5NRlKKqxOTWBiJzYqfZLhgaIlLJsKiXDtLITsRwGmUBv2dX/N1aQ7AVzlb9yJCGsSZ9/EjvtaHGTVTUAXMlTZfkF9j6ytmrXItxVao4yd9e6HcCAxNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707193928; c=relaxed/simple;
	bh=AxYpZmmSfejTvSrlt2lrpZ90ipai/hGyIHlWgTXCTVA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=EMe8TGamAStWjmxdoZhx5ZoUqO3Nxba6WDPQ/JZZj6XhaotW97EIGqvC9+O+4RS4ofgVxDK0KvO5GUmtF0JxpcwHwYbh6n74izVPN0o05ft819/nTZ+btDUfeREmUx9dKtZMeVTybb+PFNQQJn1/6t1onmaPeDH4N58G7RPtkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bbieBiMO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so5863762276.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 20:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707193926; x=1707798726; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZIdcfMjd0pHTXittFkoI9gm5TNhxImmZIlV61ZvhK6g=;
        b=bbieBiMOmqBOUN+WUpr4Rc66yF75zBos5jrQxiZUcDGMXh0m03DuuL+vL22w0gfUHM
         ajXO3zbbfDLEbvfowwQbJW7Z1bUsOlcVCg2kjXjFjIx5wN8Csv5soyYBI4rPdhgLCJj3
         0wVD1XD7sct48s7yIIld2HvVDyv7gG35vzHrMY+lfy+Ayv0RoC58OLz+FyeHcjXEF/ti
         FwCBDeP9MoEjza0xz2AuoURKmgXSMMV4N/rF9rKbljnYuo2m1yx0AKr0AvdOPpcmZKnm
         98kIZza71eG2HYQZogY0EBjAnl2RqrwJK91+neVN3+Up1QGEXAa5eK2nTo3Q3pq5jtdv
         fX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707193926; x=1707798726;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZIdcfMjd0pHTXittFkoI9gm5TNhxImmZIlV61ZvhK6g=;
        b=xT7ftAFQ+HGOwF8nNk+519sIIQaU7TIOB+q5hzMjf9SmA7Ubl0+tdy22gcK0MCdxvW
         0q7mhcyHJXWm9Ku3077vnx8V7Qj4JKFedLRftncY69HkbrHKfbMZ8xrANmR7yaz7r5dC
         VBxzCJQSoWryxzk2Eq/ZF7EyL3oZ17DqeHGW3WQho/fH+ytpyvXpD7EO7mGB5zQDMb6l
         1DjziZrfv1pO+vxDZg/8+q4kXHpyKYw/zMpDX6VzRXTP9wq+dfFCYw4RQe5g1D1us2+I
         li7AYCtlwJ2jPvhY6OorPe2lVXQezPS53qf/JnhNNA5S60c36FTv8SLl/d3RjqypjDkU
         H0Ew==
X-Gm-Message-State: AOJu0YygkG9Yi52KiAQEACKlyNgWsH1962hNGtGUINc84qpAP+T6jvc3
	rpfcfDHnNOflPyG7NWNSiJmtwSjOu6kS8I5cJ8xf+1xmxfDrv88qZF+pdITkwatSbClJj8x1u04
	8Yuh9yg==
X-Google-Smtp-Source: AGHT+IEHizuUSsLdvyZQlUQEn4TtgjoBKMA6PHcEPTFcdqoYThQruDguVEUCfTVhUoINolqsYyPuYAsyQaUX
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:326b:71bb:e465:6f39])
 (user=irogers job=sendgmr) by 2002:a05:6902:240b:b0:dc6:b982:cfa2 with SMTP
 id dr11-20020a056902240b00b00dc6b982cfa2mr19283ybb.8.1707193925952; Mon, 05
 Feb 2024 20:32:05 -0800 (PST)
Date: Mon,  5 Feb 2024 20:31:57 -0800
Message-Id: <20240206043159.2539981-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 1/3] perf stat: Pass fewer metric arguments
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

To reduce the size of the diff, local variables are added to match the
previous parameter names. This isn't done in the case of "name" as
evsel->name is more intention revealing. A whitespace issue is also
addressed.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/stat-shadow.c | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index e31426167852..b3a25659b9e6 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -355,11 +355,12 @@ static void print_nsecs(struct perf_stat_config *config,
 		print_metric(config, ctxp, NULL, NULL, "CPUs utilized", 0);
 }
 
-static int prepare_metric(struct evsel **metric_events,
-			  struct metric_ref *metric_refs,
+static int prepare_metric(const struct metric_expr *mexp,
 			  struct expr_parse_ctx *pctx,
 			  int aggr_idx)
 {
+	struct evsel * const *metric_events = mexp->metric_events;
+	struct metric_ref *metric_refs = mexp->metric_refs;
 	int i;
 
 	for (i = 0; metric_events[i]; i++) {
@@ -403,7 +404,7 @@ static int prepare_metric(struct evsel **metric_events,
 			if (!aggr)
 				break;
 
-                        if (!metric_events[i]->supported) {
+			if (!metric_events[i]->supported) {
 				/*
 				 * Not supported events will have a count of 0,
 				 * which can be confusing in a
@@ -441,18 +442,18 @@ static int prepare_metric(struct evsel **metric_events,
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
+			   struct metric_expr *mexp,
+			   struct evsel *evsel,
 			   int aggr_idx,
 			   struct perf_stat_output_ctx *out)
 {
 	print_metric_t print_metric = out->print_metric;
+	const char *metric_name = mexp->metric_name;
+	const char *metric_expr = mexp->metric_expr;
+	const char *metric_threshold = mexp->metric_threshold;
+	const char *metric_unit = mexp->metric_unit;
+	struct evsel * const *metric_events = mexp->metric_events;
+	int runtime = mexp->runtime;
 	struct expr_parse_ctx *pctx;
 	double ratio, scale, threshold;
 	int i;
@@ -467,7 +468,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
+	i = prepare_metric(mexp, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -502,18 +503,18 @@ static void generic_metric(struct perf_stat_config *config,
 				print_metric(config, ctxp, color, "%8.2f",
 					metric_name ?
 					metric_name :
-					out->force_header ?  name : "",
+					out->force_header ?  evsel->name : "",
 					ratio);
 			}
 		} else {
 			print_metric(config, ctxp, color, /*unit=*/NULL,
 				     out->force_header ?
-				     (metric_name ? metric_name : name) : "", 0);
+				     (metric_name ?: evsel->name) : "", 0);
 		}
 	} else {
 		print_metric(config, ctxp, color, /*unit=*/NULL,
 			     out->force_header ?
-			     (metric_name ? metric_name : name) : "", 0);
+			     (metric_name ?: evsel->name) : "", 0);
 	}
 
 	expr__ctx_free(pctx);
@@ -528,7 +529,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -630,10 +631,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 
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


