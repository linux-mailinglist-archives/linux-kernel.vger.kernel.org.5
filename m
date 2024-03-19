Return-Path: <linux-kernel+bounces-107037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FEA87F6EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F41A1C20DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DB137EEED;
	Tue, 19 Mar 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohu+3VVm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540717E763;
	Tue, 19 Mar 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827484; cv=none; b=Sr9vPcXJINBS53FHOk8vVgWfQZLNlK1cHXmKXTiRApgfGWMdXayPR2ZqK9B/ft8cCS8Ml+QB+QivGuK17lGGTe6ufskEM3u4gqazeDYSlUEZf9I6bpZ4L5el0rZSkGTXq2snU/embiflMuq047+W58y/l746NEBqBqQOjXnK/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827484; c=relaxed/simple;
	bh=Mu8hDHjCGFj2JC2y9XQ5SBu3a6veNJkuzAWS61C+LNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/DFTRRhnT9dvOeTk0CXLmvFffhhxcfNiMXzYli2//M2TggbJqHTAndsYUHaOLF8ZwtG1zhaxiMJpP8tsM28y0LxHDeWkwUSjnVfNRrRe2VAJ4cc9HRSqy7JOH5qPX3v2yZg/DoOSWR10Nui6ykUvo0aiXEC2Bo/BTACVGQCPK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ohu+3VVm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC975C433B1;
	Tue, 19 Mar 2024 05:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827484;
	bh=Mu8hDHjCGFj2JC2y9XQ5SBu3a6veNJkuzAWS61C+LNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ohu+3VVmsGfHRmpbF8wbfqzG2OIrK0Lwq7S2VoC8NWsZL2m5UIu6+VilnG6I9csCz
	 aWBgBGOXX9GVqi2IIzYznP70xET8Cmsgve0LiEbBT6z1hmiNKG3MX5kl997azklkQN
	 W9JrCqHQBOXp205AkKV18BmDMrQih9Flm9j4B41IO5ZjCxOtlRBffBmHsuuTQt0ZJz
	 SVgHLa1BJYTE8kykNPkI/VP/JGof4mDL6F/ZU8MXsmNrRVrodNRAPJrC1t724mQmd0
	 BT0MVrKEVK2gebg5aR3wXgw279TBDWiWx7a5ebCLpcSZ9CRPkGq/owBIOVUzAXkOrd
	 6jcuUAuZ3Ugmg==
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
Subject: [PATCH 11/23] perf annotate-data: Add get_global_var_type()
Date: Mon, 18 Mar 2024 22:51:03 -0700
Message-ID: <20240319055115.4063940-12-namhyung@kernel.org>
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

Accessing global variable is common when it tracks execution later.
Factor out the common code into a function for later use.

It adds thread and cpumode to struct data_loc_info to find (global)
symbols if needed.  Also remove var_name as it's retrieved in the
helper function.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 62 +++++++++++++++++++++++++--------
 tools/perf/util/annotate-data.h |  7 ++--
 tools/perf/util/annotate.c      | 21 +++--------
 3 files changed, 57 insertions(+), 33 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 592437b6c097..3b661e693410 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -22,6 +22,7 @@
 #include "strbuf.h"
 #include "symbol.h"
 #include "symbol_conf.h"
