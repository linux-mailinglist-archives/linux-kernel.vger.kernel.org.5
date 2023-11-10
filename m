Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A8F7E7598
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345635AbjKJAEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345547AbjKJADc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:32 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E8949D0;
        Thu,  9 Nov 2023 16:01:27 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-5b980391d7cso1159996a12.0;
        Thu, 09 Nov 2023 16:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574487; x=1700179287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UMm2Aciykg8ub3kZoou0mh34QtErvedZkYd88iOeNUI=;
        b=GWgsEV/027OQHPtC1vnznP7fK32F+EGGTsRj3b7eQ25n5xf0zhbd2FCaLmh59h4wZj
         iY+cAR1eUhO2IDDfmsbI+hm9pWQMz+X6084/mw6xxXE07/6miPiErLijn2AMMM9U1O35
         I2LMH+++b9k6oZPNh33Wgubf77zYZQrtLilcW0J1v4OSvaPtoOmKl9C9ebXbjU14yWVh
         ArfJtJRmjEUIY4T3x9MOu0fsoc/46Ju+mUUC8FJ5xCSndq1hwXKuop8NoZtAK2vDRCxv
         JbYaXymqURuTHDuNGF8vUq/qOEnulN7bOnv4eaj2cuu7CDgYvIZOmJHOgjpeWWBpFImj
         SpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574487; x=1700179287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMm2Aciykg8ub3kZoou0mh34QtErvedZkYd88iOeNUI=;
        b=TzdRZi2jXEgnU9AqmQ+hG36vBoN38jiMuGLEY4qGuIQOnG5I3qr5zZDtI6bGYDrk52
         R7wgij0HnQLxsSYoUs8wnGhro7fMb+eQEfZMRViv6TT5eOI6/HKfIBkxI3F9XfJXTG5W
         tx4wlHCnTdMQ35WgFzamgEbY9UxwWbv4tpRzdmVXQxj6ADNHV3KzIhIF1lxM+hQdPDrB
         anjeZPu8ClEB/MgI8FZxs3DF6dRvpn/kXIO/s7jacEDckCR+8ClimK8mqDzUf+AKFUEH
         qJzG5/Koh5eML86kxkaKcbuRIadHik13Mx0gE/sWnC8GjLY3ZYYJaZddAee7QBZEdaq6
         WltA==
X-Gm-Message-State: AOJu0YwPtEqais6KbDNcIrBdPlQkl1qCnbkfe13nTTamkG6Lztna0LJe
        rfshPr12LKAbcNf5LQdYAqE=
X-Google-Smtp-Source: AGHT+IEqIX8Ilygba3G5AqaL4yv+sKFHQLE4mgXEmlL1oemnFPD9DOndYWyANbbTga92wtGIt4Nh9w==
X-Received: by 2002:a17:90a:1a0c:b0:280:290f:4d38 with SMTP id 12-20020a17090a1a0c00b00280290f4d38mr2923365pjk.36.1699574487262;
        Thu, 09 Nov 2023 16:01:27 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:26 -0800 (PST)
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
Subject: [PATCH 46/52] perf annotate-data: Handle call instructions
Date:   Thu,  9 Nov 2023 16:00:05 -0800
Message-ID: <20231110000012.3538610-47-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index bbd271cd3419..54791dfc6244 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -22,10 +22,14 @@
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
@@ -49,6 +53,7 @@ struct type_state_stack {
 struct type_state {
 	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
 	struct list_head stack_vars;
+	int ret_reg;
 };
 
 static bool has_reg_type(struct type_state *state, int reg)
@@ -56,10 +61,23 @@ static bool has_reg_type(struct type_state *state, int reg)
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
@@ -416,6 +434,29 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
2.42.0.869.gea05f2083d-goog

