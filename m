Return-Path: <linux-kernel+bounces-70670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04A5859AE9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 188772817A8
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E23FF4;
	Mon, 19 Feb 2024 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bzLQpkpL"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098DB2103;
	Mon, 19 Feb 2024 03:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708312220; cv=none; b=UKwTtqigHg2AAMsZFGeEuvChOxb2ob7GZuKyxoKXTekuri8i0W45if8MjoV9pu8k/AWJ9wJRVBRCT3DdW0KELysQc+GF7y6BxvhMFbV2fF8oB3PESKAioq1uUgxck1rd3/hPcYOz4SviIyn5H+wmi+uemHVPs4bbx0r+EtD5x28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708312220; c=relaxed/simple;
	bh=vHGy/5iizTblx9c71wOca8ydjyG2ycIVofaO4XacMGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cq91eO/HUv7RVSGv6bbYOuUeZOo2/xM+dZ41RI5psGDj1p/h+KGS2WmoqdxZSFFYg42GLeqlQRnCgZiDYDZYH8B3yhMM7PgnOUelGgEp4ariaYHSBgyGcRV+6UyUVQjf5njbxSPJWxABe4Vlw3mJPNJ5eGbv0kynGEYOU9xkCJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bzLQpkpL; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d1094b549cso57691271fa.3;
        Sun, 18 Feb 2024 19:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708312216; x=1708917016; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xeqhTfKf3+27PA2TjmaJvKhx4MTodoOtzntu6kefSAY=;
        b=bzLQpkpLZZXyf+8w6UhwRbmYeOztrK68yVpxGNfAe1SnKRZnj5BwQceJfIsHcy7+Y2
         ABhzw1zxyv2b2QWbmIm2L9wTb5mBmpTtuxcMTlFlt/n/9DgYjmEDvST5CBrWN/xoz9VC
         ECQ6AcafxxZGnZhLmWrzxwqxkBwJ6vJs9EQ+zugC8VkFLrFXQcm/ASCcOfxLxgIL7Qkm
         lSyvakp4jIeTJ+qjOoaj55NIdrMLLhd1QcuvzqE/pEJ1ajWnhLpNIVnOelQjXWXIhRdz
         g9lXlk2WmcvKsiQRcMedywebnJxXZYuGWnZDMFm3Xwlt1q4WP+sG6ae/PR+hVDnpvBL/
         kauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708312216; x=1708917016;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xeqhTfKf3+27PA2TjmaJvKhx4MTodoOtzntu6kefSAY=;
        b=MA71WDtze9S5UF+r5EI+qASJ/vI+sB1imd4Gd6WjTfndftYn1ARwS5z9oo2OsgaM5E
         fpglwyTh7l/PUAoOBB4GG8tXzgUhgD6KsslumxtV9/ftH8PBjpDJFJux7LeMaLYpHkOW
         mDnrxp8SsVqYZWrqvp9p57caKsjrZMszVUDu9x4E0sClT7k1Gnv7CWWYUYH9m3FWCYN9
         xVCvHdDssE/egxSvMMuwYrXLp0b77wB2gYWiCFmSOl1dUo35mEwZ6D6NDfTCF1GKERx7
         svW37KxbCeNcrzH1qAm5Z8XrO3aRS2Qyn61CUWE6AbxmR7WiWJsA7SSb5tnb7MNa4+1C
         nLLw==
X-Forwarded-Encrypted: i=1; AJvYcCUDYncSMK0y3nUgSTB0NaMbxr0PVLwEx7D8hCgImRdGO0F9fzm5Wa4/eB5/+teIxFKGvEVb8xWJMcWDIy9CnoeY/6Gpm/DjJKQOh/DNPDMUf7//8DjWTJEd0/OUYLg+BntHlOyl
X-Gm-Message-State: AOJu0Yy0Uw7lho2LKOnUraw6dXBTjkIeUDlWiZ62eHMrYdSKoxY70UnX
	5iZqLjeIEJMNvPev0/itPbJcIWTgZHHeoaSw5fWHCzMuLGoJn1XkkpMFHgvoVe8DdOq4tNvyeux
	7ZX80CkDkNQmRQ+0HR9AGnrMzF4g=
X-Google-Smtp-Source: AGHT+IFMri5xaTNIC9eRRWGfpO+Cn0mEcLRlM4XjhbWHOrUI/sR7GMROAiiCw1Cu3ajRUW/b8KUK+VnS4MMasI10aQo=
X-Received: by 2002:a2e:8699:0:b0:2d2:20eb:dad8 with SMTP id
 l25-20020a2e8699000000b002d220ebdad8mr3910630lji.33.1708312215948; Sun, 18
 Feb 2024 19:10:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7CArJDbEev3YR2OB4aZjE9n6PzuzC6WLmsxCKhwq-jb3Q@mail.gmail.com>
 <87jzn1s2xe.fsf@yhuang6-desk2.ccr.corp.intel.com> <87frxprxm8.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frxprxm8.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Feb 2024 11:09:58 +0800
