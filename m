Return-Path: <linux-kernel+bounces-63651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD7B8532CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88C56B212DD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E5457865;
	Tue, 13 Feb 2024 14:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sgdWUkbC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F086456767
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833778; cv=none; b=dy1fsap8fUCSCbKd4wD32AH/GXcw/7BiwLJvEcX+pg8ozAj36mtzmOe8RffaPthS0Ny3pPjt9brYF9g++JSwUsAAo1dLE3FUKDENh+cJPRsY8NiEO+g5ifB2ViOjg1fcb9z1kIiPYcPEQZ7am5MLJdPamapEy0gmvsM7O4H4K50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833778; c=relaxed/simple;
	bh=L6jRfxMYCh8UD1FD1aOEy6MCfeW64Gaqwg9aSufjq50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRlnBsDUvGIhCnVKX2XJvG0/ushCgV/mbNuxa3MJ5M8efeDHFTzLv/mbtax2eRdFh2Vz/wylS3c63ZLwoyANfps9vBaXs9SXom3TaqTRv3w7BLRuYenrjNfvMOfogkegbDHKxl+4l2BNMla3cnyRM04kHzc6cwCsFdxwA97v+KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sgdWUkbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73155C433C7;
	Tue, 13 Feb 2024 14:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707833777;
	bh=L6jRfxMYCh8UD1FD1aOEy6MCfeW64Gaqwg9aSufjq50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sgdWUkbCwCbviBUoRnyk0DAh9/UAUx61Z33BY+4ngyew4ErGf0x0MDBgnW55JNIPw
	 t/iytl4JaD0nsJrrqXBSslMdEKDCjS4cYQIrIKT6CQzNj+UmmIlgLogG9CQprWetl+
	 1RNy/qVEvbA93I6TIY8zItmAZJdalHOE0R+DjEFXIHXx7JEcgNICVAQqDvaqggyUaL
	 XScLhr8wYnlUVIGcJXYOLejCq1rFHpJ7fLjXtmFN1dOEUGJ/61xLEelyZxeSTHObSe
	 ifmCOlEECfZwwtKkPDiHA2pyogdX5StZMBXA7T7M1+EF5v9xd6Un99N2FL5fUuz/Zn
	 KDXkbIqzlfIyg==
Date: Tue, 13 Feb 2024 16:15:54 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
	Mel Gorman <mgorman@techsingularity.net>,
	Matthew Wilcox <willy@infradead.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [PATCH] mm: document memalloc_noreclaim_save() and
 memalloc_pin_save()
Message-ID: <Zct5mtrHoeGD5S0f@kernel.org>
References: <20240212182950.32730-2-vbabka@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212182950.32730-2-vbabka@suse.cz>

On Mon, Feb 12, 2024 at 07:29:51PM +0100, Vlastimil Babka wrote:
> The memalloc_noreclaim_save() function currently has no documentation
> comment, so the implications of its usage are not obvious. Namely that
> it not only prevents entering reclaim (as the name suggests), but also
> allows using all memory reserves and thus should be only used in
> contexts that are allocating memory to free memory. This may lead to new
> improper usages being added.
> 
> Thus add a documenting comment, based on the description of
> __GFP_MEMALLOC. While at it, also document memalloc_pin_save() so that
> all the memalloc_ scopes are documented. In the comments describing the
> relevant PF_MEMALLOC flags, refer to their scope setting functions.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Except few nits below

