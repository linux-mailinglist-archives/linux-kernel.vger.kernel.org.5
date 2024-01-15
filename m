Return-Path: <linux-kernel+bounces-25584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA98D82D303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 464EF1F21266
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE52615D2;
	Mon, 15 Jan 2024 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GSX4Jlbs"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B38D15B1
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705283242; x=1736819242;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=tosmSLrXCaWa9GRL69WC6iPW9H8RYSG6q69dIiSr7BE=;
  b=GSX4JlbsLytTXXQrkVUtA0t4XhP7XtciiDKx97ILDjlhCiYLb0OkWmPs
   pzwwGVvrheKgUEGS26rYrniEwcSSotN7pEwZqPZ4hqyirH3F49Uhp5WS4
   qpu98ALXHK+oQS3HUg9y0Dr/fo3R2z9VRXPNaJcyXpMeuHMW36DvmLUap
   N26iKO91whT3KVXwRGvrnq5If0JQ5J/Q66vSihZbYdhzX/S2pdW+XcyLE
   ibIE/pJRhf/y66coxJuh57vHEQQUJbZsPK3iEIuPHH9jF9P14I6nrEW1e
   lJGTB55TSS1Oft7r4ruI2Hxpdiiwp0iJlTZz1Br3pI3keF3fj9q5mYhD5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="6233077"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="6233077"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:47:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="776585349"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="776585349"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 17:47:17 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Chris
 Li <chrisl@kernel.org>,  Hugh Dickins <hughd@google.com>,  Johannes Weiner
 <hannes@cmpxchg.org>,  Matthew Wilcox <willy@infradead.org>,  Michal Hocko
 <mhocko@suse.com>,  Yosry Ahmed <yosryahmed@google.com>,  David
 Hildenbrand <david@redhat.com>,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] mm/swap: handle swapcache lookup in swapin_entry
In-Reply-To: <CAMgjq7Ce6sCSTRd==N3ihrAcvVd2ggszdZuTwxDbFYcBWzcE_g@mail.gmail.com>
	(Kairui Song's message of "Wed, 10 Jan 2024 10:53:42 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-7-ryncsn@gmail.com>
	<87a5pg9qno.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7Ce6sCSTRd==N3ihrAcvVd2ggszdZuTwxDbFYcBWzcE_g@mail.gmail.com>
Date: Mon, 15 Jan 2024 09:45:19 +0800
Message-ID: <87wmsb1ia8.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Kairui Song <ryncsn@gmail.com> writes:

> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2024=E5=B9=B41=E6=9C=888=E6=
=97=A5=E5=91=A8=E4=B8=80 16:28=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Since all callers of swapin_entry need to check the swap cache first, =
we
>> > can merge this common routine into swapin_entry, so it can be shared a=
nd
>> > optimized later.
>> >
>> > Also introduce a enum to better represent possible swap cache usage, a=
nd
>> > add some comments about it, make the usage of swap cache easier to
>> > understand.
>>
>> I don't find any benefit to do this.  The code line number isn't
>> reduced.  The concept of swap cache isn't hided either.
>
> Hi Ying
>
> Thanks for the comments.
>
> Maybe I should squash this with the following commit? The following
> commit want to do cache lookup in swapin_entry to avoid a redundant
> shadow lookup, it can help to improve the performance by about 4% for
> swapin path.

It's good to improve performance.  But I don't think we must put
swap_cache_get_folio() in swapin_entry() to do that.  We can just get
"shadow" from swap_cache_get_folio() and pass it to swapin_entry().

> So it need to return a enum to represent cache status.

I don't think we are talking about the same thing here.

> Further more, note the comments added here:
>
> +/*
> + * Caller of swapin_entry may need to know the cache lookup result:
> + *
> + * SWAP_CACHE_HIT: cache hit, cached folio is retured.
> + * SWAP_CACHE_MISS: cache miss, folio is allocated, read from swap device
> + *                  and adde to swap cache, but still may return a cached
> + *                  folio if raced (check __read_swap_cache_async).
> + * SWAP_CACHE_BYPASS: cache miss, folio is new allocated and read
> + *                    from swap device bypassing the cache.
> + */
>
> SWAP_CACHE_MISS might be inaccurate, this is not an issue introduced
> by this commit, but better exposed. May worth a fix later. So far I
> can see two benefits fixing it:
> - More accurate maj/min page fault count.
> - Note the PageHWPoison check in do_swap_page, it ignored the race
> case, if a page getting poisoned is raced with swapcache then it may
> not work as expected.
>
> These are all minor issue indeed, some other optimization might also
> be doable, but at least a comment might be helpful.
>

--
Best Regards,
Huang, Ying

