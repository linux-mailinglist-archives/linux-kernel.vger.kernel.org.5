Return-Path: <linux-kernel+bounces-50641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B008D847C04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F9C1F2B799
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D37812C801;
	Fri,  2 Feb 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r1RiXsPu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6812D762;
	Fri,  2 Feb 2024 22:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911507; cv=none; b=fedeBVj76bAiK1B0osXiK2Qd0uoqyreaYXxqn9z3sugCmMARXqtV/tCbC7Vx71aC7++RQ4TQMwYx5WutCGncdaP8Dv/6hM4r/Cdh7kSx/uqHKkTZwfvu7MzdZ5/g2DZnsnD14OBu0cTR+FvspC5JZ9KPuwEy33i6jJ+7UGdk5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911507; c=relaxed/simple;
	bh=Lf0brn5nL1UgsdGJBLme5o8pREvbDQOaQ2MZkihr1mQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+tqmWHyZKhr3mw9Y8b83eSBTkyhpvXLP2N9oIa3Uejtzi2PggBxDXtaXTFcIaqWcBAhAeYDRsOpJdxiA31ark2Cq0mo37dA5m+vU0ycVwOQtwa1siLcgu/knqdFvPaqdYj9Q5ytjITuscuRseLlmSBb2CCfI09GFZk7Bo22DXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r1RiXsPu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EE7FC433C7;
	Fri,  2 Feb 2024 22:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911506;
	bh=Lf0brn5nL1UgsdGJBLme5o8pREvbDQOaQ2MZkihr1mQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r1RiXsPuuGOoR3yz+7ZpliRqSyNDQtW+64gTe3HFYJaQR1gZgbPl8pxql78E5PPH/
	 Nc7lFEC9Qo0FVChl2GlUuMFnw7HVOHAeQwikgL5CwkNeVDuh2l5nx7B4pji7iilBV9
	 OXXWF2Xxhw/YCkyst9qTgaFGmSWznwhg4fQlsK+me/C+CuJzw9jM+LAwIynaZGFyRF
	 EHw43ObyJHdtnp/3owV56s1hHymc48hra5Phl+vXV4Bvn5qliJQ0DNNwdwwsqffNVQ
	 Ww8kJm/BJenZaaAoWSSiIZTL8IQvkwjMLLwqeCgqGSXkQW4gI2JQ2EEw6ifReCl38M
	 /VWgzctnw3PEQ==
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
Subject: [PATCH 08/14] perf annotate-data: Handle global variable access
Date: Fri,  2 Feb 2024 14:04:53 -0800
Message-ID: <20240202220459.527138-9-namhyung@kernel.org>
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

When updating the instruction states, it also needs to handle global
variable accesses.  Same as it does for PC-relative addressing, it can
look up the type by address (if it's defined in the same file), or by
name after finding the symbol by address (for declarations).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 45 ++++++++++++++++++++++++++++++---
 tools/perf/util/annotate-data.h | 10 ++++++--
 tools/perf/util/annotate.c      | 45 ++++++++++++++++++++-------------
 tools/perf/util/annotate.h      |  5 ++++
 4 files changed, 83 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index b1e921663452..e46e162c783f 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -396,6 +396,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * update_insn_state - Update type state for an instruction
  * @state: type state table
  * @dloc: data location info
+ * @cu_die: compile unit debug entry
  * @dl: disasm line for the instruction
  *
  * This function updates the @state table for the target operand of the
@@ -407,7 +408,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * are true.
  */
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl)
+		       void *cu_die, struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
@@ -449,8 +450,46 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 			return;
 
 retry:
