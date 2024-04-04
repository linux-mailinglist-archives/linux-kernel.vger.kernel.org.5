Return-Path: <linux-kernel+bounces-131924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6EF898D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1371328A59E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB55134404;
	Thu,  4 Apr 2024 17:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeZgV1KF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504F0132816;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253442; cv=none; b=oWOw8RV/9KARQTGKPZC0YDvd0bteySij2DEk3w9ZCvT+E0U8H7nm+tqJPIrmkbSQ0fYoelK9oab+jbS5W5D43iMCCSVQYMAPtnBgA9iCYxwhw0Xb5OF4U8Y4eFssrsJNdMqIpzSpoP5IT4jpzfzDHGdvssOtgoHLqGya41iV71A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253442; c=relaxed/simple;
	bh=Xxo+cBqc6qIpHVIyGo1yk3m+aPbd3TuunlhzqIeauC4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4o8qhQnJBLObglUwUlVQ7MvTg0M3RON8ntUE6qQnkmjm0xsZxZiX8WZMJfoAXaIbXJLkBL/g47E2RAZBh7Awhry+iVKivv2YAOMQSM3L7nt1GfR6KrXSVsTPl/4PJbEVcAkpuTCi9F0SndcPAzSszLe0/fftcYccoPV1OH5B5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeZgV1KF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E06DC4167D;
	Thu,  4 Apr 2024 17:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712253441;
	bh=Xxo+cBqc6qIpHVIyGo1yk3m+aPbd3TuunlhzqIeauC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeZgV1KFwBBkcZv+ZjBNIvjAC7EPYSkTR1LVwYipa4eiIX/5uFooTeHfT8IYxeIyL
	 gfYzxFDjEt8ssR+Mtpnt3YawlbfjVXB5/X0RMR0oqi2b9XY1VlR6FK/8A167GORbA/
	 0thvXqtCgC6WNu7Pl9DM8dth72rUe+EtGcTOvislB6XduFdfZsgC9EdLPvFC0n+r9O
	 DvA2waD1xxCjf6DfkIb8Ej2bnKzkPnQxuWDRSvRPOz5CGHWBzBimPk4pU4acupcGdR
	 9fjYlaLwQj2rzOgle0SPYXojY2BKktOjLiqZc/fkAu6BuxyQpYJk2gfcaLHTT5t9Af
	 uUSZ1+sMAQBZA==
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
Subject: [PATCH 6/9] perf annotate: Move widths struct to annotated_source
Date: Thu,  4 Apr 2024 10:57:13 -0700
Message-ID: <20240404175716.1225482-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240404175716.1225482-1-namhyung@kernel.org>
References: <20240404175716.1225482-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only used in perf annotate output which means functions with actual
samples.  No need to consume memory for every symbol (annotation).

Also move max_line_len field into it as it's related.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/ui/browsers/annotate.c |  6 ++---
 tools/perf/util/annotate.c        | 41 +++++++++++++++++--------------
 tools/perf/util/annotate.h        | 20 +++++++--------
 3 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/tools/perf/ui/browsers/annotate.c b/tools/perf/ui/browsers/annotate.c
index c93da2ce727f..032642a0b4b6 100644
--- a/tools/perf/ui/browsers/annotate.c
+++ b/tools/perf/ui/browsers/annotate.c
@@ -205,13 +205,13 @@ static void annotate_browser__draw_current_jump(struct ui_browser *browser)
 
 	ui_browser__set_color(browser, HE_COLORSET_JUMP_ARROWS);
 	__ui_browser__line_arrow(browser,
-				 pcnt_width + 2 + notes->widths.addr + width,
+				 pcnt_width + 2 + notes->src->widths.addr + width,
 				 from, to);
 
 	diff = is_fused(ab, cursor);
 	if (diff > 0) {
 		ui_browser__mark_fused(browser,
-				       pcnt_width + 3 + notes->widths.addr + width,
+				       pcnt_width + 3 + notes->src->widths.addr + width,
 				       from - diff, diff, to > from);
 	}
 }
