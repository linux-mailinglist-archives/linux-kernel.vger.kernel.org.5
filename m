Return-Path: <linux-kernel+bounces-28560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3321683001A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A1CF28791E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 06:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3DBBE62;
	Wed, 17 Jan 2024 06:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V90naq17"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A0AB65E;
	Wed, 17 Jan 2024 06:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705472820; cv=none; b=tXLdxq/uBvGDZR9HCZrmtLgz5BNtYEF/xZJB6mOgVsw9Mo1KdHLAQlwGx1dG74TtPobzmeAotamEjILRNWbrG0CgOZISW1srXwzUUJIIOdd01X1OM6Oi765+dUg1R8vR8R1JQHRJXdKJomBIpIOOZQ2whnmvsPIHMWt9keuP4RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705472820; c=relaxed/simple;
	bh=j3CQtAHDX8h8w5bN2iELxQFD2yPW0ofGCxfemmbDBys=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=VZZMavaq2zr3JsSy09/vpT5ylzXD78Bd1NmWdBGTMJvnYUHA4ulmJ1GBF1jzQlbI8lWl0E0l2TIeiLbOCC+46IlKcdib6UM4NIXgUy3kQ2UtK4moJjrtFtOnX8XJNosl+awUXWl+ZVAg2Dc5vD5vUXVBrtPbkgQSDTpETr4cb3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V90naq17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8795C43399;
	Wed, 17 Jan 2024 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705472820;
	bh=j3CQtAHDX8h8w5bN2iELxQFD2yPW0ofGCxfemmbDBys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V90naq17OvQUfq9g8qnySLVPR5K69X5jKGiv50opmPunqeCWk9tY97MWOj8tNQj45
	 sOCnnw+TQJYbG4gvQ3C5OCQCC0ETBQPcVi62Z9pcW2Zf0qVrHAa4fHvpOT7bKmlH0N
	 bttOIcBXH4P86fzyjH8o78gnbjrwT6F/uoSlRNnf/tSLuhmOZCzvK8nxE6ZsHFmUod
	 0LPFzSn6ky+0ETNp7OuUYt/Zcse0viI0zDcRjUFRRiXkDagZxogxN9TFLOJSdvx3ao
	 Y+TIEXBCVK/+FgvRLzNgxBRwISNX+hWJlUN1FN3wz9ZwkN5E8/ExN6itrXagBr1y5R
	 OtN58BIrq+zKw==
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
Subject: [PATCH 2/9] perf annotate-data: Handle macro fusion on x86
Date: Tue, 16 Jan 2024 22:26:50 -0800
Message-ID: <20240117062657.985479-3-namhyung@kernel.org>
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

When a sample was come from a conditional branch without a memory
operand, it could be due to a macro fusion with a previous instruction.
So it needs to check the memory operand in the previous one.

This improves the stat like below:

  Annotate data type stats:
  total 294, ok 147 (50.0%), bad 147 (50.0%)
  -----------------------------------------------------------
          30 : no_sym
          32 : no_mem_ops
          71 : no_var
           6 : no_typeinfo
           8 : bad_offset

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 8d761be1a102..0ec42e85ca5c 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3751,6 +3751,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return NULL;
 	}
 
+retry:
 	istat = annotate_data_stat(&ann_insn_stat, dl->ins.name);
 	if (istat == NULL) {
 		ann_data_stat.no_insn++;
@@ -3767,7 +3768,7 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		if (!op_loc->mem_ref)
 			continue;
 
-		/* Recalculate IP since it can be changed due to LOCK prefix */
+		/* Recalculate IP because of LOCK prefix or insn fusion */
 		ip = ms->sym->start + dl->al.offset;
 
 		mem_type = find_data_type(ms, ip, op_loc->reg, op_loc->offset);
@@ -3786,6 +3787,20 @@ struct annotated_data_type *hist_entry__get_data_type(struct hist_entry *he)
 		return mem_type;
 	}
 
+	/*
+	 * Some instructions can be fused and the actual memory access came
+	 * from the previous instruction.
+	 */
+	if (dl->al.offset > 0) {
+		struct disasm_line *prev_dl;
+
+		prev_dl = list_prev_entry(dl, al.node);
+		if (ins__is_fused(arch, prev_dl->ins.name, dl->ins.name)) {
+			dl = prev_dl;
+			goto retry;
+		}
+	}
+
 	ann_data_stat.no_mem_ops++;
 	istat->bad++;
 	return NULL;
-- 
2.43.0.381.gb435a96ce8-goog


