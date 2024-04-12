Return-Path: <linux-kernel+bounces-143210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4D8D8A35C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CECEB1C23CD3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497531509AC;
	Fri, 12 Apr 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cR2WVq5+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C614F9FD;
	Fri, 12 Apr 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946794; cv=none; b=DrEPjou17N4htiU2E2x7OYfmjOxQaQpaaqc4eIfrnkD6+prBKmQvAwZwaHgR83/uMxW41nEtB6ZhvmbOvAYw7EbeNyAzX3WtayijJUcgp3BWcTqA+MydmFNOoqBkDwwF1lycRw5v2gumPYXLLSV/GbKF6fyp10gVMxWZv/A7eZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946794; c=relaxed/simple;
	bh=Mt6sBBBPrGWipkKUwBCkIzYuDK3HGlK3FMB4X+GvFnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mVWLMo/XQdh4gBdxrbFMT/kuTAvAUMW0F1gsUr4Dk3q8SRYmO/lZQyveUTu/YGMhbRpraXUJR2YbMaJavPZuv5VgDMNKkbCf8WyZ4guIge+HHOdV8Rp/z4aGr5+QgreKp1RHS7TqmAkJZdWJ48r8Iejo8sRCtUGALirvdrExI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cR2WVq5+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF6DC2BBFC;
	Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946793;
	bh=Mt6sBBBPrGWipkKUwBCkIzYuDK3HGlK3FMB4X+GvFnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cR2WVq5+L6yzaiB3qWpk0hll5h+FzZF2WrIWeo7NJfouZ0k9kps81jEHkev8wg/d3
	 qBqF+XwW6fjiPOSPAk+MjxKZPnJVHJPcXoXU+pnV8ZJIcjUny2J2DBkT/5RKeN0vJS
	 Vtp/s81axGPcYpGvUU9EeFy9Bq4D3FyYjsrQdrbslBsjxpjn0/ymVKpWIGHpFWMs8X
	 +VLdo3LheHehC6TLtqBZNvF2wXBf7vEY05C3mRH2UzzPAN3Zzk+y2pFLztQlyMIW7F
	 9bO76mFiRJYzXlIded2eG7bq+6vc4VRxRlUVVwsZxuE9T/H1+jQ0Na2aa18AOqXbtt
	 YSVMS2sBxpJlA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 4/4] perf annotate-data: Handle RSP if it's not the FB register
Date: Fri, 12 Apr 2024 11:33:10 -0700
Message-ID: <20240412183310.2518474-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
In-Reply-To: <20240412183310.2518474-1-namhyung@kernel.org>
References: <20240412183310.2518474-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In some cases, the stack pointer on x86 (rsp = reg7) is used to point
variables on stack but it's not the frame base register.  Then it
should handle the register like normal registers (IOW not to access
the other stack variables using offset calculation) but it should not
assume it would have a pointer.

Before:
  -----------------------------------------------------------
  find data type for 0x7c(reg7) at tcp_getsockopt+0xb62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  no pointer or no type
  check variable "zc" failed (die: 0x7b9580a)
   variable location: base=reg7, offset=0x40
   type='struct tcp_zerocopy_receive' size=0x40 (die:0x7b947f4)

After:
  -----------------------------------------------------------
  find data type for 0x7c(reg7) at tcp_getsockopt+0xb62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  found "zc" in scope=3/3 (die: 0x7b957fc) type_offset=0x3c
   variable location: base=reg7, offset=0x40
   type='struct tcp_zerocopy_receive' size=0x40 (die:0x7b947f4)

Note that the type-offset was properly calculated to 0x3c as the
variable starts at 0x40.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index c6eb5b2cc4d5..2dfbdd804222 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -25,6 +25,9 @@
 #include "symbol_conf.h"
 #include "thread.h"
 
+/* register number of the stack pointer */
+#define X86_REG_SP 7
+
 enum type_state_kind {
 	TSR_KIND_INVALID = 0,
 	TSR_KIND_TYPE,
@@ -197,7 +200,7 @@ static void init_type_state(struct type_state *state, struct arch *arch)
 		state->regs[10].caller_saved = true;
 		state->regs[11].caller_saved = true;
 		state->ret_reg = 0;
-		state->stack_reg = 7;
+		state->stack_reg = X86_REG_SP;
 	}
 }
 
@@ -382,10 +385,18 @@ static bool find_cu_die(struct debuginfo *di, u64 pc, Dwarf_Die *cu_die)
 }
 
 /* The type info will be saved in @type_die */
-static int check_variable(Dwarf_Die *var_die, Dwarf_Die *type_die, int offset,
-			  bool is_pointer)
+static int check_variable(struct data_loc_info *dloc, Dwarf_Die *var_die,
+			  Dwarf_Die *type_die, int reg, int offset, bool is_fbreg)
 {
 	Dwarf_Word size;
+	bool is_pointer = true;
+
+	if (reg == DWARF_REG_PC)
+		is_pointer = false;
+	else if (reg == dloc->fbreg || is_fbreg)
+		is_pointer = false;
+	else if (arch__is(dloc->arch, "x86") && reg == X86_REG_SP)
+		is_pointer = false;
 
 	/* Get the type of the variable */
 	if (die_get_real_type(var_die, type_die) == NULL) {
@@ -607,7 +618,6 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 {
 	u64 pc;
 	int offset;
-	bool is_pointer = false;
 	const char *var_name = NULL;
 	struct global_var_entry *gvar;
 	Dwarf_Die var_die;
@@ -623,7 +633,8 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 	/* Try to get the variable by address first */
 	if (die_find_variable_by_addr(cu_die, var_addr, &var_die, &offset) &&
-	    check_variable(&var_die, type_die, offset, is_pointer) == 0) {
+	    check_variable(dloc, &var_die, type_die, DWARF_REG_PC, offset,
+			   /*is_fbreg=*/false) == 0) {
 		var_name = dwarf_diename(&var_die);
 		*var_offset = offset;
 		goto ok;
@@ -636,7 +647,8 @@ static bool get_global_var_type(Dwarf_Die *cu_die, struct data_loc_info *dloc,
 
 	/* Try to get the name of global variable */
 	if (die_find_variable_at(cu_die, var_name, pc, &var_die) &&
-	    check_variable(&var_die, type_die, *var_offset, is_pointer) == 0)
+	    check_variable(dloc, &var_die, type_die, DWARF_REG_PC, *var_offset,
+			   /*is_fbreg=*/false) == 0)
 		goto ok;
 
 	return false;
@@ -1587,8 +1599,7 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		}
 
 		/* Found a variable, see if it's correct */
-		ret = check_variable(&var_die, type_die, offset,
-				     reg != DWARF_REG_PC && !is_fbreg);
+		ret = check_variable(dloc, &var_die, type_die, reg, offset, is_fbreg);
 		if (ret == 0) {
 			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
 				     dwarf_diename(&var_die), i+1, nr_scopes,
-- 
2.44.0.683.g7961c838ac-goog


