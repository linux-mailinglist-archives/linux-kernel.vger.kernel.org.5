Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 591777E844F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbjKJUmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:42:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346608AbjKJUmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:42:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8252D185;
        Fri, 10 Nov 2023 12:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=zIWhQPPVGGNsaH/zRjrbtFp7YhWrYOd/f9YxTGaAZsk=; b=V/0LsvqHZxuH1WQBbyi1o8z9ob
        khRauoUl0ia4ev2SntjAolsMV+pTeyIM6ND3ENfIiVNwIuBvpGpuTD7BIeJnU01XB4qQlvavyMN56
        phj4yqYpnOfE+xivPYnjQqNlh622XeuBNdimGTYJqMtRkJA/0xJfLP/kTna/KjzmzYzRXS8FLf/Jw
        6OjsWNF0X+tTLixXMKlA3ysqh4tzhBCE+us7CMebzE1+yPghfsjI2KlmCGkln1pfwyVehm7PICMFg
        5CVV3HceK8SJwsjFFcZ4FA85DrpsIR9Oli15msYV3+hxt7Ta1yau9tjNzDZ862EAZL8mtlxO4dw3e
        aqbnUyHQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r1YJd-00FUT8-7j; Fri, 10 Nov 2023 20:41:21 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 3/4] xfs: Replace xfs_isilocked with xfs_assert_ilocked
Date:   Fri, 10 Nov 2023 20:41:18 +0000
Message-Id: <20231110204119.3692023-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231110204119.3692023-1-willy@infradead.org>
References: <20231110204119.3692023-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To use the new rwsem_assert_held()/rwsem_assert_held_write(), we can't
use the existing ASSERT macro.  Add a new xfs_assert_ilocked() and
convert all the callers.

