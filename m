Return-Path: <linux-kernel+bounces-55874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CC184C2C4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA2B29C68
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E64F9D6;
	Wed,  7 Feb 2024 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IYHpYds3"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50843F9EA;
	Wed,  7 Feb 2024 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707274528; cv=none; b=Cgp/WyzLekBycB0u1yhEYinrBsSNKorqXIBebVTRe0bY8VHe8oWE10dNFrX5E0rWWHVGZalREgV20p2U5zCg9iikSFy1wLEmVCa63BIAPVUBLqwld7w8i81PKCarC+S+fKcy4p3B94r93mWER0Eq/t8lfWH4YdHnSksgfrdOdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707274528; c=relaxed/simple;
	bh=IDkTcD+Il9gisHQGw8RL56SdmQKenRGDrFA2DfHsgYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TWSMMh8AAlchBztvI7aR3Eiw+gVYIKDgYUf7ewQqitdxxbdu0FZSZYEhMv71sR6jGUbpT/lreX39eMyW/OvWeQ/QcOVCQzTqNxDnHbmItH34WKTGF/0bT1IRSZN25qtrQzijaHm911BvHkBPAeYliG5idoaYQg9ScPEf+qOhJxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IYHpYds3; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7d698a8d93cso70293241.3;
        Tue, 06 Feb 2024 18:55:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707274525; x=1707879325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9EFEgmSHGF3F21j6OUWnw+MyyN4MHGfmS2TtGC3X6/k=;
        b=IYHpYds3S4uMezu4HLp6E4dGpT2gPu3oWgHRixmYWdNqNM+VZgMp5jBvOmUy7YB0nh
         E27g2buKU/cyygksHZBwUUagZZ9oiaLqQv9SoOR8olzN7aqnIgLDN4GQhL4dExYqlUrd
         wHqYuYy+CILHqZHWIHZsAgSV9DTMMpvHF6IuNjwRGtetj0Ck53Y88MNWjpfW/kzPplBZ
         /LLl4TXHO660Uhlm46h91JENDGMkUBJTZuNJvVnh++fGuNNcKMwMfHOdv8sPG4RRlbCx
         5TQPSrz4QlQiDe2ggAjDnU69uKZfzZwfQrLDt+qFA4a1pVpn7o3aBi0JfXFoxq71Mjs1
         +NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707274525; x=1707879325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9EFEgmSHGF3F21j6OUWnw+MyyN4MHGfmS2TtGC3X6/k=;
        b=LOPLxcpaEJdBsp4y3y+zeojvV10cxhA19l0myCPhpMtif1gN1ljCaGispHH5WfqO86
         VPgD2FGpxWg3HLWnF2e5uMnWtd7C6trReBtKvSg06Uz08xDNNo91361eQ94OSSJ9A1bT
         3PzdFEoS5LT+v3RJVv10lBoan624+n8pQAe+d5CdYunxKB0sqyeBFxsF9gJIz93HJlCV
         SbbsngeS2yg6wLAmYE3f2NlPMzyn7YOV4eLkcwc8KihiVd9lNjbjKs7rf4FmwsJ25DVC
         DGtEX4JXCX+Gah14ySxVQ0fS3uUXOWJC436F1wKPGe8VL8JL0qZZOtDvbB13Bk4tG5dk
         meAA==
X-Gm-Message-State: AOJu0Yz7m5UErGTJ0oksNkRsYPvxPLSfCUi8AmLS6hAY1HC326+GUCVp
	gJK/0pNqJnIFbs+6k5KX6MOe+PnaXcn4IL0gxdAsvW++481fprID4Tqsxyn3iIa0mP5rQYgQjcI
	o9xRS64V89uIsNAXIrzDdXsBJH0Y=
X-Google-Smtp-Source: AGHT+IGZo5wTrDunN7ImoDgNJqNYrHP7y+7wXb4MascXiZVpjGTkAJ47dyLuYXZ34D8CaqU2sW97Sq+jWy55VEmvMnQ=
X-Received: by 2002:a05:6102:66b:b0:46d:393b:5e56 with SMTP id
 z11-20020a056102066b00b0046d393b5e56mr1132704vsf.35.1707274523739; Tue, 06
 Feb 2024 18:55:23 -0800 (PST)
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
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Feb 2024 09:52:21 +0800
Message-ID: <CAGsJ_4xogYS=Ysi921Zudt++UGvd8WDggdiJhkckEJYwf19TMg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Huang, Ying" <ying.huang@intel.com>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:21=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
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

Hi Kairui,

> The worst thing I know of returning in do_swap_page without handling
> the swap, is an increase of some statistic counters, note it will not
> cause major page fault counters to grow, only things like perf counter
> and vma lock statistic are affected.

I don't understand :-) if it is goto out, userspace may re-execute the
instruction.
What is going to happen is a totally new page fault.

>
> And actually there are multiple already existing return points in
> do_swap_page that will return without handling it, which may
> re-trigger the page fault.

I feel this case is different from other returns.
other returns probably have held ptl or page lock before checking entry/pte=
,
and another thread has likely changed the PTE/swap entry before those
locks are released.
then it is likely there is no following page fault.

but our case is different, we are unconditionally having one or more page
faults. I think making the count "right" is important as we highly depend o=
n
it to debug performance issues.

> When do_swap_page is called, many pre-checks have been applied, and
> they could all be invalidated if something raced, simply looping
> inside here could miss a lot of corner cases, so we have to go through
> that again.

I agree.

>
> This patch did increase the chance of false positive increase of some
> counters, maybe something like returning a VM_FAULT_RETRY could make
> it better, but code is more complex and will cause other counters to
> grow.

right.

Thanks
Barry

