Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C60A37E7595
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345567AbjKJAEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345688AbjKJAD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:26 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8087555B6;
        Thu,  9 Nov 2023 16:01:23 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5bd6ac9833fso1121352a12.0;
        Thu, 09 Nov 2023 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574483; x=1700179283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kvTfv482Q4PYRjTpfYUAW6Q8pGRZjJf+S0DM/gjie/M=;
        b=goKoS3+hEtjNEmwDoegPLNieykU8JjffpOH06hD2FsqPQGlUtZC5fLBwHWs0mGwlQq
         miISCxD20AaU0X69+TgDviwyRQD8nyXUb97ewKtGppxttK2gQRF+7LFraPb+MMsteD2a
         jzFxkpGnOH0xJICANwiU4rO37K9sb4h6E/Br2q/VQrNr+XkBhHOwcXPTcJXevKVeaWgG
         UkFT72H4usOwDfQJtVJ5Ox4gGv6YQjVk7BXXYonuru/UJA89q/9b9DrfJa1Vw59cApXQ
         d1P8XrHvr3UomIU0nzsUfaLNQo3h1hnwcYmGIy8BP2yEheEgtE3w/6v4Auo4J71KRhFK
         VOGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574483; x=1700179283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kvTfv482Q4PYRjTpfYUAW6Q8pGRZjJf+S0DM/gjie/M=;
        b=hcum198OQalSh4LH3VDWw5mQv/k1HTdIBSRHrxSJkSLvpjsLRjpzOM7tgqBd/QqOP+
         FEX/P91JRNiR9xpQb/SD8kGqA9ijUMHppMmfmRLW7V3mI3c8IEyj5P5lSZrjpEp863mI
         yHJZtFwSobR38+f4PLBCVI+Uz2/My1AgK6kTIkjeWkMrViOnJX7ResmGmXwpKyJn3Nq1
         a4hxqK9TwOKsOmwVZEBiFz7YA8bTpOpRyDf+7TKGlMhN9epFeKekTEJ9ewsq7LqGA4Ev
         /C3RgYgdadlWirkvD2PRp2ucLd80rgEJDO/dx8Qfbsh20WSkxowaTeuJ0IytCduxE6HE
         CX1A==
X-Gm-Message-State: AOJu0YxuiarsaI5Ams+NP8RrxU9tKakACP4OiUDpY+NQNv5xsNp/9t1S
        RO3eqACzSPgEyH2mQE5QW0o=
X-Google-Smtp-Source: AGHT+IFKV9nmHh39ZaEncpP2mUU/qTToe7W832z98mIHNn/T/TPaAaEQU0o6985aaVIeiGICVa5IzA==
X-Received: by 2002:a17:90b:1a91:b0:27d:114e:d4a3 with SMTP id ng17-20020a17090b1a9100b0027d114ed4a3mr3003610pjb.14.1699574482871;
        Thu, 09 Nov 2023 16:01:22 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:22 -0800 (PST)
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
Subject: [PATCH 43/52] perf annotate-data: Maintain variable type info
Date:   Thu,  9 Nov 2023 16:00:02 -0800
Message-ID: <20231110000012.3538610-44-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As it collected basic block and variable information in each scope, it
now can build a state table to find matching variable at the location.

The struct type_state is to keep the type info saved in each register
and stack slot.  The update_var_state() updates the table when it finds
variables in the current address.  It expects die_collect_vars() filled
a list of variables with type info and starting address.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 155 ++++++++++++++++++++++++++++++++
 tools/perf/util/annotate-data.h |  29 ++++++
 tools/perf/util/dwarf-aux.c     |   4 +
 3 files changed, 188 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c61f5b5b6adc..438d6234020b 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -22,6 +22,57 @@
 #include "symbol.h"
 #include "symbol_conf.h"
 
