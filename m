Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3465680B8B8
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 05:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjLJEEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 23:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjLJEEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 23:04:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95EE118
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 20:04:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACDEC433C8;
        Sun, 10 Dec 2023 04:04:12 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
        (envelope-from <rostedt@goodmis.org>)
        id 1rCB3h-000000021Mn-1UhX;
        Sat, 09 Dec 2023 23:04:49 -0500
Message-ID: <20231210040449.140717619@goodmis.org>
User-Agent: quilt/0.67
Date:   Sat, 09 Dec 2023 22:54:07 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 03/14] ring-buffer: Add interface for configuring trace sub buffer size
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

From: "Tzvetomir Stoyanov (VMware)" <tz.stoyanov@gmail.com>

The trace ring buffer sub page size can be configured, per trace
instance. A new ftrace file "buffer_subbuf_order" is added to get and
set the size of the ring buffer sub page for current trace instance.
The size must be an order of system page size, that's why the new
interface works with system page order, instead of absolute page size:
0 means the ring buffer sub page is equal to 1 system page and so
forth:
0 - 1 system page
1 - 2 system pages
2 - 4 system pages
...
The ring buffer sub page size is limited between 1 and 128 system
pages. The default value is 1 system page.
New ring buffer APIs are introduced:
 ring_buffer_subbuf_order_set()
 ring_buffer_subbuf_order_get()
 ring_buffer_subbuf_size_get()

Link: https://lore.kernel.org/linux-trace-devel/20211213094825.61876-4-tz.stoyanov@gmail.com

Signed-off-by: Tzvetomir Stoyanov (VMware) <tz.stoyanov@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ring_buffer.h |  4 ++
 kernel/trace/ring_buffer.c  | 73 +++++++++++++++++++++++++++++++++++++
 kernel/trace/trace.c        | 48 ++++++++++++++++++++++++
 3 files changed, 125 insertions(+)

diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
index ce46218ce46d..12573306b889 100644
--- a/include/linux/ring_buffer.h
+++ b/include/linux/ring_buffer.h
@@ -202,6 +202,10 @@ struct trace_seq;
 int ring_buffer_print_entry_header(struct trace_seq *s);
 int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq *s);
 
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer);
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order);
+int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
+
 enum ring_buffer_flags {
 	RB_FL_OVERWRITE		= 1 << 0,
 };
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a4354287dec3..7c925ce95c96 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -524,6 +524,7 @@ struct trace_buffer {
 	bool				time_stamp_abs;
 
 	unsigned int			subbuf_size;
+	unsigned int			subbuf_order;
 	unsigned int			max_data_size;
 };
 
@@ -5894,6 +5895,78 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 }
 EXPORT_SYMBOL_GPL(ring_buffer_read_page);
 
+/**
+ * ring_buffer_subbuf_size_get - get size of the sub buffer.
+ * @buffer: the buffer to get the sub buffer size from
+ *
+ * Returns size of the sub buffer, in bytes.
+ */
+int ring_buffer_subbuf_size_get(struct trace_buffer *buffer)
+{
+	return buffer->subbuf_size + BUF_PAGE_HDR_SIZE;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_size_get);
+
+/**
+ * ring_buffer_subbuf_order_get - get order of system sub pages in one buffer page.
+ * @buffer: The ring_buffer to get the system sub page order from
+ *
+ * By default, one ring buffer sub page equals to one system page. This parameter
+ * is configurable, per ring buffer. The size of the ring buffer sub page can be
+ * extended, but must be an order of system page size.
+ *
+ * Returns the order of buffer sub page size, in system pages:
+ * 0 means the sub buffer size is 1 system page and so forth.
+ * In case of an error < 0 is returned.
+ */
+int ring_buffer_subbuf_order_get(struct trace_buffer *buffer)
+{
+	if (!buffer)
+		return -EINVAL;
+
+	return buffer->subbuf_order;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_get);
+
+/**
+ * ring_buffer_subbuf_order_set - set the size of ring buffer sub page.
+ * @buffer: The ring_buffer to set the new page size.
+ * @order: Order of the system pages in one sub buffer page
+ *
+ * By default, one ring buffer pages equals to one system page. This API can be
+ * used to set new size of the ring buffer page. The size must be order of
+ * system page size, that's why the input parameter @order is the order of
+ * system pages that are allocated for one ring buffer page:
+ *  0 - 1 system page
+ *  1 - 2 system pages
+ *  3 - 4 system pages
+ *  ...
+ *
+ * Returns 0 on success or < 0 in case of an error.
+ */
+int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
+{
+	int psize;
+
+	if (!buffer || order < 0)
+		return -EINVAL;
+
+	if (buffer->subbuf_order == order)
+		return 0;
+
+	psize = (1 << order) * PAGE_SIZE;
+	if (psize <= BUF_PAGE_HDR_SIZE)
+		return -EINVAL;
+
+	buffer->subbuf_order = order;
+	buffer->subbuf_size = psize - BUF_PAGE_HDR_SIZE;
+
+	/* Todo: reset the buffer with the new page size */
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ring_buffer_subbuf_order_set);
+
 /*
  * We only allocate new buffers, never free them if the CPU goes down.
  * If we were to free the buffer, then the user would lose any trace that was in
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 90e0ea91521f..503fd7a57177 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9343,6 +9343,51 @@ static const struct file_operations buffer_percent_fops = {
 	.llseek		= default_llseek,
 };
 
+static ssize_t
+buffer_order_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	char buf[64];
+	int r;
+
+	r = sprintf(buf, "%d\n", ring_buffer_subbuf_order_get(tr->array_buffer.buffer));
+
+	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
+}
+
+static ssize_t
+buffer_order_write(struct file *filp, const char __user *ubuf,
+		   size_t cnt, loff_t *ppos)
+{
+	struct trace_array *tr = filp->private_data;
+	unsigned long val;
+	int ret;
+
+	ret = kstrtoul_from_user(ubuf, cnt, 10, &val);
+	if (ret)
+		return ret;
+
+	/* limit between 1 and 128 system pages */
+	if (val < 0 || val > 7)
+		return -EINVAL;
+
+	ret = ring_buffer_subbuf_order_set(tr->array_buffer.buffer, val);
+	if (ret)
+		return ret;
+
+	(*ppos)++;
+
+	return cnt;
+}
+
+static const struct file_operations buffer_order_fops = {
+	.open		= tracing_open_generic_tr,
+	.read		= buffer_order_read,
+	.write		= buffer_order_write,
+	.release	= tracing_release_generic_tr,
+	.llseek		= default_llseek,
+};
+
 static struct dentry *trace_instance_dir;
 
 static void
@@ -9809,6 +9854,9 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	trace_create_file("buffer_percent", TRACE_MODE_WRITE, d_tracer,
 			tr, &buffer_percent_fops);
 
+	trace_create_file("buffer_subbuf_order", TRACE_MODE_WRITE, d_tracer,
+			  tr, &buffer_order_fops);
+
 	create_trace_options_dir(tr);
 
 #ifdef CONFIG_TRACER_MAX_TRACE
-- 
2.42.0


