Return-Path: <linux-kernel+bounces-59215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FD884F34F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 766CF281AA1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5155A69E04;
	Fri,  9 Feb 2024 10:22:21 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AB769DE5;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707474140; cv=none; b=cGRGOIUm3OxyQXaPzy2Auuo7xHsq09aVpW6E8K2i270E3bY5Lk+/+uGj6hvcR4OUnQaf3LOQPgkCLE3s6Vwc5ONvDUi5V4WKJYPYsM4oQL++QXOmlN8kzfZffuDEV7COOxhYtbWtc02/gEse7JSMuNHXQ0xGbW8JPssLbpwHCwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707474140; c=relaxed/simple;
	bh=BafTDLLX3FXjYRJPV4bUYKyxw5xU5KNu3LX6H1q7D54=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZPgj55L7nFwaTdJzXRG5b4awXJdik4DfcPZrrYP3GrPBJ74DVuaLgZvNLuJoB27M5pH+6GIB02g9Fl4SKV8Z8s+aALeGSBAgqs4McmbZMEgtKJKI56f2J5GgSgJ5YrviOOqHThoYkXGxvcrnKWM67m8gZqOzGYvK/4H/a0+2tjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B6F6C433F1;
	Fri,  9 Feb 2024 10:22:20 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.97)
	(envelope-from <rostedt@goodmis.org>)
	id 1rYO23-00000006px2-2Xpi;
	Fri, 09 Feb 2024 05:22:55 -0500
Message-ID: <20240209102255.462566699@goodmis.org>
User-Agent: quilt/0.67
Date: Fri, 09 Feb 2024 05:22:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 stable@vger.kernel.org,
 Vincent Donnefort <vdonnefort@google.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Mete Durlu <meted@linux.ibm.com>
Subject: [for-linus][PATCH 2/2] tracing: Fix wasted memory in saved_cmdlines logic
References: <20240209102220.255052617@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

While looking at improving the saved_cmdlines cache I found a huge amount
of wasted memory that should be used for the cmdlines.

The tracing data saves pids during the trace. At sched switch, if a trace
occurred, it will save the comm of the task that did the trace. This is
saved in a "cache" that maps pids to comms and exposed to user space via
the /sys/kernel/tracing/saved_cmdlines file. Currently it only caches by
default 128 comms.

The structure that uses this creates an array to store the pids using
PID_MAX_DEFAULT (which is usually set to 32768). This causes the structure
to be of the size of 131104 bytes on 64 bit machines.

In hex: 131104 = 0x20020, and since the kernel allocates generic memory in
powers of two, the kernel would allocate 0x40000 or 262144 bytes to store
this structure. That leaves 131040 bytes of wasted space.

Worse, the structure points to an allocated array to store the comm names,
which is 16 bytes times the amount of names to save (currently 128), which
is 2048 bytes. Instead of allocating a separate array, make the structure
end with a variable length string and use the extra space for that.

This is similar to a recommendation that Linus had made about eventfs_inode names:

  https://lore.kernel.org/all/20240130190355.11486-5-torvalds@linux-foundation.org/

Instead of allocating a separate string array to hold the saved comms,
have the structure end with: char saved_cmdlines[]; and round up to the
next power of two over sizeof(struct saved_cmdline_buffers) + num_cmdlines * TASK_COMM_LEN
It will use this extra space for the saved_cmdline portion.

Now, instead of saving only 128 comms by default, by using this wasted
space at the end of the structure it can save over 8000 comms and even
saves space by removing the need for allocating the other array.

Link: https://lore.kernel.org/linux-trace-kernel/20240208105328.7e73f71d@rorschach.local.home

Cc: stable@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Vincent Donnefort <vdonnefort@google.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>
Fixes: 939c7a4f04fcd ("tracing: Introduce saved_cmdlines_size file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 73 +++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 39 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..ea6d13ff256c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2320,7 +2320,7 @@ struct saved_cmdlines_buffer {
 	unsigned *map_cmdline_to_pid;
 	unsigned cmdline_num;
 	int cmdline_idx;
-	char *saved_cmdlines;
+	char saved_cmdlines[];
 };
 static struct saved_cmdlines_buffer *savedcmd;
 
