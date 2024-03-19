Return-Path: <linux-kernel+bounces-107040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDF887F6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C152B1C21939
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5498D7FBBF;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="umhuJVF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDEE7F7C1;
	Tue, 19 Mar 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827487; cv=none; b=mxZtdfEtubj7xlpITcuyOEfXpy+r/nsqBaB43Ikr8pjnCGN3Vcsq2XTytVwsx1zaOKq7j46Z4IfEDd7o7d06OBi/E9rsYAtl4b5Ca8z4oaMsdyzT8ZqYJzN0kEx3gUSB0veM9zg24c5jsYUv7Nj+VuN8ofe+Ta7tT69h2LryOpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827487; c=relaxed/simple;
	bh=61VgKV31vYUBRqV9qo2hI10KmXR//3S4gszy882fliQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja81ylFSkFVeF/imS9gKkkV/YSNWz/xOGEHN8iYMz71ZCS0ZYhEyqVorwIXggrUGzS0yidn6d3ZE3MsLX2enID04DblGg82fA8DY0tGk7Irtr52XYkup+8vTk+fC/39gf0YOzDyAJTjIPwydaDrNaP2/cUUGCwnzi0JKuuQyn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=umhuJVF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B82C43601;
	Tue, 19 Mar 2024 05:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827486;
	bh=61VgKV31vYUBRqV9qo2hI10KmXR//3S4gszy882fliQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=umhuJVF1TrukWwX4W8toYsh8simW7cVs5LfANlcSY4rJe8oE+iM71gf5/+ieAkRRU
	 fI08EWBEqlqeGsnltQUpReQuGEhto9gGpo3Y00SKELgTtACcm1F9IWCm2MBwU2Q7gg
	 Fcnc2YvmiBDp7pHCU5N1xIjC0fWjpp69VAksCUXOnjyYftcpAIMurb/AnTRHajHn1L
	 xn2z1ygbE3XgbaPbH76HK1gVdqhg2ERRwQX2GINKyLqzglauVtElU8zNEhibzWNHMB
	 WWA7vMXl+Xs8mWKUjFbRMXjHT/PLYpVw6PietBj7Fk47xPHRnHyGvysa6Ey6jekW9B
	 HeyMZ7+HIhAbA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Stephane Eranian <eranian@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-toolchains@vger.kernel.org,
	linux-trace-devel@vger.kernel.org
Subject: [PATCH 14/23] perf annotate-data: Implement instruction tracking
Date: Mon, 18 Mar 2024 22:51:06 -0700
Message-ID: <20240319055115.4063940-15-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If it failed to find a variable for the location directly, it might be
due to a missing variable in the source code.  For example, accessing
pointer variables in a chain can result in the case like below:

  struct foo *foo = ...;

  int i = foo->bar->baz;

The DWARF debug information is created for each variable so it'd have
one for 'foo'.  But there's no variable for 'foo->bar' and then it
cannot know the type of 'bar' and 'baz'.

The above source code can be compiled to the follow x86 instructions:

  mov  0x8(%rax), %rcx
  mov  0x4(%rcx), %rdx   <=== PMU sample
  mov  %rdx, -4(%rbp)

Let's say 'foo' is located in the %rax and it has a pointer to struct
foo.  But perf sample is captured in the second instruction and there
is no variable or type info for the %rcx.

It'd be great if compiler could generate debug info for %rcx, but we
should handle it on our side.  So this patch implements the logic to
iterate instructions and update the type table for each location.

As it already collected a list of scopes including the target
instruction, we can use it to construct the type table smartly.

  +----------------  scope[0] subprogram
  |
  | +--------------  scope[1] lexical_block
  | |
  | | +------------  scope[2] inlined_subroutine
  | | |
  | | | +----------  scope[3] inlined_subroutine
  | | | |
  | | | | +--------  scope[4] lexical_block
  | | | | |
  | | | | |     ***  target instruction
  ...

Image the target instruction has 5 scopes, each scope will have its own
variables and parameters.  Then it can start with the innermost scope
(4).  So it'd search the shortest path from the start of scope[4] to
the target address and build a list of basic blocks.  Then it iterates
the basic blocks with the variables in the scope and update the table.
If it finds a type at the target instruction, then returns it.

Otherwise, it moves to the upper scope[3].  Now it'd search the shortest
path from the start of scope[3] to the start of scope[4].  Then connect
it to the existing basic block list.  Then it'd iterate the blocks with
variables for both scopes.  It can repeat this until it finds a type at
the target instruction or reaches to the top scope[0].

As the basic blocks contain the shortest path, it won't worry about
branches and can update the table simply.

