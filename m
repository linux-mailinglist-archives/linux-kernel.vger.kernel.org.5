Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A3DE7E6197
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 01:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbjKIAn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 19:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKIAno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 19:43:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C802018E;
        Wed,  8 Nov 2023 16:43:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E93C43397;
        Thu,  9 Nov 2023 00:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699490621;
        bh=oURUhZ94tVLepGPeb4PAIE8X5Cgy1Q4AJy231PK2fX0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SZrVQDr+QQzBAHoxasIgqiHV0GqWsbsa8kMqjChG7olM+iPOxwx0SjBxFBPRN++0T
         Vt1iV9Eoq3QAVnkVzF1Gfs0jCzxipRz8cDXSjYq47ldPKBZtwAtkDAGTe87o/woW3g
         7TVSvFC5dKGoDbmY3aTODF/YnRNAL4/hXduPynHJ+P0XWKu39zD0IGoCSVXYM139pq
         zFKlAtp3KTbXJQuxAIQlR0RnzanfIU20qrhXqj2ycNPVzTQDOXWqShv9KPj3QgJsU6
         B14Z6kFlW/Sw3IvvOxhnI+ykc9vtms2Q+3lxh4El9yyVG1MEoRjoSCf/OByFHR8Kjt
         c2OBKn8gJLuNA==
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
Subject: [PATCH RFC 04/10] perf: Introduce deferred user callchains
Date:   Wed,  8 Nov 2023 16:41:09 -0800
Message-ID: <d5def69b0c88bcbe2a85d0e1fd6cfca62b472ed4.1699487758.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1699487758.git.jpoimboe@kernel.org>
References: <cover.1699487758.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of attempting to unwind user space from the NMI handler, defer
it to run in task context by sending a self-IPI and then scheduling the
unwind to run in the IRQ's exit task work before returning to user space.

This allows the user stack page to be paged in if needed, avoids
duplicate unwinds for kernel-bound workloads, and prepares for SFrame
unwinding (so .sframe sections can be paged in on demand).

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/Kconfig                    |  3 ++
 include/linux/perf_event.h      | 22 ++++++--
 include/uapi/linux/perf_event.h |  1 +
 kernel/bpf/stackmap.c           |  5 +-
 kernel/events/callchain.c       |  7 ++-
 kernel/events/core.c            | 90 ++++++++++++++++++++++++++++++---
 6 files changed, 115 insertions(+), 13 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index f4b210ab0612..690c82212224 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -425,6 +425,9 @@ config HAVE_HARDLOCKUP_DETECTOR_ARCH
 	  It uses the same command line parameters, and sysctl interface,
 	  as the generic hardlockup detectors.
 
