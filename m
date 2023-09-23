Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A69B7AC5D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 01:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjIWXOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 19:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIWXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 19:14:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A84A83
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 16:14:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09CAC433C8;
        Sat, 23 Sep 2023 23:14:22 +0000 (UTC)
Date:   Sat, 23 Sep 2023 19:14:20 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Zheng Yejian <zhengyejian1@huawei.com>
Subject: [GIT PULL] tracing: Fixes for 6.6-rc2
Message-ID: <20230923191420.10c42e4f@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Tracing fixes for 6.6-rc2:

- Fix the "bytes" output of the per_cpu stat file
  The tracefs/per_cpu/cpu*/stats "bytes" was giving bogus values as the
  accounting was not accurate. It is suppose to show how many used bytes are
  still in the ring buffer, but even when the ring buffer was empty it would
  still show there were bytes used.

- Fix a bug in eventfs where reading a dynamic event directory (open) and then
  creating a dynamic event that goes into that diretory screws up the accounting.
  On close, the newly created event dentry will get a "dput" without ever having
  a "dget" done for it. The fix is to allocate an array on dir open to save what
  dentries were actually "dget" on, and what ones to "dput" on close.

[
   Note, the show_event_dentries was critical in debugging the above ;-)
]

Please pull the latest trace-v6.6-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-v6.6-rc2

Tag SHA1: 3164684ad125d90cdb6c96cddb00676649831d52
Head SHA1: ef36b4f92868d66908e235980f74afdfb9742d12


Steven Rostedt (Google) (1):
      eventfs: Remember what dentries were created on dir open

Zheng Yejian (1):
      ring-buffer: Fix bytes info in per_cpu buffer stats

----
 fs/tracefs/event_inode.c   | 87 +++++++++++++++++++++++++++++++++++++---------
 kernel/trace/ring_buffer.c | 28 ++++++++-------
 2 files changed, 85 insertions(+), 30 deletions(-)
---------------------------
diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 9f64e7332796..5f1714089884 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -70,6 +70,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 					  struct dentry *dentry,
 					  unsigned int flags);
 static int dcache_dir_open_wrapper(struct inode *inode, struct file *file);
+static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx);
 static int eventfs_release(struct inode *inode, struct file *file);
 
 static const struct inode_operations eventfs_root_dir_inode_operations = {
@@ -79,7 +80,7 @@ static const struct inode_operations eventfs_root_dir_inode_operations = {
 static const struct file_operations eventfs_file_operations = {
 	.open		= dcache_dir_open_wrapper,
 	.read		= generic_read_dir,
-	.iterate_shared	= dcache_readdir,
+	.iterate_shared	= dcache_readdir_wrapper,
 	.llseek		= generic_file_llseek,
 	.release	= eventfs_release,
 };
@@ -396,6 +397,11 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 	return ret;
 }
 
+struct dentry_list {
+	void			*cursor;
+	struct dentry		**dentries;
+};
+
 /**
  * eventfs_release - called to release eventfs file/dir
  * @inode: inode to be released
@@ -404,26 +410,25 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
 static int eventfs_release(struct inode *inode, struct file *file)
 {
 	struct tracefs_inode *ti;
-	struct eventfs_inode *ei;
-	struct eventfs_file *ef;
-	struct dentry *dentry;
-	int idx;
+	struct dentry_list *dlist = file->private_data;
+	void *cursor;
+	int i;
 
 	ti = get_tracefs(inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
-	ei = ti->private;
-	idx = srcu_read_lock(&eventfs_srcu);
-	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
-				 srcu_read_lock_held(&eventfs_srcu)) {
-		mutex_lock(&eventfs_mutex);
-		dentry = ef->dentry;
-		mutex_unlock(&eventfs_mutex);
-		if (dentry)
-			dput(dentry);
+	if (WARN_ON_ONCE(!dlist))
+		return -EINVAL;
+
+	for (i = 0; dlist->dentries[i]; i++) {
+		dput(dlist->dentries[i]);
 	}
-	srcu_read_unlock(&eventfs_srcu, idx);
+
+	cursor = dlist->cursor;
+	kfree(dlist->dentries);
+	kfree(dlist);
+	file->private_data = cursor;
 	return dcache_dir_close(inode, file);
 }
 
@@ -442,22 +447,70 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
 	struct tracefs_inode *ti;
 	struct eventfs_inode *ei;
 	struct eventfs_file *ef;
+	struct dentry_list *dlist;
+	struct dentry **dentries = NULL;
 	struct dentry *dentry = file_dentry(file);
+	struct dentry *d;
 	struct inode *f_inode = file_inode(file);
+	int cnt = 0;
 	int idx;
+	int ret;
 
 	ti = get_tracefs(f_inode);
 	if (!(ti->flags & TRACEFS_EVENT_INODE))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(file->private_data))
+		return -EINVAL;
+
+	dlist = kmalloc(sizeof(*dlist), GFP_KERNEL);
+	if (!dlist)
+		return -ENOMEM;
+
 	ei = ti->private;
 	idx = srcu_read_lock(&eventfs_srcu);
 	list_for_each_entry_srcu(ef, &ei->e_top_files, list,
 				 srcu_read_lock_held(&eventfs_srcu)) {
-		create_dentry(ef, dentry, false);
+		d = create_dentry(ef, dentry, false);
+		if (d) {
+			struct dentry **tmp;
+
+			tmp = krealloc(dentries, sizeof(d) * (cnt + 2), GFP_KERNEL);
+			if (!tmp)
+				break;
+			tmp[cnt] = d;
+			tmp[cnt + 1] = NULL;
+			cnt++;
+			dentries = tmp;
+		}
 	}
 	srcu_read_unlock(&eventfs_srcu, idx);
-	return dcache_dir_open(inode, file);
+	ret = dcache_dir_open(inode, file);
+
+	/*
+	 * dcache_dir_open() sets file->private_data to a dentry cursor.
+	 * Need to save that but also save all the dentries that were
+	 * opened by this function.
+	 */
+	dlist->cursor = file->private_data;
+	dlist->dentries = dentries;
+	file->private_data = dlist;
+	return ret;
+}
+
+/*
+ * This just sets the file->private_data back to the cursor and back.
+ */
+static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
+{
+	struct dentry_list *dlist = file->private_data;
+	int ret;
+
+	file->private_data = dlist->cursor;
+	ret = dcache_readdir(file, ctx);
+	dlist->cursor = file->private_data;
+	file->private_data = dlist;
+	return ret;
 }
 
 /**
diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index a1651edc48d5..28daf0ce95c5 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -354,6 +354,11 @@ static void rb_init_page(struct buffer_data_page *bpage)
 	local_set(&bpage->commit, 0);
 }
 
+static __always_inline unsigned int rb_page_commit(struct buffer_page *bpage)
+{
+	return local_read(&bpage->page->commit);
+}
+
 static void free_buffer_page(struct buffer_page *bpage)
 {
 	free_page((unsigned long)bpage->page);
@@ -2003,7 +2008,7 @@ rb_remove_pages(struct ring_buffer_per_cpu *cpu_buffer, unsigned long nr_pages)
 			 * Increment overrun to account for the lost events.
 			 */
 			local_add(page_entries, &cpu_buffer->overrun);
