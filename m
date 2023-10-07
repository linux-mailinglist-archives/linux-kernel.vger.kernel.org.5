Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF87BC9D0
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 22:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbjJGUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 16:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344187AbjJGUgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 16:36:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A4593;
        Sat,  7 Oct 2023 13:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tO4I1YN3rjgRtaLOwI5RhJx4suxpIK/NlbOhBn3dZ+E=; b=kCGf5OHKv1yLhAGaMJql4oo/aY
        oDrgdQTXvr2bazyv2FCtxnoyhilrDWQktqCsorTTPfXQ8CANTTikiR/c5LrqHxvnwV0TPPm+cLOcT
        cbZb3+jKkTqYoGLkPuflfJ4d+vjrlHf6EokCVmDD/NQTyXzDPUdp2ILpK9eKf1n4ZHCRs7vj/K5hW
        NAtOXWYKChX3rHQnOVxoK1wfIV0Z0IybOnaEAcHXJjtJK863oYBqC8gAnUY1czauBv5ZiNEvm0iGF
        pXMHml50dSk2YAiDSVT56nFM6/WnZX1uRBvZ32aBt3DRK6SFcpOGPJUuGOixBEQi0FyohEnh7w7pW
        EU3o0Vmw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qpE1Y-005mLE-OL; Sat, 07 Oct 2023 20:35:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v2 3/5] xfs: Replace xfs_isilocked with xfs_assert_locked
Date:   Sat,  7 Oct 2023 21:35:41 +0100
Message-Id: <20231007203543.1377452-4-willy@infradead.org>
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

To use the new rwsem_assert_held()/rwsem_assert_held_write(), we can't
use the existing ASSERT macro.

xfs_assert_ilocked(ip,  XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL) checks both the
IOLOCK and the ILOCK are held for write.  xfs_isilocked() only checked
that the ILOCK was held for write.

xfs_assert_ilocked() is always on, even if DEBUG or XFS_WARN aren't
defined.  It's a cheap check, so I don't think it's worth defining
it away.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/xfs/libxfs/xfs_attr.c        |  2 +-
 fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
 fs/xfs/libxfs/xfs_bmap.c        | 19 +++++----
 fs/xfs/libxfs/xfs_defer.c       |  2 +-
 fs/xfs/libxfs/xfs_inode_fork.c  |  2 +-
 fs/xfs/libxfs/xfs_rtbitmap.c    |  2 +-
 fs/xfs/libxfs/xfs_trans_inode.c |  6 +--
 fs/xfs/scrub/readdir.c          |  4 +-
 fs/xfs/xfs_attr_list.c          |  2 +-
 fs/xfs/xfs_bmap_util.c          | 10 ++---
 fs/xfs/xfs_dir2_readdir.c       |  2 +-
 fs/xfs/xfs_dquot.c              |  4 +-
 fs/xfs/xfs_file.c               |  4 +-
 fs/xfs/xfs_inode.c              | 72 +++++++++++----------------------
 fs/xfs/xfs_inode.h              |  2 +-
 fs/xfs/xfs_inode_item.c         |  4 +-
 fs/xfs/xfs_iops.c               |  3 +-
 fs/xfs/xfs_qm.c                 | 10 ++---
 fs/xfs/xfs_reflink.c            |  2 +-
 fs/xfs/xfs_rtalloc.c            |  4 +-
 fs/xfs/xfs_symlink.c            |  2 +-
 fs/xfs/xfs_trans_dquot.c        |  2 +-
 22 files changed, 66 insertions(+), 96 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
