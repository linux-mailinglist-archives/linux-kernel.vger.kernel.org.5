Return-Path: <linux-kernel+bounces-107041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97DDE87F6EE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C691F22226
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CA67FBA6;
	Tue, 19 Mar 2024 05:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmHLe6hS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE167F7C2;
	Tue, 19 Mar 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827487; cv=none; b=EEB8U/4e3ok3HX5w3pqjJP23ulx5CVus1tMgyYZzmYASBaaqvckTfN+ujsZBO0nSzixChnOc1HSehhPsAXeycdmrWBTtRDTtnd4bZLr411wj0qGnSzSxgo51oVqK+5le0nmH47+2AB43Edxl6wQ3Rd6a7ddBnYhcqpWQENYYGUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827487; c=relaxed/simple;
	bh=QLyOSfT8f1zHgXyW3/7xJapPDD+hyj+Y2KOoSnTTUs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+DUcln8KBj8sgBwIj94HZCuNAow+ilicr5c4TuNPJy+AcaLN90W5EujsVOoQvXRP/9o3Ho9aW9tF8atHhmSacyusCTYfIKwowPfHasx6lV9WZBDt4Kp4lfnMmdK98G2IfhYSZVw7bnOaK54kKE2Mnebj6tSopmiDc0en+sb6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmHLe6hS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E9BC433B1;
	Tue, 19 Mar 2024 05:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827486;
	bh=QLyOSfT8f1zHgXyW3/7xJapPDD+hyj+Y2KOoSnTTUs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CmHLe6hSMentoh66Ns63Ow8SJ319+tSJ5SCofEnzoYJpYnbqad4sc5tlYLMlM2FhR
	 yawE2ROfAXRvHUkzQjozN9FWLx2clQOi42acR01FJi1VPvMEqjlCHTrnh0hzDM5MyC
	 TkkN0gfLoPsIDq2lSdMXEK1VfeDIOViDGew47V8b21vXdsRQV+CBRRsihHYzufum2X
	 FcxIfTFnA6rd1vIgKrLUvewylHe+ejPbTdIJHTClx3Merjt5uSH18gN8eShL0wgTdx
	 twudnPQLHM+S4dI6ZwGNWkNZpyjelOcQegeO7n5xK0CmTdGxLyx9R5unyRBQqA31Aw
	 scQnTbr0DDYDg==
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
Subject: [PATCH 15/23] perf annotate-data: Check register state for type
Date: Mon, 18 Mar 2024 22:51:07 -0700
Message-ID: <20240319055115.4063940-16-namhyung@kernel.org>
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

As instruction tracking updates the type state for each register, check
the final type info for the target register at the given instruction.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 88 ++++++++++++++++++++++++++++++---
 1 file changed, 81 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 13ba65693367..f5329a78a97d 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -788,12 +788,83 @@ static void delete_var_types(struct die_var_type *var_types)
 }
 
 /* It's at the target address, check if it has a matching type */
-static bool find_matching_type(struct type_state *state __maybe_unused,
-			       struct data_loc_info *dloc __maybe_unused,
-			       int reg __maybe_unused,
-			       Dwarf_Die *type_die __maybe_unused)
+static bool check_matching_type(struct type_state *state,
+				struct data_loc_info *dloc, int reg,
+				Dwarf_Die *type_die)
 {
-	/* TODO */
+	Dwarf_Word size;
+	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
+
+	pr_debug_dtp("chk [%x] reg%d offset=%#x ok=%d",
+		     insn_offset, reg, dloc->op->offset, state->regs[reg].ok);
+
+	if (state->regs[reg].ok) {
+		int tag = dwarf_tag(&state->regs[reg].type);
+
+		pr_debug_dtp("\n");
+
+		/*
+		 * Normal registers should hold a pointer (or array) to
+		 * dereference a memory location.
+		 */
+		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type)
+			return false;
+
+		/* Remove the pointer and get the target type */
+		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
+			return false;
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
+	if (reg == dloc->fbreg) {
+		struct type_state_stack *stack;
+
+		pr_debug_dtp(" fbreg\n");
+
+		stack = find_stack_state(state, dloc->type_offset);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= stack->offset;
+
+		return true;
+	}
+
+	if (dloc->fb_cfa) {
+		struct type_state_stack *stack;
+		u64 pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
+		int fbreg, fboff;
+
+		pr_debug_dtp(" cfa\n");
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+
+		if (reg != fbreg)
+			return false;
+
+		stack = find_stack_state(state, dloc->type_offset - fboff);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= fboff + stack->offset;
+
+		return true;
+	}
+
+	pr_debug_dtp("\n");
 	return false;
 }
 
@@ -825,8 +896,8 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
 			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
 
 			if (this_ip == dloc->ip) {
-				found = find_matching_type(&state, dloc, reg,
-							   type_die);
+				found = check_matching_type(&state, dloc, reg,
+							    type_die);
 				goto out;
 			}
 
@@ -896,6 +967,9 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		if (find_data_type_insn(dloc, reg, &basic_blocks, var_types,
 					cu_die, type_die)) {
 			ret = 0;
+			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x",
+				     dloc->op->offset, reg, dloc->type_offset);
+			pr_debug_type_name(type_die);
 			break;
 		}
 
-- 
2.44.0.291.gc1ea87d7ee-goog


