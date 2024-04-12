Return-Path: <linux-kernel+bounces-143207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B168A35C6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE301F24AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B184114F9E3;
	Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVoJ2eoK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8AC14F136;
	Fri, 12 Apr 2024 18:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946792; cv=none; b=Lkf/jDYSj3uym0+5TlB7zyiYi5fScVB7vkV4dAKmLWuOcj2QkN1n/Kwi8qfu67xoUibljASpVrmlHibXNZm/FAJ6qJxPvDQlwua69KfwG4fgfbBV7e0N8cmYoBUXXMutxcV6eUisNjBBdHVdG25cwpKGJCIynmSoPO5+pWx24g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946792; c=relaxed/simple;
	bh=vaVisn2Hv+xkW0BEkChkfySYlnshZGIQoNtORS9lyKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bIBBKKCBsFzE51RwIYS32RwT9Pw1fL4MqEoGDMY83Pu4GhbEr20IAoImrhmeRJ0CdETDoWBuAvSnxp9ZDyMfkikOuE508XQm8fWxr7o/Alnwjw7RweOZx9mGmgJAwe4V/PPc6Hrl8d2mgXrh3kbY2RdkepYLH+31JpdWH7YS4Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVoJ2eoK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BFCC2BBFC;
	Fri, 12 Apr 2024 18:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946792;
	bh=vaVisn2Hv+xkW0BEkChkfySYlnshZGIQoNtORS9lyKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVoJ2eoKqlPDIU5AGscdTPr6jQMwXYRf6BUQ8hk4g6Z9LR2dD7XjJzWXB4FAXJ5rq
	 JPHZvlTy1iVsItaByVesEmels9hIQppxao7aF4gFp988sMWXPC6tCvWWLJmJfrNhuI
	 Fo/NDXyQUjLZr6LO0dg8sgPyCHqrThbqv2MXHPWYE1bBtzPvudNJs14h/SFZV1SR8o
	 ifKRTlztm9men99rMRxgZZ2eqCdwuQbvmjnAtoJBF/tGsoNnRzglr/2Z6K5yr03z8E
	 DYQH4+6PqLnjtAGRkyCVBV/Z37eF0kTZVk6z73FKCWYomRikJCvR1ob8e871GXcyXD
	 LWJbpSG/bqMJQ==
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
Subject: [PATCH 1/4] perf annotate-data: Improve debug message with location info
Date: Fri, 12 Apr 2024 11:33:07 -0700
Message-ID: <20240412183310.2518474-2-namhyung@kernel.org>
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

To verify it found the correct variable, let's add the location
expression to the debug message.

  $ perf --debug type-profile annotate --data-type
  ...
  -----------------------------------------------------------
  find data type for 0xaf0(reg15) at schedule+0xeb
  CU for kernel/sched/core.c (die:0x1180523)
  frame base: cfa=0 fbreg=6
  found "rq" in scope=3/4 (die: 0x11b6a00) type_offset=0xaf0
   variable location: reg15
   type='struct rq' size=0xfc0 (die:0x11892e2)
  -----------------------------------------------------------
  find data type for 0x7bc(reg3) at tcp_get_info+0x62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  offset: 1980 is bigger than size: 760
  check variable "sk" failed (die: 0x7b92b2c)
   variable location: reg3
   type='struct sock' size=0x2f8 (die:0x7b63c3a)
  -----------------------------------------------------------
  ...

The first case is fine.  It looked up a data type in r15 with offset of
0xaf0 at the schedule+0xeb.  It found CU die and the frame base info and
the variable "rq" was found in the scope 3/4.  Its location is the r15
register and the type size is 0xfc0 which includes 0xaf0.

But the second case is not good.  It looked up a data type in rbx (reg3)
with offset 0x7bc.  It found a CU and the frame base which is good so
far.  And it also found a variable "sk" but the access offset is bigger
than the type size (1980 vs. 760 or 0x7bc vs. 0x2f8).  The variable has
the right location (reg3) but I need to figure out why it accesses
beyond what it's supposed to.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 99 +++++++++++++++++++++++++++------
 1 file changed, 82 insertions(+), 17 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 1cd857400038..c6eb5b2cc4d5 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -46,6 +46,7 @@ static void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 {
 	struct strbuf sb;
 	char *str;
+	Dwarf_Word size = 0;
 
 	if (!debug_type_profile && verbose < 3)
 		return;
@@ -72,13 +73,67 @@ static void pr_debug_type_name(Dwarf_Die *die, enum type_state_kind kind)
 		break;
 	}
 
+	dwarf_aggregate_size(die, &size);
+
 	strbuf_init(&sb, 32);
 	die_get_typename_from_type(die, &sb);
 	str = strbuf_detach(&sb, NULL);
-	pr_info(" type=%s (die:%lx)\n", str, (long)dwarf_dieoffset(die));
+	pr_info(" type='%s' size=%#lx (die:%#lx)\n",
+		str, (long)size, (long)dwarf_dieoffset(die));
 	free(str);
 }
 
