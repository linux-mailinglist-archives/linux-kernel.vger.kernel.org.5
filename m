Return-Path: <linux-kernel+bounces-34961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E038389E2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 102F82874E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E6357868;
	Tue, 23 Jan 2024 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KuWx9f2Z"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5251C54
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706000468; cv=none; b=piUx6MBXQzcVwH9N1NcWaNx1hmS/E+Drjx6QOMkuhNHcHU2pMIXZleCtg/z/mmH/94URmfKEpesfeHP6icbfn4gi7POvN+u0Da5uUsJRF/wSeVLBjNo5BWSm1tDXkULF8yJsE/gJMUo9IDuS8ZZnyE7FecI8hzfat8+LwhgOW3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706000468; c=relaxed/simple;
	bh=2iIMuxSXVIfbhEDxIspm7QifUedTVVjC5VjdGTdogdA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=arQH1e9hs5jFaGIvGAPclgIYgulLg6v7uIOmrG2C4pa6TCUsOxDkUYxp1CsEU4bvkEV4BAJFwfXNJK9fEec4C5RdQ/JeUYFznLL4sQ7Y37+bWGtaHhib89OokEfxnhmH7DzJR+tqZHb4YXK+0jTxgoxZ+HmrzDbnJaPtZvuSs6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KuWx9f2Z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706000465; x=1737536465;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=2iIMuxSXVIfbhEDxIspm7QifUedTVVjC5VjdGTdogdA=;
  b=KuWx9f2ZKVes/QlPrb7mff5JakMCsP9FCZUNuUUVU5yVUlWSgnKa5Jxe
   p7DpuS785uwkkWUR4kSAhomwlcXzmC5uePNBkJvf7xb3R1NG8b2v4wMEW
   KtZAYCei3ekixLIUtl4eC6rkS0b8yLJ5ut8VitnYbFAnwx/BAtGtG3T6D
   nLOE+kcH+7ITsPfOqyo7kt5GY9ZH/Rn9FIVP4XZv2E2uzMULhXww1quN+
   8gnPK/iIffT7yGCkT58HpZOkahad4UiY6ngjjNDu6JWbIzRJf2PyCqCK0
   mjd/ksgJ4U5qaefxRwziqQnfOFrGU3JHmhhF7c1SDJ5QnYVSdIP+1AzAa
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="8572860"
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="8572860"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:01:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,214,1701158400"; 
   d="scan'208";a="1589512"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 01:01:01 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Nhat Pham <nphamcs@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Chengming Zhou <zhouchengming@bytedance.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are
 done
In-Reply-To: <20240120024007.2850671-2-yosryahmed@google.com> (Yosry Ahmed's
	message of "Sat, 20 Jan 2024 02:40:06 +0000")
References: <20240120024007.2850671-1-yosryahmed@google.com>
	<20240120024007.2850671-2-yosryahmed@google.com>
Date: Tue, 23 Jan 2024 16:59:03 +0800
Message-ID: <87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
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
> swapoff, try_to_unuse() uses inuse_pages to make sure all swap entries
> are freed. Make sure we only update inuse_pages after we are done with
> the cleanups.
>
> In practice, this shouldn't matter, because swap_range_free() is called
> with the swap info lock held, and the swapoff code will spin for that
> lock after try_to_unuse() anyway.
>
> The goal is to make it obvious and more future proof that once
> try_to_unuse() returns, all cleanups are done.

Defines "all cleanups".  Apparently, some other operations are still
to be done after try_to_unuse() in swap_off().

> This also facilitates a
> following zswap cleanup patch which uses this fact to simplify
> zswap_swapoff().
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  mm/swapfile.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f0..2fedb148b9404 100644
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
> @@ -752,6 +750,8 @@ static void swap_range_free(struct swap_info_struct *si, unsigned long offset,
>  		offset++;
>  	}
>  	clear_shadow_from_swap_cache(si->type, begin, end);
> +	atomic_long_add(nr_entries, &nr_swap_pages);
> +	WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);

This isn't enough.  You need to use smp_wmb() here and smp_rmb() in
somewhere reading si->inuse_pages.

>  }
>  
>  static void set_cluster_next(struct swap_info_struct *si, unsigned long next)

--
Best Regards,
Huang, Ying

