Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680CF7BC9CA
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjJGUgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:36:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343782AbjJGUgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:36:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50719F;
        Sat,  7 Oct 2023 13:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=XSq7hOCZtUTD3xmIh2+j7L/eFgD05O4FG3L1sm/q0vU=; b=vvK0TzTj5czxdfAs0vX3rONj3R
        CyOinIlNZZFgSisIAlafVf+YcJotrT54o8RfwWrEfl4Mjhkq/6gRHoXp/GWLfEav5h+9d27Lfgrue
        kZGkrdGXIjvuB+ies2741IrTpLI7ISbl8uaY0x0VP2r5Pf0ADQGLNcRjFiZe9AfHj8rWjKI1s1zW2
        rycySDH7CUC80HfTQA6VuVMJJrM/ktxfimoYiC6Cj75IE8oXjIPrQX1+xTMSdswir1pIJ8ynDLu0R
        gABbXZ8H2vDfxTFUt/pzfNKXILKBZcVquhCtWVbqfSey1hKSSUCcZNtNXBSnKHmdRldFXYMUtIeW+
        2J0CfQBw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpE1Y-005mLG-Rn; Sat, 07 Oct 2023 20:35:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 4/5] xfs: Remove mrlock wrapper
Date:   Sat,  7 Oct 2023 21:35:42 +0100
Message-Id: <20231007203543.1377452-5-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231007203543.1377452-1-willy@infradead.org>
References: <20231007203543.1377452-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mrlock was an rwsem wrapper that also recorded whether the lock was
held for read or write.  Now that we can ask the generic code whether
the lock is held for read or write, we can remove this wrapper and use
an rwsem directly.

As the comment says, we can't use lockdep to assert that the ILOCK is
held for write, because we might be in a workqueue, and we aren't able
to tell lockdep that we do in fact own the lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/mrlock.h    | 78 ----------------------------------------------
 fs/xfs/xfs_inode.c | 22 +++++++------
 fs/xfs/xfs_inode.h |  2 +-
 fs/xfs/xfs_iops.c  |  4 +--
 fs/xfs/xfs_linux.h |  2 +-
 fs/xfs/xfs_super.c |  4 +--
 6 files changed, 18 insertions(+), 94 deletions(-)
 delete mode 100644 fs/xfs/mrlock.h

diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
deleted file mode 100644
index 79155eec341b..000000000000
--- a/fs/xfs/mrlock.h
+++ /dev/null
@@ -1,78 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2000-2006 Silicon Graphics, Inc.
- * All Rights Reserved.
- */
-#ifndef __XFS_SUPPORT_MRLOCK_H__
-#define __XFS_SUPPORT_MRLOCK_H__
-
-#include <linux/rwsem.h>
-
-typedef struct {
-	struct rw_semaphore	mr_lock;
-#if defined(DEBUG) || defined(XFS_WARN)
-	int			mr_writer;
-#endif
-} mrlock_t;
-
-#if defined(DEBUG) || defined(XFS_WARN)
-#define mrinit(mrp, name)	\
-	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
-#else
-#define mrinit(mrp, name)	\
-	do { init_rwsem(&(mrp)->mr_lock); } while (0)
-#endif
-
-#define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
-#define mrfree(mrp)		do { } while (0)
-
-static inline void mraccess_nested(mrlock_t *mrp, int subclass)
-{
-	down_read_nested(&mrp->mr_lock, subclass);
-}
-
-static inline void mrupdate_nested(mrlock_t *mrp, int subclass)
-{
-	down_write_nested(&mrp->mr_lock, subclass);
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 1;
-#endif
-}
-
-static inline int mrtryaccess(mrlock_t *mrp)
-{
-	return down_read_trylock(&mrp->mr_lock);
-}
-
-static inline int mrtryupdate(mrlock_t *mrp)
-{
-	if (!down_write_trylock(&mrp->mr_lock))
-		return 0;
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 1;
-#endif
-	return 1;
-}
-
-static inline void mrunlock_excl(mrlock_t *mrp)
-{
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 0;
-#endif
-	up_write(&mrp->mr_lock);
-}
-
-static inline void mrunlock_shared(mrlock_t *mrp)
-{
-	up_read(&mrp->mr_lock);
-}
-
-static inline void mrdemote(mrlock_t *mrp)
-{
-#if defined(DEBUG) || defined(XFS_WARN)
-	mrp->mr_writer = 0;
-#endif
-	downgrade_write(&mrp->mr_lock);
-}
-
-#endif /* __XFS_SUPPORT_MRLOCK_H__ */
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 812d6f255d84..a6d9a834d869 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -208,9 +208,9 @@ xfs_ilock(
 	}
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrupdate_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
+		down_write_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
 	else if (lock_flags & XFS_ILOCK_SHARED)
