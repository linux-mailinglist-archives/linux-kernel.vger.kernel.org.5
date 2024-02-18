Return-Path: <linux-kernel+bounces-70289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 299328595A0
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:29:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EF328366B
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:29:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB008FBEA;
	Sun, 18 Feb 2024 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaCjUeKz"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4905F4F5;
	Sun, 18 Feb 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244966; cv=none; b=rJxbB678f7x00ndg2u/Uxdrj4iZ6O7T6p1gTf/qDA6RTLtpnPg3g6qcldCzisEUcQW43HwnyCIGBsM54sJopzhrMG9DpQrRR79dS9AoHB96QBWrGus6cWskXjgvFXZCDQ7UqDFZUsfRW49NvZy11VMeYj94uOPcSYijNxJ22K7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244966; c=relaxed/simple;
	bh=6YMJp8PypyjJmZ09GPGferZj4OOYlonnkodg4/8mJTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kuQWZ+EFQAwh9to6iGtOMdvEYRCEeKOXUOachJHdRCDoe+ptuv388OAoGMml6ZqvbuPXSgvNHj1M6vczRNLxmHeBSn5CY5XNdU9rzZyGMER8HxmLWzjs23+rOynftgt3hPpzaiMbB6f6DIFxdGYLQkbhco8gFxarZmOmPznq4mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaCjUeKz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d23796e337so2030741fa.1;
        Sun, 18 Feb 2024 00:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708244963; x=1708849763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJvVjgUHEApAXx3wmFfFplZJiO5FJ60uaM75kGCFIoM=;
        b=KaCjUeKz1NHVDofIGWvrUWF+OyYU8Lk81A+CwCHizq6VJqMDHOuVJrRIpXIi0P//f3
         lwrJMR3C1+dT+LOrgJZsrMLS1VRYVequ82/DCcn317wcWytz01cTNz+EtcDwEwNxMgFO
         EFoeBgpbhdq6J2j3f0IwqLTe3xUD9XF5t9f7et6UPxjLeiisNrrq5kDyeFLHMhLrZEGV
         3HV9ZxU6/e62CW/tCW+Enihuo7ttHyTQy7i9KdFYWDMSmbeakrB65HrXqqWyON1At6zo
         GPmlGxVXCo2vmLyLGC+v112tUcihGRxGVET1P6zpP0IUz/R9rnJgmIPbQsfUnVb3VbTH
         QYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708244963; x=1708849763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xJvVjgUHEApAXx3wmFfFplZJiO5FJ60uaM75kGCFIoM=;
        b=KlXvxBrL9Iq2cH/AJnIpasAohlY/ER9UtocTotMKRJeW1szOrONiTC3YnNtcdsAGGf
         9xW+miTv/8sTl5/IFOPv89xzCw8UHFKMez1deKajkEof9Y5thPY8vcczVqHTbRVRqwZQ
         diKWshx20Vo7yVzDF5yh57EaOmTu734q/Qn/MH3F/q4eFK/l0OlBntSKKCxFvDhlbhRl
         9L3kFjawHeUZR4ciIf8Ji49mNNexeZXseM46Xd0TBIy3VYvSbEVMXtH5/iZAQKolbYfJ
         EI3/xFwaezMhpVzzhEP71SoS93szpSsj3qVTlwQZHxQfGg1Wm4xRTB2EnY9FPq8FkVyM
         f0wg==
X-Forwarded-Encrypted: i=1; AJvYcCWLyvbzJxXlRzVYkahxh6CkN+rYPUoNSgNz4CqafSqfGkS0rWmCwZQtP/f7WBU0oOu0j0xpYrE15G2cpWsfmjbgvTT38YuekswKuOTprJfcCQUcgjmBmbkpADT3+/t/nXgFEw83
X-Gm-Message-State: AOJu0YxCXMhlgQnU/BcjgSChiB1R3q2BxqkT3i/QW27QGRVaO1sEUX0f
	Opl1XF+pPAN/rWWCx6KfZrp/Cr65qhNPkR0iWr7NIDJ7UzK+QGIlkN/W//fbIG7SZzswPdbk58a
	k6BHCVSEmZTifJMDbpOiVB+Ad+uU=
X-Google-Smtp-Source: AGHT+IGoZqEWqHcKlFC4NWamuZG0d+9tEJrxjiQMNJa+2wO0tsIYpiLOgDMjpSukc8qJwRVXjMUSnTsNu9x5l/bQ14E=
X-Received: by 2002:a2e:9898:0:b0:2d0:8bfa:56b8 with SMTP id
 b24-20020a2e9898000000b002d08bfa56b8mr5919195ljj.48.1708244962392; Sun, 18
 Feb 2024 00:29:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <c2f3a1d0-30cf-4680-83bd-08f5d8a54deb@redhat.com>
 <fca46c3d-1a4f-411c-b60b-b6978b127bc5@redhat.com>
