Return-Path: <linux-kernel+bounces-28561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB5D83001B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:27:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 629862880F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80DE1173D;
	Wed, 17 Jan 2024 06:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rIaqOFJP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9066DBE76;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472821; cv=none; b=DpNFCk9wO01s5nLolD5DpHndyFjmGPUQ/zbUGfNjgeMVC2LqzJu6Q/ETfWWrhZE7iBQwVgkoSh/GHt/IqzDTHtFo06BeOMlGWOCMeepaNzqSx9DRGpFn4/fFDK5udWPiga4Wi4fxv+8Ax4EDs7NiAkoIjsPWAiK+R6vLuW5/YsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472821; c=relaxed/simple;
	bh=pukFXDOVvA1Ds/BWrknHc8KZ239c9zVHca14GIGWrH4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=tFe/N7j1/CAKC14UxyNK3l9c9uYRH7C71+sYSJIHFPdzf9jOyFWCpAzhDNPd1oCEwe1c2IGL/hbdJ7TlmxMkI17lIso+2EMYtYdyXIVwyP0IvVUM3DVWC5m13DcJ8fgGwXXMO7cGtji25cAw4zgnz6N5D3fmgzyBkZGnuDWS7KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rIaqOFJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBEDC43143;
	Wed, 17 Jan 2024 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472821;
	bh=pukFXDOVvA1Ds/BWrknHc8KZ239c9zVHca14GIGWrH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rIaqOFJPCsIJB/lPipxaHOVrmZ6Cr/DZB7AZ4zsIc32gfCAPU9l0gPoxf/J0fNi8d
	 dz8YgAasNnDlgElVFri3AtJA+vmVnvTCwnzZ0cNalFD0efa60kDBnuEctArSMHRMxq
	 +NZiPyt6vAhWcmwyB5dizYsontyiRvKwnR48diMgD48NUF98IwFRSiYc2Za6qOjy7K
	 RrNkwMA/2loOJZD7NbFXo+GYHclP6LsRREXT0AhnPSBHQuY1bheo3ph3PjxzUKLwye
	 QS8Kcp4p4aBWPNoNrVMjE8W1acdVRz9+mCvf3m5yKI+GD8te6cFnuLlUhjZ5mdRT6S
	 MH9Rctep3Rx4g==
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
Subject: [PATCH 3/9] perf annotate-data: Handle array style accesses
Date: Tue, 16 Jan 2024 22:26:51 -0800
Message-ID: <20240117062657.985479-4-namhyung@kernel.org>
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

On x86, instructions for array access often looks like below.

  mov  0x1234(%rax,%rbx,8), %rcx

Usually the first register holds the type information and the second one
has the index.  And the current code only looks up a variable for the
first register.  But it's possible to be in the other way around so it
needs to check the second register if the first one failed.

The stat changed like this.

  Annotate data type stats:
  total 294, ok 148 (50.3%), bad 146 (49.7%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          66 : no_var
          10 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 24 +++++++++++++-----
 tools/perf/util/annotate-data.h |  5 ++--
 tools/perf/util/annotate.c      | 43 ++++++++++++++++++++++++++-------
 tools/perf/util/annotate.h      |  8 ++++--
 4 files changed, 61 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f22b4f18271c..d1ceac7e2441 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include <inttypes.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "debuginfo.h"
 #include "debug.h"
@@ -207,7 +208,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	 * It expects a pointer type for a memory access.
 	 * Convert to a real type it points to.
 	 */
-	if (dwarf_tag(type_die) != DW_TAG_pointer_type ||
+	if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
+	     dwarf_tag(type_die) != DW_TAG_array_type) ||
 	    die_get_real_type(type_die, type_die) == NULL) {
 		pr_debug("no pointer or no type\n");
 		ann_data_stat.no_typeinfo++;
@@ -233,10 +235,11 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct debuginfo *di, u64 pc,
-			      int reg, int offset, Dwarf_Die *type_die)
+			      struct annotated_op_loc *loc, Dwarf_Die *type_die)
 {
 	Dwarf_Die cu_die, var_die;
 	Dwarf_Die *scopes = NULL;
+	int reg, offset;
 	int ret = -1;
 	int i, nr_scopes;
 
@@ -250,6 +253,10 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
 	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
 
+	reg = loc->reg1;
+	offset = loc->offset;
+
+retry:
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		/* Look up variables/parameters in this scope */
@@ -260,6 +267,12 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 		ret = check_variable(&var_die, type_die, offset);
 		goto out;
 	}
+
+	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
+		reg = loc->reg2;
+		goto retry;
+	}
+
 	if (ret < 0)
 		ann_data_stat.no_var++;
 
@@ -272,15 +285,14 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
  * find_data_type - Return a data type at the location
  * @ms: map and symbol at the location
  * @ip: instruction address of the memory access
- * @reg: register that holds the base address
- * @offset: offset from the base address
+ * @loc: instruction operand location
  *
  * This functions searches the debug information of the binary to get the data
  * type it accesses.  The exact location is expressed by (ip, reg, offset).
  * It return %NULL if not found.
  */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   int reg, int offset)
