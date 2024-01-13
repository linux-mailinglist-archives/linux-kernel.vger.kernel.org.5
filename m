Return-Path: <linux-kernel+bounces-25138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A0E82C85C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:31:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 882E82863BD
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBB819456;
	Sat, 13 Jan 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XDS7Oz0F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8368E17739;
	Sat, 13 Jan 2024 00:29:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0944C433F1;
	Sat, 13 Jan 2024 00:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705105770;
	bh=JAvwWUtmXl0VoUe1t4B4U2Vs7n3vjhfaIM/dqJeCdDE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XDS7Oz0Fyk20HkbbwDerLmzg8UgsATURp3iWM43OMggELC2/csRYvv4KnaYtLX519
	 gPXFQwhN+vqof1Vi2PlLqNpLuDg5MbQMh6qFrjC2Z07SsZplsxiWMi1Dwpp5Fbscko
	 x2oo5XK45aZLphzrD0w5i9J+VrsOVovN4UhWNDZHIYzDty1CbmJaZ6g3GsIygAfBU9
	 yDvL4aoFLXWL1hsUIL0nhnnJDlH03eSVDYT8C5oMYiH6ZvizoWPdLU1WN+Y5qGuXu2
	 9d72/K+vv3DJV/m2de8e00PFXbub6IzPMKd8F4RyDKXnQ187984ueSxszvDMSFwW9J
	 FgkP/Dsk3CtlQ==
Date: Fri, 12 Jan 2024 16:29:30 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Chandan Babu R <chandan.babu@oracle.com>, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v5 3/3] xfs: Remove mrlock wrapper
Message-ID: <20240113002930.GZ722975@frogsfrogsfrogs>
References: <20240111212424.3572189-1-willy@infradead.org>
 <20240111212424.3572189-4-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111212424.3572189-4-willy@infradead.org>

