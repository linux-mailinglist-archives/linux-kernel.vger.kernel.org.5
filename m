Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1164F7E618C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232111AbjKIAno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230515AbjKIAnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88DB418E;
        Wed,  8 Nov 2023 16:43:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9534DC433C9;
        Thu,  9 Nov 2023 00:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490619;
        bh=4+3ZnMlsc/QpNeAUS1yS0d/MnrzAaX9AOG0Qj3+lXzU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKAGQWH3CcMl08puONswfb5ftsDQf75y295GZbojL3VfiIeY6vg1VEB7aoHCCd7Lv
         M/BesqpG6Io/cpueK6CzvYyuWe7n70LK3plfTLc0sMBHBdQQ2fBZVLHtDxeROfDYtf
         00tt1/+7+CCJlr62wDeOtDZwGJD2pJntLDJb/Bj9p39Gh4Em8rF5xPUmiV9UwlXoIl
         mGim56lCK1BkdUvjiz12z1wqCA0xw0u4+6xatapMLRvAsv3kTA1N/kXMwptFBRnVXw
         +mFhB9SQRWGXN0RLnSV4+x5kqVs0RA7JQwrSp9EG+/7AR5SelF3IOYGCFANj+644bl
         Boubij6+Nv2ow==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Indu Bhagat <indu.bhagat@oracle.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-toolchains@vger.kernel.org
Subject: [PATCH RFC 01/10] perf: Remove get_perf_callchain() 'init_nr' argument
Date:   Wed,  8 Nov 2023 16:41:06 -0800
Message-ID: <b9e939c77fa74baec8d1b2d3001958f12ef16eb9.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'init_nr' argument has double duty: it's used to initialize both the
number of contexts and the number of stack entries.  That's confusing
and the callers always pass zero anyway.  Hard code the zero.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/perf_event.h |  2 +-
 kernel/bpf/stackmap.c      |  4 ++--
 kernel/events/callchain.c  | 12 ++++++------
 kernel/events/core.c       |  2 +-
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index afb028c54f33..f4b05954076c 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1533,7 +1533,7 @@ DECLARE_PER_CPU(struct perf_callchain_entry, perf_callchain_entry);
 extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index d6b277482085..b0b0fbff7c18 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -294,7 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+	trace = get_perf_callchain(regs, kernel, user, max_depth,
 				   false, false);
 
 	if (unlikely(!trace))
@@ -420,7 +420,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 	else if (kernel && task)
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
-		trace = get_perf_callchain(regs, 0, kernel, user, max_depth,
+		trace = get_perf_callchain(regs, kernel, user, max_depth,
 					   false, false);
 	if (unlikely(!trace))
 		goto err_fault;
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1273be84392c..1e135195250c 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -177,7 +177,7 @@ put_callchain_entry(int rctx)
 }
 
 struct perf_callchain_entry *
-get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
+get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		   u32 max_stack, bool crosstask, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
@@ -188,11 +188,11 @@ get_perf_callchain(struct pt_regs *regs, u32 init_nr, bool kernel, bool user,
 	if (!entry)
 		return NULL;
 
-	ctx.entry     = entry;
-	ctx.max_stack = max_stack;
-	ctx.nr	      = entry->nr = init_nr;
-	ctx.contexts       = 0;
-	ctx.contexts_maxed = false;
+	ctx.entry		= entry;
+	ctx.max_stack		= max_stack;
+	ctx.nr			= entry->nr = 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
 
 	if (kernel && !user_mode(regs)) {
 		if (add_mark)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 683dc086ef10..b0d62df7df4e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7600,7 +7600,7 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, 0, kernel, user,
+	callchain = get_perf_callchain(regs, kernel, user,
 				       max_stack, crosstask, true);
 	return callchain ?: &__empty_callchain;
 }
-- 
2.41.0

