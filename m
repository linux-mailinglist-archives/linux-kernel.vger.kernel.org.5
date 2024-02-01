Return-Path: <linux-kernel+bounces-48984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2D84645E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B9CA1F24CF9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F48F47A7F;
	Thu,  1 Feb 2024 23:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DYz1Uw65"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F2241211
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 23:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706829661; cv=none; b=EJRMDydu+qNt//TLP2GImPv2eB76zRkHuJr05Th07qlcgAqXa4KyxlnS62o3Wdb9lEfjl00h8jkVAWw9YECj3LRpjEKS9uF7EDpRJbXN5Yx60wFNxP6SjoIYdHC0HtXGjvEnubsVdHVNW4F2E17GWuJHa8tp7zYEBluOvkXPHuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706829661; c=relaxed/simple;
	bh=l9z7Z/CPSJRsgaZ/pWgOCZAEvFTdT/WuuGesqxR6Q/s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GHiS1RKGfjncIkSIzuXKexnNWDRlS42SPLeTtp2gSleP7JNg1B1WpleIkgEGrrvPC/LmM28G39lgKXYfA6khZAxu3xXMkdBDCAFJO5U94VAEK49gHiz20bhGOOflulCjRaUQEKPXee3r3MEVv+Aspl7GgBzw2PSCT1SQc6AHTsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DYz1Uw65; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706829661; x=1738365661;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=l9z7Z/CPSJRsgaZ/pWgOCZAEvFTdT/WuuGesqxR6Q/s=;
  b=DYz1Uw65Bozgq1Q2vrT2kv5bKgkiZWUphE4hB5jxohVK0H9nvmEG2dfS
   4R1OedvcZzjzQJPQb8oq1t+tx+tKvVD/C+u+vMZW9U2rpZQgGto+UV2rc
   giQwHnaR2QGgEOCH4J+6T0sF4E4SK155yUoOHILQ8RP6iCgzXMExVtFC8
   qV2y2f+AXjARMSZ8gPujkRK3+pshewfTcoq7Vxz4kJ/oqb75pTOJfbIg3
   XrHEjK4Yo/dLpCI4LXTN7eXwHCbnOmJKUhuWjMISngVXXz0kFNo6Tk9QL
   2gzrTgwenOgqmQhWwqorqShByND9iFUyuw51DYNePaXYJnoCMCOd+HM/P
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11133236"
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="11133236"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 15:21:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,236,1701158400"; 
   d="scan'208";a="4654575"
Received: from xzhou1-mobl.amr.corp.intel.com (HELO [10.212.155.8]) ([10.212.155.8])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 15:20:59 -0800
Message-ID: <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
  linux-mm@kvack.org, Wei =?UTF-8?Q?Xu=EF=BF=BC?= <weixugc@google.com>, Yu
 =?UTF-8?Q?Zhao=EF=BF=BC?= <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, Suren
 =?UTF-8?Q?Baghdasaryan=EF=BF=BC?= <surenb@google.com>,  Yosry
 =?UTF-8?Q?Ahmed=EF=BF=BC?= <yosryahmed@google.com>, Brain Geffon
 <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Nhat Pham
 <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song
 <kasong@tencent.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>,  Barry Song <v-songbaohua@oppo.com>
Date: Thu, 01 Feb 2024 15:20:58 -0800
In-Reply-To: <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
	 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-01 at 13:33 +0800, Huang, Ying wrote:
