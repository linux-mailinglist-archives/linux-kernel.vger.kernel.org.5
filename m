Return-Path: <linux-kernel+bounces-100784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD87879D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDC9E1F2270D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD05143C53;
	Tue, 12 Mar 2024 21:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CESbpEnm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C803E143C6F;
	Tue, 12 Mar 2024 21:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277367; cv=none; b=e+XKZbDhvpEEkZeFynI60L5Bpqfl/qcwU7IukOqfUxNg9evv958aGAT10ZI0YOatKQ6ganUFsZnszq0Pw4ZY8fZg+LVEeYWhsrYZvqMYzZ3UB2xetDYdGLytzTswPxpPXYqMJuc0OBYZygCCtqWwAxfI6ugmWZ+xAKL3oJR6oaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277367; c=relaxed/simple;
	bh=cWxc6HfjtZV35pUP1FtXOr488JntRQYUGZObUDCOEv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWFNL+KKqnoDf8EDF9p502RbVbOnkUnk3t4X9GmcRb+Nd3UgC4yo9MkzV0e530X9gsFDCWxiPVsjsqC9yVX3/i/nXvhUNHshHdj6eFArbn0U2DSHEKlUe7OlnuPlB/pAQZdV1Vy6ZOfUbEf1r2z2lLih/6RsXSTVT2rMIZvUMeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CESbpEnm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264EEC433F1;
	Tue, 12 Mar 2024 21:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710277367;
	bh=cWxc6HfjtZV35pUP1FtXOr488JntRQYUGZObUDCOEv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CESbpEnmXZEQ+iEpOW9LYfBLzZt1o2ilm+1Nm/vwtm0kAdK/3ie3kE8VwS48JYldc
	 z6eZMKyhJs9pIceZkGClHi+gVvXsUrv2clEQ4b3WsLIJxZeiIL0onr0+3bZwcqc+MO
	 R7siCOMhLo0FcrjHkXL7QaF0SBFTwlfirSg1Elx3pNALGanJpkaQ6JxWZk6CBQ897l
	 MLh9tlYhA7mOjOt3bdnxnvdOsNIRRRyXPwngsgOqL/ieMI/ZQEZ0CwBuGw3zvYK6yS
	 yh+hdQ9sfTTCUDUFbVktDhZtJnRs0oiiewPeAAOOvqYGSFmayBV8ErwV1b3jLCVe+U
	 yI4jLkaudAcTg==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 2/3] uprobes: prepare uprobe args buffer lazily
Date: Tue, 12 Mar 2024 14:02:32 -0700
Message-ID: <20240312210233.1941599-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312210233.1941599-1-andrii@kernel.org>
References: <20240312210233.1941599-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

uprobe_cpu_buffer and corresponding logic to store uprobe args into it
are used for uprobes/uretprobes that are created through tracefs or
perf events.

BPF is yet another user of uprobe/uretprobe infrastructure, but doesn't
need uprobe_cpu_buffer and associated data. For BPF-only use cases this
buffer handling and preparation is a pure overhead. At the same time,
BPF-only uprobe/uretprobe usage is very common in practice. Also, for
a lot of cases applications are very senstivie to performance overheads,
as they might be tracing a very high frequency functions like
malloc()/free(), so every bit of performance improvement matters.

All that is to say that this uprobe_cpu_buffer preparation is an
unnecessary overhead that each BPF user of uprobes/uretprobe has to pay.
This patch is changing this by making uprobe_cpu_buffer preparation
optional. It will happen only if either tracefs-based or perf event-based
uprobe/uretprobe consumer is registered for given uprobe/uretprobe. For
BPF-only use cases this step will be skipped.

We used uprobe/uretprobe benchmark which is part of BPF selftests (see [0])
to estimate the improvements. We have 3 uprobe and 3 uretprobe
scenarios, which vary an instruction that is replaced by uprobe: nop
(fastest uprobe case), `push rbp` (typical case), and non-simulated
`ret` instruction (slowest case). Benchmark thread is constantly calling
user space function in a tight loop. User space function has attached
BPF uprobe or uretprobe program doing nothing but atomic counter
increments to count number of triggering calls. Benchmark emits
throughput in millions of executions per second.

BEFORE these changes
====================
uprobe-nop     :    2.657 ± 0.024M/s
uprobe-push    :    2.499 ± 0.018M/s
uprobe-ret     :    1.100 ± 0.006M/s
uretprobe-nop  :    1.356 ± 0.004M/s
uretprobe-push :    1.317 ± 0.019M/s
uretprobe-ret  :    0.785 ± 0.007M/s

AFTER these changes
===================
uprobe-nop     :    2.732 ± 0.022M/s (+2.8%)
uprobe-push    :    2.621 ± 0.016M/s (+4.9%)
uprobe-ret     :    1.105 ± 0.007M/s (+0.5%)
uretprobe-nop  :    1.396 ± 0.007M/s (+2.9%)
uretprobe-push :    1.347 ± 0.008M/s (+2.3%)
uretprobe-ret  :    0.800 ± 0.006M/s (+1.9)

