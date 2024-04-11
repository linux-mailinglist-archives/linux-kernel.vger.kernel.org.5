Return-Path: <linux-kernel+bounces-139628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 384518A057A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E581E287467
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78ACB80BFA;
	Thu, 11 Apr 2024 01:26:31 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214E969D31;
	Thu, 11 Apr 2024 01:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712798788; cv=none; b=MQx65/s/1ZtBIQdKMnu37gCx9s34w29b70KOMR0JPheoqJZ5SU9lE7wlbAu5AmgpDn7YhaPhqE8ZxT616HmuNUrUt1DtXxXDFZJ/SZlkLmi561fIclE2ELoSNub4Hro9OeU5tdKOW7JnONLx2iR3kjJ3m1LKdI9ecJ/DVxiVxDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712798788; c=relaxed/simple;
	bh=IE1IK2OKn7/pafSQ0ncO+HLzuopsT1q+/33iYZS7wTg=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=nYEiH7bqDkmi89z1AEDMBS5Ho34ySH9sphhp9CJQyu94F+Pb5QT+y096ijZZJIfpzsCWA9wAdeT8twgVOmjoRkXJs0LAd+ZcyePm69EJPey54Rni3sJPfuFS7mWGEtJ0z2WEy/hqkS2FVU4MCNTQ2O2zsgdI7drKUbwgNnrLA78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864EEC32796;
	Thu, 11 Apr 2024 01:26:27 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rujFR-00000000nZP-43Mh;
	Wed, 10 Apr 2024 21:29:05 -0400
Message-ID: <20240411012905.828215645@goodmis.org>
User-Agent: quilt/0.67
Date: Wed, 10 Apr 2024 21:25:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 David Howells <dhowells@redhat.com>
Subject: [PATCH v2 11/11] tracing: Update function tracing output for previous boot buffer
References: <20240411012541.285904543@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

For a persistent ring buffer that is saved across boots, if function
tracing was performed in the previous boot, it only saves the address of
the functions and uses "%pS" to print their names. But the current boot,
those functions may be in different locations. The persistent meta-data
saves the text delta between the two boots and can be used to find the
address of the saved function of where it is located in the current boot.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d8b302d01083..b9d2c64c0648 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -990,8 +990,11 @@ enum print_line_t trace_nop_print(struct trace_iterator *iter, int flags,
 }
 
 static void print_fn_trace(struct trace_seq *s, unsigned long ip,
-			   unsigned long parent_ip, int flags)
+			   unsigned long parent_ip, long delta, int flags)
 {
+	ip += delta;
+	parent_ip += delta;
+
 	seq_print_ip_sym(s, ip, flags);
 
 	if ((flags & TRACE_ITER_PRINT_PARENT) && parent_ip) {
@@ -1009,7 +1012,7 @@ static enum print_line_t trace_fn_trace(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1674,7 +1677,7 @@ trace_func_repeats_print(struct trace_iterator *iter, int flags,
 
 	trace_assign_type(field, iter->ent);
 
-	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	print_fn_trace(s, field->ip, field->parent_ip, iter->tr->text_delta, flags);
 	trace_seq_printf(s, " (repeats: %u, last_ts:", field->count);
 	trace_print_time(s, iter,
 			 iter->ts - FUNC_REPEATS_GET_DELTA_TS(field));
-- 
2.43.0