In-Reply-To: <fca46c3d-1a4f-411c-b60b-b6978b127bc5@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Sun, 18 Feb 2024 16:29:04 +0800
Message-ID: <CAMgjq7BWOGhHPgBHAbYUpdTj8Rm89SVSQTiG0wksSoUi42afxw@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 2:02=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
> On 16.02.24 17:53, David Hildenbrand wrote:
> > On 16.02.24 10:51, Kairui Song wrote:
> >> From: Kairui Song <kasong@tencent.com>
> >>
> >> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> >> swapin the same entry at the same time, they get different pages (A, B=
).
> >> Before one thread (T0) finishes the swapin and installs page (A)
> >> to the PTE, another thread (T1) could finish swapin of page (B),
> >> swap_free the entry, then swap out the possibly modified page
> >> reusing the same entry. It breaks the pte_same check in (T0) because
> >> PTE value is unchanged, causing ABA problem. Thread (T0) will
> >> install a stalled page (A) into the PTE and cause data corruption.
> >>
> >> One possible callstack is like this:
> >>
> >> CPU0                                 CPU1
> >> ----                                 ----
> >> do_swap_page()                       do_swap_page() with same entry
> >> <direct swapin path>                 <direct swapin path>
> >> <alloc page A>                       <alloc page B>
> >> swap_read_folio() <- read to page A  swap_read_folio() <- read to page=
 B
> >> <slow on later locks or interrupt>   <finished swapin first>
> >> ...                                  set_pte_at()
> >>                                        swap_free() <- entry is free
> >>                                        <write to page B, now page A st=
alled>
> >>                                        <swap out page B to same swap e=
ntry>
> >> pte_same() <- Check pass, PTE seems
> >>                 unchanged, but page A
> >>                 is stalled!
> >> swap_free() <- page B content lost!
> >> set_pte_at() <- staled page A installed!
> >>
> >> And besides, for ZRAM, swap_free() allows the swap device to discard
> >> the entry content, so even if page (B) is not modified, if
> >> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >> it may also cause data loss.
> >>
> >> To fix this, reuse swapcache_prepare which will pin the swap entry usi=
ng
> >> the cache flag, and allow only one thread to pin it. Release the pin
> >> after PT unlocked. Racers will simply wait since it's a rare and very
> >> short event. A schedule() call is added to avoid wasting too much CPU
> >> or adding too much noise to perf statistics
> >>
> >> Other methods like increasing the swap count don't seem to be a good
> >> idea after some tests, that will cause racers to fall back to use the
> >> swap cache again. Parallel swapin using different methods leads to
> >> a much more complex scenario.
> >>
> >> Reproducer:
> >>
> >> This race issue can be triggered easily using a well constructed
> >> reproducer and patched brd (with a delay in read path) [1]:
> >>
> >> With latest 6.8 mainline, race caused data loss can be observed easily=
:
> >> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >>     Polulating 32MB of memory region...
> >>     Keep swapping out...
> >>     Starting round 0...
> >>     Spawning 65536 workers...
> >>     32746 workers spawned, wait for done...
> >>     Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >>     Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss=
!
> >>     Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss=
!
> >>     Round 0 Failed, 15 data loss!
> >>
> >> This reproducer spawns multiple threads sharing the same memory region
> >> using a small swap device. Every two threads updates mapped pages one =
by
> >> one in opposite direction trying to create a race, with one dedicated
> >> thread keep swapping out the data out using madvise.
> >>
> >> The reproducer created a reproduce rate of about once every 5 minutes,
> >> so the race should be totally possible in production.
> >>
> >> After this patch, I ran the reproducer for over a few hundred rounds
> >> and no data loss observed.
> >>
> >> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >> zram:
> >>
> >> Before:     10934698 us
> >> After:      11157121 us
> >> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >>
> >> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchrono=
us device")
> >> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stre=
ss-race [1]
> >> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.c=
cr.corp.intel.com/
> >> Signed-off-by: Kairui Song <kasong@tencent.com>
> >> Cc: stable@vger.kernel.org
> >>
> >> ---
> >> Update from V2:
> >> - Add a schedule() if raced to prevent repeated page faults wasting CP=
U
> >>     and add noise to perf statistics.
> >> - Use a bool to state the special case instead of reusing existing
> >>     variables fixing error handling [Minchan Kim].
> >>
> >> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.co=
m/
> >>
> >> Update from V1:
> >> - Add some words on ZRAM case, it will discard swap content on swap_fr=
ee so the race window is a bit different but cure is the same. [Barry Song]
> >> - Update comments make it cleaner [Huang, Ying]
> >> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae P=
ark]
> >> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO i=
nstead of "direct swapin path" [Yu Zhao]
> >> - Update commit message.
> >> - Collect Review and Acks.
> >>
> >> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com=
/
> >>
> >>    include/linux/swap.h |  5 +++++
> >>    mm/memory.c          | 20 ++++++++++++++++++++
> >>    mm/swap.h            |  5 +++++
> >>    mm/swapfile.c        | 13 +++++++++++++
> >>    4 files changed, 43 insertions(+)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index 4db00ddad261..8d28f6091a32 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> >>      return 0;
> >>    }
> >>
> >> +static inline int swapcache_prepare(swp_entry_t swp)
> >> +{
> >> +    return 0;
> >> +}
> >> +
> >>    static inline void swap_free(swp_entry_t swp)
> >>    {
> >>    }
> >> diff --git a/mm/memory.c b/mm/memory.c
> >> index 7e1f4849463a..7059230d0a54 100644
> >> --- a/mm/memory.c
> >> +++ b/mm/memory.c
> >> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>      struct page *page;
> >>      struct swap_info_struct *si =3D NULL;
> >>      rmap_t rmap_flags =3D RMAP_NONE;
> >> +    bool need_clear_cache =3D false;
> >>      bool exclusive =3D false;
> >>      swp_entry_t entry;
> >>      pte_t pte;
> >> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >>      if (!folio) {
> >>              if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >>                  __swap_count(entry) =3D=3D 1) {
> >> +                    /*
> >> +                     * Prevent parallel swapin from proceeding with
> >> +                     * the cache flag. Otherwise, another thread may
> >> +                     * finish swapin first, free the entry, and swapo=
ut
> >> +                     * reusing the same entry. It's undetectable as
> >> +                     * pte_same() returns true due to entry reuse.
> >> +                     */
> >> +                    if (swapcache_prepare(entry)) {
> >> +                            /* Relax a bit to prevent rapid repeated =
page faults */
> >> +                            schedule();
> >> +                            goto out;
> >> +                    }
> >> +                    need_clear_cache =3D true;
> >> +

Hi David

Thanks for the review! I saw you added more replies so I'll just post
reply on your last mail.

> >
> > I took a closer look at __read_swap_cache_async() and it essentially
> > does something similar.
> >
> > Instead of returning, it keeps retrying until it finds that
> > swapcache_prepare() fails for another reason than -EEXISTS (e.g.,
> > freed concurrently) or it finds the entry in the swapcache.
> >
> > So if you would succeed here on a freed+reused swap entry,
> > __read_swap_cache_async() would simply retry.
> >
> > It spells that out:
> >
> >               /*
> >                * We might race against __delete_from_swap_cache(), and
> >                * stumble across a swap_map entry whose SWAP_HAS_CACHE
> >                * has not yet been cleared.  Or race against another
> >                * __read_swap_cache_async(), which has set SWAP_HAS_CACH=
E
> >                * in swap_map, but not yet added its folio to swap cache=
.
> >                */
> >
> > Whereby we could not race against this code here as well where we
> > speculatively set SWAP_HAS_CACHE and might never add something to the s=
wap
> > cache.
> >
> >
> > I'd probably avoid the wrong returns and do something even closer to
> > __read_swap_cache_async().
> >
> > while (true) {
> >       /*
> >        * Fake that we are trying to insert a page into the swapcache, t=
o
> >        * serialize against concurrent threads wanting to do the same.
> >        * [more from your description]
> >        */
> >       ret =3D swapcache_prepare(entry);
> >       if (likely(!ret)
> >               /*
> >                * Move forward with swapin, we'll recheck if the PTE has=
n't
> >                * changed later.
> >                */
> >               break;
> >       else if (ret !=3D -EEXIST)
> >               goto out;
> >
> >       /*
> >            * See __read_swap_cache_async(). We might either have raced =
against
> >            * another thread, or the entry could have been freed and reu=
sed in the
> >        * meantime. Make sure that the PTE did not change, to detect fre=
eing.
> >        */
> >       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> >                                      vmf->address, &vmf->ptl);
> >       if (!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte))
> >               goto unlock;
> >
> >
> >       schedule();
> > }

