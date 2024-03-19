Return-Path: <linux-kernel+bounces-107049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3219B87F6F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8780B1F2182E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3448173C;
	Tue, 19 Mar 2024 05:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKSPRxKI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C107E811FF;
	Tue, 19 Mar 2024 05:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827491; cv=none; b=ETW6qY7MsCaRkM+vNnqGJOnuDz71E5LYcB25DmaSjbp5/qsg10fOG7ih2HlsmFsi/0C2bU740BVAfrILF7vkgR+2672VcYCYB0z2czl7JVSBZ+c9RL1Q2XVZuGl86vjxpSQKJlpfZ9X8Rm4DuFJQif6ZftBPbGJAYKUX5yAeQgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827491; c=relaxed/simple;
	bh=f0mkHRNlUfGGLDB2E7rhqWdLV4QOlURXTjK0Hu1VgTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gw3qKQRxGFbW43YBG+npqiW7RWC3jxZvcln5XDGgVFC5UjLW9sOrLdjemOvEQEIUGkaZxYGKBBrN9+YegFJJ8oBHvrRjV7LZqXFgAlQCNzp77I2VfUpASWBosBm2gmIEVQFMCW5slELpCPTXQMRrUn0mLfAtp+rIwlVlvK1ASAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKSPRxKI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31797C43390;
	Tue, 19 Mar 2024 05:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827491;
	bh=f0mkHRNlUfGGLDB2E7rhqWdLV4QOlURXTjK0Hu1VgTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YKSPRxKIml4/bAUNwcRs6ey1cie9/DKFrfy+I+UGDM6/T+iBL9P0Ivd6iH37xz836
	 kDFLEEt+LW1vTYND17xwDsGH41bXZV3WbYmMhYWQeJwTEVoF+dZ8TAZqkLBQqhLwav
	 UL8vGpyIO3fiaUOJdlJ26/koRZJFWH8x3BU/g+r3xr4yPO3d/FWex4QNzIm/GMX4r1
	 gPMPX6bbkXZU7s4102iaPBHtyrIQ6n9CQ8uMntsm8/m6tIEkX5b9G9y62x3iyYJUIb
	 k9P0wyJUIQ0o1dKurkTQ1m75U1gE7tG9tHlXwt2q75zV9SXD+zec+Tqa73xR/RMhst
	 AvphRzbgFo37g==
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
Subject: [PATCH 23/23] perf annotate-data: Do not retry for invalid types
Date: Mon, 18 Mar 2024 22:51:15 -0700
Message-ID: <20240319055115.4063940-24-namhyung@kernel.org>
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

In some cases, it was able to find a type or location info (for per-cpu
variable) but cannot match because of invalid offset or missing global
information.  In those cases, it's meaningless to go to the outer scope
and retry because there will be no additional information.

Let's change the return type of find_matching_type() and bail out if it
returns -1 for the cases.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 83 +++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 35 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4b3184b7c799..de035db9d9b4 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1115,10 +1115,15 @@ static void setup_stack_canary(struct data_loc_info *dloc)
 	}
 }
 
-/* It's at the target address, check if it has a matching type */
-static bool check_matching_type(struct type_state *state,
-				struct data_loc_info *dloc, int reg,
-				Dwarf_Die *cu_die, Dwarf_Die *type_die)
+/*
+ * It's at the target address, check if it has a matching type.
+ * It returns 1 if found, 0 if not or -1 if not found but no need to
+ * repeat the search.  The last case is for per-cpu variables which
+ * are similar to global variables and no additional info is needed.
+ */
+static int check_matching_type(struct type_state *state,
+			       struct data_loc_info *dloc, int reg,
+			       Dwarf_Die *cu_die, Dwarf_Die *type_die)
 {
 	Dwarf_Word size;
 	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
@@ -1137,20 +1142,20 @@ static bool check_matching_type(struct type_state *state,
 		 * dereference a memory location.
 		 */
 		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type)
-			return false;
+			return -1;
 
 		/* Remove the pointer and get the target type */
 		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
-			return false;
+			return -1;
 
 		dloc->type_offset = dloc->op->offset;
 
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
 		    (unsigned)dloc->type_offset >= size)
-			return false;
+			return -1;
 
