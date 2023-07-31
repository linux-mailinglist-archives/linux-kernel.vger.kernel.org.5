Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9083676A4B6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 01:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjGaXSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 19:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjGaXRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 19:17:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5660A1BE6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 16:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 706AE61375
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD696C433CB;
        Mon, 31 Jul 2023 23:17:08 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qQc8R-003fR1-2K;
        Mon, 31 Jul 2023 19:17:07 -0400
Message-ID: <20230731231707.538436821@goodmis.org>
User-Agent: quilt/0.66
Date:   Mon, 31 Jul 2023 19:16:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>,
        Ching-lin Yu <chinglinyu@google.com>,
        kernel test robot <lkp@intel.com>
Subject: [for-next][PATCH 13/15] eventfs: Implement removal of meta data from eventfs
References: <20230731231634.031452225@goodmis.org>
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

From: Ajay Kaher <akaher@vmware.com>

When events are removed from tracefs, the eventfs must be aware of this.
The eventfs_remove() removes the meta data from eventfs so that it will no
longer create the files associated with that event.

When an instance is removed from tracefs, eventfs_remove_events_dir() will
remove and clean up the entire "events" directory.

The helper function eventfs_remove_rec() is used to clean up and free the
associated data from eventfs for both of the added functions. SRCU is used
to protect the lists of meta data stored in the eventfs. The eventfs_mutex
is used to protect the content of the items in the list.

As lookups may be happening as deletions of events are made, the freeing
of dentry/inodes and relative information is done after the SRCU grace
period has passed.

Link: https://lkml.kernel.org/r/1690568452-46553-9-git-send-email-akaher@vmware.com

Signed-off-by: Ajay Kaher <akaher@vmware.com>
Co-developed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Tested-by: Ching-lin Yu <chinglinyu@google.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202305030611.Kas747Ev-lkp@intel.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 fs/tracefs/event_inode.c | 143 +++++++++++++++++++++++++++++++++++++++
 include/linux/tracefs.h  |   4 ++
 2 files changed, 147 insertions(+)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5240bd2c81e7..da8d2e73cc47 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -198,6 +198,14 @@ void eventfs_set_ef_status_free(struct dentry *dentry)
 	if (!ef)
 		goto out;
 
+	/*
+	 * If ef was freed, then the LSB bit is set for d_fsdata.
+	 * But this should not happen, as it should still have a
+	 * ref count that prevents it. Warn in case it does.
+	 */
+	if (WARN_ON_ONCE((unsigned long)ef & 1))
+		goto out;
+
 	dentry->d_fsdata = NULL;
 	ef->dentry = NULL;
 out:
@@ -656,3 +664,138 @@ int eventfs_add_file(const char *name, umode_t mode,
 	mutex_unlock(&eventfs_mutex);
 	return 0;
 }
