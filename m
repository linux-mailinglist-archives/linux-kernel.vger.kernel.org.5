Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399DC7E75A4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:05:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345636AbjKJAFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345619AbjKJAEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:04:15 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CA649E4;
        Thu,  9 Nov 2023 16:01:36 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-28098ebd5aeso1308221a91.0;
        Thu, 09 Nov 2023 16:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574496; x=1700179296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DnROzZu8XXAZvFxHI/WlJvEJJ2mL81wo6OnJpfh/LW4=;
        b=hgtoRHm7guWQMo/K9hHRiuJoWHqVgpd5TBlW7MshZBHuEMzvviIWVUmBYDxN6xQ0IT
         DbD9JECK1RHlQfTp+wDSjscDGL6rWiV9z//qcwL1yBKV06YFKd9HFzE7XS6K6o++oDq9
         AzMxk3OLjc8/+XTp8W0h8adL1RLkBHBJL5sZ8oXjE5eEl1WtsdgXsxAqKW4kLN11Qs2R
         mr/sjvTsEmt9lAD5PvZYoOfdtFUNm1NnvvB7tO0kHetlwpgdIFWpjL5v90K5TRj9rF1k
         Ilz/8fOwJ3nYu6xkBb0ky6FoRynoDNd04/hDZcnflouMMRle2505bVfncVJA64j2qS0X
         QFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574496; x=1700179296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DnROzZu8XXAZvFxHI/WlJvEJJ2mL81wo6OnJpfh/LW4=;
        b=BOSbFhhz/PbKD1pmC7ygwAaKohpgSuVGwCsXjm5n7t2uVmlLoL/9OWphhsEw28jehX
         R4UuQItjZEgFnbjbwAzfjqrxmtB/VfNyBNdWphlB8duWcIPL0aDC147IOB15rrshBW3/
         W88RxP9x5tT0GTGNze8cK4nMZthLyemCA7EHug1dfwFzNV7C21rYRbRkzlqpV0neOsoC
         6N+966+LwpyEgM3zce5HCnjR4Qmqf95J6L8lv9D4tnt6mzcdl4p3omQMUo0wnb5+ezsH
         itxEeQl12bjX3sCsdzMFd8WxgX5GjQvNPtw7I2Yn0RGe39dxdIf9NiaBUA+cLS1WKC4h
         C0GA==
X-Gm-Message-State: AOJu0YyBlhVYbpvzj5zWEwlNtVHfXpYeJXQlp2Ne6bRCFQ9njbkPsALr
        2a3o+I3FrQqcV0RS8OMOg5Q=
X-Google-Smtp-Source: AGHT+IGbmcszCffgVvol1Yj6r8qsQfRHBV8HeaHxIKAgx9VrznJPdZtv8xPzEKqSJ36wtyq09K4Z4w==
X-Received: by 2002:a17:90b:38cf:b0:27d:6937:db89 with SMTP id nn15-20020a17090b38cf00b0027d6937db89mr3256557pjb.43.1699574496008;
        Thu, 09 Nov 2023 16:01:36 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:35 -0800 (PST)
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
Subject: [PATCH 52/52] perf annotate-data: Add debug message
Date:   Thu,  9 Nov 2023 16:00:11 -0800
Message-ID: <20231110000012.3538610-53-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just for debugging and not for merge.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 122 +++++++++++++++++++++++++++++---
 tools/perf/util/annotate-data.h |   2 +-
 2 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 416c0b5649fc..8e318349f430 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -90,6 +90,21 @@ void exit_type_state(struct type_state *state)
 	}
 }
 
