Return-Path: <linux-kernel+bounces-139716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135228A06C7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 363721C21B6B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87CF13C694;
	Thu, 11 Apr 2024 03:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW8knkiQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BB913BC1A;
	Thu, 11 Apr 2024 03:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806379; cv=none; b=soEhlo8rzKMnn26d8EJwHNI1kson9Ez1mGr2Jr/stUC2LQEXvMMLVT6PZCrOHbgwguoICeZtHyu9nB3W0l0uqFpkMNypdH5OEO9fGX2jfNm0Ooqn9+ozAyL4zOyp/6xuvRgArYo2yGAZPCXdDs7UZ3qSK3pma6zHKHCc1v6HI8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806379; c=relaxed/simple;
	bh=QUqZPqNpv1B2WpvqTPpemc1xyxDVxJ3oUcE4o5/x8QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+MhVp702Zi05jO95GrW9N+Zm6yeO2BEqZKzs0LmHl6rwH8irtSrTeuhzMzkRi0MtLW+IPw3Q92Rd+zPIRs6y23F4syidPM8W7lznYtF1WmZHSDQIwvwpfJfBO2CYODR76QHywYqzBjZ/pvjv6Bbj63VWh3X9pjJ6ZKTrgrmB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sW8knkiQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD32BC433F1;
	Thu, 11 Apr 2024 03:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712806379;
	bh=QUqZPqNpv1B2WpvqTPpemc1xyxDVxJ3oUcE4o5/x8QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sW8knkiQVOf6Ikdt4pI86QIYNEmQ2eLFIagIfi7KabXI4RnjmIsS2RaiGg0tm8Oxg
	 eLSqEJ1ZDJ6+TJ2MF7HT84xlsu55QnbYmaIbKPlYrAclEnFHLg3bUTFmNjZke1dIY+
	 iDn+tFY1bVARfCic//GJu8k+waBJ7u0+G8LaJKSpJ9lfi6TtwcRHjjr2C36qedylxQ
	 ZK9+i0w/o2DsNiukj5gdDqw6dlIQ32jOPyIWPLjEbCvCIBKBIlN0o9kcj180ExQCsH
	 XCgxBh3Uh1L7GBe4fOXGZxB++Ij6guL6/yjqIrkEl11B5xx/Tg+bnvop1T0AYUPYB9
	 brscjNPurX3ug==
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
Subject: [PATCH 3/7] perf annotate-data: Add hist_entry__annotate_data_tty()
Date: Wed, 10 Apr 2024 20:32:52 -0700
Message-ID: <20240411033256.2099646-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240411033256.2099646-1-namhyung@kernel.org>
References: <20240411033256.2099646-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

And move the related code into util/annotate-data.c file.

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c   | 106 +-----------------------------
 tools/perf/util/annotate-data.c | 112 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |   9 +++
 3 files changed, 122 insertions(+), 105 deletions(-)

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
index b69a1cd1577a..b150137a92dc 100644
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
@@ -1710,3 +1711,114 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
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
+int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel)
+{
+	print_annotated_data_header(he, evsel);
+	print_annotated_data_type(he->mem_type, &he->mem_type->self, evsel, 0);
+	printf("\n");
+
+	return 0;
+}
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index fe1e53d6e8c7..01489db267d4 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -10,6 +10,7 @@
 struct annotated_op_loc;
 struct debuginfo;
 struct evsel;
+struct hist_entry;
 struct map_symbol;
 struct thread;
 
@@ -156,6 +157,8 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 /* Release all global variable information in the tree */
 void global_var_type__tree_delete(struct rb_root *root);
 
+int hist_entry__annotate_data_tty(struct hist_entry *he, struct evsel *evsel);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -182,6 +185,12 @@ static inline void global_var_type__tree_delete(struct rb_root *root __maybe_unu
 {
 }
 
+static inline int hist_entry__annotate_data_tty(struct hist_entry *he __maybe_unused,
+						struct evsel *evsel __maybe_unused)
+{
+	return -1;
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
-- 
2.44.0.478.gd926399ef9-goog


