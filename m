Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AEC7E7586
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345701AbjKJACw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345571AbjKJAB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:01:59 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2451C4EC7;
        Thu,  9 Nov 2023 16:01:02 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28041176e77so1264761a91.0;
        Thu, 09 Nov 2023 16:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574461; x=1700179261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuNYbGY/TZYhNEl+3fPnXMSkLeW2sk5VhkJK2QzHpkM=;
        b=hzH6EjlVoC0nARk2tfjCo+O2gyxvT2ut7muxDJ9E54A9xcmhMa44mfkvAbEeZf9a6n
         yFZWC1AeIAfgn7nui+7sEUoexX2G306Lc2h40l9b2IbhCNYxHyLs5Tpri4Tfjc/wwfv0
         N5g14yb5Oj1+OipF8wJlHzG5Oi6+EVp77zsZfquWhsWPWvHbg2vvAZpVuPcXfqexObtZ
         2Y+f9gPHunYbBem68JCDVGfXh5p0f2bjxGxsTxKizrB67ApskGXQU0TPZp5Yf0aAadhN
         i17b7OpfYh1RQ6ZwOHKAob5lN+w9gyB+2AQWYHRieNXAGZAoWGLbArGpPpwNvLfkD94V
         2XBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574461; x=1700179261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YuNYbGY/TZYhNEl+3fPnXMSkLeW2sk5VhkJK2QzHpkM=;
        b=kxh9ViG+AzJUaWgd0e6L6mSSeY+LfA+CS/Yq+D/VJym43nyz4oV4U9JPeVsOOBgIqQ
         X3MPEiEvBF4EDoYl19QTGL1A4x8elxGJh+BeW1p2oBSNLtDneBn/HsgIaDIymz06bzCc
         J0XB2BUlqsoSc9c9fXCGk+nQdDsYnnNduTDChaQ8wwJQoMeFKJYJbHy1Ki0Mv0W4x4Z+
         83MmFIkMDfFMKB/rFf/kBrgATAQuQY0H5ABEeT+gp+JJMqQ3cqudmdbee9YkIPkcYyKB
         /qBiGfQ+YaPKAoE3IIfqrDJJ+VOS0ptLnzvmHz9Wc3BvFTNrCdK3wFJhp+IqPcK7cJhv
         gBiQ==
X-Gm-Message-State: AOJu0Yy6ZQJrDtnqgXm5WQW7Yyt4KFeYDsXwo13ZXBB8E/GtiTlEuVI0
        XgQdkRxVdKHUZiQynh1TPXs=
X-Google-Smtp-Source: AGHT+IHDsKq1HdvnM0iIpag/xmlhWcwJIvdyEuXoKH27k00GyWB0ZyF6HDeG1jjfbUx5hE7qOfm9dg==
X-Received: by 2002:a17:90a:5d86:b0:281:3a4a:2e61 with SMTP id t6-20020a17090a5d8600b002813a4a2e61mr3049790pji.14.1699574461515;
        Thu, 09 Nov 2023 16:01:01 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.00.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:00 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        linux-trace-devel@vger.kernel.org, linux-toolchains@vger.kernel.org
Subject: [PATCH 30/52] perf annotate-data: Handle array style accesses
Date:   Thu,  9 Nov 2023 15:59:49 -0800
Message-ID: <20231110000012.3538610-31-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 79f09ce92f15..159fceeebaa4 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -8,6 +8,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 
+#include "annotate.h"
 #include "annotate-data.h"
 #include "debuginfo.h"
 #include "debug.h"
@@ -206,7 +207,8 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 	 * It expects a pointer type for a memory access.
 	 * Convert to a real type it points to.
 	 */
-	if (dwarf_tag(type_die) != DW_TAG_pointer_type ||
+	if ((dwarf_tag(type_die) != DW_TAG_pointer_type &&
+	     dwarf_tag(type_die) != DW_TAG_array_type) ||
 	    die_get_real_type(type_die, type_die) == NULL) {
 		pr_debug("no pointer or no type\n");
 		ann_data_stat.no_typeinfo++;
@@ -232,10 +234,11 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset)
 
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
 
@@ -249,6 +252,10 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
 	/* Get a list of nested scopes - i.e. (inlined) functions and blocks. */
 	nr_scopes = die_get_scopes(&cu_die, pc, &scopes);
 
+	reg = loc->reg1;
+	offset = loc->offset;
+
+retry:
 	/* Search from the inner-most scope to the outer */
 	for (i = nr_scopes - 1; i >= 0; i--) {
 		/* Look up variables/parameters in this scope */
@@ -259,6 +266,12 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
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
 
@@ -271,15 +284,14 @@ static int find_data_type_die(struct debuginfo *di, u64 pc,
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
 	struct dso *dso = ms->map->dso;
@@ -299,7 +311,7 @@ struct annotated_data_type *find_data_type(struct map_symbol *ms, u64 ip,
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
index 7d733bc85c9a..19e7f4000368 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3567,8 +3567,22 @@ static int extract_reg_offset(struct arch *arch, const char *str,
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
 
@@ -3581,14 +3595,20 @@ static int extract_reg_offset(struct arch *arch, const char *str,
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
@@ -3609,24 +3629,29 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 
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
@@ -3770,7 +3795,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
-		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
+		mem_type = find_data_type(ms, ip, op_loc);
 		if (mem_type)
 			istat->good++;
 		else
diff --git a/tools/perf/util/annotate.h b/tools/perf/util/annotate.h
index 2cef96859e45..f5a6c3227757 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -448,14 +448,18 @@ int annotate_check_args(struct annotation_options *args);
 
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
2.42.0.869.gea05f2083d-goog

