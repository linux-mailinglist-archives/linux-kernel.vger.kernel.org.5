Return-Path: <linux-kernel+bounces-87050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CB586CEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:20:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEB991C226C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F74413F422;
	Thu, 29 Feb 2024 16:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJgt7a/I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE65134430;
	Thu, 29 Feb 2024 16:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709222450; cv=none; b=Ffw5UOwkEk51Xu75UP6f5+tS24kp6Rkkh25qEjrjlZVUh7sFbWdnfOJlXcOI98xqxQE0IjZ+at1dx6FAu3O2PNbFdLFzJoJsF601Jz6h+f2j6IX2Bs13nBlDD+L+1/1GbvtJb89VKCNmkiUJ4kAClWCGX5TpkOOGtBmi8TErb2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709222450; c=relaxed/simple;
	bh=lnjqrM8Lfog5fV1cL5NQmbG9UmOGAw+pkjMKhL6L9FI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+0eTuqlReR66qiRXNGH+VMPctkdx0RKru58+0gEAanT4WSJoM/mP2mDvBbqLbAFYoR171+3uIA5rW+PkyfOjt6HZZmj7LMUMt7awk07Yah+wK0VJM7E00jbv/r/kxgo6wMGRv2N3OcAJewvWaig1q0rUQiPc0RjNRm5Qdv3HCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJgt7a/I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69F6C433F1;
	Thu, 29 Feb 2024 16:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709222449;
	bh=lnjqrM8Lfog5fV1cL5NQmbG9UmOGAw+pkjMKhL6L9FI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJgt7a/I08xUFVWKGUQUt/CbnrRwSeuWuOVZB/GRli+J4DfxIBlU8I4rOQ8iTiOsv
	 E104t5JtWqdIRhuavFMU2rVQoMQjnnkpulToS3t8V47AIInq31/SnL3CC4g8o3a0VD
	 1rumGN985aN5g2VIfW/FMygt4zS/00Li3OIULshxEyZz3fPc8gJXcu0vh0AjruHdzD
	 zS6n9bsWeyH1KcnctMPBo6kLtaGy6d6XnD6E5CsE1zi/P/Bzcp8efTp/DTzbjpxzQV
	 ygabbPCyn45uZ3XmdlLQzBlTYGnl72qMikVI/D8OYaperNbR0CT1TizT4tX5sFpQ80
	 3jRxkXx54nuuQ==
Date: Thu, 29 Feb 2024 08:00:49 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: kunwu.chan@linux.dev
Cc: chandan.babu@oracle.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kunwu Chan <chentao@kylinos.cn>
Subject: Re: [PATCH] xfs: use KMEM_CACHE() to create xfs_defer_pending cache
Message-ID: <20240229160049.GY1927156@frogsfrogsfrogs>
References: <20240229083342.1128686-1-kunwu.chan@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229083342.1128686-1-kunwu.chan@linux.dev>

On Thu, Feb 29, 2024 at 04:33:42PM +0800, kunwu.chan@linux.dev wrote:
> From: Kunwu Chan <chentao@kylinos.cn>
> 
> Use the KMEM_CACHE() macro instead of kmem_cache_create() to simplify
> the creation of SLAB caches when the default values are used.
> 
> Signed-off-by: Kunwu Chan <chentao@kylinos.cn>

Why bother? The vast majority of the kernel is still using
kmem_cache_create(), not the weird, shouty macro that doesn't actually
tell us what it is doing with said kmem_cache......

Up until now we've chosen not switch XFS to use it because many of the
slab caches we use in XFS are not just "default" slab caches.  IOWs, we
still have to use kmem_cache_create() for a lot of the caches we create,
so we may as well use kmem_cache_create() for all of them rather than
have to go look up what KMEM_CACHE() translates to every time we are
looking at how slab caches are created.

Also, if you are going to change simple API stuff like this in XFS,
please do all the conversions in a single patch. It takes much less time
and resources to review and merge a single patch compared to a pile of
dozen independent one line patches...

--D

> ---
>  fs/xfs/libxfs/xfs_defer.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/fs/xfs/libxfs/xfs_defer.c b/fs/xfs/libxfs/xfs_defer.c
> index 66a17910d021..6d957fcc17f2 100644
> --- a/fs/xfs/libxfs/xfs_defer.c
> +++ b/fs/xfs/libxfs/xfs_defer.c
> @@ -1143,9 +1143,7 @@ xfs_defer_resources_rele(
>  static inline int __init
>  xfs_defer_init_cache(void)
>  {
> -	xfs_defer_pending_cache = kmem_cache_create("xfs_defer_pending",
> -			sizeof(struct xfs_defer_pending),
> -			0, 0, NULL);
> +	xfs_defer_pending_cache = KMEM_CACHE(xfs_defer_pending, 0);
>  
>  	return xfs_defer_pending_cache != NULL ? 0 : -ENOMEM;
>  }
> -- 
> 2.39.2
> 
> 

