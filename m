Return-Path: <linux-kernel+bounces-107036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BED87F6EA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F54328283B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8707E796;
	Tue, 19 Mar 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iM1ZVht4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030C67E583;
	Tue, 19 Mar 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827484; cv=none; b=BNn9MajwNHkp7u1tq5v5WdKAjaj8p95/82LJOa5GewM2njNcNJltxVoaVeRtI3/2PCb2nZ9eVjr6kJnt6D2Zb3pWrN4rEph0/dvV+QBQvoMjPTWy4qlWnRSIx1me4CDGbl0IzqF6C1I9Tqivggm0JNGpBNXHUu8HnIaT6W+yWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827484; c=relaxed/simple;
	bh=4LofnhBbDvtFowCiRDglvw22DbDrZ65v42pKGJKRikM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ks3NNuvM3Q6QClouqgfTb/XCFOAao3aCRrfZET7UhDdH0PRHVTq30/aI+Z8HP+BbygYUbzq0AQsE/be6cxN+wMZaBSH98eJVnqNTj6QIBm7Sk7KW/OeN3uUMt7rQrJy/5QmEpTm8KQaqOx0DT9Ia1vKR2Hn6CLLSlubi8drMK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iM1ZVht4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 262B7C4166A;
	Tue, 19 Mar 2024 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827483;
	bh=4LofnhBbDvtFowCiRDglvw22DbDrZ65v42pKGJKRikM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iM1ZVht4BxqYAzOY6yQuh8lRg3YrjtT8IXT+Yde4vEJ9yvzL6uBFt3KXbc5WDslX7
	 /4sFxgM/cpjsKiaYhdJEeSsqN512nG+rfMSmogvr7aMMyjKsWawtWm5GgZuIWu3Ba4
	 ytsn38kFOVKBBmrAJ13U4PT7TJjBLlFSK8xrGb23M2onpcB1tn3xJ9qTZEn7mx7B6G
	 of4kbJ9d96ChGEWa2QyYc+T1yZOm1MHMyWVA7Zy/aASkQDAgtbI6Han5Izj2gO/F/r
	 o4B5fzy53oU3MCEddJuKCByCC1eyzoDvXcO/4RonkZ1uh8gTiSqmi7GoXkiDgGGJPG
	 8x4Mm0UuLj5BA==
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
Subject: [PATCH 10/23] perf annotate-data: Add update_insn_state()
Date: Mon, 18 Mar 2024 22:51:02 -0700
Message-ID: <20240319055115.4063940-11-namhyung@kernel.org>
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

The update_insn_state() function is to update the type state table after
processing each instruction.  For now, it handles MOV (on x86) insn
to transfer type info from the source location to the target.