index e28d93d232de..ebf0722d8963 100644
--- a/fs/xfs/libxfs/xfs_attr.c
+++ b/fs/xfs/libxfs/xfs_attr.c
@@ -224,7 +224,7 @@ int
 xfs_attr_get_ilocked(
 	struct xfs_da_args	*args)
 {
-	ASSERT(xfs_isilocked(args->dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(args->dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
 
 	if (!xfs_inode_hasattr(args->dp))
 		return -ENOATTR;
diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
index d440393b40eb..1c007ebf153a 100644
--- a/fs/xfs/libxfs/xfs_attr_remote.c
+++ b/fs/xfs/libxfs/xfs_attr_remote.c
@@ -545,7 +545,7 @@ xfs_attr_rmtval_stale(
 	struct xfs_buf		*bp;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	if (XFS_IS_CORRUPT(mp, map->br_startblock == DELAYSTARTBLOCK) ||
 	    XFS_IS_CORRUPT(mp, map->br_startblock == HOLESTARTBLOCK))
diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
index 30c931b38853..d70cf543a52d 100644
--- a/fs/xfs/libxfs/xfs_bmap.c
+++ b/fs/xfs/libxfs/xfs_bmap.c
@@ -1189,7 +1189,7 @@ xfs_iread_extents(
 	if (!xfs_need_iread_extents(ifp))
 		return 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	ir.loaded = 0;
 	xfs_iext_first(ifp, &ir.icur);
@@ -3883,7 +3883,7 @@ xfs_bmapi_read(
 
 	ASSERT(*nmap >= 1);
 	ASSERT(!(flags & ~(XFS_BMAPI_ATTRFORK | XFS_BMAPI_ENTIRE)));
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_SHARED|XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_SHARED|XFS_ILOCK_EXCL);
 
 	if (WARN_ON_ONCE(!ifp))
 		return -EFSCORRUPTED;
@@ -4354,7 +4354,7 @@ xfs_bmapi_write(
 	ASSERT(tp != NULL);
 	ASSERT(len > 0);
 	ASSERT(ifp->if_format != XFS_DINODE_FMT_LOCAL);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(!(flags & XFS_BMAPI_REMAP));
 
 	/* zeroing is for currently only for data extents, not metadata */
@@ -4651,7 +4651,7 @@ xfs_bmapi_remap(
 	ifp = xfs_ifork_ptr(ip, whichfork);
 	ASSERT(len > 0);
 	ASSERT(len <= (xfs_filblks_t)XFS_MAX_BMBT_EXTLEN);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(!(flags & ~(XFS_BMAPI_ATTRFORK | XFS_BMAPI_PREALLOC |
 			   XFS_BMAPI_NORMAP)));
 	ASSERT((flags & (XFS_BMAPI_ATTRFORK | XFS_BMAPI_PREALLOC)) !=
@@ -5305,7 +5305,7 @@ __xfs_bunmapi(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(len > 0);
 	ASSERT(nexts >= 0);
 
@@ -5648,8 +5648,7 @@ xfs_bmse_merge(
 
 	blockcount = left->br_blockcount + got->br_blockcount;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 	ASSERT(xfs_bmse_can_merge(left, got, shift));
 
 	new = *left;
@@ -5777,7 +5776,7 @@ xfs_bmap_collapse_extents(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 
 	error = xfs_iread_extents(tp, ip, whichfork);
 	if (error)
@@ -5850,7 +5849,7 @@ xfs_bmap_can_insert_extents(
 	int			is_empty;
 	int			error = 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	if (xfs_is_shutdown(ip->i_mount))
 		return -EIO;
@@ -5892,7 +5891,7 @@ xfs_bmap_insert_extents(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 
 	error = xfs_iread_extents(tp, ip, whichfork);
 	if (error)
diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
index bcfb6a4203cd..7927a721dc86 100644
--- a/fs/xfs/libxfs/xfs_defer.c
+++ b/fs/xfs/libxfs/xfs_defer.c
@@ -744,7 +744,7 @@ xfs_defer_ops_capture(
 	 * transaction.
 	 */
 	for (i = 0; i < dfc->dfc_held.dr_inos; i++) {
-		ASSERT(xfs_isilocked(dfc->dfc_held.dr_ip[i], XFS_ILOCK_EXCL));
+		xfs_assert_ilocked(dfc->dfc_held.dr_ip[i], XFS_ILOCK_EXCL);
 		ihold(VFS_I(dfc->dfc_held.dr_ip[i]));
 	}
 
diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
index 5a2e7ddfa76d..14193e044f3d 100644
--- a/fs/xfs/libxfs/xfs_inode_fork.c
+++ b/fs/xfs/libxfs/xfs_inode_fork.c
@@ -563,7 +563,7 @@ xfs_iextents_copy(
 	struct xfs_bmbt_irec	rec;
 	int64_t			copied = 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED);
 	ASSERT(ifp->if_bytes > 0);
 
 	for_each_xfs_iext(ifp, &icur, &rec) {
diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
index fa180ab66b73..4146b8697c89 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -974,7 +974,7 @@ xfs_rtfree_extent(
 	mp = tp->t_mountp;
 
 	ASSERT(mp->m_rbmip->i_itemp != NULL);
-	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
 
 	error = xfs_rtcheck_alloc_range(mp, tp, bno, len);
 	if (error)
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 6b2296ff248a..05229fdef36b 100644
--- a/fs/xfs/libxfs/xfs_trans_inode.c
+++ b/fs/xfs/libxfs/xfs_trans_inode.c
@@ -31,7 +31,7 @@ xfs_trans_ijoin(
 {
 	struct xfs_inode_log_item *iip;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (ip->i_itemp == NULL)
 		xfs_inode_item_init(ip, ip->i_mount);
 	iip = ip->i_itemp;
@@ -60,7 +60,7 @@ xfs_trans_ichgtime(
 	struct timespec64	tv;
 
 	ASSERT(tp);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	tv = current_time(inode);
 
@@ -90,7 +90,7 @@ xfs_trans_log_inode(
 	struct inode		*inode = VFS_I(ip);
 
 	ASSERT(iip);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(!xfs_iflags_test(ip, XFS_ISTALE));
 
 	tp->t_flags |= XFS_TRANS_DIRTY;
diff --git a/fs/xfs/scrub/readdir.c b/fs/xfs/scrub/readdir.c
index e51c1544be63..0b200bab04c8 100644
--- a/fs/xfs/scrub/readdir.c
+++ b/fs/xfs/scrub/readdir.c
@@ -283,7 +283,7 @@ xchk_dir_walk(
 		return -EIO;
 
 	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
-	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
 
 	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL)
 		return xchk_dir_walk_sf(sc, dp, dirent_fn, priv);
@@ -334,7 +334,7 @@ xchk_dir_lookup(
 		return -EIO;
 
 	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
-	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
 
 	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
 		error = xfs_dir2_sf_lookup(&args);
diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
index 99bbbe1a0e44..235dd125c92f 100644
--- a/fs/xfs/xfs_attr_list.c
+++ b/fs/xfs/xfs_attr_list.c
@@ -505,7 +505,7 @@ xfs_attr_list_ilocked(
 {
 	struct xfs_inode		*dp = context->dp;
 
-	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
 
 	/*
 	 * Decide on what work routines to call based on the inode size.
diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
index fcefab687285..1bd430f69d44 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -655,8 +655,8 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL) ||
-	       (VFS_I(ip)->i_state & I_FREEING));
+	if (!(VFS_I(ip)->i_state & I_FREEING))
+		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
 	if (!S_ISREG(VFS_I(ip)->i_mode))
@@ -1112,8 +1112,7 @@ xfs_collapse_file_space(
 	xfs_fileoff_t		shift_fsb = XFS_B_TO_FSB(mp, len);
 	bool			done = false;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 
 	trace_xfs_collapse_file_space(ip);
 
@@ -1182,8 +1181,7 @@ xfs_insert_file_space(
 	xfs_fileoff_t		shift_fsb = XFS_B_TO_FSB(mp, len);
 	bool			done = false;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 
 	trace_xfs_insert_file_space(ip);
 
diff --git a/fs/xfs/xfs_dir2_readdir.c b/fs/xfs/xfs_dir2_readdir.c
index 9f3ceb461515..95cd8b9cf3dc 100644
--- a/fs/xfs/xfs_dir2_readdir.c
+++ b/fs/xfs/xfs_dir2_readdir.c
@@ -521,7 +521,7 @@ xfs_readdir(
 		return -EIO;
 
 	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
-	ASSERT(xfs_isilocked(dp, XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(dp, XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
 	XFS_STATS_INC(dp->i_mount, xs_dir_getdents);
 
 	args.dp = dp;
diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index ac6ba646624d..4b2f1b82badc 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -949,7 +949,7 @@ xfs_qm_dqget_inode(
 	if (error)
 		return error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(xfs_inode_dquot(ip, type) == NULL);
 
 	id = xfs_qm_id_for_quotatype(ip, type);
@@ -1006,7 +1006,7 @@ xfs_qm_dqget_inode(
 	}
 
 dqret:
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	trace_xfs_dqget_miss(dqp);
 	*O_dqpp = dqp;
 	return 0;
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 203700278ddb..9ba2b89b3862 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -842,7 +842,7 @@ xfs_break_dax_layouts(
 {
 	struct page		*page;
 
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
 	page = dax_layout_busy_page(inode->i_mapping);
 	if (!page)
@@ -863,7 +863,7 @@ xfs_break_layouts(
 	bool			retry;
 	int			error;
 
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(XFS_I(inode), XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
 
 	do {
 		retry = false;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 4d55f58d99b7..812d6f255d84 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -333,52 +333,26 @@ xfs_ilock_demote(
 	trace_xfs_ilock_demote(ip, lock_flags, _RET_IP_);
 }
 
-#if defined(DEBUG) || defined(XFS_WARN)
-static inline bool
-__xfs_rwsem_islocked(
-	struct rw_semaphore	*rwsem,
-	bool			shared)
-{
-	if (!debug_locks)
-		return rwsem_is_locked(rwsem);
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
-bool
-xfs_isilocked(
+void
+xfs_assert_ilocked(
 	struct xfs_inode	*ip,
 	uint			lock_flags)
 {
-	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
-		if (!(lock_flags & XFS_ILOCK_SHARED))
-			return !!ip->i_lock.mr_writer;
-		return rwsem_is_locked(&ip->i_lock.mr_lock);
-	}
-
-	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
-		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
-				(lock_flags & XFS_MMAPLOCK_SHARED));
-	}
-
-	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
-		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
-				(lock_flags & XFS_IOLOCK_SHARED));
-	}
-
-	ASSERT(0);
-	return false;
+	if (lock_flags & XFS_ILOCK_SHARED)
+		rwsem_assert_held(&ip->i_lock.mr_lock);
+	else if (lock_flags & XFS_ILOCK_EXCL)
+		BUG_ON(!ip->i_lock.mr_writer);
+
+	if (lock_flags & XFS_MMAPLOCK_SHARED)
+		rwsem_assert_held(&VFS_I(ip)->i_mapping->invalidate_lock);
+	else if (lock_flags & XFS_MMAPLOCK_EXCL)
+		rwsem_assert_held_write(&VFS_I(ip)->i_mapping->invalidate_lock);
+
+	if (lock_flags & XFS_IOLOCK_SHARED)
+		rwsem_assert_held(&VFS_I(ip)->i_rwsem);
+	else if (lock_flags & XFS_IOLOCK_EXCL)
+		rwsem_assert_held_write(&VFS_I(ip)->i_rwsem);
 }
-#endif
 
 /*
  * xfs_lockdep_subclass_ok() is only used in an ASSERT, so is only called when
@@ -1335,9 +1309,9 @@ xfs_itruncate_extents_flags(
 	xfs_filblks_t		unmap_len;
 	int			error = 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
-	ASSERT(!atomic_read(&VFS_I(ip)->i_count) ||
-	       xfs_isilocked(ip, XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
+	if (atomic_read(&VFS_I(ip)->i_count))
+		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 	ASSERT(new_size <= XFS_ISIZE(ip));
 	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
 	ASSERT(ip->i_itemp != NULL);
@@ -1598,7 +1572,7 @@ xfs_inactive_ifree(
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 
 	error = xfs_ifree(tp, ip);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (error) {
 		/*
 		 * If we fail to free the inode, shut down.  The cancel
@@ -2352,7 +2326,7 @@ xfs_ifree(
 	struct xfs_inode_log_item *iip = ip->i_itemp;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(VFS_I(ip)->i_nlink == 0);
 	ASSERT(ip->i_df.if_nextents == 0);
 	ASSERT(ip->i_disk_size == 0 || !S_ISREG(VFS_I(ip)->i_mode));
@@ -2421,7 +2395,7 @@ static void
 xfs_iunpin(
 	struct xfs_inode	*ip)
 {
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED);
 
 	trace_xfs_inode_unpin_nowait(ip, _RET_IP_);
 
@@ -3182,7 +3156,7 @@ xfs_iflush(
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED);
 	ASSERT(xfs_iflags_test(ip, XFS_IFLUSHING));
 	ASSERT(ip->i_df.if_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_df.if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK));
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 0c5bdb91152e..b70f3e8e4525 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -515,7 +515,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
 int		xfs_ilock_nowait(xfs_inode_t *, uint);
 void		xfs_iunlock(xfs_inode_t *, uint);
 void		xfs_ilock_demote(xfs_inode_t *, uint);
-bool		xfs_isilocked(struct xfs_inode *, uint);
+void		xfs_assert_ilocked(struct xfs_inode *, uint);
 uint		xfs_ilock_data_map_shared(struct xfs_inode *);
 uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 127b2410eb20..02427b53328f 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -648,7 +648,7 @@ xfs_inode_item_pin(
 {
 	struct xfs_inode	*ip = INODE_ITEM(lip)->ili_inode;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(lip->li_buf);
 
 	trace_xfs_inode_pin(ip, _RET_IP_);
@@ -754,7 +754,7 @@ xfs_inode_item_release(
 	unsigned short		lock_flags;
 
 	ASSERT(ip->i_itemp != NULL);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	lock_flags = iip->ili_lock_flags;
 	iip->ili_lock_flags = 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 1c1e6171209d..2492b746912e 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -791,8 +791,7 @@ xfs_setattr_size(
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 	ASSERT(S_ISREG(inode->i_mode));
 	ASSERT((iattr->ia_valid & (ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_ATIME_SET|
 		ATTR_MTIME_SET|ATTR_TIMES_SET)) == 0);
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 086e78a6143a..660e7878db0d 100644
--- a/fs/xfs/xfs_qm.c
+++ b/fs/xfs/xfs_qm.c
@@ -254,7 +254,7 @@ xfs_qm_dqattach_one(
 	struct xfs_dquot	*dqp;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	error = 0;
 
 	/*
@@ -322,7 +322,7 @@ xfs_qm_dqattach_locked(
 	if (!xfs_qm_need_dqattach(ip))
 		return 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	if (XFS_IS_UQUOTA_ON(mp) && !ip->i_udquot) {
 		error = xfs_qm_dqattach_one(ip, XFS_DQTYPE_USER,
@@ -353,7 +353,7 @@ xfs_qm_dqattach_locked(
 	 * Don't worry about the dquots that we may have attached before any
 	 * error - they'll get detached later if it has not already been done.
 	 */
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	return error;
 }
 
@@ -1808,7 +1808,7 @@ xfs_qm_vop_chown(
 				 XFS_TRANS_DQ_RTBCOUNT : XFS_TRANS_DQ_BCOUNT;
 
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(XFS_IS_QUOTA_ON(ip->i_mount));
 
 	/* old dquot */
@@ -1896,7 +1896,7 @@ xfs_qm_vop_create_dqattach(
 	if (!XFS_IS_QUOTA_ON(mp))
 		return;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
 		ASSERT(ip->i_udquot == NULL);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index eb9102453aff..1267e008014e 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -527,7 +527,7 @@ xfs_reflink_allocate_cow(
 	int			error;
 	bool			found;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (!ip->i_cowfp) {
 		ASSERT(!xfs_is_reflink_inode(ip));
 		xfs_ifork_init_cow(ip);
diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
index 16534e9873f6..29382bc9d373 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1188,7 +1188,7 @@ xfs_rtallocate_extent(
 	xfs_fsblock_t	sb;		/* summary file block number */
 	struct xfs_buf	*sumbp;		/* summary file block buffer */
 
-	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
 	ASSERT(minlen > 0 && minlen <= maxlen);
 
 	/*
@@ -1431,7 +1431,7 @@ xfs_rtpick_extent(
 	uint64_t	seq;		/* sequence number of file creation */
 	uint64_t	*seqp;		/* pointer to seqno in inode */
 
-	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
 
 	seqp = (uint64_t *)&VFS_I(mp->m_rbmip)->i_atime;
 	if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
index 85e433df6a3f..2ca157de4a73 100644
--- a/fs/xfs/xfs_symlink.c
+++ b/fs/xfs/xfs_symlink.c
@@ -43,7 +43,7 @@ xfs_readlink_bmap_ilocked(
 	int			fsblocks = 0;
 	int			offset;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
 
 	fsblocks = xfs_symlink_blocks(mp, pathlen);
 	error = xfs_bmapi_read(ip, 0, fsblocks, mval, &nmaps, 0);
diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
index aa00cf67ad72..9c159d016ecf 100644
--- a/fs/xfs/xfs_trans_dquot.c
+++ b/fs/xfs/xfs_trans_dquot.c
@@ -796,7 +796,7 @@ xfs_trans_reserve_quota_nblks(
 		return 0;
 
 	ASSERT(!xfs_is_quota_inode(&mp->m_sb, ip->i_ino));
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	if (force)
 		qflags |= XFS_QMOPT_FORCE_RES;
-- 
2.40.1

