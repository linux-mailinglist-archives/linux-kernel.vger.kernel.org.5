Return-Path: <linux-kernel+bounces-143208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 204018A35C7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 433DA1C230B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D4B14F9EB;
	Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pKc1bG6x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D7114F13A;
	Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946793; cv=none; b=HnzOrTqnFfFMNyJzHicxoIavCoGlZWust7iABs5jjF1NN8Je8VFjO2ELvr8EWeYYLTbAWuOUX7Om+p73hGiRWUtI9qIxUQfgYuxsL8cWEiIATCMrzdRDqbKUFi3TIa8Qc24GA24YwEnk2UNLruc0RL9ittzoeAV5pGWBxqIBvxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946793; c=relaxed/simple;
	bh=MdGKWRljF8Qw40speV6mfVp91ivhhrN0E6WVpTJ1KU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YinOAQdX9N20oGGHdekpe+Rjgsn7v8C8tauNNGj5yafCQIDo0DTsBE3GIAQbIHMLVlbvPPzQBDM1lpbjuaneAQcpkffMSNR/PSRS+mDp22PrwCzBsb8MZkgbSqEQ0DczgStGP1IZtei3UH8X8+x/6RJNwp5DpAY6BnCtMxW1VpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pKc1bG6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A59EC32781;
	Fri, 12 Apr 2024 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946792;
	bh=MdGKWRljF8Qw40speV6mfVp91ivhhrN0E6WVpTJ1KU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pKc1bG6xBUUOOwZfvk+GES4RLab54aBAQYX5QKGkQKyT4DXmN4B+nNUmoiFHs5/t9
	 l8AdYR5YjDmtdW3+h23XK/eKqYvQRImgOGvaawwhSk/U+rNQozdkP3Vu0BEDtYp18t
	 BWrnih5lmEhINYQSYIOAp5ULFee/vrapuwoNLZm3CxECaNXulv8HKOU+9ae2MdVEjI
	 ZPXmBTKkY3gt9ZrApbBjBcr3Y+oS+ofAgis+6GoqM9asJ0m3+PraBjJF/TOV0BsxJ4
	 VzmScnmdbU4W1WMrlcrSN8Y6PCFIhFP+T8YupllWYVo7OiWCM7j0fn2ZxJ6IytpAGq
	 p/TnWClbb3GvQ==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 2/4] perf dwarf-aux: Check pointer offset when checking variables
Date: Fri, 12 Apr 2024 11:33:08 -0700
Message-ID: <20240412183310.2518474-3-namhyung@kernel.org>
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

In match_var_offset(), it checks the offset range with the target type
only for non-pointer types.  But it also needs to check the pointer
types with the target type.

This is because there can be more than one pointer variables located in
the same register.  Let's look at the following example.  It's looking
up a variable for reg3 at tcp_get_info+0x62.  It found "sk" variable but
it wasn't the right one since it accesses beyond the target type (struct
'sock' in this case) size.

  -----------------------------------------------------------
  find data type for 0x7bc(reg3) at tcp_get_info+0x62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  offset: 1980 is bigger than size: 760
  check variable "sk" failed (die: 0x7b92b2c)
   variable location: reg3
   type='struct sock' size=0x2f8 (die:0x7b63c3a)

Actually there was another variable "tp" in the function and it's
located at the same (reg3) because it's just type-casted like below.

  void tcp_get_info(struct sock *sk, struct tcp_info *info)
  {
      const struct tcp_sock *tp = tcp_sk(sk);
      ...

The struct tcp_sock contains the struct sock at offset 0 so it can
just use the same address as a pointer to tcp_sock.  That means it
should match variables correctly by checking the offset and size.
Actually it cannot distinguish if the offset was smaller than the size
of the original struct sock.  But I think it's fine as they are the
same at that part.

So let's check the target type size and retry if it doesn't match.
Now it succeeded to find the correct variable.

  -----------------------------------------------------------
  find data type for 0x7bc(reg3) at tcp_get_info+0x62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  found "tp" in scope=1/1 (die: 0x7b92b16) type_offset=0x7bc
   variable location: reg3
   type='struct tcp_sock' size=0xa68 (die:0x7b81380)

Fixes: bc10db8eb895 ("perf annotate-data: Support stack variables")
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7dad99ee3ff3..b361fd7ebd56 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1361,7 +1361,7 @@ struct find_var_data {
 #define DWARF_OP_DIRECT_REGS  32
 
 static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
-			     u64 addr_offset, u64 addr_type)
+			     u64 addr_offset, u64 addr_type, bool is_pointer)
 {
 	Dwarf_Die type_die;
 	Dwarf_Word size;
@@ -1375,6 +1375,12 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return false;
 
+	if (is_pointer && dwarf_tag(&type_die) == DW_TAG_pointer_type) {
+		/* Get the target type of the pointer */
+		if (die_get_real_type(&type_die, &type_die) == NULL)
+			return false;
+	}
+
 	if (dwarf_aggregate_size(&type_die, &size) < 0)
 		return false;
 
@@ -1442,31 +1448,38 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    data->offset >= (int)ops->number &&
 		    check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->offset, ops->number))
+		    match_var_offset(die_mem, data, data->offset, ops->number,
+				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
 		if (data->reg < DWARF_OP_DIRECT_REGS) {
 			/* pointer variables saved in a register 0 to 31 */
 			if (ops->atom == (DW_OP_reg0 + data->reg) &&
-			    check_allowed_ops(ops, nops))
+			    check_allowed_ops(ops, nops) &&
+			    match_var_offset(die_mem, data, data->offset, 0,
+					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
 			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number))
+			    match_var_offset(die_mem, data, data->offset, ops->number,
+					     /*is_pointer=*/false))
 				return DIE_FIND_CB_END;
 		} else {
 			/* pointer variables saved in a register 32 or above */
 			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
-			    check_allowed_ops(ops, nops))
+			    check_allowed_ops(ops, nops) &&
+			    match_var_offset(die_mem, data, data->offset, 0,
+					     /*is_pointer=*/true))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
 			    check_allowed_ops(ops, nops) &&
-			    match_var_offset(die_mem, data, data->offset, ops->number2))
+			    match_var_offset(die_mem, data, data->offset, ops->number2,
+					     /*is_poitner=*/false))
 				return DIE_FIND_CB_END;
 		}
 	}
@@ -1528,7 +1541,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 			continue;
 
 		if (check_allowed_ops(ops, nops) &&
-		    match_var_offset(die_mem, data, data->addr, ops->number))
+		    match_var_offset(die_mem, data, data->addr, ops->number,
+				     /*is_pointer=*/false))
 			return DIE_FIND_CB_END;
 	}
 	return DIE_FIND_CB_SIBLING;
-- 
2.44.0.683.g7961c838ac-goog


