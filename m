Return-Path: <linux-kernel+bounces-70300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F7A8595C5
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519B7282B94
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467D107A0;
	Sun, 18 Feb 2024 08:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WfvAONnO"
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E9510A0D;
	Sun, 18 Feb 2024 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708246068; cv=none; b=mQ+D4reyRWdeBfSToPSTqDB4en7cnAMN8FemjKAnK9cs+Ap53wP2/wLXcsMCae8UBRUdYYNrQQ/eg0CUCvPWGh3gH4AeEoD0luqCSJeIzOnY67M/5aUjZXa055ICNA8quWR4GIByQg1j1YP/6pSxbNTarLRuYf/oK8DYrDlxsjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708246068; c=relaxed/simple;
	bh=NycQlVDdIcbfxECYPQ46rO09iBw6PNCpFGHVyaYhKeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bV8zxEeJK0zXeODoPmC78JY08w+F34hREuy4kRBfgPoBILY8fCouwd0rxU0HhT7XuiZaZPgTvvi4KqB/FBjyR3X7+9QLy54ogwDv72c/LISl7mH2w9yHw1T2tCAtdyZnMlFfRAcxVfmLQe4oF3mhPHUSOKVmw3VdkfS4Z4LRGEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WfvAONnO; arc=none smtp.client-ip=209.85.222.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f51.google.com with SMTP id a1e0cc1a2514c-7ce55932330so830531241.0;
        Sun, 18 Feb 2024 00:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708246065; x=1708850865; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/7T2nx6oZUjpUFHsGhN7Ae4dG7JkTyBoY76YpD2+I8=;
        b=WfvAONnOLVnioKgZWs1bmrjD0VbyvESWAcFwuhIx616L2ktm4FuYFYIYiqTerABXao
         dAIPUVkP6bTVB/nvRtD8KOdfy8odr9Bl0YmHEF4h5NyZCd/xU1oLKZczUmS6M2OToX7A
         dV3bds98jgTM+5XNvdVBsZqQH1MDGFKEDdwJXzQQ9Pgf6uDloo5Xehc2XEd5twikEZxf
         sULKcJ3ImV1AzP4w4D3bnGl6AWFZSISyRe7rEYQg16dLffEjjaiNPWO1t90ok8n/gbGy
         wOnzioMjsfG+zV6JvijgjDJTqgw0UXsYGmGWKgCY56Z+zHgjaH29BlxMxWUYj8UUx+dA
         s4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708246065; x=1708850865;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0/7T2nx6oZUjpUFHsGhN7Ae4dG7JkTyBoY76YpD2+I8=;
        b=Bhd7wEf0XU1KewDWdDUT7cMymXP0+0juBLZ9/MLCJztSReDDbSBg2dstGTuRDKUkDn
         LI0rnyUvT4QO5+YQyHQ0g/1vZtx44k6fFdAntDwxcp7c5c0THbR48iB4Y3eaZygvQfco
         IGgXKgfgJOQL8jSS8nFst6eL5/R8fKFB13rctSdTujgCrssaWIOmdyqGGVY0DZaBo9xf
         A7O1eFuL5gD60r3AFuGaSQSzMO3AgCf0Zc/CmR6+dc1bJ/LxNSNf0L3BiRbSeKr3HaQ2
         Ot69Iq9YLvVyDsOxaDU3Xr43jyHGFCC1XVEABIqijqcL+rdiLjUXL3nePbevmxvp5oc4
         //ew==
X-Forwarded-Encrypted: i=1; AJvYcCX6X+Fo4C5bggeKnHrnXXar9N5XHBlcB2tkDPo5+E+MzIxv/SdqaK7M6hFbNzhOZCWuyRe3Pb/+eJfHV/5bH9U6MqXAr0anT61jVcZKLtw2g1871dtUidwB5C+qJFyU24/CrLi5
X-Gm-Message-State: AOJu0YwJITTs11Tze7micElKNoplZ4ZAbTdIjB1trRTF2NKoTk8/Z3di
	b8qRm1OdOzg/VDYd+Ivq3B+uFeL7IR37jfWSbu7dwt2gMYJvFPb4W1nkrFvnGw5rWmW3fyfHXuy
	bJDRJMQNy0uZ+80kbEQte1h2hUEI=
