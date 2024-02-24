Return-Path: <linux-kernel+bounces-79752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD46E86263B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781F4283447
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EE044502E;
	Sat, 24 Feb 2024 17:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="chNLt8QL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E7A3E493;
	Sat, 24 Feb 2024 17:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708794187; cv=none; b=dncamBlwmJlIQQF6CBp57NYAPHDG6HTRbhuB82ztbmw+3X3oAROCebCkzM/Z0Jz5rcOaQRdHTkv6IJ0gOZ71/4rG4wmyzurYxlJ2Y/vUnzVe8ZmETdzlWBkgnGUzR4BiJ5SRVBm0kZbn3rvPwLGCRZShW2PZVimdmX+T/mTqgCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708794187; c=relaxed/simple;
	bh=vf1J4XGP8ttoc+eTT7vjZBCjuz6YX6OyBN3XBleaBGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rKws58EBxJVfwBgCTo4DSJ7HMyk3R9VmNx34TOW4pltle7D3sKfwovE9KWz1ZanaZ72r6a1NX0+Y6tJt/cbnFew1AQ77Bi2c4WtdiMVxTp8/IysAb1p1mxQPaom4H/K+whJ2iJCV773P2dO9gRm3HNZ61L2SsBbkN569eUuKKQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=chNLt8QL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1019BC433C7;
	Sat, 24 Feb 2024 17:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708794187;
	bh=vf1J4XGP8ttoc+eTT7vjZBCjuz6YX6OyBN3XBleaBGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=chNLt8QLPVfpWlo9KfuJvke+7y62wQSPfLUQTSAFpFedmSkflFSilLKG9Vb/ZFbh0
	 GMlZk80dHYTufgqTvTsM50eu6l5705EAqeD9nlMjM4guqzQ4LpjSkbXyKlHYeV+9Ll
	 GC7EtpmZtLu63pBmnCG2XUoubZdchLQ7cMw3x7iQ++mM9xGT3gdS8n2I03VVlvWXQI
	 5nf8zCgaetW5Tu2GhIET8lK9Ge+C6MAHVQ0jYMHtkRwqSzAQBQNQW17WlYb9/Y5h5d
	 wsCG96Z7FPjHQSfQmW2KmnfcAgKSVZxzGVo06B4FJQtJmjiK7j6yE2MAuT55OsZyaK
	 hJk/ivBH7BN5g==
Date: Sat, 24 Feb 2024 09:03:06 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: chengming.zhou@linux.dev
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
	roman.gushchin@linux.dev, Xiongwei.Song@windriver.com,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: Re: [PATCH] xfs: remove SLAB_MEM_SPREAD flag usage
Message-ID: <20240224170306.GI616564@frogsfrogsfrogs>
References: <20240224135323.830509-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224135323.830509-1-chengming.zhou@linux.dev>

On Sat, Feb 24, 2024 at 01:53:23PM +0000, chengming.zhou@linux.dev wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
> its usage so we can delete it from slab. No functional change.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Darrick J. Wong <djwong@kernel.org>

(acked, as in "this looks right, i don't know why it wasn't removed when
slab went away, and from the -mm list traffic this seems to be in line
with [1] but i still had to dig for details)

[1] https://lore.kernel.org/linux-mm/20240131172027.10f64405@gandalf.local.home/T/#u

--D

> ---
>  fs/xfs/xfs_super.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 56006b877a5d..171a1287b296 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -2042,8 +2042,7 @@ xfs_init_caches(void)
>  
>  	xfs_buf_cache = kmem_cache_create("xfs_buf", sizeof(struct xfs_buf), 0,
>  					 SLAB_HWCACHE_ALIGN |
> -					 SLAB_RECLAIM_ACCOUNT |
> -					 SLAB_MEM_SPREAD,
> +					 SLAB_RECLAIM_ACCOUNT,
>  					 NULL);
>  	if (!xfs_buf_cache)
>  		goto out;
> @@ -2108,14 +2107,14 @@ xfs_init_caches(void)
>  					   sizeof(struct xfs_inode), 0,
>  					   (SLAB_HWCACHE_ALIGN |
>  					    SLAB_RECLAIM_ACCOUNT |
> -					    SLAB_MEM_SPREAD | SLAB_ACCOUNT),
> +					    SLAB_ACCOUNT),
>  					   xfs_fs_inode_init_once);
>  	if (!xfs_inode_cache)
>  		goto out_destroy_efi_cache;
>  
>  	xfs_ili_cache = kmem_cache_create("xfs_ili",
>  					 sizeof(struct xfs_inode_log_item), 0,
> -					 SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD,
> +					 SLAB_RECLAIM_ACCOUNT,
>  					 NULL);
>  	if (!xfs_ili_cache)
>  		goto out_destroy_inode_cache;
> -- 
> 2.40.1
> 
> 

