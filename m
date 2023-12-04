Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D107680401B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 21:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376267AbjLDUiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 15:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbjLDUhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 15:37:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E369619D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 12:35:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F6C433CD;
        Mon,  4 Dec 2023 20:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701722141;
        bh=m4kahRJjjQPGeVY5i1Av7Wc4vdgcY6bB8ZFlsKLT4Mk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ktXIAuUnmWPd/IWFzZm+9SJXqe3JRG180dIsHH8TxU66pB8ESI4Z1bXrB+m5mTeSE
         ihh0P3ruGc9OLsJDXOX2vBncU6QdlJOUO0nv/4ayd7srHdUdR+p3gdV2nhnW+wdBvh
         36it4t/6uMPOeQagKVk7tz1jU8ufjkNQnBuP0a49aQVCXp9k8Eu39G6K2HD0IziuOj
         GkI1kHOHMSUm0oby2AWl7oG4LSAkWa4vJW27a+h6iHaHAASWDM7pIswRD2unrc3Svg
         PKBDzwRmw0g1+O3knfMdBngb7GmNWLuZgSvaraljUEKTwEtY4zIESeZo/ChOdS/saR
         k6o18iUUm4DoQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 10/17] debugfs: add API to allow debugfs operations cancellation
Date:   Mon,  4 Dec 2023 15:34:55 -0500
Message-ID: <20231204203514.2093855-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204203514.2093855-1-sashal@kernel.org>
References: <20231204203514.2093855-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.65
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 8c88a474357ead632b07c70bf7f119ace8c3b39e ]

In some cases there might be longer-running hardware accesses
in debugfs files, or attempts to acquire locks, and we want
to still be able to quickly remove the files.

Introduce a cancellations API to use inside the debugfs handler
functions to be able to cancel such operations on a per-file
basis.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/debugfs/file.c       | 82 +++++++++++++++++++++++++++++++++++++++++
 fs/debugfs/inode.c      | 32 +++++++++++++++-
 fs/debugfs/internal.h   |  5 +++
 include/linux/debugfs.h | 19 ++++++++++
 4 files changed, 137 insertions(+), 1 deletion(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 375af381bf005..b3493ce50227e 100644
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
index 8fc470aa67823..d6058e1881add 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -248,6 +248,8 @@ static void debugfs_release_dentry(struct dentry *dentry)
 		lockdep_unregister_key(&fsd->key);
 		kfree(fsd->lock_name);
 #endif
+		WARN_ON(!list_empty(&fsd->cancellations));
+		mutex_destroy(&fsd->cancellations_mtx);
 	}
 
 	kfree(fsd);
@@ -757,8 +759,36 @@ static void __debugfs_file_removed(struct dentry *dentry)
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
index c7d61cfc97d26..0c4c68cf161f8 100644
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
index ea2d919fd9c79..c9c65b132c0fd 100644
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