The final check will be done by find_matching_type() in the next patch.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-annotate.c   |   1 +
 tools/perf/util/annotate-data.c | 223 ++++++++++++++++++++++++++++++--
 tools/perf/util/annotate-data.h |   1 +
 3 files changed, 211 insertions(+), 14 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 6c1cc797692d..f677671409b1 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -430,6 +430,7 @@ static void print_annotate_data_stat(struct annotated_data_stat *s)
 	PRINT_STAT(no_typeinfo);
 	PRINT_STAT(invalid_size);
 	PRINT_STAT(bad_offset);
+	PRINT_STAT(insn_track);
 	printf("\n");
 
 #undef PRINT_STAT
diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 6bcf22e523cb..13ba65693367 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -89,15 +89,7 @@ static bool has_reg_type(struct type_state *state, int reg)
 	return (unsigned)reg < ARRAY_SIZE(state->regs);
 }
 
-/* These declarations will be remove once they are changed to static */
-void init_type_state(struct type_state *state, struct arch *arch __maybe_unused);
-void exit_type_state(struct type_state *state);
-void update_var_state(struct type_state *state, struct data_loc_info *dloc,
-		      u64 addr, u64 insn_offset, struct die_var_type *var_types);
-void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       Dwarf_Die *cu_die, struct disasm_line *dl);
-
-void init_type_state(struct type_state *state, struct arch *arch)
+static void init_type_state(struct type_state *state, struct arch *arch)
 {
 	memset(state, 0, sizeof(*state));
 	INIT_LIST_HEAD(&state->stack_vars);
@@ -116,7 +108,7 @@ void init_type_state(struct type_state *state, struct arch *arch)
 	}
 }
 
