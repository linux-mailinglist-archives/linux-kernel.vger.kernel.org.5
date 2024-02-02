Return-Path: <linux-kernel+bounces-50636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5CB847BFE
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520AA28AEEC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4658A126F34;
	Fri,  2 Feb 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1UkVyRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9E385954;
	Fri,  2 Feb 2024 22:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911504; cv=none; b=ZQiAKe76BZe5Ho0dtM7MGyZiw7PYnEq1r27rLdjy/rq5TAwNgWzvGItvq64XdrRptKFLMHkSNJk8oOFrYbc/7Aep54OU0ztPMMfwRIVwfdl8X3i4gy6vyssp5nkbPtbxl/B4lk5jZ7HqsH5+DWsbS5BsFXs4VPu3XHNtgnntAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911504; c=relaxed/simple;
	bh=uJ/e1019xzEMihf4k8j5WuA+3QD3U7RV6gdd3li3qcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTe5vP8JCzxbxcUhyc1EU8g6rF5160/D9BYLXbLc5tFjnMD1OU9fdvAmmAW78+S6+GshTd6ds+wip8IriIfWuE4JAZaD8Uzwft0KL8+XmgB4WN0JdDuAk6V5IDxTV207BctlvRGFR6RyzZC9rEw+NQuwWzAbGRJGb1yMJu5avSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1UkVyRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D205C43141;
	Fri,  2 Feb 2024 22:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911503;
	bh=uJ/e1019xzEMihf4k8j5WuA+3QD3U7RV6gdd3li3qcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N1UkVyRZVT+xs1znMXAH8igdQjaH4dM3DMOQzFvvNSh43UxWzXZ8EjhJj7sCsBOqs
	 5uvqxmlGbNEsJ1JfnpqNkkyrSPs/SOu45kO5N58geptJ6+C6kbnmunFAru9QyljVjr
	 y1WNgDP/g6IQsReh5ErMb8RaGOfQ+kczeBkSfbKwN5JP+9MsHEIBUljw2Z3+3jbL4F
	 dJuH+J5EcbcoGbsw0Nh3uFNGmcPGKdUTbTy7vorEdSRe2rq8E5iwFsClKz3130kXEW
	 +L+6L/WqaXt4Fhcj9JWGV7VN7rpjm3yyzR3FmDcKn/DIUehMEGE2kZhKmCtzdncV/g
	 HMqZtSdfnqgMA==
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
Subject: [PATCH 03/14] perf annotate-data: Introduce struct data_loc_info
Date: Fri,  2 Feb 2024 14:04:48 -0800
Message-ID: <20240202220459.527138-4-namhyung@kernel.org>
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

The find_data_type() needs many information to describe the location of
the data.  Add the new struct data_loc_info to pass those information at
once.

No functional changes intended.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 83 +++++++++++++++++----------------
 tools/perf/util/annotate-data.h | 38 ++++++++++++---
 tools/perf/util/annotate.c      | 30 ++++++------
 3 files changed, 91 insertions(+), 60 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 30c4d19fcf11..b8e60c42af8c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -239,21 +239,28 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 }
 
 /* The result will be saved in @type_die */
-static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
-			      const char *var_name, struct annotated_op_loc *loc,
-			      Dwarf_Die *type_die)
+static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
+	struct annotated_op_loc *loc = dloc->op;
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
 	int reg, offset;
 	int ret = -1;
 	int i, nr_scopes;
 	int fbreg = -1;
-	bool is_fbreg = false;
 	int fb_offset = 0;
+	bool is_fbreg = false;
+	u64 pc;
+
+	/*
+	 * IP is a relative instruction address from the start of the map, as
+	 * it can be randomized/relocated, it needs to translate to PC which is
+	 * a file address for DWARF processing.
+	 */
+	pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
 
 	/* Get a compile_unit for this address */
