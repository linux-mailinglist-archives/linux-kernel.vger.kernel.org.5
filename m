Return-Path: <linux-kernel+bounces-70494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A52285989B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C87CB1F211D6
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8356F06C;
	Sun, 18 Feb 2024 18:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCh5qrWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 417C61E87F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708281438; cv=none; b=dgmEo1utIS3I3ebLqHlbN1etySPGeg6amJEQbCrlwiYHfscLhO8nAoxhqZ6bEql3YFYvGyuSCCvzns5G/dJf9cPT0E4cryPMR6h3hL72YZkmq6/O8k1QZp0jV1t/gGdI96vYYkXCvlmKOOh/917Wysko8S3A3bC8GyIKXCnbPfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708281438; c=relaxed/simple;
	bh=avXJgoEJCe9mxWv/f7Hz3oObHvGvHLsq1pSi10T5wPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rj7deWN9eXXOgqiASH8F36FzR9DLSUUChfcuSXRQFIozTL8NlTKWO3bcKAvyNNGn1F5muKNpTs0z4lWjDCaZaJ+kNTL5VbrIj2ZzCiI57vEgS3Y7QOR39zVqY6v4zNKeiokISFoXuCLeNPmrzcDRUJwn1oTuyoRsEUMUZ29nR0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCh5qrWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3544C43399
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708281437;
	bh=avXJgoEJCe9mxWv/f7Hz3oObHvGvHLsq1pSi10T5wPY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=iCh5qrWXtIH4R6UKEcN/ERAvyL0TKhxpDz+34j5ftmtCkHsjFi76Dm4JDZG6lbyfv
	 3Yfc+5VjvAqpUO7CZ8NkLFlfpgglhpiC4OMR3tDg+Auod02B/20/w4bQEu4DES27NX
	 ccbWuG6K1l/YI756X5smXkjiXf2qicEEFjzdcMUuP2ORYp8asMyLRMxF/4zhgdelQp
	 f009Vgf1pqkLfzqCsm6pkjjyc/bXK4YcbIsMNsligsUQ8Dx8sz3gvOTH5tle/34g9X
	 IfepQNx3QVBB/84k8Q9HW/ACHfpPFN+63vqRm0tMJ6IZyqRRez8Dcr/0kt4VpcGha2
	 F2r5b1Vz0127Q==
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c7476a11e0so33057039f.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:37:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU6gzjFmSxr/l2ux1yQieV4gqOiYqbh1C2cBPgusFeaEXtIOPr26aGYljSqNcIf/BKzzLwepGLGNAM6viRSfSrknJtfO4oixwd2EALs
X-Gm-Message-State: AOJu0Yz/vC9pNndKbRJS0e/6Q/Ru0fbun7aO/hMJHxBEOeE8qMEiERm6
	edNzqi6jvl+QBtsaBCmJ4UG2rx5N5rdbpPPZgWWUybw6e/+L9+y/Qno+tCM7+mBjmnIC/5Gu37l
	1oQqAEQ5QY09iwbwFPi3moTOCj1ecKffoyFsD
X-Google-Smtp-Source: AGHT+IFPkHmWeH9mHJ3CxuXj/PnFJU1gwfRSDIcSamShkS2OZXHLItiD2SvdIicEJrhAh+37W2Er3pGicGV+OwM0Uus=
X-Received: by 2002:a92:d989:0:b0:365:1459:e1ed with SMTP id
 r9-20020a92d989000000b003651459e1edmr6017618iln.4.1708281436980; Sun, 18 Feb
 2024 10:37:16 -0800 (PST)
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
From: Chris Li <chrisl@kernel.org>
Date: Sun, 18 Feb 2024 10:37:02 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO6_htZWF5zsTH-CKUzmhMDbLm9bn39XOkXDo7xEccW+g@mail.gmail.com>
Message-ID: <CAF8kJuO6_htZWF5zsTH-CKUzmhMDbLm9bn39XOkXDo7xEccW+g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Barry Song <21cnbao@gmail.com>, David Hildenbrand <david@redhat.com>, 
	Kairui Song <kasong@tencent.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 18, 2024 at 12:41=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
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

I am trying to find the alternative path which can cause the swap
fault to bring in the swap cache in page fault while the SYNC IO is
looping for HAS_SWAP_CACHE. Kairui was able to identify the in the
current code in do_page_fault() path, the rmap and fork case wouldn't
be able to modify the swap cache causing a problem. The MADV_WILLNEED
is an excellent example. Thank you for finding this example.

> >
> > This seems fine.
> >
> > if swapcache has data from WILLNEED, the new page fault will hit it. Th=
us,
> > we won't go into the SYNC_IO path any more?
>
> They may happen in parallel.  That is, one task is busy looping, while
> another task read the swap entry into swap cache.

Agree.

Chris

