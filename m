Return-Path: <linux-kernel+bounces-36468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1DE83A149
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42EBC1F2AAA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D738F9C7;
	Wed, 24 Jan 2024 05:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfb5632t"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C41BE541
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073725; cv=none; b=K0LW6LR+vYs20mKWx6Np+zTQgu5PxZ0gBI8Zj6PAWolAAlZE/q+q5nBvZN4mEBWi2b7TdMcAZXdzCQtJK8sTmxr4LmXGZtH55v/1FW678a7ewxkAbTyKm/Z+7g6L3SzvcVIwGfybrbtU/B2tLs7g3oJsE5smCaqd0EqyXa93jko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073725; c=relaxed/simple;
	bh=hU252DMMuSZQLgzYBhf+Vx2BxaVBXcFr8qCm+J/aDJM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cKhrbRRrPj3Ub3FkS4FeHL8u/KhHgx3xo3sp3hx94L2s3JUFAOkWOtZ4wBj21GB+BM9bJukvbWIknT6VRGsHZjOryDoPdYS6fmduaMrXEW1zSO03TfJbKaC1pnmlPpruvGPzXuussgTvy4si6CSTlFSUiZqYKGbOzEMeo8EZs58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfb5632t; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706073723; x=1737609723;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=hU252DMMuSZQLgzYBhf+Vx2BxaVBXcFr8qCm+J/aDJM=;
  b=kfb5632tXL4QiyZD4Cz9nV3cIOAdiyONF+kae1ZoknTvdzkXQLtFFfQU
   RY+EkXTc5sAS+KrVPcdKB2Szw/wFC7m3F+wMTe/WmEqb1fo2m0C2MSlts
   n5HgfoO8eaQV3gZGpQpE0RPCgsKwoeMWYzNB4CLjC8zBigmeTZ9XpPy2R
   lkrIOgNyghvX3OmEOCV3Nm2dTCYmDIuI4M2/0mj1ZEeXbRtlGQQUHoPaH
   PklwWczKOvo9AbI2Z+1/TL2ncuTNPNZFO4kDlYsoCpPAvlIf1bSEKCwmj
   ha5DKmVqYk9+oRHXKUc8gyclcYpY0oBRMcj6xHY5KcOmtMh3Xn1YK/Asj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="15261380"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="15261380"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:22:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="959392792"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="959392792"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:21:59 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Nhat Pham <nphamcs@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Chengming Zhou <zhouchengming@bytedance.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm: swap: enforce updating inuse_pages at the
 end of swap_range_free()
In-Reply-To: <20240124045113.415378-2-yosryahmed@google.com> (Yosry Ahmed's
	message of "Wed, 24 Jan 2024 04:51:11 +0000")
References: <20240124045113.415378-1-yosryahmed@google.com>
	<20240124045113.415378-2-yosryahmed@google.com>
Date: Wed, 24 Jan 2024 13:20:02 +0800
Message-ID: <87v87js3y5.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yosry Ahmed <yosryahmed@google.com> writes:

> In swap_range_free(), we update inuse_pages then do some cleanups (arch
> invalidation, zswap invalidation, swap cache cleanups, etc). During
> swapoff, try_to_unuse() checks that inuse_pages is 0 to make sure all
> swap entries are freed. Make sure we only update inuse_pages after we
> are done with the cleanups in swap_range_free(), and use the proper
> memory barriers to enforce it. This makes sure that code following
> try_to_unuse() can safely assume that swap_range_free() ran for all
> entries in thr swapfile (e.g. swap cache cleanup, zswap_swapoff()).
>
> In practice, this currently isn't a problem because swap_range_free() is
> called with the swap info lock held, and the swapoff code happens to
> spin for that after try_to_unuse(). However, this seems fragile and
> unintentional, so make it more relable and future-proof. This also
> facilitates a following simplification of zswap_swapoff().
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

LGTM, Thanks!

Reviewed-by: "Huang, Ying" <ying.huang@intel.com>

> ---
>  mm/swapfile.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index b11b6057d8b5f..0580bb3e34d77 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		if (was_full && (si->flags & SWP_WRITEOK))
>  			add_to_avail_list(si);
>  	}
> -	atomic_long_add(nr_entries, &nr_swap_pages);
> -	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  	if (si->flags & SWP_BLKDEV)
>  		swap_slot_free_notify =
>  			si->bdev->bd_disk->fops->swap_slot_free_notify;
> @@ -752,6 +750,14 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		offset++;
>  	}
>  	clear_shadow_from_swap_cache(si->type, begin, end);
> +
> +	/*
> +	 * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
> +	 * only after the above cleanups are done.
> +	 */
> +	smp_wmb();
> +	atomic_long_add(nr_entries, &nr_swap_pages);
> +	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  }
>  
>  static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
> @@ -2049,7 +2055,7 @@ static int try_to_unuse(unsigned int type)
>  	unsigned int i;
>  
>  	if (!READ_ONCE(si->inuse_pages))
> -		return 0;
> +		goto success;
>  
>  retry:
>  	retval = shmem_unuse(type);
> @@ -2130,6 +2136,12 @@ static int try_to_unuse(unsigned int type)
>  		return -EINTR;
>  	}
>  
> +success:
> +	/*
> +	 * Make sure that further cleanups after try_to_unuse() returns happen
> +	 * after swap_range_free() reduces si->inuse_pages to 0.
> +	 */
> +	smp_mb();
>  	return 0;
>  }

