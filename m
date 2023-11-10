Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2F57E75A0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345595AbjKJAEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345641AbjKJADz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:55 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6CBD5B8B;
        Thu,  9 Nov 2023 16:01:33 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc316ccc38so12761285ad.1;
        Thu, 09 Nov 2023 16:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574493; x=1700179293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LQMqcV8+xKPMkuCeGhhLbjMOgNrw0IhfnrFjgWw4W4=;
        b=Q3u4WB7taRsrngFLMMtKkhcDTCLRRLdMvh2S9Ax4NvfSD4YUGXbX5RWT+tjBGYE72A
         coGPfKtFWNVEFzOUJ5eEHrezi0lMJdZX4o61BS7a5MCLQu98nYSs7J8IkzMmuAgccUC/
         JCmvP8J/AO6ZtexOHGDJmx0SK4yEQaqR1mhq7/TpfoaHQDAHmmd3tOg6Fsx2sjdbzdIs
         nRXrL5hZcS/FoBgfyxjj0yBHvvIz6IqVc/01QqDTo7M7cum997oCwL9ja81pwHrpJEoY
         TqPks52j07Wlkzr/3zVgt8aRE/cEu308R7vY3jMRhh5McGkbZPKpVf+k8yKEY3DTw6wo
         BSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574493; x=1700179293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7LQMqcV8+xKPMkuCeGhhLbjMOgNrw0IhfnrFjgWw4W4=;
        b=WL8PKJAeRxBoprpJK0XsZWhZUCyOpt2242IAKxhV4V9IiL9qVGbHXaBQnhuemUf2/C
         tQk81n5lmzjt7vUiXIjP6TJY+3UzmPOQF72N4M1LQXoGNY8oyLThbl4pYSQkci3kQ5gy
         Chxvf8bqKZE7kB+6L/eXiR0wqh4LyRCkirMHGH35zqIjYiSRqEMv4kRujXwQ1o6cOM0r
         DvNXeXAZaSx1AqBTId9aF3asi/tcPSCjBIDlZxyghQE7EApLlp0EiU/QzxRBDN6NmHhI
         AzfypziGuFLgsUNOgevwqvRcB3UjEwzR8uywMqaF+EQjkKxH3UbCVKh2FeR3ze++u7nE
         0Fdw==
X-Gm-Message-State: AOJu0YwB/KGRl+fYYxB3vxNsuYgx5hvAsARaQauN3ztql83s3EpjyJJI
        J2DKr6ks28rmlh/f+6qWSiEjp+nj3LQ=
X-Google-Smtp-Source: AGHT+IGk43I3VkvyGIAng10T1TVRcP4V9gcBaWqsidFcRNWTeD86MkCSZxWlztrLTz7ISIwqxrCCfw==
X-Received: by 2002:a17:90b:4f48:b0:281:3f1e:c26d with SMTP id pj8-20020a17090b4f4800b002813f1ec26dmr3401074pjb.45.1699574493117;
        Thu, 09 Nov 2023 16:01:33 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:32 -0800 (PST)
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
Subject: [PATCH 50/52] perf annotate-data: Track instructions with a this-cpu variable
Date:   Thu,  9 Nov 2023 16:00:09 -0800
Message-ID: <20231110000012.3538610-51-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like global variables, this per-cpu variables should be tracked
correctly.  Factor our get_global_var_type() to handle both global
and per-cpu (for this cpu) variables in the same manner.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 84 +++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 56dfbddb53d2..416c0b5649fc 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -409,6 +409,37 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
 	}
 }
 