> Chris Li <chrisl@kernel.org> writes:
>=20
> >=20
> > Changes in v2:
> > - Add description of the impact of time changing suggest by Ying.
> > - Remove create_workqueue() and use schedule_work()
> > - Link to v1: https://lore.kernel.org/r/20231221-async-free-v1-1-94b277=
992cb0@kernel.org
> > ---
> >  include/linux/swap_slots.h |  1 +
> >  mm/swap_slots.c            | 29 +++++++++++++++++++++--------
> >  2 files changed, 22 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/include/linux/swap_slots.h b/include/linux/swap_slots.h
> > index 15adfb8c813a..67bc8fa30d63 100644
> > --- a/include/linux/swap_slots.h
> > +++ b/include/linux/swap_slots.h
> > @@ -19,6 +19,7 @@ struct swap_slots_cache {
> >  	spinlock_t	free_lock;  /* protects slots_ret, n_ret */
> >  	swp_entry_t	*slots_ret;
> >  	int		n_ret;
> > +	struct work_struct async_free;
> >  };
> > =20
> >  void disable_swap_slots_cache_lock(void);
> > diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> > index 0bec1f705f8e..71d344564e55 100644
> > --- a/mm/swap_slots.c
> > +++ b/mm/swap_slots.c
> > @@ -44,6 +44,7 @@ static DEFINE_MUTEX(swap_slots_cache_mutex);
> >  static DEFINE_MUTEX(swap_slots_cache_enable_mutex);
> > =20
> >  static void __drain_swap_slots_cache(unsigned int type);
> > +static void swapcache_async_free_entries(struct work_struct *data);
> > =20
> >  #define use_swap_slot_cache (swap_slot_cache_active && swap_slot_cache=
_enabled)
> >  #define SLOTS_CACHE 0x1
> > @@ -149,6 +150,7 @@ static int alloc_swap_slot_cache(unsigned int cpu)
> >  		spin_lock_init(&cache->free_lock);
> >  		cache->lock_initialized =3D true;
> >  	}
> > +	INIT_WORK(&cache->async_free, swapcache_async_free_entries);
> >  	cache->nr =3D 0;
> >  	cache->cur =3D 0;
> >  	cache->n_ret =3D 0;
> > @@ -269,6 +271,20 @@ static int refill_swap_slots_cache(struct swap_slo=
ts_cache *cache)
> >  	return cache->nr;
> >  }
> > =20
> > +static void swapcache_async_free_entries(struct work_struct *data)
> > +{
> > +	struct swap_slots_cache *cache;
> > +
> > +	cache =3D container_of(data, struct swap_slots_cache, async_free);
> > +	spin_lock_irq(&cache->free_lock);
> > +	/* Swap slots cache may be deactivated before acquiring lock */
> > +	if (cache->slots_ret) {
> > +		swapcache_free_entries(cache->slots_ret, cache->n_ret);
> > +		cache->n_ret =3D 0;
> > +	}
> > +	spin_unlock_irq(&cache->free_lock);
> > +}
> > +
> >  void free_swap_slot(swp_entry_t entry)
> >  {
> >  	struct swap_slots_cache *cache;
> > @@ -282,17 +298,14 @@ void free_swap_slot(swp_entry_t entry)
> >  			goto direct_free;
> >  		}
> >  		if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> > -			/*
> > -			 * Return slots to global pool.
> > -			 * The current swap_map value is SWAP_HAS_CACHE.
> > -			 * Set it to 0 to indicate it is available for
> > -			 * allocation in global pool
> > -			 */
> > -			swapcache_free_entries(cache->slots_ret, cache->n_ret);
> > -			cache->n_ret =3D 0;
> > +			spin_unlock_irq(&cache->free_lock);
> > +			schedule_work(&cache->async_free);
> > +			goto direct_free;
> >  		}
> >  		cache->slots_ret[cache->n_ret++] =3D entry;
> >  		spin_unlock_irq(&cache->free_lock);
> > +		if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> > +			schedule_work(&cache->async_free);


I have some concerns about the current patch with the change above.
We could hit the direct_free path very often.

By delaying the freeing of entries in the return
cache, we have to do more freeing of swap entry one at a time. When
we try to free an entry, we can find the return cache still full, waiting t=
o be freed.

So we have fewer batch free of swap entries, resulting in an increase in
number of sis->lock acquisitions overall. This could have the
effect of reducing swap throughput overall when swap is under heavy
operations and sis->lock is contended.

Tim

>=20

> >  	} else {
> >  direct_free:
> >  		swapcache_free_entries(&entry, 1);
> >=20
> > ---
> > base-commit: eacce8189e28717da6f44ee492b7404c636ae0de
> > change-id: 20231216-async-free-bef392015432
> >=20
> > Best regards,
>=20


