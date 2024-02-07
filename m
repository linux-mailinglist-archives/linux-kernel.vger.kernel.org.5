Return-Path: <linux-kernel+bounces-55916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B7384C357
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:02:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A30ADB21E22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B50910979;
	Wed,  7 Feb 2024 04:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pmhHxR90"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6506A12E63
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707278532; cv=none; b=Lid3UAjvOXo+QAzkHfkbFL+SppiixvCnMG+8lwaMtLmxVS4BeOqBjiVFdd7my7LIQNtYXkV+6RsYVbR+BSa0hqFSN3YF4yJAxqo4+aLjv2pq/ssI6nPLSTCXRKt6AMqdVXPASlPv06FXNCLeBPIEKDxZM4co+b3pvxQRHNW1RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707278532; c=relaxed/simple;
	bh=8GkdIka54FzA2d79OAmIF6BdL2EAh+pvwbeiutSEMWE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uilwt+WEahUmhf22O+hmYCKeDeZgcPDRYLZ/GsjNpvJJE8buzxoRFxnEutY82nCety7fSuib4fWUNghLaXUO9cw/93xjP6+hdcc04nR/dcRa6AZjheZWJW84+pvNeIoeEtVf6wE0GI++JI7y4cX5EXKfdlG3d5lRkVfY5WndqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pmhHxR90; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFC2EC4166C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707278531;
	bh=8GkdIka54FzA2d79OAmIF6BdL2EAh+pvwbeiutSEMWE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pmhHxR904zeXoJ4MqdzRUshVfCkIvjJJA73A7Ipod16gelvl/kWpPTWglCgIS3mp+
	 pc9W8C9nYOAJhW9F0M+TMEXhnQrKvyM6t5C3xWbmFys4ADyXQDLEIrSp50LURYxYG1
	 x8RbZD9jsea0JSOs04eyaw41LKlpEAJVn2H06bzw+/Ru+KeYYjp6cNxBVPEVahdGuA
	 koB4R9f18qcau0M90Xkv+r1wU1DXCBlIRqCdA+7376vax6321vzWhDyqEDFOEK7IEU
	 CxUicHlSZrzTyUdIge8EdODZ9N1rQTRFDP+9TQR3DS3DgUagCc04CsD76wbMhV0qF2
	 +xE/79rWAdYpg==
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-363cd34bf13so496515ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 20:02:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXYC8P7c3emswFs2+Pkh4K9Km5yyu0sOorRAaPdrWF8PbgdNmOuD7pH43MmsjzONDCFGpLGVq1uWi1AP3NSBTN7bCo1bFaJM8s/9mNv
X-Gm-Message-State: AOJu0YwFPlAMmphkKhmVLo3+GNiNNkcM86tgj8sfBD86OwRyUtM4awkP
	TRl+vXJnHjF0dW5hMFVAuLrpjlnBr0RxlCTaweT+PvtWHNJ4biLhfZgaKlhKqHy+obmt/FACzPy
	wFCXfrL3EQUzUoAlp84Pt5MbhtEI1uPcIJys+
X-Google-Smtp-Source: AGHT+IG6gCkxwceoM7lPN+1DlL7ZFoLgE56EJYYl9XsQ+/gwTPK/LQH6zvBsOpsCSJXoMbL0WzP2FE3zGn1uuV9w05Q=
X-Received: by 2002:a92:b751:0:b0:363:b686:5b6e with SMTP id
 c17-20020a92b751000000b00363b6865b6emr4317763ilm.27.1707278531037; Tue, 06
 Feb 2024 20:02:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <CAF8kJuOBtT+n5CM2s1Mobk5fzpgetCSMTZ-nb8+0KUj1W5f+Mw@mail.gmail.com> <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
In-Reply-To: <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 6 Feb 2024 20:01:58 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
Message-ID: <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 6, 2024 at 6:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Wed, Feb 7, 2024 at 10:03=E2=80=AFAM Chris Li <chrisl@kernel.org> wrot=
e:
> >
> > On Tue, Feb 6, 2024 at 4:43=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> > >
> > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > > >
> > > > Hi Kairui,
> > > >
> > > > Sorry replying to your patch V1 late, I will reply on the V2 thread=
.
> > > >
> > > > On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
> > > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more th=
reads
> > > > > swapin the same entry at the same time, they get different pages =
(A, B).
> > > > > Before one thread (T0) finishes the swapin and installs page (A)
> > > > > to the PTE, another thread (T1) could finish swapin of page (B),
> > > > > swap_free the entry, then swap out the possibly modified page
> > > > > reusing the same entry. It breaks the pte_same check in (T0) beca=
use
> > > > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > > > install a stalled page (A) into the PTE and cause data corruption=
.
> > > > >
> > > > > One possible callstack is like this:
> > > > >
> > > > > CPU0                                 CPU1
> > > > > ----                                 ----
> > > > > do_swap_page()                       do_swap_page() with same ent=
ry
> > > > > <direct swapin path>                 <direct swapin path>
> > > > > <alloc page A>                       <alloc page B>
> > > > > swap_read_folio() <- read to page A  swap_read_folio() <- read to=
 page B
