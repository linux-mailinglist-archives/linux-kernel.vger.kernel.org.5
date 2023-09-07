Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE85F797AC1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245414AbjIGRsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245516AbjIGRrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:47:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F541FEC;
        Thu,  7 Sep 2023 10:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wD6jndt8wbHj+DL+KkiwehRezl2XHcQmRoPgvfO+F4I=; b=nF26xSCABiPufnNgK3G2trN8Zm
        15ekZrNYw2ptW9dbui8bV+AHuMNUASEcvB5o1xmBMGDWlFSCSX0C5wAj/svU/64WCqMG5XQ9K+tvj
        EYN10+S4ZDVeKfrKGbK/HyNHnzL509E2KUjoiBr8rEyDoxk3s1ie3fda6OIL+WD7qTFg/2IxxjK7Q
        U/3tHfGX4klo3XbKbbvi/aFGhGAiO7HckY8AwXoRANtBsxk4K+scpYQJ4NYQIvbAe9ocTPbszSS1L
        kyQLCkX0txtmHtVJUcG6kiR4BCbB6Rj6griCoOTUOy1OoPPO1Z1zynUfx0vwTpeNi7JRe4nfQ0pN2
        GEq9iA8w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qeJ5w-00CUFP-3W; Thu, 07 Sep 2023 17:47:08 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org
Subject: [PATCH 3/5] xfs: Use rwsem_is_write_locked()
Date:   Thu,  7 Sep 2023 18:47:03 +0100
Message-Id: <20230907174705.2976191-4-willy@infradead.org>
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

This avoids using the mr_writer field to check the XFS ILOCK is held
for write.  It also improves the checking we do when lockdep is disabled.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/xfs_inode.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 360fe83a334f..e58d84d23f49 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -339,8 +339,11 @@ __xfs_rwsem_islocked(
 	struct rw_semaphore	*rwsem,
 	bool			shared)
 {
-	if (!debug_locks)
+	if (!debug_locks) {
+		if (!shared)
+			return rwsem_is_write_locked(rwsem);
 		return rwsem_is_locked(rwsem);
+	}
 
 	if (!shared)
 		return lockdep_is_held_type(rwsem, 0);
@@ -359,12 +362,10 @@ xfs_isilocked(
 	struct xfs_inode	*ip,
 	uint			lock_flags)
 {
-	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
-		if (!(lock_flags & XFS_ILOCK_SHARED))
-			return !!ip->i_lock.mr_writer;
+	if (lock_flags & XFS_ILOCK_SHARED)
 		return rwsem_is_locked(&ip->i_lock.mr_lock);
-	}
-
+	if (lock_flags & XFS_ILOCK_EXCL)
+		return rwsem_is_write_locked(&ip->i_lock.mr_lock);
 	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
 		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
 				(lock_flags & XFS_MMAPLOCK_SHARED));
-- 
2.40.1