@@ -983,7 +983,7 @@ int symbol__tui_annotate(struct map_symbol *ms, struct evsel *evsel,
 
 	ui_helpline__push("Press ESC to exit");
 
-	browser.b.width = notes->src->max_line_len;
+	browser.b.width = notes->src->widths.max_line_len;
 	browser.b.nr_entries = notes->src->nr_entries;
 	browser.b.entries = &notes->src->source,
 	browser.b.width += 18; /* Percentage */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0e8319835986..0be744bb529c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1383,15 +1383,15 @@ static void annotation__set_index(struct annotation *notes)
 	struct annotation_line *al;
 	struct annotated_source *src = notes->src;
 
-	src->max_line_len = 0;
+	src->widths.max_line_len = 0;
 	src->nr_entries = 0;
 	src->nr_asm_entries = 0;
 
 	list_for_each_entry(al, &src->source, node) {
 		size_t line_len = strlen(al->line);
 
-		if (src->max_line_len < line_len)
-			src->max_line_len = line_len;
+		if (src->widths.max_line_len < line_len)
+			src->widths.max_line_len = line_len;
 		al->idx = src->nr_entries++;
 		if (al->offset != -1)
 			al->idx_asm = src->nr_asm_entries++;
@@ -1429,26 +1429,26 @@ static int annotation__max_ins_name(struct annotation *notes)
 static void
 annotation__init_column_widths(struct annotation *notes, struct symbol *sym)
 {
-	notes->widths.addr = notes->widths.target =
-		notes->widths.min_addr = hex_width(symbol__size(sym));
-	notes->widths.max_addr = hex_width(sym->end);
-	notes->widths.jumps = width_jumps(notes->max_jump_sources);
-	notes->widths.max_ins_name = annotation__max_ins_name(notes);
+	notes->src->widths.addr = notes->src->widths.target =
+		notes->src->widths.min_addr = hex_width(symbol__size(sym));
+	notes->src->widths.max_addr = hex_width(sym->end);
+	notes->src->widths.jumps = width_jumps(notes->max_jump_sources);
+	notes->src->widths.max_ins_name = annotation__max_ins_name(notes);
 }
 
 void annotation__update_column_widths(struct annotation *notes)
 {
 	if (annotate_opts.use_offset)
-		notes->widths.target = notes->widths.min_addr;
+		notes->src->widths.target = notes->src->widths.min_addr;
 	else if (annotate_opts.full_addr)
-		notes->widths.target = BITS_PER_LONG / 4;
+		notes->src->widths.target = BITS_PER_LONG / 4;
 	else
-		notes->widths.target = notes->widths.max_addr;
+		notes->src->widths.target = notes->src->widths.max_addr;
 
-	notes->widths.addr = notes->widths.target;
+	notes->src->widths.addr = notes->src->widths.target;
 
 	if (annotate_opts.show_nr_jumps)
-		notes->widths.addr += notes->widths.jumps + 1;
+		notes->src->widths.addr += notes->src->widths.jumps + 1;
 }
 
 void annotation__toggle_full_addr(struct annotation *notes, struct map_symbol *ms)
@@ -1625,7 +1625,8 @@ static void disasm_line__write(struct disasm_line *dl, struct annotation *notes,
 		obj__printf(obj, "  ");
 	}
 
-	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset, notes->widths.max_ins_name);
+	disasm_line__scnprintf(dl, bf, size, !annotate_opts.use_offset,
+			       notes->src->widths.max_ins_name);
 }
 
 static void ipc_coverage_string(char *bf, int size, struct annotation *notes)
@@ -1753,9 +1754,11 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 		obj__printf(obj, "%-*s", width - pcnt_width - cycles_width, " ");
 	else if (al->offset == -1) {
 		if (al->line_nr && annotate_opts.show_linenr)
-			printed = scnprintf(bf, sizeof(bf), "%-*d ", notes->widths.addr + 1, al->line_nr);
+			printed = scnprintf(bf, sizeof(bf), "%-*d ",
+					    notes->src->widths.addr + 1, al->line_nr);
 		else
-			printed = scnprintf(bf, sizeof(bf), "%-*s  ", notes->widths.addr, " ");
+			printed = scnprintf(bf, sizeof(bf), "%-*s  ",
+					    notes->src->widths.addr, " ");
 		obj__printf(obj, bf);
 		obj__printf(obj, "%-*s", width - printed - pcnt_width - cycles_width + 1, al->line);
 	} else {
@@ -1773,7 +1776,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				if (annotate_opts.show_nr_jumps) {
 					int prev;
 					printed = scnprintf(bf, sizeof(bf), "%*d ",
-							    notes->widths.jumps,
+							    notes->src->widths.jumps,
 							    al->jump_sources);
 					prev = obj__set_jumps_percent_color(obj, al->jump_sources,
 									    current_entry);
@@ -1782,7 +1785,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				}
 print_addr:
 				printed = scnprintf(bf, sizeof(bf), "%*" PRIx64 ": ",
-						    notes->widths.target, addr);
+						    notes->src->widths.target, addr);
 			} else if (ins__is_call(&disasm_line(al)->ins) &&
 				   annotate_opts.offset_level >= ANNOTATION__OFFSET_CALL) {
 				goto print_addr;
@@ -1790,7 +1793,7 @@ static void __annotation_line__write(struct annotation_line *al, struct annotati
 				goto print_addr;
 			} else {
 				printed = scnprintf(bf, sizeof(bf), "%-*s  ",
-						    notes->widths.addr, " ");
+						    notes->src->widths.addr, " ");
 			}
 		}
 
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d61184499bda..402ae774426b 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -250,7 +250,7 @@ struct cyc_hist {
  * @nr_entries: Number of annotated_line in the source list.
  * @nr_asm_entries: Number of annotated_line with actual asm instruction in the
  * 		    source list.
- * @max_line_len: Maximum length of objdump output in an annotated_line.
+ * @widths: Precalculated width of each column in the TUI output.
  *
  * disasm_lines are allocated, percentages calculated and all sorted by percentage
  * when the annotation is about to be presented, so the percentages are for
@@ -265,7 +265,15 @@ struct annotated_source {
 	int    			nr_histograms;
 	int			nr_entries;
 	int			nr_asm_entries;
-	u16			max_line_len;
+	struct {
+		u8		addr;
+		u8		jumps;
+		u8		target;
+		u8		min_addr;
+		u8		max_addr;
+		u8		max_ins_name;
+		u16		max_line_len;
+	} widths;
 };
 
 struct annotation_line *annotated_source__get_line(struct annotated_source *src,
@@ -302,14 +310,6 @@ struct LOCKABLE annotation {
 	u64			start;
 	int			nr_events;
 	int			max_jump_sources;
-	struct {
-		u8		addr;
-		u8		jumps;
-		u8		target;
-		u8		min_addr;
-		u8		max_addr;
-		u8		max_ins_name;
-	} widths;
 	struct annotated_source *src;
 	struct annotated_branch *branch;
 };
-- 
2.44.0.478.gd926399ef9-goog


