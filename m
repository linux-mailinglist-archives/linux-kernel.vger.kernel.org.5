Return-Path: <linux-kernel+bounces-107044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D5A87F6F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C56752824A7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C88004B;
	Tue, 19 Mar 2024 05:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYZ2Wykl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FB87FBDA;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710827488; cv=none; b=S06hQFiZOLqlYPAoJ/dfqXxEKrnAo2yCGbChRc7sbjiuSST2suJ4tDu0o79noAo97lZcDGvbCdoJqoqZ4NZ45hUp1+igxAFxI+vhTWX4chK6aQk8v0lHWbfkhhjW2XhJhGXtmeN2qxDHHYCZBm0KW8q1Dtj5hohkByRhI/nhOvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710827488; c=relaxed/simple;
	bh=QJ4b60uS7SiZLvE/zbDFsQPiZ25HBF3r++1i4MMpgTA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tZT+vrU+pPWOKZcIkctBxT+qFH3K5MoZ+hQzk/6y6DeirJzERi7AE2orKfMA6vMBr6gCYQDbGQeV3hrFhFKtmULC2w5h8C7l0j4Lg23jkPA8BGZ+KwnenAS4pHRmrmn51UE6TcxTiOGk5DSETwTOBj8Q2lM1vx19RnxU0jThwDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYZ2Wykl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DEFC433B1;
	Tue, 19 Mar 2024 05:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710827488;
	bh=QJ4b60uS7SiZLvE/zbDFsQPiZ25HBF3r++1i4MMpgTA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYZ2Wyklr7jGA4Sm0WPc83O20209o9s4aDfl3HgrXKIkf2MviUUypU4oFm0vVvDNo
	 ROSF97my3G2XcFfXGrpEzSo7e5ZLYsqBjN6bPXVoFoWq5BdpkUL1xqCxuioDJRYLCZ
	 b4++XkS9k+wo+hxW2pjPuVCj95K2pbZ8k5DgBhcLHpW9FdQtVLl4/kdpWmPqfk25Gt
	 PTjxRV1VFHtMrJ10kNExh8Pce7Ke/loo+J3rDMWcKAjNtBuTzGOk0Q8mmLUl5KKHxJ
	 nneWuQo9IPtlV5/eJZ7gkFHKLUKl4AhXthVrptZ/iA/WT3p75T53N1kogNdBdSe3XK
	 kZQfH7bFL2wtA==
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
Subject: [PATCH 18/23] perf annotate-data: Track instructions with a this-cpu variable
Date: Mon, 18 Mar 2024 22:51:10 -0700
Message-ID: <20240319055115.4063940-19-namhyung@kernel.org>
X-Mailer: git-send-email 2.44.0.291.gc1ea87d7ee-goog
In-Reply-To: <20240319055115.4063940-1-namhyung@kernel.org>
References: <20240319055115.4063940-1-namhyung@kernel.org>
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
 tools/perf/util/annotate-data.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index d57622ddd5d3..48fea0c716ef 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -553,12 +553,41 @@ static void update_insn_state_x86(struct type_state *state,
 			fbreg = -1;
 	}
 
-	/* Case 1. register to register transfers */
+	/* Case 1. register to register or segment:offset to register transfers */
 	if (!src->mem_ref && !dst->mem_ref) {
 		if (!has_reg_type(state, dst->reg1))
 			return;
 
 		tsr = &state->regs[dst->reg1];
+		if (map__dso(dloc->ms->map)->kernel &&
+		    src->segment == INSN_SEG_X86_GS && src->imm) {
+			u64 ip = dloc->ms->sym->start + dl->al.offset;
+			u64 var_addr;
+			int offset;
+
+			/*
+			 * In kernel, %gs points to a per-cpu region for the
+			 * current CPU.  Access with a constant offset should
+			 * be treated as a global variable access.
+			 */
+			var_addr = src->offset;
+
+			if (!get_global_var_type(cu_die, dloc, ip, var_addr,
+						 &offset, &type_die) ||
+			    !die_get_member_type(&type_die, offset, &type_die)) {
+				tsr->ok = false;
+				return;
+			}
+
+			tsr->type = type_die;
+			tsr->ok = true;
+
+			pr_debug_dtp("mov [%x] this-cpu addr=%#"PRIx64" -> reg%d",
+				     insn_offset, var_addr, dst->reg1);
+			pr_debug_type_name(&tsr->type);
+			return;
+		}
+
 		if (!has_reg_type(state, src->reg1) ||
 		    !state->regs[src->reg1].ok) {
 			tsr->ok = false;
-- 
2.44.0.291.gc1ea87d7ee-goog


