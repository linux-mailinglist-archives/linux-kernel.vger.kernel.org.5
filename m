Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78BE07C63A8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377329AbjJLEC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235374AbjJLEBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:01:35 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E8F172E;
        Wed, 11 Oct 2023 20:52:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c60cec8041so3991835ad.3;
        Wed, 11 Oct 2023 20:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082727; x=1697687527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1uOezb4cZDV5RInjOhQ1kglHXO9ceCmqMPAaugA2Fws=;
        b=MoKHCygKSwaGJUUK1FQxbHAg87Ol4tlOMFRUL8LkUZmF+HSrgXfmmFrCMOhn2U/SbH
         5OCFZ13r06Bo3us26Af51KOt0s5XmR3IsFyjlIhYgbs59/VEQYm4VHpTtfp8HVikBc9/
         F1vv+GIlLomWekQq9vKE4DEeHG9bsenWYtkcmz09D7vC85lO1rXnAmL2nmH6PAccraBB
         C3SSa2r3UXycNWN4L62u0dhu9u6VRGdZxrAByqHl+jiLYMjIWxQUAoKo2QYRe7Pnw0By
         xwJRmmsVmFInIcnWiXDNh2qiGBG1rbkQDrsjUeq3GafUv6K6lZRFE7C/cVAI9QkKUnVb
         o8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082727; x=1697687527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1uOezb4cZDV5RInjOhQ1kglHXO9ceCmqMPAaugA2Fws=;
        b=HDwlDnSo3/DCF9wyNEk/aRetaOwk/efTwBF4bXu3LuW8dMi9wRb/iTx8T98PEk6j0z
         O1dYTDDwsGr8AtGTLVe1QvCJkCOmCmNOtpHCd/hd0wIVBz80oJpmRfGzrl7uKxn5FxwL
         kiJoPk1q6GfVtZIuMIY8pdXCV9w9B0sNbnfng6tfJLPKyX9iyOBtZFpRiMX94/UP3l4+
         xPiOYUd/a94Wk4GqITzVyqvs3BZtao03Nc372lgL4Tvf9we/fci2rgmuBfUOowhRegPd
         Il1RARNw7nHGnFh/xcJOiumnsiEfpcrHCArgec1C0rC3xvNYAUwRepJs6na8sCttN4Op
         H+LQ==
X-Gm-Message-State: AOJu0Yz94cOsdrq6cJQfmtTpR0/bP2Nv+MLpfSAnjYdmNL5y0jDcBnJH
        7weDhqx+fANu0Mv9O4vphe4=
X-Google-Smtp-Source: AGHT+IEgZY3TnNf8iEy/TGlCaUg5WcrxoTFCjxq9iR/g1TXxY/TqIFy+lgJSqTNVoKUwaLrMv9c+Zw==
X-Received: by 2002:a17:902:ab82:b0:1c1:e7b2:27ad with SMTP id f2-20020a170902ab8200b001c1e7b227admr19761542plr.60.1697082727072;
        Wed, 11 Oct 2023 20:52:07 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:06 -0700 (PDT)
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
Subject: [PATCH 40/48] perf annotate-data: Add update_insn_state()
Date:   Wed, 11 Oct 2023 20:51:03 -0700
Message-ID: <20231012035111.676789-41-namhyung@kernel.org>
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
index a88d2cdafa08..e8d80b1adda9 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -44,7 +44,6 @@ struct annotated_data_stat ann_data_stat;
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
-	bool scratch;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -400,7 +399,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 			findnew_stack_state(state, var->offset, &mem_die);
 		} else if (var->reg == fbreg) {
 			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
-		} else if (has_reg_type(state, var->reg)) {
+		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
 			struct type_state_reg *reg;
 
 			reg = &state->regs[var->reg];
@@ -410,6 +409,131 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
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
index 8384bc37831c..ab4b6a1d86fe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3795,6 +3795,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 
 	for_each_insn_op_loc(&loc, i, op_loc) {
 		struct data_loc_info dloc = {
+			.arch = arch,
 			.ms = ms,
 			/* Recalculate IP for LOCK prefix or insn fusion */
 			.ip = ms->sym->start + dl->al.offset,
-- 
2.42.0.655.g421f12c284-goog

