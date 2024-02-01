Return-Path: <linux-kernel+bounces-47653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AD68450C2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7208B1F29FFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6985F87D;
	Thu,  1 Feb 2024 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oA7DJfo7"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718B55F861
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 05:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765712; cv=none; b=j/JskWllB1+OTCMb3y2SEChLAnSRVimN+4w7O/XzlpBHDcn/ob6id9/VmXJgW4PWw7fEsc0Q/zujrzNpS5WLHxVl73GN8hHiF4BNxiHuopp5G3GRCSHplypj9bw1VjAIpfg/km6CNjfLBTV95RGcm/2FcpASXqnUQIuQLjem+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765712; c=relaxed/simple;
	bh=Ti8kVewtXtvIiMYx+XqzhxQNBkFEys/ij1bq33Pr8oE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GNN/HG68iorpg8MTGaFVB7iTLOvvR2kBDFX+D7eAlcYfDRStd11F24XaNUJpn4blPxMUMHt85XA3fcEO5jbw2IOa7dAn7QhF1rWatwcR/VijMd4AGHDWFY/6kN/ee5fOmWopzau5MSwNM+o2JJORt7wA5+/SCr+t8N7hsTg2LcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oA7DJfo7; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706765710; x=1738301710;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=Ti8kVewtXtvIiMYx+XqzhxQNBkFEys/ij1bq33Pr8oE=;
  b=oA7DJfo7t4zmp7PFf/BEzefoAOaeLwss2NFJ0euuR3ujjKJNRM6al/xy
   TC2KRfWiR0qxWpY0qWupo9oOuH3aGNc3RBP/t3ylokKIvQ/6GZ3tj4kTR
   ru32JOIWVJd1+Qea8wM6TUMvqn0WYqs4YxeoMa283eT1yiBv6TbEaSOnQ
   9rd4ItDQJMbXC23JwcXCGtiv+4hSKz3N1A3SB5b+rKsLpaf3A11O9Rl3i
   BCKLHfVS/s7J7x5XM6RppyYhF7KMvhp3hUUaxMrIw6TjCO56nw2sIrW0a
   5eLQbfARzZubSjERiSODPNc9rtV9TtRp+phEwhONXBuZkdAUXEMgySEJU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="468049411"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="468049411"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:35:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4313762"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:35:04 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Wei =?utf-8?Q?Xu?=
 =?utf-8?Q?=EF=BF=BC?=
 <weixugc@google.com>,  Yu =?utf-8?Q?Zhao=EF=BF=BC?= <yuzhao@google.com>,
  Greg Thelen
 <gthelen@google.com>,  Chun-Tse Shao <ctshao@google.com>,  Suren
 =?utf-8?Q?Baghdasaryan=EF=BF=BC?= <surenb@google.com>,  Yosry =?utf-8?Q?A?=
 =?utf-8?Q?hmed=EF=BF=BC?= <yosryahmed@google.com>,
  Brain Geffon <bgeffon@google.com>,  Minchan Kim <minchan@kernel.org>,
  Michal Hocko <mhocko@suse.com>,  Mel Gorman
 <mgorman@techsingularity.net>,  Nhat Pham <nphamcs@gmail.com>,  Johannes
 Weiner <hannes@cmpxchg.org>,  Kairui Song <kasong@tencent.com>,  Zhongkun
 He <hezhongkun.hzk@bytedance.com>,  Kemeng Shi
 <shikemeng@huaweicloud.com>,  Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
In-Reply-To: <20240131-async-free-v2-1-525f03e07184@kernel.org> (Chris Li's
	message of "Wed, 31 Jan 2024 17:17:31 -0800")
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
Date: Thu, 01 Feb 2024 13:33:07 +0800
Message-ID: <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Chris Li <chrisl@kernel.org> writes:

> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>
> Further investigation show that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>
> Move free_swap_slots() outside of the swapin page fault handler into an
> async work queue to avoid such long tail latencies.
>
> The batch free of swap slots is typically at 100us level. Such a

Running ~100us operation in an asynchronous task appears overkill for me
too.

Can you try to move some operations out of swapcache_free_entries() to
check whether that can resolve your issue?

--
Best Regards,
Huang, Ying

> short time will not have a significant impact on the CPU accounting.
> Notice that the previous swap slot batching behavior already performs
> a delayed=C2=A0batch free. It=C2=A0waits for the entries=C2=A0accumulated=
 to 64.
