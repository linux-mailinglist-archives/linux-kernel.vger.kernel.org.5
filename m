Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62187C63A5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377051AbjJLECK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235367AbjJLEBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:01:33 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 205E41722;
        Wed, 11 Oct 2023 20:52:06 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1c735473d1aso4399105ad.1;
        Wed, 11 Oct 2023 20:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697082726; x=1697687526; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mLaKLGWSqUFuR6JldirEmidqSxeEteg7NHTV+cCNTLU=;
        b=jT4qk5U+udJI7tGJANiXTTxyV6zNByGvZ4ixj4F7DJOHfix8xRJtU2Yj0XGFbfTXOi
         OXo6sAMCgDi6i8pSmjmXif5dgA0ahVbrheG10wBChUF28ipOPknda5usB+1lqgONc719
         sxHYF93P4vtCxnMjj7RfW0ES9N6J0ZJj4XGOmDhrrSUKZrtMVWzARaJ/NRWzEuTGGEzZ
         wpCp494QvD/4xORlt5KpQmY/f6yXF8WGgkhy6hFobG0wWOvZatmwm6bM1uvrZGziUQ26
         hae664zpJlKRZb3pGiZqxJi4sUyT4GHHUVzYehm5doR70XJrh5r8QchtPx1xcgYwN2Kz
         dQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697082726; x=1697687526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mLaKLGWSqUFuR6JldirEmidqSxeEteg7NHTV+cCNTLU=;
        b=neu83P1LXaeMKzwC9cR8rCKSv2F8xRmxWvbZmDiDauQaGCLN6SD3KrDV+NtO5xCRtf
         aUHIhUpl8nzZyiyHC1Hmn/MKChE6f+Hpm0LuF3K7lB9waoAlH0Yjlve4kz0oXhqk2swN
         OycMSE366sVSevFG/ceDCKh9O60r1dlIgvLpCJjYNQGEw5n8ALD9hamRSw4yZzAatr0A
         LXbRpC+Hmcf0jvoFHxbHwmN/BQjd3mQfCioZaSsg+MKxXD2IClHogr1S4ERbPD3aiRXl
         NsFnKGAD+PIAQB1j7xfs5wG6zAl2mAhEFKB9r8O9lv7iF+P6JpR3PFbT3773U9q3pj7o
         nmgw==
X-Gm-Message-State: AOJu0YyQgHGUTr7bErPQBygb8/loWPKXSXF+mwx9lwazsjOecblnab0N
        YjTswXi8OO5iim16kOJZuBM=
X-Google-Smtp-Source: AGHT+IEBHcceyfL5BN3w/HlZUuDeOYJc3lMOzNXoXFfYjdvl7FwJAxPoxquIRRRn/JdbKrn6X8LlUQ==
X-Received: by 2002:a17:902:ec85:b0:1c4:749e:e725 with SMTP id x5-20020a170902ec8500b001c4749ee725mr23136550plg.0.1697082725805;
        Wed, 11 Oct 2023 20:52:05 -0700 (PDT)
Received: from bangji.hsd1.ca.comcast.net ([2601:647:6780:42e0:b1b9:d490:2f5e:be06])
        by smtp.gmail.com with ESMTPSA id w8-20020a170902d70800b001bc18e579aesm711374ply.101.2023.10.11.20.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 20:52:05 -0700 (PDT)
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
Subject: [PATCH 39/48] perf annotate-data: Maintain variable type info
Date:   Wed, 11 Oct 2023 20:51:02 -0700
Message-ID: <20231012035111.676789-40-namhyung@kernel.org>
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
index 90793cbb6aa0..a88d2cdafa08 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -40,6 +40,57 @@ struct annotated_data_type stackop_type = {
 /* Data type collection debug statistics */
 struct annotated_data_stat ann_data_stat;
 
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
@@ -255,6 +306,110 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
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
index 5ec895e0a069..923e974ad18e 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
+#include "dwarf-regs.h"
 #include "strbuf.h"
 #include "string2.h"
 
@@ -1490,6 +1491,8 @@ static int reg_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 	case DW_OP_bregx:
 		return op->number;
+	case DW_OP_fbreg:
+		return DWARF_REG_FB;
 	default:
 		break;
 	}
@@ -1503,6 +1506,7 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 		return 0;
 	case DW_OP_breg0 ... DW_OP_breg31:
+	case DW_OP_fbreg:
 		return op->number;
 	case DW_OP_bregx:
 		return op->number2;
-- 
2.42.0.655.g421f12c284-goog

