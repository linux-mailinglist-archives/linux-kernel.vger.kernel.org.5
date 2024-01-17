Return-Path: <linux-kernel+bounces-28567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 918EB830021
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F64BB24744
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C5B14AA5;
	Wed, 17 Jan 2024 06:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcNDo9Gg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C041427F;
	Wed, 17 Jan 2024 06:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472825; cv=none; b=df6YEjFv1LN3Um3xpkciQQiybUGPo5BiA2heIfjqz46FqJodgwojr2NPvEEn5ddIJHHpkgVYu9CNM8Oy748Jx4Opcy7ukrqaXKWYvfhQxA8NuU9zPcpyPCNdNXCphbclZzyqgGt++vI5bWvqjE6hVwVFLdceSHs6syT8j2Nb0aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472825; c=relaxed/simple;
	bh=kGeOYRx8qI0US6bRFjuYIEStLY+yQsBJ4RwEajsebjM=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=L8LiiKOX9mAPHk6VxdYqAyumt4I8p7u62GnnVdCk/QEK0UmOagOzvxh2Md2qSwyJXwzGvHl9c09tiiHwHoo9ewz2f8F9Gi4MUEL1u6D4EGD90B5ZRnH1xAMLftvlA6UnsTfrMFYeI5FSbUbsN2N8jLqIuzdsu31Pdgt4WWuPnvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TcNDo9Gg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8346AC43390;
	Wed, 17 Jan 2024 06:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472825;
	bh=kGeOYRx8qI0US6bRFjuYIEStLY+yQsBJ4RwEajsebjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TcNDo9GgchQ6h3sAcUB3HGvOoDL1wvZMNA2FFGl3hJxhNvd8yoE4madZ0jJgsy2Mr
	 ir4WWI25rX6R6/ZK0AQCJkEzHQa0MO1TpFAZbJCDgPksMII6V/d2P9HquXxjHJ+3Sv
	 aJ/0dxnhTAzzP694bbIFEcVSRmQ1lZuq+tyVbEt5VdUjnCcrZqK0h1iJ90G4eE5JTu
	 zK2hERqkYYyBMSJMTK2UkLJuvzN+MzaQkW4L1k6XWF2tpN+VPLBfoQmJjgTn7bLmyr
	 ZOODXca52Ye8FdJVHY5fgm9dcElFIaSjY4uhYgKvvJ0jtHSuGRsahcEncXFXXzjlZv
	 HPv3v9dNn4v0Q==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>
Cc: Ian Rogers <irogers@google.com>,
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
Subject: [PATCH 9/9] perf dwarf-aux: Check allowed DWARF Ops
Date: Tue, 16 Jan 2024 22:26:57 -0800
Message-ID: <20240117062657.985479-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.43.0.381.gb435a96ce8-goog
In-Reply-To: <20240117062657.985479-1-namhyung@kernel.org>
References: <20240117062657.985479-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DWARF location expression can be fairly complex and it'd be hard
to match it with the condition correctly.  So let's be conservative
and only allow simple expressions.  For now it just checks the first
operation in the list.  The following operations looks ok:

 * DW_OP_stack_value
 * DW_OP_deref_size
 * DW_OP_deref
 * DW_OP_piece

To refuse complex (and unsupported) location expressions, add
check_allowed_ops() to compare the rest of the list.  It seems earlier
result contained those unsupported expressions.  For example, I found
some local struct variable is placed like below.

 <2><43d1517>: Abbrev Number: 62 (DW_TAG_variable)
    <43d1518>   DW_AT_location    : 15 byte block: 91 50 93 8 91 78 93 4 93 84 8 91 68 93 4
        (DW_OP_fbreg: -48; DW_OP_piece: 8;
         DW_OP_fbreg: -8; DW_OP_piece: 4;
         DW_OP_piece: 1028;
         DW_OP_fbreg: -24; DW_OP_piece: 4)

Another example is something like this.

    0057c8be ffffffffffffffff ffffffff812109f0 (base address)
    0057c8ce ffffffff812112b5 ffffffff812112c8 (DW_OP_breg3 (rbx): 0;
                                                DW_OP_constu: 18446744073709551612;
                                                DW_OP_and;
                                                DW_OP_stack_value)

It should refuse them.  After the change, the stat shows:

  Annotate data type stats:
  total 294, ok 158 (53.7%), bad 136 (46.3%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          53 : no_var
          14 : no_typeinfo
           7 : bad_offset

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 44 +++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index 7caf52fdc255..2791126069b4 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1305,6 +1305,34 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 	return true;
 }
 
+static bool check_allowed_ops(Dwarf_Op *ops, size_t nops)
+{
+	/* The first op is checked separately */
+	ops++;
+	nops--;
+
+	/*
+	 * It needs to make sure if the location expression matches to the given
+	 * register and offset exactly.  Thus it rejects any complex expressions
+	 * and only allows a few of selected operators that doesn't change the
+	 * location.
+	 */
+	while (nops) {
+		switch (ops->atom) {
+		case DW_OP_stack_value:
+		case DW_OP_deref_size:
+		case DW_OP_deref:
+		case DW_OP_piece:
+			break;
+		default:
+			return false;
+		}
+		ops++;
+		nops--;
+	}
+	return true;
+}
+
 /* Only checks direct child DIEs in the given scope. */
 static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 {
@@ -1332,25 +1360,31 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 		/* Local variables accessed using frame base register */
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
 		    data->offset >= (int)ops->number &&
+		    check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->offset, ops->number))
 			return DIE_FIND_CB_END;
 
 		/* Only match with a simple case */
 		if (data->reg < DWARF_OP_DIRECT_REGS) {
-			if (ops->atom == (DW_OP_reg0 + data->reg) && nops == 1)
+			/* pointer variables saved in a register 0 to 31 */
+			if (ops->atom == (DW_OP_reg0 + data->reg) &&
+			    check_allowed_ops(ops, nops))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == (DW_OP_breg0 + data->reg) &&
+			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number))
 				return DIE_FIND_CB_END;
 		} else {
+			/* pointer variables saved in a register 32 or above */
 			if (ops->atom == DW_OP_regx && ops->number == data->reg &&
-			    nops == 1)
+			    check_allowed_ops(ops, nops))
 				return DIE_FIND_CB_END;
 
 			/* Local variables accessed by a register + offset */
 			if (ops->atom == DW_OP_bregx && data->reg == ops->number &&
+			    check_allowed_ops(ops, nops) &&
 			    match_var_offset(die_mem, data, data->offset, ops->number2))
 				return DIE_FIND_CB_END;
 		}
@@ -1412,7 +1446,8 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		if (data->addr < ops->number)
 			continue;
 
-		if (match_var_offset(die_mem, data, data->addr, ops->number))
+		if (check_allowed_ops(ops, nops) &&
+		    match_var_offset(die_mem, data, data->addr, ops->number))
 			return DIE_FIND_CB_END;
 	}
 	return DIE_FIND_CB_SIBLING;
@@ -1503,7 +1538,8 @@ int die_get_cfa(Dwarf *dwarf, u64 pc, int *preg, int *poffset)
 		return -1;
 
 	if (!dwarf_cfi_addrframe(cfi, pc, &frame) &&
-	    !dwarf_frame_cfa(frame, &ops, &nops) && nops == 1) {
+	    !dwarf_frame_cfa(frame, &ops, &nops) &&
+	    check_allowed_ops(ops, nops)) {
 		*preg = reg_from_dwarf_op(ops);
 		*poffset = offset_from_dwarf_op(ops);
 		return 0;
-- 
2.43.0.381.gb435a96ce8-goog


