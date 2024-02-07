Return-Path: <linux-kernel+bounces-55918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D084C35D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6964C1C2438C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF510979;
	Wed,  7 Feb 2024 04:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3/Ab1XB"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01615E8B;
	Wed,  7 Feb 2024 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278797; cv=none; b=fCaqSDyg2wZxdZUk2kv0WvMp7kmoEapmnjtMbEhDVUk46cQ+J5eRHdI8hjgvq594V5za07lpRhE1+tGY5i4dVfWIXxESy1woViqNgzJMUco2fWWuQmpYwga5TZo7gVpRK2YM63VX7JVAQm2i7yk4CtxLy2gk4W5yIhlpHifxPOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278797; c=relaxed/simple;
	bh=RO3peUvRPdGAouJICOWRImX9sVJjZ1mJRBMI+yfis9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrpuisHiGkPlqjxtIBzEKU2X9NfOy/rmZXQOZQg28use2C9C3Dq3fYUunrLjZKh4yUdN7MLu8vHUjqE6Dr/dfrs7sxwgPQyEPKJxAxzHAveLkezwg1KASbyneZQ4BZUKL3HcFyCyAon+MG+A+58ujf6ZFLrdfbr6xU2QvfcxSPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3/Ab1XB; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2cf1fd1cc5bso2452081fa.3;
        Tue, 06 Feb 2024 20:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707278793; x=1707883593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7hAFMIwS/BE1sRgqMaTOJ2yGZ8MaAcI4W7dcsziTmnk=;
        b=D3/Ab1XBlSczTgaSrJFS1eMjq5exAQDsSxloeTYKjbzfmE1NQJQGNvi/7o0db43nvU
         Auhh2GXvJ7kkQjpfjL3TVuqDr1vg2lg+wM1eo5eG6GfER7zc5MbXaClvZsnEYfDokbDN
         LDJ4NavUvxL4Lz1vEdJ75TBY9d6yq0d+lRrXjymdV7X4h5eEm67F+p0v7ifMH9KDoTik
         2RwAVhcupcH2T4dNp8VQGOM20OTo7id52Qh+dZHMS6C0yTuk4N8+p60px5OmHmj94nCP
         LrNljLJwe6mbZUESLgTQhqg3D3woOpCrk8LabKd9vrvOVpmCm0M4W6eucwp2diVYDcpX
         t8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707278793; x=1707883593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7hAFMIwS/BE1sRgqMaTOJ2yGZ8MaAcI4W7dcsziTmnk=;
        b=Y9YIniLDC0EjaPze//tTH5fq+1yzB34akVnjgPb/6nHXt2eQl1xbBn5YgNrNd/U0rJ
         QHRznRP/5Apgttlea6LlBQ/fibqcIjLVRMQIVWfJk7HxGFcI7gkeTdIaW3NPsFFGFckf
         0lydKOW8gpap6zSI6r9AVVVOD0eV2EwQks71Csmu1idbFikHyxHTWvndacMhjMmNyKw0
         zNYlkqHEyMTi3yqZ7maNhn3Py28iixht9tQGL49hyGRcw3eNHjB+P39oXaV3rksU+Zlz
         KDWZAqy6dDE3TEj7PICCaw3rYerj3RSzincFKrkzpvOYhWG1juBYBf71H4o8da8lNWhG
         rUFQ==
X-Gm-Message-State: AOJu0YwP8ge6ji7bkWt2uuzImGgIz+4xySV723wR2nNzoZT78YLVnljQ
	OHYhOyPmNOH2V1LXfUXf5cz5vcXC8Si3HXyNtUtPxU2UdGmMqe/B1vhiEQ34r5UAhuuTOXy28Pb
	93EDLo8J1StMPMkCJh9LouVPAdbk=