It was discussed earlier about looping in the page fault. One issue is
about swap entry may stuck in swapcache for a long time, so at lease
an extra cache loop up is need. To be safe we need to implement a
similar loop like the one in mm/swap_state.c, which I doubt is
necessary...

> >
> > I was skeptical about the schedule(), but __read_swap_cache_async() doe=
s it
> > already because there is no better way to wait for the event to happen.
> >
> > With something like above you would no longer depend on the speed of sc=
hedule() to
> > determine how often you would retry the fault, which would likely make =
sense.
> >
> > I do wonder about the schedule() vs. schedule_timeout_uninterruptible()=
, though.
> > No expert on that area, do you have any idea?
> >

schedule_timeout_uninterruptible seems more reasonable here from its
name (delay a bit to wait). My idea here is that SWP_SYNCHRONOUS_IO
devices are supposed to be super fast, so usually a second try will
just work (when tested with a less stressed test case and that seems
to be always true), and the race itself is rare enough to be ignore
for 7 years.

But when system is really stressed (eg. the reproducer I provided), it
may take longer to finish (SWP_SYNCHRONOUS_IO devices are CPU bound).
So a schedule() can help to avoid one task from looping page fault,
for better statistic and CPU usage.

Previous test results:
https://lore.kernel.org/lkml/CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMGde4=
Ov=3DgA@mail.gmail.com/
It showed schedule() works fine here.