On Thu, Jan 11, 2024 at 09:24:24PM +0000, Matthew Wilcox (Oracle) wrote:
> mrlock was an rwsem wrapper that also recorded whether the lock was
> held for read or write.  Now that we can ask the generic code whether
> the lock is held for read or write, we can remove this wrapper and use
> an rwsem directly.
> 
> As the comment says, we can't use lockdep to assert that the ILOCK is
> held for write, because we might be in a workqueue, and we aren't able
> to tell lockdep that we do in fact own the lock.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/xfs/mrlock.h    | 78 ----------------------------------------------
>  fs/xfs/xfs_inode.c | 22 +++++++------
>  fs/xfs/xfs_inode.h |  2 +-
>  fs/xfs/xfs_iops.c  |  4 +--
>  fs/xfs/xfs_linux.h |  2 +-
>  fs/xfs/xfs_super.c |  4 +--
>  6 files changed, 18 insertions(+), 94 deletions(-)
>  delete mode 100644 fs/xfs/mrlock.h
> 
> diff --git a/fs/xfs/mrlock.h b/fs/xfs/mrlock.h
> deleted file mode 100644
> index 79155eec341b..000000000000
> --- a/fs/xfs/mrlock.h
> +++ /dev/null
> @@ -1,78 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0
> -/*
> - * Copyright (c) 2000-2006 Silicon Graphics, Inc.
> - * All Rights Reserved.
> - */
> -#ifndef __XFS_SUPPORT_MRLOCK_H__
> -#define __XFS_SUPPORT_MRLOCK_H__
> -
> -#include <linux/rwsem.h>
> -
> -typedef struct {
> -	struct rw_semaphore	mr_lock;
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	int			mr_writer;
> -#endif
> -} mrlock_t;
> -
> -#if defined(DEBUG) || defined(XFS_WARN)
> -#define mrinit(mrp, name)	\
> -	do { (mrp)->mr_writer = 0; init_rwsem(&(mrp)->mr_lock); } while (0)
> -#else
> -#define mrinit(mrp, name)	\
> -	do { init_rwsem(&(mrp)->mr_lock); } while (0)
> -#endif
> -
> -#define mrlock_init(mrp, t,n,s)	mrinit(mrp, n)
> -#define mrfree(mrp)		do { } while (0)
> -
> -static inline void mraccess_nested(mrlock_t *mrp, int subclass)
> -{
> -	down_read_nested(&mrp->mr_lock, subclass);
> -}
> -
> -static inline void mrupdate_nested(mrlock_t *mrp, int subclass)
> -{
> -	down_write_nested(&mrp->mr_lock, subclass);
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 1;
> -#endif
> -}
> -
> -static inline int mrtryaccess(mrlock_t *mrp)
> -{
> -	return down_read_trylock(&mrp->mr_lock);
> -}
> -
> -static inline int mrtryupdate(mrlock_t *mrp)
> -{
> -	if (!down_write_trylock(&mrp->mr_lock))
> -		return 0;
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 1;
> -#endif
> -	return 1;
> -}
> -
> -static inline void mrunlock_excl(mrlock_t *mrp)
> -{
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 0;
> -#endif
> -	up_write(&mrp->mr_lock);
> -}
> -
> -static inline void mrunlock_shared(mrlock_t *mrp)
> -{
> -	up_read(&mrp->mr_lock);
> -}
> -
> -static inline void mrdemote(mrlock_t *mrp)
> -{
> -#if defined(DEBUG) || defined(XFS_WARN)
> -	mrp->mr_writer = 0;
> -#endif
> -	downgrade_write(&mrp->mr_lock);
> -}
> -
> -#endif /* __XFS_SUPPORT_MRLOCK_H__ */
> diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
> index 728b3bc1c3db..b9b2af913e89 100644
> --- a/fs/xfs/xfs_inode.c
> +++ b/fs/xfs/xfs_inode.c
> @@ -203,9 +203,9 @@ xfs_ilock(
>  	}
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
> -		mrupdate_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
> +		down_write_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
>  	else if (lock_flags & XFS_ILOCK_SHARED)
> -		mraccess_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
> +		down_read_nested(&ip->i_lock, XFS_ILOCK_DEP(lock_flags));
>  }
>  
>  /*
> @@ -246,10 +246,10 @@ xfs_ilock_nowait(
>  	}
>  
>  	if (lock_flags & XFS_ILOCK_EXCL) {
> -		if (!mrtryupdate(&ip->i_lock))
> +		if (!down_write_trylock(&ip->i_lock))
>  			goto out_undo_mmaplock;
>  	} else if (lock_flags & XFS_ILOCK_SHARED) {
> -		if (!mrtryaccess(&ip->i_lock))
> +		if (!down_read_trylock(&ip->i_lock))
>  			goto out_undo_mmaplock;
>  	}
>  	return 1;
> @@ -298,9 +298,9 @@ xfs_iunlock(
>  		up_read(&VFS_I(ip)->i_mapping->invalidate_lock);
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
> -		mrunlock_excl(&ip->i_lock);
> +		up_write(&ip->i_lock);
>  	else if (lock_flags & XFS_ILOCK_SHARED)
> -		mrunlock_shared(&ip->i_lock);
> +		up_read(&ip->i_lock);
>  
>  	trace_xfs_iunlock(ip, lock_flags, _RET_IP_);
>  }
> @@ -319,7 +319,7 @@ xfs_ilock_demote(
>  		~(XFS_IOLOCK_EXCL|XFS_MMAPLOCK_EXCL|XFS_ILOCK_EXCL)) == 0);
>  
>  	if (lock_flags & XFS_ILOCK_EXCL)
> -		mrdemote(&ip->i_lock);
> +		downgrade_write(&ip->i_lock);
>  	if (lock_flags & XFS_MMAPLOCK_EXCL)
>  		downgrade_write(&VFS_I(ip)->i_mapping->invalidate_lock);
>  	if (lock_flags & XFS_IOLOCK_EXCL)
> @@ -333,10 +333,14 @@ xfs_assert_ilocked(
>  	struct xfs_inode	*ip,
>  	uint			lock_flags)
>  {
> +	/*
> +	 * Sometimes we assert the ILOCK is held exclusively, but we're in
> +	 * a workqueue, so lockdep doesn't know we're the owner.
> +	 */
>  	if (lock_flags & XFS_ILOCK_SHARED)
> -		rwsem_assert_held(&ip->i_lock.mr_lock);
> +		rwsem_assert_held(&ip->i_lock);
>  	else if (lock_flags & XFS_ILOCK_EXCL)
> -		ASSERT(ip->i_lock.mr_writer);
> +		rwsem_assert_held_write_nolockdep(&ip->i_lock);

