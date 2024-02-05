Return-Path: <linux-kernel+bounces-53190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4965684A1DD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 19:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF8EB21CED
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747247F59;
	Mon,  5 Feb 2024 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A41V3EW4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AB947794
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707156907; cv=none; b=DKvELuydeJSVRQ1cBOfW9s94fqGxf9au4KlaECKWl78+GmiVQHPI2PwfiKLN/+BEvu5fJd0aqJQExJ4KXpjTWETBRf0BC7OIx1RvHlZ8yGM05y1TtARAd5HIlGfDfMLqPAsaMQg8YJpPTUyw+RV+ZcGSbtUASTWUjq+Yfhy9iaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707156907; c=relaxed/simple;
	bh=conKQZ6wiYv2oi5ekMEn/OIRAFGKnZQbNRkFZLGjHCQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hzqZD1WojMv3uaFKD59q/K/KLcn6T6je7VwM0Z2Usdi6sO2V+xQXGhAdJZrCi/ckofHpCnrGIx9ZALqz9mXWeDIleKQEMpy2JTi+hDEVQORss2Nm/Rgp++rOtwbRm3JEhqy6yQtswjcIbWwbll0jcTX+uLYocVSApih7MXpIdjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A41V3EW4; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707156907; x=1738692907;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=conKQZ6wiYv2oi5ekMEn/OIRAFGKnZQbNRkFZLGjHCQ=;
  b=A41V3EW49FLigU2wOo+iCfG4o3p/xNjXPlfqpXc7/kuW1X6RraE4N8Dj
   kUGv5rcX1o7GVUaZDVdwrdeBvSBJkcAz1bZRol3Pw6ezZmtm//UTwDt0q
   7q2HqVZi20FFYo7bOCQJdwre4iPpP8+CQrkqKu8SpAfNNkCWv6oh7xXU8
   Hl2yP+oCCEBj9LoFKtbUy/t3hCicOwnquyfk79CvRtJY87c17bStqJFx5
   XYAEPSMCj4lEXV9BlS2F+/weySvSwvo1J6zCjuSRUpbVWMUASkOtzrIKe
   dGC0z1I8sxk9VfXo/oUZG0TfKaG5iyltouUoY/34FFbN8y8bSntrW4ff2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="17995530"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="17995530"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5536044"
Received: from cacunnin-mobl2.amr.corp.intel.com (HELO [10.209.92.172]) ([10.209.92.172])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 10:15:05 -0800
Message-ID: <1fa1da19b0b929efec46bd02a6fc358fef1b9c42.camel@linux.intel.com>
Subject: Re: [PATCH v2] mm: swap: async free swap slot cache entries
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Andrew Morton
 <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,  Wei =?UTF-8?Q?Xu=EF=BF=BC?= <weixugc@google.com>, Yu
 =?UTF-8?Q?Zhao=EF=BF=BC?= <yuzhao@google.com>, Greg Thelen
 <gthelen@google.com>, Chun-Tse Shao <ctshao@google.com>, Suren
 =?UTF-8?Q?Baghdasaryan=EF=BF=BC?= <surenb@google.com>, Yosry
 =?UTF-8?Q?Ahmed=EF=BF=BC?= <yosryahmed@google.com>,  Brain Geffon
 <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, Michal Hocko
 <mhocko@suse.com>, Mel Gorman <mgorman@techsingularity.net>, Nhat Pham
 <nphamcs@gmail.com>, Johannes Weiner <hannes@cmpxchg.org>, Kairui Song
 <kasong@tencent.com>, Zhongkun He <hezhongkun.hzk@bytedance.com>, Kemeng
 Shi <shikemeng@huaweicloud.com>,  Barry Song <v-songbaohua@oppo.com>
Date: Mon, 05 Feb 2024 10:15:04 -0800
In-Reply-To: <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
References: <20240131-async-free-v2-1-525f03e07184@kernel.org>
	 <87sf2ceoks.fsf@yhuang6-desk2.ccr.corp.intel.com>
	 <7f19b4d69ff20efe8260a174c7866b4819532b1f.camel@linux.intel.com>
	 <CAF8kJuNvB8gXv3kj2nkN5j2ny0ZjJoVEdkeDDWSuWxySkKE=1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-03 at 10:12 -0800, Chris Li wrote:
>=20
> > > >  {
> > > >     struct swap_slots_cache *cache;
> > > > @@ -282,17 +298,14 @@ void free_swap_slot(swp_entry_t entry)
> > > >                     goto direct_free;
> > > >             }
> > > >             if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE) {
> > > > -                   /*
> > > > -                    * Return slots to global pool.
> > > > -                    * The current swap_map value is SWAP_HAS_CACHE=
.
> > > > -                    * Set it to 0 to indicate it is available for
> > > > -                    * allocation in global pool
> > > > -                    */
> > > > -                   swapcache_free_entries(cache->slots_ret, cache-=
>n_ret);
> > > > -                   cache->n_ret =3D 0;
> > > > +                   spin_unlock_irq(&cache->free_lock);
> > > > +                   schedule_work(&cache->async_free);
> > > > +                   goto direct_free;
> > > >             }
> > > >             cache->slots_ret[cache->n_ret++] =3D entry;
> > > >             spin_unlock_irq(&cache->free_lock);
> > > > +           if (cache->n_ret >=3D SWAP_SLOTS_CACHE_SIZE)
> > > > +                   schedule_work(&cache->async_free);
> >=20
> >=20
> > I have some concerns about the current patch with the change above.
> > We could hit the direct_free path very often.
> >=20
> > By delaying the freeing of entries in the return
> > cache, we have to do more freeing of swap entry one at a time. When
> > we try to free an entry, we can find the return cache still full, waiti=
ng to be freed.
>=20
> You are describing the async free is not working. In that case it will al=
ways
> hit the direct free path one by one.
>=20
> >=20
> > So we have fewer batch free of swap entries, resulting in an increase i=
n
> > number of sis->lock acquisitions overall. This could have the
> > effect of reducing swap throughput overall when swap is under heavy
> > operations and sis->lock is contended.
>=20
> I  can change the direct free path to free all entries. If the async
> free hasn't freed up the batch by the time the next swap fault comes in.
> The new swap fault will take the hit, just free the whole batch. It will =
behave
> closer to the original batch free behavior in this path.
>=20
Will that negate the benefit you are looking for?

A hack is to double the SWAP_SLOTS_CACHE_SIZE to 128, and trigger the
background reclaim when entries reach 64. This will allow you to avoid
the one by one relcaim direct path and hopefully the delayed job
would have done its job when slots accumulate between 64 and 128.

However, I am unsure how well this hack is under really heavy
swap load.  It means that the background reclaim will need to=C2=A0
work through a larger backlog and
hold the sis->lock longer. So if you hit the direct path while
the background reclaim is underway, you may have longer tail latency
to acquire the sis->lock.=20

Tim


