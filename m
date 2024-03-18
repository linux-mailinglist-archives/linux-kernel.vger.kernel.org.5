Return-Path: <linux-kernel+bounces-106509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCA587EFA4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CBD31C22230
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19715674C;
	Mon, 18 Mar 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hl232Qto"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C539158225;
	Mon, 18 Mar 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785861; cv=none; b=hYKoexhgomI8nb7wGOmEjRFtjp7hslY8pPBcJXMDYkcVUOk/kkr9CjTNE5bNdIFPAe4vU7lUaLc5ZEfjLea09HBUrTNlW5H4tndxJDd4kDv52rMzUZrki22MPthPOaNXN4gWc/0V6BSDFNM7JHL3r6gY9Ii70k10yQVOqaeviyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785861; c=relaxed/simple;
	bh=N+QKnlom24nxx4m3U7Ngokpd/5eCR5/4mzMX0RqHTDc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8paOyRqdH54Ra4ETQlisyVXGH5WJUuEQh0sn+nmYe3QClXHHh+mKb7mT/HysVl+QmLg/ZKQ42fJWs34GZPGmrQmb4RXlRToJV7geJLHf/pGAVD4yRVH0C5cQMYm9MwByizFXLJqyt0GEqqgGxnfVvrCHsa9v0cOYg67cz67Evo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hl232Qto; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE4CC433F1;
	Mon, 18 Mar 2024 18:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785861;
	bh=N+QKnlom24nxx4m3U7Ngokpd/5eCR5/4mzMX0RqHTDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hl232Qtozjb8fJA30cdeuzbABHCzq6EpHz35MSIHt5+ny1QRlapUz/IMha1UXw32e
	 aln954WJZ4vqlcYs8gDfDieoR7Fqwlbh2hpCZ5tYeLpWEe3AEbH6EmTLiApywO/u3p
	 KBlWC60mJRyDn34HmfvebqtVXL1kabnBNAcCTlMXPyBVteZ/MHEF++mmSIXQUxmW9j
	 23FaRvytAnmaoqFefXoyryvazzuatujD+Z9LIJ8K5KebPL7EcGgPpxcxK7cD2MCTcM
	 CABPBKX9eY+GBa19a7pMzpil/h5sZv2cgrWAmcOsvzalijX3UwCdwRex19PewLWnX7
	 Sazi465Tx2yWA==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	jolsa@kernel.org,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH v2 2/3] uprobes: prepare uprobe args buffer lazily
Date: Mon, 18 Mar 2024 11:17:27 -0700
Message-ID: <20240318181728.2795838-3-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
References: <20240318181728.2795838-1-andrii@kernel.org>
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

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 49 +++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 9bffaab448a6..b5da95240a31 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -941,15 +941,21 @@ static struct uprobe_cpu_buffer *uprobe_buffer_get(void)
 
 static void uprobe_buffer_put(struct uprobe_cpu_buffer *ucb)
 {
+	if (!ucb)
+		return;
 	mutex_unlock(&ucb->mutex);
 }
 
 static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
-						       struct pt_regs *regs)
+						       struct pt_regs *regs,
+						       struct uprobe_cpu_buffer **ucbp)
 {
 	struct uprobe_cpu_buffer *ucb;
 	int dsize, esize;
 
+	if (*ucbp)
+		return *ucbp;
+
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 	dsize = __get_data_size(&tu->tp, regs);
 
@@ -958,22 +964,25 @@ static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
 
 	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
 
+	*ucbp = ucb;
 	return ucb;
 }
 
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
 
 	WARN_ON(call != trace_file->event_call);
 
+	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
 	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
 		return;
 
@@ -1002,7 +1011,7 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 /* uprobe handler */
 static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			     struct uprobe_cpu_buffer *ucb)
+			     struct uprobe_cpu_buffer **ucbp)
 {
 	struct event_file_link *link;
 
@@ -1011,7 +1020,7 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
+		__uprobe_trace_func(tu, 0, regs, ucbp, link->file);
 	rcu_read_unlock();
 
 	return 0;
@@ -1019,13 +1028,13 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
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
 
@@ -1353,10 +1362,11 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 
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
@@ -1374,6 +1384,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
+	ucb = prepare_uprobe_buffer(tu, regs, ucbp);
 	size = esize + ucb->dsize;
 	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
@@ -1410,21 +1421,21 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
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
@@ -1489,7 +1500,7 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
-	struct uprobe_cpu_buffer *ucb;
+	struct uprobe_cpu_buffer *ucb = NULL;
 	int ret = 0;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
@@ -1503,14 +1514,12 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
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
 	uprobe_buffer_put(ucb);
 	return ret;
@@ -1521,7 +1530,7 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 {
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
-	struct uprobe_cpu_buffer *ucb;
+	struct uprobe_cpu_buffer *ucb = NULL;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1533,14 +1542,12 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
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
 	uprobe_buffer_put(ucb);
 	return 0;
-- 
2.43.0