> > > > > <slow on later locks or interrupt>   <finished swapin first>
> > > > > ...                                  set_pte_at()
> > > > >                                      swap_free() <- entry is free
> > > > >                                      <write to page B, now page A=
 stalled>
> > > > >                                      <swap out page B to same swa=
p entry>
> > > > > pte_same() <- Check pass, PTE seems
> > > > >               unchanged, but page A
> > > > >               is stalled!
> > > > > swap_free() <- page B content lost!
> > > > > set_pte_at() <- staled page A installed!
> > > > >
> > > > > And besides, for ZRAM, swap_free() allows the swap device to disc=
ard
> > > > > the entry content, so even if page (B) is not modified, if
> > > > > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > > > > it may also cause data loss.
> > > > >
> > > > > To fix this, reuse swapcache_prepare which will pin the swap entr=
y using
> > > > > the cache flag, and allow only one thread to pin it. Release the =
pin
> > > > > after PT unlocked. Racers will simply busy wait since it's a rare
> > > > > and very short event.
> > > > >
> > > > > Other methods like increasing the swap count don't seem to be a g=
ood
> > > > > idea after some tests, that will cause racers to fall back to use=
 the
> > > > > swap cache again. Parallel swapin using different methods leads t=
o
> > > > > a much more complex scenario.
> > > > >
> > > > > Reproducer:
> > > > >
> > > > > This race issue can be triggered easily using a well constructed
> > > > > reproducer and patched brd (with a delay in read path) [1]:
> > > > >
> > > > > With latest 6.8 mainline, race caused data loss can be observed e=
asily:
> > > > > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > > > >   Polulating 32MB of memory region...
> > > > >   Keep swapping out...
> > > > >   Starting round 0...
> > > > >   Spawning 65536 workers...
> > > > >   32746 workers spawned, wait for done...
> > > > >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data lo=
ss!
> > > > >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data l=
oss!
> > > > >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data l=
oss!
> > > > >   Round 0 Failed, 15 data loss!
> > > > >
> > > > > This reproducer spawns multiple threads sharing the same memory r=
egion
> > > > > using a small swap device. Every two threads updates mapped pages=
 one by
> > > > > one in opposite direction trying to create a race, with one dedic=
ated
> > > > > thread keep swapping out the data out using madvise.
> > > > >
> > > > > The reproducer created a reproduce rate of about once every 5 min=
utes,
> > > > > so the race should be totally possible in production.
> > > > >
> > > > > After this patch, I ran the reproducer for over a few hundred rou=
nds
> > > > > and no data loss observed.
> > > > >
> > > > > Performance overhead is minimal, microbenchmark swapin 10G from 3=
2G
> > > > > zram:
> > > > >
> > > > > Before:     10934698 us
> > > > > After:      11157121 us
> > > > > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > > > >
> > > > > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of sync=
hronous device")
> > > > > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-de=
sk2.ccr.corp.intel.com/
> > > > > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap=
-stress-race [1]
> > > > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > > > Acked-by: Yu Zhao <yuzhao@google.com>
> > > > >
> > > > > ---
> > > > > Update from V1:
> > > > > - Add some words on ZRAM case, it will discard swap content on sw=
ap_free so the race window is a bit different but cure is the same. [Barry =
Song]
> > > > > - Update comments make it cleaner [Huang, Ying]
> > > > > - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seong=
Jae Park]
> > > > > - Update the commit message and summary, refer to SWP_SYNCHRONOUS=
_IO instead of "direct swapin path" [Yu Zhao]
> > > > > - Update commit message.
> > > > > - Collect Review and Acks.
> > > > >
> > > > >  include/linux/swap.h |  5 +++++
> > > > >  mm/memory.c          | 15 +++++++++++++++
> > > > >  mm/swap.h            |  5 +++++
> > > > >  mm/swapfile.c        | 13 +++++++++++++
> > > > >  4 files changed, 38 insertions(+)
> > > > >
> > > > > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > > > > index 4db00ddad261..8d28f6091a32 100644
> > > > > --- a/include/linux/swap.h
> > > > > +++ b/include/linux/swap.h
> > > > > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t=
 swp)
