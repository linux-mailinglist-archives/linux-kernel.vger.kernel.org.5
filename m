Return-Path: <linux-kernel+bounces-50645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89A5847C08
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 23:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927D9288A8A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300C4132474;
	Fri,  2 Feb 2024 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxHn2IiH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39757132467;
	Fri,  2 Feb 2024 22:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911510; cv=none; b=UbI1WJhzJOKzZa1QhY0d78D3p6dQubkeROlL9daBI4Oq8J9xo3cJCUe1iuJpjsJRYpuEaWSRzbxfWUUVUGxiopf3cBetNQUvL4eAsk0aWQMvCnQK3K90C7fV9tCyOXZo2VX8xrN74bZQTGZTVG8SP6iooEWr47N3QiePFKb9hLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911510; c=relaxed/simple;
	bh=8cuanY9nIKPUghP/dPMClAHP/3p1hi26K3nztrI2MFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=agG8Z709yo0/mB1R4qPOdvJr5Hq2A6IX/b74DJz1+fpOFUJ3CvDhLhi45txagN54WgKYS3coX0k5xbCYC4xiXA6X/DzPWDLxXWw8AHuLGCMIvnYmneTfXkxbA8jSjGcEu8FXv1M2GOy7GQjm+zsmrrZdEuLMvylii0r8gpiOXtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxHn2IiH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5866CC43390;
	Fri,  2 Feb 2024 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706911509;
	bh=8cuanY9nIKPUghP/dPMClAHP/3p1hi26K3nztrI2MFI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TxHn2IiHBRlypqccvr7R1y33hds9O14sWGIbCsicdHXkx2sdrIDnShKjbGjiY6x3O
	 DOxLl3ppa9OEWw8+YoorLHC39SbSIedAHJiF/4IQwBXgQKe/FAdHEWRAqkcoUFVKaB
	 9s5hrCQQiaLpasPfJCiaGOlbgpb4k6o6ZYrnLJLDP4PARu/upkAU/5CMY1kNLzBhSh
	 2btZ6QO6LOCiW0JsDeZMgifISkpp3z4iraiN8Ka+qjhMFYfSPkhIzo1065+MjW0Z07
	 RZJDcmrt/D0cA6Um6u1oToUlo4XkY4/RBKYTkSiwvWSqqeaLvdjRVmw4ATVcdhxtO5
	 vLTKS3Z+Dtykg==
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
Subject: [PATCH 13/14] perf annotate-data: Track instructions with a this-cpu variable
Date: Fri,  2 Feb 2024 14:04:58 -0800
Message-ID: <20240202220459.527138-14-namhyung@kernel.org>
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

Like global variables, this per-cpu variables should be tracked
correctly.  Factor our get_global_var_type() to handle both global
and per-cpu (for this cpu) variables in the same manner.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 84 +++++++++++++++++++++++----------
 1 file changed, 60 insertions(+), 24 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index cebbe17de64a..9d6cc6ac431c 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -410,6 +410,37 @@ void update_var_state(struct type_state *state, struct data_loc_info *dloc,
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
@@ -473,14 +504,36 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
+		else if (map__dso(dloc->ms->map)->kernel &&
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
@@ -493,37 +546,20 @@ void update_insn_state(struct type_state *state, struct data_loc_info *dloc,
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
2.43.0.594.gd9cf4e227d-goog


