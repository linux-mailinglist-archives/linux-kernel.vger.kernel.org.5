Return-Path: <linux-kernel+bounces-125465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727F892681
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 22:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB039B219BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7762B13CFA7;
	Fri, 29 Mar 2024 21:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r39vM8QI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EC213CC4C;
	Fri, 29 Mar 2024 21:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711749494; cv=none; b=O5OhXP4NLJQ2FTNg+7GMhVJAwkwYmKzWzSjimT53Qqmmq5C6HCnGvtA61Nv94iEFuu+hEUG5q56fV2V0Ph21uppFNhuXtAJPR7zFL9NFdrNU7wHFFdNr1oF8DqVfBgMs7lJ5mW6Vsd5aUYe6xFQk/jntOD9O+5ExwT52SwvTnAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711749494; c=relaxed/simple;
	bh=Yuksmztv1iAfN+x6okM3pQalu3vHmel1McQJiArxC8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=md+aRUvA0w2kmDxWCV5aA5jVuZ626cUdAtHXsmOMqHEi9ozuL9mJi+R70AyNPTBB2EXwSz7bjE8y1bY/NZIGjbJ1qlLFRSgfeT+7Ae7ngv/A2VYHODcjsEqe+5GHROktbfvBeUHflclBn+wddWflP08EDr1ZGSeVEv0nwgJo3Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r39vM8QI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD25C43390;
	Fri, 29 Mar 2024 21:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711749494;
	bh=Yuksmztv1iAfN+x6okM3pQalu3vHmel1McQJiArxC8Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r39vM8QIkfUs/a0eGQCB598c4fl95aRuAe8k6SZBU1flFYvJlAej4c/ZehBEF1XpU
	 eLaaPuF7CmO8MuaNKoV/AloH7c+5aXKuaOJqzM572pcRH1Jmf9cAgtCgBeon/7K9qL
	 IROC73PuGk+lGlWM1za7Wu5Wksm7O19SCXdWzklUD8rPRfN080KLeRN+mtfxUk7mNR
	 VHA9u1fw11t+YNGaF/oJNBhk9NBLKiLUcBkaqfh5qXC+oE9B4ccJlTWfcNC2RYzTJ5
	 6F1KFuWz+ueZRA4vnm1ldiw7dNUmY31NjvlfdkfTqumJtWEnVPhP0MQ4D3O9awkOTP
	 7abyOwdQ6mUqQ==
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
Subject: [PATCH v2 1/5] perf annotate: Use ins__is_xxx() if possible
Date: Fri, 29 Mar 2024 14:58:08 -0700
Message-ID: <20240329215812.537846-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
In-Reply-To: <20240329215812.537846-1-namhyung@kernel.org>
References: <20240329215812.537846-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is to prepare separation of disasm related code.  Use the public
ins API instead of checking the internal data structure.

Tested-by: Ian Rogers <irogers@google.com>
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


