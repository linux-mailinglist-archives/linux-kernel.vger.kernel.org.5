Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDE937FFAA8
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235222AbjK3TBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjK3TBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:01:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F065A10E2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:01:23 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1ACC433C7;
        Thu, 30 Nov 2023 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701370883;
        bh=mrQTm2/X3bNSt7Um/8oj1SlRbeIm1qp56xkDGGk6vZg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LtpRvOLbxzuM9+T7wChsLRxkoWLmlRHSuhamm/cm+uImj8aiTKd1mbpS1L6+hinSF
         +iNyCj1PClAmM/v1fVCmJGkHI3rli9TB+OtV3+FCVBYYXE9gL4zo/IQ//emX0sij+S
         K/tTriiGbay61VRch0RwgO9G3tkh6TVGhnvEXTTsaVwrM5JjK+qWj/g/JC4c1L63cb
         Zd1JifYSTxgm4n5tulghabJ0TMoO7WtOxkpfpT2m+iNx8gGiKtXI0ECmYudI4FmbBC
         XxUI9xCnBj8d0ZgZTDlpn/OXYXYXhIRUzEwbWDgxVt5IbJh8pBvdTtVtHLeavN51Wp
         tJNBPStIGf9jg==
Date:   Thu, 30 Nov 2023 11:01:20 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Cc:     Chandan Babu R <chandan.babu@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Allison Henderson <allison.henderson@oracle.com>,
        Zhang Tianci <zhangtianci.1997@bytedance.com>,
        Brian Foster <bfoster@redhat.com>, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, xieyongji@bytedance.com, me@jcix.top,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 1/3] xfs: ensure logflagsp is initialized in
 xfs_bmap_del_extent_real
Message-ID: <20231130190120.GM361584@frogsfrogsfrogs>
References: <20231130040516.35677-1-zhangjiachen.jaycee@bytedance.com>
 <20231130040516.35677-2-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130040516.35677-2-zhangjiachen.jaycee@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:05:14PM +0800, Jiachen Zhang wrote:
