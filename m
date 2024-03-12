Return-Path: <linux-kernel+bounces-100783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCB5879D2D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF1BE1F22812
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B514372A;
	Tue, 12 Mar 2024 21:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIcL3Byx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405B143C53;
	Tue, 12 Mar 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710277364; cv=none; b=ntLORRI3jhsE10idcQcRe8IX+j5IKQp7kWMx+jbMBVmqRR05T//3CX64PkzwTkLOpxDy+gJd+HEPChc95KdO5WXzL/lZmnk4BbeLjbUkuG/mW6P4L3OUdmcEpccGUQUQxs4br03mlcALalWYfj6PBYnPKTyBPQLMkSbnkvQflbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710277364; c=relaxed/simple;
	bh=DqnnOwIsu05TmATP+pSDg1OVjB3WtRWW2rjVSAX2XJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEYUUDFTPo6KvMH0JYEzNrcgExlkRvnfwYVqARUjWf+KAH9buln7rXayT/9GoC0iHqbCbRRmgs4KbymR/V1hmcoVxYNRouBtr0FDWl+Cgl6N+rOh6zKkfn1INZs1Tn5KDQCIe02GHIMIYsqDoFG0Lv5U8Q8lYnmeI/FQgO0bxkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIcL3Byx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7784C433F1;
	Tue, 12 Mar 2024 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710277364;
	bh=DqnnOwIsu05TmATP+pSDg1OVjB3WtRWW2rjVSAX2XJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIcL3ByxMuBEY/D/cPs5OOmD+Kls+MxZYdnEnPUnm5QTBlgqgAJdjpBzpnNwbvb/J
	 yjJjX/fZfel2Nqpxh2fEPubghl/fHjI5iUY8eFZz1HUopznV/FQsUFsBw+6k6JVf+K
	 Zo8d1EDcirL63HgrHi/7UBT3t6NnZ3WtX8GseXD+Nbx/g4ePI3Wd6ISnUqkn1XMY9W
	 W/v++RJEljTQfgv5dDzOYJgme18/W0vwByxaIjuJHW6ny9zkRBjYJMtQ2QhpKJiRos
	 f7wiNTB1lkRkbEy6Z/2h5Cf6kPt2AW0CalMc2i4XeHrdxh84Z0MnHvxvcFXDX7AUIL
	 HTSAzt+Uwklbw==
From: Andrii Nakryiko <andrii@kernel.org>
To: linux-trace-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: bpf@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	oleg@redhat.com,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH bpf-next 1/3] uprobes: encapsulate preparation of uprobe args buffer
Date: Tue, 12 Mar 2024 14:02:31 -0700
Message-ID: <20240312210233.1941599-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240312210233.1941599-1-andrii@kernel.org>
References: <20240312210233.1941599-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the logic of fetching temporary per-CPU uprobe buffer and storing
uprobes args into it to a new helper function. Store data size as part
of this buffer, simplifying interfaces a bit, as now we only pass single
uprobe_cpu_buffer reference around, instead of pointer + dsize.

This logic was duplicated across uprobe_dispatcher and uretprobe_dispatcher,
and now will be centralized. All this is also in preparation to make
this uprobe_cpu_buffer handling logic optional in the next patch.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 75 ++++++++++++++++++++-----------------
 1 file changed, 41 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a84b85d8aac1..a0f60bb10158 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -854,6 +854,7 @@ static const struct file_operations uprobe_profile_ops = {
 struct uprobe_cpu_buffer {
 	struct mutex mutex;
 	void *buf;
+	int dsize;
 };
 static struct uprobe_cpu_buffer __percpu *uprobe_cpu_buffer;
 static int uprobe_buffer_refcnt;
@@ -943,9 +944,26 @@ static void uprobe_buffer_put(struct uprobe_cpu_buffer *ucb)
 	mutex_unlock(&ucb->mutex);
 }
 
+static struct uprobe_cpu_buffer *prepare_uprobe_buffer(struct trace_uprobe *tu,
+						       struct pt_regs *regs)
+{
+	struct uprobe_cpu_buffer *ucb;
+	int dsize, esize;
+
+	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
+	dsize = __get_data_size(&tu->tp, regs);
+
+	ucb = uprobe_buffer_get();
+	ucb->dsize = dsize;
+
+	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+
+	return ucb;
+}
+
 static void __uprobe_trace_func(struct trace_uprobe *tu,
 				unsigned long func, struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb, int dsize,
+				struct uprobe_cpu_buffer *ucb,
 				struct trace_event_file *trace_file)
 {
 	struct uprobe_trace_entry_head *entry;
@@ -956,14 +974,14 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 
 	WARN_ON(call != trace_file->event_call);
 
-	if (WARN_ON_ONCE(tu->tp.size + dsize > PAGE_SIZE))
+	if (WARN_ON_ONCE(tu->tp.size + ucb->dsize > PAGE_SIZE))
 		return;
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-	size = esize + tu->tp.size + dsize;
+	size = esize + tu->tp.size + ucb->dsize;
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
 		return;
@@ -977,14 +995,14 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
+	memcpy(data, ucb->buf, tu->tp.size + ucb->dsize);
 
 	trace_event_buffer_commit(&fbuffer);
 }
 
 /* uprobe handler */
 static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			     struct uprobe_cpu_buffer *ucb, int dsize)
