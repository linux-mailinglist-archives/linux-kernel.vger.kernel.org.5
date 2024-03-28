Return-Path: <linux-kernel+bounces-123818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A569D890E6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6FC1F24D17
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C91D137753;
	Thu, 28 Mar 2024 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDCIYGHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15257F471;
	Thu, 28 Mar 2024 23:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668011; cv=none; b=JErVEhesqi1WXXi7Kk1HzRm8jCd5tmb3meVk9BhAao/QQFennYwYJJd/KZ/CoPdvcK7toVeinLcrSDeMn3gqYL3Sx/7KKHzZKw9UjD/Gt9WF7XEU2n//efL7S/+/05KskocG4fPDF0tIE6I8tO+Qeo54Cof3QLhT/8yNdKyD8FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668011; c=relaxed/simple;
	bh=Le/6DqZN+PpjTvtonv6SHoMB847GalZIUlDBHCdNYKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQnWVhllVh1lMn0fa2sdzTceVErhcPU1wJqSLxOiJ3QNRlpiC/5C1cWYJaXQEHPGK1VvANWMzRi+4F4kprQaJq26aWjoNKrxR/rJCqZc4Oo7iSwqseUttBuQD7RZX2QH3cc5Iv6uYYcFW1W873GE/O5IVLjY2B3a1gNhWXrsXEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDCIYGHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E741CC433A6;
	Thu, 28 Mar 2024 23:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711668011;
	bh=Le/6DqZN+PpjTvtonv6SHoMB847GalZIUlDBHCdNYKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gDCIYGHjpl901r/xSMvH/8c0KQ99TPWM3copLg4ZT43+Gsnjv/jczE+hx75RykQSR
	 c+/ov86G6TAu9vcR71LMaW+eWXW2nhCCNFHGtJnJY9BYyyF7258sGW5/eUQbXhmoMV
	 GCwe9VQVfdbzcMgOJ5CLP1gFnrpqwS5sqFcH7re3ye5Je+7k5V9RrEjaXiNI/EfY8e
	 o6ZmiaYObg0HRjuNTse8e4JDYniGXlIVysFfsD70SHt0fXtjQ5vY6l1IQYKJB8iH4o
	 itbIDJIdQePIUnH4GiYM6v8pqm0B42BpnyoPEfw+PfzBJIKNCKnmit8YKbdL6iwSrF
	 BYzLzh5gFLueg==
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
Subject: [PATCH 1/4] perf annotate: Use ins__is_xxx() if possible
Date: Thu, 28 Mar 2024 16:20:06 -0700
Message-ID: <20240328232009.466018-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240328232009.466018-1-namhyung@kernel.org>
References: <20240328232009.466018-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare separation of disasm related code.  Use the public
ins API instead of checking the internal data structure.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 64e54ff1aa1d..986c499150ef 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -3665,7 +3665,7 @@ int annotate_get_insn_location(struct arch *arch, struct disasm_line *dl,
 	struct annotated_op_loc *op_loc;
 	int i;
 
-	if (!strcmp(dl->ins.name, "lock"))
+	if (ins__is_lock(&dl->ins))
 		ops = dl->ops.locked.ops;
 	else
 		ops = &dl->ops;
@@ -3763,7 +3763,7 @@ static struct disasm_line *find_disasm_line(struct symbol *sym, u64 ip,
 			 * llvm-objdump places "lock" in a separate line and
 			 * in that case, we want to get the next line.
 			 */
-			if (!strcmp(dl->ins.name, "lock") &&
+			if (ins__is_lock(&dl->ins) &&
 			    *dl->ops.raw == '\0' && allow_update) {
 				ip++;
 				continue;
@@ -4093,10 +4093,10 @@ static bool process_basic_block(struct basic_block_data *bb_data,
 		if (dl == last_dl)
 			break;
 		/* 'return' instruction finishes the block */
-		if (dl->ins.ops == &ret_ops)
+		if (ins__is_ret(&dl->ins))
 			break;
 		/* normal instructions are part of the basic block */
-		if (dl->ins.ops != &jump_ops)
+		if (!ins__is_jump(&dl->ins))
 			continue;
 		/* jump to a different function, tail call or return */
 		if (dl->ops.target.outside)
-- 
2.44.0.478.gd926399ef9-goog