-void exit_type_state(struct type_state *state)
+static void exit_type_state(struct type_state *state)
 {
 	struct type_state_stack *stack, *tmp;
 
@@ -457,8 +449,8 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
  * This function fills the @state table using @var_types info.  Each variable
  * is used only at the given location and updates an entry in the table.
  */
-void update_var_state(struct type_state *state, struct data_loc_info *dloc,
-		      u64 addr, u64 insn_offset, struct die_var_type *var_types)
+static void update_var_state(struct type_state *state, struct data_loc_info *dloc,
+			     u64 addr, u64 insn_offset, struct die_var_type *var_types)
 {
 	Dwarf_Die mem_die;
 	struct die_var_type *var;
@@ -716,13 +708,207 @@ static void update_insn_state_x86(struct type_state *state,
  * Note that ops->reg2 is only available when both mem_ref and multi_regs
  * are true.
  */
-void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       Dwarf_Die *cu_die, struct disasm_line *dl)
+static void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+			      Dwarf_Die *cu_die, struct disasm_line *dl)
 {
 	if (arch__is(dloc->arch, "x86"))
 		update_insn_state_x86(state, dloc, cu_die, dl);
 }
 
+/*
+ * Prepend this_blocks (from the outer scope) to full_blocks, removing
+ * duplicate disasm line.
+ */
+static void prepend_basic_blocks(struct list_head *this_blocks,
+				 struct list_head *full_blocks)
+{
+	struct annotated_basic_block *first_bb, *last_bb;
+
+	last_bb = list_last_entry(this_blocks, typeof(*last_bb), list);
+	first_bb = list_first_entry(full_blocks, typeof(*first_bb), list);
+
+	if (list_empty(full_blocks))
+		goto out;
+
+	/* Last insn in this_blocks should be same as first insn in full_blocks */
+	if (last_bb->end != first_bb->begin) {
+		pr_debug("prepend basic blocks: mismatched disasm line %"PRIx64" -> %"PRIx64"\n",
+			 last_bb->end->al.offset, first_bb->begin->al.offset);
+		goto out;
+	}
+
+	/* Is the basic block have only one disasm_line? */
+	if (last_bb->begin == last_bb->end) {
+		list_del(&last_bb->list);
+		free(last_bb);
+		goto out;
+	}
+
+	/* Point to the insn before the last when adding this block to full_blocks */
+	last_bb->end = list_prev_entry(last_bb->end, al.node);
+
+out:
+	list_splice(this_blocks, full_blocks);
+}
+
+static void delete_basic_blocks(struct list_head *basic_blocks)
+{
+	struct annotated_basic_block *bb, *tmp;
+
+	list_for_each_entry_safe(bb, tmp, basic_blocks, list) {
+		list_del(&bb->list);
+		free(bb);
+	}
+}
+
+/* Make sure all variables have a valid start address */
+static void fixup_var_address(struct die_var_type *var_types, u64 addr)
+{
+	while (var_types) {
+		/*
+		 * Some variables have no address range meaning it's always
+		 * available in the whole scope.  Let's adjust the start
+		 * address to the start of the scope.
+		 */
+		if (var_types->addr == 0)
+			var_types->addr = addr;
+
+		var_types = var_types->next;
+	}
+}
+
+static void delete_var_types(struct die_var_type *var_types)
+{
+	while (var_types) {
+		struct die_var_type *next = var_types->next;
+
+		free(var_types);
+		var_types = next;
+	}
+}
+
+/* It's at the target address, check if it has a matching type */
+static bool find_matching_type(struct type_state *state __maybe_unused,
+			       struct data_loc_info *dloc __maybe_unused,
+			       int reg __maybe_unused,
+			       Dwarf_Die *type_die __maybe_unused)
+{
+	/* TODO */
+	return false;
+}
+
+/* Iterate instructions in basic blocks and update type table */
+static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
+				struct list_head *basic_blocks,
+				struct die_var_type *var_types,
+				Dwarf_Die *cu_die, Dwarf_Die *type_die)
+{
+	struct type_state state;
+	struct symbol *sym = dloc->ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotated_basic_block *bb;
+	bool found = false;
+
+	init_type_state(&state, dloc->arch);
+
+	list_for_each_entry(bb, basic_blocks, list) {
+		struct disasm_line *dl = bb->begin;
+
+		pr_debug_dtp("bb: [%"PRIx64" - %"PRIx64"]\n",
+			     bb->begin->al.offset, bb->end->al.offset);
+
+		list_for_each_entry_from(dl, &notes->src->source, al.node) {
+			u64 this_ip = sym->start + dl->al.offset;
+			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
+
+			/* Update variable type at this address */
+			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
+
+			if (this_ip == dloc->ip) {
+				found = find_matching_type(&state, dloc, reg,
+							   type_die);
+				goto out;
+			}
+
+			/* Update type table after processing the instruction */
+			update_insn_state(&state, dloc, cu_die, dl);
+			if (dl == bb->end)
+				break;
+		}
+	}
+
+out:
+	exit_type_state(&state);
+	return found;
+}
+
+/*
+ * Construct a list of basic blocks for each scope with variables and try to find
+ * the data type by updating a type state table through instructions.
+ */
+static int find_data_type_block(struct data_loc_info *dloc, int reg,
+				Dwarf_Die *cu_die, Dwarf_Die *scopes,
+				int nr_scopes, Dwarf_Die *type_die)
+{
+	LIST_HEAD(basic_blocks);
+	struct die_var_type *var_types = NULL;
+	u64 src_ip, dst_ip, prev_dst_ip;
+	int ret = -1;
+
+	/* TODO: other architecture support */
+	if (!arch__is(dloc->arch, "x86"))
+		return -1;
+
+	prev_dst_ip = dst_ip = dloc->ip;
+	for (int i = nr_scopes - 1; i >= 0; i--) {
+		Dwarf_Addr base, start, end;
+		LIST_HEAD(this_blocks);
+
+		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
+			break;
+
+		pr_debug_dtp("scope: [%d/%d] (die:%lx)\n",
+			     i + 1, nr_scopes, (long)dwarf_dieoffset(&scopes[i]));
+		src_ip = map__objdump_2rip(dloc->ms->map, start);
+
+again:
+		/* Get basic blocks for this scope */
+		if (annotate_get_basic_blocks(dloc->ms->sym, src_ip, dst_ip,
+					      &this_blocks) < 0) {
+			/* Try previous block if they are not connected */
+			if (prev_dst_ip != dst_ip) {
+				dst_ip = prev_dst_ip;
+				goto again;
+			}
+
+			pr_debug_dtp("cannot find a basic block from %"PRIx64" to %"PRIx64"\n",
+				     src_ip - dloc->ms->sym->start,
+				     dst_ip - dloc->ms->sym->start);
+			continue;
+		}
+		prepend_basic_blocks(&this_blocks, &basic_blocks);
+
+		/* Get variable info for this scope and add to var_types list */
+		die_collect_vars(&scopes[i], &var_types);
+		fixup_var_address(var_types, start);
+
+		/* Find from start of this scope to the target instruction */
+		if (find_data_type_insn(dloc, reg, &basic_blocks, var_types,
+					cu_die, type_die)) {
+			ret = 0;
+			break;
+		}
+
+		/* Go up to the next scope and find blocks to the start */
+		prev_dst_ip = dst_ip;
+		dst_ip = src_ip;
+	}
+
+	delete_basic_blocks(&basic_blocks);
+	delete_var_types(var_types);
+	return ret;
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
@@ -847,6 +1033,15 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto out;
 	}
 
+	if (reg != DWARF_REG_PC) {
+		ret = find_data_type_block(dloc, reg, &cu_die, scopes,
+					   nr_scopes, type_die);
+		if (ret == 0) {
+			ann_data_stat.insn_track++;
+			goto out;
+		}
+	}
+
 	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
 		reg = loc->reg2;
 		goto retry;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index acfbd1748d02..ae0f87aed804 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -135,6 +135,7 @@ struct annotated_data_stat {
 	int no_typeinfo;
 	int invalid_size;
 	int bad_offset;
+	int insn_track;
 };
 extern struct annotated_data_stat ann_data_stat;
 
-- 
2.44.0.291.gc1ea87d7ee-goog


