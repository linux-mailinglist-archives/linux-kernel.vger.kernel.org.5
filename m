Return-Path: <linux-kernel+bounces-137726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD289E667
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0EA21F230DC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87232159213;
	Tue,  9 Apr 2024 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aj0F8qkP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90894158DDE;
	Tue,  9 Apr 2024 23:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712706602; cv=none; b=GTko/Z+Rj1AFxlJVwXpdoNGvWWzEx7JdVos34FFBTZxMsBtCH6dIZXrZvrVdKvbtd24Z9SgCXNL3iu/4MZbwgMix9M8mCLAsrEf87DUg/Q0o4Ds+quOC71+vSkEyfH2KQLYgN/lWYfMj3Rh2MU5m+DNzYtBPHakAohU1hsi2bP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712706602; c=relaxed/simple;
	bh=0pW5q6KpdAEgOCgzS+L1xZu25Btzvfo5clIFIMC4pqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fncOZKetiW6Eb+zcAAU44H9b/H3GCyiJtSyrDGgHM7jymz84Fx/BoAVQQ+sXADvNNOgrkM7h8OXmQt2T9QmDwI3BXpjwVulc1mckOAC3ucPLPvvU5LRtXgjla/+pnFN5N2JTQFTQ/d75OwZMKP/nWPGobBtJsyeMSwgsFJqMtqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aj0F8qkP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EBE5C433C7;
	Tue,  9 Apr 2024 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712706602;
	bh=0pW5q6KpdAEgOCgzS+L1xZu25Btzvfo5clIFIMC4pqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Aj0F8qkP2y8wgqW1A0sAym5sAakKe/AgnNE8eLapmiw/QkUFNiDHciLu8kvRp8Lzu
	 ig5wEcX0Bim+FFMnMeKTxVBmiIlpT5aZQyYxDr7T9fDu0jv5UQuGzFxOJW4wOWG6qf
	 j3pLwfD1lb4GYyHPRurRYcGuosxQhiFKTuSXYbqT5NaXbQQENr0rmLUccNo+3Avjf9
	 MsLsRBFUUVJdK4kYvj3/v/lFBhKiE9Cd5Sei4yjrreYYEiIE1Ai5mgqQGeAdCejEdT
	 afrTRuMUz3sxy6oDpURIOd3tS3jkRBQBNfpJ0PeDASnzzxZ2081lcOQe/9s1bqL/F0
	 k/CFSyeZNjGGg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 2/6] perf annotate-data: Add hist_entry__annotate_data_tty()
Date: Tue,  9 Apr 2024 16:49:56 -0700
Message-ID: <20240409235000.1893969-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240409235000.1893969-1-namhyung@kernel.org>
References: <20240409235000.1893969-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And move the related code into util/annotate-data.c file.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c   | 106 +-----------------------------
 tools/perf/util/annotate-data.c | 110 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |   3 +
 3 files changed, 114 insertions(+), 105 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 332e1ddcacbd..0812664faa54 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -329,108 +329,6 @@ static int hist_entry__tty_annotate(struct hist_entry *he,
 	return symbol__tty_annotate2(&he->ms, evsel);
 }
 
