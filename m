Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0674F7E7596
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345685AbjKJAEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345585AbjKJAD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:28 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1084A49CA;
        Thu,  9 Nov 2023 16:01:24 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-5bdb0be3591so1199633a12.2;
        Thu, 09 Nov 2023 16:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574484; x=1700179284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h8r6yMR8qZ6aWaX50TTJmshQLLIUq/rTAmPUtwjxMSo=;
        b=Z1bOBmARQKVM7EEm/Xz6OAjvbdLkxnnBKznpEOPjlw5peH1M8oj4PFJJYYoFQjzlGV
         gMX4Fj5mjprsh6C3qikoWSDqs/ji0TteJlgZv0BLqryGvkLVawfERq0ELzJgFyhI9Fqy
         cGIsdrlZEVLT7djkZZrpL0jJue/fwa2FaEe3gWbyq0wcCxEiuXNSt7RPaFZXuWXxwu1k
         87O1CPVwTfX7eZuCokE/jmcNRGCTJz0n5OS0aMkoOxoUV4EG+JWYeHX2qsEx/O07T0Is
         R+gp2s0mGSh0EYgEFWANb16vhqQfgrUABxE4cAVBXHUNn/QhzOawdUySH3dwOsrKO5uY
         NEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574484; x=1700179284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h8r6yMR8qZ6aWaX50TTJmshQLLIUq/rTAmPUtwjxMSo=;
        b=EaASSuITOQ+o8YdrOPwbMzcHH55sc5zWmzCrcXuwau1R6Hm8LXb1I2EEzDIsN56paL
         2tUhhyVL8v2PCPM5CQ0HX3WCMwlnHy1qhDq/XlpXZ0ariUUOqwlYDzqGDhCiTkXefRnv
         YlR1QuUMugeFGzKYs04bL/3ts9CzNoBD0u9cl2bjSYgSCY2oUUcS7INiILZ1vS0NfrAG
         2It8LE/u9VcN7SW8H5rHGdNqUCkQ3SyIpnXW3M08DduopICBprSDLN1Hv1efTTrLDU8Q
         mVpnXmDuFicT0lG+pgqBuode2ylb9KOh5SEfWj9cYo5lHbxQZioG352Ej7bwSNlKHG3G
         aLwA==
X-Gm-Message-State: AOJu0Yyt7iioVR2BG9tHaXDz2UyhKdYrZ8dQeeqKwP8FrFedC6DomMMQ
        oSjVDNrISKHQyQoezwdvV7U=
X-Google-Smtp-Source: AGHT+IGvtc2xCQtxIACTHeP0XgfIlTVV5MSwhPBzqTLlDxaRBOkkR1JGlGpqRUfhBeBKLDlItFWJkw==
X-Received: by 2002:a17:90b:1b0e:b0:281:e1:af1d with SMTP id nu14-20020a17090b1b0e00b0028100e1af1dmr3055942pjb.18.1699574484182;
        Thu, 09 Nov 2023 16:01:24 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:23 -0800 (PST)
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
Subject: [PATCH 44/52] perf annotate-data: Add update_insn_state()
Date:   Thu,  9 Nov 2023 16:00:03 -0800
Message-ID: <20231110000012.3538610-45-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The update_insn_state() function is to update the type state table after
processing each instruction.  For now, it handles MOV (on x86) insn
to transfer type info from the source location to the target.

The location can be a register or a stack slot.  Check carefully when
memory reference happens and fetch the type correctly.  It basically
ignores write to a memory since it doesn't change the type info.  One
exception is writes to (new) stack slots for register spilling.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 128 +++++++++++++++++++++++++++++++-
 tools/perf/util/annotate-data.h |  13 ++++
 tools/perf/util/annotate.c      |   1 +
 3 files changed, 140 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 438d6234020b..09ccac1d0769 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -26,7 +26,6 @@
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
-	bool scratch;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -382,7 +381,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 			findnew_stack_state(state, var->offset, &mem_die);
 		} else if (var->reg == fbreg) {
 			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
-		} else if (has_reg_type(state, var->reg)) {
+		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
 
 			reg = &state->regs[var->reg];
@@ -392,6 +391,131 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 	}
 }
 