+config HAVE_PERF_CALLCHAIN_DEFERRED
+	bool
+
 config HAVE_PERF_REGS
 	bool
 	help
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 2d8fa253b9df..2f232111dff2 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -786,6 +786,7 @@ struct perf_event {
 	struct irq_work			pending_irq;
 	struct callback_head		pending_task;
 	unsigned int			pending_work;
+	unsigned int			pending_unwind;
 
 	atomic_t			event_limit;
 
@@ -1113,7 +1114,10 @@ int perf_event_read_local(struct perf_event *event, u64 *value,
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
-extern struct perf_callchain_entry *perf_callchain(struct perf_event *event, struct pt_regs *regs);
+extern void perf_callchain(struct perf_sample_data *data,
+			   struct perf_event *event, struct pt_regs *regs);
+extern void perf_callchain_deferred(struct perf_sample_data *data,
+				    struct perf_event *event, struct pt_regs *regs);
 
 static inline bool branch_sample_no_flags(const struct perf_event *event)
 {
@@ -1189,6 +1193,7 @@ struct perf_sample_data {
 	u64				data_page_size;
 	u64				code_page_size;
 	u64				aux_size;
+	bool				deferred;
 } ____cacheline_aligned;
 
 /* default value for data source */
@@ -1206,6 +1211,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->sample_flags = PERF_SAMPLE_PERIOD;
 	data->period = period;
 	data->dyn_size = 0;
+	data->deferred = false;
 
 	if (addr) {
 		data->addr = addr;
@@ -1219,7 +1225,11 @@ static inline void perf_sample_save_callchain(struct perf_sample_data *data,
 {
 	int size = 1;
 
-	data->callchain = perf_callchain(event, regs);
+	if (data->deferred)
+		perf_callchain_deferred(data, event, regs);
+	else
+		perf_callchain(data, event, regs);
+
 	size += data->callchain->nr;
 
 	data->dyn_size += size * sizeof(u64);
@@ -1534,12 +1544,18 @@ extern void perf_callchain_user(struct perf_callchain_entry_ctx *entry, struct p
 extern void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
 extern struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark);
+		   u32 max_stack, bool add_mark, bool defer_user);
 extern int get_callchain_buffers(int max_stack);
 extern void put_callchain_buffers(void);
 extern struct perf_callchain_entry *get_callchain_entry(int *rctx);
 extern void put_callchain_entry(int rctx);
 
+#ifdef CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED
+extern void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs);
+#else
+static inline void perf_callchain_user_deferred(struct perf_callchain_entry_ctx *entry, struct pt_regs *regs) {}
+#endif
+
 extern int sysctl_perf_event_max_stack;
 extern int sysctl_perf_event_max_contexts_per_stack;
 
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 39c6a250dd1b..9a1127af4cda 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -1237,6 +1237,7 @@ enum perf_callchain_context {
 	PERF_CONTEXT_HV			= (__u64)-32,
 	PERF_CONTEXT_KERNEL		= (__u64)-128,
 	PERF_CONTEXT_USER		= (__u64)-512,
+	PERF_CONTEXT_USER_DEFERRED	= (__u64)-640,
 
 	PERF_CONTEXT_GUEST		= (__u64)-2048,
 	PERF_CONTEXT_GUEST_KERNEL	= (__u64)-2176,
diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
index e4827ca5378d..fcdd26715b12 100644
--- a/kernel/bpf/stackmap.c
+++ b/kernel/bpf/stackmap.c
@@ -294,8 +294,7 @@ BPF_CALL_3(bpf_get_stackid, struct pt_regs *, regs, struct bpf_map *, map,
 	if (max_depth > sysctl_perf_event_max_stack)
 		max_depth = sysctl_perf_event_max_stack;
 
-	trace = get_perf_callchain(regs, kernel, user, max_depth, false);
-
+	trace = get_perf_callchain(regs, kernel, user, max_depth, false, false);
 	if (unlikely(!trace))
 		/* couldn't fetch the stack trace */
 		return -EFAULT;
@@ -420,7 +419,7 @@ static long __bpf_get_stack(struct pt_regs *regs, struct task_struct *task,
 		trace = get_callchain_entry_for_task(task, max_depth);
 	else
 		trace = get_perf_callchain(regs, kernel, user, max_depth,
-					   false);
+					   false, false);
 	if (unlikely(!trace))
 		goto err_fault;
 
diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index 2bee8b6fda0e..16571c8d6771 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -178,7 +178,7 @@ put_callchain_entry(int rctx)
 
 struct perf_callchain_entry *
 get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
-		   u32 max_stack, bool add_mark)
+		   u32 max_stack, bool add_mark, bool defer_user)
 {
 	struct perf_callchain_entry *entry;
 	struct perf_callchain_entry_ctx ctx;
@@ -207,6 +207,11 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, bool user,
 			regs = task_pt_regs(current);
 		}
 
+		if (defer_user) {
+			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER_DEFERRED);
+			goto exit_put;
+		}
+
 		if (add_mark)
 			perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
 
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 5e41a3b70bcd..290e06b0071c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6751,6 +6751,12 @@ static void perf_pending_irq(struct irq_work *entry)
 	struct perf_event *event = container_of(entry, struct perf_event, pending_irq);
 	int rctx;
 
+	if (!is_software_event(event)) {
+		if (event->pending_unwind)
+			task_work_add(current, &event->pending_task, TWA_RESUME);
+		return;
+	}
+
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -6772,11 +6778,57 @@ static void perf_pending_irq(struct irq_work *entry)
 		perf_swevent_put_recursion_context(rctx);
 }
 
+static void perf_pending_task_unwind(struct perf_event *event)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	struct perf_output_handle handle;
+	struct perf_event_header header;
+	struct perf_sample_data data;
+	struct perf_callchain_entry *callchain;
+
+	callchain = kmalloc(sizeof(struct perf_callchain_entry) +
+			    (sizeof(__u64) * event->attr.sample_max_stack) +
+			    (sizeof(__u64) * 1) /* one context */,
+			    GFP_KERNEL);
+	if (!callchain)
+		return;
+
+	callchain->nr = 0;
+	data.callchain = callchain;
+
+	perf_sample_data_init(&data, 0, event->hw.last_period);
+
+	data.deferred = true;
+
+	perf_prepare_sample(&data, event, regs);
+
+	perf_prepare_header(&header, &data, event, regs);
+
+	if (perf_output_begin(&handle, &data, event, header.size))
+		goto done;
+
+	perf_output_sample(&handle, &header, &data, event);
+
+	perf_output_end(&handle);
+
+done:
+	kfree(callchain);
+}
+
+
 static void perf_pending_task(struct callback_head *head)
 {
 	struct perf_event *event = container_of(head, struct perf_event, pending_task);
 	int rctx;
 
+	if (!is_software_event(event)) {
+		if (event->pending_unwind) {
+			perf_pending_task_unwind(event);
+			event->pending_unwind = 0;
+		}
+		return;
+	}
+
 	/*
 	 * If we 'fail' here, that's OK, it means recursion is already disabled
 	 * and we won't recurse 'further'.
@@ -7587,22 +7639,48 @@ static u64 perf_get_page_size(unsigned long addr)
 
 static struct perf_callchain_entry __empty_callchain = { .nr = 0, };
 
-struct perf_callchain_entry *
-perf_callchain(struct perf_event *event, struct pt_regs *regs)
+void perf_callchain(struct perf_sample_data *data, struct perf_event *event,
+		    struct pt_regs *regs)
 {
 	bool kernel = !event->attr.exclude_callchain_kernel;
 	bool user   = !event->attr.exclude_callchain_user;
 	const u32 max_stack = event->attr.sample_max_stack;
-	struct perf_callchain_entry *callchain;
+	bool defer_user = IS_ENABLED(CONFIG_HAVE_PERF_CALLCHAIN_DEFERRED);
 
 	/* Disallow cross-task user callchains. */
 	user &= !event->ctx->task || event->ctx->task == current;
 
 	if (!kernel && !user)
-		return &__empty_callchain;
+		goto empty;
 
-	callchain = get_perf_callchain(regs, kernel, user, max_stack, true);
-	return callchain ?: &__empty_callchain;
+	data->callchain = get_perf_callchain(regs, kernel, user, max_stack, true, defer_user);
+	if (!data->callchain)
+		goto empty;
+
+	if (user && defer_user && !event->pending_unwind) {
+		event->pending_unwind = 1;
+		irq_work_queue(&event->pending_irq);
+	}
+
+	return;
+
+empty:
+	data->callchain = &__empty_callchain;
+}
+
+void perf_callchain_deferred(struct perf_sample_data *data,
+			     struct perf_event *event, struct pt_regs *regs)
+{
+	struct perf_callchain_entry_ctx ctx;
+
+	ctx.entry		= data->callchain;
+	ctx.max_stack		= event->attr.sample_max_stack;
+	ctx.nr			= 0;
+	ctx.contexts		= 0;
+	ctx.contexts_maxed	= false;
+
+	perf_callchain_store_context(&ctx, PERF_CONTEXT_USER);
+	perf_callchain_user_deferred(&ctx, regs);
 }
 
 static __always_inline u64 __cond_set(u64 flags, u64 s, u64 d)
-- 
2.41.0

