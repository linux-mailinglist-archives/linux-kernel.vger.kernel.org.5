Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6030B797A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245357AbjIGRrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245396AbjIGRrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9466892;
        Thu,  7 Sep 2023 10:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9FU0HDBbS9848C77tpg24Iv2uyZEtVXyAgpiQsjv/fA=; b=NcXGBCh5BPyjAcESrPbWgrRsvW
        PDdtlXUAW0k8lC/IdN0FAJeBK1laH7kwHd4DLz5VGxpxlbeGjY5LEWxmT2mnCzfiDg/9MxX1y9YIq
        Aco2rxkVPG1Q5cC4t6HrgpCG7dzJ/n00GBBB5HYp+YIDycwMRJ2stN/4f6UCE/cu+yDvEPg/xymUe
        gxLzC04nT4WV/5Np19ENi1c6ygMEpl7CoMfjbF6CfUeB2VJ80U//JUdE1S4mVgoEnKU3m4Us/q4ti
        l2voBmp7JV5jVnAX2/7wySndJLGXrAMrdqgKY6dmc/C4GztfYiBEY6CBASMTB1vOnuCu23xjQCZ8Y
        6X3U3qxQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeJ5w-00CUFT-91; Thu, 07 Sep 2023 17:47:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 5/5] xfs: Stop using lockdep to assert that locks are held
Date:   Thu,  7 Sep 2023 18:47:05 +0100
Message-Id: <20230907174705.2976191-6-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230907174705.2976191-1-willy@infradead.org>
References: <20230907174705.2976191-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lockdep does not know that the worker thread has inherited the lock
from its caller.  Rather than dance around moving the ownership from the
caller to the thread and back again, just remove the lockdep assertions
and rely on the rwsem itself to tell us whether _somebody_ is holding
the lock at the moment.

__xfs_rwsem_islocked() simplifies into a trivial function, which is easy
to inline into xfs_isilocked().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_inode.c | 40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c3cd73c29868..81ee6bf8c662 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -334,29 +334,6 @@ xfs_ilock_demote(
 }
 
 #if defined(DEBUG) || defined(XFS_WARN)
-static inline bool
-__xfs_rwsem_islocked(
-	struct rw_semaphore	*rwsem,
-	bool			shared)
-{
-	if (!debug_locks) {
-		if (!shared)
-			return rwsem_is_write_locked(rwsem);
-		return rwsem_is_locked(rwsem);
-	}
-
-	if (!shared)
-		return lockdep_is_held_type(rwsem, 0);
-
-	/*
-	 * We are checking that the lock is held at least in shared
-	 * mode but don't care that it might be held exclusively
-	 * (i.e. shared | excl). Hence we check if the lock is held
-	 * in any mode rather than an explicit shared mode.
-	 */
-	return lockdep_is_held_type(rwsem, -1);
-}
-
 bool
 xfs_isilocked(
 	struct xfs_inode	*ip,
@@ -366,15 +343,14 @@ xfs_isilocked(
 		return rwsem_is_locked(&ip->i_lock);
 	if (lock_flags & XFS_ILOCK_EXCL)
 		return rwsem_is_write_locked(&ip->i_lock);
-	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
-		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
-				(lock_flags & XFS_MMAPLOCK_SHARED));
-	}
-
-	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
-		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
-				(lock_flags & XFS_IOLOCK_SHARED));
-	}
+	if (lock_flags & XFS_MMAPLOCK_SHARED)
+		return rwsem_is_locked(&VFS_I(ip)->i_mapping->invalidate_lock);
+	if (lock_flags & XFS_MMAPLOCK_EXCL)
+		return rwsem_is_write_locked(&VFS_I(ip)->i_mapping->invalidate_lock);
+	if (lock_flags & XFS_IOLOCK_SHARED)
+		return rwsem_is_locked(&VFS_I(ip)->i_rwsem);
+	if (lock_flags & XFS_IOLOCK_EXCL)
+		return rwsem_is_write_locked(&VFS_I(ip)->i_rwsem);
 
 	ASSERT(0);
 	return false;
-- 
2.40.1

