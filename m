Return-Path: <linux-kernel+bounces-143209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9711F8A35C8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C681C23CD6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D23F14F9FA;
	Fri, 12 Apr 2024 18:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGRJdUmR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83708142E78;
	Fri, 12 Apr 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712946793; cv=none; b=EWejSM85wUsrZRy6edJ01yLFiXbba2xFPFg+Il0S6ERpEWKX7nm9xzyohJnKw4fLlcfPc71S/NDL6ZoYz45sNRciEp/bxiO4mHNokxLrw+sOdwgrcFr3jykyjgvMSwE2djk+OF1f5IyDUWUZwNP3OEyAM/Z8asF1raqfdCglZcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712946793; c=relaxed/simple;
	bh=d46/j7SfBjlB5pOHNg/gyQVFI44DuFqnaghicJF9/+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfrmTcP6kK342u3EIYTamiBVTSuGKgSnXDLzvW1nf6dgazr09zN83GRlmo+WZK5TF1vq2Uurl9VwCA9M60yyOtt92aKEZQnSJIj9nqyoQVbt4IwE97P2V5efQo6LWHsbPVOfiggYc/oV/+leLcgUsbdKum26z3M1TKjYnerAeZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGRJdUmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 069A6C4AF0F;
	Fri, 12 Apr 2024 18:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712946793;
	bh=d46/j7SfBjlB5pOHNg/gyQVFI44DuFqnaghicJF9/+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGRJdUmRz6JuH14PX2oW4J4iKBjLs5L9muwe1c2FZK29AehqdZ31TOhFYx5EhswF5
	 BsY0I9tseGqOdZPk7PPwZ6IHEeff65pklUfyKU+Um97Wg0rMcBjnw+csgugB9hFBcY
	 4/d/SdQtmJcKigKH8GNQD9+e2d2idRXzcZmISzH4e/EyyoMUwHyXBj1/laeRVFsKV3
	 1HbkK+FZXUBTY/XfRuPyLDgkQ16V07C1ojJZOCJbjcLG8myUlu52tCHCET7deHfNgV
	 FyCLTOs1z0FntzEseAYfggLgmvCfnQpNdVaaOlDYdKoJcUMMlLhdaQlkb3Ut6CaJVe
	 rOHkpCkLIFXcA==
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
Subject: [PATCH 3/4] perf dwarf-aux: Check variable address range properly
Date: Fri, 12 Apr 2024 11:33:09 -0700
Message-ID: <20240412183310.2518474-4-namhyung@kernel.org>
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

In match_var_offset(), it just checked the end address of the variable
with the given offset because it assumed the register holds a pointer
to the data type and the offset starts from the base.

But I found some cases that the stack pointer (rsp = reg7) register is
used to pointer a stack variable while the frame base is maintained by a
different register (rbp = reg6).  In that case, it cannot simply use the
stack pointer as it cannot guarantee that it points to the frame base.
So it needs to check the both boundaries of the variable location.

Before:
  -----------------------------------------------------------
  find data type for 0x7c(reg7) at tcp_getsockopt+0xb62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  no pointer or no type
  check variable "tss" failed (die: 0x7b95801)
   variable location: base reg7, offset=0x110
   type='struct scm_timestamping_internal' size=0x30 (die:0x7b8c126)

So the current code just checks register number for the non-PC and
non-FB registers and assuming it has offset 0.  But this variable has
offset 0x110 so it should not match to this.

After:
  -----------------------------------------------------------
  find data type for 0x7c(reg7) at tcp_getsockopt+0xb62
  CU for net/ipv4/tcp.c (die:0x7b5f516)
  frame base: cfa=0 fbreg=6
  no pointer or no type
  check variable "zc" failed (die: 0x7b9580a)
   variable location: base=reg7, offset=0x40
   type='struct tcp_zerocopy_receive' size=0x40 (die:7b947f4)

Now it find the correct variable "zc".  It was located at reg7 + 0x40
and the size if 0x40 which means it should cover [0x40, 0x80).  And the
access was for reg7 + 0x7c so it found the right one.  But it still
failed to use the variable and it would be handled in the next patch.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/dwarf-aux.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/dwarf-aux.c b/tools/perf/util/dwarf-aux.c
index b361fd7ebd56..40cfbdfe2d75 100644
--- a/tools/perf/util/dwarf-aux.c
+++ b/tools/perf/util/dwarf-aux.c
@@ -1372,6 +1372,9 @@ static bool match_var_offset(Dwarf_Die *die_mem, struct find_var_data *data,
 		return true;
 	}
 
+	if (addr_offset < addr_type)
+		return false;
+
 	if (die_get_real_type(die_mem, &type_die) == NULL)
 		return false;
 
@@ -1446,7 +1449,6 @@ static int __die_find_var_reg_cb(Dwarf_Die *die_mem, void *arg)
 
 		/* Local variables accessed using frame base register */
 		if (data->is_fbreg && ops->atom == DW_OP_fbreg &&
-		    data->offset >= (int)ops->number &&
 		    check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->offset, ops->number,
 				     /*is_pointer=*/false))
@@ -1537,9 +1539,6 @@ static int __die_find_var_addr_cb(Dwarf_Die *die_mem, void *arg)
 		if (ops->atom != DW_OP_addr)
 			continue;
 
-		if (data->addr < ops->number)
-			continue;
-
 		if (check_allowed_ops(ops, nops) &&
 		    match_var_offset(die_mem, data, data->addr, ops->number,
 				     /*is_pointer=*/false))
-- 
2.44.0.683.g7961c838ac-goog


