Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1E17F7913
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345434AbjKXQfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjKXQfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:35:14 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E579710CF;
        Fri, 24 Nov 2023 08:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=lRmcKq7AIxSR6usOW5TWHREpkqLey1xNLAHUQ3oiplc=;
        t=1700843720; x=1702053320; b=wa+2OV/olec2UJOI4JBr78xUtZA+Ok2eKCz+qntJmqFVVx1
        VkhlSBJMOwZOCHWZMjE2Ra0szNu7DWV1jr7v9HSEVevn83Kze8Q2wa7DFGaW9xkyNg3iTriUF6h2g
        6QRQKXR6msqO3OvcEjVzoD4DD1XAf+OR19UGO1e6rwnLmSd/Bdnor2PTS0IdlnA8bhTl8NF4pzN1w
        n/xXm1wW6o1lrGe7JfxJRQ0EHsCxo3zgoFKjg7SD0otQJku34r1aHIk9jOMqeAo9sy5YPg5cog+Hb
        P2NuN5JYKZJDZ//7Ka+YfkT+9HAGXHf3c9+6DuLUOkemC6062/iHQG4jPoTc2bIA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r6Z9A-00000002fA8-3co7;
        Fri, 24 Nov 2023 17:35:17 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2 3/6] debugfs: add API to allow debugfs operations cancellation
Date:   Fri, 24 Nov 2023 17:25:26 +0100
Message-ID: <20231124172522.8c5d739c69e7.If54cd017d5734024e7bee5e4a237e17244050480@changeid>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231124162522.16344-7-johannes@sipsolutions.net>
References: <20231124162522.16344-7-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

In some cases there might be longer-running hardware accesses
in debugfs files, or attempts to acquire locks, and we want
to still be able to quickly remove the files.

Introduce a cancellations API to use inside the debugfs handler
functions to be able to cancel such operations on a per-file
basis.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2:
 - use mutex to protect the cancellations and hold it around
   calling the cancel function so that cannot race with the
   handler finishing and leaving the cancellation.
---
 fs/debugfs/file.c       | 82 +++++++++++++++++++++++++++++++++++++++++
 fs/debugfs/inode.c      | 32 +++++++++++++++-
 fs/debugfs/internal.h   |  5 +++
 include/linux/debugfs.h | 19 ++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 3eff92450fd5..5568cdea3490 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -114,6 +114,8 @@ int debugfs_file_get(struct dentry *dentry)
 		lockdep_init_map(&fsd->lockdep_map, fsd->lock_name ?: "debugfs",
 				 &fsd->key, 0);
 #endif
