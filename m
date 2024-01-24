Return-Path: <linux-kernel+bounces-36400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC5CA83A014
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF36F1C290EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C44B63AA;
	Wed, 24 Jan 2024 03:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kCoUQYNO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3CA1381
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066997; cv=none; b=ZkvdEsp8+2tLMDB12qrxvTyipeCoSq0a0WP/3PgwxKovIyD7gZU2Yc4lctH6L9qLrU6YkSRgFoSkkCamyBVC/HrEldejBNgmd3lQGlhL0RR7Wo6lJQHu3iWfz8sv8nf///H78SxbaIJS75GxGvJ8BMEBz4MkVySgO73os+3gBmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066997; c=relaxed/simple;
	bh=rSaAlk94pMBR8JXrSQ+PW4+MqsgT6LSmV+ZN3ZU7qKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ld5eQ6lWkcQBlgazvD3eOXU1uLK38oh51YAUkv6SIFjKt0s1NjPiiU7g8adsyEy6RxsCL7axU67cf6qGS9DQd88i8NiQodq6glEg6QBLkiAynOqPW5h35N6PwA1OIk17obm89DSgjpgZ+VzeOdBaGRJS64+Kb4AwNzGEcgQ6qqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kCoUQYNO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706066996; x=1737602996;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=rSaAlk94pMBR8JXrSQ+PW4+MqsgT6LSmV+ZN3ZU7qKo=;
  b=kCoUQYNOgStJgcYAzeOXLu3UGUS1EdqI+wssLpIfy6ixlKum6rsIfgep
   Zsa52R7cTQosKkLMDSJUL2xtgbrYuzF4FEGryO0H8k2TIPEzpIp7d5cXk
   cyIRIafKrDX50icJoqvGS/YTQ3hKUGUvKjkpOfwSRQld3EyuQ47aBFtgQ
   WIzvqcxrhGu22g5gW3zlhkS0aV+Q+5VR1J+kK/2AwTUlQ+l1U2PBNjtfP
   ORxQqd0xuQuUmUNf/AgtN0oyEKtFNK9gCMtcP89rhiNfATMxiJ03Uzk+L
   A6j6kuvcOodC88ESYQLxvKMZaMWhFfneW65TYJKGt4pX7cvn048AW4Ch0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1614996"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1614996"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:29:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="28251243"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:29:53 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Nhat Pham <nphamcs@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Chengming Zhou <zhouchengming@bytedance.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are
 done
In-Reply-To: <CAJD7tkbKxfuy-uWrOMVnOeDpx-TuJwosxk2jG_0Gx4bi1tUBog@mail.gmail.com>
	(Yosry Ahmed's message of "Tue, 23 Jan 2024 19:20:17 -0800")
References: <20240120024007.2850671-1-yosryahmed@google.com>
	<20240120024007.2850671-2-yosryahmed@google.com>
	<87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
	<878r4ftodl.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAJD7tkbKxfuy-uWrOMVnOeDpx-TuJwosxk2jG_0Gx4bi1tUBog@mail.gmail.com>
Date: Wed, 24 Jan 2024 11:27:56 +0800
Message-ID: <874jf3tnpf.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Yosry Ahmed <yosryahmed@google.com> writes:

>> > In swap_range_free, we want to make sure that the write to
>> > si->inuse_pages in swap_range_free() happens *after* the cleanups
>> > (specifically zswap_invalidate() in this case).
>> > In swap_off, we want to make sure that the cleanups following
>> > try_to_unuse() (e.g. zswap_swapoff) happen *after* reading
>> > si->inuse_pages == 0 in try_to_unuse().
>> >
>> > So I think we want smp_wmb() in swap_range_free() and smp_mb() in
>> > try_to_unuse(). Does the below look correct to you?
>> >
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 2fedb148b9404..a2fa2f65a8ddd 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -750,6 +750,12 @@ static void swap_range_free(struct
>> > swap_info_struct *si, unsigned long offset,
>> >                 offset++;
>> >         }
>> >         clear_shadow_from_swap_cache(si->type, begin, end);
>> > +
>> > +       /*
>> > +        * Make sure that try_to_unuse() observes si->inuse_pages reaching 0
>> > +        * only after the above cleanups are done.
>> > +        */
>> > +       smp_wmb();
>> >         atomic_long_add(nr_entries, &nr_swap_pages);
>> >         WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>> >  }
>> > @@ -2130,6 +2136,11 @@ static int try_to_unuse(unsigned int type)
>> >                 return -EINTR;
>> >         }
>> >
>> > +       /*
>> > +        * Make sure that further cleanups after try_to_unuse() returns happen
>> > +        * after swap_range_free() reduces si->inuse_pages to 0.
>> > +        */
>> > +       smp_mb();
>> >         return 0;
>> >  }
>>
>> We need to take care of "si->inuse_pages" checking at the beginning of
>> try_to_unuse() too.  Otherwise, it looks good to me.
>
> Hmm, why isn't one barrier at the end of the function enough? I think
> all we need is that before we return from try_to_unuse(), all the
> cleanups in swap_range_free() are taken care of, which the barrier at
> the end should be doing. We just want instructions after
> try_to_unuse() to not get re-ordered before si->inuse_pages is read as
> 0, right?

Because at the begin of try_to_unuse() as below, after reading, function
returns directly without any memory barriers.

  if (!READ_ONCE(si->inuse_pages))
        return 0;

--
Best Regards,
Huang, Ying

