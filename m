Return-Path: <linux-kernel+bounces-69502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F27858A5E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A444A1F21E05
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C091C148FF9;
	Fri, 16 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="svlHEZrA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04E14E2C3;
	Fri, 16 Feb 2024 23:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127671; cv=none; b=lidHjEeH7QUvUrHailowGQFobxkcIkFphuo6qUiDkmcfhL3XORiinKiS2w9+zNC77FrQSqzkLzIFZ3M3HZcoUz0EOPclteNUwIGoSDiMQ4NyFmnr4JeFfsbnD9giGo21323ZIq7m2GKCd+9eAtOlXGmzL2mVP0eMYn9wwVWHJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127671; c=relaxed/simple;
	bh=mxQgos6l91axIiDZvKbOHQz0qaSv4aKPPA72xFNlJzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mZrEVG+BNVBEFqLDrQ0Sa3xaBDn85jQxzA471EYalHZf4HzaZRfNH+ZBs225qgDW2XwVIOjqLSwN5GwWvyxx4vJQJqyDb2e2Fki8wgbLTMQ6u4ae8mfBXLduM8fCVn2V9TrVGqWCW+Pfs69jRo9HuqW9jZYa6epHq0XE1jhQ9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=svlHEZrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE6CC43390;
	Fri, 16 Feb 2024 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127671;
	bh=mxQgos6l91axIiDZvKbOHQz0qaSv4aKPPA72xFNlJzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=svlHEZrAjad61GT4SGkJYPeohlJ4BH2qhvWmrxvxGrgSPgmm9VdPFU5c/003bc+Lj
	 eMhbhdKn4D4Y26VTgamKR4HW3SC3Rc8rd0Wf4dDb8dJYMYwcDvctHtzVcbufYGNYrF
	 Tomua08pSdvQxPRrm11AIxUZX4m8iB+8Ul9X+YZm1UAcLFT5Vk7LM/0iJeQSyeZ4Ej
	 lVp9DhbMqZRnAoKF74yn7afwi9C6F2lJ4pVmg2g/XBZAmTJBLeGggBEEWEFDhphXkL
	 ctbiVIxgfqYXE6XLZFE55rvrg+5O3QmHvhM/ey9+ZreCk8HVXH2L8eExGBss0utcrD
	 QRMfg3imvQrXg==
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
Subject: [PATCH 10/14] perf annotate-data: Implement instruction tracking
Date: Fri, 16 Feb 2024 15:54:19 -0800
Message-ID: <20240216235423.2343167-11-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
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

With this change, the stat now looks like below:

  Annotate data type stats:
  total 294, ok 185 (62.9%), bad 109 (37.1%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          27 : no_var
          13 : no_typeinfo
           7 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 232 ++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e8e363fed8c2..9dab5cc5c842 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -597,6 +597,231 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 	/* Case 4. memory to memory transfers (not handled for now) */
 }
 
+/* Prepend this_list to full_list, removing duplicate disasm line */
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
+	if (last_bb->end != first_bb->begin) {
+		pr_debug("prepend basic blocks: mismatched disasm line %lx -> %lx\n",
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
+static bool find_matching_type(struct type_state *state,
+			       struct data_loc_info *dloc, int reg,
+			       Dwarf_Die *type_die)
+{
+	Dwarf_Word size;
+
+	if (state->regs[reg].ok) {
+		int tag = dwarf_tag(&state->regs[reg].type);
+
+		/*
+		 * Normal registers should hold a pointer (or array) to
+		 * dereference a memory location.
+		 */
+		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type)
+			return false;
+
+		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
+			return false;
+
+		dloc->type_offset = dloc->op->offset;
+
+		/* Get the size of the actual type */
+		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		    (unsigned)dloc->type_offset >= size)
+			return false;
+
+		return true;
+	}
+
+	if (reg == dloc->fbreg) {
+		struct type_state_stack *stack;
+
+		stack = find_stack_state(state, dloc->type_offset);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= stack->offset;
+		return true;
+	}
+
+	if (dloc->fb_cfa) {
+		struct type_state_stack *stack;
+		u64 pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
+		int fbreg, fboff;
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+
+		if (reg != fbreg)
+			return false;
+
+		stack = find_stack_state(state, dloc->type_offset - fboff);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= fboff + stack->offset;
+		return true;
+	}
+
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
+		list_for_each_entry_from(dl, &notes->src->source, al.node) {
+			u64 this_ip = sym->start + dl->al.offset;
+			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
+
+			/* Update variable type at this address */
+			update_var_state(&state, dloc, addr, var_types);
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
+	u64 src_ip, dst_ip;
+	int ret = -1;
+
+	dst_ip = dloc->ip;
+	for (int i = nr_scopes - 1; i >= 0; i--) {
+		Dwarf_Addr base, start, end;
+		LIST_HEAD(this_blocks);
+
+		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
+			break;
+
+		src_ip = map__objdump_2rip(dloc->ms->map, start);
+
+		/* Get basic blocks for this scope */
+		if (annotate_get_basic_blocks(dloc->ms->sym, src_ip, dst_ip,
+					      &this_blocks) < 0)
+			continue;
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
@@ -697,6 +922,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto out;
 	}
 
+	if (reg != DWARF_REG_PC) {
+		ret = find_data_type_block(dloc, reg, &cu_die, scopes,
+					   nr_scopes, type_die);
+		if (ret == 0)
+			goto out;
+	}
+
 	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
 		reg = loc->reg2;
 		goto retry;
-- 
2.44.0.rc0.258.g7320e95886-goog


