Return-Path: <linux-kernel+bounces-25142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51CD382C86D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:37:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F02552863C8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA811F4F5;
	Sat, 13 Jan 2024 00:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PTFWM+bL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FD57F6;
	Sat, 13 Jan 2024 00:37:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8701C433F1;
	Sat, 13 Jan 2024 00:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705106235;
	bh=d5apei/ZrigJkGjSuSVsOknc4yySm4oDkZGOOB470xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PTFWM+bLMymTwsoyPjrE2k47WKBEKg/AcEbkHcX2uuIm/dhW9+8ZnS7XwREs6k1QY
	 aURvCEvOZ9X6+zL9PqDKasxE7TOEPwlGzlJmnG2h0M6ggkbFt426+dj3uEIl6BebyQ
	 IhJfCybGlA5jlhH5IMfVEtP4tEC2p0d3TELP5rq9HvVoCGbWYzNhAlhDs9VNMILIAi
	 sFOV/kUT02cAIx7Zc0pJZ7q5KJBHlFxwSa6DAlU2/QI8T6b5G0putsWfmjagtgAXwo
	 lKxfRqEVGYIutcnSG/qF9Qk7YRLaLIR/R11jsuAVHVXVhohcreEd0Bjb6zrYlysnDR
	 ccnr+PhooqSeA==
Date: Fri, 12 Jan 2024 16:37:14 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 2/3] xfs: Replace xfs_isilocked with xfs_assert_ilocked
Message-ID: <20240113003714.GA722975@frogsfrogsfrogs>
References: <20240111212424.3572189-1-willy@infradead.org>
 <20240111212424.3572189-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111212424.3572189-3-willy@infradead.org>

On Thu, Jan 11, 2024 at 09:24:23PM +0000, Matthew Wilcox (Oracle) wrote:
> To use the new rwsem_assert_held()/rwsem_assert_held_write(), we can't
> use the existing ASSERT macro.  Add a new xfs_assert_ilocked() and
> convert all the callers.
> 
> Fix an apparent bug in xfs_isilocked(): If the caller specifies
> XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL, xfs_assert_ilocked() will check both
> the IOLOCK and the ILOCK are held for write.  xfs_isilocked() only
> checked that the ILOCK was held for write.

Oh wow.  I hope you tested all this (including the quota+rt madness) and
didn't shake loose any latent locking bugs that we never noticed?

