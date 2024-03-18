Return-Path: <linux-kernel+bounces-106508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8509087EFA1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F17161F23D2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6251655E7C;
	Mon, 18 Mar 2024 18:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMjlvWhe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC135811A;
	Mon, 18 Mar 2024 18:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710785858; cv=none; b=gsaVP1wzquiVgWYKKLFiQLOKYsaIGun7NxgjnYoGXbSP+iTO7Chr/wESn5LeeYlHeZ9twzgYmXkFrluFQHYHon7PU0ojKUXRbFQszeaIrx/8D9IaXONzWdSmuXu9Gh7yuXkCZk6RBgm3Mv7ebmMzDLGhfyVzVrrSzGwNHBbGncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710785858; c=relaxed/simple;
	bh=6NWC2/XoSoHUQNSMpv1Z3Y78LMQHvwFvTzuw0p0Dxxs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fs1UunFV20CuEoJIS4dXOVe8fi6o7s3/daLGimoQmTMuplCTNU0LFC2tJ4zXo562QtVu6bwTAFPns4Dmmfl5Yhep1+1jUJXZsxx5oX/ogpjMBbIxjLAwc9q8Aa1J+yrmPxuDgezklw5uvVpc50ohBxwc7J4NaqLstzdDG0TAGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMjlvWhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1528C43394;
	Mon, 18 Mar 2024 18:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710785858;
	bh=6NWC2/XoSoHUQNSMpv1Z3Y78LMQHvwFvTzuw0p0Dxxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UMjlvWheEmUcg4jSwpcZiqGDL3wywvNzKcL9Iui2fMxnEkQ8mJV80yg66o1vQyEkT
	 H9PD1zvRYA5UZgJqGWIbPnOFTtCzDFAIatGbtX3DbUjjTbTTZBGy0sLEcpST9AxUyp
	 Ih7ubEaQ7+EXHm4pDn2ySb+yMEQCZAqfzFJuAkNUM6dQaVIRiSx3m9NXtb8pyb3SDZ
	 J96kXoQsgsGvxU17XLPF9UWaceYRUgXeLVTd1QqBG55CrCxnsKaRNNE0cVz3Dp2prz
	 NH5Oh8Zl5sWfeC6IRfIAU5COgET6wkwAw8O+IZT0+hEQe+gy9zH2uzZo+37BpqoqU1
	 cN7/I6FxJOsfQ==
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
Subject: [PATCH v2 1/3] uprobes: encapsulate preparation of uprobe args buffer
Date: Mon, 18 Mar 2024 11:17:26 -0700
Message-ID: <20240318181728.2795838-2-andrii@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240318181728.2795838-1-andrii@kernel.org>
References: <20240318181728.2795838-1-andrii@kernel.org>
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

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 kernel/trace/trace_uprobe.c | 78 +++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a84b85d8aac1..9bffaab448a6 100644
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
+	ucb->dsize = tu->tp.size + dsize;
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
+	if (WARN_ON_ONCE(ucb->dsize > PAGE_SIZE))
 		return;
 
 	if (trace_trigger_soft_disabled(trace_file))
 		return;
 
 	esize = SIZEOF_TRACE_ENTRY(is_ret_probe(tu));
-	size = esize + tu->tp.size + dsize;
+	size = esize + ucb->dsize;
 	entry = trace_event_buffer_reserve(&fbuffer, trace_file, size);
 	if (!entry)
 		return;
@@ -977,14 +995,14 @@ static void __uprobe_trace_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
+	memcpy(data, ucb->buf, ucb->dsize);
 
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
+	size = esize + ucb->dsize;
 	size = ALIGN(size + sizeof(u32), sizeof(u64)) - sizeof(u32);
 	if (WARN_ONCE(size > PERF_MAX_TRACE_SIZE, "profile buffer not large enough"))
 		return;
@@ -1379,13 +1397,10 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 		data = DATAOF_TRACE_ENTRY(entry, false);
 	}
 
-	memcpy(data, ucb->buf, tu->tp.size + dsize);
+	memcpy(data, ucb->buf, ucb->dsize);
 
-	if (size - esize > tu->tp.size + dsize) {
-		int len = tu->tp.size + dsize;
-
-		memset(data + len, 0, size - esize - len);
-	}
+	if (size - esize > ucb->dsize)
+		memset(data + ucb->dsize, 0, size - esize - ucb->dsize);
 
 	perf_trace_buf_submit(entry, size, rctx, call->event.type, 1, regs,
 			      head, NULL);
@@ -1395,21 +1410,21 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 
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
@@ -1475,10 +1490,8 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 	int ret = 0;
 
-
 	tu = container_of(con, struct trace_uprobe, consumer);
 	tu->nhit++;
 
@@ -1490,18 +1503,14 @@ static int uprobe_dispatcher(struct uprobe_consumer *con, struct pt_regs *regs)
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
@@ -1513,7 +1522,6 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
 	struct trace_uprobe *tu;
 	struct uprobe_dispatch_data udd;
 	struct uprobe_cpu_buffer *ucb;
-	int dsize, esize;
 
 	tu = container_of(con, struct trace_uprobe, consumer);
 
@@ -1525,18 +1533,14 @@ static int uretprobe_dispatcher(struct uprobe_consumer *con,
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


