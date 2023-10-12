Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70B7C638E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377308AbjJLDz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377224AbjJLDyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:54:09 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E7C19BE;
        Wed, 11 Oct 2023 20:52:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c9d922c039so4500475ad.3;
        Wed, 11 Oct 2023 20:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082738; x=1697687538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QS9t+1UxNgjEpS8viLjdstjzbOva5QnEdVrobE/OTdA=;
        b=bSAoOHO33tol/ESOxDmDvL/TQKPwfY5KygPPBHNi9SEkU8RsObyvpyRnEi8WfQZfSS
         9hZSJI3IS60/9GRGd4ag9qnhiPsCnDEKFOZ4LlesUzuG5X5hY+ue4NRfvF+h2hIghVW8
         BeHC9BwOXONma8OcURk0Zs2VcqtRlQXI4/UuU6ucviragmUjlbFoIwj9gX532QVlJm3d
         Xba5gViBlZUBhE65cNw15gr4N7hpVIsSNtbBLYJvhJlgEByqPuGXcZ9GlbEimWaQ8oUe
         9O2dLRxf4/sxyktg5L+iFWj+tC32+kVhCTuLOWWMaSzDWzz4o3aEwfMl8MMZtuc3ztpN
         lCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082738; x=1697687538;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QS9t+1UxNgjEpS8viLjdstjzbOva5QnEdVrobE/OTdA=;
        b=W2mX3hrUnG4rPb/t4d978qDHLhvccVx/J1dfd6cdaH6wE1l5QgIF2b+VeC1RULoHJh
         itrXDzlFGolC7eKhkxY7IcMVeWldJ/aYcuUVdR1DIOahX3EiIGpLxHuviWv+TmjGH1Z7
         KpyKXKJR2l1PruxOn2LA9sdw3azJvX5NRz5+ItHAhfbSg0b5wTXtdQBD1MNhNwdNMLw6
         +BFnuUr+mC74kOtZZHNCFfiy1oLtYvdJFBjztIVdFUPp6qo1V16nvrM+m2+W0LkapVuo
         2DRd2KyKDEXRsByw+Y7nD5TMXpcjQKwCqrko4ZVL3xCiSnTePUoVG5c0DAmD26LwS5SJ
         JJrQ==
X-Gm-Message-State: AOJu0YzB3h1d1ivphBiBMJJBXdppHdfU3Rafg5HHmhF2nHwgzOYMrtT+
        VrjK4+SMPvJBDV8xFPRAMTY=
X-Google-Smtp-Source: AGHT+IEXFEe8Cjy4EdVwkH80U06BM1WbOGfr6H7DU9pFZIgM7XFYxTFu9zlb6xkgBUsADflizhSD5A==
X-Received: by 2002:a17:902:7893:b0:1bc:6c8:cded with SMTP id q19-20020a170902789300b001bc06c8cdedmr21435579pll.67.1697082737575;
        Wed, 11 Oct 2023 20:52:17 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:17 -0700 (PDT)
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
Subject: [PATCH 48/48] perf annotate-data: Add debug message
Date:   Wed, 11 Oct 2023 20:51:11 -0700
Message-ID: <20231012035111.676789-49-namhyung@kernel.org>
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

This is just for debugging and not for merge.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 122 +++++++++++++++++++++++++++++---
 tools/perf/util/annotate-data.h |   2 +-
 2 files changed, 114 insertions(+), 10 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 68d7d207e2f7..bb0ad26e704d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -115,6 +115,21 @@ void exit_type_state(struct type_state *state)
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
+	__die_get_typename(die, &sb);
+	str = strbuf_detach(&sb, NULL);
+	pr_debug("%s (die:%lx)\n", str, dwarf_dieoffset(die));
+	free(str);
+}
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
@@ -401,7 +416,7 @@ static struct type_state_stack *findnew_stack_state(struct type_state *state,
  * is used only at the given location and updates an entry in the table.
  */
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
-		      u64 addr, struct die_var_type *var_types)
+		      u64 addr, u64 off, struct die_var_type *var_types)
 {
 	Dwarf_Die mem_die;
 	struct die_var_type *var;
@@ -422,14 +437,20 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 
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
@@ -509,6 +530,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 		    die_get_real_type(&func_die, &type_die)) {
 			state->regs[state->ret_reg].type = type_die;
 			state->regs[state->ret_reg].ok = true;
+			pr_debug("fun [%lx] reg0 return from %s type=", dl->al.offset, dwarf_diename(&func_die));
+			debug_print_type_name(&type_die);
 		}
 		return;
 	}
