Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB0B80B8BD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjLJEEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231496AbjLJEEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855FC118
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B427C433B7;
        Sun, 10 Dec 2023 04:04:14 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3j-000000021Pm-0Gbc;
        Sat, 09 Dec 2023 23:04:51 -0500
Message-ID: <20231210040450.846348590@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:13 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 09/14] tracing: Update snapshot order along with main buffer order
References: <20231210035404.053677508@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

When updating the order of the sub buffers for the main buffer, make sure
that if the snapshot buffer exists, that it gets its order updated as
well.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 45 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b3b36d7f1201..7faaaf29b504 100644
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
@@ -9378,6 +9386,7 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 {
 	struct trace_array *tr = filp->private_data;
 	unsigned long val;
+	int old_order;
 	int ret;
 
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
@@ -9388,12 +9397,44 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
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
 
+	if (!tr->allocated_snapshot)
+		goto out_max;
+
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


