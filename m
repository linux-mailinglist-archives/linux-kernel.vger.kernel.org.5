Return-Path: <linux-kernel+bounces-107047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C682A87F6F5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BF6D2828ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD7F811E0;
	Tue, 19 Mar 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvlOHNZU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8973B80637;
	Tue, 19 Mar 2024 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827490; cv=none; b=J1OdMLFaaVhNJT9Ui2ndyUNbSXazklMwVfhphehxjgixEL9TBOInEofcgpieyicEcT5Gy79Gz9i+yR0ZDGw+0jtMIbtMSL3RXPrvd9/rjBta58gaGKFHl6U83fU3w/hzjU9fPbfEnA41Lh7hb9cG80gh1yoj8UYyOkp55gBk/Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827490; c=relaxed/simple;
	bh=/JGap4Y9xwXTO8JArBzhog8K1/fRwK77w+sFtNgYcGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AqIokfdHKxRIUDE5h0rgSkVxPb9LzMvl2bJ9gqGhNAqcynI4JOIF+AgtiBGya/0Idr2h0/LVvb6XgA9+zRFVt02uxypfzTpb8MpTWP1S8//w4ovbGPZGfhrp8f3hziVCuXF1WdjsN+ce+RaH445sAddMkCzxDP62w9bl1A4g2CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvlOHNZU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED039C433B2;
	Tue, 19 Mar 2024 05:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827490;
	bh=/JGap4Y9xwXTO8JArBzhog8K1/fRwK77w+sFtNgYcGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KvlOHNZUM6VJvVdD/A2qsN9TS31Hqzq87keTkHjIVjM4gAf/5CY57+BeCXNyudI4d
	 xoWk+WpqXIxzKFxuSUk64SzMC86MmM2dUQ45WvjGndGVlY/VX9TIRv7Zwwsa3r/5jZ
	 1Dp3hVFYHAJMsMiGFx1A8d5WXrAu90QNAhELOwN9L2D1C0mhYGTl48kGboQ12yUTU3
	 ibCfyuY1GYq5j1lFtIuJfrYaTY1nCp/c9biVXcTvZ9e4f1BeI5H35YfZsiBz/PU3Vn
	 Rvq5QzNls305NqXgZu4kUYsNBg6i8OO1U2GOVwPPIeZdIlbMmlektA5pH1dzfOsqzs
	 RvTb0hbTVj9Kw==
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
Subject: [PATCH 21/23] perf annotate-data: Add stack canary type
Date: Mon, 18 Mar 2024 22:51:13 -0700
Message-ID: <20240319055115.4063940-22-namhyung@kernel.org>
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

When the stack protector is enabled, compiler would generate code to
check stack overflow with a special value called 'stack carary' at
runtime.  On x86_64, GCC hard-codes the stack canary as %gs:40.

While there's a definition of fixed_percpu_data in asm/processor.h,
it seems that the header is not included everywhere and many places
it cannot find the type info.  As it's in the well-known location (at
%gs:40), let's add a pseudo stack canary type to handle it specially.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 46 +++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |  1 +
 tools/perf/util/annotate.c      | 25 ++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index bd10a576cfbf..633fe125fcd8 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -30,6 +30,7 @@ enum type_state_kind {
 	TSR_KIND_PERCPU_BASE,
 	TSR_KIND_CONST,
 	TSR_KIND_POINTER,
+	TSR_KIND_CANARY,
 };
 
 #define pr_debug_dtp(fmt, ...)					\
@@ -62,6 +63,9 @@ static void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		pr_info(" pointer");
 		/* it also prints the type info */
 		break;
+	case TSR_KIND_CANARY:
+		pr_info(" stack canary\n");
+		return;
 	case TSR_KIND_TYPE:
 	default:
 		break;