Fix an apparent bug in xfs_isilocked(): If the caller specifies
XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL, xfs_assert_ilocked() will check both
the IOLOCK and the ILOCK are held for write.  xfs_isilocked() only
checked that the ILOCK was held for write.

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
index be62acffad6c..eaa1dbe9a6b3 100644
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
@@ -5287,7 +5287,7 @@ __xfs_bunmapi(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(len > 0);
 	ASSERT(nexts >= 0);
 
@@ -5631,8 +5631,7 @@ xfs_bmse_merge(
 
 	blockcount = left->br_blockcount + got->br_blockcount;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 	ASSERT(xfs_bmse_can_merge(left, got, shift));
 
 	new = *left;
@@ -5760,7 +5759,7 @@ xfs_bmap_collapse_extents(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
 
 	error = xfs_iread_extents(tp, ip, whichfork);
 	if (error)
@@ -5833,7 +5832,7 @@ xfs_bmap_can_insert_extents(
 	int			is_empty;
 	int			error = 0;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	if (xfs_is_shutdown(ip->i_mount))
 		return -EIO;
@@ -5875,7 +5874,7 @@ xfs_bmap_insert_extents(
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
index c269d704314d..0b094a44c6e2 100644
--- a/fs/xfs/libxfs/xfs_rtbitmap.c
+++ b/fs/xfs/libxfs/xfs_rtbitmap.c
@@ -946,7 +946,7 @@ xfs_rtfree_extent(
 	struct timespec64	atime;
 
 	ASSERT(mp->m_rbmip->i_itemp != NULL);
-	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
 
 	error = xfs_rtcheck_alloc_range(&args, start, len);
 	if (error)
diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
index 70e97ea6eee7..69fc5b981352 100644
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
index 731260a5af6d..0887fb37d84f 100644
--- a/fs/xfs/xfs_bmap_util.c
+++ b/fs/xfs/xfs_bmap_util.c
@@ -649,8 +649,8 @@ xfs_can_free_eofblocks(
 	 * Caller must either hold the exclusive io lock; or be inactivating
 	 * the inode, which guarantees there are no other users of the inode.
 	 */
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL) ||
-	       (VFS_I(ip)->i_state & I_FREEING));
+	if (!(VFS_I(ip)->i_state & I_FREEING))
+		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
 
 	/* prealloc/delalloc exists only on regular files */
 	if (!S_ISREG(VFS_I(ip)->i_mode))
@@ -1106,8 +1106,7 @@ xfs_collapse_file_space(
 	xfs_fileoff_t		shift_fsb = XFS_B_TO_FSB(mp, len);
 	bool			done = false;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 
 	trace_xfs_collapse_file_space(ip);
 
@@ -1176,8 +1175,7 @@ xfs_insert_file_space(
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
index e33e5e13b95f..632653e00906 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -879,7 +879,7 @@ xfs_break_dax_layouts(
 {
 	struct page		*page;
 
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
 
 	page = dax_layout_busy_page(inode->i_mapping);
 	if (!page)
@@ -900,7 +900,7 @@ xfs_break_layouts(
 	bool			retry;
 	int			error;
 
-	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
+	xfs_assert_ilocked(XFS_I(inode), XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
 
 	do {
 		retry = false;
diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index c0f1c89786c2..1ed6bed19bec 100644
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
+		ASSERT(ip->i_lock.mr_writer);
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
@@ -1342,9 +1316,9 @@ xfs_itruncate_extents_flags(
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
@@ -1605,7 +1579,7 @@ xfs_inactive_ifree(
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 
 	error = xfs_ifree(tp, ip);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (error) {
 		/*
 		 * If we fail to free the inode, shut down.  The cancel
@@ -2359,7 +2333,7 @@ xfs_ifree(
 	struct xfs_inode_log_item *iip = ip->i_itemp;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(VFS_I(ip)->i_nlink == 0);
 	ASSERT(ip->i_df.if_nextents == 0);
 	ASSERT(ip->i_disk_size == 0 || !S_ISREG(VFS_I(ip)->i_mode));
@@ -2428,7 +2402,7 @@ static void
 xfs_iunpin(
 	struct xfs_inode	*ip)
 {
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED);
 
 	trace_xfs_inode_unpin_nowait(ip, _RET_IP_);
 
@@ -3189,7 +3163,7 @@ xfs_iflush(
 	struct xfs_mount	*mp = ip->i_mount;
 	int			error;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED);
 	ASSERT(xfs_iflags_test(ip, XFS_IFLUSHING));
 	ASSERT(ip->i_df.if_format != XFS_DINODE_FMT_BTREE ||
 	       ip->i_df.if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK));
diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
index 3dc47937da5d..dd8b8339ba1b 100644
--- a/fs/xfs/xfs_inode.h
+++ b/fs/xfs/xfs_inode.h
@@ -523,7 +523,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
 int		xfs_ilock_nowait(xfs_inode_t *, uint);
 void		xfs_iunlock(xfs_inode_t *, uint);
 void		xfs_ilock_demote(xfs_inode_t *, uint);
-bool		xfs_isilocked(struct xfs_inode *, uint);
+void		xfs_assert_ilocked(struct xfs_inode *, uint);
 uint		xfs_ilock_data_map_shared(struct xfs_inode *);
 uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
 
diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index cd7803fda8b1..3e125be356c1 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -649,7 +649,7 @@ xfs_inode_item_pin(
 {
 	struct xfs_inode	*ip = INODE_ITEM(lip)->ili_inode;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(lip->li_buf);
 
 	trace_xfs_inode_pin(ip, _RET_IP_);
@@ -755,7 +755,7 @@ xfs_inode_item_release(
 	unsigned short		lock_flags;
 
 	ASSERT(ip->i_itemp != NULL);
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	lock_flags = iip->ili_lock_flags;
 	iip->ili_lock_flags = 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index fdfda4fba12b..e711668d601b 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -796,8 +796,7 @@ xfs_setattr_size(
 	uint			lock_flags = 0;
 	bool			did_zeroing = false;
 
-	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
-	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
 	ASSERT(S_ISREG(inode->i_mode));
 	ASSERT((iattr->ia_valid & (ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_ATIME_SET|
 		ATTR_MTIME_SET|ATTR_TIMES_SET)) == 0);
diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
index 94a7932ac570..45cf9a557eb9 100644
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
 
@@ -1809,7 +1809,7 @@ xfs_qm_vop_chown(
 				 XFS_TRANS_DQ_RTBCOUNT : XFS_TRANS_DQ_BCOUNT;
 
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	ASSERT(XFS_IS_QUOTA_ON(ip->i_mount));
 
 	/* old dquot */
@@ -1897,7 +1897,7 @@ xfs_qm_vop_create_dqattach(
 	if (!XFS_IS_QUOTA_ON(mp))
 		return;
 
-	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 
 	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
 		ASSERT(ip->i_udquot == NULL);
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index 658edee8381d..d10eba9548dc 100644
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
index 88c48de5c9c8..5e5eedff71c9 100644
--- a/fs/xfs/xfs_rtalloc.c
+++ b/fs/xfs/xfs_rtalloc.c
@@ -1182,7 +1182,7 @@ xfs_rtallocate_extent(
 	int			error;	/* error value */
 	xfs_rtxnum_t		r;	/* result allocated rtext */
 
-	ASSERT(xfs_isilocked(args.mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(args.mp->m_rbmip, XFS_ILOCK_EXCL);
 	ASSERT(minlen > 0 && minlen <= maxlen);
 
 	/*
@@ -1425,7 +1425,7 @@ xfs_rtpick_extent(
 	uint64_t		seq;		/* sequence number of file creation */
 	struct timespec64	ts;		/* timespec in inode */
 
-	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
+	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
 
 	ts = inode_get_atime(VFS_I(mp->m_rbmip));
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
2.42.0