Message-ID: <CAMgjq7C4UmRgrqycrM=Na18+ONeFT57_Nr6b2jhbKb=7f10YMA@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 10:35=E2=80=AFAM Huang, Ying <ying.huang@intel.com>=
 wrote:
> "Huang, Ying" <ying.huang@intel.com> writes:
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> >> On Sun, Feb 18, 2024 at 4:34=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> >>>
> >>> Kairui Song <ryncsn@gmail.com> writes:
> >>>
> >>> > From: Kairui Song <kasong@tencent.com>
> >>> >
> >>> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more thre=
ads
> >>> > swapin the same entry at the same time, they get different pages (A=
, B).
> >>> > Before one thread (T0) finishes the swapin and installs page (A)
> >>> > to the PTE, another thread (T1) could finish swapin of page (B),
> >>> > swap_free the entry, then swap out the possibly modified page
> >>> > reusing the same entry. It breaks the pte_same check in (T0) becaus=
e
> >>> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> >>> > install a stalled page (A) into the PTE and cause data corruption.
> >>> >
> >>> > One possible callstack is like this:
> >>> >
> >>> > CPU0                                 CPU1
> >>> > ----                                 ----
> >>> > do_swap_page()                       do_swap_page() with same entry
> >>> > <direct swapin path>                 <direct swapin path>
> >>> > <alloc page A>                       <alloc page B>
> >>> > swap_read_folio() <- read to page A  swap_read_folio() <- read to p=
age B
> >>> > <slow on later locks or interrupt>   <finished swapin first>
> >>> > ...                                  set_pte_at()
> >>> >                                      swap_free() <- entry is free
> >>> >                                      <write to page B, now page A s=
talled>
> >>> >                                      <swap out page B to same swap =
entry>
> >>> > pte_same() <- Check pass, PTE seems
> >>> >               unchanged, but page A
> >>> >               is stalled!
> >>> > swap_free() <- page B content lost!
> >>> > set_pte_at() <- staled page A installed!
> >>> >
> >>> > And besides, for ZRAM, swap_free() allows the swap device to discar=
d
> >>> > the entry content, so even if page (B) is not modified, if
> >>> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >>> > it may also cause data loss.
> >>> >
> >>> > To fix this, reuse swapcache_prepare which will pin the swap entry =
using
> >>> > the cache flag, and allow only one thread to pin it. Release the pi=
n
> >>> > after PT unlocked. Racers will simply wait since it's a rare and ve=
ry
> >>> > short event. A schedule() call is added to avoid wasting too much C=
PU
> >>> > or adding too much noise to perf statistics
> >>> >
> >>> > Other methods like increasing the swap count don't seem to be a goo=
d
> >>> > idea after some tests, that will cause racers to fall back to use t=
he
> >>> > swap cache again. Parallel swapin using different methods leads to
> >>> > a much more complex scenario.
> >>>
> >>> The swap entry may be put in swap cache by some parallel code path
> >>> anyway.  So, we always need to consider that when reasoning the code.
> >>>
> >>> > Reproducer:
> >>> >
> >>> > This race issue can be triggered easily using a well constructed
> >>> > reproducer and patched brd (with a delay in read path) [1]:
> >>> >
> >>> > With latest 6.8 mainline, race caused data loss can be observed eas=
ily:
> >>> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >>> >   Polulating 32MB of memory region...
> >>> >   Keep swapping out...
> >>> >   Starting round 0...
> >>> >   Spawning 65536 workers...
> >>> >   32746 workers spawned, wait for done...
> >>> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss=
!
> >>> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data los=
s!
> >>> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data los=
s!
> >>> >   Round 0 Failed, 15 data loss!
> >>> >
> >>> > This reproducer spawns multiple threads sharing the same memory reg=
ion
> >>> > using a small swap device. Every two threads updates mapped pages o=
ne by
> >>> > one in opposite direction trying to create a race, with one dedicat=
ed
> >>> > thread keep swapping out the data out using madvise.
> >>> >
> >>> > The reproducer created a reproduce rate of about once every 5 minut=
es,
> >>> > so the race should be totally possible in production.
> >>> >
> >>> > After this patch, I ran the reproducer for over a few hundred round=
s
> >>> > and no data loss observed.
> >>> >
> >>> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >>> > zram:
> >>> >
> >>> > Before:     10934698 us
> >>> > After:      11157121 us
> >>> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >>> >
> >>> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchr=
onous device")
> >>> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-s=
tress-race [1]
> >>> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >>> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk=
2.ccr.corp.intel.com/
> >>> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >>> > Cc: stable@vger.kernel.org
> >>> >
> >>> > ---
> >>> > Update from V2:
> >>> > - Add a schedule() if raced to prevent repeated page faults wasting=
 CPU