X-Google-Smtp-Source: AGHT+IFu+MfkjcRXrpWvUxo4X9gu1eQea5nu3Q5c2Ibt2IhA8b8kssE1CsgtYy/GQKlzKNDoHaXsIkQG0xQ3p/KngGE=
X-Received: by 2002:a2e:b527:0:b0:2d0:82cf:d3d1 with SMTP id
 z7-20020a2eb527000000b002d082cfd3d1mr2785493ljm.22.1707278792971; Tue, 06 Feb
 2024 20:06:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
 <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com> <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
In-Reply-To: <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 7 Feb 2024 12:06:15 +0800
Message-ID: <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Chris Li <chrisl@kernel.org>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:02=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Tue, Feb 6, 2024 at 6:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
> >
> > On Wed, Feb 7, 2024 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > On Tue, Feb 6, 2024 at 4:43=E2=80=AFPM Barry Song <21cnbao@gmail.com>=
 wrote:
> > > >
> > > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org>=
 wrote:
> > > > >
> > > > > Hi Kairui,
> > > > >
> > > > > Sorry replying to your patch V1 late, I will reply on the V2 thre=
ad.
> > > > >
> > > > > On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail=
com> wrote:
> > > > > >
> > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > >
> > > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more =
threads
> > > > > > swapin the same entry at the same time, they get different page=
s (A, B).
> > > > > > Before one thread (T0) finishes the swapin and installs page (A=
)
> > > > > > to the PTE, another thread (T1) could finish swapin of page (B)=
,
> > > > > > swap_free the entry, then swap out the possibly modified page
> > > > > > reusing the same entry. It breaks the pte_same check in (T0) be=
cause
> > > > > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > > > > install a stalled page (A) into the PTE and cause data corrupti=
on.
> > > > > >
> > > > > > One possible callstack is like this:
> > > > > >
> > > > > > CPU0                                 CPU1
> > > > > > ----                                 ----
> > > > > > do_swap_page()                       do_swap_page() with same e=
ntry
> > > > > > <direct swapin path>                 <direct swapin path>
> > > > > > <alloc page A>                       <alloc page B>
> > > > > > swap_read_folio() <- read to page A  swap_read_folio() <- read =
to page B
> > > > > > <slow on later locks or interrupt>   <finished swapin first>
> > > > > > ...                                  set_pte_at()
> > > > > >                                      swap_free() <- entry is fr=
ee
> > > > > >                                      <write to page B, now page=
 A stalled>
> > > > > >                                      <swap out page B to same s=
wap entry>
> > > > > > pte_same() <- Check pass, PTE seems
> > > > > >               unchanged, but page A
> > > > > >               is stalled!
> > > > > > swap_free() <- page B content lost!
> > > > > > set_pte_at() <- staled page A installed!
> > > > > >
> > > > > > And besides, for ZRAM, swap_free() allows the swap device to di=
scard
> > > > > > the entry content, so even if page (B) is not modified, if
> > > > > > swap_read_folio() on CPU0 happens later than swap_free() on CPU=
1,
> > > > > > it may also cause data loss.
> > > > > >
> > > > > > To fix this, reuse swapcache_prepare which will pin the swap en=
try using
> > > > > > the cache flag, and allow only one thread to pin it. Release th=
e pin
> > > > > > after PT unlocked. Racers will simply busy wait since it's a ra=
re
> > > > > > and very short event.
> > > > > >
> > > > > > Other methods like increasing the swap count don't seem to be a=
 good
> > > > > > idea after some tests, that will cause racers to fall back to u=
se the
> > > > > > swap cache again. Parallel swapin using different methods leads=
 to
> > > > > > a much more complex scenario.
> > > > > >
> > > > > > Reproducer:
> > > > > >
> > > > > > This race issue can be triggered easily using a well constructe=
d
> > > > > > reproducer and patched brd (with a delay in read path) [1]:
> > > > > >
> > > > > > With latest 6.8 mainline, race caused data loss can be observed=
 easily:
> > > > > > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > > > > >   Polulating 32MB of memory region...
> > > > > >   Keep swapping out...
> > > > > >   Starting round 0...
> > > > > >   Spawning 65536 workers...
> > > > > >   32746 workers spawned, wait for done...
> > > > > >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data =
loss!
> > > > > >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data=
 loss!
> > > > > >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data=
 loss!
> > > > > >   Round 0 Failed, 15 data loss!
> > > > > >
> > > > > > This reproducer spawns multiple threads sharing the same memory=
 region
> > > > > > using a small swap device. Every two threads updates mapped pag=
es one by
> > > > > > one in opposite direction trying to create a race, with one ded=
icated
> > > > > > thread keep swapping out the data out using madvise.
> > > > > >
> > > > > > The reproducer created a reproduce rate of about once every 5 m=
inutes,
> > > > > > so the race should be totally possible in production.
> > > > > >
> > > > > > After this patch, I ran the reproducer for over a few hundred r=
ounds
> > > > > > and no data loss observed.
> > > > > >
> > > > > > Performance overhead is minimal, microbenchmark swapin 10G from=
 32G
> > > > > > zram:
> > > > > >
> > > > > > Before:     10934698 us
> > > > > > After:      11157121 us
> > > > > > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > > > > >
> > > > > > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of sy=
nchronous device")
> > > > > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-=
desk2.ccr.corp.intel.com/
> > > > > > Link: https://github.com/ryncsn/emm-test-project/tree/master/sw=
ap-stress-race [1]
> > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > Acked-by: Yu Zhao <yuzhao@google.com>
> > > > > >
> > > > > > ---
> > > > > > Update from V1:
> > > > > > - Add some words on ZRAM case, it will discard swap content on =
swap_free so the race window is a bit different but cure is the same. [Barr=
y Song]
> > > > > > - Update comments make it cleaner [Huang, Ying]
> > > > > > - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seo=
ngJae Park]
> > > > > > - Update the commit message and summary, refer to SWP_SYNCHRONO=
US_IO instead of "direct swapin path" [Yu Zhao]
> > > > > > - Update commit message.
> > > > > > - Collect Review and Acks.
> > > > > >
> > > > > >  include/linux/swap.h |  5 +++++
> > > > > >  mm/memory.c          | 15 +++++++++++++++
> > > > > >  mm/swap.h            |  5 +++++
> > > > > >  mm/swapfile.c        | 13 +++++++++++++
> > > > > >  4 files changed, 38 insertions(+)
> > > > > >
> > > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > > index 4db00ddad261..8d28f6091a32 100644
> > > > > > --- a/include/linux/swap.h
> > > > > > +++ b/include/linux/swap.h
> > > > > > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry=
_t swp)
> > > > > >         return 0;
> > > > > >  }
> > > > > >
> > > > > > +static inline int swapcache_prepare(swp_entry_t swp)
> > > > > > +{
> > > > > > +       return 0;
> > > > > > +}
> > > > > > +
> > > > > >  static inline void swap_free(swp_entry_t swp)
> > > > > >  {
> > > > > >  }
> > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > index 7e1f4849463a..1749c700823d 100644
> > > > > > --- a/mm/memory.c
> > > > > > +++ b/mm/memory.c
> > > > > > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault =
*vmf)
> > > > > >         if (!folio) {
> > > > > >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &=
&
> > > > > >                     __swap_count(entry) =3D=3D 1) {
> > > > > > +                       /*
> > > > > > +                        * Prevent parallel swapin from proceed=
ing with
> > > > > > +                        * the cache flag. Otherwise, another t=
hread may
> > > > > > +                        * finish swapin first, free the entry,=
 and swapout
> > > > > > +                        * reusing the same entry. It's undetec=
table as
> > > > > > +                        * pte_same() returns true due to entry=
 reuse.
> > > > > > +                        */
> > > > > > +                       if (swapcache_prepare(entry))
> > > > > > +                               goto out;
> > > > > > +
> > > > >
> > > > > I am puzzled by this "goto out". If I understand this correctly, =
you
> > > > > have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CA=
CHE.
> > > > > The CPU1 will succeed in adding the flag and  the CPU2 will get
> > > > > "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> > > > > correctly so far?
> > > > >
> > > > > Then the goto out seems wrong to me. For the CPU2, the page fault=
 will
> > > > > return *unhandled*. Even worse, the "-EEXIST" error is not preser=
ved,
> > > > > CPU2 does not even know the page fault is not handled, it will re=
sume
> > > > > from the page fault instruction, possibly generate another page f=
ault
> > > > > at the exact same location. That page fault loop will repeat unti=
l
> > > > > CPU1 install the new pte on that faulting virtual address and pic=
k up
> > > > > by CPU2.
> > > > >
> > > > > Am I missing something obvious there?
> > > >
> > > > I feel you are right. any concurrent page faults at the same pte
> > > > will increase the count of page faults for a couple of times now.
> > > >
> > > > >
> > > > > I just re-read your comment: "Racers will simply busy wait since =
it's
> > > > > a rare and very short event." That might be referring to the abov=
e
> > > > > CPU2 page fault looping situation. I consider the page fault loop=
ing
> > > > > on CPU2 not acceptable. For one it will mess up the page fault
> > > > > statistics.
> > > > > In my mind, having an explicit loop for CPU2 waiting for the PTE =
to
> > > > > show up is still better than this page fault loop. You can have m=
ore
> > > > > CPU power friendly loops.
> > > >
> > > > I assume you mean something like
> > > >
> > > > while(!pte_same())
> > > >    cpu_relax();
> > > >
> > > > then we still have a chance to miss the change of B.
> > > >
> > > > For example, another thread is changing pte to A->B->A, our loop ca=
n
> > > > miss B. Thus we will trap into an infinite loop. this is even worse=
.
> > >
> > > Yes. You are right, it is worse. Thanks for catching that. That is wh=
y
> > > I say this needs more discussion, I haven't fully thought it through
> > > :-)
> >
> > Hi Chris and Barry,
> >
> > Thanks for the comments!
> >
> > The worst thing I know of returning in do_swap_page without handling
> > the swap, is an increase of some statistic counters, note it will not
> > cause major page fault counters to grow, only things like perf counter
> > and vma lock statistic are affected.
> >
> > And actually there are multiple already existing return points in
> > do_swap_page that will return without handling it, which may
> > re-trigger the page fault.
>
> Thanks for pointing that out. I take a look at those, which seems
> different than the case here.  In those cases, it truely can not make
> forward progress.
> Here we actually have all the data it needs to complete the page
> fault. Just a data synchronization issue preventing making forward
> progress.
> Ideally we can have some clever data structure to solve the
> synchronization issue and make forward progress.
>
> > When do_swap_page is called, many pre-checks have been applied, and
> > they could all be invalidated if something raced, simply looping
> > inside here could miss a lot of corner cases, so we have to go through
> > that again.
>
> Actually, I  think about it. Looping it here seems worse in the sense
> that it is already holding some locks. Return and retry the page fault
> at least release those locks and let others have a chance to make
> progress.
>
> >
> > This patch did increase the chance of false positive increase of some
> > counters, maybe something like returning a VM_FAULT_RETRY could make
> > it better, but code is more complex and will cause other counters to
> > grow.
>
> This is certainly not ideal. It might upset the feedback loop that
> uses the swap fault statistic as input to adjust the swapping
> behavior.
>
> Chris

Hi Chris,

Thanks for the reply.

So I think the thing is, it's getting complex because this patch
wanted to make it simple and just reuse the swap cache flags.

Then maybe time to introduce a new swap map value (eg. SWAP_MAP_LOCK,
not an ideal name, open to any suggestion on this...) then we can just
wait for that value to be gone, no risk of loops and repeated page
faults, just need to tidy some flag set/retrieving helpers.

