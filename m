Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651387E7599
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 01:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345627AbjKJAEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 19:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjKJADs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 19:03:48 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B05E49D7;
        Thu,  9 Nov 2023 16:01:29 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-2802d218242so1366347a91.1;
        Thu, 09 Nov 2023 16:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574489; x=1700179289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wLivHB+5XUGw6AKIAysW4dP2ru9/y+S3j/0jOvIeF8g=;
        b=Djc2Yho+skNKb7DRd2yQzJbbjaRFDJX1Y+jshUbx7oQFu8dq5z4NfZ6PsxhdndbiQy
         nRM+2ERZUFQK0xpOnqjMLN1KoVvqxe+mT2Us7U7lK1+VsA252+Dg7p0qNA4FNj41RwDp
         8O86yY+u9H6f1YpbHRvmg6TNzEfhzC3jkcKdfE7S4c27jehkZge71jAAQh3L0c9dphnN
         bG6qQLf6Ztfr4CdgyMpk5VD8zviQNnN8fwzSbFB4spjl3QTVMnKr/ddb+iVpy8ovUze/
         8GpUo6+EDO5l8w2F1CNyBzPL31YYw0Ob/bbVDyWJy/jkbD6akI5lQBIo3OvQ9Sm2gAIW
         eWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574489; x=1700179289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wLivHB+5XUGw6AKIAysW4dP2ru9/y+S3j/0jOvIeF8g=;
        b=X6Gb4WUPwI/4QzhoLEkSvKcHmf30fbD5goMQjEcUA3yP37wsirPDepfiPDsVdkXb3M
         Tou0hYOUgGX5KoyYOy1kYqV2gTlBqeyF7QBPYejgL1OtMKBjNBkJSFuPPVUoLZz+WOML
         OfLux9f1tFeBs7XWFchqRSbL6dz5YeaPFOvDauGL+AalF5++V+mGhvTxNritzyUM1+5w
         QR1J0qRFry9mCTtez4YQVsF+I8TR6F/y3DpkOLv85+0RIRA8KJYdzT60G/Z59f0Y42sG
         SBcN+wFho6QxrbnSHwzwtj5mqb4NIbZoYPW/78OMoenTU6JDZFyPcpGiEEvbvmoFoKkV
         8ZUg==
X-Gm-Message-State: AOJu0YxC1bpQ78jkA4UCBWvdmxF4hyiyHrevmEzv84+53+9vyq6hJhjY
        Zwc/HMfPdrmu7K9D5IgTGzk=
X-Google-Smtp-Source: AGHT+IGI0onRDTRqBWLn2qrikHQpQrZY7STqD8HXdY0ipQQSrtg4YCTaSEqiHGUeie+tWWzWOK/dUw==
X-Received: by 2002:a17:90b:38c4:b0:27c:fc2a:a178 with SMTP id nn4-20020a17090b38c400b0027cfc2aa178mr3512366pjb.9.1699574488843;
        Thu, 09 Nov 2023 16:01:28 -0800 (PST)
Received: from bangji.corp.google.com ([2620:15c:2c0:5:d45c:ae16:d959:a5f1])
        by smtp.gmail.com with ESMTPSA id k32-20020a17090a4ca300b002635db431a0sm371312pjh.45.2023.11.09.16.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 16:01:28 -0800 (PST)
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
Subject: [PATCH 47/52] perf annotate-data: Implement instruction tracking
Date:   Thu,  9 Nov 2023 16:00:06 -0800
Message-ID: <20231110000012.3538610-48-namhyung@kernel.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231110000012.3538610-1-namhyung@kernel.org>
References: <20231110000012.3538610-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If it failed to find a variable for the location directly, it might be
due to a missing variable in the source code.  For example, accessing
pointer variables in a chain can result in the case like below:

  struct foo *foo = ...;

  int i = foo->bar->baz;

The DWARF debug information is created for each variable so it'd have
one for 'foo'.  But there's no variable for 'foo->bar' and then it
cannot know the type of 'bar' and 'baz'.

The above source code can be compiled to the follow x86 instructions:

  mov  0x8(%rax), %rcx
  mov  0x4(%rcx), %rdx   <=== PMU sample
  mov  %rdx, -4(%rbp)

Let's say 'foo' is located in the %rax and it has a pointer to struct
foo.  But perf sample is captured in the second instruction and there
is no variable or type info for the %rcx.