+static bool get_global_var_type(Dwarf_Die *cu_die, struct map_symbol *ms, u64 ip,
+				u64 var_addr, const char *var_name, int var_offset,
+				Dwarf_Die *type_die)
+{
+	u64 pc;
+	int offset = var_offset;
+	bool is_pointer = false;
+	Dwarf_Die var_die;
+
+	pc = map__rip_2objdump(ms->map, ip);
+
+	/* Try to get the variable by address first */
+	if (die_find_variable_by_addr(cu_die, pc, var_addr, &var_die, &offset) &&
+	    check_variable(&var_die, type_die, offset, is_pointer) == 0 &&
+	    die_get_member_type(type_die, offset, type_die))
+		return true;
+
+	if (var_name == NULL)
+		return false;
+
+	offset = var_offset;
+
+	/* Try to get the name of global variable */
+	if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
+	    check_variable(&var_die, type_die, offset, is_pointer) == 0 &&
+	    die_get_member_type(type_die, offset, type_die))
+		return true;
+
+	return false;
+}
+
 /**
  * update_insn_state - Update type state for an instruction
  * @state: type state table
@@ -472,14 +503,36 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 			fbreg = -1;
 	}
 
-	/* Case 1. register to register transfers */
+	/* Case 1. register to register or segment:offset to register transfers */
 	if (!src->mem_ref && !dst->mem_ref) {
 		if (!has_reg_type(state, dst->reg1))
 			return;
 
 		if (has_reg_type(state, src->reg1))
 			state->regs[dst->reg1] = state->regs[src->reg1];
-		else
+		else if (dloc->ms->map->dso->kernel &&
+			 src->segment == INSN_SEG_X86_GS) {
+			struct map_symbol *ms = dloc->ms;
+			int offset = src->offset;
+			u64 ip = ms->sym->start + dl->al.offset;
+			const char *var_name = NULL;
+			u64 var_addr;
+
+			/*
+			 * In kernel, %gs points to a per-cpu region for the
+			 * current CPU.  Access with a constant offset should
+			 * be treated as a global variable access.
+			 */
+			var_addr = src->offset;
+			get_percpu_var_info(dloc->thread, ms, dloc->cpumode,
+					    var_addr, &var_name, &offset);
+
+			if (get_global_var_type(cu_die, ms, ip, var_addr,
+						var_name, offset, &type_die)) {
+				state->regs[dst->reg1].type = type_die;
+				state->regs[dst->reg1].ok = true;
+			}
+		} else
 			state->regs[dst->reg1].ok = false;
 	}
 	/* Case 2. memory to register transers */
@@ -492,37 +545,20 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 retry:
 		/* Check if it's a global variable */
 		if (sreg == DWARF_REG_PC) {
-			Dwarf_Die var_die;
 			struct map_symbol *ms = dloc->ms;
 			int offset = src->offset;
 			u64 ip = ms->sym->start + dl->al.offset;
-			u64 pc, addr;
 			const char *var_name = NULL;
+			u64 var_addr;
 
-			addr = annotate_calc_pcrel(ms, ip, offset, dl);
-			pc = map__rip_2objdump(ms->map, ip);
-
-			if (die_find_variable_by_addr(cu_die, pc, addr,
-						      &var_die, &offset) &&
-			    check_variable(&var_die, &type_die, offset,
-					   /*is_pointer=*/false) == 0 &&
-			    die_get_member_type(&type_die, offset, &type_die)) {
-				state->regs[dst->reg1].type = type_die;
-				state->regs[dst->reg1].ok = true;
-				return;
-			}
+			var_addr = annotate_calc_pcrel(ms, ip, offset, dl);
 
-			/* Try to get the name of global variable */
-			offset = src->offset;
 			get_global_var_info(dloc->thread, ms, ip, dl,
-					    dloc->cpumode, &addr,
+					    dloc->cpumode, &var_addr,
 					    &var_name, &offset);
 
-			if (var_name && die_find_variable_at(cu_die, var_name,
-							     pc, &var_die) &&
-			    check_variable(&var_die, &type_die, offset,
-					   /*is_pointer=*/false) == 0 &&
-			    die_get_member_type(&type_die, offset, &type_die)) {
+			if (get_global_var_type(cu_die, ms, ip, var_addr,
+						var_name, offset, &type_die)) {
 				state->regs[dst->reg1].type = type_die;
 				state->regs[dst->reg1].ok = true;
 			} else
-- 
2.42.0.869.gea05f2083d-goog

