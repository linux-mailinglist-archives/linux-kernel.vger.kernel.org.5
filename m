Return-Path: <linux-kernel+bounces-91623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B609871452
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B56341F213C2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 03:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8041F381C6;
	Tue,  5 Mar 2024 03:32:46 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1860E2F44;
	Tue,  5 Mar 2024 03:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709609566; cv=none; b=Np7rGY5lTwivMX9bVDpwPlf6ryIDGgZNOZKLl++6BrGZKXxmlf1ZkyFhOwkt3X8anBJBks1IDNkLi48UDRzrrk8AEUZsfaBOh7D/1RQZJ4QlyFMFPLdtqQaHaAV99IRJuZlm6OUBEmIO6O2iigIayMrNBs/JKXHucfUahYVz86Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709609566; c=relaxed/simple;
	bh=cX8NBhzPtSej8jgrGTppfGMMCbZxG13SiFGh+FuLuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qb5gD+2OjRWr6kTT2x4WS5pFBXjuKe6n/wK7XHUbRGoWv1BysMpOUR8w9Go+01M+uRpQIRf2YhPGhaQqYThiJBwk2ngXKoN6j+1YB7U5faPpyTGKDvPhym47UMHisuZxDXtfFjwi4BToIR9J0Xs0Ovwo+kgryCoAUmf/JGoy9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14BDC43390;
	Tue,  5 Mar 2024 03:32:44 +0000 (UTC)
Date: Mon, 4 Mar 2024 22:34:33 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH v2] tracing: Limit trace_marker writes to just 4K
Message-ID: <20240304223433.4ba47dff@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Limit the max print event of trace_marker to just 4K string size. This must
also be less than the amount that can be held by a trace_seq along with
the text that is before the output (like the task name, PID, CPU, state,
etc). As trace_seq is made to handle large events (some greater than 4K).
Make the max size of a trace_marker write event be 4K which is guaranteed
to fit in the trace_seq buffer.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240304192710.4c99677c@gandalf.local.home/

- Just make the max limit 4K and not half of the trace_seq size.
  The trace_seq is already made to handle events greater than 4k.

 kernel/trace/trace.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..d16b95ca58a7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7293,6 +7293,8 @@ tracing_free_buffer_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+#define TRACE_MARKER_MAX_SIZE		4096
+
 static ssize_t
 tracing_mark_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7320,6 +7322,9 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if ((ssize_t)cnt < 0)
 		return -EINVAL;
 
+	if (cnt > TRACE_MARKER_MAX_SIZE)
+		cnt = TRACE_MARKER_MAX_SIZE;
+
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
@@ -7328,11 +7333,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt < FAULTED_SIZE)
 		size += FAULTED_SIZE - cnt;
 
-	if (size > TRACE_SEQ_BUFFER_SIZE) {
-		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
-		goto again;
-	}
-
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
-- 
2.43.0