+
+static void free_ef(struct rcu_head *head)
+{
+	struct eventfs_file *ef = container_of(head, struct eventfs_file, rcu);
+
+	kfree(ef->name);
+	kfree(ef->ei);
+	kfree(ef);
+}
+
+/**
+ * eventfs_remove_rec - remove eventfs dir or file from list
+ * @ef: eventfs_file to be removed.
+ * @head: to create list of eventfs_file to be deleted
+ * @level: to check recursion depth
+ *
+ * The helper function eventfs_remove_rec() is used to clean up and free the
+ * associated data from eventfs for both of the added functions.
+ */
+static void eventfs_remove_rec(struct eventfs_file *ef, struct list_head *head, int level)
+{
+	struct eventfs_file *ef_child;
+
+	if (!ef)
+		return;
+	/*
+	 * Check recursion depth. It should never be greater than 3:
+	 * 0 - events/
+	 * 1 - events/group/
+	 * 2 - events/group/event/
+	 * 3 - events/group/event/file
+	 */
+	if (WARN_ON_ONCE(level > 3))
+		return;
+
+	if (ef->ei) {
+		/* search for nested folders or files */
+		list_for_each_entry_srcu(ef_child, &ef->ei->e_top_files, list,
+					 lockdep_is_held(&eventfs_mutex)) {
+			eventfs_remove_rec(ef_child, head, level + 1);
+		}
+	}
+
+	list_del_rcu(&ef->list);
+	list_add_tail(&ef->del_list, head);
+}
+
+/**
+ * eventfs_remove - remove eventfs dir or file from list
+ * @ef: eventfs_file to be removed.
+ *
+ * This function acquire the eventfs_mutex lock and call eventfs_remove_rec()
+ */
+void eventfs_remove(struct eventfs_file *ef)
+{
+	struct eventfs_file *tmp;
+	LIST_HEAD(ef_del_list);
+	struct dentry *dentry_list = NULL;
+	struct dentry *dentry;
+
+	if (!ef)
+		return;
+
+	mutex_lock(&eventfs_mutex);
+	eventfs_remove_rec(ef, &ef_del_list, 0);
+	list_for_each_entry_safe(ef, tmp, &ef_del_list, del_list) {
+		if (ef->dentry) {
+			unsigned long ptr = (unsigned long)dentry_list;
+
+			/* Keep the dentry from being freed yet */
+			dget(ef->dentry);
+
+			/*
+			 * Paranoid: The dget() above should prevent the dentry
+			 * from being freed and calling eventfs_set_ef_status_free().
+			 * But just in case, set the link list LSB pointer to 1
+			 * and have eventfs_set_ef_status_free() check that to
+			 * make sure that if it does happen, it will not think
+			 * the d_fsdata is an event_file.
+			 *
+			 * For this to work, no event_file should be allocated
+			 * on a odd space, as the ef should always be allocated
+			 * to be at least word aligned. Check for that too.
+			 */
+			WARN_ON_ONCE(ptr & 1);
+
+			ef->dentry->d_fsdata = (void *)(ptr | 1);
+			dentry_list = ef->dentry;
+			ef->dentry = NULL;
+		}
+		call_srcu(&eventfs_srcu, &ef->rcu, free_ef);
+	}
+	mutex_unlock(&eventfs_mutex);
+
+	while (dentry_list) {
+		unsigned long ptr;
+
+		dentry = dentry_list;
+		ptr = (unsigned long)dentry->d_fsdata & ~1UL;
+		dentry_list = (struct dentry *)ptr;
+		dentry->d_fsdata = NULL;
+		d_invalidate(dentry);
+		mutex_lock(&eventfs_mutex);
+		/* dentry should now have at least a single reference */
+		WARN_ONCE((int)d_count(dentry) < 1,
+			  "dentry %p less than one reference (%d) after invalidate\n",
+			  dentry, d_count(dentry));
+		mutex_unlock(&eventfs_mutex);
+		dput(dentry);
+	}
+}
+
+/**
+ * eventfs_remove_events_dir - remove eventfs dir or file from list
+ * @dentry: events's dentry to be removed.
+ *
+ * This function remove events main directory
+ */
+void eventfs_remove_events_dir(struct dentry *dentry)
+{
+	struct tracefs_inode *ti;
+	struct eventfs_inode *ei;
+
+	if (!dentry || !dentry->d_inode)
+		return;
+
+	ti = get_tracefs(dentry->d_inode);
+	if (!ti || !(ti->flags & TRACEFS_EVENT_INODE))
+		return;
+
+	ei = ti->private;
+	d_invalidate(dentry);
+	dput(dentry);
+	kfree(ei);
+}
diff --git a/include/linux/tracefs.h b/include/linux/tracefs.h
index 54c9cbd0389b..009072792fa3 100644
--- a/include/linux/tracefs.h
+++ b/include/linux/tracefs.h
@@ -40,6 +40,10 @@ int eventfs_add_events_file(const char *name, umode_t mode,
 			 struct dentry *parent, void *data,
 			 const struct file_operations *fops);
 
+void eventfs_remove(struct eventfs_file *ef);
+
+void eventfs_remove_events_dir(struct dentry *dentry);
+
 struct dentry *tracefs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
-- 
2.40.1
