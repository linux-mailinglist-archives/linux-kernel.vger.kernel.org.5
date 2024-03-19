Return-Path: <linux-kernel+bounces-107035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48987F6E9
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3279A282598
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6645E7E76B;
	Tue, 19 Mar 2024 05:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F8WlFryv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7137E11A;
	Tue, 19 Mar 2024 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827483; cv=none; b=bW7I/ISBKCJQ54STIbytHHGKacG3Cu4sMjBGjEJyB97RO+CtRK7bvMYbJXAu+G0Ay+xGELq5JDHoVpACyInGHiXtKpXXUF2xBhignemtA/yEcd3xTG+aCNiD20jQoOy/uq0s7JfA9JTe5iJ21WV3PUxPd1afIgsczFt+OxCGJZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827483; c=relaxed/simple;
	bh=fhNxtapKIkDbH8Uy3IBe7yLRd7fJcDuZbr6w/rFDzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAJLxqCyZmYfqLCNsNrVtS5uZ0UZabDaedDafZC+Jn/YVEDHu+O+OtP9GjFDokjJkwSL4Ctv97AUU8zugB0AvJ45zF93buq0A22EsYwrmOZSqfBQ4HL1rVBtg/AsCHGCBYHmsWahzhqV3pyzJGNXTJbKxvaBPS/2rfR6hFvAUYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F8WlFryv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800F0C4166B;
	Tue, 19 Mar 2024 05:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827483;
	bh=fhNxtapKIkDbH8Uy3IBe7yLRd7fJcDuZbr6w/rFDzOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F8WlFryvloQB6nFyuVKy8qHQRe0r09HTuv2hYho3RoicNQa0+e5KpMKAxaFTHmq7K
	 jNSDzniIqHRpdxZBX/c0cslX0GeBqiLnOEwu4jpx3NTinJtj8hY2E3eJFNWPy4PuC0
	 UoSBXA9liL+q5Orv3Df0S0jHaFJxhsBXSCWO19OmTEFASWX47HtMrFLJveCozdbRGF
	 44XunPCDniU4rCLU6bZx9NuN6ym2XN3jF2zQgMD9ZpVaE+cgcF2p69SV6hPjNQWhVD
	 vxHX3FQRQuNIkxYCkJE0iYf9Di5lPTQHMCj42BT9VXy1HFgME4uQxNOQwH/5v0uotr
	 /3LEaDw1vvXNQ==
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
Subject: [PATCH 09/23] perf annotate-data: Maintain variable type info
Date: Mon, 18 Mar 2024 22:51:01 -0700
Message-ID: <20240319055115.4063940-10-namhyung@kernel.org>
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

As it collected basic block and variable information in each scope, it
now can build a state table to find matching variable at the location.

The struct type_state is to keep the type info saved in each register
and stack slot.  The update_var_state() updates the table when it finds
variables in the current address.  It expects die_collect_vars() filled
a list of variables with type info and starting address.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 173 ++++++++++++++++++++++++++++++++
 tools/perf/util/dwarf-aux.c     |   4 +
 2 files changed, 177 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f482ccfdaa91..8eaa06f1cee5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -46,6 +46,62 @@ static void pr_debug_type_name(Dwarf_Die *die)
 	free(str);
 }
 
+/* Type information in a register, valid when ok is true */
+struct type_state_reg {
+	Dwarf_Die type;
+	bool ok;
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
+/* These declarations will be remove once they are changed to static */
+void init_type_state(struct type_state *state, struct arch *arch __maybe_unused);
+void exit_type_state(struct type_state *state);
+void update_var_state(struct type_state *state, struct data_loc_info *dloc,
+		      u64 addr, u64 insn_offset, struct die_var_type *var_types);
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
@@ -262,6 +318,123 @@ static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
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
+ * @addr: instruction address to match with variable
+ * @insn_offset: instruction offset (for debug)
+ * @var_types: list of variables with type info
+ *
+ * This function fills the @state table using @var_types info.  Each variable
+ * is used only at the given location and updates an entry in the table.
+ */
+void update_var_state(struct type_state *state, struct data_loc_info *dloc,
+		      u64 addr, u64 insn_offset, struct die_var_type *var_types)
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
+
+			pr_debug_dtp("var [%"PRIx64"] -%#x(stack) type=",
+				     insn_offset, -var->offset);
+			pr_debug_type_name(&mem_die);
+		} else if (var->reg == fbreg) {
+			findnew_stack_state(state, var->offset - fb_offset, &mem_die);
+
+			pr_debug_dtp("var [%"PRIx64"] -%#x(stack) type=",
+				     insn_offset, -var->offset + fb_offset);
+			pr_debug_type_name(&mem_die);
+		} else if (has_reg_type(state, var->reg) && var->offset == 0) {
+			struct type_state_reg *reg;
+
+			reg = &state->regs[var->reg];
+			reg->type = mem_die;
+			reg->ok = true;
+
+			pr_debug_dtp("var [%"PRIx64"] reg%d type=",
+				     insn_offset, var->reg);
+			pr_debug_type_name(&mem_die);
+		}
+	}
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 9080119a258c..41dbbb25b256 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -9,6 +9,7 @@
 #include <stdlib.h>
 #include "debug.h"
 #include "dwarf-aux.h"
+#include "dwarf-regs.h"
 #include "strbuf.h"
 #include "string2.h"
 
@@ -1190,6 +1191,8 @@ static int reg_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 	case DW_OP_bregx:
 		return op->number;
+	case DW_OP_fbreg:
+		return DWARF_REG_FB;
 	default:
 		break;
 	}
@@ -1203,6 +1206,7 @@ static int offset_from_dwarf_op(Dwarf_Op *op)
 	case DW_OP_regx:
 		return 0;
 	case DW_OP_breg0 ... DW_OP_breg31:
+	case DW_OP_fbreg:
 		return op->number;
 	case DW_OP_bregx:
 		return op->number2;
-- 
2.44.0.291.gc1ea87d7ee-goog


