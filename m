Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699517E618D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjKIAnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjKIAnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BC70C6;
        Wed,  8 Nov 2023 16:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BA41C433CB;
        Thu,  9 Nov 2023 00:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490619;
        bh=74tVzDmLPcHwbDDKMqbOB8N7t7wMHGUYDY+FMXFJ2KU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LekKBPpDKpVAqs69PeoufY+Ll7vEGOQ6UMGe4vq8n0G3YeziGosRPHLqvIhKOkqWl
         TQY08u1shmOVtc/K7G7Z/r42NF4+v2bTZAQ43U+HKUwyn5gzBouHHETsTeek06+uYq
         uU3+H17p9lWYMJ3yPFg8fMeS3H6fAwDf+KTJ0dC3n1kXpJ9xSpNjSbVTPZecZp6z5C
         o2ZoXy72Syup4MIeKwbKil72fV0InZAtQe56am3XRQNFnS8QGNAs3qsPoum2VliQlv
         0FfkR5NSeCbYdoyPOUcHXluW8GjM6kIANxbWYP2If5yDBfMW8P9EtQRl7YYxmUDvFB
         VaEa8QpvEqm8w==
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
Subject: [PATCH RFC 02/10] perf: Remove get_perf_callchain() 'crosstask' argument
Date:   Wed,  8 Nov 2023 16:41:07 -0800
Message-ID: <f2c5130322a419ad04ea328a22fc2908487a1e25.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

get_perf_callchain() doesn't support cross-task unwinding, so it doesn't
make much sense to have 'crosstask' as an argument.  Instead, have
perf_callchain() adjust 'user' accordingly.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 include/linux/perf_event.h | 2 +-
 kernel/bpf/stackmap.c      | 5 ++---
 kernel/events/callchain.c  | 6 +-----
 kernel/events/core.c       | 8 ++++----
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index f4b05954076c..2d8fa253b9df 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1534,7 +1534,7 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark);
+		   u32 max_stack, bool add_mark);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index b0b0fbff7c18..e4827ca5378d 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth,
-				   false, false);
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
 
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
@@ -421,7 +420,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   false, false);
+					   false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 1e135195250c..aa5f9d11c28d 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool crosstask, bool add_mark)
+		   u32 max_stack, bool add_mark)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -209,9 +209,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 
 		if (regs) {
-			if (crosstask)
-				goto exit_put;
-
 			if (add_mark)
 				perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
@@ -219,7 +216,6 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 		}
 	}
 
-exit_put:
 	put_callchain_entry(rctx);
 
 	return entry;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index b0d62df7df4e..5e41a3b70bcd 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7592,16 +7592,16 @@ perf_callchain(struct perf_event *event, struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user;
-	/* Disallow cross-task user callchains. */
-	bool crosstask = event->ctx->task && event->ctx->task != current;
 	const u32 max_stack = event->attr.sample_max_stack;
 	struct perf_callchain_entry *callchain;
 
+	/* Disallow cross-task user callchains. */
+	user &= !event->ctx->task || event->ctx->task == current;
+
 	if (!kernel && !user)
 		return &__empty_callchain;
 
-	callchain = get_perf_callchain(regs, kernel, user,
-				       max_stack, crosstask, true);
+	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
 	return callchain ?: &__empty_callchain;
 }
 
-- 
2.41.0

