Return-Path: <linux-kernel+bounces-24086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6904182B69D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2AAF2880B9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE97758AAD;
	Thu, 11 Jan 2024 21:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SUOmIqox"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5378358235;
	Thu, 11 Jan 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YCY8NmfqxhdCM5IFvMH03A2WXmdyGvl0bRxwl4R74o4=; b=SUOmIqox1yukaBx32qLy2OGCiL
	UlZyaPhp/OX9HDD/pmBw32C72gRU5bEjtjfbAbevzxgi04/r2P3fwCvV1iLUJu5lcwDMkludKdNmJ
	h74/js7+aRDwZMhRRhbMMcwl6a54mhEiiRAf91OM+MrKkX958PDpBvZIpdlWWRtdJELNKuwGobjNd
	EMkrm7Vt/tZYYuXfCqe2eqzY09XAIAraXYLiMns6FanfoXCp7JD5tzPXYeztI00ts18Y0k3M7CwC+
	M8GyShzzu+wYdH23Rq/g+EON4fe1oTV+enNYXaOIb9dbRqLUE7YE4R34jrr0MGr2pdq77WXgxyl3W
	PtsYErLw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rO2XO-00EzIK-Mx; Thu, 11 Jan 2024 21:24:30 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Chandan Babu R <chandan.babu@oracle.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	"Darrick J . Wong" <djwong@kernel.org>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v5 3/3] xfs: Remove mrlock wrapper
Date: Thu, 11 Jan 2024 21:24:24 +0000
Message-Id: <20240111212424.3572189-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20240111212424.3572189-1-willy@infradead.org>
References: <20240111212424.3572189-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index 728b3bc1c3db..b9b2af913e89 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -203,9 +203,9 @@ xfs_ilock(
 	}
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrupdate_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
+		down_write_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
 	else if (lock_flags & XFS_ILOCK_SHARED)
-		mraccess_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
+		down_read_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
 }
 
 /*
@@ -246,10 +246,10 @@ xfs_ilock_nowait(
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
@@ -298,9 +298,9 @@ xfs_iunlock(
 		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrunlock_excl(&ip->i_lock);
+		up_write(&ip->i_lock);
 	else if (lock_flags & XFS_ILOCK_SHARED)
-		mrunlock_shared(&ip->i_lock);
+		up_read(&ip->i_lock);
 
 	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
 }
@@ -319,7 +319,7 @@ xfs_ilock_demote(
 		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
 
 	if (lock_flags & XFS_ILOCK_EXCL)
-		mrdemote(&ip->i_lock);
+		downgrade_write(&ip->i_lock);
 	if (lock_flags & XFS_MMAPLOCK_EXCL)
 		downgrade_write(&VFS_I(ip)->i_mapping->invalidate_lock);
 	if (lock_flags & XFS_IOLOCK_EXCL)
@@ -333,10 +333,14 @@ xfs_assert_ilocked(
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
-		ASSERT(ip->i_lock.mr_writer);
+		rwsem_assert_held_write_nolockdep(&ip->i_lock);
 
 	if (lock_flags & XFS_MMAPLOCK_SHARED)
 		rwsem_assert_held(&VFS_I(ip)->i_mapping->invalidate_lock);
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index dcc818901a79..796d11065fe2 100644
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
index e7fca1913175..73f46486c252 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -1284,9 +1284,9 @@ xfs_setup_inode(
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
index d7873e0360f0..ec3c6c138a63 100644
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
index aff20ddd4a9f..15831c53a83b 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -716,9 +716,7 @@ xfs_fs_inode_init_once(
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
2.43.0


