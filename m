Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5107AC5AE
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 00:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjIWWdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 18:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjIWWdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 18:33:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14B2193
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 15:33:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78FF3C433CB;
        Sat, 23 Sep 2023 22:33:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qkBCB-003tul-0T;
        Sat, 23 Sep 2023 18:33:51 -0400
Message-ID: <20230923223350.959882978@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 23 Sep 2023 18:33:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>
Subject: [for-linus][PATCH 2/2] eventfs: Remember what dentries were created on dir open
References: <20230923223331.720351929@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Using the following code with libtracefs:

	int dfd;

	// create the directory events/kprobes/kp1
	tracefs_kprobe_raw(NULL, "kp1", "schedule_timeout", "time=$arg1");

	// Open the kprobes directory
	dfd = tracefs_instance_file_open(NULL, "events/kprobes", O_RDONLY);

	// Do a lookup of the kprobes/kp1 directory (by looking at enable)
	tracefs_file_exists(NULL, "events/kprobes/kp1/enable");

	// Now create a new entry in the kprobes directory
	tracefs_kprobe_raw(NULL, "kp2", "schedule_hrtimeout", "expires=$arg1");

	// Do another lookup to create the dentries
	tracefs_file_exists(NULL, "events/kprobes/kp2/enable"))

	// Close the directory
	close(dfd);

What happened above, the first open (dfd) will call
dcache_dir_open_wrapper() that will create the dentries and up their ref
counts.

Now the creation of "kp2" will add another dentry within the kprobes
directory.

Upon the close of dfd, eventfs_release() will now do a dput for all the
entries in kprobes. But this is where the problem lies. The open only
upped the dentry of kp1 and not kp2. Now the close is decrementing both
kp1 and kp2, which causes kp2 to get a negative count.

Doing a "trace-cmd reset" which deletes all the kprobes cause the kernel
to crash! (due to the messed up accounting of the ref counts).

To solve this, save all the dentries that are opened in the
dcache_dir_open_wrapper() into an array, and use this array to know what
dentries to do a dput on in eventfs_release().

Since the dcache_dir_open_wrapper() calls dcache_dir_open() which uses the
file->private_data, we need to also add a wrapper around dcache_readdir()
that uses the cursor assigned to the file->private_data. This is because
the dentries need to also be saved in the file->private_data. To do this
create the structure:

  struct dentry_list {
	void		*cursor;
	struct dentry	**dentries;
  };

Which will hold both the cursor and the dentries. Some shuffling around is
needed to make sure that dcache_dir_open() and dcache_readdir() only see
the cursor.

Link: https://lore.kernel.org/linux-trace-kernel/20230919211804.230edf1e@gandalf.local.home/
Link: https://lore.kernel.org/linux-trace-kernel/20230922163446.1431d4fa@gandalf.local.home

Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Ajay Kaher <akaher@vmware.com>
Fixes: 63940449555e7 ("eventfs: Implement eventfs lookup, read, open functions")
Reported-by: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 87 ++++++++++++++++++++++++++++++++--------
 1 file changed, 70 insertions(+), 17 deletions(-)

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
-- 
2.40.1