@@ -676,6 +680,15 @@ static void update_insn_state_x86(struct type_state *state,
 			 */
 			var_addr = src->offset;
 
+			if (var_addr == 40) {
+				tsr->kind = TSR_KIND_CANARY;
+				tsr->ok = true;
+
+				pr_debug_dtp("mov [%x] stack canary -> reg%d\n",
+					     insn_offset, dst->reg1);
+				return;
+			}
+
 			if (!get_global_var_type(cu_die, dloc, ip, var_addr,
 						 &offset, &type_die) ||
 			    !die_get_member_type(&type_die, offset, &type_die)) {
@@ -991,6 +1004,16 @@ static void delete_var_types(struct die_var_type *var_types)
 	}
 }
 
+/* should match to is_stack_canary() in util/annotate.c */
+static void setup_stack_canary(struct data_loc_info *dloc)
+{
+	if (arch__is(dloc->arch, "x86")) {
+		dloc->op->segment = INSN_SEG_X86_GS;
+		dloc->op->imm = true;
+		dloc->op->offset = 40;
+	}
+}
+
 /* It's at the target address, check if it has a matching type */
 static bool check_matching_type(struct type_state *state,
 				struct data_loc_info *dloc, int reg,
@@ -1038,6 +1061,11 @@ static bool check_matching_type(struct type_state *state,
 		if (stack == NULL)
 			return false;
 
+		if (stack->kind == TSR_KIND_CANARY) {
+			setup_stack_canary(dloc);
+			return false;
+		}
+
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= stack->offset;
@@ -1062,6 +1090,11 @@ static bool check_matching_type(struct type_state *state,
 		if (stack == NULL)
 			return false;
 
+		if (stack->kind == TSR_KIND_CANARY) {
+			setup_stack_canary(dloc);
+			return false;
+		}
+
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= fboff + stack->offset;
@@ -1102,6 +1135,19 @@ static bool check_matching_type(struct type_state *state,
 		return true;
 	}
 
+	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_CANARY) {
+		pr_debug_dtp(" stack canary\n");
+
+		/*
+		 * This is a saved value of the stack canary which will be handled
+		 * in the outer logic when it returns failure here.  Pretend it's
+		 * from the stack canary directly.
+		 */
+		setup_stack_canary(dloc);
+
+		return false;
+	}
+
 	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
 		u64 addr;
 		int offset;
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ae0f87aed804..1b5a152163b5 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -73,6 +73,7 @@ struct annotated_data_type {
 
 extern struct annotated_data_type unknown_type;
 extern struct annotated_data_type stackop_type;
+extern struct annotated_data_type canary_type;
 
 /**
  * struct data_loc_info - Data location information
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e4121acb4f88..64e54ff1aa1d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -118,6 +118,13 @@ struct annotated_data_type stackop_type = {
 	},
 };
 
+struct annotated_data_type canary_type = {
+	.self = {
+		.type_name = (char *)"(stack canary)",
+		.children = LIST_HEAD_INIT(canary_type.self.children),
+	},
+};
+
 static int arch__grow_instructions(struct arch *arch)
 {
 	struct ins *new_instructions;
@@ -3803,6 +3810,18 @@ static bool is_stack_operation(struct arch *arch, struct disasm_line *dl)
 	return false;
 }
 
+static bool is_stack_canary(struct arch *arch, struct annotated_op_loc *loc)
+{
+	/* On x86_64, %gs:40 is used for stack canary */
+	if (arch__is(arch, "x86")) {
+		if (loc->segment == INSN_SEG_X86_GS && loc->imm &&
+		    loc->offset == 40)
+			return true;
+	}
+
+	return false;
+}
+
 u64 annotate_calc_pcrel(struct map_symbol *ms, u64 ip, int offset,
 			struct disasm_line *dl)
 {
@@ -3929,6 +3948,12 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		}
 
 		mem_type = find_data_type(&dloc);
+
+		if (mem_type == NULL && is_stack_canary(arch, op_loc)) {
+			mem_type = &canary_type;
+			dloc.type_offset = 0;
+		}
+
 		if (mem_type)
 			istat->good++;
 		else
-- 
2.44.0.291.gc1ea87d7ee-goog