-			local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+			local_sub(rb_page_commit(to_remove_page), &cpu_buffer->entries_bytes);
 			local_inc(&cpu_buffer->pages_lost);
 		}
 
@@ -2367,11 +2372,6 @@ rb_reader_event(struct ring_buffer_per_cpu *cpu_buffer)
 			       cpu_buffer->reader_page->read);
 }
 
-static __always_inline unsigned rb_page_commit(struct buffer_page *bpage)
-{
-	return local_read(&bpage->page->commit);
-}
-
 static struct ring_buffer_event *
 rb_iter_head_event(struct ring_buffer_iter *iter)
 {
@@ -2517,7 +2517,7 @@ rb_handle_head_page(struct ring_buffer_per_cpu *cpu_buffer,
 		 * the counters.
 		 */
 		local_add(entries, &cpu_buffer->overrun);
-		local_sub(BUF_PAGE_SIZE, &cpu_buffer->entries_bytes);
+		local_sub(rb_page_commit(next_page), &cpu_buffer->entries_bytes);
 		local_inc(&cpu_buffer->pages_lost);
 
 		/*
@@ -2660,9 +2660,6 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 
 	event = __rb_page_index(tail_page, tail);
 
-	/* account for padding bytes */
-	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
-
 	/*
 	 * Save the original length to the meta data.
 	 * This will be used by the reader to add lost event
@@ -2676,7 +2673,8 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	 * write counter enough to allow another writer to slip
 	 * in on this page.
 	 * We put in a discarded commit instead, to make sure
-	 * that this space is not used again.
+	 * that this space is not used again, and this space will
+	 * not be accounted into 'entries_bytes'.
 	 *
 	 * If we are less than the minimum size, we don't need to
 	 * worry about it.
@@ -2701,6 +2699,9 @@ rb_reset_tail(struct ring_buffer_per_cpu *cpu_buffer,
 	/* time delta must be non zero */
 	event->time_delta = 1;
 
+	/* account for padding bytes */
+	local_add(BUF_PAGE_SIZE - tail, &cpu_buffer->entries_bytes);
+
 	/* Make sure the padding is visible before the tail_page->write update */
 	smp_wmb();
 
@@ -4215,7 +4216,7 @@ u64 ring_buffer_oldest_event_ts(struct trace_buffer *buffer, int cpu)
 EXPORT_SYMBOL_GPL(ring_buffer_oldest_event_ts);
 
 /**
- * ring_buffer_bytes_cpu - get the number of bytes consumed in a cpu buffer
+ * ring_buffer_bytes_cpu - get the number of bytes unconsumed in a cpu buffer
  * @buffer: The ring buffer
  * @cpu: The per CPU buffer to read from.
  */
@@ -4723,6 +4724,7 @@ static void rb_advance_reader(struct ring_buffer_per_cpu *cpu_buffer)
 
 	length = rb_event_length(event);
 	cpu_buffer->reader_page->read += length;
+	cpu_buffer->read_bytes += length;
 }
 
 static void rb_advance_iter(struct ring_buffer_iter *iter)
@@ -5816,7 +5818,7 @@ int ring_buffer_read_page(struct trace_buffer *buffer,
 	} else {
 		/* update the entry counter */
 		cpu_buffer->read += rb_page_entries(reader);
-		cpu_buffer->read_bytes += BUF_PAGE_SIZE;
+		cpu_buffer->read_bytes += rb_page_commit(reader);
 
 		/* swap the pages */
 		rb_init_page(bpage);
