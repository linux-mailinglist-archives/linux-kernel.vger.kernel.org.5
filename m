Return-Path: <linux-kernel+bounces-5380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB23818A13
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2051F2830B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F7E225DF;
	Tue, 19 Dec 2023 14:32:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7284E20DCF
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB32C433CB;
	Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9Y-00000003MFu-1jlQ;
	Tue, 19 Dec 2023 09:33:00 -0500
Message-ID: <20231219143300.196456990@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:38 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 05/10] tracing: Have trace_marker break up by lines by size of trace_seq
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

If a trace_marker write is bigger than what trace_seq can hold, then it
will print "LINE TOO BIG" message and not what was written.

Instead, check if the write is bigger than the trace_seq and break it
up by that size.

Ideally, we could make the trace_seq dynamic that could hold this. But
that's for another time.

Link: https://lore.kernel.org/linux-trace-kernel/20231212190422.1eaf224f@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0be30cccabb4..9cf58383d2fb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7304,6 +7304,11 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (cnt < FAULTED_SIZE)
 		size += FAULTED_SIZE - cnt;
 
+	if (size > TRACE_SEQ_BUFFER_SIZE) {
+		cnt -= size - TRACE_SEQ_BUFFER_SIZE;
+		goto again;
+	}
+
 	buffer = tr->array_buffer.buffer;
 	event = __trace_buffer_lock_reserve(buffer, TRACE_PRINT, size,
 					    tracing_gen_ctx());
-- 
2.42.0