-		/* Check stack variables with offset */
-		if (sreg == fbreg) {
+		/* Check if it's a global variable */
+		if (sreg == DWARF_REG_PC) {
+			Dwarf_Die var_die;
+			struct map_symbol *ms = dloc->ms;
+			int offset = src->offset;
+			u64 ip = ms->sym->start + dl->al.offset;
+			u64 pc, addr;
+			const char *var_name = NULL;
+
+			addr = annotate_calc_pcrel(ms, ip, offset, dl);
+			pc = map__rip_2objdump(ms->map, ip);
+
+			if (die_find_variable_by_addr(cu_die, pc, addr,
+						      &var_die, &offset) &&
+			    check_variable(&var_die, &type_die, offset,
+					   /*is_pointer=*/false) == 0 &&
+			    die_get_member_type(&type_die, offset, &type_die)) {
+				state->regs[dst->reg1].type = type_die;
+				state->regs[dst->reg1].ok = true;
+				return;
+			}
+
+			/* Try to get the name of global variable */
+			offset = src->offset;
+			get_global_var_info(dloc->thread, ms, ip, dl,
+					    dloc->cpumode, &addr,
+					    &var_name, &offset);
+
+			if (var_name && die_find_variable_at(cu_die, var_name,
+							     pc, &var_die) &&
+			    check_variable(&var_die, &type_die, offset,
+					   /*is_pointer=*/false) == 0 &&
+			    die_get_member_type(&type_die, offset, &type_die)) {
+				state->regs[dst->reg1].type = type_die;
+				state->regs[dst->reg1].ok = true;
+			} else
+				state->regs[dst->reg1].ok = false;
+		}
+		/* And check stack variables with offset */
+		else if (sreg == fbreg) {
 			struct type_state_stack *stack;
 			int offset = src->offset - fboff;
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ff9acf6ea808..0bfef29fa52c 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -14,6 +14,7 @@ struct die_var_type;
 struct disasm_line;
 struct evsel;
 struct map_symbol;
+struct thread;
 struct type_state;
 
 /**
@@ -79,11 +80,13 @@ extern struct annotated_data_type stackop_type;
 
 /**
  * struct data_loc_info - Data location information
- * @arch: architecture info
+ * @arch: CPU architecture info
+ * @thread: Thread info
  * @ms: Map and Symbol info
  * @ip: Instruction address
  * @var_addr: Data address (for global variables)
  * @var_name: Variable name (for global variables)
+ * @cpumode: CPU execution mode
  * @op: Instruction operand location (regs and offset)
  * @di: Debug info
  * @fbreg: Frame base register
@@ -94,8 +97,10 @@ struct data_loc_info {
 	/* These are input field, should be filled by caller */
 	struct arch *arch;
 	struct map_symbol *ms;
+	struct thread *thread;
 	u64 ip;
 	u64 var_addr;
+	u8 cpumode;
 	const char *var_name;
 	struct annotated_op_loc *op;
 
@@ -164,7 +169,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 
 /* Update type state table for an instruction */
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl);
+		       void *cu_die, struct disasm_line *dl);
 
 #else /* HAVE_DWARF_SUPPORT */
 
@@ -206,6 +211,7 @@ static inline void update_var_state(struct type_state *state __maybe_unused,
 
 static inline void update_insn_state(struct type_state *state __maybe_unused,
 				     struct data_loc_info *dloc __maybe_unused,
+				     void *cu_die __maybe_unused,
 				     struct disasm_line *dl __maybe_unused)
 {
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 44574056d4bd..89a8d57b1bf7 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3771,6 +3771,28 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 	return map__rip_2objdump(ms->map, addr);
 }
 
+void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
+			 struct disasm_line *dl, u8 cpumode, u64 *var_addr,
+			 const char **var_name, int *poffset)
+{
+	struct addr_location al;
+	struct symbol *var;
+	u64 map_addr;
+
+	*var_addr = annotate_calc_pcrel(ms, ip, *poffset, dl);
+	/* Kernel symbols might be relocated */
+	map_addr = *var_addr + map__reloc(ms->map);
+
+	addr_location__init(&al);
+	var = thread__find_symbol_fb(thread, cpumode, map_addr, &al);
+	if (var) {
+		*var_name = var->name;
+		/* Calculate type offset from the start of variable */
+		*poffset = map_addr - map__unmap_ip(al.map, var->start);
+	}
+	addr_location__exit(&al);
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3845,6 +3867,8 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
+			.thread = he->thread,
+			.cpumode = he->cpumode,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
@@ -3859,23 +3883,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 		/* PC-relative addressing */
 		if (op_loc->reg1 == DWARF_REG_PC) {
-			struct addr_location al;
-			struct symbol *var;
-			u64 map_addr;
-
-			dloc.var_addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
-			/* Kernel symbols might be relocated */
-			map_addr = dloc.var_addr + map__reloc(ms->map);
-
-			addr_location__init(&al);
-			var = thread__find_symbol_fb(he->thread, he->cpumode,
-						     map_addr, &al);
-			if (var) {
-				dloc.var_name = var->name;
-				/* Calculate type offset from the start of variable */
-				dloc.type_offset = map_addr - map__unmap_ip(al.map, var->start);
-			}
-			addr_location__exit(&al);
+			dloc.type_offset = op_loc->offset;
+			get_global_var_info(he->thread, ms, ip, dl, he->cpumode,
+					    &dloc.var_addr, &dloc.var_name,
+					    &dloc.type_offset);
 		}
 
 		mem_type = find_data_type(&dloc);
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 83afbe294ab7..b460785111a1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct thread;
 struct annotated_data_type;
 
 struct ins {
@@ -495,6 +496,10 @@ extern struct list_head ann_insn_stat;
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl);
 
+void get_global_var_info(struct thread *thread, struct map_symbol *ms, u64 ip,
+			 struct disasm_line *dl, u8 cpumode, u64 *var_addr,
+			 const char **var_name, int *poffset);
+
 /**
  * struct annotated_basic_block - Basic block of instructions
  * @list: List node
-- 
2.43.0.594.gd9cf4e227d-goog


