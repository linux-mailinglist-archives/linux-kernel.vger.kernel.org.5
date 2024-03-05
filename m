Return-Path: <linux-kernel+bounces-91449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D760F8711A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB1C1F22453
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 021464C94;
	Tue,  5 Mar 2024 00:25:24 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ABCF2CA9;
	Tue,  5 Mar 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709598323; cv=none; b=hIZzVG7fp0oBHVMzeLfXCSadXkI7K2ZjNPOGJManAFLsXrD8ipgBRq8Nna0lOxYKn+g4SdnVt/74tYRT/sbKQoY3aKhvpy/sSetilyyLUPBa9U/VAdc31/D6w0GjpUiS4ZGFZhrBq3uyYoYT3LErqMxJyAk3Y6yzfJ00g41gIEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709598323; c=relaxed/simple;
	bh=H7au/HmPpb0snM2lhXV4u34jsf91RboakLb53PykwYk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Qim2uBMl0bJl4/HrHAOll3aXVYKhpjVzaEPOnEr/Nop+r2A2abvU43gC4GoHKO5puzT1Rcwlj975sPMrWtQisM40zHNN8Zs2pvdOy014D+tV0tbQPYQqdtaI1g6oNQCRslR7EUf30HJIrTrAn32bqDAFacr1spSESVT/uwNMCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF6AC43390;
	Tue,  5 Mar 2024 00:25:22 +0000 (UTC)
Date: Mon, 4 Mar 2024 19:27:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Sachin Sant <sachinp@linux.ibm.com>
Subject: [PATCH] tracing: Have trace_marker writes be just half of
 TRACE_SEQ_SIZE
Message-ID: <20240304192710.4c99677c@gandalf.local.home>
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

Since the size of trace_seq's buffer is the max an event can output, have
the trace_marker be half of the entire TRACE_SEQ_SIZE, which is 4K. That
will keep writes that has meta data written from being dropped (but
reported), because the total output of the print event is greater than
what the trace_seq can hold.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8198bfc54b58..d68544aef65f 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7320,6 +7320,17 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if ((ssize_t)cnt < 0)
 		return -EINVAL;
 
+	/*
+	 * TRACE_SEQ_SIZE is the total size of trace_seq buffer used
+	 * for output. As the print event outputs more than just
+	 * the string written, keep it smaller than the trace_seq
+	 * as it could drop the event if the extra data makes it bigger
+	 * than what the trace_seq can hold. Half he TRACE_SEQ_SIZE
+	 * is more than enough.
+	 */
+	if (cnt > TRACE_SEQ_SIZE / 2)
+		cnt = TRACE_SEQ_SIZE / 2;
+
 	meta_size = sizeof(*entry) + 2;  /* add '\0' and possible '\n' */
  again:
 	size = cnt + meta_size;
@@ -7328,11 +7339,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
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


