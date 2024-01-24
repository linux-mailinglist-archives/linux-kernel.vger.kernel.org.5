Return-Path: <linux-kernel+bounces-36393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3040839FFB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:15:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E8031F2B2FB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F155392;
	Wed, 24 Jan 2024 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYL2llkR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A22524C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706066128; cv=none; b=sJljNwo/ups10Qzj3ybVf6l4NubGBY0T8f33YfY/7gFyvkKVrgIQcDBBExAORnWfLUTDTZPtnXOPXoKA3a5s3Pl9/1N7qoxQ4kmY5qDZlTmrRsPSedki9nfd9Rh94jJAPiu5dUGOMZTF+aGxFlgkzCLMxmbrYJrCTSssNscgOBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706066128; c=relaxed/simple;
	bh=5JIQfkuXIc6IPaZJLDvYI4lW9FHnJAl+rx8UUzTpfbE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hfn3tSW+j6x8U4xve2AzhUoLNJEFLNtO5SO2XscBzbpUUj60SWxUpP41n+vtiYjdJMD3etVNIksnGXWCiSjyVzLJDEHQNsLTNoh78ff9sBRPaOO6udm2iYrb2DDQmSM8nux5qAxu47Cu0IRJTwqmq6MpLbk3cHXqY3AavqWwX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYL2llkR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706066127; x=1737602127;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=5JIQfkuXIc6IPaZJLDvYI4lW9FHnJAl+rx8UUzTpfbE=;
  b=WYL2llkRMqu3Ow6XDYI5Qjw8ChrBlXB89krvcOZZpx7sJbQKXMluvdNm
   yHcr6JxehCLfdrfSgf0K7WAin+gB4qGy87KWPuMVcx0EpuXZb7BcyaT5F
   LLC/J2+3QhnYoqTln5J44BEVP9iBQAZz95XM9FdUfUccHggkQJrNV193F
   K0oCipE+KLPnxgIzsubUNvAUM8MeiChIGpLFYQzrw/YSL0VpQexTTkgL4
   QFUgjZluWTHhfU9obS42IxffinsR1DKZCcUG/6MMpBj4IycPGziZERLa+
   3l3H8sItF9Ec+XVugZ9bmvLr+D5CZA3q6fnkGMZpRP5YyegFRXpqVKHRy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8840922"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="8840922"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:15:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1789059"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 19:15:22 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Nhat Pham <nphamcs@gmail.com>,  Chris Li
 <chrisl@kernel.org>,  Chengming Zhou <zhouchengming@bytedance.com>,
  linux-mm@kvack.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm: swap: update inuse_pages after all cleanups are
 done
