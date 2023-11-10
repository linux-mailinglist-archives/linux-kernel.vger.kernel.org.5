Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6380D7E7597
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345590AbjKJAER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345766AbjKJADa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:30 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFF159D2;
        Thu,  9 Nov 2023 16:01:26 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1199650a12.2;
        Thu, 09 Nov 2023 16:01:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574486; x=1700179286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pf63LKSCgXyhHnD+XwDAgtgdupMVZihRN7VkTjYL3UY=;
        b=HTA3VSxyLnuHEB9eolK8U+kksewBMlnYL0GHB7nVpnfAlSihELpGwjm7zD1KqBIfSV
         t4/i8G76KZjHjRkdTM7RyUFoSnsBeWplBYwcGNVAKltmppwJeH7zZeqPgnrGIfsnYVKM
         4lsOnxs8vOjgiQF+BqtfCdbCzFLURcs3EzipPpQ8ejr4FtYDcM8i8KdFJjpC0hDSvBuD
         xwGDOInqYBkr63hZtiJQlCYynr5inoTyHI8LuRSy+XhSh9DIbn5xCmUt3xk/LrCOLBKe
         lgfUNTwVAe0gCMBadQu21mfxPtKDEHTCdObFtMjHzpvSOgGQM1Hb+b161OuS1yjfBkZO
         oaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574486; x=1700179286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pf63LKSCgXyhHnD+XwDAgtgdupMVZihRN7VkTjYL3UY=;
        b=Icgkp7Poin+lZCLXQ1hRIc+VUskzVi9YuwuX0hDEND9EX0LpTvhIgSGS2PCAr3cb+L
         /2H8yJwKDXkDndwmmXd9Pc3R3Qt8feNEJuHa8py9Qmut0VyCjqoxj4zbMv4pqGzBvhEj
         BlIuYkGfPVbWj60psyt395o2kcdgxEm7BNl332ZW+dHdbjLnqGMrDc4oW+8Q7Ct3vkRq
         UBMskEB/LQkonEVRrXv2BsS6CHw8dBn03/tiFcAM7+8bV7l7z1CRSHKn5apNdtpVV48b
         DMVBj8FbTH0hGExnwBTcapZUv3Xj1d+CPE6T9IFdhSg0YqEVXZYHQMHThD1pXBWNw9Fl
         8/sA==
X-Gm-Message-State: AOJu0YzhpM4iI1Ga5T4hfOENK5xHlpzaOuPqQd0E0ZYysE4WcV5XtBez
        P3zxliey8QDStFENVjXMeg0=
X-Google-Smtp-Source: AGHT+IGsgRx+n4PAToauWhpKAfcWdhRBJcOZU8f06h8naNWW7DoEX1OjwVUS15uv0muMVvYbWPxouw==
X-Received: by 2002:a17:90b:4d8f:b0:27f:fce3:2266 with SMTP id oj15-20020a17090b4d8f00b0027ffce32266mr3125637pjb.24.1699574485851;
        Thu, 09 Nov 2023 16:01:25 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:25 -0800 (PST)
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
Subject: [PATCH 45/52] perf annotate-data: Handle global variable access
Date:   Thu,  9 Nov 2023 16:00:04 -0800
Message-ID: <20231110000012.3538610-46-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 09ccac1d0769..bbd271cd3419 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -395,6 +395,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * update_insn_state - Update type state for an instruction
  * @state: type state table
  * @dloc: data location info
+ * @cu_die: compile unit debug entry
  * @dl: disasm line for the instruction
  *
  * This function updates the @state table for the target operand of the
@@ -406,7 +407,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * are true.
  */
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl)
+		       void *cu_die, struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
@@ -448,8 +449,46 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
index ffbdba50b50a..33fd032bf463 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3775,6 +3775,28 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
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
@@ -3844,6 +3866,8 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
+			.thread = he->thread,
+			.cpumode = he->cpumode,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
@@ -3858,23 +3882,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
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
index e1fa86341281..13c9b6a30b15 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct thread;
 struct annotated_data_type;
 
 struct ins {
@@ -501,6 +502,10 @@ extern struct list_head ann_insn_stat;
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
2.42.0.869.gea05f2083d-goog