> In the case of returning -ENOSPC, ensure logflagsp is initialized by 0.
> Otherwise the caller __xfs_bunmapi will set uninitialized illegal
> tmp_logflags value into xfs log, which might cause unpredictable error
> in the log recovery procedure.
> 
> Also, remove the flags variable and set the *logflagsp directly, so that
> the code should be more robust in the long run.
> 
> Fixes: 1b24b633aafe ("xfs: move some more code into xfs_bmap_del_extent_real")
> Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Looks good,
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/xfs/libxfs/xfs_bmap.c | 73 +++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_bmap.c b/fs/xfs/libxfs/xfs_bmap.c
> index be62acffad6c..eacd7f43c952 100644
> --- a/fs/xfs/libxfs/xfs_bmap.c
> +++ b/fs/xfs/libxfs/xfs_bmap.c
> @@ -5010,7 +5010,6 @@ xfs_bmap_del_extent_real(
>  	xfs_fileoff_t		del_endoff;	/* first offset past del */
>  	int			do_fx;	/* free extent at end of routine */
>  	int			error;	/* error return value */
> -	int			flags = 0;/* inode logging flags */
>  	struct xfs_bmbt_irec	got;	/* current extent entry */
>  	xfs_fileoff_t		got_endoff;	/* first offset past got */
>  	int			i;	/* temp state */
> @@ -5023,6 +5022,8 @@ xfs_bmap_del_extent_real(
>  	uint32_t		state = xfs_bmap_fork_to_state(whichfork);
>  	struct xfs_bmbt_irec	old;
>  
> +	*logflagsp = 0;
> +
>  	mp = ip->i_mount;
>  	XFS_STATS_INC(mp, xs_del_exlist);
>  
> @@ -5035,7 +5036,6 @@ xfs_bmap_del_extent_real(
>  	ASSERT(got_endoff >= del_endoff);
>  	ASSERT(!isnullstartblock(got.br_startblock));
>  	qfield = 0;
> -	error = 0;
>  
>  	/*
>  	 * If it's the case where the directory code is running with no block
> @@ -5051,13 +5051,13 @@ xfs_bmap_del_extent_real(
>  	    del->br_startoff > got.br_startoff && del_endoff < got_endoff)
>  		return -ENOSPC;
>  
> -	flags = XFS_ILOG_CORE;
> +	*logflagsp = XFS_ILOG_CORE;
>  	if (whichfork == XFS_DATA_FORK && XFS_IS_REALTIME_INODE(ip)) {
>  		if (!(bflags & XFS_BMAPI_REMAP)) {
>  			error = xfs_rtfree_blocks(tp, del->br_startblock,
>  					del->br_blockcount);
>  			if (error)
> -				goto done;
> +				return error;
>  		}
>  
>  		do_fx = 0;
> @@ -5072,11 +5072,9 @@ xfs_bmap_del_extent_real(
>  	if (cur) {
>  		error = xfs_bmbt_lookup_eq(cur, &got, &i);
>  		if (error)
> -			goto done;
> -		if (XFS_IS_CORRUPT(mp, i != 1)) {
> -			error = -EFSCORRUPTED;
> -			goto done;
> -		}
> +			return error;
> +		if (XFS_IS_CORRUPT(mp, i != 1))
> +			return -EFSCORRUPTED;
>  	}
>  
>  	if (got.br_startoff == del->br_startoff)
> @@ -5093,17 +5091,15 @@ xfs_bmap_del_extent_real(
>  		xfs_iext_prev(ifp, icur);
>  		ifp->if_nextents--;
>  
> -		flags |= XFS_ILOG_CORE;
> +		*logflagsp |= XFS_ILOG_CORE;
>  		if (!cur) {
> -			flags |= xfs_ilog_fext(whichfork);
> +			*logflagsp |= xfs_ilog_fext(whichfork);
>  			break;
>  		}
>  		if ((error = xfs_btree_delete(cur, &i)))
> -			goto done;
> -		if (XFS_IS_CORRUPT(mp, i != 1)) {
> -			error = -EFSCORRUPTED;
> -			goto done;
> -		}
> +			return error;
> +		if (XFS_IS_CORRUPT(mp, i != 1))
> +			return -EFSCORRUPTED;
>  		break;
>  	case BMAP_LEFT_FILLING:
>  		/*
> @@ -5114,12 +5110,12 @@ xfs_bmap_del_extent_real(
>  		got.br_blockcount -= del->br_blockcount;
>  		xfs_iext_update_extent(ip, state, icur, &got);
>  		if (!cur) {
> -			flags |= xfs_ilog_fext(whichfork);
> +			*logflagsp |= xfs_ilog_fext(whichfork);
>  			break;
>  		}
>  		error = xfs_bmbt_update(cur, &got);
>  		if (error)
> -			goto done;
> +			return error;
>  		break;
>  	case BMAP_RIGHT_FILLING:
>  		/*
> @@ -5128,12 +5124,12 @@ xfs_bmap_del_extent_real(
>  		got.br_blockcount -= del->br_blockcount;
>  		xfs_iext_update_extent(ip, state, icur, &got);
>  		if (!cur) {
> -			flags |= xfs_ilog_fext(whichfork);
> +			*logflagsp |= xfs_ilog_fext(whichfork);
>  			break;
>  		}
>  		error = xfs_bmbt_update(cur, &got);
>  		if (error)
> -			goto done;
> +			return error;
>  		break;
>  	case 0:
>  		/*
> @@ -5150,18 +5146,18 @@ xfs_bmap_del_extent_real(
>  		new.br_state = got.br_state;
>  		new.br_startblock = del_endblock;
>  
> -		flags |= XFS_ILOG_CORE;
> +		*logflagsp |= XFS_ILOG_CORE;
>  		if (cur) {
>  			error = xfs_bmbt_update(cur, &got);
>  			if (error)
> -				goto done;
> +				return error;
>  			error = xfs_btree_increment(cur, 0, &i);
>  			if (error)
> -				goto done;
> +				return error;
>  			cur->bc_rec.b = new;
>  			error = xfs_btree_insert(cur, &i);
>  			if (error && error != -ENOSPC)
> -				goto done;
> +				return error;
>  			/*
>  			 * If get no-space back from btree insert, it tried a
>  			 * split, and we have a zero block reservation.  Fix up
> @@ -5174,33 +5170,28 @@ xfs_bmap_del_extent_real(
>  				 */
>  				error = xfs_bmbt_lookup_eq(cur, &got, &i);
>  				if (error)
> -					goto done;
> -				if (XFS_IS_CORRUPT(mp, i != 1)) {
> -					error = -EFSCORRUPTED;
> -					goto done;
> -				}
> +					return error;
> +				if (XFS_IS_CORRUPT(mp, i != 1))
> +					return -EFSCORRUPTED;
>  				/*
>  				 * Update the btree record back
>  				 * to the original value.
>  				 */
>  				error = xfs_bmbt_update(cur, &old);
>  				if (error)
> -					goto done;
> +					return error;
>  				/*
>  				 * Reset the extent record back
>  				 * to the original value.
>  				 */
>  				xfs_iext_update_extent(ip, state, icur, &old);
> -				flags = 0;
> -				error = -ENOSPC;
> -				goto done;
> -			}
> -			if (XFS_IS_CORRUPT(mp, i != 1)) {
> -				error = -EFSCORRUPTED;
> -				goto done;
> +				*logflagsp = 0;
> +				return -ENOSPC;
>  			}
> +			if (XFS_IS_CORRUPT(mp, i != 1))
> +				return -EFSCORRUPTED;
>  		} else
> -			flags |= xfs_ilog_fext(whichfork);
> +			*logflagsp |= xfs_ilog_fext(whichfork);
>  
>  		ifp->if_nextents++;
>  		xfs_iext_next(ifp, icur);
> @@ -5224,7 +5215,7 @@ xfs_bmap_del_extent_real(
>  					((bflags & XFS_BMAPI_NODISCARD) ||
>  					del->br_state == XFS_EXT_UNWRITTEN));
>  			if (error)
> -				goto done;
> +				return error;
>  		}
>  	}
>  
> @@ -5239,9 +5230,7 @@ xfs_bmap_del_extent_real(
>  	if (qfield && !(bflags & XFS_BMAPI_REMAP))
>  		xfs_trans_mod_dquot_byino(tp, ip, qfield, (long)-nblks);
>  
> -done:
> -	*logflagsp = flags;
> -	return error;
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.20.1
> 
> 
