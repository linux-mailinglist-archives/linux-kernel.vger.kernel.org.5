Return-Path: <linux-kernel+bounces-2048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEAF815750
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87B20281F1E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B9A18AEA;
	Sat, 16 Dec 2023 04:21:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117313FEA;
	Sat, 16 Dec 2023 04:21:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4F6C433CD;
	Sat, 16 Dec 2023 04:21:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rEMCJ-00000002yCk-1JRZ;
	Fri, 15 Dec 2023 23:22:43 -0500
Message-ID: <20231216042243.088375583@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 15 Dec 2023 23:22:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org
Subject: [for-linus][PATCH 05/15] tracing: Update snapshot buffer on resize if it is allocated
References: <20231216042214.905262999@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

The snapshot buffer is to mimic the main buffer so that when a snapshot is
needed, the snapshot and main buffer are swapped. When the snapshot buffer
is allocated, it is set to the minimal size that the ring buffer may be at
and still functional. When it is allocated it becomes the same size as the
main ring buffer, and when the main ring buffer changes in size, it should
do.

Currently, the resize only updates the snapshot buffer if it's used by the
current tracer (ie. the preemptirqsoff tracer). But it needs to be updated
anytime it is allocated.

When changing the size of the main buffer, instead of looking to see if
the current tracer is utilizing the snapshot buffer, just check if it is
allocated to know if it should be updated or not.

Also fix typo in comment just above the code change.

Link: https://lore.kernel.org/linux-trace-kernel/20231210225447.48476a6a@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Fixes: ad909e21bbe69 ("tracing: Add internal tracing_snapshot() functions")
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index aa8f99f3e5de..6c79548f9574 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6348,7 +6348,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 	if (!tr->array_buffer.buffer)
 		return 0;
 
-	/* Do not allow tracing while resizng ring buffer */
+	/* Do not allow tracing while resizing ring buffer */
 	tracing_stop_tr(tr);
 
 	ret = ring_buffer_resize(tr->array_buffer.buffer, size, cpu);
@@ -6356,7 +6356,7 @@ static int __tracing_resize_ring_buffer(struct trace_array *tr,
 		goto out_start;
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-	if (!tr->current_trace->use_max_tr)
+	if (!tr->allocated_snapshot)
 		goto out;
 
 	ret = ring_buffer_resize(tr->max_buffer.buffer, size, cpu);
-- 
2.42.0



