Return-Path: <linux-kernel+bounces-133587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 890A289A603
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF5EBB2295F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01029176FAA;
	Fri,  5 Apr 2024 21:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWNBseiG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AF117555F;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712351884; cv=none; b=gp6+h7ryhQmR3CLxoFnmpaBqNL5IDG4PQAgBrf+dHft7/ytRWyFWQK1cME6II8yfypjtVqgIVZRYJl2dz0trvD6Tt0vcoMHCL6BpcxnUlBNLoPwtILa+9TIfi42jWwXpGTL/MNW9emVeN+LEpV5d0DelH59ZErwSyEI3GhkdDnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712351884; c=relaxed/simple;
	bh=LKDlW092ImDWCgqQqaKslE3/JEHI6TM1IPtRvR2f8ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPd4tEks/p0175HtAdk8AKFKuuSGbJdbDnAnyY47fswb+QK0tKcaaA1iRTohNftjyCwvZ8uUUwpzgjN2/B9KD4ALCTXyJv7gH1yXwoeZ2GE5POItLWEm9jNv/OpJOgIcTrhVyntF/5yjxl0kAElVMNzpY5kd5YPG9CNyxjvMgBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWNBseiG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 288D0C433B1;
	Fri,  5 Apr 2024 21:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712351883;
	bh=LKDlW092ImDWCgqQqaKslE3/JEHI6TM1IPtRvR2f8ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWNBseiGgt4SKG3NJgoYb0E1vBH8wm7ZpRS+t8qWo+avPiLcTqDDWUFvN/6sHxaOr
	 vs29Ae1QQ5MJTeX5WRIbx43BStFb16OYlLmEq2xNpwyRUSzzRRyaRKY/jLRRk9O8Aw
	 dDA+BimaqFWi+qjgY9N3kQwEYGT351b0PIgeXGdTkmNUqLVstLEbNmpCBsF+rDcOys
	 LGFtxextlwn2VU6BN50r0CrQ9T2o6QCi8JirMMEUK4fV2Pz5EwdnolFqA54RjHXQW3
	 QWEdYd3OOQTWM41TtCe+6PWBIG9EXdGLPkg//kJnWBzNrTZE4Xc/UWPhbFrbPDXFFe
	 PEKjCCHaJ4TEA==
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
Subject: [PATCH 3/4] perf annotate-data: Do not delete non-asm lines
Date: Fri,  5 Apr 2024 14:17:59 -0700
Message-ID: <20240405211800.1412920-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240405211800.1412920-1-namhyung@kernel.org>
References: <20240405211800.1412920-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For data type profiling, it removed non-instruction lines from the list
of annotation lines.  It was to simplify the implementation dealing with
instructions like to calculate the PC-relative address and to search the
shortest path to the target instruction or basic block.

But it means that it removes all the comments and debug information in
the annotate output like source file name and line numbers.  To support
both code annotation and data type annotation, it'd be better to keep
the non-instruction lines as well.

So this change is to skip those lines during the data type profiling
and to display them in the normal perf annotate output.