+static void debug_print_type_name(Dwarf_Die *die)
+{
+	struct strbuf sb;
+	char *str;
+
+	if (!verbose)
+		return;
+
+	strbuf_init(&sb, 32);
+	die_get_typename_from_type(die, &sb);
+	str = strbuf_detach(&sb, NULL);
+	pr_debug("%s (die:%lx)\n", str, dwarf_dieoffset(die));
+	free(str);
+}
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
@@ -376,7 +391,7 @@ static struct type_state_stack *findnew_stack_state(struct type_state *state,
  * is used only at the given location and updates an entry in the table.
  */
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
-		      u64 addr, struct die_var_type *var_types)
+		      u64 addr, u64 off, struct die_var_type *var_types)
 {
 	Dwarf_Die mem_die;
 	struct die_var_type *var;
@@ -397,14 +412,20 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 
 		if (var->reg == DWARF_REG_FB) {
 			findnew_stack_state(state, var->offset, &mem_die);
+			pr_debug("var [%lx] stack fbreg (%x, %d) type=", off, var->offset, var->offset);
+			debug_print_type_name(&mem_die);
 		} else if (var->reg == fbreg) {
 			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
+			pr_debug("var [%lx] stack cfa (%x, %d) fb-offset=%d type=", off, var->offset - fb_offset, var->offset - fb_offset, fb_offset);
+			debug_print_type_name(&mem_die);
 		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
 
 			reg = &state->regs[var->reg];
 			reg->type = mem_die;
 			reg->ok = true;
+			pr_debug("var [%lx] reg%d type=", off, var->reg);
+			debug_print_type_name(&mem_die);
 		}
 	}
 }
@@ -484,6 +505,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 		    die_get_real_type(&func_die, &type_die)) {
 			state->regs[state->ret_reg].type = type_die;
 			state->regs[state->ret_reg].ok = true;
+			pr_debug("fun [%lx] reg0 return from %s type=", dl->al.offset, dwarf_diename(&func_die));
+			debug_print_type_name(&type_die);
 		}
 		return;
 	}
@@ -492,8 +515,10 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 	if (!strstr(dl->ins.name, "mov"))
 		return;
 
-	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0) {
+		pr_debug("failed to get mov insn loc\n");
 		return;
+	}
 
 	if (dloc->fb_cfa) {
 		u64 ip = dloc->ms->sym->start + dl->al.offset;
@@ -508,10 +533,14 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 		if (!has_reg_type(state, dst->reg1))
 			return;
 
-		if (has_reg_type(state, src->reg1))
+		if (has_reg_type(state, src->reg1)) {
 			state->regs[dst->reg1] = state->regs[src->reg1];
-		else if (dloc->ms->map->dso->kernel &&
-			 src->segment == INSN_SEG_X86_GS) {
+			if (state->regs[dst->reg1].ok) {
+				pr_debug("mov [%lx] reg%d -> reg%d type=", dl->al.offset, src->reg1, dst->reg1);
+				debug_print_type_name(&state->regs[dst->reg1].type);
+			}
+		} else if (dloc->ms->map->dso->kernel &&
+			   src->segment == INSN_SEG_X86_GS) {
 			struct map_symbol *ms = dloc->ms;
 			int offset = src->offset;
 			u64 ip = ms->sym->start + dl->al.offset;
@@ -531,6 +560,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 						var_name, offset, &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
+				pr_debug("mov [%lx] percpu -> reg%d type=", dl->al.offset, dst->reg1);
+				debug_print_type_name(&state->regs[dst->reg1].type);
 			}
 		} else
 			state->regs[dst->reg1].ok = false;
@@ -561,8 +592,13 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 						var_name, offset, &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
-			} else
+				pr_debug("mov [%lx] PC-rel -> reg%d type=", dl->al.offset, dst->reg1);
+				debug_print_type_name(&type_die);
+			} else {
+				if (var_name)
+					pr_debug("??? [%lx] PC-rel (%lx: %s%+d)\n", dl->al.offset, var_addr, var_name, offset);
 				state->regs[dst->reg1].ok = false;
+			}
 		}
 		/* And check stack variables with offset */
 		else if (sreg == fbreg) {
@@ -575,6 +611,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 							 &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
+				pr_debug("mov [%lx] stack (-%#x, %d) -> reg%d type=", dl->al.offset, -offset, offset, dst->reg1);
+				debug_print_type_name(&type_die);
 			} else
 				state->regs[dst->reg1].ok = false;
 		}
