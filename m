Return-Path: <linux-kernel+bounces-165998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9E88B947A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2679D283BA9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB694205B;
	Thu,  2 May 2024 06:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KcVhjvN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE58E2E85A;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629616; cv=none; b=QiCxMvYyjpUypR2kJ9jCh+hIj3LJUmSkB/kzKMxP0nt0A2EsH3MAtLPjoNJ9/y6bfWqfO7TmdDEl0vpP1oHV5skaj4yV3hKt3FymRcDn2LIHNp5SpvmYgWqcVdDBlyuN64iQl07rPu1EiTgRQjXnZikQwnvClIzV3V7JZdBEAW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629616; c=relaxed/simple;
	bh=bBO0Iqelj8fza63egsoXJuy9RT4wZZVSdAOcjGFLV54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=paoekKwzETUW5bQdITTdUx6dEwEbXB+s+REXMX71wrh8u16Lson5nREFpzgfSS6YSsEujeDXp8T1DY2z5aGc8HVMg8XCFhRUaL2K85/Qxdx0UDuN9ZjAcmEOxa5vFGB3SvFnsPe7Fh9NGYZzw+WIGozLCBkyjS5kxx+GfR/HovM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KcVhjvN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AD4C4AF61;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629615;
	bh=bBO0Iqelj8fza63egsoXJuy9RT4wZZVSdAOcjGFLV54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KcVhjvN2Q/IIksoC2T2K7yei0Za/gHqV7wMwhTWBGaCBSyeoaG57Ii30mBmJ9WbwV
	 Y4Y16Sazd9ilTIic/WJW3Gyfxoc3iU4pnXI8R4WRVDMkXwVUQpRw456ILHTP2PsL/S
	 3L4I5LA3SmBEJF+aC+ifJZUsUArPtf3Nia4Ye8ITNgvvJ0T/UsuQnWWS1+kVkTtz96
	 T6Pvq5XBxjDzCYombLd5K6dzK2Gklq45Ah7JhUV0uZ3pfT91/2tB8RGv6QQEfzMuBK
	 n+HbjKb6VbbkMgO8PoFiN5vE4q/G0MMmu4rEm4ELFRd/yULipOt3soCKtmYsVhjM6Y
	 TveN+kZdfXZuA==
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
Subject: [PATCH 5/6] perf annotate-data: Handle multi regs in find_data_type_block()
Date: Wed,  1 May 2024 23:00:10 -0700
Message-ID: <20240502060011.1838090-6-namhyung@kernel.org>
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

The instruction tracking should be the same for the both registers.
Just do it once and compare the result with multi regs as with the
previous patches.  Then we don't need to call find_data_type_block()
separately for each reg.  Let's remove the 'reg' argument from the
relevant functions.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 245e3ef3e2ff..68fe7999f033 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1258,11 +1258,12 @@ static void setup_stack_canary(struct data_loc_info *dloc)
  * are similar to global variables and no additional info is needed.
  */
 static int check_matching_type(struct type_state *state,
-			       struct data_loc_info *dloc, int reg,
+			       struct data_loc_info *dloc,
 			       Dwarf_Die *cu_die, Dwarf_Die *type_die)
 {
 	Dwarf_Word size;
 	u32 insn_offset = dloc->ip - dloc->ms->sym->start;
+	int reg = dloc->op->reg1;
 
 	pr_debug_dtp("chk [%x] reg%d offset=%#x ok=%d kind=%d",
 		     insn_offset, reg, dloc->op->offset,
@@ -1448,7 +1449,7 @@ static int check_matching_type(struct type_state *state,
 }
 
 /* Iterate instructions in basic blocks and update type table */
-static int find_data_type_insn(struct data_loc_info *dloc, int reg,
+static int find_data_type_insn(struct data_loc_info *dloc,
 			       struct list_head *basic_blocks,
 			       struct die_var_type *var_types,
 			       Dwarf_Die *cu_die, Dwarf_Die *type_die)
@@ -1481,7 +1482,7 @@ static int find_data_type_insn(struct data_loc_info *dloc, int reg,
 			update_var_state(&state, dloc, addr, dl->al.offset, var_types);
 
 			if (this_ip == dloc->ip) {
-				ret = check_matching_type(&state, dloc, reg,
+				ret = check_matching_type(&state, dloc,
 							  cu_die, type_die);
 				goto out;
 			}
@@ -1502,7 +1503,7 @@ static int find_data_type_insn(struct data_loc_info *dloc, int reg,
  * Construct a list of basic blocks for each scope with variables and try to find
  * the data type by updating a type state table through instructions.
  */
-static int find_data_type_block(struct data_loc_info *dloc, int reg,
+static int find_data_type_block(struct data_loc_info *dloc,
 				Dwarf_Die *cu_die, Dwarf_Die *scopes,
 				int nr_scopes, Dwarf_Die *type_die)
 {
@@ -1550,7 +1551,7 @@ static int find_data_type_block(struct data_loc_info *dloc, int reg,
 		fixup_var_address(var_types, start);
 
 		/* Find from start of this scope to the target instruction */
-		found = find_data_type_insn(dloc, reg, &basic_blocks, var_types,
+		found = find_data_type_insn(dloc, &basic_blocks, var_types,
 					    cu_die, type_die);
 		if (found > 0) {
 			char buf[64];
@@ -1716,8 +1717,13 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		goto out;
 	}
 
+	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
+		reg = loc->reg2;
+		goto retry;
+	}
+
 	if (reg != DWARF_REG_PC) {
-		ret = find_data_type_block(dloc, reg, &cu_die, scopes,
+		ret = find_data_type_block(dloc, &cu_die, scopes,
 					   nr_scopes, type_die);
 		if (ret == 0) {
 			ann_data_stat.insn_track++;
@@ -1725,11 +1731,6 @@ static int find_data_type_die(struct data_loc_info *dloc, Dwarf_Die *type_die)
 		}
 	}
 
-	if (loc->multi_regs && reg == loc->reg1 && loc->reg1 != loc->reg2) {
-		reg = loc->reg2;
-		goto retry;
-	}
-
 	if (ret < 0) {
 		pr_debug_dtp("no variable found\n");
 		ann_data_stat.no_var++;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


