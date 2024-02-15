Return-Path: <linux-kernel+bounces-67516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F9856CC2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47F1E28786C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AFED138486;
	Thu, 15 Feb 2024 18:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KtfxvaNd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C63A79958
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708021909; cv=none; b=iB90AFaCbr/YOElMQazrmj65qGEkHpK+3zYBswOkHRJOwl70pa+clXoQFCH7+tXymiM90vBKQY9zmY9GINsf1LZt9yGIz4Wu6eOR0N/farOR0BAwiW35ioE2+f/itCqymZFQWOKxm+Sd7rtDsCga71Oq8gloTYWw4Ck16fFTDpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708021909; c=relaxed/simple;
	bh=VuIUVWayapf/CPwBdlgdw2mp4l5hTiWPSbAsQcFP68E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=V0JhWiHLw+UDloEg7JGi7MQd7Ptx/a2+4wyASMreUcZZLEQfHV0/EQy9E//bXc4tp5vUHT8Pd6AJXcBVjCNMJxO2z7HsAiTBg46ATkNqA6XfIJ8YBlEmlSUlctcxm/521qFYTlrIkSMrbsbS9MnTHd15z5eQJj5j7DfzP83qNgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KtfxvaNd; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708021907; x=1739557907;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=VuIUVWayapf/CPwBdlgdw2mp4l5hTiWPSbAsQcFP68E=;
  b=KtfxvaNd5t1TBZgEeDJi3+Kf2QH9v7qoeorPtC6cnseoVvdJDVmcfK7t
   s6LfMNluEtod/Ks7xrHHTgJbC4KiOdX9kIuKcgP/NRNKo9PjI6ZKXJH4M
   SL6cjPzMJIue+ew/apjmFDtYMLunzOXHCPJ8sctwkwet1hikLKg60dgDg
   yeK/C7PgO9bvKOVu1y+z6h4OVZ0emok+BHAMNwXItB6nwAhbiPWVSNnrG
   WT0WuYEE6KhGu1/M28m5mSrOBKXRhAmMrptbp0ggu94qG71jmJK1Fikos
   UhOkWeTSRmzf3FeSQHRU7B5vrMwf3ZAHjqWiTN1O2Ygl/Gslb/XM6xVFk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5939523"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5939523"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 10:31:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="3637668"
Received: from sgafur-mobl1.amr.corp.intel.com (HELO [10.209.97.128]) ([10.209.97.128])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 10:31:42 -0800
Message-ID: <0c5431d984fe518f9f9b2f85639a6fc844115deb.camel@linux.intel.com>
Subject: Re: [PATCH v4] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chris Li <chrisl@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Wei Xu
 <weixugc@google.com>,  Yu Zhao <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>,  Yosry Ahmed
 <yosryahmed@google.com>, Michal Hocko <mhocko@suse.com>, Mel Gorman
 <mgorman@techsingularity.net>, Huang Ying <ying.huang@intel.com>, Nhat Pham
 <nphamcs@gmail.com>, Kairui Song <kasong@tencent.com>, Barry Song
 <v-songbaohua@oppo.com>
