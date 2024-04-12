Return-Path: <linux-kernel+bounces-142837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168E28A30AE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C237F2838B8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120CC86658;
	Fri, 12 Apr 2024 14:29:26 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5CF8594D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932165; cv=none; b=CEJfNg1R+SJZComGkNO/9Rh7Ee9hkvk7g+w7w4fArvPPPCyhrNHJ6LlNxiz9FK4DkfE+i7luLQQWt7G6t7JcaXSgQKSD4EAqIzAMHKh/LRwVkVMbnVmD4LOhUVf6jqjMA/hPggWIgqBG4xT5sGvxBunoTP0IR2KxrCVJLGrG3ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932165; c=relaxed/simple;
	bh=cOiPEaU/03Wpy1Gj2SfzH5mf7/403pqJE56CHBdRWUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dvn0nj9ucSGa96MSQjTP8Iu29cu1Op/glm5aM/sVBbSKWgOqm4zQgcF+gxU8HG15lGvxqPvG4XMWRpiG2sZKW7mwDinvWWq/mHxSiAyXBAgcWJRjKtPSQ75TlscoHDmxnrEpjgPhxYMk8RqRhgHvtEU5tKf5TE0lyoGrhdlA+mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 293FBC2BD10;
	Fri, 12 Apr 2024 14:29:23 +0000 (UTC)
Date: Fri, 12 Apr 2024 10:32:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
 Prasad Pandit <pjp@fedoraproject.org>, Yang Li <yang.lee@linux.alibaba.com>
Subject: [GIT PULL] tracing: Fixes for v6.9
Message-ID: <20240412103204.453d912c@gandalf.local.home>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus,

Three trivial fixes and one non-trivial one.

Tracing fixes for 6.9:

- Fix the buffer_percent accounting as it is dependent on three variables:
  1) pages_read - number of subbuffers read
  2) pages_lost - number of subbuffers lost due to overwrite
  3) pages_touched - number of pages that a writer entered
  These three counters only increment, and to know how many active pages
  there are on the buffer at any given time, the pages_read and
  pages_lost are subtracted from pages_touched. But the pages touched
  was incremented whenever any writer went to the next subbuffer even
  if it wasn't the only one, so it was incremented more than it should
  be causing the counter for how many subbuffers currently have content
  incorrect, which caused the buffer_percent that holds waiters until
  the ring buffer is filled to a given percentage to wake up early.

- Fix warning of unused functions when PERF_EVENTS is not configured in

- Replace bad tab with space in Kconfig for FTRACE_RECORD_RECURSION_SIZE

- Fix to some kerneldoc function comments in eventfs code.


Please pull the latest trace-v6.9-rc3 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.9-rc3

Tag SHA1: 184a6ab4ad1cf6e761bdf30b8a944774d1eb776a
Head SHA1: ffe3986fece696cf65e0ef99e74c75f848be8e30


Arnd Bergmann (1):
      tracing: hide unused ftrace_event_id_fops

Prasad Pandit (1):
      tracing: Fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry

Steven Rostedt (Google) (1):
      ring-buffer: Only update pages_touched when a new page is touched

Yang Li (1):
      eventfs: Fix kernel-doc comments to functions

----
 fs/tracefs/event_inode.c    | 14 ++++++++++----
 kernel/trace/Kconfig        |  2 +-
 kernel/trace/ring_buffer.c  |  6 +++---
 kernel/trace/trace_events.c |  4 ++++
 4 files changed, 18 insertions(+), 8 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index dc067eeb6387..894c6ca1e500 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -336,6 +336,7 @@ static void update_inode_attr(struct dentry *dentry, struct inode *inode,
 
 /**
  * lookup_file - look up a file in the tracefs filesystem
+ * @parent_ei: Pointer to the eventfs_inode that represents parent of the file
  * @dentry: the dentry to look up
  * @mode: the permission that the file should have.
  * @attr: saved attributes changed by user
@@ -389,6 +390,7 @@ static struct dentry *lookup_file(struct eventfs_inode *parent_ei,
 /**
  * lookup_dir_entry - look up a dir in the tracefs filesystem
  * @dentry: the directory to look up
+ * @pei: Pointer to the parent eventfs_inode if available
  * @ei: the eventfs_inode that represents the directory to create
  *
  * This function will look up a dentry for a directory represented by
@@ -478,16 +480,20 @@ void eventfs_d_release(struct dentry *dentry)
 
 /**
  * lookup_file_dentry - create a dentry for a file of an eventfs_inode
+ * @dentry: The parent dentry under which the new file's dentry will be created
  * @ei: the eventfs_inode that the file will be created under
  * @idx: the index into the entry_attrs[] of the @ei
- * @parent: The parent dentry of the created file.
- * @name: The name of the file to create
  * @mode: The mode of the file.
  * @data: The data to use to set the inode of the file with on open()
  * @fops: The fops of the file to be created.
  *
- * Create a dentry for a file of an eventfs_inode @ei and place it into the
- * address located at @e_dentry.
+ * This function creates a dentry for a file associated with an
+ * eventfs_inode @ei. It uses the entry attributes specified by @idx,
+ * if available. The file will have the specified @mode and its inode will be
+ * set up with @data upon open. The file operations will be set to @fops.
+ *
+ * Return: Returns a pointer to the newly created file's dentry or an error
+ * pointer.
  */
 static struct dentry *
 lookup_file_dentry(struct dentry *dentry,
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..47345bf1d4a9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -965,7 +965,7 @@ config FTRACE_RECORD_RECURSION
 
 config FTRACE_RECORD_RECURSION_SIZE
 	int "Max number of recursed functions to record"
-	default	128
+	default 128
 	depends on FTRACE_RECORD_RECURSION
 	help
 	  This defines the limit of number of functions that can be
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..6511dc3a00da 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1393,7 +1393,6 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 	old_write = local_add_return(RB_WRITE_INTCNT, &next_page->write);
 	old_entries = local_add_return(RB_WRITE_INTCNT, &next_page->entries);
 
-	local_inc(&cpu_buffer->pages_touched);
 	/*
 	 * Just make sure we have seen our old_write and synchronize
 	 * with any interrupts that come in.
@@ -1430,8 +1429,9 @@ static void rb_tail_page_update(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		local_set(&next_page->page->commit, 0);
 
-		/* Again, either we update tail_page or an interrupt does */
-		(void)cmpxchg(&cpu_buffer->tail_page, tail_page, next_page);
+		/* Either we update tail_page or an interrupt does */
+		if (try_cmpxchg(&cpu_buffer->tail_page, &tail_page, next_page))
+			local_inc(&cpu_buffer->pages_touched);
 	}
 }
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 7c364b87352e..52f75c36bbca 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1670,6 +1670,7 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+#ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 {
@@ -1684,6 +1685,7 @@ event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
 
 	return simple_read_from_buffer(ubuf, cnt, ppos, buf, len);
 }
+#endif
 
 static ssize_t
 event_filter_read(struct file *filp, char __user *ubuf, size_t cnt,
@@ -2152,10 +2154,12 @@ static const struct file_operations ftrace_event_format_fops = {
 	.release = seq_release,
 };
 
+#ifdef CONFIG_PERF_EVENTS
 static const struct file_operations ftrace_event_id_fops = {
 	.read = event_id_read,
 	.llseek = default_llseek,
 };
+#endif
 
 static const struct file_operations ftrace_event_filter_fops = {
 	.open = tracing_open_file_tr,

