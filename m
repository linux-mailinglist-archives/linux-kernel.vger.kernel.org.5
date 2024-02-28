Return-Path: <linux-kernel+bounces-84288-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 652C386A494
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 894A31C21A26
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDCE73C36;
	Wed, 28 Feb 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qlH9CSSa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1972E1865;
	Wed, 28 Feb 2024 00:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709081553; cv=none; b=mpGfafpuCtKfGgwVL9/I4EPR6NIQBFRoqXZYSkqR/M4j/N81FWAon1Wv3Wm3P6H6YW61Gzad9jpP+OVPDDrYgUpdl9/nHjcSff/2tpke2xUjpJHCkZiQ8+jROqMjgUFXAnYCxvRWuQ+FdDyciIrtdGxjdVIWSVOeYDmDer4oOmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709081553; c=relaxed/simple;
	bh=rvlDlfIuCnTKdn5MnigqcDg5DtdXoGeqGh8gOu2Zuy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MR8ErPvhv7DsiHc2RyBtUZRF3RJOek3lYB/SZYuWCMUXpD/tcpTcg4TiCfH24O9/w+AAgm9RgyS7W5qYVk4qCpP8MZXPGZxMKbhXU3nkU4CRonfICVloOEe1rhws8spgLqdW2ctcWaflyQHD1gS4Avf9rv8sea3sxpFDFE3+vGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qlH9CSSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A0FC433B2;
	Wed, 28 Feb 2024 00:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709081552;
	bh=rvlDlfIuCnTKdn5MnigqcDg5DtdXoGeqGh8gOu2Zuy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qlH9CSSaNcWpR/79oxZUYyzEnO9TumVOqoVC/Qzs73tgKsP50ZL3roXRaOozNjbyo
	 mHH9Lx0f3BnzzDdWrqYZoApz91or1r4CHeJN+JljTpQKH6V581dqHjO+1FJYLpIM4a
	 oY6AVbhPKS7BSPLOfYi4sVnHB2CDJFG9JttDKZPCH+hxFNzxYj9ntvGOM9zaSDNA9J
	 2g6oPHEowOCHPSNbyEsxQjGhy29c+WR7DFQGhINYMt6W9Y+0kY+jmSQ6fg1DgEtQc3
	 MaYLgsjYF2XArC9Qi27UYC3S54WNUMiE/2aumO/MscCjq3TKHF+OQP/szQt5NGftG6
	 EfWrp/UZjaz7Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 2/4] perf annotate: Calculate instruction overhead using hashmap
Date: Tue, 27 Feb 2024 16:52:28 -0800
Message-ID: <20240228005230.287113-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240228005230.287113-1-namhyung@kernel.org>
References: <20240228005230.287113-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use annotated_source.samples hashmap instead of addr array in the
struct sym_hist.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/gtk/annotate.c | 14 +++++++++---
 tools/perf/util/annotate.c   | 44 ++++++++++++++++++++++++------------
 tools/perf/util/annotate.h   | 11 +++++++++
 3 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/tools/perf/ui/gtk/annotate.c b/tools/perf/ui/gtk/annotate.c
