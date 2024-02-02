Return-Path: <linux-kernel+bounces-50642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05599847C03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA651F2B755
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5785412F389;
	Fri,  2 Feb 2024 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ctB46xXC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDE612D77A;
	Fri,  2 Feb 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911507; cv=none; b=NMarRYHyffVKE303AwPO1GUZpuMJvQKUTLQVOd2S5OsGaBycp5MiWJqzUIlI4KAa4pBV788pT49+UOnd12W2//PJ8qryh7Q0IlBLjk6hgJIzt2q/3pxiCbycTSuMnf34Xa1p6osnA04j2f3Ox3MQrtZby5AH+i1Xa3BlLh0EvDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911507; c=relaxed/simple;
	bh=NAmRPC2/kvPkVI8QeH6SxAYcD47o8R8XglhwKCAOVSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mfJad02ctC6FCe3wNnoziZiSvOEgzEzkmtlkObQsYY/EZsZBc7TEK14O/KY/floFqhsGODwjRaXDSRPubL9qFEjTKcaOwFJxyC7OmMICM22uFv/3GTvcqcYL7F72aRGjAwF1VkzhrduzZoCDoT85qE1SUpmXBFx+dhNe02mU/wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ctB46xXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57F6C43601;
	Fri,  2 Feb 2024 22:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911507;
	bh=NAmRPC2/kvPkVI8QeH6SxAYcD47o8R8XglhwKCAOVSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ctB46xXCILUNSO1/4P2k6tYcFVQYzgq6eKHGIQ/gdMQO1ffdqS8qnSbanL/MIjlhz
	 OappRGsP+fC2leT/uHq4aZh7OskRgkBYVw9Ikdr6hDWNKS1RBfzEbkhqQUu3LDkO9J
	 GmwgfVcZaI2PVWCVfNX3p7kloJdlVRNoE1UqOVrgmpj+Ea7mRV31f9afmKTpC04zMj
	 S+tGu2ym9m6hRAePgpf/++sd5bryC4mj/BODG1QbNJvjfSFkqTKyFu/0YmK2GJxkro
	 G7bWh1y9/dCCvcela1/ZCkpthlIA5lIls7nQ7t+ajZoOk2uIEvxbG36nno2u5vF6If
	 A19NkJPynavoA==
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
Subject: [PATCH 09/14] perf annotate-data: Handle call instructions
Date: Fri,  2 Feb 2024 14:04:54 -0800
Message-ID: <20240202220459.527138-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202220459.527138-1-namhyung@kernel.org>
References: <20240202220459.527138-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating instruction states, the call instruction should play a
role since it can change the register states.  For simplicity, mark some
registers as scratch registers (should be arch-dependent), and
invalidate them all after a function call.

If the function returns something, the designated register (ret_reg)
will have the type info.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 45 +++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e46e162c783f..185cb896b9d6 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -23,10 +23,14 @@
 #include "symbol.h"
 #include "symbol_conf.h"
 
-/* Type information in a register, valid when ok is true */
+/*
+ * Type information in a register, valid when @ok is true.
+ * The @scratch registers are invalidated after a function call.
+ */
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
+	bool scratch;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -50,6 +54,7 @@ struct type_state_stack {
 struct type_state {
 	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
 	struct list_head stack_vars;
+	int ret_reg;
 };
 
 static bool has_reg_type(struct type_state *state, int reg)
@@ -57,10 +62,23 @@ static bool has_reg_type(struct type_state *state, int reg)
 	return (unsigned)reg < ARRAY_SIZE(state->regs);
 }
 
-void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
+void init_type_state(struct type_state *state, struct arch *arch)
 {
 	memset(state, 0, sizeof(*state));
 	INIT_LIST_HEAD(&state->stack_vars);
+
+	if (arch__is(arch, "x86")) {
+		state->regs[0].scratch = true;
+		state->regs[1].scratch = true;
+		state->regs[2].scratch = true;
+		state->regs[4].scratch = true;
+		state->regs[5].scratch = true;
+		state->regs[8].scratch = true;
+		state->regs[9].scratch = true;
+		state->regs[10].scratch = true;
+		state->regs[11].scratch = true;
+		state->ret_reg = 0;
+	}
 }
 
 void exit_type_state(struct type_state *state)
@@ -417,6 +435,29 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 	int fbreg = dloc->fbreg;
 	int fboff = 0;
 
+	if (ins__is_call(&dl->ins)) {
+		Dwarf_Die func_die;
+
+		/* __fentry__ will preserve all registers */
+		if (dl->ops.target.sym &&
+		    !strcmp(dl->ops.target.sym->name, "__fentry__"))
+			return;
+
+		/* Otherwise invalidate scratch registers after call */
+		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
+			if (state->regs[i].scratch)
+				state->regs[i].ok = false;
+		}
+
+		/* Update register with the return type (if any) */
+		if (die_find_realfunc(cu_die, dl->ops.target.addr, &func_die) &&
+		    die_get_real_type(&func_die, &type_die)) {
+			state->regs[state->ret_reg].type = type_die;
+			state->regs[state->ret_reg].ok = true;
+		}
+		return;
+	}
+
 	/* FIXME: remove x86 specific code and handle more instructions like LEA */
 	if (!strstr(dl->ins.name, "mov"))
 		return;
-- 
2.43.0.594.gd9cf4e227d-goog