+			     struct uprobe_cpu_buffer *ucb)
 {
 	struct event_file_link *link;
 
@@ -993,7 +1011,7 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, 0, regs, ucb, dsize, link->file);
+		__uprobe_trace_func(tu, 0, regs, ucb, link->file);
 	rcu_read_unlock();
 
 	return 0;
@@ -1001,13 +1019,13 @@ static int uprobe_trace_func(struct trace_uprobe *tu, struct pt_regs *regs,
 
 static void uretprobe_trace_func(struct trace_uprobe *tu, unsigned long func,
 				 struct pt_regs *regs,
-				 struct uprobe_cpu_buffer *ucb, int dsize)
+				 struct uprobe_cpu_buffer *ucb)
 {
 	struct event_file_link *link;
 
 	rcu_read_lock();
 	trace_probe_for_each_link_rcu(link, &tu->tp)
-		__uprobe_trace_func(tu, func, regs, ucb, dsize, link->file);
+		__uprobe_trace_func(tu, func, regs, ucb, link->file);
 	rcu_read_unlock();
 }
 
@@ -1335,7 +1353,7 @@ static bool uprobe_perf_filter(struct uprobe_consumer *uc,
 
 static void __uprobe_perf_func(struct trace_uprobe *tu,
 			       unsigned long func, struct pt_regs *regs,
-			       struct uprobe_cpu_buffer *ucb, int dsize)
+			       struct uprobe_cpu_buffer *ucb)
 {
 	struct trace_event_call *call = trace_probe_event_call(&tu->tp);
 	struct uprobe_trace_entry_head *entry;
@@ -1356,7 +1374,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
 
-	size = esize + tu->tp.size + dsize;
+	size = esize + tu->tp.size + ucb->dsize;
 	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
 		return;
@@ -1379,10 +1397,10 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
+	memcpy(data, ucb->buf, tu->tp.size + ucb->dsize);
 
-	if (size - esize > tu->tp.size + dsize) {
-		int len = tu->tp.size + dsize;
+	if (size - esize > tu->tp.size + ucb->dsize) {
+		int len = tu->tp.size + ucb->dsize;
 
 		memset(data + len, 0, size - esize - len);
 	}
@@ -1395,21 +1413,21 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
 /* uprobe profile handler */
 static int uprobe_perf_func(struct trace_uprobe *tu, struct pt_regs *regs,
-			    struct uprobe_cpu_buffer *ucb, int dsize)
+			    struct uprobe_cpu_buffer *ucb)
 {
 	if (!uprobe_perf_filter(&tu->consumer, 0, current->mm))
 		return UPROBE_HANDLER_REMOVE;
 
 	if (!is_ret_probe(tu))
-		__uprobe_perf_func(tu, 0, regs, ucb, dsize);
+		__uprobe_perf_func(tu, 0, regs, ucb);
 	return 0;
 }
 
 static void uretprobe_perf_func(struct trace_uprobe *tu, unsigned long func,
 				struct pt_regs *regs,
-				struct uprobe_cpu_buffer *ucb, int dsize)
+				struct uprobe_cpu_buffer *ucb)
 {
-	__uprobe_perf_func(tu, func, regs, ucb, dsize);
+	__uprobe_perf_func(tu, func, regs, ucb);
 }
 
 int bpf_get_uprobe_info(const struct perf_event *event, u32 *fd_type,
@@ -1475,10 +1493,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 	int ret = 0;
 
-
 	tu = container_of(con, struct trace_uprobe, consumer);
 	tu->nhit++;
 
@@ -1490,18 +1506,14 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
-	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-
-	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	ucb = prepare_uprobe_buffer(tu, regs);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		ret |= uprobe_trace_func(tu, regs, ucb, dsize);
+		ret |= uprobe_trace_func(tu, regs, ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		ret |= uprobe_perf_func(tu, regs, ucb, dsize);
+		ret |= uprobe_perf_func(tu, regs, ucb);
 #endif
 	uprobe_buffer_put(ucb);
 	return ret;
@@ -1513,7 +1525,6 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1525,18 +1536,14 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	if (WARN_ON_ONCE(!uprobe_cpu_buffer))
 		return 0;
 
-	dsize = __get_data_size(&tu->tp, regs);
-	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-
-	ucb = uprobe_buffer_get();
-	store_trace_args(ucb->buf, &tu->tp, regs, esize, dsize);
+	ucb = prepare_uprobe_buffer(tu, regs);
 
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_TRACE))
-		uretprobe_trace_func(tu, func, regs, ucb, dsize);
+		uretprobe_trace_func(tu, func, regs, ucb);
 
 #ifdef CONFIG_PERF_EVENTS
 	if (trace_probe_test_flag(&tu->tp, TP_FLAG_PROFILE))
-		uretprobe_perf_func(tu, func, regs, ucb, dsize);
+		uretprobe_perf_func(tu, func, regs, ucb);
 #endif
 	uprobe_buffer_put(ucb);
 	return 0;
-- 
2.43.0