@@ -584,6 +622,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 					    src->offset, &type_die)) {
 			state->regs[dst->reg1].type = type_die;
 			state->regs[dst->reg1].ok = true;
+			pr_debug("mov [%lx] %#x(reg%d) -> reg%d type=", dl->al.offset, src->offset, sreg, dst->reg1);
+			debug_print_type_name(&type_die);
 		}
 		/* Or try another register if any */
 		else if (src->multi_regs && sreg == src->reg1 &&
@@ -623,6 +663,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 				findnew_stack_state(state, offset,
 						    &state->regs[src->reg1].type);
 			}
+			pr_debug("mov [%lx] reg%d -> stack (-%#x, %d) type=", dl->al.offset, src->reg1, -offset, offset);
+			debug_print_type_name(&state->regs[src->reg1].type);
 		}
 		/*
 		 * Ignore other transfers since it'd set a value in a struct
@@ -726,6 +768,9 @@ static bool find_matching_type(struct type_state *state,
 		    (unsigned)dloc->type_offset >= size)
 			return false;
 
+		pr_debug("%s: [%lx] reg=%d offset=%d type=",
+			 __func__, dloc->ip - dloc->ms->sym->start, reg, dloc->type_offset);
+		debug_print_type_name(type_die);
 		return true;
 	}
 
@@ -739,6 +784,10 @@ static bool find_matching_type(struct type_state *state,
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= stack->offset;
+
+		pr_debug("%s: [%lx] stack offset=%d type=",
+			 __func__, dloc->ip - dloc->ms->sym->start, dloc->type_offset);
+		debug_print_type_name(type_die);
 		return true;
 	}
 
@@ -760,6 +809,11 @@ static bool find_matching_type(struct type_state *state,
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= fboff + stack->offset;
+
+		pr_debug("%s: [%lx] cfa stack offset=%d type_offset=%d type=",
+			 __func__, dloc->ip - dloc->ms->sym->start,
+			 dloc->type_offset + stack->offset, dloc->type_offset);
+		debug_print_type_name(type_die);
 		return true;
 	}
 
@@ -783,12 +837,13 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
 	list_for_each_entry(bb, basic_blocks, list) {
 		struct disasm_line *dl = bb->begin;
 
+		pr_debug("bb: [%lx - %lx]\n", bb->begin->al.offset, bb->end->al.offset);
 		list_for_each_entry_from(dl, &notes->src->source, al.node) {
 			u64 this_ip = sym->start + dl->al.offset;
 			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
 
 			/* Update variable type at this address */