@@ -517,8 +540,10 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 	if (!strstr(dl->ins.name, "mov"))
 		return;
 
-	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0) {
+		pr_debug("failed to get mov insn loc\n");
 		return;
+	}
 
 	if (dloc->fb_cfa) {
 		u64 ip = dloc->ms->sym->start + dl->al.offset;
@@ -533,10 +558,14 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
@@ -556,6 +585,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 						var_name, offset, &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
+				pr_debug("mov [%lx] percpu -> reg%d type=", dl->al.offset, dst->reg1);
+				debug_print_type_name(&state->regs[dst->reg1].type);
 			}
 		} else
 			state->regs[dst->reg1].ok = false;
@@ -586,8 +617,13 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
@@ -600,6 +636,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 							 &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
+				pr_debug("mov [%lx] stack (-%#x, %d) -> reg%d type=", dl->al.offset, -offset, offset, dst->reg1);
+				debug_print_type_name(&type_die);
 			} else
 				state->regs[dst->reg1].ok = false;
 		}
@@ -609,6 +647,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 					    src->offset, &type_die)) {
 			state->regs[dst->reg1].type = type_die;
 			state->regs[dst->reg1].ok = true;
+			pr_debug("mov [%lx] %#x(reg%d) -> reg%d type=", dl->al.offset, src->offset, sreg, dst->reg1);
+			debug_print_type_name(&type_die);
 		}
 		/* Or try another register if any */
 		else if (src->multi_regs && sreg == src->reg1 &&
@@ -648,6 +688,8 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 				findnew_stack_state(state, offset,
 						    &state->regs[src->reg1].type);
 			}
+			pr_debug("mov [%lx] reg%d -> stack (-%#x, %d) type=", dl->al.offset, src->reg1, -offset, offset);
+			debug_print_type_name(&state->regs[src->reg1].type);
 		}
 		/*
 		 * Ignore other transfers since it'd set a value in a struct
@@ -751,6 +793,9 @@ static bool find_matching_type(struct type_state *state,
 		    (unsigned)dloc->type_offset >= size)
 			return false;
 
+		pr_debug("%s: [%lx] reg=%d offset=%d type=",
+			 __func__, dloc->ip - dloc->ms->sym->start, reg, dloc->type_offset);
+		debug_print_type_name(type_die);
 		return true;
 	}
 
@@ -764,6 +809,10 @@ static bool find_matching_type(struct type_state *state,
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= stack->offset;
+
+		pr_debug("%s: [%lx] stack offset=%d type=",
+			 __func__, dloc->ip - dloc->ms->sym->start, dloc->type_offset);
+		debug_print_type_name(type_die);
 		return true;
 	}
 
@@ -785,6 +834,11 @@ static bool find_matching_type(struct type_state *state,
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
 
@@ -808,12 +862,13 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
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
@@ -846,6 +901,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
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
@@ -854,12 +919,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
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
@@ -895,6 +964,18 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
@@ -913,11 +994,15 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
@@ -926,6 +1011,8 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		    die_find_variable_at(&cu_die, dloc->var_name, pc, &var_die)) {
 			ret = check_variable(&var_die, type_die, dloc->type_offset,
 					     /*is_pointer=*/false);
+			if (ret == 0)
+				pr_debug("found \"%s\" by name offset=%d\n", dloc->var_name, dloc->type_offset);
 			/* dloc->type_offset was updated by the caller */
 			goto out;
 		}
@@ -978,6 +1065,21 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
@@ -994,8 +1096,10 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
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
2.42.0.655.g421f12c284-goog