-static void print_annotated_data_header(struct hist_entry *he, struct evsel *evsel)
-{
-	struct dso *dso = map__dso(he->ms.map);
-	int nr_members = 1;
-	int nr_samples = he->stat.nr_events;
-	int width = 7;
-	const char *val_hdr = "Percent";
-
-	if (evsel__is_group_event(evsel)) {
-		struct hist_entry *pair;
-
-		list_for_each_entry(pair, &he->pairs.head, pairs.node)
-			nr_samples += pair->stat.nr_events;
-	}
-
-	printf("Annotate type: '%s' in %s (%d samples):\n",
-	       he->mem_type->self.type_name, dso->name, nr_samples);
-
-	if (evsel__is_group_event(evsel)) {
-		struct evsel *pos;
-		int i = 0;
-
-		for_each_group_evsel(pos, evsel)
-			printf(" event[%d] = %s\n", i++, pos->name);
-
-		nr_members = evsel->core.nr_members;
-	}
-
-	if (symbol_conf.show_total_period) {
-		width = 11;
-		val_hdr = "Period";
-	} else if (symbol_conf.show_nr_samples) {
-		width = 7;
-		val_hdr = "Samples";
-	}
-
-	printf("============================================================================\n");
-	printf("%*s %10s %10s  %s\n", (width + 1) * nr_members, val_hdr,
-	       "offset", "size", "field");
-}
-
-static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_samples)
-{
-	double percent = h->period ? (100.0 * period / h->period) : 0;
-	const char *color = get_percent_color(percent);
-
-	if (symbol_conf.show_total_period)
-		color_fprintf(stdout, color, " %11" PRIu64, period);
-	else if (symbol_conf.show_nr_samples)
-		color_fprintf(stdout, color, " %7d", nr_samples);
-	else
-		color_fprintf(stdout, color, " %7.2f", percent);
-}
-
-static void print_annotated_data_type(struct annotated_data_type *mem_type,
-				      struct annotated_member *member,
-				      struct evsel *evsel, int indent)
-{
-	struct annotated_member *child;
-	struct type_hist *h = mem_type->histograms[evsel->core.idx];
-	int i, nr_events = 1, samples = 0;
-	u64 period = 0;
-	int width = symbol_conf.show_total_period ? 11 : 7;
-
-	for (i = 0; i < member->size; i++) {
-		samples += h->addr[member->offset + i].nr_samples;
-		period += h->addr[member->offset + i].period;
-	}
-	print_annotated_data_value(h, period, samples);
-
-	if (evsel__is_group_event(evsel)) {
-		struct evsel *pos;
-
-		for_each_group_member(pos, evsel) {
-			h = mem_type->histograms[pos->core.idx];
-
-			samples = 0;
-			period = 0;
-			for (i = 0; i < member->size; i++) {
-				samples += h->addr[member->offset + i].nr_samples;
-				period += h->addr[member->offset + i].period;
-			}
-			print_annotated_data_value(h, period, samples);
-		}
-		nr_events = evsel->core.nr_members;
-	}
-
-	printf(" %10d %10d  %*s%s\t%s",
-	       member->offset, member->size, indent, "", member->type_name,
-	       member->var_name ?: "");
-
-	if (!list_empty(&member->children))
-		printf(" {\n");
-
-	list_for_each_entry(child, &member->children, node)
-		print_annotated_data_type(mem_type, child, evsel, indent + 4);
-
-	if (!list_empty(&member->children))
-		printf("%*s}", (width + 1) * nr_events + 24 + indent, "");
-	printf(";\n");
-}
-
 static void print_annotate_data_stat(struct annotated_data_stat *s)
 {
 #define PRINT_STAT(fld) if (s->fld) printf("%10d : %s\n", s->fld, #fld)
@@ -571,9 +469,7 @@ static void hists__find_annotations(struct hists *hists,
 					goto find_next;
 			}
 
-			print_annotated_data_header(he, evsel);
-			print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
-			printf("\n");
+			hist_entry__annotate_data_tty(he, evsel);
 			goto find_next;
 		}
 
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b69a1cd1577a..99c5dcdfc9df 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -19,6 +19,7 @@
 #include "evlist.h"
 #include "map.h"
 #include "map_symbol.h"
+#include "sort.h"
 #include "strbuf.h"
 #include "symbol.h"
 #include "symbol_conf.h"
@@ -1710,3 +1711,112 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 	h->addr[offset].period += period;
 	return 0;
 }
