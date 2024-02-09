Return-Path: <linux-kernel+bounces-59299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C3684F4BF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8386F284A8C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B622E633;
	Fri,  9 Feb 2024 11:36:27 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C931D542;
	Fri,  9 Feb 2024 11:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478587; cv=none; b=qTIYa4grV7Q2xolLnqeJLIhMHIY3XI9YfyLHxEH2ObhcR7ik+X/ovRun9lZCrFj9AmBrbX1l6NaiV5M16oT1ZqlejqdnouYQiVUVMLr09o638YxewzOY/PTG0gCSTjmGtEofP5R1KJOBzxC6U8r1atfJSVTit5oeiU01/pERdrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478587; c=relaxed/simple;
	bh=lQCt5IpvlhoGD78imhrQYoo7a8ZPzBS9q7DvLNIcdeM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mraesiliZuQSuU5KLbHWMIITwBAcsHXHhxW/V8Pv71NPY5SpUoUpchALudBCB/55lBgf4s4XUZPjmPdvGwenXIslQI2F5xKpNPrTlf1YcTEYiFiHQRrxCbgUxHj5lyN+rEQZjLm2WPw666yv5Ef3NC6j1u6N5HP5yK7FQylyYrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA21AC433F1;
	Fri,  9 Feb 2024 11:36:25 +0000 (UTC)
Date: Fri, 9 Feb 2024 06:36:22 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Vincent Donnefort
 <vdonnefort@google.com>, Sven Schnelle <svens@linux.ibm.com>, Mete Durlu
 <meted@linux.ibm.com>
Subject: [PATCH v2] tracing: Fix wasted memory in saved_cmdlines logic
Message-ID: <20240209063622.1f7b6d5f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

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

Cc: stable@vger.kernel.org
Fixes: 939c7a4f04fcd ("tracing: Introduce saved_cmdlines_size file")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20240208105328.7e73f71d@rorschach.local.home

- Added back error check of s->map_cmdline_to_pid allocation failure

 kernel/trace/trace.c | 75 ++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 38 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2a7c6fd934e9..9ff8a439d674 100644
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
 
@@ -2334,47 +2334,58 @@ static inline void set_cmdline(int idx, const char *cmdline)
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
+	if (!s->map_cmdline_to_pid) {
+		free_saved_cmdlines_buffer(s);
+		return NULL;
 	}
 
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
@@ -6056,26 +6067,14 @@ tracing_saved_cmdlines_size_read(struct file *filp, char __user *ubuf,
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