So the improvements on this particular machine seems to be between 2% and 5%.

  [0] https://github.com/torvalds/linux/blob/master/tools/testing/selftests/bpf/benchs/bench_trigger.c

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 56 ++++++++++++++++++++++---------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a0f60bb10158..f2875349d124 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -963,15 +963,22 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 
 static void __uprobe_trace_func(struct trace_uprobe *tu,
 				unsigned long func, struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb,
+				struct uprobe_cpu_buffer **ucbp,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
 	struct trace_event_buffer fbuffer;
+	struct uprobe_cpu_buffer *ucb;
 	void *data;
 	int size, esize;
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 
+	ucb = *ucbp;
+	if (!ucb) {
+		ucb = prepare_uprobe_buffer(tu, regs);
+		*ucbp = ucb;
+	}
+
 	WARN_ON(call != trace_file->event_call);
 
 	if (WARN_ON_ONCE(tu->tp.size + ucb->dsize > PAGE_SIZE))
@@ -1002,7 +1009,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 /* uprobe handler */
 static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			     struct uprobe_cpu_buffer *ucb)
+			     struct uprobe_cpu_buffer **ucbp)
 {
 	struct event_file_link *link;
 
@@ -1011,7 +1018,7 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
+		__uprobe_trace_func(tu, 0, regs, ucbp, link->file);
 	rcu_read_unlock();
 
 	return 0;
@@ -1019,13 +1026,13 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 				 struct pt_regs *regs,
-				 struct uprobe_cpu_buffer *ucb)
+				 struct uprobe_cpu_buffer **ucbp)
 {
 	struct event_file_link *link;
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, func, regs, ucb, link->file);
+		__uprobe_trace_func(tu, func, regs, ucbp, link->file);
 	rcu_read_unlock();
 }
 
@@ -1353,10 +1360,11 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 
 static void __uprobe_perf_func(struct trace_uprobe *tu,
 			       unsigned long func, struct pt_regs *regs,
-			       struct uprobe_cpu_buffer *ucb)
+			       struct uprobe_cpu_buffer **ucbp)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 	struct uprobe_trace_entry_head *entry;
+	struct uprobe_cpu_buffer *ucb;
 	struct hlist_head *head;
 	void *data;
 	int size, esize;
@@ -1372,6 +1380,12 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	}
 #endif /* CONFIG_BPF_EVENTS */
 
+	ucb = *ucbp;
+	if (!ucb) {
+		ucb = prepare_uprobe_buffer(tu, regs);
+		*ucbp = ucb;
+	}
+
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
 	size = esize + tu->tp.size + ucb->dsize;
@@ -1413,21 +1427,21 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 /* uprobe profile handler */
 static int uprobe_perf_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			    struct uprobe_cpu_buffer *ucb)
+			    struct uprobe_cpu_buffer **ucbp)
 {
 	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
 		return UPROBE_HANDLER_REMOVE;
 
 	if (!is_ret_probe(tu))
-		__uprobe_perf_func(tu, 0, regs, ucb);
+		__uprobe_perf_func(tu, 0, regs, ucbp);
 	return 0;
 }
 
 static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb)
+				struct uprobe_cpu_buffer **ucbp)
 {
-	__uprobe_perf_func(tu, func, regs, ucb);
+	__uprobe_perf_func(tu, func, regs, ucbp);
 }
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
@@ -1492,7 +1506,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
-	struct uprobe_cpu_buffer *ucb;
+	struct uprobe_cpu_buffer *ucb = NULL;
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
@@ -1506,16 +1520,15 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	ucb = prepare_uprobe_buffer(tu, regs);
-
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		ret |= uprobe_trace_func(tu, regs, ucb);
+		ret |= uprobe_trace_func(tu, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		ret |= uprobe_perf_func(tu, regs, ucb);
+		ret |= uprobe_perf_func(tu, regs, &ucb);
 #endif
-	uprobe_buffer_put(ucb);
+	if (ucb)
+		uprobe_buffer_put(ucb);
 	return ret;
 }
 
@@ -1524,7 +1537,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
-	struct uprobe_cpu_buffer *ucb;
+	struct uprobe_cpu_buffer *ucb = NULL;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1536,16 +1549,15 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	ucb = prepare_uprobe_buffer(tu, regs);
-
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		uretprobe_trace_func(tu, func, regs, ucb);
+		uretprobe_trace_func(tu, func, regs, &ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		uretprobe_perf_func(tu, func, regs, ucb);
+		uretprobe_perf_func(tu, func, regs, &ucb);
 #endif
-	uprobe_buffer_put(ucb);
+	if (ucb)
+		uprobe_buffer_put(ucb);
 	return 0;
 }
 
-- 
2.43.0