Reviewed-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/sched.h    |  9 ++++----
>  include/linux/sched/mm.h | 45 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 50 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index ffe8f618ab86..f2cb479f56a7 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1623,15 +1623,15 @@ extern struct pid *cad_pid;
>  #define PF_SUPERPRIV		0x00000100	/* Used super-user privileges */
>  #define PF_DUMPCORE		0x00000200	/* Dumped core */
>  #define PF_SIGNALED		0x00000400	/* Killed by a signal */
> -#define PF_MEMALLOC		0x00000800	/* Allocating memory */
> +#define PF_MEMALLOC		0x00000800	/* Allocating memory to free memory. See memalloc_noreclaim_save() */
>  #define PF_NPROC_EXCEEDED	0x00001000	/* set_user() noticed that RLIMIT_NPROC was exceeded */
>  #define PF_USED_MATH		0x00002000	/* If unset the fpu must be initialized before use */
>  #define PF_USER_WORKER		0x00004000	/* Kernel thread cloned from userspace thread */
>  #define PF_NOFREEZE		0x00008000	/* This thread should not be frozen */
>  #define PF__HOLE__00010000	0x00010000
>  #define PF_KSWAPD		0x00020000	/* I am kswapd */
> -#define PF_MEMALLOC_NOFS	0x00040000	/* All allocation requests will inherit GFP_NOFS */
> -#define PF_MEMALLOC_NOIO	0x00080000	/* All allocation requests will inherit GFP_NOIO */
> +#define PF_MEMALLOC_NOFS	0x00040000	/* All allocations inherit GFP_NOFS. See memalloc_nfs_save() */
> +#define PF_MEMALLOC_NOIO	0x00080000	/* All allocations inherit GFP_NOIO. See memalloc_noio_save() */
>  #define PF_LOCAL_THROTTLE	0x00100000	/* Throttle writes only against the bdi I write to,
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
> @@ -1641,7 +1641,8 @@ extern struct pid *cad_pid;
>  #define PF__HOLE__02000000	0x02000000
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> -#define PF_MEMALLOC_PIN		0x10000000	/* Allocation context constrained to zones which allow long term pinning. */
> +#define PF_MEMALLOC_PIN		0x10000000	/* Allocations constrained to zones which allow long term pinning.
> +						 * See memalloc_pin_save() */
>  #define PF__HOLE__20000000	0x20000000
>  #define PF__HOLE__40000000	0x40000000
>  #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 9a19f1b42f64..eef8fa5ba5de 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -368,6 +368,27 @@ static inline void memalloc_nofs_restore(unsigned int flags)
>  	current->flags = (current->flags & ~PF_MEMALLOC_NOFS) | flags;
>  }
>  
> +/**
> + * memalloc_noreclaim_save - Marks implicit __GFP_MEMALLOC scope.
> + *
> + * This functions marks the beginning of the __GFP_MEMALLOC allocation scope.

          ^ function

> + * All further allocations will implicitly add the __GFP_MEMALLOC flag, which
> + * prevents entering reclaim and allows access to all memory reserves. This
> + * should only be used when the caller guarantees the allocation will allow more
> + * memory to be freed very shortly, i.e. it needs to allocate some memory in
> + * the process of freeing memory, and cannot reclaim due to potential recursion.
> + *
> + * Users of this scope have to be extremely careful to not deplete the reserves
> + * completely and implement a throttling mechanism which controls the
> + * consumption of the reserve based on the amount of freed memory. Usage of a
> + * pre-allocated pool (e.g. mempool) should be always considered before using
> + * this scope.
> + *
> + * Individual allocations under the scope can opt out using __GFP_NOMEMALLOC
> + *
> + * This function should not be used in an interrupt context as that one does not
> + * give PF_MEMALLOC access to reserves, see __gfp_pfmemalloc_flags().

Missing Return: description

> + */
>  static inline unsigned int memalloc_noreclaim_save(void)
>  {
>  	unsigned int flags = current->flags & PF_MEMALLOC;
> @@ -375,11 +396,27 @@ static inline unsigned int memalloc_noreclaim_save(void)
>  	return flags;
>  }
>  
> +/**
> + * memalloc_noreclaim_restore - Ends the implicit __GFP_MEMALLOC scope.
> + * @flags: Flags to restore.
> + *
> + * Ends the implicit __GFP_MEMALLOC scope started by memalloc_noreclaim_save
> + * function. Always make sure that the given flags is the return value from the
> + * pairing memalloc_noreclaim_save call.
> + */
>  static inline void memalloc_noreclaim_restore(unsigned int flags)
>  {
>  	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
>  }
>  
> +/**
> + * memalloc_pin_save - Marks implicit ~__GFP_MOVABLE scope.
> + *
> + * This functions marks the beginning of the ~__GFP_MOVABLE allocation scope.

          ^ function

> + * All further allocations will implicitly remove the __GFP_MOVABLE flag, which
> + * will constraint the allocations to zones that allow long term pinning, i.e.
> + * not ZONE_MOVABLE zones.

Missing Return: description

> + */
>  static inline unsigned int memalloc_pin_save(void)
>  {
>  	unsigned int flags = current->flags & PF_MEMALLOC_PIN;
> @@ -388,6 +425,14 @@ static inline unsigned int memalloc_pin_save(void)
>  	return flags;
>  }
>  
> +/**
> + * memalloc_pin_restore - Ends the implicit ~__GFP_MOVABLE scope.
> + * @flags: Flags to restore.
> + *
> + * Ends the implicit ~__GFP_MOVABLE scope started by memalloc_pin_save function.
> + * Always make sure that the given flags is the return value from the pairing
> + * memalloc_pin_save call.
> + */
>  static inline void memalloc_pin_restore(unsigned int flags)
>  {
>  	current->flags = (current->flags & ~PF_MEMALLOC_PIN) | flags;
> -- 
> 2.43.0
> 
> 

-- 
Sincerely yours,
Mike.

