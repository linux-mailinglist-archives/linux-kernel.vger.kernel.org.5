Return-Path: <linux-kernel+bounces-91399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF58710EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAB962889CA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DF27E57D;
	Mon,  4 Mar 2024 23:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCklBLKT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E717D41C;
	Mon,  4 Mar 2024 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709593699; cv=none; b=B/VZaaeApY/+/hEDyuXaCDhk1Mml6euiH4Jf8dDgcXB0LEVyTb6cmn7VuAr0XtArhNSmtvhR9v/uAymudm0uZWR1826UF2UXBZvpvnr5+hPHh8h5nlenLuN/6sxRqGXuF+lP59E1RC9qjrDPH1KWFD6G3pqMWGIqsneLThcsHzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709593699; c=relaxed/simple;
	bh=6Aw5acCv4CoQWjErFC5MywXHMebtv9mViX2GVgBXuqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdIJDBcMEMQU41E4GJXWfaEgva8qYgcv8JXMM9tcWXEpa2HF9mA/EoFnNabmd12rteL54idKMh/RDMKwE2b751xtgFxOOzvU0JuV7NQ/3h60ozZIuPJRGwtm5USKzS/pzJ21KfTM3AfsmXzjSxy62qE2+GIlKLcflbaWXDoKHyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCklBLKT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B7CC43330;
	Mon,  4 Mar 2024 23:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709593699;
	bh=6Aw5acCv4CoQWjErFC5MywXHMebtv9mViX2GVgBXuqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uCklBLKTP0WjF2EXAYwVXuoMjg1Bk+RX2LKu1r/l+/S1wEcjHX4IvPpCKna84QoQP
	 l4GNnYbOgLXM3VSyoenGhefXdqTHdBIDJbKc6SxYgmwZNGMgXK+BnlVIzwwWKWn1Lx
	 1LTIRznVPlT+weVohsCf2KPDleQqdoxsgwcmqp1+D0xW6I56Ynid5zz92uCUcU6Yye
	 y68hyuCZ5Us5oZ6cPy+skChwrT8ogC8C89w3gWJ+D6N3eKd6neZ714Ukr+D7GrqUq5
	 3+8kNm4Q3t7Kx/VrStwmcs2GxUTkf+L0qg6ak6uDwcG1nD4e8pj8oeZ5rNxrcDofnB
	 2tUs9y+Ias2/A==
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
Subject: [PATCH v2 4/4] perf annotate: Add comments in the data structures
Date: Mon,  4 Mar 2024 15:08:15 -0800
Message-ID: <20240304230815.1440583-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
In-Reply-To: <20240304230815.1440583-1-namhyung@kernel.org>
References: <20240304230815.1440583-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reviewed-by: Ian Rogers <irogers@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.h | 69 ++++++++++++++++++++++++++++++++++----
 1 file changed, 62 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 4bdc70a9d376..13cc659e508c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -239,11 +239,42 @@ int disasm_line__scnprintf(struct disasm_line *dl, char *bf, size_t size, bool r
 size_t disasm__fprintf(struct list_head *head, FILE *fp);
 void symbol__calc_percent(struct symbol *sym, struct evsel *evsel);
 
+/**
+ * struct sym_hist - symbol histogram information for an event
+ *
+ * @nr_samples: Total number of samples.
+ * @period: Sum of sample periods.
+ */
 struct sym_hist {
 	u64		      nr_samples;
 	u64		      period;
 };
 
+/**
+ * struct cyc_hist - (CPU) cycle histogram for a basic block
+ *
+ * @start: Start address of current block (if known).
+ * @cycles: Sum of cycles for the longest basic block.
+ * @cycles_aggr: Total cycles for this address.
+ * @cycles_max: Max cycles for this address.
+ * @cycles_min: Min cycles for this address.
+ * @cycles_spark: History of cycles for the longest basic block.
+ * @num: Number of samples for the longest basic block.
+ * @num_aggr: Total number of samples for this address.
+ * @have_start: Whether the current branch info has a start address.
+ * @reset: Number of resets due to a different start address.
+ *
+ * If sample has branch_stack and cycles info, it can construct basic blocks
+ * between two adjacent branches.  It'd have start and end addresses but
+ * sometimes the start address may not be available.  So the cycles are
+ * accounted at the end address.  If multiple basic blocks end at the same
+ * address, it will take the longest one.
+ *
+ * The @start, @cycles, @cycles_spark and @num fields are used for the longest
+ * block only.  Other fields are used for all cases.
+ *
+ * See __symbol__account_cycles().
+ */
 struct cyc_hist {
 	u64	start;
 	u64	cycles;
@@ -258,18 +289,24 @@ struct cyc_hist {
 	u16	reset;
 };
 
-/** struct annotated_source - symbols with hits have this attached as in sannotation
+/**
+ * struct annotated_source - symbols with hits have this attached as in annotation
  *
- * @histograms: Array of addr hit histograms per event being monitored
- * nr_histograms: This may not be the same as evsel->evlist->core.nr_entries if
+ * @source: List head for annotated_line (embeded in disasm_line).
+ * @histograms: Array of symbol histograms per event to maintain the total number
+ * 		of samples and period.
+ * @nr_histograms: This may not be the same as evsel->evlist->core.nr_entries if
  * 		  we have more than a group in a evlist, where we will want
  * 		  to see each group separately, that is why symbol__annotate2()
  * 		  sets src->nr_histograms to evsel->nr_members.
- * @lines: If 'print_lines' is specified, per source code line percentages
- * @source: source parsed from a disassembler like objdump -dS
- * @cyc_hist: Average cycles per basic block
+ * @offsets: Array of annotation_line to be accessed by offset.
+ * @samples: Hash map of sym_hist_entry.  Keyed by event index and offset in symbol.
+ * @nr_entries: Number of annotated_line in the source list.
+ * @nr_asm_entries: Number of annotated_line with actual asm instruction in the
+ * 		    source list.
+ * @max_line_len: Maximum length of objdump output in an annotated_line.
  *
- * lines is allocated, percentages calculated and all sorted by percentage
+ * disasm_lines are allocated, percentages calculated and all sorted by percentage
  * when the annotation is about to be presented, so the percentages are for
  * one of the entries in the histogram array, i.e. for the event/counter being
  * presented. It is deallocated right after symbol__{tui,tty,etc}_annotate
@@ -286,6 +323,24 @@ struct annotated_source {
 	u16			max_line_len;
 };
 
+/**
+ * struct annotated_branch - basic block and IPC information for a symbol.
+ *
+ * @hit_cycles: Total executed cycles.
+ * @hit_insn: Total number of instructions executed.
+ * @total_insn: Number of instructions in the function.
+ * @cover_insn: Number of distinct, actually executed instructions.
+ * @cycles_hist: Array of cyc_hist for each instruction.
+ * @max_coverage: Maximum number of covered basic block (used for block-range).
+ *
+ * This struct is used by two different codes when the sample has branch stack
+ * and cycles information.  annotation__compute_ipc() calculates average IPC
+ * using @hit_insn / @hit_cycles.  The actual coverage can be calculated using
+ * @cover_insn / @total_insn.  The @cycles_hist can give IPC for each (longest)
+ * basic block ends at the given address.
+ * process_basic_block() calculates coverage of instructions (or basic blocks)
+ * in the function.
+ */
 struct annotated_branch {
 	u64			hit_cycles;
 	u64			hit_insn;
-- 
2.44.0.rc1.240.g4c46232300-goog


