Return-Path: <linux-kernel+bounces-112075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F20F8874E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 23:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB701F23946
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 22:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486DE8289C;
	Fri, 22 Mar 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4bmu+WR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2C582885;
	Fri, 22 Mar 2024 22:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711147395; cv=none; b=q5uTvKcgcFOoTEBhEkHkcnrUJxA4O09faEXHkNfYQzZ35SWtVlUB2YvSBu40mBIHrpPwFkx8BMLPnJoGlEpmgdSRW+/CDYIx4HFJVGUT9OzW+Tqe/DoxpDggNnmKVqYJBiW1na6QSriNVICU7DwPOeYPCs2Q64MTVk9UxsndeNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711147395; c=relaxed/simple;
	bh=94c3ApKhfdXXy5yXArKe+AKXVzYjtIcn0YWblDXG74s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFoMgcZCJTRSTpQlEGq90SdXJKnmoJjd13tWZAdSe8yAKGxcaffKsgta/R+7mzw2/uUmJvzBeQ9fH++SXSpJ9fsADLNnd/ltRthtJAsfJeCAIbWad+QiEnMJA1IVGWEyG/gZJORZ82NHdNYe/R8I4WkLcfEdhekvQgI46G8xTBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4bmu+WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91720C433A6;
	Fri, 22 Mar 2024 22:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711147394;
	bh=94c3ApKhfdXXy5yXArKe+AKXVzYjtIcn0YWblDXG74s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O4bmu+WRE+FtSbvM59nlmr+1cOJLgo+cGiAaGLLr+8H1TT4eOp3M56KF+HRLfIbwK
	 IHsI1g3iU+xAjN/Jo/7fvIZEAYledthK7TBwz23Vr8ijqKpn05luIWUCHRBCpRiZK+
	 CNcMYR8OvkjIAGvAyLGHwcf0ZI1ywcjqxnkgA2nSvHmlfSZyxvd6MQMGqfMAbUEmCM
	 tbKobMpEnfhHA6Dc0X8ZdWqUm1ghPto70eRVnpikOwuhqTj9lsDIC0NbyF1GgmmwqZ
	 EioGwoobomG3EwOC48nJMbTLgGqcRwI3JMCjgvAQ/ZQTh9GPhEpLhdVcCRGavvdCZY
	 0IDm/bVWXN6xg==
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
Subject: [PATCH 2/2] perf annotate: Honor output options with --data-type
Date: Fri, 22 Mar 2024 15:43:13 -0700
Message-ID: <20240322224313.423181-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
In-Reply-To: <20240322224313.423181-1-namhyung@kernel.org>
References: <20240322224313.423181-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For data type profiling output, it should be in sync with normal output
so make it display percentage for each field.  Also use coloring scheme
for users to identify fields with big overhead easily.

Users can use --show-total-period or --show-nr-samples to change the
output style like in the normal perf annotate output.

Before:
  $ perf annotate --data-type
  Annotate type: 'struct task_struct' in [kernel.kallsyms] (34 samples):
  ============================================================================
      samples     offset       size  field
           34          0       9792  struct task_struct    {
            2          0         24      struct thread_info       thread_info {
            0          0          8          long unsigned int    flags;
            1          8          8          long unsigned int    syscall_work;
            0         16          4          u32  status;
            1         20          4          u32  cpu;
                                         };

After:
  $ perf annotate --data-type
  Annotate type: 'struct task_struct' in [kernel.kallsyms] (34 samples):
  ============================================================================
   Percent     offset       size  field
    100.00          0       9792  struct task_struct       {
      3.55          0         24      struct thread_info  thread_info {
      0.00          0          8          long unsigned int       flags;
      1.63          8          8          long unsigned int       syscall_work;
      0.00         16          4          u32     status;
      1.91         20          4          u32     cpu;
                                      };

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c | 44 ++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 3e9f7e0596e8..16e1581207c9 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -42,6 +42,7 @@
 #include <errno.h>
 #include <linux/bitmap.h>
 #include <linux/err.h>
+#include <inttypes.h>
 
 struct perf_annotate {
 	struct perf_tool tool;
@@ -332,6 +333,8 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 	struct dso *dso = map__dso(he->ms.map);
 	int nr_members = 1;
 	int nr_samples = he->stat.nr_events;
+	int width = 7;
+	const char *val_hdr = "Percent";
 
 	if (evsel__is_group_event(evsel)) {
 		struct hist_entry *pair;
@@ -353,8 +356,30 @@ static void print_annotated_data_header(struct hist_entry *he, struct evsel *evs
 		nr_members = evsel->core.nr_members;
 	}
 
+	if (symbol_conf.show_total_period) {
+		width = 11;
+		val_hdr = "Period";
+	} else if (symbol_conf.show_nr_samples) {
+		width = 7;
+		val_hdr = "Samples";
+	}
+
 	printf("============================================================================\n");
-	printf("%*s %10s %10s  %s\n", 11 * nr_members, "samples", "offset", "size", "field");
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
 }
 
 static void print_annotated_data_type(struct annotated_data_type *mem_type,
@@ -364,10 +389,14 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 	struct annotated_member *child;
 	struct type_hist *h = mem_type->histograms[evsel->core.idx];
 	int i, nr_events = 1, samples = 0;
+	u64 period = 0;
+	int width = symbol_conf.show_total_period ? 11 : 7;
 
-	for (i = 0; i < member->size; i++)
+	for (i = 0; i < member->size; i++) {
 		samples += h->addr[member->offset + i].nr_samples;
-	printf(" %10d", samples);
+		period += h->addr[member->offset + i].period;
+	}
+	print_annotated_data_value(h, period, samples);
 
 	if (evsel__is_group_event(evsel)) {
 		struct evsel *pos;
@@ -376,9 +405,12 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 			h = mem_type->histograms[pos->core.idx];
 
 			samples = 0;
-			for (i = 0; i < member->size; i++)
+			period = 0;
+			for (i = 0; i < member->size; i++) {
 				samples += h->addr[member->offset + i].nr_samples;
-			printf(" %10d", samples);
+				period += h->addr[member->offset + i].period;
+			}
+			print_annotated_data_value(h, period, samples);
 		}
 		nr_events = evsel->core.nr_members;
 	}
@@ -394,7 +426,7 @@ static void print_annotated_data_type(struct annotated_data_type *mem_type,
 		print_annotated_data_type(mem_type, child, evsel, indent + 4);
 
 	if (!list_empty(&member->children))
-		printf("%*s}", 11 * nr_events + 24 + indent, "");
+		printf("%*s}", (width + 1) * nr_events + 24 + indent, "");
 	printf(";\n");
 }
 
-- 
2.44.0.396.g6e790dbe36-goog