It'd be great if compiler could generate debug info for %rcx, but we
should handle it on our side.  So this patch implements the logic to
iterate instructions and update the type table for each location.

As it already collected a list of scopes including the target
instruction, we can use it to construct the type table smartly.

  +----------------  scope[0] subprogram
  |
  | +--------------  scope[1] lexical_block
  | |
  | | +------------  scope[2] inlined_subroutine
  | | |
  | | | +----------  scope[3] inlined_subroutine
  | | | |
  | | | | +--------  scope[4] lexical_block
  | | | | |
  | | | | |     ***  target instruction
  ...

Image the target instruction has 5 scopes, each scope will have its own
variables and parameters.  Then it can start with the innermost scope
(4).  So it'd search the shortest path from the start of scope[4] to
the target address and build a list of basic blocks.  Then it iterates
the basic blocks with the variables in the scope and update the table.
If it finds a type at the target instruction, then returns it.

Otherwise, it moves to the upper scope[3].  Now it'd search the shortest
path from the start of scope[3] to the start of scope[4].  Then connect
it to the existing basic block list.  Then it'd iterate the blocks with
variables for both scopes.  It can repeat this until it finds a type at
the target instruction or reaches to the top scope[0].

As the basic blocks contain the shortest path, it won't worry about
branches and can update the table simply.

With this change, the stat now looks like below:

  Annotate data type stats:
  total 294, ok 185 (62.9%), bad 109 (37.1%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          27 : no_var
          13 : no_typeinfo
           7 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 232 ++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 54791dfc6244..56dfbddb53d2 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -596,6 +596,231 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
 	/* Case 4. memory to memory transfers (not handled for now) */
 }
 