+static void pr_debug_location(Dwarf_Die *die, u64 pc, int reg)
+{
+	ptrdiff_t off = 0;
+	Dwarf_Attribute attr;
+	Dwarf_Addr base, start, end;
+	Dwarf_Op *ops;
+	size_t nops;
+
+	if (!debug_type_profile && verbose < 3)
+		return;
+
+	if (dwarf_attr(die, DW_AT_location, &attr) == NULL)
+		return;
+
+	while ((off = dwarf_getlocations(&attr, off, &base, &start, &end, &ops, &nops)) > 0) {
+		if (reg != DWARF_REG_PC && end < pc)
+			continue;
+		if (reg != DWARF_REG_PC && start > pc)
+			break;
+
+		pr_info(" variable location: ");
+		switch (ops->atom) {
+		case DW_OP_reg0 ...DW_OP_reg31:
+			pr_info("reg%d\n", ops->atom - DW_OP_reg0);
+			break;
+		case DW_OP_breg0 ...DW_OP_breg31:
+			pr_info("base=reg%d, offset=%#lx\n",
+				ops->atom - DW_OP_breg0, ops->number);
+			break;
+		case DW_OP_regx:
+			pr_info("reg%ld\n", ops->number);
+			break;
+		case DW_OP_bregx:
+			pr_info("base=reg%ld, offset=%#lx\n",
+				ops->number, ops->number2);
+			break;
+		case DW_OP_fbreg:
+			pr_info("use frame base, offset=%#lx\n", ops->number);
+			break;
+		case DW_OP_addr:
+			pr_info("address=%#lx\n", ops->number);
+			break;
+		default:
+			pr_info("unknown: code=%#x, number=%#lx\n",
+				ops->atom, ops->number);
+			break;
+		}
+		break;
+	}
+}
+
 /*
  * Type information in a register, valid when @ok is true.
  * The @caller_saved registers are invalidated after a function call.
@@ -1404,7 +1459,7 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		found = find_data_type_insn(dloc, reg, &basic_blocks, var_types,
 					    cu_die, type_die);
 		if (found > 0) {
-			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x",
+			pr_debug_dtp("found by insn track: %#x(reg%d) type-offset=%#x\n",
 				     dloc->op->offset, reg, dloc->type_offset);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 			ret = 0;
@@ -1440,16 +1495,16 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	char buf[64];
 
 	if (dloc->op->multi_regs)
-		snprintf(buf, sizeof(buf), " or reg%d", dloc->op->reg2);
+		snprintf(buf, sizeof(buf), "reg%d, reg%d", dloc->op->reg1, dloc->op->reg2);
 	else if (dloc->op->reg1 == DWARF_REG_PC)
-		snprintf(buf, sizeof(buf), " (PC)");
+		snprintf(buf, sizeof(buf), "PC");
 	else
-		buf[0] = '\0';
+		snprintf(buf, sizeof(buf), "reg%d", dloc->op->reg1);
 
 	pr_debug_dtp("-----------------------------------------------------------\n");
-	pr_debug_dtp("%s [%"PRIx64"] for reg%d%s offset=%#x in %s\n",
-		     __func__, dloc->ip - dloc->ms->sym->start,
-		     dloc->op->reg1, buf, dloc->op->offset, dloc->ms->sym->name);
+	pr_debug_dtp("find data type for %#x(%s) at %s+%#"PRIx64"\n",
+		     dloc->op->offset, buf, dloc->ms->sym->name,
+		     dloc->ip - dloc->ms->sym->start);
 
 	/*
 	 * IP is a relative instruction address from the start of the map, as
@@ -1468,14 +1523,15 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 	reg = loc->reg1;
 	offset = loc->offset;
 
-	pr_debug_dtp("CU die offset: %#lx\n", (long)dwarf_dieoffset(&cu_die));
+	pr_debug_dtp("CU for %s (die:%#lx)\n",
+		     dwarf_diename(&cu_die), (long)dwarf_dieoffset(&cu_die));
 
 	if (reg == DWARF_REG_PC) {
 		if (get_global_var_type(&cu_die, dloc, dloc->ip, dloc->var_addr,
 					&offset, type_die)) {
 			dloc->type_offset = offset;
 
-			pr_debug_dtp("found PC-rel by addr=%#"PRIx64" offset=%#x",
+			pr_debug_dtp("found by addr=%#"PRIx64" type_offset=%#x\n",
 				     dloc->var_addr, offset);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 			ret = 0;
@@ -1537,13 +1593,22 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 			pr_debug_dtp("found \"%s\" in scope=%d/%d (die: %#lx) ",
 				     dwarf_diename(&var_die), i+1, nr_scopes,
 				     (long)dwarf_dieoffset(&scopes[i]));
-			if (reg == DWARF_REG_PC)
-				pr_debug_dtp("%#x(PC) offset=%#x", loc->offset, offset);
-			else if (reg == DWARF_REG_FB || is_fbreg)
-				pr_debug_dtp("%#x(reg%d) stack fb_offset=%#x offset=%#x",
-					     loc->offset, reg, fb_offset, offset);
-			else
-				pr_debug_dtp("%#x(reg%d)", loc->offset, reg);
+			if (reg == DWARF_REG_PC) {
+				pr_debug_dtp("addr=%#"PRIx64" type_offset=%#x\n",
+					     dloc->var_addr, offset);
+			} else if (reg == DWARF_REG_FB || is_fbreg) {
+				pr_debug_dtp("stack_offset=%#x type_offset=%#x\n",
+					     fb_offset, offset);
+			} else {
+				pr_debug_dtp("type_offset=%#x\n", offset);
+			}
+			pr_debug_location(&var_die, pc, reg);
+			pr_debug_type_name(type_die, TSR_KIND_TYPE);
+		} else {
+			pr_debug_dtp("check variable \"%s\" failed (die: %#lx)\n",
+				     dwarf_diename(&var_die),
+				     (long)dwarf_dieoffset(&var_die));
+			pr_debug_location(&var_die, pc, reg);
 			pr_debug_type_name(type_die, TSR_KIND_TYPE);
 		}
 		dloc->type_offset = offset;
-- 
2.44.0.683.g7961c838ac-goog