+/* Type information in a register, valid when ok is true */
+struct type_state_reg {
+	Dwarf_Die type;
+	bool ok;
+	bool scratch;
+};
+
+/* Type information in a stack location, dynamically allocated */
+struct type_state_stack {
+	struct list_head list;
+	Dwarf_Die type;
+	int offset;
+	int size;
+	bool compound;
+};
+
+/* FIXME: This should be arch-dependent */
+#define TYPE_STATE_MAX_REGS  16
+
+/*
+ * State table to maintain type info in each register and stack location.
+ * It'll be updated when new variable is allocated or type info is moved
+ * to a new location (register or stack).  As it'd be used with the
+ * shortest path of basic blocks, it only maintains a single table.
+ */
+struct type_state {
+	struct type_state_reg regs[TYPE_STATE_MAX_REGS];
+	struct list_head stack_vars;
+};
+
+static bool has_reg_type(struct type_state *state, int reg)
+{
+	return (unsigned)reg < ARRAY_SIZE(state->regs);
+}
+
+void init_type_state(struct type_state *state, struct arch *arch __maybe_unused)
+{
+	memset(state, 0, sizeof(*state));
+	INIT_LIST_HEAD(&state->stack_vars);
+}
+
+void exit_type_state(struct type_state *state)
+{
+	struct type_state_stack *stack, *tmp;
+
+	list_for_each_entry_safe(stack, tmp, &state->stack_vars, list) {
+		list_del(&stack->list);
+		free(stack);
+	}
+}
+
 /*
  * Compare type name and size to maintain them in a tree.
  * I'm not sure if DWARF would have information of a single type in many
@@ -237,6 +288,110 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
 	return 0;
 }
 
+static struct type_state_stack *find_stack_state(struct type_state *state,
+						 int offset)
+{
+	struct type_state_stack *stack;
+
+	list_for_each_entry(stack, &state->stack_vars, list) {
+		if (offset == stack->offset)
+			return stack;
+
+		if (stack->compound && stack->offset < offset &&
+		    offset < stack->offset + stack->size)
+			return stack;
+	}
+	return NULL;
+}
+
+static void set_stack_state(struct type_state_stack *stack, int offset,
+			    Dwarf_Die *type_die)
+{
+	int tag;
+	Dwarf_Word size;
+
+	if (dwarf_aggregate_size(type_die, &size) < 0)
+		size = 0;
+
+	tag = dwarf_tag(type_die);
+
+	stack->type = *type_die;
+	stack->size = size;
+	stack->offset = offset;
+
+	switch (tag) {
+	case DW_TAG_structure_type:
+	case DW_TAG_union_type:
+		stack->compound = true;
+		break;
+	default:
+		stack->compound = false;
+		break;
+	}
+}
+
+static struct type_state_stack *findnew_stack_state(struct type_state *state,
+						    int offset, Dwarf_Die *type_die)
+{
+	struct type_state_stack *stack = find_stack_state(state, offset);
+
+	if (stack) {
+		set_stack_state(stack, offset, type_die);
+		return stack;
+	}
+
+	stack = malloc(sizeof(*stack));
+	if (stack) {
+		set_stack_state(stack, offset, type_die);
+		list_add(&stack->list, &state->stack_vars);
+	}
+	return stack;
+}
+
+/**
+ * update_var_state - Update type state using given variables
+ * @state: type state table
+ * @dloc: data location info
+ * @addr: instruction address to update
+ * @var_types: list of variables with type info
+ *
+ * This function fills the @state table using @var_types info.  Each variable
+ * is used only at the given location and updates an entry in the table.
+ */
+void update_var_state(struct type_state *state, struct data_loc_info *dloc,
+		      u64 addr, struct die_var_type *var_types)
+{
+	Dwarf_Die mem_die;
+	struct die_var_type *var;
+	int fbreg = dloc->fbreg;
+	int fb_offset = 0;
+
+	if (dloc->fb_cfa) {
+		if (die_get_cfa(dloc->di->dbg, addr, &fbreg, &fb_offset) < 0)
+			fbreg = -1;
+	}
+
+	for (var = var_types; var != NULL; var = var->next) {
+		if (var->addr != addr)
+			continue;
+		/* Get the type DIE using the offset */
+		if (!dwarf_offdie(dloc->di->dbg, var->die_off, &mem_die))
+			continue;
+
+		if (var->reg == DWARF_REG_FB) {
+			findnew_stack_state(state, var->offset, &mem_die);
+		} else if (var->reg == fbreg) {
+			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
+		} else if (has_reg_type(state, var->reg)) {
+			struct type_state_reg *reg;
+
+			reg = &state->regs[var->reg];
+			reg->type = mem_die;
+			reg->ok = true;
+		}
+	}
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/annotate-data.h b/tools/perf/util/annotate-data.h
index ad6493ea2c8e..7fbb9eb2e96f 100644
--- a/tools/perf/util/annotate-data.h
+++ b/tools/perf/util/annotate-data.h
@@ -8,9 +8,12 @@
 #include <linux/types.h>
 
 struct annotated_op_loc;
+struct arch;
 struct debuginfo;
+struct die_var_type;
 struct evsel;
 struct map_symbol;
+struct type_state;
 
 /**
  * struct annotated_member - Type of member field
@@ -146,6 +149,16 @@ int annotated_data_type__update_samples(struct annotated_data_type *adt,
 /* Release all data type information in the tree */
 void annotated_data_type__tree_delete(struct rb_root *root);
 
+/* Initialize type state table */
+void init_type_state(struct type_state *state, struct arch *arch);
+
+/* Destroy type state table */
+void exit_type_state(struct type_state *state);
+
+/* Update type state table using variables */
+void update_var_state(struct type_state *state, struct data_loc_info *dloc,
+		      u64 addr, struct die_var_type *var_types);
+
 #else /* HAVE_DWARF_SUPPORT */
 
 static inline struct annotated_data_type *
@@ -168,6 +181,22 @@ static inline void annotated_data_type__tree_delete(struct rb_root *root __maybe
 {
 }
 
+static inline void init_type_state(struct type_state *state __maybe_unused,
+				   struct arch *arch __maybe_unused)
+{
+}
+
+static inline void exit_type_state(struct type_state *state __maybe_unused)
+{
+}
+
+static inline void update_var_state(struct type_state *state __maybe_unused,
+				    struct data_loc_info *dloc __maybe_unused,
+				    u64 addr __maybe_unused,
+				    struct die_var_type *var_types __maybe_unused)
+{
+}
+
 #endif /* HAVE_DWARF_SUPPORT */
 
 #endif /* _PERF_ANNOTATE_DATA_H */
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 39851ff1d5c4..f88a8fb4a350 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
+#include "dwarf-regs.h"
 #include "strbuf.h"
 #include "string2.h"
 
@@ -1147,6 +1148,8 @@ static int reg_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 	case DW_OP_bregx:
 		return op->number;
+	case DW_OP_fbreg:
+		return DWARF_REG_FB;
 	default:
 		break;
 	}
@@ -1160,6 +1163,7 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 		return 0;
 	case DW_OP_breg0 ... DW_OP_breg31:
+	case DW_OP_fbreg:
 		return op->number;
 	case DW_OP_bregx:
 		return op->number2;
-- 
2.42.0.869.gea05f2083d-goog

