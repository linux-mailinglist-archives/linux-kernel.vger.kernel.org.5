Return-Path: <linux-kernel+bounces-57491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8984D9C2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885AD1C22CED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1DA67C76;
	Thu,  8 Feb 2024 06:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPEZXKSl"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E05367C6D;
	Thu,  8 Feb 2024 06:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707372317; cv=none; b=aTEF4A5TFd0/4h4E5o/MsmD1cU/ltKCN4xOSjUnNHnJoSZ2hMfI5H/uaXz75WAQg1CuNLmBVcP0SyjW7LXPE0xZl3FBwO+5aoDXSMGQVTpYbWYycBZ+vHYcbD+Z8ZBN4w4VCHzaNAe3TnuGpK2wEEgzlvpQkrm0DXSxt+xm4hp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707372317; c=relaxed/simple;
	bh=n8B7XwnDMznlgJFPgGe8e0KCjII6DKTeS34YMGFq8sM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RUnLrbceJxwa/b2QqEQLThwcjrcfule80EuZaUnam796LfhcKVNdFhEs7q8f/UsGzZkDF0X6ZMPpFXAk+8ADC2gHBeyImkCEL1H6WjRLJeTNxjvg+Lgwb5aa7zfziRdnfzyqIXZvP3JhqAd267UXWeC4VSlYC1U1olUiL/9pkiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPEZXKSl; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d07ffa0a9cso13798791fa.2;
        Wed, 07 Feb 2024 22:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707372313; x=1707977113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bz4+FfHyCP6BBKdQ7cOOlMvE98ccARnG+JyeIo2PFwg=;
        b=GPEZXKSlTIeyNEnShIU+uW0E2kXXD5pZRLZfmD1gRgZEEmilUcIchyGpVSWsGPM6Ho
         JfYu7Bza1ph0wOhnnHClS4Oq8e7/wxyLZlivty+KU3N8cLdSHJ20q1hLIcv4sxzmhNUH
         9qPvNucTOAs92dQNq0ojrBpa5fd13JYYc/r5Nxd7SJAAKkqHrfxUaAseDjvUn0d2GTsj
         09x3M61RUzuPEYppzxy/OgUlR2A85fcacchyEUhLTIrQ5MBBjtl3r2NKVFgBG/6yGKAJ
         re3GAkFG+ALoBM8p1LWKx2f+HWeSqyQ2AthXNWQyBzUlf3FsrClyd4FFoMcfX0pMqlPv
         ib4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707372313; x=1707977113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bz4+FfHyCP6BBKdQ7cOOlMvE98ccARnG+JyeIo2PFwg=;
        b=sFphhvKMXwB5t4QfSCH6NmooCxldPYR6ExeWLDh6Gzxs6ZBVenJhvUuuOtN5vvAXg5
         e4a/65NBkg1OJ48/Tee4+hWYVU1hEHa5yy0iPogZuWQJelqHRCqQVEqBPx86GPT/p/g8
         8y4Kp8mucxPbbQG7Becgzw3Rzrc+/1GDOXS25g+ohB6Hwlc4cZoaURO6N9nfwLUsOF8e
         t8w2+MYGVDc+L/wvWkYpKufwTxoEomDf+UMG0fHZ49ARQ1jrQYN6t+4aNV17+yzoR0Cy
         AEV5fqccDjLDo35t4/WKCIC4lsEad5REHj3REFuOXPVDMpRLeQVEYYveLEkfbdPRQzkl
         SU1w==
X-Gm-Message-State: AOJu0Yya7CDhZfmS32D0NYjEeazMGOLfxI8MqVFJaKohH4txDGBS1Ycx
	m9A5mV8QJyLUg88DL4yOYbY4E1k36wJ/QCErOdgN27Rv4T9S/a26+iTuqkR7G/FfD3tbxtG1AsI
	EVVgPDp/SJV7AO4YY4nwtlgniCUw=
X-Google-Smtp-Source: AGHT+IFZu8gPirxAzRWk7AVavJh11h6U+IK5vZrMhokGFrAaJleUdQiMZFoBvJANYdry6eZGw5DE7gxkQEQ281NpUJc=
X-Received: by 2002:a2e:b0f0:0:b0:2d0:aa89:a34d with SMTP id
 h16-20020a2eb0f0000000b002d0aa89a34dmr5157530ljl.11.1707372312698; Wed, 07
 Feb 2024 22:05:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com>
 <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com> <ZcPMi6DX5PN4WwHr@google.com>