-		mraccess_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
+		down_read_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
 }
 
 /*
@@ -251,10 +251,10 @@ xfs_ilock_nowait(
 	}
 
 	if (lock_flags & XFS_ILOCK_EXCL) {
-		if (!mrtryupdate(&ip->i_lock))
+		if (!down_write_trylock(&ip->i_lock))
 			goto out_undo_mmaplock;
 	} else if (lock_flags & XFS_ILOCK_SHARED) {
-		if (!mrtryaccess(&ip->i_lock))
+		if (!down_read_trylock(&ip->i_lock))
 			goto out_undo_mmaplock;
 	}
 	return 1;
@@ -303,9 +303,9 @@ xfs_iunlock(
 		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrunlock_excl(&ip->i_lock);
+		up_write(&ip->i_lock);
 	else if (lock_flags & XFS_ILOCK_SHARED)
-		mrunlock_shared(&ip->i_lock);
+		up_read(&ip->i_lock);
 
 	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
 }
@@ -324,7 +324,7 @@ xfs_ilock_demote(
 		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrdemote(&ip->i_lock);
+		downgrade_write(&ip->i_lock);
 	if (lock_flags & XFS_MMAPLOCK_EXCL)
 		downgrade_write(&VFS_I(ip)->i_mapping->invalidate_lock);
 	if (lock_flags & XFS_IOLOCK_EXCL)
@@ -338,10 +338,14 @@ xfs_assert_ilocked(
 	struct xfs_inode	*ip,
 	uint			lock_flags)
 {
+	/*
+	 * Sometimes we assert the ILOCK is held exclusively, but we're in
+	 * a workqueue, so lockdep doesn't know we're the owner.
+	 */
 	if (lock_flags & XFS_ILOCK_SHARED)
-		rwsem_assert_held(&ip->i_lock.mr_lock);
+		rwsem_assert_held(&ip->i_lock);
 	else if (lock_flags & XFS_ILOCK_EXCL)
-		BUG_ON(!ip->i_lock.mr_writer);
+		__rwsem_assert_held_write(&ip->i_lock);
 
 	if (lock_flags & XFS_MMAPLOCK_SHARED)
 		rwsem_assert_held(&VFS_I(ip)->i_mapping->invalidate_lock);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index b70f3e8e4525..1c2484b6afff 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -39,7 +39,7 @@ typedef struct xfs_inode {
 
 	/* Transaction and locking information. */
 	struct xfs_inode_log_item *i_itemp;	/* logging information */
-	mrlock_t		i_lock;		/* inode lock */
+	struct rw_semaphore	i_lock;		/* inode lock */
 	atomic_t		i_pincount;	/* inode pin count */
 	struct llist_node	i_gclist;	/* deferred inactivation list */
 
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 2492b746912e..fcceb2b4e40d 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1279,9 +1279,9 @@ xfs_setup_inode(
 		 */
 		lockdep_set_class(&inode->i_rwsem,
 				  &inode->i_sb->s_type->i_mutex_dir_key);
-		lockdep_set_class(&ip->i_lock.mr_lock, &xfs_dir_ilock_class);
+		lockdep_set_class(&ip->i_lock, &xfs_dir_ilock_class);
 	} else {
-		lockdep_set_class(&ip->i_lock.mr_lock, &xfs_nondir_ilock_class);
+		lockdep_set_class(&ip->i_lock, &xfs_nondir_ilock_class);
 	}
 
 	/*
diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
index e9d317a3dafe..15fdaef578fe 100644
--- a/fs/xfs/xfs_linux.h
+++ b/fs/xfs/xfs_linux.h
@@ -22,7 +22,6 @@ typedef __u32			xfs_nlink_t;
 #include "xfs_types.h"
 
 #include "kmem.h"
-#include "mrlock.h"
 
 #include <linux/semaphore.h>
 #include <linux/mm.h>
@@ -51,6 +50,7 @@ typedef __u32			xfs_nlink_t;
 #include <linux/notifier.h>
 #include <linux/delay.h>
 #include <linux/log2.h>
+#include <linux/rwsem.h>
 #include <linux/spinlock.h>
 #include <linux/random.h>
 #include <linux/ctype.h>
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 819a3568b28f..19435fa4c6b3 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -717,9 +717,7 @@ xfs_fs_inode_init_once(
 	/* xfs inode */
 	atomic_set(&ip->i_pincount, 0);
 	spin_lock_init(&ip->i_flags_lock);
-
-	mrlock_init(&ip->i_lock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
-		     "xfsino", ip->i_ino);
+	init_rwsem(&ip->i_lock);
 }
 
 /*
-- 
2.40.1

