Return-Path: <linux-kernel+bounces-5844-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D648E81900D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37C63B242F7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 175CD3D0BE;
	Tue, 19 Dec 2023 18:55:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3ED3B19C;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08FC4C433C7;
	Tue, 19 Dec 2023 18:55:31 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rFfGY-00000003R3q-1CcE;
	Tue, 19 Dec 2023 13:56:30 -0500
Message-ID: <20231219185630.054668186@goodmis.org>
User-Agent: quilt/0.67
Date: Tue, 19 Dec 2023 13:54:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
 Vincent Donnefort <vdonnefort@google.com>,
 Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v5 09/15] tracing: Update snapshot order along with main buffer order
References: <20231219185414.474197117@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When updating the order of the sub buffers for the main buffer, make sure
that if the snapshot buffer exists, that it gets its order updated as
well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4dcdc30aa110..2439e00aa4ce 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1263,10 +1263,17 @@ static void set_buffer_entries(struct array_buffer *buf, unsigned long val);
 
 int tracing_alloc_snapshot_instance(struct trace_array *tr)
 {
+	int order;
 	int ret;
 
 	if (!tr->allocated_snapshot) {
 
+		/* Make the snapshot buffer have the same order as main buffer */
+		order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+		ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
+		if (ret < 0)
+			return ret;
+
 		/* allocate spare buffer */
 		ret = resize_buffer_duplicate_size(&tr->max_buffer,
 				   &tr->array_buffer, RING_BUFFER_ALL_CPUS);
@@ -1286,6 +1293,7 @@ static void free_snapshot(struct trace_array *tr)
 	 * The max_tr ring buffer has some state (e.g. ring->clock) and
 	 * we want preserve it.
 	 */
+	ring_buffer_subbuf_order_set(tr->max_buffer.buffer, 0);
 	ring_buffer_resize(tr->max_buffer.buffer, 1, RING_BUFFER_ALL_CPUS);
 	set_buffer_entries(&tr->max_buffer, 1);
 	tracing_reset_online_cpus(&tr->max_buffer);
@@ -9393,6 +9401,7 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	unsigned long val;
+	int old_order;
 	int ret;
 
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
@@ -9403,12 +9412,44 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 	if (val < 0 || val > 7)
 		return -EINVAL;
 
+	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+	if (old_order == val)
+		return 0;
+
 	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
 	if (ret)
-		return ret;
+		return 0;
 
-	(*ppos)++;
+#ifdef CONFIG_TRACER_MAX_TRACE
+
+	if (!tr->allocated_snapshot)
+		goto out_max;
 
+	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, val);
+	if (ret) {
+		/* Put back the old order */
+		cnt = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, old_order);
+		if (WARN_ON_ONCE(cnt)) {
+			/*
+			 * AARGH! We are left with different orders!
+			 * The max buffer is our "snapshot" buffer.
+			 * When a tracer needs a snapshot (one of the
+			 * latency tracers), it swaps the max buffer
+			 * with the saved snap shot. We succeeded to
+			 * update the order of the main buffer, but failed to
+			 * update the order of the max buffer. But when we tried
+			 * to reset the main buffer to the original size, we
+			 * failed there too. This is very unlikely to
+			 * happen, but if it does, warn and kill all
+			 * tracing.
+			 */
+			tracing_disabled = 1;
+		}
+		return ret;
+	}
+ out_max:
+#endif
+	(*ppos)++;
 	return cnt;
 }
 
-- 
2.42.0