+#include "thread.h"
 
 #define pr_debug_dtp(fmt, ...)					\
 do {								\
@@ -382,6 +383,50 @@ static struct type_state_stack *findnew_stack_state(struct type_state *state,
 	return stack;
 }
 
+static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
+				u64 ip, u64 var_addr, int *var_offset,
+				Dwarf_Die *type_die)
+{
+	u64 pc, mem_addr;
+	int offset;
+	bool is_pointer = false;
+	const char *var_name = NULL;
+	Dwarf_Die var_die;
+	struct addr_location al;
+	struct symbol *sym;
+
+	/* Try to get the variable by address first */
+	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset) &&
+	    check_variable(&var_die, type_die, offset, is_pointer) == 0) {
+		*var_offset = offset;
+		return true;
+	}
+
+	/* Kernel symbols might be relocated */
+	mem_addr = var_addr + map__reloc(dloc->ms->map);
+
+	addr_location__init(&al);
+	sym = thread__find_symbol_fb(dloc->thread, dloc->cpumode,
+				     mem_addr, &al);
+	if (sym) {
+		var_name = sym->name;
+		/* Calculate type offset from the start of variable */
+		*var_offset = mem_addr - map__unmap_ip(al.map, sym->start);
+	}
+	addr_location__exit(&al);
+	if (var_name == NULL)
+		return false;
+
+	pc = map__rip_2objdump(dloc->ms->map, ip);
+
+	/* Try to get the name of global variable */
+	if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
+	    check_variable(&var_die, type_die, *var_offset, is_pointer) == 0)
+		return true;
+
+	return false;
+}
+
 /**
  * update_var_state - Update type state using given variables
  * @state: type state table
@@ -637,24 +682,14 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	pr_debug_dtp("CU die offset: %#lx\n", (long)dwarf_dieoffset(&cu_die));
 
 	if (reg == DWARF_REG_PC) {
-		if (die_find_variable_by_addr(&cu_die, dloc->var_addr, &var_die,
-					      &offset)) {
-			ret = check_variable(&var_die, type_die, offset,
-					     /*is_pointer=*/false);
+		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
+					&offset, type_die)) {
 			dloc->type_offset = offset;
 
 			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x\n",
 				     dloc->var_addr, offset);
 			goto out;
 		}
-
-		if (dloc->var_name &&
-		    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
-			ret = check_variable(&var_die, type_die, dloc->type_offset,
-					     /*is_pointer=*/false);
-			/* dloc->type_offset was updated by the caller */
-			goto out;
-		}
 	}
 
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
@@ -769,8 +804,7 @@ struct annotated_data_type *find_data_type(struct data_loc_info *dloc)
 	 * The type offset is the same as instruction offset by default.
 	 * But when finding a global variable, the offset won't be valid.
 	 */
-	if (dloc->var_name == NULL)
-		dloc->type_offset = dloc->op->offset;
+	dloc->type_offset = dloc->op->offset;
 
 	dloc->fbreg = -1;
 
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 7324cafe2c7b..acfbd1748d02 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -11,6 +11,7 @@ struct annotated_op_loc;
 struct debuginfo;
 struct evsel;
 struct map_symbol;
+struct thread;
 
 /**
  * struct annotated_member - Type of member field
@@ -76,10 +77,11 @@ extern struct annotated_data_type stackop_type;
 /**
  * struct data_loc_info - Data location information
  * @arch: CPU architecture info
+ * @thread: Thread info
  * @ms: Map and Symbol info
  * @ip: Instruction address
  * @var_addr: Data address (for global variables)
- * @var_name: Variable name (for global variables)
+ * @cpumode: CPU execution mode
  * @op: Instruction operand location (regs and offset)
  * @di: Debug info
  * @fbreg: Frame base register
@@ -89,10 +91,11 @@ extern struct annotated_data_type stackop_type;
 struct data_loc_info {
 	/* These are input field, should be filled by caller */
 	struct arch *arch;
+	struct thread *thread;
 	struct map_symbol *ms;
 	u64 ip;
 	u64 var_addr;
-	const char *var_name;
+	u8 cpumode;
 	struct annotated_op_loc *op;
 
 	/* These are used internally */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9777df5dc2e3..abb641aa8ec0 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3873,9 +3873,11 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
+			.thread = he->thread,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
+			.cpumode = he->cpumode,
 			.op = op_loc,
 		};
 
@@ -3887,23 +3889,8 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
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
+			dloc.var_addr = annotate_calc_pcrel(ms, dloc.ip,
+							    op_loc->offset, dl);
 		}
 
 		mem_type = find_data_type(&dloc);
-- 
2.44.0.291.gc1ea87d7ee-goog