In-Reply-To: <CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
	(Yosry Ahmed's message of "Tue, 23 Jan 2024 01:40:31 -0800")
References: <20240120024007.2850671-1-yosryahmed@google.com>
	<20240120024007.2850671-2-yosryahmed@google.com>
	<87wms0toh4.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAJD7tkb=-0mP1CXEmAd4QjMXKgep7myHShiwUSNnY1cjfRqfJA@mail.gmail.com>
Date: Wed, 24 Jan 2024 11:13:26 +0800
Message-ID: <878r4ftodl.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yosry Ahmed <yosryahmed@google.com> writes:

> On Tue, Jan 23, 2024 at 1:01=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Yosry Ahmed <yosryahmed@google.com> writes:
>>
>> > In swap_range_free(), we update inuse_pages then do some cleanups (arch
>> > invalidation, zswap invalidation, swap cache cleanups, etc). During
>> > swapoff, try_to_unuse() uses inuse_pages to make sure all swap entries
>> > are freed. Make sure we only update inuse_pages after we are done with
>> > the cleanups.
>> >
>> > In practice, this shouldn't matter, because swap_range_free() is called
>> > with the swap info lock held, and the swapoff code will spin for that
>> > lock after try_to_unuse() anyway.
>> >
>> > The goal is to make it obvious and more future proof that once
>> > try_to_unuse() returns, all cleanups are done.
>>
>> Defines "all cleanups".  Apparently, some other operations are still
>> to be done after try_to_unuse() in swap_off().
>
> I am referring to the cleanups in swap_range_free() that I mentioned abov=
e.
>
> How about s/all the cleanups/all the cleanups in swap_range_free()?

Sounds good for me.

>>
>> > This also facilitates a
>> > following zswap cleanup patch which uses this fact to simplify
>> > zswap_swapoff().
>> >
>> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>> > ---
>> >  mm/swapfile.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/mm/swapfile.c b/mm/swapfile.c
>> > index 556ff7347d5f0..2fedb148b9404 100644
>> > --- a/mm/swapfile.c
>> > +++ b/mm/swapfile.c
>> > @@ -737,8 +737,6 @@ static void swap_range_free(struct swap_info_struc=
t *si, unsigned long offset,
>> >               if (was_full && (si->flags & SWP_WRITEOK))
>> >                       add_to_avail_list(si);
>> >       }
>> > -     atomic_long_add(nr_entries, &nr_swap_pages);
>> > -     WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>> >       if (si->flags & SWP_BLKDEV)
>> >               swap_slot_free_notify =3D
>> >                       si->bdev->bd_disk->fops->swap_slot_free_notify;
>> > @@ -752,6 +750,8 @@ static void swap_range_free(struct swap_info_struc=
t *si, unsigned long offset,
>> >               offset++;
>> >       }
>> >       clear_shadow_from_swap_cache(si->type, begin, end);
>> > +     atomic_long_add(nr_entries, &nr_swap_pages);
>> > +     WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>>
>> This isn't enough.  You need to use smp_wmb() here and smp_rmb() in
>> somewhere reading si->inuse_pages.
>
> Hmm, good point. Although as I mentioned in the commit message, this
> shouldn't matter today as swap_range_free() executes with the lock
> held, and we spin on the lock after try_to_unuse() returns.

Yes.  IIUC, this patch isn't needed too because we have spinlock already.

> It may still be more future-proof to add the memory barriers.

Yes.  Without memory barriers, moving code doesn't guarantee memory
order.

> In swap_range_free, we want to make sure that the write to
> si->inuse_pages in swap_range_free() happens *after* the cleanups
> (specifically zswap_invalidate() in this case).
> In swap_off, we want to make sure that the cleanups following
> try_to_unuse() (e.g. zswap_swapoff) happen *after* reading
> si->inuse_pages =3D=3D 0 in try_to_unuse().
>
> So I think we want smp_wmb() in swap_range_free() and smp_mb() in
> try_to_unuse(). Does the below look correct to you?
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 2fedb148b9404..a2fa2f65a8ddd 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -750,6 +750,12 @@ static void swap_range_free(struct
> swap_info_struct *si, unsigned long offset,
>                 offset++;
>         }
>         clear_shadow_from_swap_cache(si->type, begin, end);
> +
> +       /*
> +        * Make sure that try_to_unuse() observes si->inuse_pages reachin=
g 0
> +        * only after the above cleanups are done.
> +        */
> +       smp_wmb();
>         atomic_long_add(nr_entries, &nr_swap_pages);
>         WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);
>  }
> @@ -2130,6 +2136,11 @@ static int try_to_unuse(unsigned int type)
>                 return -EINTR;
>         }
>
> +       /*
> +        * Make sure that further cleanups after try_to_unuse() returns h=
appen
> +        * after swap_range_free() reduces si->inuse_pages to 0.
> +        */
> +       smp_mb();
>         return 0;
>  }

We need to take care of "si->inuse_pages" checking at the beginning of
try_to_unuse() too.  Otherwise, it looks good to me.

> Alternatively, we may just hold the spinlock in try_to_unuse() when we
> check si->inuse_pages at the end. This will also ensure that any calls
> to swap_range_free() have completed. Let me know what you prefer.

Personally, I prefer memory barriers here.

--
Best Regards,
Huang, Ying