X-Google-Smtp-Source: AGHT+IGqECaSUMs3U/4nc/297HJHsHCjtxib2n7LTRT3ZrmKc2e9v9QdhTJ5S5ABZgl8zKkrUso2DMP8RLQ0+kzDz+s=
X-Received: by 2002:a1f:4a45:0:b0:4c7:6d00:767a with SMTP id
 x66-20020a1f4a45000000b004c76d00767amr1696139vka.14.1708246065060; Sun, 18
 Feb 2024 00:47:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
 <871q9atd6o.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAGsJ_4y6u0MgfpwSoqa38wKiD5Vko=PbKAGrH_xPdChebgeOqQ@mail.gmail.com>
 <87sf1qrwsw.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf1qrwsw.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 18 Feb 2024 21:47:33 +1300
Message-ID: <CAGsJ_4yJj_SBrgRvNA7UjVEHFhLaA90-+aGp8GD3uj7AnR1eEA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: David Hildenbrand <david@redhat.com>, Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 9:41=E2=80=AFPM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Sun, Feb 18, 2024 at 9:02=E2=80=AFPM Huang, Ying <ying.huang@intel.c=
om> wrote:
> >>
> >> David Hildenbrand <david@redhat.com> writes:
> >>
> >> > On 16.02.24 10:51, Kairui Song wrote:
> >> >> From: Kairui Song <kasong@tencent.com>
> >> >> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more
> >> >> threads
> >> >> swapin the same entry at the same time, they get different pages (A=
, B).
> >> >> Before one thread (T0) finishes the swapin and installs page (A)
> >> >> to the PTE, another thread (T1) could finish swapin of page (B),
> >> >> swap_free the entry, then swap out the possibly modified page
> >> >> reusing the same entry. It breaks the pte_same check in (T0) becaus=
e
> >> >> PTE value is unchanged, causing ABA problem. Thread (T0) will
> >> >> install a stalled page (A) into the PTE and cause data corruption.
> >> >> One possible callstack is like this:
> >> >> CPU0                                 CPU1
> >> >> ----                                 ----
> >> >> do_swap_page()                       do_swap_page() with same entry
> >> >> <direct swapin path>                 <direct swapin path>
> >> >> <alloc page A>                       <alloc page B>
> >> >> swap_read_folio() <- read to page A  swap_read_folio() <- read to p=
age B
> >> >> <slow on later locks or interrupt>   <finished swapin first>
> >> >> ...                                  set_pte_at()
> >> >>                                       swap_free() <- entry is free
> >> >>                                       <write to page B, now page A =
stalled>
> >> >>                                       <swap out page B to same swap=
 entry>