+					   struct annotated_op_loc *loc)
 {
 	struct annotated_data_type *result = NULL;
 	struct dso *dso = map__dso(ms->map);
@@ -300,7 +312,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
 	 * a file address for DWARF processing.
 	 */
 	pc = map__rip_2objdump(ms->map, ip);
-	if (find_data_type_die(di, pc, reg, offset, &type_die) < 0)
+	if (find_data_type_die(di, pc, loc, &type_die) < 0)
 		goto out;
 
 	result = dso__findnew_data_type(dso, &type_die);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 8e73096c01d1..65ddd839850f 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -7,6 +7,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 
+struct annotated_op_loc;
 struct evsel;
 struct map_symbol;
 
@@ -105,7 +106,7 @@ extern struct annotated_data_stat ann_data_stat;
 
 /* Returns data type at the location (ip, reg, offset) */
 struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
-					   int reg, int offset);
+					   struct annotated_op_loc *loc);
 
 /* Update type access histogram at the given offset */
 int annotated_data_type__update_samples(struct annotated_data_type *adt,
@@ -119,7 +120,7 @@ void annotated_data_type__tree_delete(struct rb_root *root);
 
 static inline struct annotated_data_type *
 find_data_type(struct map_symbol *ms __maybe_unused, u64 ip __maybe_unused,
-	       int reg __maybe_unused, int offset __maybe_unused)
+	       struct annotated_op_loc *loc __maybe_unused)
 {
 	return NULL;
 }
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0ec42e85ca5c..3cdcdd449c86 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3563,8 +3563,22 @@ static int extract_reg_offset(struct arch *arch, const char *str,
 	if (regname == NULL)
 		return -1;
 
-	op_loc->reg = get_dwarf_regnum(regname, 0);
+	op_loc->reg1 = get_dwarf_regnum(regname, 0);
 	free(regname);
+
+	/* Get the second register */
+	if (op_loc->multi_regs) {
+		p = strchr(p + 1, arch->objdump.register_char);
+		if (p == NULL)
+			return -1;
+
+		regname = strdup(p);
+		if (regname == NULL)
+			return -1;
+
+		op_loc->reg2 = get_dwarf_regnum(regname, 0);
+		free(regname);
+	}
 	return 0;
 }
 
@@ -3577,14 +3591,20 @@ static int extract_reg_offset(struct arch *arch, const char *str,
  * Get detailed location info (register and offset) in the instruction.
  * It needs both source and target operand and whether it accesses a
  * memory location.  The offset field is meaningful only when the
- * corresponding mem flag is set.
+ * corresponding mem flag is set.  The reg2 field is meaningful only
+ * when multi_regs flag is set.
  *
  * Some examples on x86:
  *
- *   mov  (%rax), %rcx   # src_reg = rax, src_mem = 1, src_offset = 0
- *                       # dst_reg = rcx, dst_mem = 0
+ *   mov  (%rax), %rcx   # src_reg1 = rax, src_mem = 1, src_offset = 0
+ *                       # dst_reg1 = rcx, dst_mem = 0
  *
- *   mov  0x18, %r8      # src_reg = -1, dst_reg = r8
+ *   mov  0x18, %r8      # src_reg1 = -1, src_mem = 0
+ *                       # dst_reg1 = r8, dst_mem = 0
+ *
+ *   mov  %rsi, 8(%rbx,%rcx,4)  # src_reg1 = rsi, src_mem = 0, dst_multi_regs = 0
+ *                              # dst_reg1 = rbx, dst_reg2 = rcx, dst_mem = 1
+ *                              # dst_multi_regs = 1, dst_offset = 8
  */
 int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 			       struct annotated_insn_loc *loc)
@@ -3605,24 +3625,29 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
 	for_each_insn_op_loc(loc, i, op_loc) {
 		const char *insn_str = ops->source.raw;
+		bool multi_regs = ops->source.multi_regs;
 
-		if (i == INSN_OP_TARGET)
+		if (i == INSN_OP_TARGET) {
 			insn_str = ops->target.raw;
+			multi_regs = ops->target.multi_regs;
+		}
 
 		/* Invalidate the register by default */
-		op_loc->reg = -1;
+		op_loc->reg1 = -1;
+		op_loc->reg2 = -1;
 
 		if (insn_str == NULL)
 			continue;
 
 		if (strchr(insn_str, arch->objdump.memory_ref_char)) {
 			op_loc->mem_ref = true;
+			op_loc->multi_regs = multi_regs;
 			extract_reg_offset(arch, insn_str, op_loc);
 		} else {
 			char *s = strdup(insn_str);
 
 			if (s) {
-				op_loc->reg = get_dwarf_regnum(s, 0);
+				op_loc->reg1 = get_dwarf_regnum(s, 0);
 				free(s);
 			}
 		}
@@ -3771,7 +3796,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		mem_type = find_data_type(ms, ip, op_loc);
 		if (mem_type)
 			istat->good++;
 		else
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index dba50762c6e8..d0ff677b460c 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -442,14 +442,18 @@ int annotate_check_args(void);
 
 /**
  * struct annotated_op_loc - Location info of instruction operand
- * @reg: Register in the operand
+ * @reg1: First register in the operand
+ * @reg2: Second register in the operand
  * @offset: Memory access offset in the operand
  * @mem_ref: Whether the operand accesses memory
+ * @multi_regs: Whether the second register is used
  */
 struct annotated_op_loc {
-	int reg;
+	int reg1;
+	int reg2;
 	int offset;
 	bool mem_ref;
+	bool multi_regs;
 };
 
 enum annotated_insn_ops {
-- 
2.43.0.381.gb435a96ce8-goog


