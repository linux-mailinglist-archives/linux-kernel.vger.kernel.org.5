Return-Path: <linux-kernel+bounces-28564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2BF83001E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E451C23543
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C6D1401A;
	Wed, 17 Jan 2024 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QqWLuu+3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A696D12B94;
	Wed, 17 Jan 2024 06:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472823; cv=none; b=a0H7kwjx9bW1ARFeCWgc5HTAwFvcI3HO5NSXup9LOOgHTrXJQJPiEvxtsgzfQ+gHDD898rq5B6cOllafWYVfk54i8CwJ4zwbISQ3MDBtV9QqTwVKJAAztLuhqkAdrhhYAuqmQC7K+ArwOgkjtpLyEfedRKB80tVWYDE6dFZhBjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472823; c=relaxed/simple;
	bh=nNnrg0nrI4/YyB/Uu8EizF5eOdVRbdg2sptuGKf71TA=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=ncPQr2IVC9F9VM2zgl2eluC0swFbJck2TRplYoFr+ahiMccnFKlWUAfKJfEoq73uRUYmTsvN1AVd/o83NcbRfzrZPU8omXy2qIs/VrzbwFrJViRI8X79xMwmaBfkr4GFJOoHxyM+HzKwMAHjGb6mU9QQwT4W2yUAr6UJZ1h3v+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QqWLuu+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE1AC4167D;
	Wed, 17 Jan 2024 06:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472823;
	bh=nNnrg0nrI4/YyB/Uu8EizF5eOdVRbdg2sptuGKf71TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QqWLuu+3DWtSiM5QAfFa13oO0ifVAhqWBxVht20VHGH78MNGCdegzThRr+uOOcWUD
	 ZC+eB2yjD9huNh+zcTRBhRal76ZCRnWgKmNKPy9dtDlqL5CB1UCc1Q5vc4zbzPtFnJ
	 jdaFnYpIGK0EQb+X2M0wiP6qj9mQvoGrLkahw+3g0BYuj8N54amBnAGx9gYdKNCV9I
	 kFpsOJnH0YnR6VVcBbP4fcLeEVEEee/3GCK9wEKlg4jRMgSun51vrCSHwz+g0Q4IjJ
	 iW4/tdj2iQ/ll7bYJapXvjGUqk2S0bXXuLynA9OdSDvWvJxS0sbLgVX0vCEVReKcF9
	 btDNM0tdjadCg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
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
Subject: [PATCH 6/9] perf annotate-data: Support global variables
Date: Tue, 16 Jan 2024 22:26:54 -0800
Message-ID: <20240117062657.985479-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Global variables are accessed using PC-relative address so it needs to
be handled separately.  The PC-rel addressing is detected by using
DWARF_REG_PC.  On x86, %rip register would be used.

The address can be calculated using the ip and offset in the
instruction.  But it should start from the next instruction so add
calculate_pcrel_addr() to do it properly.

But global variables defined in a different file would only have a
declaration which doesn't include a location list.  So it first tries
to get the type info using the address, and then looks up the variable
declarations using name.  The name of global variables should be get
from the symbol table.  The declaration would have the type info.

So extend find_var_type() to take both address and name for global
variables.

The stat is now looks like:

  Annotate data type stats:
  total 294, ok 153 (52.0%), bad 141 (48.0%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          61 : no_var
          10 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 38 ++++++++++++++++------
 tools/perf/util/annotate-data.h |  6 ++--
 tools/perf/util/annotate.c      | 57 +++++++++++++++++++++++++++++++--
 tools/perf/util/annotate.h      |  4 +++
 4 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 58c0fac42e9d..e375dd288f67 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -240,7 +240,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
-			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
+			      const char *var_name, struct annotated_op_loc *loc,
+			      Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
@@ -258,11 +259,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 	reg = loc->reg1;
 	offset = loc->offset;
 
-	if (reg == DWARF_REG_PC &&
-	    die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
-		ret = check_variable(&var_die, type_die, offset,
-				     /*is_pointer=*/false);
-		goto out;
+	if (reg == DWARF_REG_PC) {
+		if (die_find_variable_by_addr(&cu_die, pc, addr, &var_die, &offset)) {
+			ret = check_variable(&var_die, type_die, offset,
+					     /*is_pointer=*/false);
+			loc->offset = offset;
+			goto out;
+		}
+
+		if (var_name && die_find_variable_at(&cu_die, var_name, pc,
+						     &var_die)) {
+			ret = check_variable(&var_die, type_die, 0,
+					     /*is_pointer=*/false);
+			/* loc->offset will be updated by the caller */
+			goto out;
+		}
 	}
 
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
@@ -285,6 +296,7 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC);
+		loc->offset = offset;
 		goto out;
 	}
 