@@ -2334,47 +2334,54 @@ static inline void set_cmdline(int idx, const char *cmdline)
 	strncpy(get_saved_cmdlines(idx), cmdline, TASK_COMM_LEN);
 }
 
-static int allocate_cmdlines_buffer(unsigned int val,
-				    struct saved_cmdlines_buffer *s)
+static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
+{
+	int order = get_order(sizeof(*s) + s->cmdline_num * TASK_COMM_LEN);
+
+	kfree(s->map_cmdline_to_pid);
+	free_pages((unsigned long)s, order);
+}
+
+static struct saved_cmdlines_buffer *allocate_cmdlines_buffer(unsigned int val)
 {
+	struct saved_cmdlines_buffer *s;
+	struct page *page;
+	int orig_size, size;
+	int order;
+
+	/* Figure out how much is needed to hold the given number of cmdlines */
+	orig_size = sizeof(*s) + val * TASK_COMM_LEN;
+	order = get_order(orig_size);
+	size = 1 << (order + PAGE_SHIFT);
+	page = alloc_pages(GFP_KERNEL, order);
+	if (!page)
+		return NULL;
+
+	s = page_address(page);
+	memset(s, 0, sizeof(*s));
+
+	/* Round up to actual allocation */
+	val = (size - sizeof(*s)) / TASK_COMM_LEN;
+	s->cmdline_num = val;
+
 	s->map_cmdline_to_pid = kmalloc_array(val,
 					      sizeof(*s->map_cmdline_to_pid),
 					      GFP_KERNEL);
-	if (!s->map_cmdline_to_pid)
-		return -ENOMEM;
-
-	s->saved_cmdlines = kmalloc_array(TASK_COMM_LEN, val, GFP_KERNEL);
-	if (!s->saved_cmdlines) {
-		kfree(s->map_cmdline_to_pid);
-		return -ENOMEM;
-	}
 
 	s->cmdline_idx = 0;
-	s->cmdline_num = val;
 	memset(&s->map_pid_to_cmdline, NO_CMDLINE_MAP,
 	       sizeof(s->map_pid_to_cmdline));
 	memset(s->map_cmdline_to_pid, NO_CMDLINE_MAP,
 	       val * sizeof(*s->map_cmdline_to_pid));
 
-	return 0;
+	return s;
 }
 
 static int trace_create_savedcmd(void)
 {
-	int ret;
-
-	savedcmd = kmalloc(sizeof(*savedcmd), GFP_KERNEL);
-	if (!savedcmd)
-		return -ENOMEM;
-
-	ret = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT, savedcmd);
-	if (ret < 0) {
-		kfree(savedcmd);
-		savedcmd = NULL;
-		return -ENOMEM;
-	}
+	savedcmd = allocate_cmdlines_buffer(SAVED_CMDLINES_DEFAULT);
 
-	return 0;
+	return savedcmd ? 0 : -ENOMEM;
 }
 
 int is_tracing_stopped(void)
@@ -6056,26 +6063,14 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
 }
 
-static void free_saved_cmdlines_buffer(struct saved_cmdlines_buffer *s)
-{
-	kfree(s->saved_cmdlines);
-	kfree(s->map_cmdline_to_pid);
-	kfree(s);
-}
-
 static int tracing_resize_saved_cmdlines(unsigned int val)
 {
 	struct saved_cmdlines_buffer *s, *savedcmd_temp;
 
-	s = kmalloc(sizeof(*s), GFP_KERNEL);
+	s = allocate_cmdlines_buffer(val);
 	if (!s)
 		return -ENOMEM;
 
-	if (allocate_cmdlines_buffer(val, s) < 0) {
-		kfree(s);
-		return -ENOMEM;
-	}
-
 	preempt_disable();
 	arch_spin_lock(&trace_cmdline_lock);
 	savedcmd_temp = savedcmd;
-- 
2.43.0