+
+static void print_annotated_data_header(struct hist_entry *he, struct evsel *evsel)
+{
+	struct dso *dso = map__dso(he->ms.map);
+	int nr_members = 1;
+	int nr_samples = he->stat.nr_events;
+	int width = 7;
+	const char *val_hdr = "Percent";
+
+	if (evsel__is_group_event(evsel)) {
+		struct hist_entry *pair;
+
+		list_for_each_entry(pair, &he->pairs.head, pairs.node)
+			nr_samples += pair->stat.nr_events;
+	}
+
+	printf("Annotate type: '%s' in %s (%d samples):\n",
+	       he->mem_type->self.type_name, dso->name, nr_samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+		int i = 0;
+
+		for_each_group_evsel(pos, evsel)
+			printf(" event[%d] = %s\n", i++, pos->name);
+
+		nr_members = evsel->core.nr_members;
+	}
+
+	if (symbol_conf.show_total_period) {
+		width = 11;
+		val_hdr = "Period";
+	} else if (symbol_conf.show_nr_samples) {
+		width = 7;
+		val_hdr = "Samples";
+	}
+
+	printf("============================================================================\n");
+	printf("%*s %10s %10s  %s\n", (width + 1) * nr_members, val_hdr,
+	       "offset", "size", "field");
+}
+
+static void print_annotated_data_value(struct type_hist *h, u64 period, int nr_samples)
+{
+	double percent = h->period ? (100.0 * period / h->period) : 0;
+	const char *color = get_percent_color(percent);
+
+	if (symbol_conf.show_total_period)
+		color_fprintf(stdout, color, " %11" PRIu64, period);
+	else if (symbol_conf.show_nr_samples)
+		color_fprintf(stdout, color, " %7d", nr_samples);
+	else
+		color_fprintf(stdout, color, " %7.2f", percent);
+}
+
+static void print_annotated_data_type(struct annotated_data_type *mem_type,
+				      struct annotated_member *member,
+				      struct evsel *evsel, int indent)
+{
+	struct annotated_member *child;
+	struct type_hist *h = mem_type->histograms[evsel->core.idx];
+	int i, nr_events = 1, samples = 0;
+	u64 period = 0;
+	int width = symbol_conf.show_total_period ? 11 : 7;
+
+	for (i = 0; i < member->size; i++) {
+		samples += h->addr[member->offset + i].nr_samples;
+		period += h->addr[member->offset + i].period;
+	}
+	print_annotated_data_value(h, period, samples);
+
+	if (evsel__is_group_event(evsel)) {
+		struct evsel *pos;
+
+		for_each_group_member(pos, evsel) {
+			h = mem_type->histograms[pos->core.idx];
+
+			samples = 0;
+			period = 0;
+			for (i = 0; i < member->size; i++) {
+				samples += h->addr[member->offset + i].nr_samples;
+				period += h->addr[member->offset + i].period;
+			}
+			print_annotated_data_value(h, period, samples);
+		}
+		nr_events = evsel->core.nr_members;
+	}
+
+	printf(" %10d %10d  %*s%s\t%s",
+	       member->offset, member->size, indent, "", member->type_name,
+	       member->var_name ?: "");
+
+	if (!list_empty(&member->children))
+		printf(" {\n");
+
+	list_for_each_entry(child, &member->children, node)
+		print_annotated_data_type(mem_type, child, evsel, indent + 4);
+
+	if (!list_empty(&member->children))
+		printf("%*s}", (width + 1) * nr_events + 24 + indent, "");
+	printf(";\n");
+}
+
+void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
+{
+	print_annotated_data_header(he, evsel);
+	print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
+	printf("\n");
+}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index fe1e53d6e8c7..037e2622b7a3 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -10,6 +10,7 @@
 struct annotated_op_loc;
 struct debuginfo;
 struct evsel;
+struct hist_entry;
 struct map_symbol;
 struct thread;
 
@@ -140,6 +141,8 @@ struct annotated_data_stat {
 };
 extern struct annotated_data_stat ann_data_stat;
 
+void hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
+
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
-- 
2.44.0.478.gd926399ef9-goog