@@ -306,13 +318,21 @@ static int find_data_type_die(struct debuginfo *di, u64 pc, u64 addr,
  * @ms: map and symbol at the location
  * @ip: instruction address of the memory access
  * @loc: instruction operand location
+ * @addr: data address of the memory access
+ * @var_name: global variable name
  *
  * This functions searches the debug information of the binary to get the data
- * type it accesses.  The exact location is expressed by (ip, reg, offset).
+ * type it accesses.  The exact location is expressed by (@ip, reg, offset)
+ * for pointer variables or (@ip, @addr) for global variables.  Note that global
+ * variables might update the @loc->offset after finding the start of the variable.
+ * If it cannot find a global variable by address, it tried to fine a declaration
+ * of the variable using @var_name.  In that case, @loc->offset won't be updated.
+ *
  * It return %NULL if not found.
  */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc)
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name)
 {
 	struct annotated_data_type *result = NULL;
 	struct dso *dso = map__dso(ms->map);
@@ -332,7 +352,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, 0, loc, &type_die) < 0)
+	if (find_data_type_die(di, pc, addr, var_name, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 214c625e7bc9..1b0db8e8c40e 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -107,7 +107,8 @@ extern struct annotated_data_stat ann_data_stat;
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   struct annotated_op_loc *loc);
+					   struct annotated_op_loc *loc, u64 addr,
+					   const char *var_name);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -121,7 +122,8 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 
 static inline struct annotated_data_type *
 find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       struct annotated_op_loc *loc __maybe_unused)
+	       struct annotated_op_loc *loc __maybe_unused,
+	       u64 addr __maybe_unused, const char *var_name __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 655bd9443f5e..107b264fa41e 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -37,6 +37,7 @@
 #include "util/sharded_mutex.h"
 #include "arch/common.h"
 #include "namespaces.h"
+#include "thread.h"
 #include <regex.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
@@ -3744,6 +3745,30 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl)
+{
+	struct annotation *notes;
+	struct disasm_line *next;
+	u64 addr;
+
+	notes = symbol__annotation(ms->sym);
+	/*
+	 * PC-relative addressing starts from the next instruction address
+	 * But the IP is for the current instruction.  Since disasm_line
+	 * doesn't have the instruction size, calculate it using the next
+	 * disasm_line.  If it's the last one, we can use symbol's end
+	 * address directly.
+	 */
+	if (&dl->al.node == notes->src->source.prev)
+		addr = ms->sym->end + offset;
+	else {
+		next = list_next_entry(dl, al.node);
+		addr = ip + (next->al.offset - dl->al.offset) + offset;
+	}
+	return map__rip_2objdump(ms->map, addr);
+}
+
 /**
  * hist_entry__get_data_type - find data type for given hist entry
  * @he: hist entry
@@ -3763,7 +3788,9 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	struct annotated_op_loc *op_loc;
 	struct annotated_data_type *mem_type;
 	struct annotated_item_stat *istat;
-	u64 ip = he->ip;
+	u64 ip = he->ip, addr = 0;
+	const char *var_name = NULL;
+	int var_offset;
 	int i;
 
 	ann_data_stat.total++;
@@ -3822,12 +3849,38 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc);
+		var_offset = op_loc->offset;
+
+		/* PC-relative addressing */
+		if (op_loc->reg1 == DWARF_REG_PC) {
+			struct addr_location al;
+			struct symbol *var;
+			u64 map_addr;
+
+			addr = annotate_calc_pcrel(ms, ip, op_loc->offset, dl);
+			/* Kernel symbols might be relocated */
+			map_addr = addr + map__reloc(ms->map);
+
+			addr_location__init(&al);
+			var = thread__find_symbol_fb(he->thread, he->cpumode,
+						     map_addr, &al);
+			if (var) {
+				var_name = var->name;
+				/* Calculate type offset from the start of variable */
+				var_offset = map_addr - map__unmap_ip(al.map, var->start);
+			}
+			addr_location__exit(&al);
+		}
+
+		mem_type = find_data_type(ms, ip, op_loc, addr, var_name);
 		if (mem_type)
 			istat->good++;
 		else
 			istat->bad++;
 
+		if (mem_type && var_name)
+			op_loc->offset = var_offset;
+
 		if (symbol_conf.annotate_data_sample) {
 			annotated_data_type__update_samples(mem_type, evsel,
 							    op_loc->offset,
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index d0ff677b460c..94435607c958 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -491,4 +491,8 @@ struct annotated_item_stat {
 };
 extern struct list_head ann_insn_stat;
 
+/* Calculate PC-relative address */
+u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
+			struct disasm_line *dl);
+
 #endif	/* __PERF_ANNOTATE_H */
-- 
2.43.0.381.gb435a96ce8-goog


