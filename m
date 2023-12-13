Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699F5810828
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 03:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378380AbjLMCT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 21:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378321AbjLMCTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 21:19:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8F1E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 18:19:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2EA8C433CC;
        Wed, 13 Dec 2023 02:19:28 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rDEr6-00000002TsJ-22KG;
        Tue, 12 Dec 2023 21:20:12 -0500
Message-ID: <20231213022012.267049115@goodmis.org>
User-Agent: quilt/0.67
Date:   Tue, 12 Dec 2023 21:19:29 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH v2 15/15] tracing: Update subbuffer with kilobytes not page order
References: <20231213021914.361709558@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Using page order for deciding what the size of the ring buffer sub buffers
are is exposing a bit too much of the implementation. Although the sub
buffers are only allocated in orders of pages, allow the user to specify
the minimum size of each sub-buffer via kilobytes like they can with the
buffer size itself.

If the user specifies 3 via:

  echo 3 > buffer_subbuf_size_kb

Then the sub-buffer size will round up to 4kb (on a 4kb page size system).

If they specify:

  echo 6 > buffer_subbuf_size_kb

The sub-buffer size will become 8kb.

and so on.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/trace/ftrace.rst                | 46 ++++++++-----------
 kernel/trace/trace.c                          | 38 +++++++++------
 ...fer_order.tc => ringbuffer_subbuf_size.tc} | 18 ++++----
 3 files changed, 54 insertions(+), 48 deletions(-)
 rename tools/testing/selftests/ftrace/test.d/00basic/{ringbuffer_order.tc => ringbuffer_subbuf_size.tc} (85%)

diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 231d26ceedb0..933e7efb9f1b 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -203,32 +203,26 @@ of ftrace. Here is a list of some of the key files:
 
 	This displays the total combined size of all the trace buffers.
 
-  buffer_subbuf_order:
-
-	This sets or displays the sub buffer page size order. The ring buffer
-	is broken up into several same size "sub buffers". An event can not be
-	bigger than the size of the sub buffer. Normally, the sub buffer is
-	the size of the architecture's page (4K on x86). The sub buffer also
-	contains meta data at the start which also limits the size of an event.
-	That means when the sub buffer is a page size, no event can be larger
-	than the page size minus the sub buffer meta data.
-
-	The buffer_subbuf_order allows the user to change the size of the sub
-	buffer. As the sub buffer is a set of pages by the power of 2, thus
-	the sub buffer total size is defined by the order:
-
-	order		size
-	----		----
-	0		PAGE_SIZE
-	1		PAGE_SIZE * 2
-	2		PAGE_SIZE * 4
-	3		PAGE_SIZE * 8
-
-	Changing the order will change the sub buffer size allowing for events
-	to be larger than the page size.
-
-	Note: When changing the order, tracing is stopped and any data in the
-	ring buffer and the snapshot buffer will be discarded.
+  buffer_subbuf_size_kb:
+
+	This sets or displays the sub buffer size. The ring buffer is broken up
+	into several same size "sub buffers". An event can not be bigger than
+	the size of the sub buffer. Normally, the sub buffer is the size of the
+	architecture's page (4K on x86). The sub buffer also contains meta data
+	at the start which also limits the size of an event.  That means when
+	the sub buffer is a page size, no event can be larger than the page
+	size minus the sub buffer meta data.
+
+	Note, the buffer_subbuf_size_kb is a way for the user to specify the
+	minimum size of the subbuffer. The kernel may make it bigger due to the
+	implementation details, or simply fail the operation if the kernel can
+	not handle the request.
+
+	Changing the sub buffer size allows for events to be larger than the
+	page size.
+
+	Note: When changing the sub-buffer size, tracing is stopped and any
+	data in the ring buffer and the snapshot buffer will be discarded.
 
   free_buffer:
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 0cb5e1a50e65..d121f3742792 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9377,42 +9377,54 @@ static const struct file_operations buffer_percent_fops = {
 };
 
 static ssize_t
-buffer_order_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+buffer_subbuf_size_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
+	size_t size;
 	char buf[64];
+	int order;
 	int r;
 
