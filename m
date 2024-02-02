Return-Path: <linux-kernel+bounces-50639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CB59847C00
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116D21F2AB4C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13CF812D75B;
	Fri,  2 Feb 2024 22:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWXDaAq3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E898812C7FF;
	Fri,  2 Feb 2024 22:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911506; cv=none; b=E8iJ/pWTI6ta3LsYRFuI2RBIAG4NBDVpLA5Zq54qgQf15HS3qIVboqhoPnAa+n2u43v1TPhpnYxHQxUsCBM8uqwEUt6IzEIx+RXww8mvdtYVDg1h1v+hmsdCxYlsX7yZTTTOZuyVMAHxPGVQ6VIM5CHkxoCm9Ltf0kKPqgqER0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911506; c=relaxed/simple;
	bh=ce3rdgKItQ/zl8//pGAPQd7MlZR2haA80pcRv2ilW2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gfErMxpGyV6ockScYDHtXwXz4ySKmHUkwz/xHf2cBRsnE1O5pH0FZ3ykfDIw3eK8X05Yr1DvBomlaaCPIBz5KYRuQ8zLRqo0fvtsc3T328YlGbdP6jblPMBK8BcIbjXn1ehab7Vxk+fUcOA3+JkaGsFf5k8elPLrRq8H7o3Pepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWXDaAq3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3359C433B1;
	Fri,  2 Feb 2024 22:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911505;
	bh=ce3rdgKItQ/zl8//pGAPQd7MlZR2haA80pcRv2ilW2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZWXDaAq3lZqppAgyOh4Y3pStZ3mdYGfpPsEJJjGxql3nJoTBIbl/IDPxrJaS3+MiX
	 spU1RNeDoN8cW/1sXhm8z5LC2IKDRLhoQsiEfcSfp4/WbbFZ5GB5gtlOlaPcDAY98c
	 Vu/CpQfBVFwKLTIZB6UbKBuMTGRKcq82aNXgKjo7szSf88VCZPwngwTssaYwH/vqha
	 MIDF3ck5Y/loZG1exTwtuw7vr7EcB6sMp/8PnY/x/HN0C2rfo3XKoDSE9to65wHs9w
	 OtkOdm9gwyyHhL4evvNcCu+A8elPsKDd+7HsWNJM7I7KGVUtJBfVtviBIJIlfPrIay
	 IPLnduKCT3R4g==
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
Subject: [PATCH 06/14] perf annotate-data: Maintain variable type info
Date: Fri,  2 Feb 2024 14:04:51 -0800
Message-ID: <20240202220459.527138-7-namhyung@kernel.org>
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
index b8e60c42af8c..f8768c224bcc 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -23,6 +23,57 @@
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
@@ -238,6 +289,110 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
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
2.43.0.594.gd9cf4e227d-goog