-		return true;
+		return 1;
 	}
 
 	if (reg == dloc->fbreg) {
@@ -1160,18 +1165,18 @@ static bool check_matching_type(struct type_state *state,
 
 		stack = find_stack_state(state, dloc->type_offset);
 		if (stack == NULL)
-			return false;
+			return 0;
 
 		if (stack->kind == TSR_KIND_CANARY) {
 			setup_stack_canary(dloc);
-			return false;
+			return -1;
 		}
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= stack->offset;
 
-		return true;
+		return 1;
 	}
 
 	if (dloc->fb_cfa) {
@@ -1185,22 +1190,22 @@ static bool check_matching_type(struct type_state *state,
 			fbreg = -1;
 
 		if (reg != fbreg)
-			return false;
+			return 0;
 
 		stack = find_stack_state(state, dloc->type_offset - fboff);
 		if (stack == NULL)
-			return false;
+			return 0;
 
 		if (stack->kind == TSR_KIND_CANARY) {
 			setup_stack_canary(dloc);
-			return false;
+			return -1;
 		}
 
 		*type_die = stack->type;
 		/* Update the type offset from the start of slot */
 		dloc->type_offset -= fboff + stack->offset;
 
-		return true;
+		return 1;
 	}
 
 	if (state->regs[reg].kind == TSR_KIND_PERCPU_BASE) {
@@ -1212,9 +1217,10 @@ static bool check_matching_type(struct type_state *state,
 		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
 					&var_offset, type_die)) {
 			dloc->type_offset = var_offset;
-			return true;
+			return 1;
 		}
-		return false;
+		/* No need to retry per-cpu (global) variables */
+		return -1;
 	}
 
 	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_POINTER) {
@@ -1231,9 +1237,9 @@ static bool check_matching_type(struct type_state *state,
 		/* Get the size of the actual type */
 		if (dwarf_aggregate_size(type_die, &size) < 0 ||
 		    (unsigned)dloc->type_offset >= size)
-			return false;
+			return -1;
 
-		return true;
+		return 1;
 	}
 
 	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_CANARY) {
@@ -1246,7 +1252,7 @@ static bool check_matching_type(struct type_state *state,
 		 */
 		setup_stack_canary(dloc);
 
-		return false;
+		return -1;
 	}
 
 	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
@@ -1262,9 +1268,9 @@ static bool check_matching_type(struct type_state *state,
 			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
 				dloc->type_offset = offset;
-				return true;
+				return 1;
 			}
-			return false;
+			return -1;
 		}
 
 		/* Access to per-cpu base like "-0x7dcf0500(,%rdx,8)" */
@@ -1280,26 +1286,28 @@ static bool check_matching_type(struct type_state *state,
 				pr_debug_dtp(" percpu base\n");
 
 				dloc->type_offset = offset;
-				return true;
+				return 1;
 			}
+			pr_debug_dtp(" negative offset\n");
+			return -1;
 		}
 	}
 
 	pr_debug_dtp("\n");
-	return false;
+	return 0;
 }
 
 /* Iterate instructions in basic blocks and update type table */
-static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
-				struct list_head *basic_blocks,
-				struct die_var_type *var_types,
-				Dwarf_Die *cu_die, Dwarf_Die *type_die)
+static int find_data_type_insn(struct data_loc_info *dloc, int reg,
+			       struct list_head *basic_blocks,
+			       struct die_var_type *var_types,
+			       Dwarf_Die *cu_die, Dwarf_Die *type_die)
 {
 	struct type_state state;
 	struct symbol *sym = dloc->ms->sym;
 	struct annotation *notes = symbol__annotation(sym);
 	struct annotated_basic_block *bb;
-	bool found = false;
+	int ret = 0;
 
 	init_type_state(&state, dloc->arch);
 
@@ -1317,8 +1325,8 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
 			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
 
 			if (this_ip == dloc->ip) {
-				found = check_matching_type(&state, dloc, reg,
-							    cu_die, type_die);
+				ret = check_matching_type(&state, dloc, reg,
+							  cu_die, type_die);
 				goto out;
 			}
 
@@ -1331,7 +1339,7 @@ static bool find_data_type_insn(struct data_loc_info *dloc, int reg,
 
 out:
 	exit_type_state(&state);
-	return found;
+	return ret;
 }
 
 /*
@@ -1355,6 +1363,7 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 	for (int i = nr_scopes - 1; i >= 0; i--) {
 		Dwarf_Addr base, start, end;
 		LIST_HEAD(this_blocks);
+		int found;
 
 		if (dwarf_ranges(&scopes[i], 0, &base, &start, &end) < 0)
 			break;
@@ -1385,15 +1394,19 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		fixup_var_address(var_types, start);
 
 		/* Find from start of this scope to the target instruction */
-		if (find_data_type_insn(dloc, reg, &basic_blocks, var_types,
-					cu_die, type_die)) {
-			ret = 0;
+		found = find_data_type_insn(dloc, reg, &basic_blocks, var_types,
+					    cu_die, type_die);
+		if (found > 0) {
 			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x",
 				     dloc->op->offset, reg, dloc->type_offset);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+			ret = 0;
 			break;
 		}
 
+		if (found < 0)
+			break;
+
 		/* Go up to the next scope and find blocks to the start */
 		prev_dst_ip = dst_ip;
 		dst_ip = src_ip;
-- 
2.44.0.291.gc1ea87d7ee-goog