In-Reply-To: <ZcPMi6DX5PN4WwHr@google.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 8 Feb 2024 14:04:54 +0800
Message-ID: <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Minchan Kim <minchan@kernel.org>
Cc: Chris Li <chrisl@kernel.org>, Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.org> wro=
te:
>
> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> > On Wed, Feb 7, 2024 at 12:02=E2=80=AFPM Chris Li <chrisl@kernel.org> wr=
ote:
> > >
> > > On Tue, Feb 6, 2024 at 6:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > > >
> > > > On Wed, Feb 7, 2024 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.org=
> wrote:
> > > > >
> > > > > On Tue, Feb 6, 2024 at 4:43=E2=80=AFPM Barry Song <21cnbao@gmail.=
com> wrote:
> > > > > >
> > > > > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.=
org> wrote:
> > > > > > >
> > > > > > > Hi Kairui,
> > > > > > >
> > > > > > > Sorry replying to your patch V1 late, I will reply on the V2 =
thread.
> > > > > > >
> > > > > > > On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@g=
mail.com> wrote:
> > > > > > > >
> > > > > > > > From: Kairui Song <kasong@tencent.com>
> > > > > > > >
> > > > > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or m=
ore threads
> > > > > > > > swapin the same entry at the same time, they get different =
pages (A, B).
> > > > > > > > Before one thread (T0) finishes the swapin and installs pag=
e (A)
> > > > > > > > to the PTE, another thread (T1) could finish swapin of page=
 (B),
> > > > > > > > swap_free the entry, then swap out the possibly modified pa=
ge
> > > > > > > > reusing the same entry. It breaks the pte_same check in (T0=
) because
> > > > > > > > PTE value is unchanged, causing ABA problem. Thread (T0) wi=
ll
> > > > > > > > install a stalled page (A) into the PTE and cause data corr=
uption.
> > > > > > > >
> > > > > > > > One possible callstack is like this:
> > > > > > > >
> > > > > > > > CPU0                                 CPU1
> > > > > > > > ----                                 ----
> > > > > > > > do_swap_page()                       do_swap_page() with sa=
me entry
> > > > > > > > <direct swapin path>                 <direct swapin path>
> > > > > > > > <alloc page A>                       <alloc page B>
> > > > > > > > swap_read_folio() <- read to page A  swap_read_folio() <- r=
ead to page B
> > > > > > > > <slow on later locks or interrupt>   <finished swapin first=
>
> > > > > > > > ...                                  set_pte_at()
> > > > > > > >                                      swap_free() <- entry i=
s free
> > > > > > > >                                      <write to page B, now =
page A stalled>
> > > > > > > >                                      <swap out page B to sa=
me swap entry>
> > > > > > > > pte_same() <- Check pass, PTE seems
> > > > > > > >               unchanged, but page A
> > > > > > > >               is stalled!
> > > > > > > > swap_free() <- page B content lost!
> > > > > > > > set_pte_at() <- staled page A installed!
> > > > > > > >
> > > > > > > > And besides, for ZRAM, swap_free() allows the swap device t=
o discard
> > > > > > > > the entry content, so even if page (B) is not modified, if
> > > > > > > > swap_read_folio() on CPU0 happens later than swap_free() on=
 CPU1,
> > > > > > > > it may also cause data loss.
> > > > > > > >
> > > > > > > > To fix this, reuse swapcache_prepare which will pin the swa=
p entry using
> > > > > > > > the cache flag, and allow only one thread to pin it. Releas=
e the pin
> > > > > > > > after PT unlocked. Racers will simply busy wait since it's =
a rare
> > > > > > > > and very short event.
> > > > > > > >
> > > > > > > > Other methods like increasing the swap count don't seem to =
be a good
> > > > > > > > idea after some tests, that will cause racers to fall back =
to use the
> > > > > > > > swap cache again. Parallel swapin using different methods l=
eads to
> > > > > > > > a much more complex scenario.
> > > > > > > >
> > > > > > > > Reproducer:
> > > > > > > >
> > > > > > > > This race issue can be triggered easily using a well constr=
ucted
> > > > > > > > reproducer and patched brd (with a delay in read path) [1]:
> > > > > > > >
> > > > > > > > With latest 6.8 mainline, race caused data loss can be obse=
rved easily:
> > > > > > > > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > > > > > > >   Polulating 32MB of memory region...
> > > > > > > >   Keep swapping out...
> > > > > > > >   Starting round 0...
> > > > > > > >   Spawning 65536 workers...
> > > > > > > >   32746 workers spawned, wait for done...
> > > > > > > >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 d=
ata loss!
> > > > > > > >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 =
data loss!
> > > > > > > >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 =
data loss!
> > > > > > > >   Round 0 Failed, 15 data loss!
> > > > > > > >
> > > > > > > > This reproducer spawns multiple threads sharing the same me=
mory region
> > > > > > > > using a small swap device. Every two threads updates mapped=
 pages one by