+/**
+ * update_insn_state - Update type state for an instruction
+ * @state: type state table
+ * @dloc: data location info
+ * @dl: disasm line for the instruction
+ *
+ * This function updates the @state table for the target operand of the
+ * instruction at @dl if it transfers the type like MOV on x86.  Since it
+ * tracks the type, it won't care about the values like in arithmetic
+ * instructions like ADD/SUB/MUL/DIV and INC/DEC.
+ *
+ * Note that ops->reg2 is only available when both mem_ref and multi_regs
+ * are true.
+ */
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl)
+{
+	struct annotated_insn_loc loc;
+	struct annotated_op_loc *src = &loc.ops[INSN_OP_SOURCE];
+	struct annotated_op_loc *dst = &loc.ops[INSN_OP_TARGET];
+	Dwarf_Die type_die;
+	int fbreg = dloc->fbreg;
+	int fboff = 0;
+
+	/* FIXME: remove x86 specific code and handle more instructions like LEA */
+	if (!strstr(dl->ins.name, "mov"))
+		return;
+
+	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
+		return;
+
+	if (dloc->fb_cfa) {
+		u64 ip = dloc->ms->sym->start + dl->al.offset;
+		u64 pc = map__rip_2objdump(dloc->ms->map, ip);
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+	}
+
+	/* Case 1. register to register transfers */
+	if (!src->mem_ref && !dst->mem_ref) {
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		if (has_reg_type(state, src->reg1))
+			state->regs[dst->reg1] = state->regs[src->reg1];
+		else
+			state->regs[dst->reg1].ok = false;
+	}
+	/* Case 2. memory to register transers */
+	if (src->mem_ref && !dst->mem_ref) {
+		int sreg = src->reg1;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+retry:
+		/* Check stack variables with offset */
+		if (sreg == fbreg) {
+			struct type_state_stack *stack;
+			int offset = src->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack && die_get_member_type(&stack->type,
+							 offset - stack->offset,
+							 &type_die)) {
+				state->regs[dst->reg1].type = type_die;
+				state->regs[dst->reg1].ok = true;
+			} else
+				state->regs[dst->reg1].ok = false;
+		}
+		/* And then dereference the pointer if it has one */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 die_deref_ptr_type(&state->regs[sreg].type,
+					    src->offset, &type_die)) {
+			state->regs[dst->reg1].type = type_die;
+			state->regs[dst->reg1].ok = true;
+		}
+		/* Or try another register if any */
+		else if (src->multi_regs && sreg == src->reg1 &&
+			 src->reg1 != src->reg2) {
+			sreg = src->reg2;
+			goto retry;
+		}
+		/* It failed to get a type info, mark it as invalid */
+		else {
+			state->regs[dst->reg1].ok = false;
+		}
+	}
+	/* Case 3. register to memory transfers */
+	if (!src->mem_ref && dst->mem_ref) {
+		if (!has_reg_type(state, src->reg1) ||
+		    !state->regs[src->reg1].ok)
+			return;
+
+		/* Check stack variables with offset */
+		if (dst->reg1 == fbreg) {
+			struct type_state_stack *stack;
+			int offset = dst->offset - fboff;
+
+			stack = find_stack_state(state, offset);
+			if (stack) {
+				/*
+				 * The source register is likely to hold a type
+				 * of member if it's a compound type.  Do not
+				 * update the stack variable type since we can
+				 * get the member type later by using the
+				 * die_get_member_type().
+				 */
+				if (!stack->compound)
+					set_stack_state(stack, offset,
+							&state->regs[src->reg1].type);
+			} else {
+				findnew_stack_state(state, offset,
+						    &state->regs[src->reg1].type);
+			}
+		}
+		/*
+		 * Ignore other transfers since it'd set a value in a struct
+		 * and won't change the type.
+		 */
+	}
+	/* Case 4. memory to memory transfers (not handled for now) */
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index 7fbb9eb2e96f..ff9acf6ea808 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -11,6 +11,7 @@ struct annotated_op_loc;
 struct arch;
 struct debuginfo;
 struct die_var_type;
+struct disasm_line;
 struct evsel;
 struct map_symbol;
 struct type_state;
@@ -78,6 +79,7 @@ extern struct annotated_data_type stackop_type;
 
 /**
  * struct data_loc_info - Data location information
+ * @arch: architecture info
  * @ms: Map and Symbol info
  * @ip: Instruction address
  * @var_addr: Data address (for global variables)
@@ -90,6 +92,7 @@ extern struct annotated_data_type stackop_type;
  */
 struct data_loc_info {
 	/* These are input field, should be filled by caller */
+	struct arch *arch;
 	struct map_symbol *ms;
 	u64 ip;
 	u64 var_addr;
@@ -159,6 +162,10 @@ void exit_type_state(struct type_state *state);
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 		      u64 addr, struct die_var_type *var_types);
 
+/* Update type state table for an instruction */
+void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
+		       struct disasm_line *dl);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -197,6 +204,12 @@ static inline void update_var_state(struct type_state *state __maybe_unused,
 {
 }
 
+static inline void update_insn_state(struct type_state *state __maybe_unused,
+				     struct data_loc_info *dloc __maybe_unused,
+				     struct disasm_line *dl __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index d54a9ec16af4..ffbdba50b50a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3843,6 +3843,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
+			.arch = arch,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
-- 
2.42.0.869.gea05f2083d-goog

