Return-Path: <linux-kernel+bounces-107046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDCD487F6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:56:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E21C2185D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38EA80BFD;
	Tue, 19 Mar 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6xsYcfM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEC8060D;
	Tue, 19 Mar 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827490; cv=none; b=DOY34xHJZy4qKlGExHIoJLB5NGMvFC1N6v685jpjM7VHC30Eq7wbiEZxekZv3N/fYfECBovanCcnh1grviEGAQsGy64uokPbuJuApOnUHLKqca5ZRfCcYXS0idv8Ln7NIMRfR1dIqXNiS8h54HO4A7UAu8+A47kGnjxTmnSumjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827490; c=relaxed/simple;
	bh=kniRyKinD1XPWhOm9ZuYt3pPTPJOSx3a2pFJaSgowl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JrhmYXINSGKnjbo3v6vRna0UEePer6vkAOzKgdwhEVPiFlgz1GvviYd7Evj7r9t4isqFkTipocAW3qYF26gx/FqbFtn8ftwgC7hMQ5X0vX8mQ+3gGFRroRor/hPLlC7y3mAoONSEo+bj+A3lWZP8/MCo6fLUyMLdvH/1UR5hQl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6xsYcfM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D7EC43390;
	Tue, 19 Mar 2024 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827489;
	bh=kniRyKinD1XPWhOm9ZuYt3pPTPJOSx3a2pFJaSgowl8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G6xsYcfMSYrJvL7S9JnkGu7ihFsS2cFDbUIYj76eotVKTgjDVlIq9adodJKgf+1wW
	 MKaOHriq8M3LWEXkVP7cEXnS4in+9y1XnIwWhH/lE+RPwViZweeiBJxLj3mwChynaK
	 BPg1L9t2Hdmd17xOsoIBgpxscwLN8qnHEgIMx2lpUhOBIqcgL6Qf1GmIe0zZlexmBZ
	 +Ptyx/ZqhbV/8GIgwvKYigDKLAcWiEu0ww6qJc8WvQshB9XnjRrGEJeKXmV1wNlXIE
	 d6gNIYKqQGyufkVHTT+mFbMf9kQqPAfQDazEG/h0IDhyn/onh2CrUFe7cX3JpTrBrl
	 86y5XdQSIc0fA==
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
Subject: [PATCH 20/23] perf annotate-data: Handle ADD instructions
Date: Mon, 18 Mar 2024 22:51:12 -0700
Message-ID: <20240319055115.4063940-21-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

There are different patterns for percpu variable access using a constant
value added to the base.

  2aeb:  mov    -0x7da0f7e0(,%rax,8),%r14  # r14 = __per_cpu_offset[cpu]
  2af3:  mov    $0x34740,%rax              # rax = address of runqueues
* 2afa:  add    %rax,%r14                  # r14 = &per_cpu(runqueues, cpu)
  2bfd:  cmpl   $0x0,0x10(%r14)            # cpu_rq(cpu)->has_blocked_load
  2b03:  je     0x2b36

At the first instruction, r14 has the __per_cpu_offset.  And then rax
has an immediate value and then added to r14 to calculate the address of
a per-cpu variable.  So it needs to track the immediate values and ADD
instructions.

Similar but a little different case is to use "this_cpu_off" instead of
"__per_cpu_offset" for the current CPU.  This time the variable address
comes with PC-rel addressing.

  89:  mov     $0x34740,%rax                # rax = address of runqueues
* 90:  add     %gs:0x7f015f60(%rip),%rax    # 19a78  <this_cpu_off>
  98:  incl    0xd8c(%rax)                  # cpu_rq(cpu)->sched_count

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 107 +++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 83b5aa00f01c..bd10a576cfbf 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -28,6 +28,8 @@ enum type_state_kind {
 	TSR_KIND_INVALID = 0,
 	TSR_KIND_TYPE,
 	TSR_KIND_PERCPU_BASE,
+	TSR_KIND_CONST,
+	TSR_KIND_POINTER,
 };
 
 #define pr_debug_dtp(fmt, ...)					\
@@ -53,6 +55,13 @@ static void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 	case TSR_KIND_PERCPU_BASE:
 		pr_info(" percpu base\n");
 		return;
+	case TSR_KIND_CONST:
+		pr_info(" constant\n");
+		return;
+	case TSR_KIND_POINTER:
+		pr_info(" pointer");
+		/* it also prints the type info */
+		break;
 	case TSR_KIND_TYPE:
 	default:
 		break;