> >> >> pte_same() <- Check pass, PTE seems
> >> >>                unchanged, but page A
> >> >>                is stalled!
> >> >> swap_free() <- page B content lost!
> >> >> set_pte_at() <- staled page A installed!
> >> >> And besides, for ZRAM, swap_free() allows the swap device to discar=
d
> >> >> the entry content, so even if page (B) is not modified, if
> >> >> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >> >> it may also cause data loss.
> >> >> To fix this, reuse swapcache_prepare which will pin the swap entry
> >> >> using
> >> >> the cache flag, and allow only one thread to pin it. Release the pi=
n
> >> >> after PT unlocked. Racers will simply wait since it's a rare and ve=
ry
> >> >> short event. A schedule() call is added to avoid wasting too much C=
PU
> >> >> or adding too much noise to perf statistics
> >> >> Other methods like increasing the swap count don't seem to be a goo=
d
> >> >> idea after some tests, that will cause racers to fall back to use t=
he
> >> >> swap cache again. Parallel swapin using different methods leads to
> >> >> a much more complex scenario.
> >> >> Reproducer:
> >> >> This race issue can be triggered easily using a well constructed
> >> >> reproducer and patched brd (with a delay in read path) [1]:
> >> >> With latest 6.8 mainline, race caused data loss can be observed
> >> >> easily:
> >> >> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >> >>    Polulating 32MB of memory region...
> >> >>    Keep swapping out...
> >> >>    Starting round 0...
> >> >>    Spawning 65536 workers...
> >> >>    32746 workers spawned, wait for done...
> >> >>    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data los=
s!
> >> >>    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data lo=
ss!
> >> >>    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data lo=
ss!
> >> >>    Round 0 Failed, 15 data loss!
> >> >> This reproducer spawns multiple threads sharing the same memory
> >> >> region
> >> >> using a small swap device. Every two threads updates mapped pages o=
ne by
> >> >> one in opposite direction trying to create a race, with one dedicat=
ed
> >> >> thread keep swapping out the data out using madvise.
> >> >> The reproducer created a reproduce rate of about once every 5
> >> >> minutes,
> >> >> so the race should be totally possible in production.
> >> >> After this patch, I ran the reproducer for over a few hundred round=
s
> >> >> and no data loss observed.
> >> >> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >> >> zram:
> >> >> Before:     10934698 us
> >> >> After:      11157121 us
> >> >> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >> >> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of
> >> >> synchronous device")
> >> >> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-s=
tress-race [1]
> >> >> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >> >> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk=
2.ccr.corp.intel.com/
> >> >> Signed-off-by: Kairui Song <kasong@tencent.com>
> >> >> Cc: stable@vger.kernel.org
> >> >> ---
> >> >> Update from V2:
> >> >> - Add a schedule() if raced to prevent repeated page faults wasting=
 CPU