-			update_var_state(&state, dloc, addr, var_types);
+			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
 
 			if (this_ip == dloc->ip) {
 				found = find_matching_type(&state, dloc, reg,
@@ -821,6 +876,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 	u64 src_ip, dst_ip;
 	int ret = -1;
 
+	if (dloc->fb_cfa) {
+		u64 pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
+		int fbreg, fboff;
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+
+		pr_debug("CFA reg=%d offset=%d\n", fbreg, fboff);
+	}
+
 	dst_ip = dloc->ip;
 	for (int i = nr_scopes - 1; i >= 0; i--) {
 		Dwarf_Addr base, start, end;
@@ -829,12 +894,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
 			break;
 
+		pr_debug("scope: [%d/%d] (die:%lx)\n", i + 1, nr_scopes, dwarf_dieoffset(&scopes[i]));
 		src_ip = map__objdump_2rip(dloc->ms->map, start);
 
 		/* Get basic blocks for this scope */
 		if (annotate_get_basic_blocks(dloc->ms->sym, src_ip, dst_ip,
-					      &this_blocks) < 0)
+					      &this_blocks) < 0) {
+			pr_debug("cannot find a basic block from %lx to %lx\n",
+				 src_ip - dloc->ms->sym->start, dst_ip - dloc->ms->sym->start);
 			continue;
+		}
 		prepend_basic_blocks(&this_blocks, &basic_blocks);
 
 		/* Get variable info for this scope and add to var_types list */
@@ -870,6 +939,18 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	int fb_offset = 0;
 	bool is_fbreg = false;
 	u64 pc;
+	char buf[64];
+
+	if (dloc->op->multi_regs)
+		snprintf(buf, sizeof(buf), " or reg%d", dloc->op->reg2);
+	else if (dloc->op->reg1 == DWARF_REG_PC)
+		snprintf(buf, sizeof(buf), " (PC)");
+	else
+		buf[0] = '\0';
+
+	pr_debug("-----------------------------------------------------------\n");
+	pr_debug("%s [%lx] for reg%d%s in %s\n", __func__, dloc->ip - dloc->ms->sym->start,
+		 dloc->op->reg1, buf, dloc->ms->sym->name);
 
 	/*
 	 * IP is a relative instruction address from the start of the map, as
@@ -888,11 +969,15 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	reg = loc->reg1;
 	offset = loc->offset;
 
+	pr_debug("CU die offset: %lx\n", dwarf_dieoffset(&cu_die));
+
 	if (reg == DWARF_REG_PC) {
 		if (die_find_variable_by_addr(&cu_die, pc, dloc->var_addr,
 					      &var_die, &offset)) {
 			ret = check_variable(&var_die, type_die, offset,
 					     /*is_pointer=*/false);
+			if (ret == 0)
+				pr_debug("found PC-rel by addr=%lx offset=%d\n", dloc->var_addr, offset);
 			dloc->type_offset = offset;
 			goto out;
 		}
@@ -901,6 +986,8 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
 			ret = check_variable(&var_die, type_die, dloc->type_offset,
 					     /*is_pointer=*/false);
+			if (ret == 0)
+				pr_debug("found \"%s\" by name offset=%d\n", dloc->var_name, dloc->type_offset);
 			/* dloc->type_offset was updated by the caller */
 			goto out;
 		}
@@ -953,6 +1040,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		/* Found a variable, see if it's correct */
 		ret = check_variable(&var_die, type_die, offset,
 				     reg != DWARF_REG_PC && !is_fbreg);
+		if (ret == 0) {
+#if 0
+			const char *filename;
+			int lineno;
+
+			if (cu_find_lineinfo(&cu_die, pc, &filename, &lineno) < 0) {
+				filename = "unknown";
+				lineno = 0;
+			}
+#endif
+			pr_debug("found \"%s\" in scope=%d/%d reg=%d offset=%#x (%d) loc->offset=%d fb-offset=%d (die:%lx scope:%lx) type=",
+				 dwarf_diename(&var_die), i+1, nr_scopes, reg, offset, offset, loc->offset, fb_offset, dwarf_dieoffset(&var_die),
+				 dwarf_dieoffset(&scopes[i])/*, filename, lineno*/);
+			debug_print_type_name(type_die);
+		}
 		dloc->type_offset = offset;
 		goto out;
 	}
@@ -969,8 +1071,10 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto retry;
 	}
 
-	if (ret < 0)
+	if (ret < 0) {
+		pr_debug("no variable found\n");
 		ann_data_stat.no_var++;
+	}
 
 out:
 	free(scopes);
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index e293980eb11b..44e0f3770432 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -166,7 +166,7 @@ void exit_type_state(struct type_state *state);
 
 /* Update type state table using variables */
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
-		      u64 addr, struct die_var_type *var_types);
+		      u64 addr, u64 off, struct die_var_type *var_types);
 
 /* Update type state table for an instruction */
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-- 
2.42.0.869.gea05f2083d-goog