@@ -393,7 +402,7 @@ static void set_stack_state(struct type_state_stack *stack, int offset, u8 kind,
 	switch (tag) {
 	case DW_TAG_structure_type:
 	case DW_TAG_union_type:
-		stack->compound = true;
+		stack->compound = (kind != TSR_KIND_POINTER);
 		break;
 	default:
 		stack->compound = false;
@@ -585,6 +594,58 @@ static void update_insn_state_x86(struct type_state *state,
 		return;
 	}
 
+	if (!strncmp(dl->ins.name, "add", 3)) {
+		u64 imm_value = -1ULL;
+		int offset;
+		const char *var_name = NULL;
+		struct map_symbol *ms = dloc->ms;
+		u64 ip = ms->sym->start + dl->al.offset;
+
+		if (!has_reg_type(state, dst->reg1))
+			return;
+
+		tsr = &state->regs[dst->reg1];
+
+		if (src->imm)
+			imm_value = src->offset;
+		else if (has_reg_type(state, src->reg1) &&
+			 state->regs[src->reg1].kind == TSR_KIND_CONST)
+			imm_value = state->regs[src->reg1].imm_value;
+		else if (src->reg1 == DWARF_REG_PC) {
+			u64 var_addr = annotate_calc_pcrel(dloc->ms, ip,
+							   src->offset, dl);
+
+			if (get_global_var_info(dloc, var_addr,
+						&var_name, &offset) &&
+			    !strcmp(var_name, "this_cpu_off") &&
+			    tsr->kind == TSR_KIND_CONST) {
+				tsr->kind = TSR_KIND_PERCPU_BASE;
+				imm_value = tsr->imm_value;
+			}
+		}
+		else
+			return;
+
+		if (tsr->kind != TSR_KIND_PERCPU_BASE)
+			return;
+
+		if (get_global_var_type(cu_die, dloc, ip, imm_value, &offset,
+					&type_die) && offset == 0) {
+			/*
+			 * This is not a pointer type, but it should be treated
+			 * as a pointer.
+			 */
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_POINTER;
+			tsr->ok = true;
+
+			pr_debug_dtp("add [%x] percpu %#"PRIx64" -> reg%d",
+				     insn_offset, imm_value, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
@@ -632,6 +693,16 @@ static void update_insn_state_x86(struct type_state *state,
 			return;
 		}
 
+		if (src->imm) {
+			tsr->kind = TSR_KIND_CONST;
+			tsr->imm_value = src->offset;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] imm=%#x -> reg%d\n",
+				     insn_offset, tsr->imm_value, dst->reg1);
+			return;
+		}
+
 		if (!has_reg_type(state, src->reg1) ||
 		    !state->regs[src->reg1].ok) {
 			tsr->ok = false;
@@ -739,13 +810,26 @@ static void update_insn_state_x86(struct type_state *state,
 				tsr->kind = TSR_KIND_TYPE;
 				tsr->ok = true;
 
-				pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d type=",
+				pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d",
 					     insn_offset, src->offset, sreg, dst->reg1);
 				pr_debug_type_name(&tsr->type, tsr->kind);
 			} else {
 				tsr->ok = false;
 			}
 		}
+		/* And then dereference the calculated pointer if it has one */
+		else if (has_reg_type(state, sreg) && state->regs[sreg].ok &&
+			 state->regs[sreg].kind == TSR_KIND_POINTER &&
+			 die_get_member_type(&state->regs[sreg].type,
+					     src->offset, &type_die)) {
+			tsr->type = type_die;
+			tsr->kind = TSR_KIND_TYPE;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] pointer %#x(reg%d) -> reg%d",
+				     insn_offset, src->offset, sreg, dst->reg1);
+			pr_debug_type_name(&tsr->type, tsr->kind);
+		}
 		/* Or try another register if any */
 		else if (src->multi_regs && sreg == src->reg1 &&
 			 src->reg1 != src->reg2) {
@@ -999,6 +1083,25 @@ static bool check_matching_type(struct type_state *state,
 		return false;
 	}
 
+	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_POINTER) {
+		pr_debug_dtp(" percpu ptr\n");
+
+		/*
+		 * It's actaully pointer but the address was calculated using
+		 * some arithmetic.  So it points to the actual type already.
+		 */
+		*type_die = state->regs[reg].type;
+
+		dloc->type_offset = dloc->op->offset;
+
+		/* Get the size of the actual type */
+		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		    (unsigned)dloc->type_offset >= size)
+			return false;
+
+		return true;
+	}
+
 	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
 		u64 addr;
 		int offset;
-- 
2.44.0.291.gc1ea87d7ee-goog


