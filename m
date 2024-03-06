Return-Path: <linux-kernel+bounces-94440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5F3873FD7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792E3287465
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8924D13E7F3;
	Wed,  6 Mar 2024 18:41:50 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F62C13E7C5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709750510; cv=none; b=P/A1ABuMKsnklXwGoEMSOSlvjodTJDcHUR1f/n228Ab+KR5vZgP8lXxtkudaz6cMoQfNbsloe7pmG6+R/5kq4Dk0fe0BeYZIDs0Z7oNny/T89AtrdjPMo7gKmkOInywaCkNYG4qQeHRgr8uNh87P0VXP/joGbBzgCKEmjj/UPYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709750510; c=relaxed/simple;
	bh=M32KOXv/AFVR6xfmKfYjkG0waeE8jfIiCibplogrfB4=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=gHHZipvNYuqWQbS+ZI6+9WoFI2by2g15n68C8TrRvKvOOABJGvVTYCz9vNivEoKYvVdc6g/231qKALbw7VDxicSYpvXp2kAbmXLkWFtBq1w+/66NRJKLjyw5GUPdq/dj6Yhw0NtNwhKs7qEvUNcpmz+yKXeJh71xndo4m74mR1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC45C43390;
	Wed,  6 Mar 2024 18:41:49 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rhwEw-00000000YAi-3uCp;
	Wed, 06 Mar 2024 13:43:42 -0500
Message-ID: <20240306184342.788071416@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 06 Mar 2024 13:42:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [for-linus][PATCH 3/3] tracing: Limit trace_marker writes to just 4K
References: <20240306184244.754263547@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Limit the max print event of trace_marker to just 4K string size. This must
also be less than the amount that can be held by a trace_seq along with
the text that is before the output (like the task name, PID, CPU, state,
etc). As trace_seq is made to handle large events (some greater than 4K).
Make the max size of a trace_marker write event be 4K which is guaranteed
to fit in the trace_seq buffer.

Link: https://lore.kernel.org/linux-trace-kernel/20240304223433.4ba47dff@gandalf.local.home

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
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