Date: Thu, 15 Feb 2024 10:31:41 -0800
In-Reply-To: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
References: <20240214-async-free-v4-1-6abe0d59f85f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-02-14 at 17:02 -0800, Chris Li wrote:
> We discovered that 1% swap page fault is 100us+ while 50% of
> the swap fault is under 20us.
>=20
> Further investigation shows that a large portion of the time
> spent in the free_swap_slots() function for the long tail case.
>=20
> The percpu cache of swap slots is freed in a batch of 64 entries
> inside free_swap_slots(). These cache entries are accumulated
> from previous page faults, which may not be related to the current
> process.
>=20
> Doing the batch free in the page fault handler causes longer
> tail latencies and penalizes the current process.
>=20
> When the swap cache slot is full, schedule async free cached
> swap slots in a work queue,=C2=A0before the next swap fault comes in.
> If the next swap fault comes in very fast, before the async
> free gets a chance to run. It will directly free all the swap
> cache in the swap fault the same way as previously.
>=20
> Testing:
>=20
> Chun-Tse did some benchmark in chromebook, showing that
> zram_wait_metrics improve about 15% with 80% and 95% confidence.
>=20
> I recently ran some experiments on about 1000 Google production
> machines. It shows swapin latency drops in the long tail
> 100us - 500us bucket dramatically.
>=20
> platform	(100-500us)	 	(0-100us)
> A		1.12% -> 0.36%		98.47% -> 99.22%
> B		0.65% -> 0.15%		98.96% -> 99.46%
> C		0.61% -> 0.23%		98.96% -> 99.38%
>=20
> Signed-off-by: Chris Li <chrisl@kernel.org>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
> Changes in v4:
> - Remove the sysfs interface file, according the feedback.
> - Move the full condition test inside the spinlock.
> - Link to v3: https://lore.kernel.org/r/20240213-async-free-v3-1-b89c3cc4=
8384@kernel.org
>=20
> Changes in v3:
> - Address feedback from Tim Chen, direct free path will free all swap slo=
ts.
> - Add /sys/kernel/mm/swap/swap_slot_async_fee to enable async free. Defau=
lt is off.
> - Link to v2: https://lore.kernel.org/r/20240131-async-free-v2-1-525f03e0=
7184@kernel.org
>=20
> Changes in v2:
> - Add description of the impact of time changing suggest by Ying.
> - Remove create_workqueue() and use schedule_work()
> - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b27799=
2cb0@kernel.org
> ---
>  include/linux/swap_slots.h |  1 +
>  mm/swap_slots.c            | 20 ++++++++++++++++++++
>  2 files changed, 21 insertions(+)
>=20
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
> =20
>  void disable_swap_slots_cache_lock(void);
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e..23dc04bce9ca 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -44,6 +44,7 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
>  static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
> =20
>  static void __drain_swap_slots_cache(unsigned int type);
> +static void swapcache_async_free_entries(struct work_struct *data);
> =20
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
> @@ -269,12 +271,27 @@ static int refill_swap_slots_cache(struct swap_slot=
s_cache *cache)
>  	return cache->nr;
>  }
> =20
> +static void swapcache_async_free_entries(struct work_struct *data)
> +{
> +	struct swap_slots_cache *cache;
> +
> +	cache =3D container_of(data, struct swap_slots_cache, async_free);
> +	spin_lock_irq(&cache->free_lock);
> +	/* Swap slots cache may be deactivated before acquiring lock */
> +	if (cache->slots_ret && cache->n_ret) {
> +		swapcache_free_entries(cache->slots_ret, cache->n_ret);
> +		cache->n_ret =3D 0;
> +	}
> +	spin_unlock_irq(&cache->free_lock);
> +}
> +
>  void free_swap_slot(swp_entry_t entry)
>  {
>  	struct swap_slots_cache *cache;
> =20
>  	cache =3D raw_cpu_ptr(&swp_slots);
>  	if (likely(use_swap_slot_cache && cache->slots_ret)) {
> +		bool full;
>  		spin_lock_irq(&cache->free_lock);
>  		/* Swap slots cache may be deactivated before acquiring lock */
>  		if (!use_swap_slot_cache || !cache->slots_ret) {
> @@ -292,7 +309,10 @@ void free_swap_slot(swp_entry_t entry)
>  			cache->n_ret =3D 0;
>  		}
>  		cache->slots_ret[cache->n_ret++] =3D entry;
> +		full =3D cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE;
>  		spin_unlock_irq(&cache->free_lock);
> +		if (full)
> +			schedule_work(&cache->async_free);
>  	} else {
>  direct_free:
>  		swapcache_free_entries(&entry, 1);
>=20
> ---
> base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
> change-id: 20231216-async-free-bef392015432
>=20
> Best regards,