-	if (!find_cu_die(di, pc, &cu_die)) {
+	if (!find_cu_die(dloc->di, pc, &cu_die)) {
 		pr_debug("cannot find CU for address %" PRIx64 "\n", pc);
 		ann_data_stat.no_cuinfo++;
 		return -1;
@@ -263,18 +270,19 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	offset = loc->offset;
 
 	if (reg == DWARF_REG_PC) {
-		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+		if (die_find_variable_by_addr(&cu_die, pc, dloc->var_addr,
+					      &var_die, &offset)) {
 			ret = check_variable(&var_die, type_die, offset,
 					     /*is_pointer=*/false);
-			loc->offset = offset;
+			dloc->type_offset = offset;
 			goto out;
 		}
 
-		if (var_name && die_find_variable_at(&cu_die, var_name, pc,
-						     &var_die)) {
-			ret = check_variable(&var_die, type_die, 0,
+		if (dloc->var_name &&
+		    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
+			ret = check_variable(&var_die, type_die, dloc->type_offset,
 					     /*is_pointer=*/false);
-			/* loc->offset will be updated by the caller */
+			/* dloc->type_offset was updated by the caller */
 			goto out;
 		}
 	}
@@ -291,10 +299,11 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		    dwarf_formblock(&attr, &block) == 0 && block.length == 1) {
 			switch (*block.data) {
 			case DW_OP_reg0 ... DW_OP_reg31:
-				fbreg = *block.data - DW_OP_reg0;
+				fbreg = dloc->fbreg = *block.data - DW_OP_reg0;
 				break;
 			case DW_OP_call_frame_cfa:
-				if (die_get_cfa(di->dbg, pc, &fbreg,
+				dloc->fb_cfa = true;
+				if (die_get_cfa(dloc->di->dbg, pc, &fbreg,
 						&fb_offset) < 0)
 					fbreg = -1;
 				break;
@@ -312,7 +321,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		if (reg == DWARF_REG_PC) {
-			if (!die_find_variable_by_addr(&scopes[i], pc, addr,
+			if (!die_find_variable_by_addr(&scopes[i], pc, dloc->var_addr,
 						       &var_die, &offset))
 				continue;
 		} else {
@@ -325,7 +334,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC && !is_fbreg);
-		loc->offset = offset;
+		dloc->type_offset = offset;
 		goto out;
 	}
 
@@ -344,50 +353,46 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 
 /**
  * find_data_type - Return a data type at the location
- * @ms: map and symbol at the location
- * @ip: instruction address of the memory access
- * @loc: instruction operand location
- * @addr: data address of the memory access
- * @var_name: global variable name
+ * @dloc: data location
  *
  * This functions searches the debug information of the binary to get the data
- * type it accesses.  The exact location is expressed by (@ip, reg, offset)
- * for pointer variables or (@ip, @addr) for global variables.  Note that global
- * variables might update the @loc->offset after finding the start of the variable.
- * If it cannot find a global variable by address, it tried to fine a declaration
- * of the variable using @var_name.  In that case, @loc->offset won't be updated.
+ * type it accesses.  The exact location is expressed by (ip, reg, offset)
+ * for pointer variables or (ip, addr) for global variables.  Note that global
+ * variables might update the @dloc->type_offset after finding the start of the
+ * variable.  If it cannot find a global variable by address, it tried to find
+ * a declaration of the variable using var_name.  In that case, @dloc->offset
+ * won't be updated.
  *
  * It return %NULL if not found.
  */
-struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc, u64 addr,
-					   const char *var_name)
+struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 {
 	struct annotated_data_type *result = NULL;
-	struct dso *dso = map__dso(ms->map);
-	struct debuginfo *di;
+	struct dso *dso = map__dso(dloc->ms->map);
 	Dwarf_Die type_die;
-	u64 pc;
 
-	di = debuginfo__new(dso->long_name);
-	if (di == NULL) {
+	dloc->di = debuginfo__new(dso->long_name);
+	if (dloc->di == NULL) {
 		pr_debug("cannot get the debug info\n");
 		return NULL;
 	}
 
 	/*
-	 * IP is a relative instruction address from the start of the map, as
-	 * it can be randomized/relocated, it needs to translate to PC which is
-	 * a file address for DWARF processing.
+	 * The type offset is the same as instruction offset by default.
+	 * But when finding a global variable, the offset won't be valid.
 	 */
-	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
+	if (dloc->var_name == NULL)
+		dloc->type_offset = dloc->op->offset;
+
+	dloc->fbreg = -1;
+
+	if (find_data_type_die(dloc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
 
 out:
-	debuginfo__delete(di);
+	debuginfo__delete(dloc->di);
 	return result;
 }
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 1b0db8e8c40e..ad6493ea2c8e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 
 struct annotated_op_loc;
+struct debuginfo;
 struct evsel;
 struct map_symbol;
 
@@ -72,6 +73,35 @@ struct annotated_data_type {
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
 
+/**
+ * struct data_loc_info - Data location information
+ * @ms: Map and Symbol info
+ * @ip: Instruction address
+ * @var_addr: Data address (for global variables)
+ * @var_name: Variable name (for global variables)
+ * @op: Instruction operand location (regs and offset)
+ * @di: Debug info
+ * @fbreg: Frame base register
+ * @fb_cfa: Whether the frame needs to check CFA
+ * @type_offset: Final offset in the type
+ */
+struct data_loc_info {
+	/* These are input field, should be filled by caller */
+	struct map_symbol *ms;
+	u64 ip;
+	u64 var_addr;
+	const char *var_name;
+	struct annotated_op_loc *op;
+
+	/* These are used internally */
+	struct debuginfo *di;
+	int fbreg;
+	bool fb_cfa;
+
+	/* This is for the result */
+	int type_offset;
+};
+
 /**
  * struct annotated_data_stat - Debug statistics
  * @total: Total number of entry
@@ -106,9 +136,7 @@ extern struct annotated_data_stat ann_data_stat;
 #ifdef HAVE_DWARF_SUPPORT
 
 /* Returns data type at the location (ip, reg, offset) */
-struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc, u64 addr,
-					   const char *var_name);
+struct annotated_data_type *find_data_type(struct data_loc_info *dloc);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -121,9 +149,7 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
-find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       struct annotated_op_loc *loc __maybe_unused,
-	       u64 addr __maybe_unused, const char *var_name __maybe_unused)
+find_data_type(struct data_loc_info *dloc __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 107b264fa41e..cb5d4c517a4d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3788,9 +3788,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
-	u64 ip = he->ip, addr = 0;
-	const char *var_name = NULL;
-	int var_offset;
+	u64 ip = he->ip;
 	int i;
 
 	ann_data_stat.total++;
@@ -3843,51 +3841,53 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	}
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
+		struct data_loc_info dloc = {
+			.ms = ms,
+			/* Recalculate IP for LOCK prefix or insn fusion */
+			.ip = ms->sym->start + dl->al.offset,
+			.op = op_loc,
+		};
+
 		if (!op_loc->mem_ref)
 			continue;
 
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		var_offset = op_loc->offset;
-
 		/* PC-relative addressing */
 		if (op_loc->reg1 == DWARF_REG_PC) {
 			struct addr_location al;
 			struct symbol *var;
 			u64 map_addr;
 
-			addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
+			dloc.var_addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
 			/* Kernel symbols might be relocated */
-			map_addr = addr + map__reloc(ms->map);
+			map_addr = dloc.var_addr + map__reloc(ms->map);
 
 			addr_location__init(&al);
 			var = thread__find_symbol_fb(he->thread, he->cpumode,
 						     map_addr, &al);
 			if (var) {
-				var_name = var->name;
+				dloc.var_name = var->name;
 				/* Calculate type offset from the start of variable */
-				var_offset = map_addr - map__unmap_ip(al.map, var->start);
+				dloc.type_offset = map_addr - map__unmap_ip(al.map, var->start);
 			}
 			addr_location__exit(&al);
 		}
 
-		mem_type = find_data_type(ms, ip, op_loc, addr, var_name);
+		mem_type = find_data_type(&dloc);
 		if (mem_type)
 			istat->good++;
 		else
 			istat->bad++;
 
-		if (mem_type && var_name)
-			op_loc->offset = var_offset;
-
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
-							    op_loc->offset,
+							    dloc.type_offset,
 							    he->stat.nr_events,
 							    he->stat.period);
 		}
-		he->mem_type_off = op_loc->offset;
+		he->mem_type_off = dloc.type_offset;
 		return mem_type;
 	}
 
-- 
2.43.0.594.gd9cf4e227d-goog