+/* Prepend this_list to full_list, removing duplicate disasm line */
+static void prepend_basic_blocks(struct list_head *this_blocks,
+				 struct list_head *full_blocks)
+{
+	struct annotated_basic_block *first_bb, *last_bb;
+
+	last_bb = list_last_entry(this_blocks, typeof(*last_bb), list);
+	first_bb = list_first_entry(full_blocks, typeof(*first_bb), list);
+
+	if (list_empty(full_blocks))
+		goto out;
+
+	if (last_bb->end != first_bb->begin) {
+		pr_debug("prepend basic blocks: mismatched disasm line %lx -> %lx\n",
+			 last_bb->end->al.offset, first_bb->begin->al.offset);
+		goto out;
+	}
+
+	/* Is the basic block have only one disasm_line? */
+	if (last_bb->begin == last_bb->end) {
+		list_del(&last_bb->list);
+		free(last_bb);
+		goto out;
+	}
+
+	last_bb->end = list_prev_entry(last_bb->end, al.node);
+
+out:
+	list_splice(this_blocks, full_blocks);
+}
+
+static void delete_basic_blocks(struct list_head *basic_blocks)
+{
+	struct annotated_basic_block *bb, *tmp;
+
+	list_for_each_entry_safe(bb, tmp, basic_blocks, list) {
+		list_del(&bb->list);
+		free(bb);
+	}
+}
+
+/* Make sure all variables have a valid start address */
+static void fixup_var_address(struct die_var_type *var_types, u64 addr)
+{
+	while (var_types) {
+		/*
+		 * Some variables have no address range meaning it's always
+		 * available in the whole scope.  Let's adjust the start
+		 * address to the start of the scope.
+		 */
+		if (var_types->addr == 0)
+			var_types->addr = addr;
+
+		var_types = var_types->next;
+	}
+}
+
+static void delete_var_types(struct die_var_type *var_types)
+{
+	while (var_types) {
+		struct die_var_type *next = var_types->next;
+
+		free(var_types);
+		var_types = next;
+	}
+}
+
+/* It's at the target address, check if it has a matching type */
+static bool find_matching_type(struct type_state *state,
+			       struct data_loc_info *dloc, int reg,
+			       Dwarf_Die *type_die)
+{
+	Dwarf_Word size;
+
+	if (state->regs[reg].ok) {
+		int tag = dwarf_tag(&state->regs[reg].type);
+
+		/*
+		 * Normal registers should hold a pointer (or array) to
+		 * dereference a memory location.
+		 */
+		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type)
+			return false;
+
+		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
+			return false;
+
+		dloc->type_offset = dloc->op->offset;
+
+		/* Get the size of the actual type */
+		if (dwarf_aggregate_size(type_die, &size) < 0 ||
+		    (unsigned)dloc->type_offset >= size)
+			return false;
+
+		return true;
+	}
+
+	if (reg == dloc->fbreg) {
+		struct type_state_stack *stack;
+
+		stack = find_stack_state(state, dloc->type_offset);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= stack->offset;
+		return true;
+	}
+
+	if (dloc->fb_cfa) {
+		struct type_state_stack *stack;
+		u64 pc = map__rip_2objdump(dloc->ms->map, dloc->ip);
+		int fbreg, fboff;
+
+		if (die_get_cfa(dloc->di->dbg, pc, &fbreg, &fboff) < 0)
+			fbreg = -1;
+
+		if (reg != fbreg)
+			return false;
+
+		stack = find_stack_state(state, dloc->type_offset - fboff);
+		if (stack == NULL)
+			return false;
+
+		*type_die = stack->type;
+		/* Update the type offset from the start of slot */
+		dloc->type_offset -= fboff + stack->offset;
+		return true;
+	}
+
+	return false;
+}
+
+/* Iterate instructions in basic blocks and update type table */
+static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
+				struct list_head *basic_blocks,
+				struct die_var_type *var_types,
+				Dwarf_Die *cu_die, Dwarf_Die *type_die)
+{
+	struct type_state state;
+	struct symbol *sym = dloc->ms->sym;
+	struct annotation *notes = symbol__annotation(sym);
+	struct annotated_basic_block *bb;
+	bool found = false;
+
+	init_type_state(&state, dloc->arch);
+
+	list_for_each_entry(bb, basic_blocks, list) {
+		struct disasm_line *dl = bb->begin;
+
+		list_for_each_entry_from(dl, &notes->src->source, al.node) {
+			u64 this_ip = sym->start + dl->al.offset;
+			u64 addr = map__rip_2objdump(dloc->ms->map, this_ip);
+
+			/* Update variable type at this address */
+			update_var_state(&state, dloc, addr, var_types);
+
+			if (this_ip == dloc->ip) {
+				found = find_matching_type(&state, dloc, reg,
+							   type_die);
+				goto out;
+			}
+
+			/* Update type table after processing the instruction */
+			update_insn_state(&state, dloc, cu_die, dl);
+			if (dl == bb->end)
+				break;
+		}
+	}
+
+out:
+	exit_type_state(&state);
+	return found;
+}
+
+/*
+ * Construct a list of basic blocks for each scope with variables and try to find
+ * the data type by updating a type state table through instructions.
+ */
+static int find_data_type_block(struct data_loc_info *dloc, int reg,
+				Dwarf_Die *cu_die, Dwarf_Die *scopes,
+				int nr_scopes, Dwarf_Die *type_die)
+{
+	LIST_HEAD(basic_blocks);
+	struct die_var_type *var_types = NULL;
+	u64 src_ip, dst_ip;
+	int ret = -1;
+
+	dst_ip = dloc->ip;
+	for (int i = nr_scopes - 1; i >= 0; i--) {
+		Dwarf_Addr base, start, end;
+		LIST_HEAD(this_blocks);
+
+		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
+			break;
+
+		src_ip = map__objdump_2rip(dloc->ms->map, start);
+
+		/* Get basic blocks for this scope */
+		if (annotate_get_basic_blocks(dloc->ms->sym, src_ip, dst_ip,
+					      &this_blocks) < 0)
+			continue;
+		prepend_basic_blocks(&this_blocks, &basic_blocks);
+
+		/* Get variable info for this scope and add to var_types list */
+		die_collect_vars(&scopes[i], &var_types);
+		fixup_var_address(var_types, start);
+
+		/* Find from start of this scope to the target instruction */
+		if (find_data_type_insn(dloc, reg, &basic_blocks, var_types,
+					cu_die, type_die)) {
+			ret = 0;
+			break;
+		}
+
+		/* Go up to the next scope and find blocks to the start */
+		dst_ip = src_ip;
+	}
+
+	delete_basic_blocks(&basic_blocks);
+	delete_var_types(var_types);
+	return ret;
+}
+
 /* The result will be saved in @type_die */
 static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 {
@@ -696,6 +921,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto out;
 	}
 
+	if (reg != DWARF_REG_PC) {
+		ret = find_data_type_block(dloc, reg, &cu_die, scopes,
+					   nr_scopes, type_die);
+		if (ret == 0)
+			goto out;
+	}
+
 	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
 		reg = loc->reg2;
 		goto retry;
-- 
2.42.0.869.gea05f2083d-goog

