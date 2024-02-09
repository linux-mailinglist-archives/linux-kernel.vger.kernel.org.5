Return-Path: <linux-kernel+bounces-59386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC54584F62F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A104281A2C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74945958;
	Fri,  9 Feb 2024 13:48:51 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082FB3D3AC
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707486531; cv=none; b=aqv1PK1Hxw2s811uLCoGxSpL1axF6dAnDG3erRf+nTKxM+Vo0DCw0KW8e1+zbAKdtex/kTM9ySrmKMToFHxGHOfS4eI89Nm4KDD8f57qxtXAn3vWUwKlkH7qsgSdgNbUzocddaIPWmNAqdofmo7aWZEsSzLgYsP/0eJ8xJifgvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707486531; c=relaxed/simple;
	bh=OIE5COOO6rqfwxCMmCGXgFOnkdt6DaCZsKrEzxx5dvo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RUtBC0XtQnKfBS0Vq5mTnPOJB6OUuGmRqe2Zxfb08eR3nmpTHnIXpeb/yKT7u4CRVj8p2OOLvyE6EU/KB81UUlWMfdhwWSPVv4IrRLAl5V3RW9zu/DR3tfeNSbNyraB0O1zj3vzt7Xycwq4R3U+9rKaBHrRe8f2bYLeswc3/h1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CF27C433F1;
	Fri,  9 Feb 2024 13:48:49 +0000 (UTC)
Date: Fri, 9 Feb 2024 08:48:45 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [GIT PULL] tracing: Fixes for v6.8-rc3
Message-ID: <20240209084845.3744389f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

[
   Note: The first change is a definite fix. The second one I believe
   is a fix but you may not. If you feel that the second is not worthy
   of an RC addition, I created another tag: trace-v6.8-rc3-alt
   that only has the first fix in it.

   While looking to improve the saved_cmdlines cache that maps PIDs to
   COMMs I discovered that a large structure that is allocated is just
   over a power of 2 leaving 131040 bytes unused that could have been
   used for the cache itself. I personally think that's a bug, but I can
   understand if others do not. I'll let you decided if you want to
   pull it or not. If you do not, I'll just rebase that change on top
   of my for-next queue.
]


Tracing fixes for v6.8-rc3:

- Fix broken direct trampolines being called when another callback is
  attached to the same function. ARM 64 does not support FTRACE_WITH_REGS, and
  when it added direct trampoline calls from ftrace, it removed the
  "WITH_REGS" flag from the ftrace_ops for direct trampolines. This broke
  x86 as x86 requires direct trampolines to have WITH_REGS. This wasn't
  noticed because direct trampolines work as long as the function it is
  attached to is not shared with other callbacks (like the function tracer).
  When there's other callbacks, a helper trampoline is called, to call all
  the non direct callbacks and when it returns, the direct trampoline is
  called. For x86, the trampoline sets a flag in the regs field to
  tell the x86 specific code to call the direct trampoline. But this only
  works if the ftrace_ops had WITH_REGS set. ARM does things differently
  that does not require this. For now, set WITH_REGS if the arch supports
  WITH_REGS (which ARM does not), and this makes it work for both ARM64 and
  x86.

- Fix wasted memory in the saved_cmdlines logic.

  The saved_cmdlines is a cache that maps PIDs to COMMs that tracing can
  use. Most trace events only save the PID in the event. The saved_cmdlines
  file lists PIDs to COMMs so that the tracing tools can show an actual name
  and not just a PID for each event. There's an array of PIDs that map to a
  small set of saved COMM strings. The array is set to PID_MAX_DEFAULT which
  is usually set to 32768. When a PID comes in, it will add itself to this
  array along with the index into the COMM array (note if the system allows
  more than PID_MAX_DEFAULT, this cache is similar to cache lines as an
  update of a PID that has the same PID_MAX_DEFAULT bits set will flush out
  another task with the same matching bits set).

  A while ago, the size of this cache was changed to be dynamic and the
  array was moved into a structure and created with kmalloc(). But this
  new structure had the size of 131104 bytes, or 0x20020 in hex. As kmalloc
  allocates in powers of two, it was actually allocating 0x40000 bytes
  (262144) leaving 131040 bytes of wasted memory. The last element of this
  structure was a pointer to the COMM string array which defaulted to just
  saving 128 COMMs.

  By changing the last field of this structure to a variable length string,
  and just having it round up to fill the allocated memory, the default
  size of the saved COMM cache is now 8190. This not only uses the wasted
  space, but actually saves space by removing the extra allocation for the
  COMM names.


Please pull the latest trace-v6.8-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.8-rc3

Tag SHA1: 28c94dfb4c59f1e16d71d487bb242f6214420b21
Head SHA1: 44dc5c41b5b1267d4dd037d26afc0c4d3a568acb


Masami Hiramatsu (Google) (1):
      ftrace: Fix DIRECT_CALLS to use SAVE_REGS by default

Steven Rostedt (Google) (1):
      tracing: Fix wasted memory in saved_cmdlines logic

----
 kernel/trace/ftrace.c | 10 +++++++
 kernel/trace/trace.c  | 75 +++++++++++++++++++++++++--------------------------
 2 files changed, 47 insertions(+), 38 deletions(-)
---------------------------
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index b01ae7d36021..c060d5b47910 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5325,7 +5325,17 @@ static LIST_HEAD(ftrace_direct_funcs);
 
 static int register_ftrace_function_nolock(struct ftrace_ops *ops);
 
+/*
+ * If there are multiple ftrace_ops, use SAVE_REGS by default, so that direct
+ * call will be jumped from ftrace_regs_caller. Only if the architecture does
+ * not support ftrace_regs_caller but direct_call, use SAVE_ARGS so that it
+ * jumps from ftrace_caller for multiple ftrace_ops.
+ */
+#ifndef HAVE_DYNAMIC_FTRACE_WITH_REGS
 #define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_ARGS)
+#else
+#define MULTI_FLAGS (FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS)
+#endif
 
 static int check_direct_multi(struct ftrace_ops *ops)
 {
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