> > > > > > > > one in opposite direction trying to create a race, with one=
 dedicated
> > > > > > > > thread keep swapping out the data out using madvise.
> > > > > > > >
> > > > > > > > The reproducer created a reproduce rate of about once every=
 5 minutes,
> > > > > > > > so the race should be totally possible in production.
> > > > > > > >
> > > > > > > > After this patch, I ran the reproducer for over a few hundr=
ed rounds
> > > > > > > > and no data loss observed.
> > > > > > > >
> > > > > > > > Performance overhead is minimal, microbenchmark swapin 10G =
from 32G
> > > > > > > > zram:
> > > > > > > >
> > > > > > > > Before:     10934698 us
> > > > > > > > After:      11157121 us
> > > > > > > > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > > > > > > >
> > > > > > > > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin o=
f synchronous device")
> > > > > > > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhua=
ng6-desk2.ccr.corp.intel.com/
> > > > > > > > Link: https://github.com/ryncsn/emm-test-project/tree/maste=
r/swap-stress-race [1]
> > > > > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > > > > Acked-by: Yu Zhao <yuzhao@google.com>
> > > > > > > >
> > > > > > > > ---
> > > > > > > > Update from V1:
> > > > > > > > - Add some words on ZRAM case, it will discard swap content=
 on swap_free so the race window is a bit different but cure is the same. [=
Barry Song]
> > > > > > > > - Update comments make it cleaner [Huang, Ying]
> > > > > > > > - Add a function place holder to fix CONFIG_SWAP=3Dn built =
[SeongJae Park]
> > > > > > > > - Update the commit message and summary, refer to SWP_SYNCH=
RONOUS_IO instead of "direct swapin path" [Yu Zhao]
> > > > > > > > - Update commit message.
> > > > > > > > - Collect Review and Acks.
> > > > > > > >
> > > > > > > >  include/linux/swap.h |  5 +++++
> > > > > > > >  mm/memory.c          | 15 +++++++++++++++
> > > > > > > >  mm/swap.h            |  5 +++++
> > > > > > > >  mm/swapfile.c        | 13 +++++++++++++
> > > > > > > >  4 files changed, 38 insertions(+)
> > > > > > > >
> > > > > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > > > > index 4db00ddad261..8d28f6091a32 100644
> > > > > > > > --- a/include/linux/swap.h
> > > > > > > > +++ b/include/linux/swap.h
> > > > > > > > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_e=
ntry_t swp)
> > > > > > > >         return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static inline int swapcache_prepare(swp_entry_t swp)
> > > > > > > > +{
> > > > > > > > +       return 0;
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static inline void swap_free(swp_entry_t swp)
> > > > > > > >  {
> > > > > > > >  }
> > > > > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > > > > index 7e1f4849463a..1749c700823d 100644
> > > > > > > > --- a/mm/memory.c
> > > > > > > > +++ b/mm/memory.c
> > > > > > > > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fa=
ult *vmf)
> > > > > > > >         if (!folio) {
> > > > > > > >                 if (data_race(si->flags & SWP_SYNCHRONOUS_I=
O) &&
> > > > > > > >                     __swap_count(entry) =3D=3D 1) {
> > > > > > > > +                       /*
> > > > > > > > +                        * Prevent parallel swapin from pro=
ceeding with
> > > > > > > > +                        * the cache flag. Otherwise, anoth=
er thread may
> > > > > > > > +                        * finish swapin first, free the en=
try, and swapout
> > > > > > > > +                        * reusing the same entry. It's und=
etectable as
> > > > > > > > +                        * pte_same() returns true due to e=
ntry reuse.
> > > > > > > > +                        */
> > > > > > > > +                       if (swapcache_prepare(entry))
> > > > > > > > +                               goto out;
> > > > > > > > +
> > > > > > >
> > > > > > > I am puzzled by this "goto out". If I understand this correct=
ly, you
> > > > > > > have two threads CPU1 and CPU2 racing to set the flag SWAP_HA=
S_CACHE.
> > > > > > > The CPU1 will succeed in adding the flag and  the CPU2 will g=
et
> > > > > > > "-EEXIST" from "swapcache_prepare(entry)".  Am I understandin=
g it
> > > > > > > correctly so far?
> > > > > > >
> > > > > > > Then the goto out seems wrong to me. For the CPU2, the page f=
ault will
> > > > > > > return *unhandled*. Even worse, the "-EEXIST" error is not pr=
eserved,
> > > > > > > CPU2 does not even know the page fault is not handled, it wil=
l resume
> > > > > > > from the page fault instruction, possibly generate another pa=
ge fault
> > > > > > > at the exact same location. That page fault loop will repeat =
until
> > > > > > > CPU1 install the new pte on that faulting virtual address and=
 pick up
> > > > > > > by CPU2.
> > > > > > >
> > > > > > > Am I missing something obvious there?
> > > > > >
> > > > > > I feel you are right. any concurrent page faults at the same pt=
e
> > > > > > will increase the count of page faults for a couple of times no=
w.
> > > > > >
> > > > > > >
> > > > > > > I just re-read your comment: "Racers will simply busy wait si=
nce it's
> > > > > > > a rare and very short event." That might be referring to the =
above
> > > > > > > CPU2 page fault looping situation. I consider the page fault =
looping
> > > > > > > on CPU2 not acceptable. For one it will mess up the page faul=
t
> > > > > > > statistics.
> > > > > > > In my mind, having an explicit loop for CPU2 waiting for the =
PTE to
> > > > > > > show up is still better than this page fault loop. You can ha=
ve more
> > > > > > > CPU power friendly loops.
> > > > > >
> > > > > > I assume you mean something like
> > > > > >
> > > > > > while(!pte_same())
> > > > > >    cpu_relax();
> > > > > >
> > > > > > then we still have a chance to miss the change of B.
> > > > > >
> > > > > > For example, another thread is changing pte to A->B->A, our loo=
p can
> > > > > > miss B. Thus we will trap into an infinite loop. this is even w=
orse.
> > > > >
> > > > > Yes. You are right, it is worse. Thanks for catching that. That i=
s why
> > > > > I say this needs more discussion, I haven't fully thought it thro=
ugh
> > > > > :-)
> > > >
> > > > Hi Chris and Barry,
> > > >
> > > > Thanks for the comments!
> > > >
> > > > The worst thing I know of returning in do_swap_page without handlin=
g
> > > > the swap, is an increase of some statistic counters, note it will n=
ot
> > > > cause major page fault counters to grow, only things like perf coun=
ter
> > > > and vma lock statistic are affected.
> > > >
> > > > And actually there are multiple already existing return points in
> > > > do_swap_page that will return without handling it, which may
> > > > re-trigger the page fault.
> > >
> > > Thanks for pointing that out. I take a look at those, which seems
> > > different than the case here.  In those cases, it truely can not make
> > > forward progress.
> > > Here we actually have all the data it needs to complete the page
> > > fault. Just a data synchronization issue preventing making forward
> > > progress.
> > > Ideally we can have some clever data structure to solve the
> > > synchronization issue and make forward progress.
> > >
> > > > When do_swap_page is called, many pre-checks have been applied, and
> > > > they could all be invalidated if something raced, simply looping
> > > > inside here could miss a lot of corner cases, so we have to go thro=
ugh
> > > > that again.
> > >
> > > Actually, I  think about it. Looping it here seems worse in the sense
> > > that it is already holding some locks. Return and retry the page faul=
t
> > > at least release those locks and let others have a chance to make
> > > progress.
> > >
> > > >
> > > > This patch did increase the chance of false positive increase of so=
me
> > > > counters, maybe something like returning a VM_FAULT_RETRY could mak=
e
> > > > it better, but code is more complex and will cause other counters t=
o
> > > > grow.
> > >
> > > This is certainly not ideal. It might upset the feedback loop that
> > > uses the swap fault statistic as input to adjust the swapping
> > > behavior.
> > >
> > > Chris
> >
> > Hi Chris,
> >
> > Thanks for the reply.
> >
> > So I think the thing is, it's getting complex because this patch
> > wanted to make it simple and just reuse the swap cache flags.
>
> I agree that a simple fix would be the important at this point.
>
> Considering your description, here's my understanding of the other idea:
> Other method, such as increasing the swap count, haven't proven effective
> in your tests. The approach risk forcing racers to rely on the swap cache
> again and the potential performance loss in race scenario.
>
> While I understand that simplicity is important, and performance loss
> in this case may be infrequent, I believe swap_count approach could be a
> suitable solution. What do you think?

Hi Minchan

Yes, my main concern was about simplicity and performance.

Increasing swap_count here will also race with another process from
releasing swap_count to 0 (swapcache was able to sync callers in other
call paths but we skipped swapcache here).
So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
__swap_duplicate can be modified to support this, it's similar to
existing logics for SWAP_HAS_CACHE.

And swap freeing path will do more things, swapcache clean up needs to
be handled even in the bypassing path since the racer may add it to
swapcache.

Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
overhead, so I used that way in this patch, the only issue is
potentially repeated page faults now.

I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
at naming it) special value, so any racer can just spin on it to avoid
all the problems, how do you think about this?