> xfs_assert_ilocked() is always on, even if DEBUG or XFS_WARN aren't
> defined.  It's a cheap check, so I don't think it's worth defining
> it away.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/xfs/libxfs/xfs_attr.c        |  2 +-
>  fs/xfs/libxfs/xfs_attr_remote.c |  2 +-
>  fs/xfs/libxfs/xfs_bmap.c        | 21 +++++-----
>  fs/xfs/libxfs/xfs_defer.c       |  2 +-
>  fs/xfs/libxfs/xfs_inode_fork.c  |  2 +-
>  fs/xfs/libxfs/xfs_rtbitmap.c    |  2 +-
>  fs/xfs/libxfs/xfs_trans_inode.c |  6 +--
>  fs/xfs/scrub/readdir.c          |  4 +-
>  fs/xfs/xfs_attr_list.c          |  2 +-
>  fs/xfs/xfs_bmap_util.c          | 10 ++---
>  fs/xfs/xfs_dir2_readdir.c       |  2 +-
>  fs/xfs/xfs_dquot.c              |  4 +-
>  fs/xfs/xfs_file.c               |  4 +-
>  fs/xfs/xfs_inode.c              | 68 ++++++++++-----------------------
>  fs/xfs/xfs_inode.h              |  2 +-
>  fs/xfs/xfs_inode_item.c         |  4 +-
>  fs/xfs/xfs_iops.c               |  3 +-
>  fs/xfs/xfs_qm.c                 | 10 ++---
>  fs/xfs/xfs_reflink.c            |  2 +-
>  fs/xfs/xfs_rtalloc.c            |  2 +-
>  fs/xfs/xfs_symlink.c            |  2 +-
>  fs/xfs/xfs_trans.c              |  2 +-
>  fs/xfs/xfs_trans_dquot.c        |  2 +-
>  23 files changed, 65 insertions(+), 95 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr.c b/fs/xfs/libxfs/xfs_attr.c
> index 9976a00a73f9..7eb00f25865a 100644
> --- a/fs/xfs/libxfs/xfs_attr.c
> +++ b/fs/xfs/libxfs/xfs_attr.c
> @@ -224,7 +224,7 @@ int
>  xfs_attr_get_ilocked(
>  	struct xfs_da_args	*args)
>  {
> -	ASSERT(xfs_isilocked(args->dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(args->dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
>  
>  	if (!xfs_inode_hasattr(args->dp))
>  		return -ENOATTR;
> diff --git a/fs/xfs/libxfs/xfs_attr_remote.c b/fs/xfs/libxfs/xfs_attr_remote.c
> index d440393b40eb..1c007ebf153a 100644
> --- a/fs/xfs/libxfs/xfs_attr_remote.c
> +++ b/fs/xfs/libxfs/xfs_attr_remote.c
> @@ -545,7 +545,7 @@ xfs_attr_rmtval_stale(
>  	struct xfs_buf		*bp;
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	if (XFS_IS_CORRUPT(mp, map->br_startblock == DELAYSTARTBLOCK) ||
>  	    XFS_IS_CORRUPT(mp, map->br_startblock == HOLESTARTBLOCK))
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index 98aaca933bdd..6774a3b0027f 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -1189,7 +1189,7 @@ xfs_iread_extents(
>  	if (!xfs_need_iread_extents(ifp))
>  		return 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	ir.loaded = 0;
>  	xfs_iext_first(ifp, &ir.icur);
> @@ -3898,7 +3898,7 @@ xfs_bmapi_read(
>  
>  	ASSERT(*nmap >= 1);
>  	ASSERT(!(flags & ~(XFS_BMAPI_ATTRFORK | XFS_BMAPI_ENTIRE)));
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_SHARED|XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_SHARED|XFS_ILOCK_EXCL);

Nit: consistency of inserting (or not) spaces  ^ around the logical or
operator.

>  
>  	if (WARN_ON_ONCE(!ifp))
>  		return -EFSCORRUPTED;
> @@ -4369,7 +4369,7 @@ xfs_bmapi_write(
>  	ASSERT(tp != NULL);
>  	ASSERT(len > 0);
>  	ASSERT(ifp->if_format != XFS_DINODE_FMT_LOCAL);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(!(flags & XFS_BMAPI_REMAP));
>  
>  	/* zeroing is for currently only for data extents, not metadata */
> @@ -4666,7 +4666,7 @@ xfs_bmapi_remap(
>  	ifp = xfs_ifork_ptr(ip, whichfork);
>  	ASSERT(len > 0);
>  	ASSERT(len <= (xfs_filblks_t)XFS_MAX_BMBT_EXTLEN);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(!(flags & ~(XFS_BMAPI_ATTRFORK | XFS_BMAPI_PREALLOC |
>  			   XFS_BMAPI_NORMAP)));
>  	ASSERT((flags & (XFS_BMAPI_ATTRFORK | XFS_BMAPI_PREALLOC)) !=
> @@ -5291,7 +5291,7 @@ __xfs_bunmapi(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(len > 0);
>  	ASSERT(nexts >= 0);
>  
> @@ -5635,8 +5635,7 @@ xfs_bmse_merge(
>  
>  	blockcount = left->br_blockcount + got->br_blockcount;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
>  	ASSERT(xfs_bmse_can_merge(left, got, shift));
>  
>  	new = *left;
> @@ -5764,7 +5763,7 @@ xfs_bmap_collapse_extents(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
>  
>  	error = xfs_iread_extents(tp, ip, whichfork);
>  	if (error)
> @@ -5837,7 +5836,7 @@ xfs_bmap_can_insert_extents(
>  	int			is_empty;
>  	int			error = 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>  
>  	if (xfs_is_shutdown(ip->i_mount))
>  		return -EIO;
> @@ -5879,7 +5878,7 @@ xfs_bmap_insert_extents(
>  	if (xfs_is_shutdown(mp))
>  		return -EIO;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_ILOCK_EXCL);
>  
>  	error = xfs_iread_extents(tp, ip, whichfork);
>  	if (error)
> @@ -6257,7 +6256,7 @@ xfs_bunmapi_range(
>  	xfs_filblks_t		unmap_len = endoff - startoff + 1;
>  	int			error = 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	while (unmap_len > 0) {
>  		ASSERT((*tpp)->t_highest_agno == NULLAGNUMBER);
> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
> index 66a17910d021..5b955f0c1742 100644
> --- a/fs/xfs/libxfs/xfs_defer.c
> +++ b/fs/xfs/libxfs/xfs_defer.c
> @@ -1011,7 +1011,7 @@ xfs_defer_ops_capture(
>  	 * transaction.
>  	 */
>  	for (i = 0; i < dfc->dfc_held.dr_inos; i++) {
> -		ASSERT(xfs_isilocked(dfc->dfc_held.dr_ip[i], XFS_ILOCK_EXCL));
> +		xfs_assert_ilocked(dfc->dfc_held.dr_ip[i], XFS_ILOCK_EXCL);
>  		ihold(VFS_I(dfc->dfc_held.dr_ip[i]));
>  	}
>  
> diff --git a/fs/xfs/libxfs/xfs_inode_fork.c b/fs/xfs/libxfs/xfs_inode_fork.c
> index f4569e18a8d0..01e89d9fa6b5 100644
> --- a/fs/xfs/libxfs/xfs_inode_fork.c
> +++ b/fs/xfs/libxfs/xfs_inode_fork.c
> @@ -562,7 +562,7 @@ xfs_iextents_copy(
>  	struct xfs_bmbt_irec	rec;
>  	int64_t			copied = 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED);
>  	ASSERT(ifp->if_bytes > 0);
>  
>  	for_each_xfs_iext(ifp, &icur, &rec) {
> diff --git a/fs/xfs/libxfs/xfs_rtbitmap.c b/fs/xfs/libxfs/xfs_rtbitmap.c
> index 31100120b2c5..809a67ae625b 100644
> --- a/fs/xfs/libxfs/xfs_rtbitmap.c
> +++ b/fs/xfs/libxfs/xfs_rtbitmap.c
> @@ -934,7 +934,7 @@ xfs_rtfree_extent(
>  	struct timespec64	atime;
>  
>  	ASSERT(mp->m_rbmip->i_itemp != NULL);
> -	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
>  
>  	error = xfs_rtcheck_alloc_range(&args, start, len);
>  	if (error)
> diff --git a/fs/xfs/libxfs/xfs_trans_inode.c b/fs/xfs/libxfs/xfs_trans_inode.c
> index 70e97ea6eee7..69fc5b981352 100644
> --- a/fs/xfs/libxfs/xfs_trans_inode.c
> +++ b/fs/xfs/libxfs/xfs_trans_inode.c
> @@ -31,7 +31,7 @@ xfs_trans_ijoin(
>  {
>  	struct xfs_inode_log_item *iip;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	if (ip->i_itemp == NULL)
>  		xfs_inode_item_init(ip, ip->i_mount);
>  	iip = ip->i_itemp;
> @@ -60,7 +60,7 @@ xfs_trans_ichgtime(
>  	struct timespec64	tv;
>  
>  	ASSERT(tp);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	tv = current_time(inode);
>  
> @@ -90,7 +90,7 @@ xfs_trans_log_inode(
>  	struct inode		*inode = VFS_I(ip);
>  
>  	ASSERT(iip);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(!xfs_iflags_test(ip, XFS_ISTALE));
>  
>  	tp->t_flags |= XFS_TRANS_DIRTY;
> diff --git a/fs/xfs/scrub/readdir.c b/fs/xfs/scrub/readdir.c
> index 16462332c897..dfdcb96b6c16 100644
> --- a/fs/xfs/scrub/readdir.c
> +++ b/fs/xfs/scrub/readdir.c
> @@ -281,7 +281,7 @@ xchk_dir_walk(
>  		return -EIO;
>  
>  	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
> -	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
>  
>  	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL)
>  		return xchk_dir_walk_sf(sc, dp, dirent_fn, priv);
> @@ -332,7 +332,7 @@ xchk_dir_lookup(
>  		return -EIO;
>  
>  	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
> -	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
>  
>  	if (dp->i_df.if_format == XFS_DINODE_FMT_LOCAL) {
>  		error = xfs_dir2_sf_lookup(&args);
> diff --git a/fs/xfs/xfs_attr_list.c b/fs/xfs/xfs_attr_list.c
> index e368ad671e26..c23b79e71252 100644
> --- a/fs/xfs/xfs_attr_list.c
> +++ b/fs/xfs/xfs_attr_list.c
> @@ -504,7 +504,7 @@ xfs_attr_list_ilocked(
>  {
>  	struct xfs_inode		*dp = context->dp;
>  
> -	ASSERT(xfs_isilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(dp, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
>  
>  	/*
>  	 * Decide on what work routines to call based on the inode size.
> diff --git a/fs/xfs/xfs_bmap_util.c b/fs/xfs/xfs_bmap_util.c
> index c2531c28905c..4a31c5aa42fc 100644
> --- a/fs/xfs/xfs_bmap_util.c
> +++ b/fs/xfs/xfs_bmap_util.c
> @@ -508,8 +508,8 @@ xfs_can_free_eofblocks(
>  	 * Caller must either hold the exclusive io lock; or be inactivating
>  	 * the inode, which guarantees there are no other users of the inode.
>  	 */
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL) ||
> -	       (VFS_I(ip)->i_state & I_FREEING));
> +	if (!(VFS_I(ip)->i_state & I_FREEING))
> +		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>  
>  	/* prealloc/delalloc exists only on regular files */
>  	if (!S_ISREG(VFS_I(ip)->i_mode))
> @@ -965,8 +965,7 @@ xfs_collapse_file_space(
>  	xfs_fileoff_t		shift_fsb = XFS_B_TO_FSB(mp, len);
>  	bool			done = false;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> -	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>  
>  	trace_xfs_collapse_file_space(ip);
>  
> @@ -1035,8 +1034,7 @@ xfs_insert_file_space(
>  	xfs_fileoff_t		shift_fsb = XFS_B_TO_FSB(mp, len);
>  	bool			done = false;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> -	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>  
>  	trace_xfs_insert_file_space(ip);
>  
> diff --git a/fs/xfs/xfs_dir2_readdir.c b/fs/xfs/xfs_dir2_readdir.c
> index cc6dc56f455d..e82dd5d65cde 100644
> --- a/fs/xfs/xfs_dir2_readdir.c
> +++ b/fs/xfs/xfs_dir2_readdir.c
> @@ -522,7 +522,7 @@ xfs_readdir(
>  		return -EIO;
>  
>  	ASSERT(S_ISDIR(VFS_I(dp)->i_mode));
> -	ASSERT(xfs_isilocked(dp, XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL));
> +	xfs_assert_ilocked(dp, XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
>  	XFS_STATS_INC(dp->i_mount, xs_dir_getdents);
>  
>  	args.dp = dp;
> diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
> index b4f20d9c8f98..138f8774b1ea 100644
> --- a/fs/xfs/xfs_dquot.c
> +++ b/fs/xfs/xfs_dquot.c
> @@ -950,7 +950,7 @@ xfs_qm_dqget_inode(
>  	if (error)
>  		return error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(xfs_inode_dquot(ip, type) == NULL);
>  
>  	id = xfs_qm_id_for_quotatype(ip, type);
> @@ -1007,7 +1007,7 @@ xfs_qm_dqget_inode(
>  	}
>  
>  dqret:
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	trace_xfs_dqget_miss(dqp);
>  	*O_dqpp = dqp;
>  	return 0;
> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
> index e33e5e13b95f..632653e00906 100644
> --- a/fs/xfs/xfs_file.c
> +++ b/fs/xfs/xfs_file.c
> @@ -879,7 +879,7 @@ xfs_break_dax_layouts(
>  {
>  	struct page		*page;
>  
> -	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
> +	xfs_assert_ilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL);
>  
>  	page = dax_layout_busy_page(inode->i_mapping);
>  	if (!page)
> @@ -900,7 +900,7 @@ xfs_break_layouts(
>  	bool			retry;
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(XFS_I(inode), XFS_IOLOCK_SHARED|XFS_IOLOCK_EXCL));
> +	xfs_assert_ilocked(XFS_I(inode), XFS_IOLOCK_SHARED | XFS_IOLOCK_EXCL);
>  
>  	do {
>  		retry = false;
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 1fd94958aa97..728b3bc1c3db 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -328,52 +328,26 @@ xfs_ilock_demote(
>  	trace_xfs_ilock_demote(ip, lock_flags, _RET_IP_);
>  }
>  
> -#if defined(DEBUG) || defined(XFS_WARN)
> -static inline bool
> -__xfs_rwsem_islocked(
> -	struct rw_semaphore	*rwsem,
> -	bool			shared)
> -{
> -	if (!debug_locks)
> -		return rwsem_is_locked(rwsem);
> -
> -	if (!shared)
> -		return lockdep_is_held_type(rwsem, 0);
> -
> -	/*
> -	 * We are checking that the lock is held at least in shared
> -	 * mode but don't care that it might be held exclusively
> -	 * (i.e. shared | excl). Hence we check if the lock is held
> -	 * in any mode rather than an explicit shared mode.
> -	 */
> -	return lockdep_is_held_type(rwsem, -1);
> -}
> -
> -bool
> -xfs_isilocked(
> +void
> +xfs_assert_ilocked(
>  	struct xfs_inode	*ip,
>  	uint			lock_flags)
>  {
> -	if (lock_flags & (XFS_ILOCK_EXCL|XFS_ILOCK_SHARED)) {
> -		if (!(lock_flags & XFS_ILOCK_SHARED))
> -			return !!ip->i_lock.mr_writer;
> -		return rwsem_is_locked(&ip->i_lock.mr_lock);
> -	}
> +	if (lock_flags & XFS_ILOCK_SHARED)
> +		rwsem_assert_held(&ip->i_lock.mr_lock);
> +	else if (lock_flags & XFS_ILOCK_EXCL)
> +		ASSERT(ip->i_lock.mr_writer);
>  
> -	if (lock_flags & (XFS_MMAPLOCK_EXCL|XFS_MMAPLOCK_SHARED)) {
> -		return __xfs_rwsem_islocked(&VFS_I(ip)->i_mapping->invalidate_lock,
> -				(lock_flags & XFS_MMAPLOCK_SHARED));
> -	}
> +	if (lock_flags & XFS_MMAPLOCK_SHARED)
> +		rwsem_assert_held(&VFS_I(ip)->i_mapping->invalidate_lock);
> +	else if (lock_flags & XFS_MMAPLOCK_EXCL)
> +		rwsem_assert_held_write(&VFS_I(ip)->i_mapping->invalidate_lock);
>  
> -	if (lock_flags & (XFS_IOLOCK_EXCL | XFS_IOLOCK_SHARED)) {
> -		return __xfs_rwsem_islocked(&VFS_I(ip)->i_rwsem,
> -				(lock_flags & XFS_IOLOCK_SHARED));
> -	}
> -
> -	ASSERT(0);
> -	return false;
> +	if (lock_flags & XFS_IOLOCK_SHARED)
> +		rwsem_assert_held(&VFS_I(ip)->i_rwsem);
> +	else if (lock_flags & XFS_IOLOCK_EXCL)
> +		rwsem_assert_held_write(&VFS_I(ip)->i_rwsem);
>  }
> -#endif
>  
>  /*
>   * xfs_lockdep_subclass_ok() is only used in an ASSERT, so is only called when
> @@ -1342,9 +1316,9 @@ xfs_itruncate_extents_flags(
>  	xfs_fileoff_t		first_unmap_block;
>  	int			error = 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> -	ASSERT(!atomic_read(&VFS_I(ip)->i_count) ||
> -	       xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
> +	if (atomic_read(&VFS_I(ip)->i_count))
> +		xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL);
>  	ASSERT(new_size <= XFS_ISIZE(ip));
>  	ASSERT(tp->t_flags & XFS_TRANS_PERM_LOG_RES);
>  	ASSERT(ip->i_itemp != NULL);
> @@ -1596,7 +1570,7 @@ xfs_inactive_ifree(
>  	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
>  
>  	error = xfs_ifree(tp, ip);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	if (error) {
>  		/*
>  		 * If we fail to free the inode, shut down.  The cancel
> @@ -2350,7 +2324,7 @@ xfs_ifree(
>  	struct xfs_inode_log_item *iip = ip->i_itemp;
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(VFS_I(ip)->i_nlink == 0);
>  	ASSERT(ip->i_df.if_nextents == 0);
>  	ASSERT(ip->i_disk_size == 0 || !S_ISREG(VFS_I(ip)->i_mode));
> @@ -2419,7 +2393,7 @@ static void
>  xfs_iunpin(
>  	struct xfs_inode	*ip)
>  {
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL | XFS_ILOCK_SHARED);
>  
>  	trace_xfs_inode_unpin_nowait(ip, _RET_IP_);
>  
> @@ -3182,7 +3156,7 @@ xfs_iflush(
>  	struct xfs_mount	*mp = ip->i_mount;
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL|XFS_ILOCK_SHARED);
>  	ASSERT(xfs_iflags_test(ip, XFS_IFLUSHING));
>  	ASSERT(ip->i_df.if_format != XFS_DINODE_FMT_BTREE ||
>  	       ip->i_df.if_nextents > XFS_IFORK_MAXEXT(ip, XFS_DATA_FORK));
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index 97f63bacd4c2..dcc818901a79 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -523,7 +523,7 @@ void		xfs_ilock(xfs_inode_t *, uint);
>  int		xfs_ilock_nowait(xfs_inode_t *, uint);
>  void		xfs_iunlock(xfs_inode_t *, uint);
>  void		xfs_ilock_demote(xfs_inode_t *, uint);
> -bool		xfs_isilocked(struct xfs_inode *, uint);
> +void		xfs_assert_ilocked(struct xfs_inode *, uint);
>  uint		xfs_ilock_data_map_shared(struct xfs_inode *);
>  uint		xfs_ilock_attr_map_shared(struct xfs_inode *);
>  
> diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
> index 0aee97ba0be8..ce37e12d951e 100644
> --- a/fs/xfs/xfs_inode_item.c
> +++ b/fs/xfs/xfs_inode_item.c
> @@ -650,7 +650,7 @@ xfs_inode_item_pin(
>  {
>  	struct xfs_inode	*ip = INODE_ITEM(lip)->ili_inode;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(lip->li_buf);
>  
>  	trace_xfs_inode_pin(ip, _RET_IP_);
> @@ -756,7 +756,7 @@ xfs_inode_item_release(
>  	unsigned short		lock_flags;
>  
>  	ASSERT(ip->i_itemp != NULL);
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	lock_flags = iip->ili_lock_flags;
>  	iip->ili_lock_flags = 0;
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index a0d77f5f512e..e7fca1913175 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -796,8 +796,7 @@ xfs_setattr_size(
>  	uint			lock_flags = 0;
>  	bool			did_zeroing = false;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_IOLOCK_EXCL));
> -	ASSERT(xfs_isilocked(ip, XFS_MMAPLOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_IOLOCK_EXCL | XFS_MMAPLOCK_EXCL);
>  	ASSERT(S_ISREG(inode->i_mode));
>  	ASSERT((iattr->ia_valid & (ATTR_UID|ATTR_GID|ATTR_ATIME|ATTR_ATIME_SET|
>  		ATTR_MTIME_SET|ATTR_TIMES_SET)) == 0);
> diff --git a/fs/xfs/xfs_qm.c b/fs/xfs/xfs_qm.c
> index 67d0a8564ff3..fc451d3b1199 100644
> --- a/fs/xfs/xfs_qm.c
> +++ b/fs/xfs/xfs_qm.c
> @@ -254,7 +254,7 @@ xfs_qm_dqattach_one(
>  	struct xfs_dquot	*dqp;
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	error = 0;
>  
>  	/*
> @@ -322,7 +322,7 @@ xfs_qm_dqattach_locked(
>  	if (!xfs_qm_need_dqattach(ip))
>  		return 0;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	if (XFS_IS_UQUOTA_ON(mp) && !ip->i_udquot) {
>  		error = xfs_qm_dqattach_one(ip, XFS_DQTYPE_USER,
> @@ -353,7 +353,7 @@ xfs_qm_dqattach_locked(
>  	 * Don't worry about the dquots that we may have attached before any
>  	 * error - they'll get detached later if it has not already been done.
>  	 */
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	return error;
>  }
>  
> @@ -1809,7 +1809,7 @@ xfs_qm_vop_chown(
>  				 XFS_TRANS_DQ_RTBCOUNT : XFS_TRANS_DQ_BCOUNT;
>  
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	ASSERT(XFS_IS_QUOTA_ON(ip->i_mount));
>  
>  	/* old dquot */
> @@ -1897,7 +1897,7 @@ xfs_qm_vop_create_dqattach(
>  	if (!XFS_IS_QUOTA_ON(mp))
>  		return;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	if (udqp && XFS_IS_UQUOTA_ON(mp)) {
>  		ASSERT(ip->i_udquot == NULL);
> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
> index d5ca8bcae65b..e64ef2a293b6 100644
> --- a/fs/xfs/xfs_reflink.c
> +++ b/fs/xfs/xfs_reflink.c
> @@ -527,7 +527,7 @@ xfs_reflink_allocate_cow(
>  	int			error;
>  	bool			found;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  	if (!ip->i_cowfp) {
>  		ASSERT(!xfs_is_reflink_inode(ip));
>  		xfs_ifork_init_cow(ip);
> diff --git a/fs/xfs/xfs_rtalloc.c b/fs/xfs/xfs_rtalloc.c
> index 8649d981a097..67337f00006f 100644
> --- a/fs/xfs/xfs_rtalloc.c
> +++ b/fs/xfs/xfs_rtalloc.c
> @@ -1260,7 +1260,7 @@ xfs_rtpick_extent(
>  	uint64_t		seq;		/* sequence number of file creation */
>  	struct timespec64	ts;		/* timespec in inode */
>  
> -	ASSERT(xfs_isilocked(mp->m_rbmip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(mp->m_rbmip, XFS_ILOCK_EXCL);
>  
>  	ts = inode_get_atime(VFS_I(mp->m_rbmip));
>  	if (!(mp->m_rbmip->i_diflags & XFS_DIFLAG_NEWRTBM)) {
> diff --git a/fs/xfs/xfs_symlink.c b/fs/xfs/xfs_symlink.c
> index 92974a4414c8..c2dc8c501bdc 100644
> --- a/fs/xfs/xfs_symlink.c
> +++ b/fs/xfs/xfs_symlink.c
> @@ -44,7 +44,7 @@ xfs_readlink_bmap_ilocked(
>  	int			fsblocks = 0;
>  	int			offset;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_SHARED | XFS_ILOCK_EXCL);
>  
>  	fsblocks = xfs_symlink_blocks(mp, pathlen);
>  	error = xfs_bmapi_read(ip, 0, fsblocks, mval, &nmaps, 0);
> diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
> index 12d45e93f07d..7350640059cc 100644
> --- a/fs/xfs/xfs_trans.c
> +++ b/fs/xfs/xfs_trans.c
> @@ -1273,7 +1273,7 @@ xfs_trans_reserve_more_inode(
>  	unsigned int		rtx = xfs_extlen_to_rtxlen(mp, rblocks);
>  	int			error;
>  
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
>  
>  	error = xfs_trans_reserve(tp, &resv, dblocks, rtx);
>  	if (error)
> diff --git a/fs/xfs/xfs_trans_dquot.c b/fs/xfs/xfs_trans_dquot.c
> index aa00cf67ad72..9c159d016ecf 100644
> --- a/fs/xfs/xfs_trans_dquot.c
> +++ b/fs/xfs/xfs_trans_dquot.c
> @@ -796,7 +796,7 @@ xfs_trans_reserve_quota_nblks(
>  		return 0;
>  
>  	ASSERT(!xfs_is_quota_inode(&mp->m_sb, ip->i_ino));
> -	ASSERT(xfs_isilocked(ip, XFS_ILOCK_EXCL));
> +	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);

With the nit fixed, I think this is finally good to go.  Though it's
going to be interesting dealing with the merge conflicts that will be
the cost of improved ilocking assertions.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  	if (force)
>  		qflags |= XFS_QMOPT_FORCE_RES;
> -- 
> 2.43.0
> 
> 

