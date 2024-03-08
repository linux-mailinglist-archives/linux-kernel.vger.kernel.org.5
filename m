Return-Path: <linux-kernel+bounces-97543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D77D876BB2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 324F51F21D10
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802E5E065;
	Fri,  8 Mar 2024 20:22:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3E5CDF5;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709929354; cv=none; b=NDuuAmLKlErnXU/xY/COiSL1knGYPcRNrLiYlSiOFfKfLbitAMtVig+2+ciCbze807Rr80opkOg33EXK0U68vLiPJJzJbMhQCfpN6KvDs7ovIooSK14jtkTxd9Pgs0DZJUWvFj0INpxNSuForX/J1RrnAIu58hL6WThIEhO7r0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709929354; c=relaxed/simple;
	bh=YI8/vnqPugKBuZi57m6Pdrz5Fc9pTxcOvLj/2eGyPhk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ktwqHdYxfQwHXiULvnyZ5RdjBI12QDw9qcyKxaPa3x8rCXtLxuybpXliGJ4SmFZiUxlika65XScifnUJIvqCONTawTibBkA8+ZKlVaCiU/x4bdhWkOsXkgbvsW8Jyyp55dxj9IupT+7BR6LOrB00Zf3cLsu3IEP4/U+B07ILTzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4486BC433B1;
	Fri,  8 Mar 2024 20:22:34 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1riglc-00000000yrd-12ic;
	Fri, 08 Mar 2024 15:24:32 -0500
Message-ID: <20240308202432.107909457@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 08 Mar 2024 15:24:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 joel@joelfernandes.org,
 linke li <lilinke99@qq.com>,
 Rabin Vincent <rabin@rab.in>,
 stable@vger.kernel.org
Subject: [PATCH v2 3/6] tracing: Use .flush() call to wake up readers
References: <20240308202402.234176464@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The .release() function does not get called until all readers of a file
descriptor are finished.

If a thread is blocked on reading a file descriptor in ring_buffer_wait(),
and another thread closes the file descriptor, it will not wake up the
other thread as ring_buffer_wake_waiters() is called by .release(), and
that will not get called until the .read() is finished.

The issue originally showed up in trace-cmd, but the readers are actually
other processes with their own file descriptors. So calling close() would wake
up the other tasks because they are blocked on another descriptor then the
one that was closed(). But there's other wake ups that solve that issue.

When a thread is blocked on a read, it can still hang even when another
thread closed its descriptor.

This is what the .flush() callback is for. Have the .flush() wake up the
readers.

Cc: stable@vger.kernel.org
Fixes: f3ddb74ad0790 ("tracing: Wake up ring buffer waiters on closing of the file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d16b95ca58a7..c9c898307348 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8393,6 +8393,20 @@ tracing_buffers_read(struct file *filp, char __user *ubuf,
 	return size;
 }
 
+static int tracing_buffers_flush(struct file *file, fl_owner_t id)
+{
+	struct ftrace_buffer_info *info = file->private_data;
+	struct trace_iterator *iter = &info->iter;
+
+	iter->wait_index++;
+	/* Make sure the waiters see the new wait_index */
+	smp_wmb();
+
+	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
+
+	return 0;
+}
+
 static int tracing_buffers_release(struct inode *inode, struct file *file)
 {
 	struct ftrace_buffer_info *info = file->private_data;
@@ -8404,12 +8418,6 @@ static int tracing_buffers_release(struct inode *inode, struct file *file)
 
 	__trace_array_put(iter->tr);
 
-	iter->wait_index++;
-	/* Make sure the waiters see the new wait_index */
-	smp_wmb();
-
-	ring_buffer_wake_waiters(iter->array_buffer->buffer, iter->cpu_file);
-
 	if (info->spare)
 		ring_buffer_free_read_page(iter->array_buffer->buffer,
 					   info->spare_cpu, info->spare);
@@ -8625,6 +8633,7 @@ static const struct file_operations tracing_buffers_fops = {
 	.read		= tracing_buffers_read,
 	.poll		= tracing_buffers_poll,
 	.release	= tracing_buffers_release,
+	.flush		= tracing_buffers_flush,
 	.splice_read	= tracing_buffers_splice_read,
 	.unlocked_ioctl = tracing_buffers_ioctl,
 	.llseek		= no_llseek,
-- 
2.43.0



