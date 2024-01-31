Return-Path: <linux-kernel+bounces-47391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C0E7844D45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7EFB1C22B63
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F07353A8CE;
	Wed, 31 Jan 2024 23:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VSG2dZct"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2943A278
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744731; cv=none; b=pKqAPksbrQAd7v2Ti0yTwoYpnb3f3PmYOddoXTX42ugcauiQAP46Epwhcpgrw6rJMVYKiXYioqqp1bw3tLbivCvfDCu21Kv8fsuSkAGrebu56ajcopVjxCor/Pe37rPW24VekVNdrY/RlNzoz+jqMTwigmtPfoDhRVfwBKX5fIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744731; c=relaxed/simple;
	bh=rgrCgSpALvr1CWsUIFrHZh9N3HtW5tFrYXTts++yW4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NZtiXgBWoaeiaU+yiQEXy/AMAG37jNuKqJ4NFfCvE7iC1zYRjKjHdjA0W1CyzCMVy4y9dk5NnG5N1cVVZ3d0jOBXGmhwWBKlTSnB1txIydfFO6RP8cBOkTu2GPuMvsngPAU3uouLq9ZFcFDjou5hPSvg8pQtK6lz3RyH4dCNDjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSG2dZct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02252C43609
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706744730;
	bh=rgrCgSpALvr1CWsUIFrHZh9N3HtW5tFrYXTts++yW4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VSG2dZctjU1VVVJzpFnw0HUzkXVWotnl9yhtM+MfzL2JzdbcQ4R8wBs+mj8dL+PqI
	 gBfwF1oeHX4rY1b7LbDFv2ZP8bI5sglrAJCHhyKrw7jQdEnsxwhAsxV9Yhw8eMKjfo
	 KqRNujtxhjW+OaU8xvR7mRjsFXES3dW7rYwSXQZ02m8SuBb6m/9epwiStAlVRad30K
	 1fbsQFaPRn5158VWH8EnXCbMvI5OuPIUowehO77vbIvKtIIuDR++UfkNiapO4w/pVB
	 dsB+Crlr+bxRjrU3wfXIvUgwgzSkTBMm2rXVw4wbz2R1nXQmyfHjiIe81ABg/J+Pn9
	 0eiTy4GZ4lDQg==
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3639b16c17bso1599435ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:45:29 -0800 (PST)
X-Gm-Message-State: AOJu0Yx7lPHTGJggCCKrAFfXSw/eqMA2jL0TnYF9bHJPjdsvBZOU+bpb
	iBcqWZ5njJRJTz0FAJ8xxRm8Xus+wpCjpUH6Rn48AmqiUXZCMv+FWrf0FFOpcq25YdkNlXFfx+x
	WxUuu7axBJkdgil4QjnAVuEbr01HMkrZrsC72
X-Google-Smtp-Source: AGHT+IHxIcPjPLgCEuO2FNMNke9aAioh5w/QeEIyl/LRy/szpWrbpAnYRI7c1RlsYBxcbDyJqlEj/OCh5XxkmjljosY=
X-Received: by 2002:a92:cf47:0:b0:363:7dc6:a156 with SMTP id
 c7-20020a92cf47000000b003637dc6a156mr3162291ilr.5.1706744729276; Wed, 31 Jan
 2024 15:45:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129175423.1987-1-ryncsn@gmail.com> <20240129175423.1987-7-ryncsn@gmail.com>
 <87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DhjeeCehzj5hiO=v+X0Jg5mEpKim3k8abJA20TN63SHA@mail.gmail.com>
In-Reply-To: <CAMgjq7DhjeeCehzj5hiO=v+X0Jg5mEpKim3k8abJA20TN63SHA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 31 Jan 2024 15:45:18 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN6G578RWQ5R6eW=FQWg3mphywgnusQYCRMJA4TzhR4jg@mail.gmail.com>
Message-ID: <CAF8kJuN6G578RWQ5R6eW=FQWg3mphywgnusQYCRMJA4TzhR4jg@mail.gmail.com>
Subject: Re: Whether is the race for SWP_SYNCHRONOUS_IO possible? (was Re:
 [PATCH v3 6/7] mm/swap, shmem: use unified swapin helper for shmem)
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org, 
	Yu Zhao <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:58=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Hi Ying,
>
> On Wed, Jan 31, 2024 at 10:53=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> >
> > Hi, Minchan,
> >
> > When I review the patchset from Kairui, I checked the code to skip swap
> > cache in do_swap_page() for swap device with SWP_SYNCHRONOUS_IO.  Is th=
e
> > following race possible?  Where a page is swapped out to a swap device
> > with SWP_SYNCHRONOUS_IO and the swap count is 1.  Then 2 threads of the
> > process runs on CPU0 and CPU1 as below.  CPU0 is running do_swap_page()=
.
>
> Chris raised a similar issue about the shmem path, and I was worrying
> about the same issue in previous discussions about do_swap_page:
> https://lore.kernel.org/linux-mm/CAMgjq7AwFiDb7cAMkWMWb3vkccie1-tocmZfT7m=
4WRb_UKPghg@mail.gmail.com/

Ha thanks for remembering that.

>
> """
> In do_swap_page path, multiple process could swapin the page at the
> same time (a mapped once page can still be shared by sub threads),
> they could get different folios. The later pte lock and pte_same check
> is not enough, because while one process is not holding the pte lock,
> another process could read-in, swap_free the entry, then swap-out the
> page again, using same entry, an ABA problem. The race is not likely
> to happen in reality but in theory possible.
> """
>
> >
> > CPU0                            CPU1
> > ----                            ----
> > swap_cache_get_folio()
> > check sync io and swap count
> > alloc folio
> > swap_readpage()
> > folio_lock_or_retry()
> >                                 swap in the swap entry
> >                                 write page
> >                                 swap out to same swap entry
> > pte_offset_map_lock()
> > check pte_same()
> > swap_free()   <-- new content lost!
> > set_pte_at()  <-- stale page!
> > folio_unlock()
> > pte_unmap_unlock()
>
> Thank you very much for highlighting this!
>
> My concern previously is the same as yours (swapping out using the
> same entry is like an ABA issue, where pte_same failed to detect the
> page table change), later when working on V3, I mistakenly thought
> that's impossible as entry should be pinned until swap_free on CPU0,
> and I'm wrong. CPU1 can also just call swap_free, then swap count is
> dropped to 0 and it can just swap out using the same entry. Now I
> think my patch 6/7 is also affected by this potential race. Seems
> nothing can stop it from doing this.
>
> Actually I was trying to make a reproducer locally, due to swap slot
> cache, swap allocation algorithm, and the short race window, this is
> very unlikely to happen though.

You can put some sleep in some of the CPU0 where expect the other race
to happen to manual help triggering it. Yes, it sounds hard to trigger
in real life due to reclaim swap out.

>
> How about we just increase the swap count temporarily in the direct
> swap in path (after alloc folio), then drop the count after pte_same
> (or shmem_add_to_page_cache in shmem path)? That seems enough to
> prevent the entry reuse issue.

Sounds like a good solution.

Chris