> >>> >   and add noise to perf statistics.
> >>> > - Use a bool to state the special case instead of reusing existing
> >>> >   variables fixing error handling [Minchan Kim].
> >>> >
> >>> > V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail=
com/
> >>> >
> >>> > Update from V1:
> >>> > - Add some words on ZRAM case, it will discard swap content on swap=
_free so the race window is a bit different but cure is the same. [Barry So=
ng]
> >>> > - Update comments make it cleaner [Huang, Ying]
> >>> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJa=
e Park]
> >>> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_I=
O instead of "direct swapin path" [Yu Zhao]
> >>> > - Update commit message.
> >>> > - Collect Review and Acks.
> >>> >
> >>> > V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.=
com/
> >>> >
> >>> >  include/linux/swap.h |  5 +++++
> >>> >  mm/memory.c          | 20 ++++++++++++++++++++
> >>> >  mm/swap.h            |  5 +++++
> >>> >  mm/swapfile.c        | 13 +++++++++++++
> >>> >  4 files changed, 43 insertions(+)
> >>> >
> >>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >>> > index 4db00ddad261..8d28f6091a32 100644
> >>> > --- a/include/linux/swap.h
> >>> > +++ b/include/linux/swap.h
> >>> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t s=
wp)
> >>> >       return 0;
> >>> >  }
> >>> >
> >>> > +static inline int swapcache_prepare(swp_entry_t swp)
> >>> > +{
> >>> > +     return 0;
> >>> > +}
> >>> > +
> >>> >  static inline void swap_free(swp_entry_t swp)
> >>> >  {
> >>> >  }
> >>> > diff --git a/mm/memory.c b/mm/memory.c
> >>> > index 7e1f4849463a..7059230d0a54 100644
> >>> > --- a/mm/memory.c
> >>> > +++ b/mm/memory.c
> >>> > @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>> >       struct page *page;
> >>> >       struct swap_info_struct *si =3D NULL;
> >>> >       rmap_t rmap_flags =3D RMAP_NONE;
> >>> > +     bool need_clear_cache =3D false;
> >>> >       bool exclusive =3D false;
> >>> >       swp_entry_t entry;
> >>> >       pte_t pte;
> >>> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf=
)
> >>> >       if (!folio) {
> >>> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>> >                   __swap_count(entry) =3D=3D 1) {
> >>> > +                     /*
> >>> > +                      * Prevent parallel swapin from proceeding wi=
th
> >>> > +                      * the cache flag. Otherwise, another thread =
may
> >>> > +                      * finish swapin first, free the entry, and s=
wapout
> >>> > +                      * reusing the same entry. It's undetectable =
as
> >>> > +                      * pte_same() returns true due to entry reuse=
.
> >>> > +                      */
> >>> > +                     if (swapcache_prepare(entry)) {
> >>> > +                             /* Relax a bit to prevent rapid repea=
ted page faults */
> >>> > +                             schedule();
> >>>
> >>> The current task may be chosen in schedule().  So, I think that we
> >>> should use cond_resched() here.
> >>>
> >>
> >> I think if we are worried about current task got chosen again we can
> >> use schedule_timeout_uninterruptible(1) here. Isn't cond_resched still
> >> __schedule() and and it can even get omitted, so it should be "weaker"
> >> IIUC.
> >
> > schedule_timeout_uninterruptible(1) will introduce 1ms latency for the
> > second task.  That may kill performance of some workloads.

It actually calls schedule_timeout so it should be a 1 jiffy latency,
not 1ms, right?

/**
 * schedule_timeout - sleep until timeout
 * @timeout: timeout value in jiffies
..

But I think what we really want here is actually the set_current_state
to force yield CPU for a short period. The latency should be mild.

>
> Just found that the cond_sched() in __read_swap_cache_async() has been
> changed to schedule_timeout_uninterruptible(1) to fix some live lock.
> Details are in the description of commit 029c4628b2eb ("mm: swap: get
> rid of livelock in swapin readahead").  I think the similar issue may
> happen here too.  So, we must use schedule_timeout_uninterruptible(1)
> here until some other better idea becomes available.

Indeed, I'll switch to schedule_timeout_uninterruptible(1). I've
tested and posted the result with schedule_timeout_uninterruptible(1)
before, it looked fine, or even better.

