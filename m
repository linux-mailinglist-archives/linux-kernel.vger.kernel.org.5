Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C8D7C6391
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376862AbjJLD4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377477AbjJLDzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:55:13 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0932219AA;
        Wed, 11 Oct 2023 20:52:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-692ada71d79so453265b3a.1;
        Wed, 11 Oct 2023 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082735; x=1697687535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32z5oH+I7vh+Z/UZDnI1j9besZ0XJgEASBZ50FSTvqQ=;
        b=M9g6qVsIRuFYeiXoviQTLK5Z8dpfmzZYQoFWn0QXpYB2Sd/ZGD9ckjZ1+AHitr877k
         I5qNh30jWd+Othq9kxOxEzvNnKWlMX7rCSzGcULbQLzX7Jpfub20ryxrIWHxv1lKU3Gg
         iD2I1gnVY4z/044xUVTYq5oI1qUevv3ogg11HmhUxK9wfkxidYGAyySPc7knaBxnPmUG
         cn4JP6qsrB/yU7RUvUTSAZ1DOnklMeEY++GY7WRl0pyyFAncpApGmtqyroW48JrKAKUy
         SNzoa0PA4DZhJ1o84QuxIeS60AyKF2vp6GhFRGFMHM4jVDzrVUr0/Ymwx9D6et1rEZyn
         Mnlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082735; x=1697687535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=32z5oH+I7vh+Z/UZDnI1j9besZ0XJgEASBZ50FSTvqQ=;
        b=cvLxAvau8rAF7wAYlXRX+OW9I031rLY0jkCX+Vse59cTHdFukueNVrn/+ZoP23fNlY
         WtjP4rWwPgmzowK7nE7by7mF1K22lhGwHaxk01Oa9tkplOwK4j6pySXGExIqgEAg5w/Q
         gRF81i72SSiEwRBRGsIPI/41cuFfrYyTko9O0W7u+dkfPNcEHbQeeCo1HJoyZhyChcf+
         L6lXaa4Daipz9jPoUXe5QWfSvT3GTN9yEw4mPP8os7JY7t2vAwDIgR8ga5CwW/6ROUPy
         IalIUNzBbJ8/a50YtmG3EmOJeALEHcwPrCbcDOiT9TiQqlFgBGEZmeYnROMKcgt20YkZ
         qlYg==
X-Gm-Message-State: AOJu0YwGciQNF+AY32MKVe1pe30BciV0njLj116/ihy8V785Lei03zih
        poL+0z2sa+St/G4Y1PTZsLg=
X-Google-Smtp-Source: AGHT+IHJq4vVq1fmAyTMkN9TzIW9VIqYrEYCUKye1tVv9QzvsN5hQLAUIb5Q+ve7KSQeoHvgFjU8JQ==
X-Received: by 2002:a05:6a20:9754:b0:174:2286:81f4 with SMTP id hs20-20020a056a20975400b00174228681f4mr1951878pzc.14.1697082734885;
        Wed, 11 Oct 2023 20:52:14 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:14 -0700 (PDT)
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
Subject: [PATCH 46/48] perf annotate-data: Track instructions with a this-cpu variable
Date:   Wed, 11 Oct 2023 20:51:09 -0700
Message-ID: <20231012035111.676789-47-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 1992ef20f71d..677dc01432d3 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -427,6 +427,37 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
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
@@ -490,14 +521,36 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
@@ -510,37 +563,20 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
2.42.0.655.g421f12c284-goog

