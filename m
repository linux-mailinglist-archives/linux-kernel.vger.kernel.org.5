Return-Path: <linux-kernel+bounces-91435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E7871175
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97871C21680
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563157FD;
	Tue,  5 Mar 2024 00:11:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8BA1C01;
	Tue,  5 Mar 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709597514; cv=none; b=Dur7ch3z+nnrj21SGV32ghSQoxxZ0xjBu2YKm7OgI2cYVrL96IfK6W+Q/6hUOYmgTtqZ2bfVWTsyR7nGajJ7anEQBV+/ECcNzxgtp0MvQ9O+kfhOOPE/2+mWTKuG3jWczUA8OiooA1uJtA272yAUG0vR8Fs/o754JoHnEBqjf+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709597514; c=relaxed/simple;
	bh=i7v3W3Y5vvzGtyiJyPI0LclovnO1BrI5PFScP7n9qrg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ZJ/rIoO7di1ipJR4OeAcJt6EghridyFlHd+7a+MQ/JKji8XVyywDpfwRtTzIE8rUD7J2C1jw9w9PrCK+4KsdFp3b8z7dxhpvUo03hKjssWLkelD/zmDDPsJ3bS0kpEvUIV7M3wPHFrc+Ds63j3mwgCgMdIEkwvpm+7lKIf5b7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2FAC433C7;
	Tue,  5 Mar 2024 00:11:53 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:13:42 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] tracing: Limit trace_seq size to just 8K and not depend on
 architecture PAGE_SIZE
Message-ID: <20240304191342.56fb1087@gandalf.local.home>
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

The trace_seq buffer is used to print out entire events. It's typically
set to PAGE_SIZE * 2 as there's some events that can be quite large.

As a side effect, writes to trace_marker is limited by both the size of the
trace_seq buffer as well as the ring buffer's sub-buffer size (which is a
power of PAGE_SIZE). By limiting the trace_seq size, it also limits the
size of the largest string written to trace_marker.

trace_seq does not need to be dependent on PAGE_SIZE like the ring buffer
sub-buffers need to be. Hard code it to 8K which is PAGE_SIZE * 2 on most
architectures. This will also limit the size of trace_marker on those
architectures with greater than 4K PAGE_SIZE.

Link: https://lore.kernel.org/all/20240302111244.3a1674be@gandalf.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_seq.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
index 9ec229dfddaa..1ef95c0287f0 100644
--- a/include/linux/trace_seq.h
+++ b/include/linux/trace_seq.h
@@ -9,9 +9,15 @@
 /*
  * Trace sequences are used to allow a function to call several other functions
  * to create a string of data to use.
+ *
+ * Have the trace seq to be 8K which is typically PAGE_SIZE * 2 on
+ * most architectures. The TRACE_SEQ_BUFFER_SIZE (which is
+ * TRACE_SEQ_SIZE minus the other fields of trace_seq), is the
+ * max size the output of a trace event may be.
  */
 
-#define TRACE_SEQ_BUFFER_SIZE	(PAGE_SIZE * 2 - \
+#define TRACE_SEQ_SIZE		8192
+#define TRACE_SEQ_BUFFER_SIZE	(TRACE_SEQ_SIZE - \
 	(sizeof(struct seq_buf) + sizeof(size_t) + sizeof(int)))
 
 struct trace_seq {
-- 
2.43.0