The location can be a register or a stack slot.  Check carefully when
memory reference happens and fetch the type correctly.  It basically
ignores write to a memory since it doesn't change the type info.  One
exception is writes to (new) stack slots for register spilling.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 161 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.h |   2 +
 tools/perf/util/annotate.c      |   1 +
 3 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 8eaa06f1cee5..592437b6c097 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -71,7 +71,9 @@ struct type_state_stack {
  * shortest path of basic blocks, it only maintains a single table.
  */
 struct type_state {
+	/* state of general purpose registers */
 	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
+	/* state of stack location */
 	struct list_head stack_vars;
 };
 
@@ -85,6 +87,8 @@ void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
 void exit_type_state(struct type_state *state);
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 		      u64 addr, u64 insn_offset, struct die_var_type *var_types);
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl);
 
 void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
 {
@@ -412,13 +416,13 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 		if (var->reg == DWARF_REG_FB) {
 			findnew_stack_state(state, var->offset, &mem_die);
 
-			pr_debug_dtp("var [%"PRIx64"] -%#x(stack) type=",
+			pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
 				     insn_offset, -var->offset);
 			pr_debug_type_name(&mem_die);
 		} else if (var->reg == fbreg) {
 			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
 
-			pr_debug_dtp("var [%"PRIx64"] -%#x(stack) type=",
+			pr_debug_dtp("var [%"PRIx64"] -%#x(stack)",
 				     insn_offset, -var->offset + fb_offset);
 			pr_debug_type_name(&mem_die);
 		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
@@ -428,13 +432,164 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 			reg->type = mem_die;
 			reg->ok = true;
 
-			pr_debug_dtp("var [%"PRIx64"] reg%d type=",
+			pr_debug_dtp("var [%"PRIx64"] reg%d",
 				     insn_offset, var->reg);
 			pr_debug_type_name(&mem_die);
 		}
 	}
 }
 
+static void update_insn_state_x86(struct type_state *state,
+				  struct data_loc_info *dloc,
+				  struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	struct type_state_reg *tsr;
+	Dwarf_Die type_die;
+	u32 insn_offset = dl->al.offset;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	if (strncmp(dl->ins.name, "mov", 3))
+		return;
+
+	if (dloc->fb_cfa) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+	}
+
+	/* Case 1. register to register transfers */
+	if (!src->mem_ref && !dst->mem_ref) {
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		tsr = &state->regs[dst->reg1];
+		if (!has_reg_type(state, src->reg1) ||
+		    !state->regs[src->reg1].ok) {
+			tsr->ok = false;
+			return;
+		}
+
+		tsr->type = state->regs[src->reg1].type;
+		tsr->ok = true;
+
+		pr_debug_dtp("mov [%x] reg%d -> reg%d",
+			     insn_offset, src->reg1, dst->reg1);
+		pr_debug_type_name(&tsr->type);
+	}
+	/* Case 2. memory to register transers */
+	if (src->mem_ref && !dst->mem_ref) {
+		int sreg = src->reg1;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		tsr = &state->regs[dst->reg1];
+
+retry:
+		/* Check stack variables with offset */
+		if (sreg == fbreg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack == NULL) {
+				tsr->ok = false;
+				return;
+			} else if (!stack->compound) {
+				tsr->type = stack->type;
+				tsr->ok = true;
+			} else if (die_get_member_type(&stack->type,
+						       offset - stack->offset,
+						       &type_die)) {
+				tsr->type = type_die;
+				tsr->ok = true;
+			} else {
+				tsr->ok = false;
+				return;
+			}
+
+			pr_debug_dtp("mov [%x] -%#x(stack) -> reg%d",
+				     insn_offset, -offset, dst->reg1);
+			pr_debug_type_name(&tsr->type);
+		}
+		/* And then dereference the pointer if it has one */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 die_deref_ptr_type(&state->regs[sreg].type,
+					    src->offset, &type_die)) {
+			tsr->type = type_die;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] %#x(reg%d) -> reg%d",
+				     insn_offset, src->offset, sreg, dst->reg1);
+			pr_debug_type_name(&tsr->type);
+		}
+		/* Or try another register if any */
+		else if (src->multi_regs && sreg == src->reg1 &&
+			 src->reg1 != src->reg2) {
+			sreg = src->reg2;
+			goto retry;
+		}
+		/* It failed to get a type info, mark it as invalid */
+		else {
+			tsr->ok = false;
+		}
+	}
+	/* Case 3. register to memory transfers */
+	if (!src->mem_ref && dst->mem_ref) {
+		if (!has_reg_type(state, src->reg1) ||
+		    !state->regs[src->reg1].ok)
+			return;
+
+		/* Check stack variables with offset */
+		if (dst->reg1 == fbreg) {
+			struct type_state_stack *stack;
+			int offset = dst->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack) {
+				/*
+				 * The source register is likely to hold a type
+				 * of member if it's a compound type.  Do not
+				 * update the stack variable type since we can
+				 * get the member type later by using the
+				 * die_get_member_type().
+				 */
+				if (!stack->compound)
+					set_stack_state(stack, offset,
+							&state->regs[src->reg1].type);
+			} else {
+				findnew_stack_state(state, offset,
+						    &state->regs[src->reg1].type);
+			}
+
+			pr_debug_dtp("mov [%x] reg%d -> -%#x(stack)",
+				     insn_offset, src->reg1, -offset);
+			pr_debug_type_name(&state->regs[src->reg1].type);
+		}
+		/*
+		 * Ignore other transfers since it'd set a value in a struct
+		 * and won't change the type.
+		 */
+	}
+	/* Case 4. memory to memory transfers (not handled for now) */
+}
+
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl)
+{
+	if (arch__is(dloc->arch, "x86"))
+		update_insn_state_x86(state, dloc, dl);
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ad6493ea2c8e..7324cafe2c7b 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -75,6 +75,7 @@ extern struct annotated_data_type stackop_type;
 
 /**
  * struct data_loc_info - Data location information
+ * @arch: CPU architecture info
  * @ms: Map and Symbol info
  * @ip: Instruction address
  * @var_addr: Data address (for global variables)
@@ -87,6 +88,7 @@ extern struct annotated_data_type stackop_type;
  */
 struct data_loc_info {
 	/* These are input field, should be filled by caller */
+	struct arch *arch;
 	struct map_symbol *ms;
 	u64 ip;
 	u64 var_addr;
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index aa005c13ff67..9777df5dc2e3 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3872,6 +3872,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
+			.arch = arch,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
-- 
2.44.0.291.gc1ea87d7ee-goog


