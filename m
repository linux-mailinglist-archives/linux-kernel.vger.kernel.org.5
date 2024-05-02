Return-Path: <linux-kernel+bounces-165997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C00DD8B9478
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E355E1C20FB3
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6612E64B;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHZFhw/W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055C823775;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629615; cv=none; b=lfAiPHirvpjOGLRwTE8C5YYFc3aOh223xlCgd/d7tf6WVnQWEHxIPSNX1b+lkgJ1pBYbT4O7Pyw7v54WD3++9OMwOOVj8sl00w8/y7Zu8DbdJhqK87uQstEJoBihFUjknBIRIrOduar6L24aEkcL9cBLXRlRBmZGNsTql6N5oMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629615; c=relaxed/simple;
	bh=FD83vOLGqIEiapuFz0V+SOOdVptlx7pB58xGzLzESqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFPgEoPQLam8N9Ba/4J2FiMfm6qHuATgb11nKLsiveNCFd3WDy70cRelXOB2+k39Fwq+LMzaOqdI8HUKZZ9bceEHcPLTk0ERR6X1IWMX3LIljM+uyu9fn5Ptkf0pdUj3xuMF4fwRKe1qeioyn0sYLwOoLr+2KPTxW4WgZtj75iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHZFhw/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82139C4AF50;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629614;
	bh=FD83vOLGqIEiapuFz0V+SOOdVptlx7pB58xGzLzESqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rHZFhw/WFZWr/010GbTf+vBwDGHAWj5xhRUIq/VH4Il3w2dgRjA56xG6KjqNz0oBH
	 ftDTLJCYVInzFIKFhRvuQ9FIvDt/y2D03TYyh1ApemaDCdpv16e051gQqe34K84I7E
	 x4O5WQX+/N/7Z9aLYfJmDZ7mvGMQYXxzKjKq89UKvuGjq0h5LfRvGIxFDy6yYsBOA8
	 TJN0Q/Re+wd4V/GhaknVD19obidf60RkkPDYEQ3E2x6fJV15sMC/hwnkjT7DM55O7u
	 YG6qA5ETnadqEwLwbF8sYZfAkKBM42T5xdraDPKWyM69pTyrJID6TkR4aScJ6DRpTU
	 fd51LCLJkhzJQ==
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
Subject: [PATCH 4/6] perf annotate-data: Check memory access with two registers
Date: Wed,  1 May 2024 23:00:09 -0700
Message-ID: <20240502060011.1838090-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
In-Reply-To: <20240502060011.1838090-1-namhyung@kernel.org>
References: <20240502060011.1838090-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following instruction pattern is used to access a global variable.

  mov     $0x231c0, %rax
  movsql  %edi, %rcx
  mov     -0x7dc94ae0(,%rcx,8), %rcx
  cmpl    $0x0, 0xa60(%rcx,%rax,1)     <<<--- here

The first instruction set the address of the per-cpu variable (here, it
is 'runqueus' of struct rq).  The second instruction seems like a cpu
number of the per-cpu base.  The third instruction get the base offset
of per-cpu area for that cpu.  The last instruction compares the value
of the per-cpu variable at the offset of 0xa60.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 44 +++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index f1e52a531563..245e3ef3e2ff 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1031,22 +1031,37 @@ static void update_insn_state_x86(struct type_state *state,
 		else if (has_reg_type(state, sreg) &&
 			 state->regs[sreg].kind == TSR_KIND_PERCPU_BASE) {
 			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 var_addr = src->offset;
 			int offset;
 
+			if (src->multi_regs) {
+				int reg2 = (sreg == src->reg1) ? src->reg2 : src->reg1;
+
+				if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+				    state->regs[reg2].kind == TSR_KIND_CONST)
+					var_addr += state->regs[reg2].imm_value;
+			}
+
 			/*
 			 * In kernel, %gs points to a per-cpu region for the
 			 * current CPU.  Access with a constant offset should
 			 * be treated as a global variable access.
 			 */
-			if (get_global_var_type(cu_die, dloc, ip, src->offset,
+			if (get_global_var_type(cu_die, dloc, ip, var_addr,
 						&offset, &type_die) &&
 			    die_get_member_type(&type_die, offset, &type_die)) {
 				tsr->type = type_die;
 				tsr->kind = TSR_KIND_TYPE;
 				tsr->ok = true;
 
-				pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d",
-					     insn_offset, src->offset, sreg, dst->reg1);
+				if (src->multi_regs) {
+					pr_debug_dtp("mov [%x] percpu %#x(reg%d,reg%d) -> reg%d",
+						     insn_offset, src->offset, src->reg1,
+						     src->reg2, dst->reg1);
+				} else {
+					pr_debug_dtp("mov [%x] percpu %#x(reg%d) -> reg%d",
+						     insn_offset, src->offset, sreg, dst->reg1);
+				}
 				pr_debug_type_name(&tsr->type, tsr->kind);
 			} else {
 				tsr->ok = false;
@@ -1340,6 +1355,17 @@ static int check_matching_type(struct type_state *state,
 
 		pr_debug_dtp(" percpu var\n");
 
+		if (dloc->op->multi_regs) {
+			int reg2 = dloc->op->reg2;
+
+			if (dloc->op->reg2 == reg)
+				reg2 = dloc->op->reg1;
+
+			if (has_reg_type(state, reg2) && state->regs[reg2].ok &&
+			    state->regs[reg2].kind == TSR_KIND_CONST)
+				var_addr += state->regs[reg2].imm_value;
+		}
+
 		if (get_global_var_type(cu_die, dloc, dloc->ip, var_addr,
 					&var_offset, type_die)) {
 			dloc->type_offset = var_offset;
@@ -1527,8 +1553,16 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		found = find_data_type_insn(dloc, reg, &basic_blocks, var_types,
 					    cu_die, type_die);
 		if (found > 0) {
-			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x\n",
-				     dloc->op->offset, reg, dloc->type_offset);
+			char buf[64];
+
+			if (dloc->op->multi_regs)
+				snprintf(buf, sizeof(buf), "reg%d, reg%d",
+					 dloc->op->reg1, dloc->op->reg2);
+			else
+				snprintf(buf, sizeof(buf), "reg%d", dloc->op->reg1);
+
+			pr_debug_dtp("found by insn track: %#x(%s) type-offset=%#x\n",
+				     dloc->op->offset, buf, dloc->type_offset);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 			ret = 0;
 			break;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


