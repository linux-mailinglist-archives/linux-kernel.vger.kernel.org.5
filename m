Return-Path: <linux-kernel+bounces-74185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E980485D0E0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 189331C22F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600CC3A28E;
	Wed, 21 Feb 2024 07:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XrF/1n7d"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD3C3A8E3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708499279; cv=none; b=h3NomfiOeRQpS9Bmbqy9ylH7O5GAsuvYs3kJeTpJU5+zRW4fYrwU0QnCv3fh/mGyyGPYm4/KscnZjlwgKKvMRPYk2X4Mp02tbylE78TU819IpwpRCZnP0ZdM7Qt/h/1LY8CKp+DelLO4f2wbMIflZYRLw+NCmBSSOcnqNO5IIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708499279; c=relaxed/simple;
	bh=Vctcg2i0KcfuRuGiF34q8FKyaNU+WFLIoo1taHhTiGA=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=JihDLXVvDbTBcXCjybdctB2HJpxCtoT0gOsAdzw+3jAQgDb13e2g7V8LN2G/++O0jiGRu6QFWXstumXuvaMTNtIen3m4qmo7adAea8OXDMueF/rDY/y/RJt+4+FMOo9IW5uXljROVQACD8a654RInCyhtjMZSARXrIHXjonlsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XrF/1n7d; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-602dae507caso103810417b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:07:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708499277; x=1709104077; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=XrF/1n7dOXKAH5wwlFadyQT+L3Z6MR53hW/PKAjj+2En2vZI9bzH9ynIoY3vETgytt
         TG3qmFQPUux+TK0yo1csf/5DvXHXFFEPzh4ptDxH4PRAvosOb6LZwE543X/I+mFb+ZVz
         NsV8Qp5M0pQTczBSMiuMoVKTxpoXfUsVCQYVFNHFLlX8sBYQDv/w6qdzYj+VmUevsyjh
         6ho48hzhNE93SRUqEodChE7Gc8ltK+QAX9MuBMjHvr0hUCQ1dquctIgKsP0Lz35teJ0V
         0TL97/tQ3IAH46OU5ruNnB1T7PPMAuUEhI7QVSxYgUCKrbIAZjLgZYg12GAl+USPGaOX
         wGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708499277; x=1709104077;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjKYmJzQl8F9/gAiKS0z/bm1yBfw+nAatzaAOGPVP0k=;
        b=n2NFfRfdRcQl9bdGqfV+eUZNHrB29pyx9YI+hHipyIw2I3tMKAx5kSTkpjkl7ysYqP
         L+jAC5HxSrIu1u0Q74fwE46yLFEWuIjdluJJXrS7Urn1JgjE0SveWNcq+dhqEogCK3N1
         lrYi2QSFxU1gwRtvEGmcwqew0j1qB9xkIqVnu//xUz4T/njZF8DbFbiHMsfoUcbtgSbD
         lQvsDQCZBm46taN9qzolD7mwArAihzL6yAr6UdoFaIn1klPnzgEEYLPMZeLgEp2p+N2F
         JMatdqeip6dxADqWgZX6ALHySSnzH0YbTIjGmh/hK4J/3K1C+TqMmUT22dgaAvU00uXU
         inlg==
X-Forwarded-Encrypted: i=1; AJvYcCV21/erLd9wt5qur70JSBmTyf7yqQM4HcBj9Jd9UHGGRQyL7F0Uwz1Kx6LJmPUd/a+u0vBrGOTGL1G+c6uyScOdkL62VT9Ob8nNsGnQ
X-Gm-Message-State: AOJu0YwSUXupJeYU5M65r6gd4h4sxcrMF8Ld7dhAaHAZ6QLEJN63xJfM
	/MW6Cj/wrvoxz7/ssuLS3eA376Ji0iCnSrgVrNRzUkF8DfDJDMxaW3gUx1rsWqPXPBI6GO63e+7
	O9DXPaQ==
X-Google-Smtp-Source: AGHT+IHqlDDgcr3rxtaox3ghXBLqkcK54ihRY+l5S7iwLrcnlNm+aa7RnDj8IoptqZzHNtAsKnMzftEqUTMC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2a3:200:3c02:f882:5876:b7ab])
 (user=irogers job=sendgmr) by 2002:a0d:d9c6:0:b0:608:77cd:bbfd with SMTP id
 b189-20020a0dd9c6000000b0060877cdbbfdmr485456ywe.1.1708499276945; Tue, 20 Feb
 2024 23:07:56 -0800 (PST)
Date: Tue, 20 Feb 2024 23:07:52 -0800
Message-Id: <20240221070754.4163916-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Subject: [PATCH v3 1/3] perf stat: Pass fewer metric arguments
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
Acked-by: Namhyung Kim <namhyung@kernel.org>
---
v3 is a rebase fixing a merge conflict with
6d6be5eb45b4 ("perf metric: Don't remove scale from counts")
---
 tools/perf/util/stat-shadow.c | 38 +++++++++++++++++------------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index cf573ff3fa84..10b452792037 100644
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
@@ -436,18 +437,18 @@ static int prepare_metric(struct evsel **metric_events,
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
@@ -462,7 +463,7 @@ static void generic_metric(struct perf_stat_config *config,
 		pctx->sctx.user_requested_cpu_list = strdup(config->user_requested_cpu_list);
 	pctx->sctx.runtime = runtime;
 	pctx->sctx.system_wide = config->system_wide;
-	i = prepare_metric(metric_events, metric_refs, pctx, aggr_idx);
+	i = prepare_metric(mexp, pctx, aggr_idx);
 	if (i < 0) {
 		expr__ctx_free(pctx);
 		return;
@@ -497,18 +498,18 @@ static void generic_metric(struct perf_stat_config *config,
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
@@ -523,7 +524,7 @@ double test_generic_metric(struct metric_expr *mexp, int aggr_idx)
 	if (!pctx)
 		return NAN;
 
-	if (prepare_metric(mexp->metric_events, mexp->metric_refs, pctx, aggr_idx) < 0)
+	if (prepare_metric(mexp, pctx, aggr_idx) < 0)
 		goto out;
 
 	if (expr__parse(&ratio, pctx, mexp->metric_expr))
@@ -625,10 +626,7 @@ void *perf_stat__print_shadow_stats_metricgroup(struct perf_stat_config *config,
 
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
2.44.0.rc1.240.g4c46232300-goog


