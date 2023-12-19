Return-Path: <linux-kernel+bounces-5382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E83A4818A14
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:34:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB08287E6C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE7792629D;
	Tue, 19 Dec 2023 14:32:02 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D220DE3
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9052BC433CA;
	Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFb9Y-00000003MGP-2xw1;
	Tue, 19 Dec 2023 09:33:00 -0500
Message-ID: <20231219143300.487404467@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 09:32:39 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 06/10] tracing: Increase size of trace_marker_raw to max ring buffer entry
References: <20231219143233.204534014@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

There's no reason to give an arbitrary limit to the size of a raw trace
marker. Just let it be as big as the size that is allowed by the ring
buffer itself.

And there's also no reason to artificially break up the write to
TRACE_BUF_SIZE, as that's not even used.

Link: https://lore.kernel.org/linux-trace-kernel/20231213104218.2efc70c1@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 9cf58383d2fb..55dabee4c78b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7365,9 +7365,6 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	return written;
 }
 
-/* Limit it for now to 3K (including tag) */
-#define RAW_DATA_MAX_SIZE (1024*3)
-
 static ssize_t
 tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 					size_t cnt, loff_t *fpos)
@@ -7389,19 +7386,18 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 		return -EINVAL;
 
 	/* The marker must at least have a tag id */
-	if (cnt < sizeof(unsigned int) || cnt > RAW_DATA_MAX_SIZE)
+	if (cnt < sizeof(unsigned int))
 		return -EINVAL;
 
-	if (cnt > TRACE_BUF_SIZE)
-		cnt = TRACE_BUF_SIZE;
-
-	BUILD_BUG_ON(TRACE_BUF_SIZE >= PAGE_SIZE);
-
 	size = sizeof(*entry) + cnt;
 	if (cnt < FAULT_SIZE_ID)
 		size += FAULT_SIZE_ID - cnt;
 
 	buffer = tr->array_buffer.buffer;
+
+	if (size > ring_buffer_max_event_size(buffer))
+		return -EINVAL;
+
 	event = __trace_buffer_lock_reserve(buffer, TRACE_RAW_DATA, size,
 					    tracing_gen_ctx());
 	if (!event)
-- 
2.42.0



