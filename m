Return-Path: <linux-kernel+bounces-69503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F44E858A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE4301F214A6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7186E14F9C9;
	Fri, 16 Feb 2024 23:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZVxGjD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902ED14E2C4;
	Fri, 16 Feb 2024 23:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708127671; cv=none; b=SwvFCNsX1TjIIR/gAJYIhd50mvtT+YbPwSIk9dKWMYtdPfSXq+9TaxZauzV6tPbKXvEGZcYWgkTOY5GZgZddZfw+P1WwhG/FyhUquBRF7emJyrGnEiUURRd7Fg9jmeLZBU6u1+cZCgxTO1Mxs3aLfixUz3gDayhtZ7xYZegKdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708127671; c=relaxed/simple;
	bh=zZHOIpCOQRvZUMTIDQX7NJi7rHNLMrUEbf5ATQRYfWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAxZDGh9xLbIVk7RbY55S+6brTpgQtaPFD7RwaKF6KXj3mbqYVdWEI2Eej2xU+zNc/nVihQrlyVLDhccdLkstwI4aYAGSqXlQOw+LNhAYJPWgUM1dVz18wRdn1Zh+21RkZeJlmO7vknLzwRhvVr1aaUhu20O3mQ4a4y5NjN6cEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZVxGjD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215B6C433B1;
	Fri, 16 Feb 2024 23:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708127670;
	bh=zZHOIpCOQRvZUMTIDQX7NJi7rHNLMrUEbf5ATQRYfWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZVxGjD9fx55g/829dqU23cR9Np786MufZf4Yc5V7mqADC3/a+IuTCz2gRxEWzfhO
	 M9QSXZnPQKiyslE/mGzNLg/0UoyBZsox0KCkEQnV54tIKBjukFdb29EnXfXahcqaSN
	 kCzb5KBTY+SuyYADZPxf2V2oOiCtEEVithd3oP25ZfewJYx6UdtdpRrLiEr2kqayIa
	 WqGWQ3+gca7KSH9b2bspj15L9eSz0/0sb686xOPqciCrlTbYUGEh3B7EW8MpFPMsDw
	 An6T8jbnrK+LWBfKAwN32K6wccKsYCsA1WKgPPlxZCqmNXhin/HShdaG2Eyy+ZItYE
	 mz7FSZcKt6MsA==
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
Date: Fri, 16 Feb 2024 15:54:18 -0800
Message-ID: <20240216235423.2343167-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240216235423.2343167-1-namhyung@kernel.org>
References: <20240216235423.2343167-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 45 +++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index e46e162c783f..e8e363fed8c2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -23,10 +23,14 @@
 #include "symbol.h"
 #include "symbol_conf.h"
 
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
+		/* Otherwise invalidate caller-saved registers after call */
+		for (unsigned i = 0; i < ARRAY_SIZE(state->regs); i++) {
+			if (state->regs[i].caller_saved)
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
2.44.0.rc0.258.g7320e95886-goog