-	r = sprintf(buf, "%d\n", ring_buffer_subbuf_order_get(tr->array_buffer.buffer));
+	order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
+	size = (PAGE_SIZE << order) / 1024;
+
+	r = sprintf(buf, "%zd\n", size);
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
 static ssize_t
-buffer_order_write(struct file *filp, const char __user *ubuf,
-		   size_t cnt, loff_t *ppos)
+buffer_subbuf_size_write(struct file *filp, const char __user *ubuf,
+			 size_t cnt, loff_t *ppos)
 {
 	struct trace_array *tr = filp->private_data;
 	unsigned long val;
 	int old_order;
+	int order;
+	int pages;
 	int ret;
 
 	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
 	if (ret)
 		return ret;
 
+	val *= 1024; /* value passed in is in KB */
+
+	pages = DIV_ROUND_UP(val, PAGE_SIZE);
+	order = fls(pages - 1);
+
 	/* limit between 1 and 128 system pages */
-	if (val < 0 || val > 7)
+	if (order < 0 || order > 7)
 		return -EINVAL;
 
 	/* Do not allow tracing while changing the order of the ring buffer */
 	tracing_stop_tr(tr);
 
 	old_order = ring_buffer_subbuf_order_get(tr->array_buffer.buffer);
-	if (old_order == val)
+	if (old_order == order)
 		goto out;
 
-	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
+	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, order);
 	if (ret)
 		goto out;
 
@@ -9421,7 +9433,7 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 	if (!tr->allocated_snapshot)
 		goto out_max;
 
-	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, val);
+	ret = ring_buffer_subbuf_order_set(tr->max_buffer.buffer, order);
 	if (ret) {
 		/* Put back the old order */
 		cnt = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, old_order);
@@ -9453,10 +9465,10 @@ buffer_order_write(struct file *filp, const char __user *ubuf,
 	return cnt;
 }
 
-static const struct file_operations buffer_order_fops = {
+static const struct file_operations buffer_subbuf_size_fops = {
 	.open		= tracing_open_generic_tr,
-	.read		= buffer_order_read,
-	.write		= buffer_order_write,
+	.read		= buffer_subbuf_size_read,
+	.write		= buffer_subbuf_size_write,
 	.release	= tracing_release_generic_tr,
 	.llseek		= default_llseek,
 };
@@ -9927,8 +9939,8 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
-	trace_create_file("buffer_subbuf_order", TRACE_MODE_WRITE, d_tracer,
-			  tr, &buffer_order_fops);
+	trace_create_file("buffer_subbuf_size_kb", TRACE_MODE_WRITE, d_tracer,
+			  tr, &buffer_subbuf_size_fops);
 
 	create_trace_options_dir(tr);
 
diff --git a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
similarity index 85%
rename from tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
rename to tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
index 5204c48a82f9..1abf5c39952a 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_order.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/ringbuffer_subbuf_size.tc
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0
-# description: Change the ringbuffer sub-buffer order
-# requires: buffer_subbuf_order
+# description: Change the ringbuffer sub-buffer size
+# requires: buffer_subbuf_size_kb
 # flags: instance
 
 get_buffer_data_size() {
@@ -52,8 +52,8 @@ write_buffer() {
 }
 
 test_buffer() {
-	orde=$1
-	page_size=$((4096<<order))
+	size_kb=$1
+	page_size=$((size_kb*1024))
 
 	size=`get_buffer_data_size`
 
@@ -82,14 +82,14 @@ test_buffer() {
 	fi
 }
 
-ORIG=`cat buffer_subbuf_order`
+ORIG=`cat buffer_subbuf_size_kb`
 
-# Could test bigger orders than 3, but then creating the string
+# Could test bigger sizes than 32K, but then creating the string
 # to write into the ring buffer takes too long
-for a in 0 1 2 3 ; do
-	echo $a > buffer_subbuf_order
+for a in 4 8 16 32 ; do
+	echo $a > buffer_subbuf_size_kb
 	test_buffer $a
 done
 
-echo $ORIG > buffer_subbuf_order
+echo $ORIG > buffer_subbuf_size_kb
 
-- 
2.42.0