> > > > >         return 0;
> > > > >  }
> > > > >
> > > > > +static inline int swapcache_prepare(swp_entry_t swp)
> > > > > +{
> > > > > +       return 0;
> > > > > +}
> > > > > +
> > > > >  static inline void swap_free(swp_entry_t swp)
> > > > >  {
> > > > >  }
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 7e1f4849463a..1749c700823d 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> > > > >         if (!folio) {
> > > > >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > > > >                     __swap_count(entry) =3D=3D 1) {
> > > > > +                       /*
> > > > > +                        * Prevent parallel swapin from proceedin=
g with
> > > > > +                        * the cache flag. Otherwise, another thr=
ead may
> > > > > +                        * finish swapin first, free the entry, a=
nd swapout
> > > > > +                        * reusing the same entry. It's undetecta=
ble as
> > > > > +                        * pte_same() returns true due to entry r=
euse.
> > > > > +                        */
> > > > > +                       if (swapcache_prepare(entry))
> > > > > +                               goto out;
> > > > > +
> > > >
> > > > I am puzzled by this "goto out". If I understand this correctly, yo=
u
> > > > have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACH=
E.
> > > > The CPU1 will succeed in adding the flag and  the CPU2 will get
> > > > "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> > > > correctly so far?
> > > >
> > > > Then the goto out seems wrong to me. For the CPU2, the page fault w=
ill
> > > > return *unhandled*. Even worse, the "-EEXIST" error is not preserve=
d,
> > > > CPU2 does not even know the page fault is not handled, it will resu=
me
> > > > from the page fault instruction, possibly generate another page fau=
lt
> > > > at the exact same location. That page fault loop will repeat until
> > > > CPU1 install the new pte on that faulting virtual address and pick =
up
> > > > by CPU2.
> > > >
> > > > Am I missing something obvious there?
> > >
> > > I feel you are right. any concurrent page faults at the same pte
> > > will increase the count of page faults for a couple of times now.
> > >
> > > >
> > > > I just re-read your comment: "Racers will simply busy wait since it=
's
> > > > a rare and very short event." That might be referring to the above
> > > > CPU2 page fault looping situation. I consider the page fault loopin=
g
> > > > on CPU2 not acceptable. For one it will mess up the page fault
> > > > statistics.
> > > > In my mind, having an explicit loop for CPU2 waiting for the PTE to
> > > > show up is still better than this page fault loop. You can have mor=
e
> > > > CPU power friendly loops.
> > >
> > > I assume you mean something like
> > >
> > > while(!pte_same())
> > >    cpu_relax();
> > >
> > > then we still have a chance to miss the change of B.
> > >
> > > For example, another thread is changing pte to A->B->A, our loop can
> > > miss B. Thus we will trap into an infinite loop. this is even worse.
> >
> > Yes. You are right, it is worse. Thanks for catching that. That is why
> > I say this needs more discussion, I haven't fully thought it through
> > :-)
>
> Hi Chris and Barry,
>
> Thanks for the comments!
>
> The worst thing I know of returning in do_swap_page without handling
> the swap, is an increase of some statistic counters, note it will not
> cause major page fault counters to grow, only things like perf counter
> and vma lock statistic are affected.
>
> And actually there are multiple already existing return points in
> do_swap_page that will return without handling it, which may
> re-trigger the page fault.

Thanks for pointing that out. I take a look at those, which seems
different than the case here.  In those cases, it truely can not make
forward progress.
Here we actually have all the data it needs to complete the page
fault. Just a data synchronization issue preventing making forward
progress.
Ideally we can have some clever data structure to solve the
synchronization issue and make forward progress.

> When do_swap_page is called, many pre-checks have been applied, and
> they could all be invalidated if something raced, simply looping
> inside here could miss a lot of corner cases, so we have to go through
> that again.

Actually, I  think about it. Looping it here seems worse in the sense
that it is already holding some locks. Return and retry the page fault
at least release those locks and let others have a chance to make
progress.

>
> This patch did increase the chance of false positive increase of some
> counters, maybe something like returning a VM_FAULT_RETRY could make
> it better, but code is more complex and will cause other counters to
> grow.

This is certainly not ideal. It might upset the feedback loop that
uses the swap fault statistic as input to adjust the swapping
behavior.

Chris