> Adding the async scheduling time does not change the original
> free timing significantly.
>
> Testing:
>
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>
> platform	(100-500us)	 	(0-100us)
> A		1.12% -> 0.36%		98.47% -> 99.22%
> B		0.65% -> 0.15%		98.96% -> 99.46%
> C		0.61% -> 0.23%		98.96% -> 99.38%
>
> Signed-off-by: Chris Li <chrisl@kernel.org>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: Wei Xu=EF=BF=BC<weixugc@google.com>
> Cc: Yu Zhao=EF=BF=BC<yuzhao@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Chun-Tse Shao <ctshao@google.com>
> Cc: Suren Baghdasaryan=EF=BF=BC<surenb@google.com>
> Cc: Yosry Ahmed=EF=BF=BC <yosryahmed@google.com>
> Cc: Brain Geffon <bgeffon@google.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Kairui Song <kasong@tencent.com>
> Cc: Zhongkun He <hezhongkun.hzk@bytedance.com>
> Cc: Kemeng Shi <shikemeng@huaweicloud.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
>
> remove create_work queue
>
> remove another work queue usage
>
> ---
> Changes in v2:
> - Add description of the impact of time changing suggest by Ying.
> - Remove create_workqueue() and use schedule_work()
> - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b27799=
2cb0@kernel.org
> ---
>  include/linux/swap_slots.h |  1 +
>  mm/swap_slots.c            | 29 +++++++++++++++++++++--------
>  2 files changed, 22 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> index 15adfb8c813a..67bc8fa30d63 100644
> --- a/include/linux/swap_slots.h
> +++ b/include/linux/swap_slots.h
> @@ -19,6 +19,7 @@ struct swap_slots_cache {
>  	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
>  	swp_entry_t	*slots_ret;
>  	int		n_ret;
> +	struct work_struct async_free;
>  };
>=20=20
>  void disable_swap_slots_cache_lock(void);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..71d344564e55 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -44,6 +44,7 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
>  static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
>=20=20
>  static void __drain_swap_slots_cache(unsigned int type);
> +static void swapcache_async_free_entries(struct work_struct *data);
>=20=20
>  #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache_e=
nabled)
>  #define SLOTS_CACHE 0x1
> @@ -149,6 +150,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
>  		spin_lock_init(&cache->free_lock);
>  		cache->lock_initialized =3D true;
>  	}
> +	INIT_WORK(&cache->async_free, swapcache_async_free_entries);
>  	cache->nr =3D 0;
>  	cache->cur =3D 0;
>  	cache->n_ret =3D 0;
> @@ -269,6 +271,20 @@ static int refill_swap_slots_cache(struct swap_slots=
_cache *cache)
>  	return cache->nr;
>  }
>=20=20
> +static void swapcache_async_free_entries(struct work_struct *data)
> +{
> +	struct swap_slots_cache *cache;
> +
> +	cache =3D container_of(data, struct swap_slots_cache, async_free);
> +	spin_lock_irq(&cache->free_lock);
> +	/* Swap slots cache may be deactivated before acquiring lock */
> +	if (cache->slots_ret) {
> +		swapcache_free_entries(cache->slots_ret, cache->n_ret);
> +		cache->n_ret =3D 0;
> +	}
> +	spin_unlock_irq(&cache->free_lock);
> +}
> +
>  void free_swap_slot(swp_entry_t entry)
>  {
>  	struct swap_slots_cache *cache;
> @@ -282,17 +298,14 @@ void free_swap_slot(swp_entry_t entry)
>  			goto direct_free;
>  		}
>  		if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> -			/*
> -			 * Return slots to global pool.
> -			 * The current swap_map value is SWAP_HAS_CACHE.
> -			 * Set it to 0 to indicate it is available for
> -			 * allocation in global pool
> -			 */
> -			swapcache_free_entries(cache->slots_ret, cache->n_ret);
> -			cache->n_ret =3D 0;
> +			spin_unlock_irq(&cache->free_lock);
> +			schedule_work(&cache->async_free);
> +			goto direct_free;
>  		}
>  		cache->slots_ret[cache->n_ret++] =3D entry;
>  		spin_unlock_irq(&cache->free_lock);
> +		if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> +			schedule_work(&cache->async_free);
>  	} else {
>  direct_free:
>  		swapcache_free_entries(&entry, 1);
>
> ---
> base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
> change-id: 20231216-async-free-bef392015432
>
> Best regards,