+		INIT_LIST_HEAD(&fsd->cancellations);
+		mutex_init(&fsd->cancellations_mtx);
 	}
 
 	/*
@@ -156,6 +158,86 @@ void debugfs_file_put(struct dentry *dentry)
 }
 EXPORT_SYMBOL_GPL(debugfs_file_put);
 
+/**
+ * debugfs_enter_cancellation - enter a debugfs cancellation
+ * @file: the file being accessed
+ * @cancellation: the cancellation object, the cancel callback
+ *	inside of it must be initialized
+ *
+ * When a debugfs file is removed it needs to wait for all active
+ * operations to complete. However, the operation itself may need
+ * to wait for hardware or completion of some asynchronous process
+ * or similar. As such, it may need to be cancelled to avoid long
+ * waits or even deadlocks.
+ *
+ * This function can be used inside a debugfs handler that may
+ * need to be cancelled. As soon as this function is called, the
+ * cancellation's 'cancel' callback may be called, at which point
+ * the caller should proceed to call debugfs_leave_cancellation()
+ * and leave the debugfs handler function as soon as possible.
+ * Note that the 'cancel' callback is only ever called in the
+ * context of some kind of debugfs_remove().
+ *
+ * This function must be paired with debugfs_leave_cancellation().
+ */
+void debugfs_enter_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation)
+{
+	struct debugfs_fsdata *fsd;
+	struct dentry *dentry = F_DENTRY(file);
+
+	INIT_LIST_HEAD(&cancellation->list);
+
+	if (WARN_ON(!d_is_reg(dentry)))
+		return;
+
+	if (WARN_ON(!cancellation->cancel))
+		return;
+
+	fsd = READ_ONCE(dentry->d_fsdata);
+	if (WARN_ON(!fsd ||
+		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return;
+
+	mutex_lock(&fsd->cancellations_mtx);
+	list_add(&cancellation->list, &fsd->cancellations);
+	mutex_unlock(&fsd->cancellations_mtx);
+
+	/* if we're already removing wake it up to cancel */
+	if (d_unlinked(dentry))
+		complete(&fsd->active_users_drained);
+}
+EXPORT_SYMBOL_GPL(debugfs_enter_cancellation);
+
+/**
+ * debugfs_leave_cancellation - leave cancellation section
+ * @file: the file being accessed
+ * @cancellation: the cancellation previously registered with
+ *	debugfs_enter_cancellation()
+ *
+ * See the documentation of debugfs_enter_cancellation().
+ */
+void debugfs_leave_cancellation(struct file *file,
+				struct debugfs_cancellation *cancellation)
+{
+	struct debugfs_fsdata *fsd;
+	struct dentry *dentry = F_DENTRY(file);
+
+	if (WARN_ON(!d_is_reg(dentry)))
+		return;
+
+	fsd = READ_ONCE(dentry->d_fsdata);
+	if (WARN_ON(!fsd ||
+		    ((unsigned long)fsd & DEBUGFS_FSDATA_IS_REAL_FOPS_BIT)))
+		return;
+
+	mutex_lock(&fsd->cancellations_mtx);
+	if (!list_empty(&cancellation->list))
+		list_del(&cancellation->list);
+	mutex_unlock(&fsd->cancellations_mtx);
+}
+EXPORT_SYMBOL_GPL(debugfs_leave_cancellation);
+
 /*
  * Only permit access to world-readable files when the kernel is locked down.
  * We also need to exclude any file that has ways to write or alter it as root
diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index 80f4f000dcc1..d53c2860b03c 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -247,6 +247,8 @@ static void debugfs_release_dentry(struct dentry *dentry)
 		lockdep_unregister_key(&fsd->key);
 		kfree(fsd->lock_name);
 #endif
+		WARN_ON(!list_empty(&fsd->cancellations));
+		mutex_destroy(&fsd->cancellations_mtx);
 	}
 
 	kfree(fsd);
@@ -756,8 +758,36 @@ static void __debugfs_file_removed(struct dentry *dentry)
 	lock_map_acquire(&fsd->lockdep_map);
 	lock_map_release(&fsd->lockdep_map);
 
-	if (!refcount_dec_and_test(&fsd->active_users))
+	/* if we hit zero, just wait for all to finish */
+	if (!refcount_dec_and_test(&fsd->active_users)) {
 		wait_for_completion(&fsd->active_users_drained);
+		return;
+	}
+
+	/* if we didn't hit zero, try to cancel any we can */
+	while (refcount_read(&fsd->active_users)) {
+		struct debugfs_cancellation *c;
+
+		/*
+		 * Lock the cancellations. Note that the cancellations
+		 * structs are meant to be on the stack, so we need to
+		 * ensure we either use them here or don't touch them,
+		 * and debugfs_leave_cancellation() will wait for this
+		 * to be finished processing before exiting one. It may
+		 * of course win and remove the cancellation, but then
+		 * chances are we never even got into this bit, we only
+		 * do if the refcount isn't zero already.
+		 */
+		mutex_lock(&fsd->cancellations_mtx);
+		while ((c = list_first_entry_or_null(&fsd->cancellations,
+						     typeof(*c), list))) {
+			list_del_init(&c->list);
+			c->cancel(dentry, c->cancel_data);
+		}
+		mutex_unlock(&fsd->cancellations_mtx);
+
+		wait_for_completion(&fsd->active_users_drained);
+	}
 }
 
 static void remove_one(struct dentry *victim)
diff --git a/fs/debugfs/internal.h b/fs/debugfs/internal.h
index c7d61cfc97d2..0c4c68cf161f 100644
--- a/fs/debugfs/internal.h
+++ b/fs/debugfs/internal.h
@@ -8,6 +8,7 @@
 #ifndef _DEBUGFS_INTERNAL_H_
 #define _DEBUGFS_INTERNAL_H_
 #include <linux/lockdep.h>
+#include <linux/list.h>
 
 struct file_operations;
 
@@ -29,6 +30,10 @@ struct debugfs_fsdata {
 			struct lock_class_key key;
 			char *lock_name;
 #endif
+
+			/* protect cancellations */
+			struct mutex cancellations_mtx;
+			struct list_head cancellations;
 		};
 	};
 };
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index ea2d919fd9c7..c9c65b132c0f 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -171,6 +171,25 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
 ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
 			      size_t count, loff_t *ppos);
 
+/**
+ * struct debugfs_cancellation - cancellation data
+ * @list: internal, for keeping track
+ * @cancel: callback to call
+ * @cancel_data: extra data for the callback to call
+ */
+struct debugfs_cancellation {
+	struct list_head list;
+	void (*cancel)(struct dentry *, void *);
+	void *cancel_data;
+};
+
+void __acquires(cancellation)
+debugfs_enter_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation);
+void __releases(cancellation)
+debugfs_leave_cancellation(struct file *file,
+			   struct debugfs_cancellation *cancellation);
+
 #else
 
 #include <linux/err.h>
-- 
2.42.0