No function changes intended (other than having more lines).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c |  6 +++
 tools/perf/util/annotate.c      | 93 ++++++++++++++++++++++++---------
 2 files changed, 74 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1047ea9d578c..b69a1cd1577a 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1314,6 +1314,8 @@ static int find_data_type_insn(struct data_loc_info *dloc, int reg,
 	list_for_each_entry(bb, basic_blocks, list) {
 		struct disasm_line *dl = bb->begin;
 
+		BUG_ON(bb->begin->al.offset == -1 || bb->end->al.offset == -1);
+
 		pr_debug_dtp("bb: [%"PRIx64" - %"PRIx64"]\n",
 			     bb->begin->al.offset, bb->end->al.offset);
 
@@ -1321,6 +1323,10 @@ static int find_data_type_insn(struct data_loc_info *dloc, int reg,
 			u64 this_ip = sym->start + dl->al.offset;
 			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
 
+			/* Skip comment or debug info lines */
+			if (dl->al.offset == -1)
+				continue;
+
 			/* Update variable type at this address */
 			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
 
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index ded9ad86df00..9df82e58cf6e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2142,23 +2142,10 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
 static void symbol__ensure_annotate(struct map_symbol *ms, struct evsel *evsel)
 {
-	struct disasm_line *dl, *tmp_dl;
-	struct annotation *notes;
-
-	notes = symbol__annotation(ms->sym);
-	if (!list_empty(&notes->src->source))
-		return;
-
-	if (symbol__annotate(ms, evsel, NULL) < 0)
-		return;
+	struct annotation *notes = symbol__annotation(ms->sym);
 
-	/* remove non-insn disasm lines for simplicity */
-	list_for_each_entry_safe(dl, tmp_dl, &notes->src->source, al.node) {
-		if (dl->al.offset == -1) {
-			list_del(&dl->al.node);
-			free(dl);
-		}
-	}
+	if (list_empty(&notes->src->source))
+		symbol__annotate(ms, evsel, NULL);
 }
 
 static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
@@ -2170,6 +2157,9 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
 	notes = symbol__annotation(sym);
 
 	list_for_each_entry(dl, &notes->src->source, al.node) {
+		if (dl->al.offset == -1)
+			continue;
+
 		if (sym->start + dl->al.offset == ip) {
 			/*
 			 * llvm-objdump places "lock" in a separate line and
@@ -2234,6 +2224,46 @@ static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
 	return false;
 }
 
+static struct disasm_line *
+annotation__prev_asm_line(struct annotation *notes, struct disasm_line *curr)
+{
+	struct list_head *sources = &notes->src->source;
+	struct disasm_line *prev;
+
+	if (curr == list_first_entry(sources, struct disasm_line, al.node))
+		return NULL;
+
+	prev = list_prev_entry(curr, al.node);
+	while (prev->al.offset == -1 &&
+	       prev != list_first_entry(sources, struct disasm_line, al.node))
+		prev = list_prev_entry(prev, al.node);
+
+	if (prev->al.offset == -1)
+		return NULL;
+
+	return prev;
+}
+
+static struct disasm_line *
+annotation__next_asm_line(struct annotation *notes, struct disasm_line *curr)
+{
+	struct list_head *sources = &notes->src->source;
+	struct disasm_line *next;
+
+	if (curr == list_last_entry(sources, struct disasm_line, al.node))
+		return NULL;
+
+	next = list_next_entry(curr, al.node);
+	while (next->al.offset == -1 &&
+	       next != list_last_entry(sources, struct disasm_line, al.node))
+		next = list_next_entry(next, al.node);
+
+	if (next->al.offset == -1)
+		return NULL;
+
+	return next;
+}
+
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl)
 {
@@ -2249,12 +2279,12 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 	 * disasm_line.  If it's the last one, we can use symbol's end
 	 * address directly.
 	 */
-	if (&dl->al.node == notes->src->source.prev)
+	next = annotation__next_asm_line(notes, dl);
+	if (next == NULL)
 		addr = ms->sym->end + offset;
-	else {
-		next = list_next_entry(dl, al.node);
+	else
 		addr = ip + (next->al.offset - dl->al.offset) + offset;
-	}
+
 	return map__rip_2objdump(ms->map, addr);
 }
 
@@ -2386,10 +2416,13 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	 * from the previous instruction.
 	 */
 	if (dl->al.offset > 0) {
+		struct annotation *notes;
 		struct disasm_line *prev_dl;
 
-		prev_dl = list_prev_entry(dl, al.node);
-		if (ins__is_fused(arch, prev_dl->ins.name, dl->ins.name)) {
+		notes = symbol__annotation(ms->sym);
+		prev_dl = annotation__prev_asm_line(notes, dl);
+
+		if (prev_dl && ins__is_fused(arch, prev_dl->ins.name, dl->ins.name)) {
 			dl = prev_dl;
 			goto retry;
 		}
@@ -2494,8 +2527,16 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 
 	last_dl = list_last_entry(&notes->src->source,
 				  struct disasm_line, al.node);
+	if (last_dl->al.offset == -1)
+		last_dl = annotation__prev_asm_line(notes, last_dl);
+
+	if (last_dl == NULL)
+		return false;
 
 	list_for_each_entry_from(dl, &notes->src->source, al.node) {
+		/* Skip comment or debug info line */
+		if (dl->al.offset == -1)
+			continue;
 		/* Found the target instruction */
 		if (sym->start + dl->al.offset == target) {
 			found = true;
@@ -2516,7 +2557,8 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		/* jump instruction creates new basic block(s) */
 		next_dl = find_disasm_line(sym, sym->start + dl->ops.target.offset,
 					   /*allow_update=*/false);
-		add_basic_block(bb_data, link, next_dl);
+		if (next_dl)
+			add_basic_block(bb_data, link, next_dl);
 
 		/*
 		 * FIXME: determine conditional jumps properly.
@@ -2524,8 +2566,9 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		 * next disasm line.
 		 */
 		if (!strstr(dl->ins.name, "jmp")) {
-			next_dl = list_next_entry(dl, al.node);
-			add_basic_block(bb_data, link, next_dl);
+			next_dl = annotation__next_asm_line(notes, dl);
+			if (next_dl)
+				add_basic_block(bb_data, link, next_dl);
 		}
 		break;
 
-- 
2.44.0.478.gd926399ef9-goog


