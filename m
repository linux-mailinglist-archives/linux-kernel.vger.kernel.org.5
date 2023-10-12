Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A105F7C6392
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376959AbjJLD4d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347066AbjJLDzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:55:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A26C1739;
        Wed, 11 Oct 2023 20:52:09 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c9e06f058bso1579295ad.0;
        Wed, 11 Oct 2023 20:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082728; x=1697687528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+cQ9CSkhhrD4qbqChHjPumcDdy/6FXJfEC4K6SPW0Y=;
        b=dGuVDFkw9QZFISzPwqWnHTd5H+JTKV+73FvQMMNZo6nuWJlIA+d5vKt43lp6zQqgdS
         w/wZOxQm2O2U+AJuF2pwuydFnV3uhzWIpCfunz7X1jChX7pniZHImqFV3Dwpsk6wF1HN
         ZG+TQo0yKRNBbVrhSOl4NRF5fi16Gjymz8b+lnUrM5FZ3tlkPzT4a++QQLvCy2IkWAnP
         OQD2cugAgXaYN11kv7bpCfyxPfLxFqXJ4WLFYIIqEl+/FKGoE1vag6ZqVl7fWmCyCxMf
         cSSBCwBbrKP4TOTlwrW+wrhx1flUoUVudCgUm8B0ARK2qZPFGGL6n1NReOu77i7v3Ra+
         oGIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082728; x=1697687528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+cQ9CSkhhrD4qbqChHjPumcDdy/6FXJfEC4K6SPW0Y=;
        b=gsCkVpz9fd3X6lt4faJ9xymy6aZnhUKgg1Hil2kigNsdywP5dBdZPZKRQrrFI71u0I
         F2wSFKEsI6f7P9yoWolyncW9kJkQxHpdGwn0W+8ovaKckB+a0aqCmifYLFTS8eVlkg4L
         MBa/W+S3mnXNKcU8BDi5L4CvDxzEXBnp8CIT62eYTsOTEJCFBdGXzuRTJE4NYyUqyA20
         C+2xVmdhLTCgomYuaveLnnVwOdYAzJQdbDy2AokLmmD/VtkFby85B+vZOTfrnaX4cwAr
         PCUlU0TzovelCBoRH5rUY2K0L5tWUhtpN8ZT3d8bIXwtJGlNKa1uL5nAyjFf7YMHgqts
         FWDA==
X-Gm-Message-State: AOJu0YyU9WLKXt7wxhzMxvLrJou7bjtkhOC9bDui4+s+nPOj40gTQ1Oo
        lV0GW4ZfbWaVISIx553j8js=
X-Google-Smtp-Source: AGHT+IGYY2REijxPTjznI/mr2/Fqobn49pWYTc0Hv7sPSWV59ECYgQRZBNuwQvYFQGVXK1RZC6vNOA==
X-Received: by 2002:a17:903:110f:b0:1c9:d358:b3d9 with SMTP id n15-20020a170903110f00b001c9d358b3d9mr4393201plh.18.1697082728435;
        Wed, 11 Oct 2023 20:52:08 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:08 -0700 (PDT)
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
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH 41/48] perf annotate-data: Handle global variable access
Date:   Wed, 11 Oct 2023 20:51:04 -0700
Message-ID: <20231012035111.676789-42-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index e8d80b1adda9..37135698a5c8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -413,6 +413,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * update_insn_state - Update type state for an instruction
  * @state: type state table
  * @dloc: data location info
+ * @cu_die: compile unit debug entry
  * @dl: disasm line for the instruction
  *
  * This function updates the @state table for the target operand of the
@@ -424,7 +425,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
  * are true.
  */
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl)
+		       void *cu_die, struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
 	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
@@ -466,8 +467,46 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
index ab4b6a1d86fe..d82bfb3b519d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3727,6 +3727,28 @@ u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
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
@@ -3796,6 +3818,8 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
 			.arch = arch,
+			.thread = he->thread,
+			.cpumode = he->cpumode,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
@@ -3810,23 +3834,10 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
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
index c2cc9baf08be..0786528770e1 100644
--- a/tools/perf/util/annotate.h
+++ b/tools/perf/util/annotate.h
@@ -23,6 +23,7 @@ struct option;
 struct perf_sample;
 struct evsel;
 struct symbol;
+struct thread;
 struct annotated_data_type;
 
 struct ins {
@@ -493,6 +494,10 @@ extern struct list_head ann_insn_stat;
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
2.42.0.655.g421f12c284-goog