index 394861245fd3..93ce3d47e47e 100644
--- a/tools/perf/ui/gtk/annotate.c
+++ b/tools/perf/ui/gtk/annotate.c
@@ -28,21 +28,29 @@ static const char *const col_names[] = {
 static int perf_gtk__get_percent(char *buf, size_t size, struct symbol *sym,
 				 struct disasm_line *dl, int evidx)
 {
+	struct annotation *notes;
 	struct sym_hist *symhist;
+	struct sym_hist_entry *entry;
 	double percent = 0.0;
 	const char *markup;
 	int ret = 0;
+	u64 nr_samples = 0;
 
 	strcpy(buf, "");
 
 	if (dl->al.offset == (s64) -1)
 		return 0;
 
-	symhist = annotation__histogram(symbol__annotation(sym), evidx);
-	if (!symbol_conf.event_group && !symhist->addr[dl->al.offset].nr_samples)
+	notes = symbol__annotation(sym);
+	symhist = annotation__histogram(notes, evidx);
+	entry = annotated_source__hist_entry(notes->src, evidx, dl->al.offset);
+	if (entry)
+		nr_samples = entry->nr_samples;
+
+	if (!symbol_conf.event_group && nr_samples == 0)
 		return 0;
 
-	percent = 100.0 * symhist->addr[dl->al.offset].nr_samples / symhist->nr_samples;
+	percent = 100.0 * nr_samples / symhist->nr_samples;
 
 	markup = perf_gtk__get_percent_color(percent);
 	if (markup)
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 7a70e4d35c9b..e7859f756252 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2368,17 +2368,25 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	return err;
 }
 
-static void calc_percent(struct sym_hist *sym_hist,
-			 struct hists *hists,
+static void calc_percent(struct annotation *notes,
+			 struct evsel *evsel,
 			 struct annotation_data *data,
 			 s64 offset, s64 end)
 {
+	struct hists *hists = evsel__hists(evsel);
+	int evidx = evsel->core.idx;
+	struct sym_hist *sym_hist = annotation__histogram(notes, evidx);
 	unsigned int hits = 0;
 	u64 period = 0;
 
 	while (offset < end) {
-		hits   += sym_hist->addr[offset].nr_samples;
-		period += sym_hist->addr[offset].period;
+		struct sym_hist_entry *entry;
+
+		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		if (entry) {
+			hits   += entry->nr_samples;
+			period += entry->period;
+		}
 		++offset;
 	}
 
@@ -2415,16 +2423,13 @@ static void annotation__calc_percent(struct annotation *notes,
 		end  = next ? next->offset : len;
 
 		for_each_group_evsel(evsel, leader) {
-			struct hists *hists = evsel__hists(evsel);
 			struct annotation_data *data;
-			struct sym_hist *sym_hist;
 
 			BUG_ON(i >= al->data_nr);
 
-			sym_hist = annotation__histogram(notes, evsel->core.idx);
 			data = &al->data[i++];
 
-			calc_percent(sym_hist, hists, data, al->offset, end);
+			calc_percent(notes, evsel, data, al->offset, end);
 		}
 	}
 }
@@ -2619,14 +2624,19 @@ static void print_summary(struct rb_root *root, const char *filename)
 
 static void symbol__annotate_hits(struct symbol *sym, struct evsel *evsel)
 {
+	int evidx = evsel->core.idx;
 	struct annotation *notes = symbol__annotation(sym);
-	struct sym_hist *h = annotation__histogram(notes, evsel->core.idx);
+	struct sym_hist *h = annotation__histogram(notes, evidx);
 	u64 len = symbol__size(sym), offset;
 
-	for (offset = 0; offset < len; ++offset)
-		if (h->addr[offset].nr_samples != 0)
+	for (offset = 0; offset < len; ++offset) {
+		struct sym_hist_entry *entry;
+
+		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		if (entry && entry->nr_samples != 0)
 			printf("%*" PRIx64 ": %" PRIu64 "\n", BITS_PER_LONG / 2,
-			       sym->start + offset, h->addr[offset].nr_samples);
+			       sym->start + offset, entry->nr_samples);
+	}
 	printf("%*s: %" PRIu64 "\n", BITS_PER_LONG / 2, "h->nr_samples", h->nr_samples);
 }
 
@@ -2855,8 +2865,14 @@ void symbol__annotate_decay_histogram(struct symbol *sym, int evidx)
 
 	h->nr_samples = 0;
 	for (offset = 0; offset < len; ++offset) {
-		h->addr[offset].nr_samples = h->addr[offset].nr_samples * 7 / 8;
-		h->nr_samples += h->addr[offset].nr_samples;
+		struct sym_hist_entry *entry;
+
+		entry = annotated_source__hist_entry(notes->src, evidx, offset);
+		if (entry == NULL)
+			continue;
+
+		entry->nr_samples = entry->nr_samples * 7 / 8;
+		h->nr_samples += entry->nr_samples;
 	}
 }
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index a2b0c8210740..3362980a5d3d 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -356,6 +356,17 @@ static inline struct sym_hist *annotation__histogram(struct annotation *notes, i
 	return annotated_source__histogram(notes->src, idx);
 }
 
+static inline struct sym_hist_entry *
+annotated_source__hist_entry(struct annotated_source *src, int idx, u64 offset)
+{
+	struct sym_hist_entry *entry;
+	long key = offset << 16 | idx;
+
+	if (!hashmap__find(src->samples, key, &entry))
+		return NULL;
+	return entry;
+}
+
 static inline struct annotation *symbol__annotation(struct symbol *sym)
 {
 	return (void *)sym - symbol_conf.priv_size;
-- 
2.44.0.rc1.240.g4c46232300-goog


