Return-Path: <linux-kernel+bounces-107038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F59887F6EC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04CB8282800
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF447EF12;
	Tue, 19 Mar 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtntBRFh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993D7CF0F;
	Tue, 19 Mar 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827485; cv=none; b=lWvV/kueXZU+HoMQnGOBJxoFGcH0+p3GPgwivLD/3phf3zXob+LN8n36MCiN4Ep6tMnvnosdhrV8EF6xaO2+X4m8DJc5qWRzeWHaahjEuZdcAJIVTTtCd34Sx2T7mH0BycXZ0vX0/O8DeplqHCEWm+VseTanRXNDY4f7BpMHWcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827485; c=relaxed/simple;
	bh=mf4B7dqQYwBHEG3EOUsWTWvUmMNcxn199ikuZuyHXX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4qK6TIcNLcxiwPga/MlDeGAeVghAo5XvvwK3K0q2Fl067ktReu84DRnXNpwjAnkASwtXtri1xXc7Hyd2I1uaVbOlDQv40nJAONnIwUNiNGU/0xtyOHDDuBDOiqoYWiTaSBK1lSqg1IK/H9F9eFGVPujv1IyFJv4WhQSbolu2Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtntBRFh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D482C433F1;
	Tue, 19 Mar 2024 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827484;
	bh=mf4B7dqQYwBHEG3EOUsWTWvUmMNcxn199ikuZuyHXX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PtntBRFhqkLS5FmNGg+r5hCM/LibLByTtcRTYcUZS4WhOEBtA6e1h9EC+UTF8bsk3
	 2BAs9ycu3t/noS9sFCgmj3Dk7/OnFa4YvDS44zv1optsRmoBG48nDordgE1bBBtM7+
	 CON6Tazc+SSp1/iXmc0zphTvnKSZ3QxuY5LEd5eDioMb1wFaYamqBCqnp2j4E1Sk5A
	 6FIDni12uTX/TtFwBpIMjB/H//f6XYvtewyTpR1UvEBkcMc3cljr/VhxOeMRgIF2Yb
	 tLp7KFfnhCqD2klAv2K0xR3/gHQZNgt0MIwti/fPEfFBzcfRaulxon78tlwQAmyKip
	 mTB8uVqXvXV9A==
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
Subject: [PATCH 12/23] perf annotate-data: Handle global variable access
Date: Mon, 18 Mar 2024 22:51:04 -0700
Message-ID: <20240319055115.4063940-13-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating the instruction states, it also needs to handle global
variable accesses.  Same as it does for PC-relative addressing, it can
look up the type by address (if it's defined in the same file), or by
name after finding the symbol by address (for declarations).

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 46 ++++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 3b661e693410..2cc9f56e3eea 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -89,7 +89,7 @@ void exit_type_state(struct type_state *state);
 void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 		      u64 addr, u64 insn_offset, struct die_var_type *var_types);
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl);
+		       Dwarf_Die *cu_die, struct disasm_line *dl);
 
 void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
 {
@@ -485,7 +485,7 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 }
 
 static void update_insn_state_x86(struct type_state *state,
-				  struct data_loc_info *dloc,
+				  struct data_loc_info *dloc, Dwarf_Die *cu_die,
 				  struct disasm_line *dl)
 {
 	struct annotated_insn_loc loc;
@@ -577,6 +577,29 @@ static void update_insn_state_x86(struct type_state *state,
 				     insn_offset, src->offset, sreg, dst->reg1);
 			pr_debug_type_name(&tsr->type);
 		}
+		/* Or check if it's a global variable */
+		else if (sreg == DWARF_REG_PC) {
+			struct map_symbol *ms = dloc->ms;
+			u64 ip = ms->sym->start + dl->al.offset;
+			u64 addr;
+			int offset;
+
+			addr = annotate_calc_pcrel(ms, ip, src->offset, dl);
+
+			if (!get_global_var_type(cu_die, dloc, ip, addr, &offset,
+						 &type_die) ||
+			    !die_get_member_type(&type_die, offset, &type_die)) {
+				tsr->ok = false;
+				return;
+			}
+
+			tsr->type = type_die;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] global addr=%"PRIx64" -> reg%d",
+				     insn_offset, addr, dst->reg1);
+			pr_debug_type_name(&type_die);
+		}
 		/* Or try another register if any */
 		else if (src->multi_regs && sreg == src->reg1 &&
 			 src->reg1 != src->reg2) {
@@ -628,11 +651,26 @@ static void update_insn_state_x86(struct type_state *state,
 	/* Case 4. memory to memory transfers (not handled for now) */
 }
 
+/**
+ * update_insn_state - Update type state for an instruction
+ * @state: type state table
+ * @dloc: data location info
+ * @cu_die: compile unit debug entry
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
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
-		       struct disasm_line *dl)
+		       Dwarf_Die *cu_die, struct disasm_line *dl)
 {
 	if (arch__is(dloc->arch, "x86"))
-		update_insn_state_x86(state, dloc, dl);
+		update_insn_state_x86(state, dloc, cu_die, dl);
 }
 
 /* The result will be saved in @type_die */
-- 
2.44.0.291.gc1ea87d7ee-goog


