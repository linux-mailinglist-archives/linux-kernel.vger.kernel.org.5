Return-Path: <linux-kernel+bounces-50640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 670C2847C02
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DFFA28AE58
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD93412F36B;
	Fri,  2 Feb 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGPChVcn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0D612C81D;
	Fri,  2 Feb 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911506; cv=none; b=QkDJt9eIe0F5tVl07Qsru7O4XFSv0va84lhZuIZpAv5+Ov3eJyPjbb5TKs/AzGxI8AnLHeWKsqzsFUTDehcejmtyBTYDLcc0pHPLvCgq4HnAFko8TM9TktKZ2h4kwZ5eP5j5Csx0BKU9W1U0ILCREMB3UlwE8gSQU57ojcP0iz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911506; c=relaxed/simple;
	bh=qaVZKbMGcsmUmdHezxQM/TrUxZNd4m0wzUk80zpPxq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N7zB/BjbK1KaCcrNeFrccueFiioIWOgmHCooijsOKon6JNZ6TXZYUspYkFc8sd0ZryEFkUz+aSOL0BCYEx7kBPuHQuMv/dLpgf0kLkhYI7pBxV3tsEHP5dWbwo0kizOsoBfUB7OUwGYiUsZ7LSUlhD61Ph/NRUwn+PcUkmfiakQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGPChVcn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CFAC43390;
	Fri,  2 Feb 2024 22:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911506;
	bh=qaVZKbMGcsmUmdHezxQM/TrUxZNd4m0wzUk80zpPxq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RGPChVcnHKceZKxHgO+de7hlxSsLN0XuERsLKJBxhVSEU9W0MgV+5vyel3Y45fvyD
	 6P15TAkhrap1j6islLnXZLw7r+SNLhZ9v61Gt3Pib0zgZHcOkd7xE9iLbJJRUPda9K
	 ldHkNUbdyfHaOWkPfNdrG+rfCJ+SsFlsDmH6OHp8ziYS84PLDGrw2185s8cwyXfuWB
	 QExsjGGCrbxXXg9/mGw7ZXY3kF6g6PEYr6R8h1F6mrFWkmSdHJ8MnxeUwsbCHNdiLX
	 6Y3x9DLweCWPDETLvJ93FDFFxhznU3RiMWOlThJxTB55c9tQ114QnSxfPdQ4zjrwmp
	 kHvV2402zZLgQ==
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
Subject: [PATCH 07/14] perf annotate-data: Add update_insn_state()
Date: Fri,  2 Feb 2024 14:04:52 -0800
Message-ID: <20240202220459.527138-8-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 128 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.h |  13 ++++
 tools/perf/util/annotate.c      |   1 +
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f8768c224bcc..b1e921663452 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -27,7 +27,6 @@
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
-	bool scratch;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -383,7 +382,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 			findnew_stack_state(state, var->offset, &mem_die);
 		} else if (var->reg == fbreg) {
 			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
-		} else if (has_reg_type(state, var->reg)) {
+		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
 
 			reg = &state->regs[var->reg];
@@ -393,6 +392,131 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 	}
 }
 
+/**
+ * update_insn_state - Update type state for an instruction
+ * @state: type state table
+ * @dloc: data location info
+ * @dl: disasm line for the instruction
+ *
+ * This function updates the @state table for the target operand of the
+ * instruction at @dl if it transfers the type like MOV on x86.  Since it
+ * tracks the type, it won't care about the values like in arithmetic
+ * instructions like ADD/SUB/MUL/DIV and INC/DEC.
+ *
+ * Note that ops->reg2 is only available when both mem_ref and multi_regs
+ * are true.
+ */
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	Dwarf_Die type_die;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	/* FIXME: remove x86 specific code and handle more instructions like LEA */
+	if (!strstr(dl->ins.name, "mov"))
+		return;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
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
+		if (has_reg_type(state, src->reg1))
+			state->regs[dst->reg1] = state->regs[src->reg1];
+		else
+			state->regs[dst->reg1].ok = false;
+	}
+	/* Case 2. memory to register transers */
+	if (src->mem_ref && !dst->mem_ref) {
+		int sreg = src->reg1;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+retry:
+		/* Check stack variables with offset */
+		if (sreg == fbreg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack && die_get_member_type(&stack->type,
+							 offset - stack->offset,
+							 &type_die)) {
+				state->regs[dst->reg1].type = type_die;
+				state->regs[dst->reg1].ok = true;
+			} else
+				state->regs[dst->reg1].ok = false;
+		}
+		/* And then dereference the pointer if it has one */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 die_deref_ptr_type(&state->regs[sreg].type,
+					    src->offset, &type_die)) {
+			state->regs[dst->reg1].type = type_die;
+			state->regs[dst->reg1].ok = true;
+		}
+		/* Or try another register if any */
+		else if (src->multi_regs && sreg == src->reg1 &&
+			 src->reg1 != src->reg2) {
+			sreg = src->reg2;
+			goto retry;
+		}
+		/* It failed to get a type info, mark it as invalid */
+		else {
+			state->regs[dst->reg1].ok = false;
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
+		}
+		/*
+		 * Ignore other transfers since it'd set a value in a struct
+		 * and won't change the type.
+		 */
+	}
+	/* Case 4. memory to memory transfers (not handled for now) */
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 7fbb9eb2e96f..ff9acf6ea808 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -11,6 +11,7 @@ struct annotated_op_loc;
 struct arch;
 struct debuginfo;
 struct die_var_type;
+struct disasm_line;
 struct evsel;
 struct map_symbol;
 struct type_state;
@@ -78,6 +79,7 @@ extern struct annotated_data_type stackop_type;
 
 /**
  * struct data_loc_info - Data location information
+ * @arch: architecture info
  * @ms: Map and Symbol info
  * @ip: Instruction address
  * @var_addr: Data address (for global variables)
@@ -90,6 +92,7 @@ extern struct annotated_data_type stackop_type;
  */
 struct data_loc_info {
 	/* These are input field, should be filled by caller */
+	struct arch *arch;
 	struct map_symbol *ms;
 	u64 ip;
 	u64 var_addr;
@@ -159,6 +162,10 @@ void exit_type_state(struct type_state *state);
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 		      u64 addr, struct die_var_type *var_types);
 
+/* Update type state table for an instruction */
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -197,6 +204,12 @@ static inline void update_var_state(struct type_state *state __maybe_unused,
 {
 }
 
+static inline void update_insn_state(struct type_state *state __maybe_unused,
+				     struct data_loc_info *dloc __maybe_unused,
+				     struct disasm_line *dl __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 4ef14b3f49e4..44574056d4bd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3844,6 +3844,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
+			.arch = arch,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
-- 
2.43.0.594.gd9cf4e227d-goog


