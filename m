Return-Path: <linux-kernel+bounces-165996-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCA8B9477
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17F228400E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA89286BD;
	Thu,  2 May 2024 06:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BldDkGuw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401E224F2;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629614; cv=none; b=gQun2ZmXeew5thr/XJtJfmCrcCWIZfcWpUyyiO12fdMXdIqOLIqHIHnN0X7eog3jJEKsAr9uGL5ewaPgJReCY7VPPZ0ltnwsnwlpPoG9OZcT9IJTY/gUksaG66nftOaG4CzsflCp1R5bjHdKv2jXfbI+KhCLIz3I5IFOoU6Y1dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629614; c=relaxed/simple;
	bh=SSyYuDfAIqFwr0E0S0Wr/ukwLpvby2PoPSUWIQ8hahY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlX4QOvqQw8HKhLAeg6HopJoEjJ7lIE9yZL+4Qx3nHclZJMe/jyKKFt+oz3xLRc0PbNOMDVtpZmo9IR/LUkGnNJuuwwU2DIetmJfymxblaog8mNFTM5mfejcsBAmmiyuj3tdmmV8hxBOvhBU1cKlYxAGsgx1+OBWLFHy2IRP+Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BldDkGuw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09099C4AF49;
	Thu,  2 May 2024 06:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714629614;
	bh=SSyYuDfAIqFwr0E0S0Wr/ukwLpvby2PoPSUWIQ8hahY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BldDkGuwbfyaEA5Fxssr4aaABm0kVEWzAu8kv5Y2r8J/bvNwhvx4Eohi0O0wCcWr7
	 Dtymvpr3xI1XO7qki2JuNYMcT0ZNEXPjjHUsrbIy78bcXpxSZ+iOInr8TXXAbMddEU
	 sF31DmxWeRjlsUMZRsfB34LvJhgnUW/uGaCS5w1jieRnUUgs1kImZyjRYdH1j4gR2S
	 U9TZwG+xFL8WNKLspg0nyWUY1luxvEWs9sK41dj/4GUR/hysVKVsTznxDzxA8ZO5AI
	 3Xx1h4E1T6pyABWHxQ7XP920YTnJSUQxM6mKrUsKlkM4GQv4r7Y82kqxEcIl+VUW3+
	 GFLhzH0US3UsQ==
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
Subject: [PATCH 3/6] perf annotate-data: Handle direct global variable access
Date: Wed,  1 May 2024 23:00:08 -0700
Message-ID: <20240502060011.1838090-4-namhyung@kernel.org>
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

Like per-cpu base offset array, sometimes it accesses the global
variable directly using the offset.  Allow this type of instructions as
long as it finds a global variable for the address.

  movslq  %edi, %rcx
  mov     -0x7dc94ae0(,%rcx,8), %rcx   <<<--- here

As %rcx has a valid type (i.e. array index) from the first instruction,
it will be checked by the first case in check_matching_type().  But as
it's not a pointer type, the match will fail.  But in this case, it
should check if it accesses the kernel global array variable.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/util/annotate-data.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate-data.c b/tools/perf/util/annotate-data.c
index 4dd0911904f2..f1e52a531563 100644
--- a/tools/perf/util/annotate-data.c
+++ b/tools/perf/util/annotate-data.c
@@ -1256,14 +1256,19 @@ static int check_matching_type(struct type_state *state,
 	if (state->regs[reg].ok && state->regs[reg].kind == TSR_KIND_TYPE) {
 		int tag = dwarf_tag(&state->regs[reg].type);
 
-		pr_debug_dtp("\n");
-
 		/*
 		 * Normal registers should hold a pointer (or array) to
 		 * dereference a memory location.
 		 */
-		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type)
+		if (tag != DW_TAG_pointer_type && tag != DW_TAG_array_type) {
+			if (dloc->op->offset < 0 && reg != state->stack_reg)
+				goto check_kernel;
+
+			pr_debug_dtp("\n");
 			return -1;
+		}
+
+		pr_debug_dtp("\n");
 
 		/* Remove the pointer and get the target type */
 		if (die_get_real_type(&state->regs[reg].type, type_die) == NULL)
@@ -1376,12 +1381,14 @@ static int check_matching_type(struct type_state *state,
 		return -1;
 	}
 
-	if (map__dso(dloc->ms->map)->kernel && arch__is(dloc->arch, "x86")) {
+check_kernel:
+	if (map__dso(dloc->ms->map)->kernel) {
 		u64 addr;
 		int offset;
 
 		/* Direct this-cpu access like "%gs:0x34740" */
-		if (dloc->op->segment == INSN_SEG_X86_GS && dloc->op->imm) {
+		if (dloc->op->segment == INSN_SEG_X86_GS && dloc->op->imm &&
+		    arch__is(dloc->arch, "x86")) {
 			pr_debug_dtp(" this-cpu var\n");
 
 			addr = dloc->op->offset;
@@ -1394,17 +1401,13 @@ static int check_matching_type(struct type_state *state,
 			return -1;
 		}
 
-		/* Access to per-cpu base like "-0x7dcf0500(,%rdx,8)" */
+		/* Access to global variable like "-0x7dcf0500(,%rdx,8)" */
 		if (dloc->op->offset < 0 && reg != state->stack_reg) {
-			const char *var_name = NULL;
-
 			addr = (s64) dloc->op->offset;
 
-			if (get_global_var_info(dloc, addr, &var_name, &offset) &&
-			    !strcmp(var_name, "__per_cpu_offset") && offset == 0 &&
-			    get_global_var_type(cu_die, dloc, dloc->ip, addr,
+			if (get_global_var_type(cu_die, dloc, dloc->ip, addr,
 						&offset, type_die)) {
-				pr_debug_dtp(" percpu base\n");
+				pr_debug_dtp(" global var\n");
 
 				dloc->type_offset = offset;
 				return 1;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