> >> >>    and add noise to perf statistics.
> >> >> - Use a bool to state the special case instead of reusing existing
> >> >>    variables fixing error handling [Minchan Kim].
> >> >> V2:
> >> >> https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com=
/
> >> >> Update from V1:
> >> >> - Add some words on ZRAM case, it will discard swap content on swap=
_free so the race window is a bit different but cure is the same. [Barry So=
ng]
> >> >> - Update comments make it cleaner [Huang, Ying]
> >> >> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJa=
e Park]
> >> >> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_I=
O instead of "direct swapin path" [Yu Zhao]
> >> >> - Update commit message.
> >> >> - Collect Review and Acks.
> >> >> V1:
> >> >> https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> >> >>   include/linux/swap.h |  5 +++++
> >> >>   mm/memory.c          | 20 ++++++++++++++++++++
> >> >>   mm/swap.h            |  5 +++++
> >> >>   mm/swapfile.c        | 13 +++++++++++++
> >> >>   4 files changed, 43 insertions(+)
> >> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> >> index 4db00ddad261..8d28f6091a32 100644
> >> >> --- a/include/linux/swap.h
> >> >> +++ b/include/linux/swap.h
> >> >> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t s=
wp)
> >> >>      return 0;
> >> >>   }
> >> >>   +static inline int swapcache_prepare(swp_entry_t swp)
> >> >> +{
> >> >> +    return 0;
> >> >> +}
> >> >> +
> >> >>   static inline void swap_free(swp_entry_t swp)
> >> >>   {
> >> >>   }
> >> >> diff --git a/mm/memory.c b/mm/memory.c
> >> >> index 7e1f4849463a..7059230d0a54 100644
> >> >> --- a/mm/memory.c
> >> >> +++ b/mm/memory.c
> >> >> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >>      struct page *page;
> >> >>      struct swap_info_struct *si =3D NULL;
> >> >>      rmap_t rmap_flags =3D RMAP_NONE;
> >> >> +    bool need_clear_cache =3D false;
> >> >>      bool exclusive =3D false;
> >> >>      swp_entry_t entry;
> >> >>      pte_t pte;
> >> >> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >> >>      if (!folio) {
> >> >>              if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >> >>                  __swap_count(entry) =3D=3D 1) {
> >> >> +                    /*
> >> >> +                     * Prevent parallel swapin from proceeding wit=
h
> >> >> +                     * the cache flag. Otherwise, another thread m=
ay
> >> >> +                     * finish swapin first, free the entry, and sw=
apout
> >> >> +                     * reusing the same entry. It's undetectable a=
s
> >> >> +                     * pte_same() returns true due to entry reuse.
> >> >> +                     */
> >> >> +                    if (swapcache_prepare(entry)) {
> >> >> +                            /* Relax a bit to prevent rapid repeat=
ed page faults */
> >> >> +                            schedule();
> >> >> +                            goto out;
> >> >> +                    }
> >> >> +                    need_clear_cache =3D true;
> >> >> +
> >> >
> >> > I took a closer look at __read_swap_cache_async() and it essentially
> >> > does something similar.
> >> >
> >> > Instead of returning, it keeps retrying until it finds that
> >> > swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
> >> > freed concurrently) or it finds the entry in the swapcache.
> >> >
> >> > So if you would succeed here on a freed+reused swap entry,
> >> > __read_swap_cache_async() would simply retry.
> >> >
> >> > It spells that out:
> >> >
> >> >               /*
> >> >                * We might race against __delete_from_swap_cache(), a=
nd
> >> >                * stumble across a swap_map entry whose SWAP_HAS_CACH=
E
> >> >                * has not yet been cleared.  Or race against another
> >> >                * __read_swap_cache_async(), which has set SWAP_HAS_C=
ACHE
> >> >                * in swap_map, but not yet added its folio to swap ca=
che.
> >> >                */
> >> >
> >> > Whereby we could not race against this code here as well where we
> >> > speculatively set SWAP_HAS_CACHE and might never add something to th=
e swap
> >> > cache.
> >> >
> >> >
> >> > I'd probably avoid the wrong returns and do something even closer to
> >> > __read_swap_cache_async().
> >> >
> >> > while (true) {
> >> >       /*
> >> >        * Fake that we are trying to insert a page into the swapcache=
, to
> >> >        * serialize against concurrent threads wanting to do the same=
.
> >> >        * [more from your description]
> >> >        */
> >> >       ret =3D swapcache_prepare(entry);
> >> >       if (likely(!ret)
> >> >               /*
> >> >                * Move forward with swapin, we'll recheck if the PTE =
hasn't
> >> >                * changed later.
> >> >                */
> >> >               break;
> >> >       else if (ret !=3D -EEXIST)
> >> >               goto out;
> >>
> >> The swap entry may be kept in swap cache for long time.  For example, =
it
> >> may be read into swap cache via MADV_WILLNEED.
> >
> > This seems fine.
> >
> > if swapcache has data from WILLNEED, the new page fault will hit it. Th=
us,
> > we won't go into the SYNC_IO path any more?
>
> They may happen in parallel.  That is, one task is busy looping, while
> another task read the swap entry into swap cache.

do_swap_page isn't busy looping swapcache_prepare, if it fails, it exits,
then we have a completely new page fault. this new page fault will
lookup swapcache and find it, going into the path to set swapcache
to ptes. so the new page fault won't do swapcache_prepare any more.

>
> --
> Best Regards,
> Huang, Ying
>
> >>
> >> --
> >> Best Regards,
> >> Huang, Ying
> >>
> >> >
> >> >       /*
> >> >          * See __read_swap_cache_async(). We might either have raced=
 against
> >> >          * another thread, or the entry could have been freed and re=
used in the
> >> >        * meantime. Make sure that the PTE did not change, to detect =
freeing.
> >> >        */
> >> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> >> >                                      vmf->address, &vmf->ptl);
> >> >       if (!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))
> >> >               goto unlock;
> >> >
> >> >
> >> >       schedule();
> >> > }
> >> >
> >> >
> >> >
> >> > I was skeptical about the schedule(), but __read_swap_cache_async() =
does it
> >> > already because there is no better way to wait for the event to happ=
en.
> >> >
> >> > With something like above you would no longer depend on the speed of=
 schedule() to
> >> > determine how often you would retry the fault, which would likely ma=
ke sense.
> >> >
> >> > I do wonder about the schedule() vs. schedule_timeout_uninterruptibl=
e(), though.
> >> > No expert on that area, do you have any idea?
> >>

