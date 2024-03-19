Return-Path: <linux-kernel+bounces-107039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D1087F6ED
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F3BF1F224DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A93A7F47D;
	Tue, 19 Mar 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3o6RMm3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B85A7EF03;
	Tue, 19 Mar 2024 05:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827485; cv=none; b=OXM54cGJZ8RQ6WuFs2/11Uo+uQNvXY/Hh5BCvIBJmZ33Ga/dn6Yuy+k9b9PwptC4UEe2A6fjQI/9t2ZZ9mJ6H37ZPm3cio5fNP+FcOkQa6v8vb1VcOtbPfPMPnP4lKFx2fcSo2WtutxbSGGgxyFtfGt2nHS1EeCcyJsIUCLV7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827485; c=relaxed/simple;
	bh=6+RHQY3XONtH+zacbKS8+bLnxBwh7xxtzvp9uABp6QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rT4cC5poQySdRHZGDMcmwIiwwocFdy0Pn3GQx2HaSpDSTdtlSOUmrFUAZg8SL0u1/EFv2sCjBXMXBLqL+arfHEXp2Yfvhs0ytlflJ84B5m+ebFSAkmMdGtBbEPd3CHrc0cfikEesbFrhKG7lSb2U4L+UHxx9CMVwCh22UNSxrFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3o6RMm3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27C5C433C7;
	Tue, 19 Mar 2024 05:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827485;
	bh=6+RHQY3XONtH+zacbKS8+bLnxBwh7xxtzvp9uABp6QI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D3o6RMm363CFM8XMMnxgojZ/s4jm/zeDImpaoQeoqRQkorSZDAA7M+nKuoTENMofp
	 oVPMQ+vnrYIYngohZ6/CkZxKkgVu0V8R9cLyjWcPiFXU1GIGUHNR4013KrR9oSjR4S
	 LTTkIHKgoe89OasdapraWM1ITGbDSoSIT9mE0a9sH74Bo0SaSYCeupHO3xkyKkR91o
	 6OzTtFirh+SlOhZnXe4W1WEG3Y8Dsnr1+Bln9YMB3WPN/+nftdfcb/YDiFsUusnadk
	 YFZiHSpAXGrmy0csSFvzZUiEbuzPAK7ftjAgdPXXyujLKo3Kka853TxGPOBLjw13du
	 nVD4360InYHTQ==
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
Subject: [PATCH 13/23] perf annotate-data: Handle call instructions
Date: Mon, 18 Mar 2024 22:51:05 -0700
Message-ID: <20240319055115.4063940-14-namhyung@kernel.org>
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

When updating instruction states, the call instruction should play a
role since it changes the register states.  For simplicity, mark some
registers as caller-saved registers (should be arch-dependent), and
invalidate them all after a function call.

If the function returns something, the designated register (ret_reg)
will have the type info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 54 +++++++++++++++++++++++++++++++--
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 2cc9f56e3eea..6bcf22e523cb 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -47,10 +47,14 @@ static void pr_debug_type_name(Dwarf_Die *die)
 	free(str);
 }
 
-/* Type information in a register, valid when ok is true */
+/*
+ * Type information in a register, valid when @ok is true.
+ * The @caller_saved registers are invalidated after a function call.
+ */
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
+	bool caller_saved;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -76,6 +80,8 @@ struct type_state {
 	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
 	/* state of stack location */
 	struct list_head stack_vars;
+	/* return value register */
+	int ret_reg;
 };
 
 static bool has_reg_type(struct type_state *state, int reg)
@@ -91,10 +97,23 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 		       Dwarf_Die *cu_die, struct disasm_line *dl);
 
-void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
+void init_type_state(struct type_state *state, struct arch *arch)
 {
 	memset(state, 0, sizeof(*state));
 	INIT_LIST_HEAD(&state->stack_vars);
+
+	if (arch__is(arch, "x86")) {
+		state->regs[0].caller_saved = true;
+		state->regs[1].caller_saved = true;
+		state->regs[2].caller_saved = true;
+		state->regs[4].caller_saved = true;
+		state->regs[5].caller_saved = true;
+		state->regs[8].caller_saved = true;
+		state->regs[9].caller_saved = true;
+		state->regs[10].caller_saved = true;
+		state->regs[11].caller_saved = true;
+		state->ret_reg = 0;
+	}
 }
 
 void exit_type_state(struct type_state *state)
@@ -500,6 +519,37 @@ static void update_insn_state_x86(struct type_state *state,
 	if (annotate_get_insn_location(dloc->arch, dl, &loc) < 0)
 		return;
 
+	if (ins__is_call(&dl->ins)) {
+		struct symbol *func = dl->ops.target.sym;
+
+		if (func == NULL)
+			return;
+
+		/* __fentry__ will preserve all registers */
+		if (!strcmp(func->name, "__fentry__"))
+			return;
+
+		pr_debug_dtp("call [%x] %s\n", insn_offset, func->name);
+
+		/* Otherwise invalidate caller-saved registers after call */
+		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
+			if (state->regs[i].caller_saved)
+				state->regs[i].ok = false;
+		}
+
+		/* Update register with the return type (if any) */
+		if (die_find_func_rettype(cu_die, func->name, &type_die)) {
+			tsr = &state->regs[state->ret_reg];
+			tsr->type = type_die;
+			tsr->ok = true;
+
+			pr_debug_dtp("call [%x] return -> reg%d",
+				     insn_offset, state->ret_reg);
+			pr_debug_type_name(&type_die);
+		}
+		return;
+	}
+
 	if (strncmp(dl->ins.name, "mov", 3))
 		return;
 
-- 
2.44.0.291.gc1ea87d7ee-goog