Hooray, someone finally broke the gordian knot!
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

>  
>  	if (lock_flags & XFS_MMAPLOCK_SHARED)
>  		rwsem_assert_held(&VFS_I(ip)->i_mapping->invalidate_lock);
> diff --git a/fs/xfs/xfs_inode.h b/fs/xfs/xfs_inode.h
> index dcc818901a79..796d11065fe2 100644
> --- a/fs/xfs/xfs_inode.h
> +++ b/fs/xfs/xfs_inode.h
> @@ -39,7 +39,7 @@ typedef struct xfs_inode {
>  
>  	/* Transaction and locking information. */
>  	struct xfs_inode_log_item *i_itemp;	/* logging information */
> -	mrlock_t		i_lock;		/* inode lock */
> +	struct rw_semaphore	i_lock;		/* inode lock */
>  	atomic_t		i_pincount;	/* inode pin count */
>  	struct llist_node	i_gclist;	/* deferred inactivation list */
>  
> diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
> index e7fca1913175..73f46486c252 100644
> --- a/fs/xfs/xfs_iops.c
> +++ b/fs/xfs/xfs_iops.c
> @@ -1284,9 +1284,9 @@ xfs_setup_inode(
>  		 */
>  		lockdep_set_class(&inode->i_rwsem,
>  				  &inode->i_sb->s_type->i_mutex_dir_key);
> -		lockdep_set_class(&ip->i_lock.mr_lock, &xfs_dir_ilock_class);
> +		lockdep_set_class(&ip->i_lock, &xfs_dir_ilock_class);
>  	} else {
> -		lockdep_set_class(&ip->i_lock.mr_lock, &xfs_nondir_ilock_class);
> +		lockdep_set_class(&ip->i_lock, &xfs_nondir_ilock_class);
>  	}
>  
>  	/*
> diff --git a/fs/xfs/xfs_linux.h b/fs/xfs/xfs_linux.h
> index d7873e0360f0..ec3c6c138a63 100644
> --- a/fs/xfs/xfs_linux.h
> +++ b/fs/xfs/xfs_linux.h
> @@ -22,7 +22,6 @@ typedef __u32			xfs_nlink_t;
>  #include "xfs_types.h"
>  
>  #include "kmem.h"
> -#include "mrlock.h"
>  
>  #include <linux/semaphore.h>
>  #include <linux/mm.h>
> @@ -51,6 +50,7 @@ typedef __u32			xfs_nlink_t;
>  #include <linux/notifier.h>
>  #include <linux/delay.h>
>  #include <linux/log2.h>
> +#include <linux/rwsem.h>
>  #include <linux/spinlock.h>
>  #include <linux/random.h>
>  #include <linux/ctype.h>
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index aff20ddd4a9f..15831c53a83b 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -716,9 +716,7 @@ xfs_fs_inode_init_once(
>  	/* xfs inode */
>  	atomic_set(&ip->i_pincount, 0);
>  	spin_lock_init(&ip->i_flags_lock);
> -
> -	mrlock_init(&ip->i_lock, MRLOCK_ALLOW_EQUAL_PRI|MRLOCK_BARRIER,
> -		     "xfsino", ip->i_ino);
> +	init_rwsem(&ip->i_lock);
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 

