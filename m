Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CCFD7C638C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 05:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377559AbjJLDzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 23:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbjJLDyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 23:54:00 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0AC2F3;
        Wed, 11 Oct 2023 20:52:10 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1c77449a6daso4675125ad.0;
        Wed, 11 Oct 2023 20:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082730; x=1697687530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VcGuty2WfdJlpv/evrY/Aeps8iBoToI2rEN24hSWRo=;
        b=IUU+5ywP6Pz6bPSwet+E9QBRdVO63wof5vkhnFIlGS28oD4G+ojCgBFPw18YqR2/Hy
         4n1g2MLsyiepo4zChhzxXFwxMUFj++s1VCiiszVKoxf/p7rQ2PXe6uYZjZfGirTotglH
         0mQnQtKxJRyxmddk12Y0YNK4jgHDsnfKWCj6K+VAyKtv7Tb75fK/+ZS+tQrZ5TblfWg3
         tdPKkquZCE2/2YLuqtopYUbX6JOLIcqfDmIQNFhxjtLMgfVCIA5ut+/cWH8HC8PyX4GT
         aIIgVpSBnGNMEpKM9hTgXbMtUtomOaJ3KfVhYisH83nS0ODhb9GJsOx9dCQgidgk0zQ6
         EikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082730; x=1697687530;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5VcGuty2WfdJlpv/evrY/Aeps8iBoToI2rEN24hSWRo=;
        b=A2ujDGqJ/SaW42eIRB0PmNLMNmMsoDt7q8tzbMn1sY3kAr9a/nktEnDnOrTGz3l+H8
         zDUJqfzzh8my2SeIA62MEQN2nzon7ssqneo2twwMNO+oA0RTMK10dNaDJwtdGS7h8Qny
         7XIcn91pS3eSiNWOhV0tnlbqbrKpj1HF0CftHMuQlgkOnwBJeJGFf77l8q9AzX9pqicH
         SFXM60JSJ9XIy2ls7Expn1/I+8/L0I/R16aWbbMvt5VKE7nH3xB/Ndhh6DeIh+69RAf7
         Wt+kNGjuP17hgrfmYEVoepPqyvSOqv1ozjpdlQapWjW7DJPHy1sPqCWum88BlG98aD7J
         KbYw==
X-Gm-Message-State: AOJu0YwfXvdT6qePP1oVp9l9BWzWEglIJ6uAvLHPNOuXUItoalLdJ4En
        HEE58mi8jXReFSvM5qJ+RIo=
X-Google-Smtp-Source: AGHT+IGT3WFYEjSubss5PGmOYJDuZC40Zfope7bEXLRaBQ2TXmX/J4Iu7M+wJgY0C3Vm3gJQi23cyg==
X-Received: by 2002:a17:902:d30d:b0:1c5:ecff:1bc7 with SMTP id b13-20020a170902d30d00b001c5ecff1bc7mr23183988plc.4.1697082729721;
        Wed, 11 Oct 2023 20:52:09 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:09 -0700 (PDT)
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
Subject: [PATCH 42/48] perf annotate-data: Handle call instructions
Date:   Wed, 11 Oct 2023 20:51:05 -0700
Message-ID: <20231012035111.676789-43-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
In-Reply-To: <20231012035111.676789-1-namhyung@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 37135698a5c8..f3f85cb9ac00 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -40,10 +40,14 @@ struct annotated_data_type stackop_type = {
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
 
-/* Type information in a register, valid when ok is true */
+/*
+ * Type information in a register, valid when ok is true.
+ * The scratch registers are invalidated after a function call.
+ */
 struct type_state_reg {
 	Dwarf_Die type;
 	bool ok;
+	bool scratch;
 };
 
 /* Type information in a stack location, dynamically allocated */
@@ -67,6 +71,7 @@ struct type_state_stack {
 struct type_state {
 	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
 	struct list_head stack_vars;
+	int ret_reg;
 };
 
 static bool has_reg_type(struct type_state *state, int reg)
@@ -74,10 +79,23 @@ static bool has_reg_type(struct type_state *state, int reg)
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
@@ -434,6 +452,29 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
2.42.0.655.g421f12c284-goog

