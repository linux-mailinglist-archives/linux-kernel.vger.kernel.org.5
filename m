Return-Path: <linux-kernel+bounces-160770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F048B42A2
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 01:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6A761F2389C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 23:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8E3BBC5;
	Fri, 26 Apr 2024 23:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmsMwz++"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D15039856;
	Fri, 26 Apr 2024 23:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173517; cv=none; b=pJiuHc7wPhfw/j6ESYEkGE8MedNRWcAyY96tAP0+pZydccWkLRJV4OqHWaoXxuuBE6MCKT1tpaG81kbalVSA/NkD0j0AF1WoTPhBB4GhCJ8nvV/+9YFKSFV3hQ9xjLdXO8LA1aix6II2zn2KkoPrOyYP4YNrtnlD2lziPWvGcyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173517; c=relaxed/simple;
	bh=vrGl3Ue2LyKd1ylUM8fMvh7FXSTGNUUpUoPx/7U/X88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bstQvjeivd7Uavi6+bFQa9PK0Zn7ejY07AhTL6c6SA5f4nY2LaGgxrWZ2jnuW8BRbRS1iP+UBckMfgZ7nEPiU5rBWcvInAmkWujIbxI1QWYPjUZTRzD6uaSk8mKCfvrzPsuF/SEQ8ZmeYy43jfkZs8GKSfUT21w8t2tRRyGQgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmsMwz++; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC16C113CD;
	Fri, 26 Apr 2024 23:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714173517;
	bh=vrGl3Ue2LyKd1ylUM8fMvh7FXSTGNUUpUoPx/7U/X88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmsMwz+++vfjZu90da564gp/0dqdQLDM0VUr2Her5Vvf5rtYyqcXQwWNhqNsPNKKO
	 eoWVNhBqCdZ09SDETZBBSwrL9yocJSd+4nifRRkfGYHOuvwhzP3/0/ADJB30sKoQgC
	 a0Ld0n4xf9F9bwXH3fwQRSKiNyZ6E1xFkkqJsnf26l82mT0BTPMrwhlTeM98NJqNc/
	 My+SHrpBWySTKtx1C2f8+QuQu7KPLNeEw27QvDMbGkAH5uA4i0RVL837abeQ5rTTEa
	 En2+X50bSqLYCXK6jJ/B5CJQew7aXVKvKvojkeBUfn7FkuENm22zzPLH4Kcx+yWAYQ
	 CN8RfdyvI9E3Q==
Date: Fri, 26 Apr 2024 16:18:36 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Chandan Babu R <chandan.babu@oracle.com>,
	Dave Chinner <dchinner@redhat.com>,
	Colin Ian King <colin.i.king@gmail.com>,
	Zhang Tianci <zhangtianci.1997@bytedance.com>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xfs: Use kmemdup() instead of kmalloc() and memcpy()
Message-ID: <20240426231836.GS360919@frogsfrogsfrogs>
References: <20240426220046.181251-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426220046.181251-2-thorsten.blum@toblux.com>

On Sat, Apr 27, 2024 at 12:00:47AM +0200, Thorsten Blum wrote:
> Fixes the following two Coccinelle/coccicheck warnings reported by
> memdup.cocci:
> 
> 	xfs_dir2.c:343:15-22: WARNING opportunity for kmemdup
> 	xfs_attr_leaf.c:1062:13-20: WARNING opportunity for kmemdup
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/xfs/libxfs/xfs_attr_leaf.c | 5 ++---
>  fs/xfs/libxfs/xfs_dir2.c      | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
> index ac904cc1a97b..7346ee9aa4ca 100644
> --- a/fs/xfs/libxfs/xfs_attr_leaf.c
> +++ b/fs/xfs/libxfs/xfs_attr_leaf.c
> @@ -1059,12 +1059,11 @@ xfs_attr3_leaf_to_shortform(
>  
>  	trace_xfs_attr_leaf_to_sf(args);
>  
> -	tmpbuffer = kmalloc(args->geo->blksize, GFP_KERNEL | __GFP_NOFAIL);
> +	tmpbuffer = kmemdup(bp->b_addr, args->geo->blksize,
> +			GFP_KERNEL | __GFP_NOFAIL);
>  	if (!tmpbuffer)
>  		return -ENOMEM;
>  
> -	memcpy(tmpbuffer, bp->b_addr, args->geo->blksize);
> -

Please read the list before submitting a patch to a function that
already has a different change pending.

--D

>  	leaf = (xfs_attr_leafblock_t *)tmpbuffer;
>  	xfs_attr3_leaf_hdr_from_disk(args->geo, &ichdr, leaf);
>  	entry = xfs_attr3_leaf_entryp(leaf);
> diff --git a/fs/xfs/libxfs/xfs_dir2.c b/fs/xfs/libxfs/xfs_dir2.c
> index 4821519efad4..3ebb959cdaf0 100644
> --- a/fs/xfs/libxfs/xfs_dir2.c
> +++ b/fs/xfs/libxfs/xfs_dir2.c
> @@ -340,12 +340,11 @@ xfs_dir_cilookup_result(
>  					!(args->op_flags & XFS_DA_OP_CILOOKUP))
>  		return -EEXIST;
>  
> -	args->value = kmalloc(len,
> +	args->value = kmemdup(name, len,
>  			GFP_KERNEL | __GFP_NOLOCKDEP | __GFP_RETRY_MAYFAIL);
>  	if (!args->value)
>  		return -ENOMEM;
>  
> -	memcpy(args->value, name, len);
>  	args->valuelen = len;
>  	return -EEXIST;
>  }
> -- 
> 2.44.0
> 
> 

