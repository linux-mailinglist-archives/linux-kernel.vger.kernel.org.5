Return-Path: <linux-kernel+bounces-55909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F9A84C343
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729FC285189
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460A8101EE;
	Wed,  7 Feb 2024 03:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHoEHstz"
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2327C1CF83;
	Wed,  7 Feb 2024 03:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707277564; cv=none; b=BR4wIjkruiJsy+d0CjMj0+ENMeGHGOERwZiBNapbHRpEf4ZJ3GPGzRgGFZDB450jdH2f6fPyJFgzAJMr2LWxJA0OOBd6gp1H46tn8wQhpn9LgbELSWhfiL3IG1o6Aa8J8ay5ZEFRt01XmemNpbxC6g+wjQcTD2e/iK4Thsvov6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707277564; c=relaxed/simple;
	bh=C7qilsSdVeToVF1IHykA/AzYlFnb7nppTc9W/RGc9M8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHstW7NfQ3D5N1Pj3VV3V29ClJ74WBJWxhXitVejUND+9N3TqaUqZwmzktcAN+0GJ0XlrDxhhFLhnfJgv4YR7IW4JJbNv4IDpxXT5Pv4ta0ro8lWDfRHbCuWtwsHPOezqRmsdvTob6MPtLwSmLI0tdguDt2qjLJpWUJ7U6LBv4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHoEHstz; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-46d246e1ebfso62956137.1;
        Tue, 06 Feb 2024 19:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707277561; x=1707882361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbX5qtQr/EjqD92mfGUpwxjcql20u4gYJdGiDPFLd4s=;
        b=DHoEHstzD1BHO2JMR8ETHssAD4pHrhX8mbN16Z+8LMnko/EWhmpmjJ8V5s9QjF8i57
         npCB6o9lmvY5CSJuN1yX+T7GxP6R9NM1EsKeTE0Kj9vL2k51L5KZ7bwTxFLhlWjgKODl
         vdUKdQLd62vtIHUh71ONLHtkWkXH5LgppV5bQsB9CTb+c5IM/ReNIld7txl6bR0PvI0l
         1c/ZL83GhWTSR2aeM1+7I7e95UTPRcKbyiWmw3UHwqxU5IRKTUUqWHFIC5vhLZY3JNj4
         25rd1wAdoiaVv8wIWiIhVfrBIGavzyeM1FyRrokYhRGDCFcRtDFFPzwCngdSDd6d6399
         Pjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707277561; x=1707882361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbX5qtQr/EjqD92mfGUpwxjcql20u4gYJdGiDPFLd4s=;
        b=ZfUHmItRtHfwZST7aWdrTZa/ecnF7ndqYCEc3itcmgJ774FWmcLqbvygqFLb0Zsfke
         ic0VxTBA5WxmrFss/SqLf4okqM+DB0kQtRatOLbsPYtRGLwHLz6/U/RBDs62+mDunPrm
         5x4lPMHkHPMmwquq9UamEyg+8IyfYTN4WF6pBORQmeQHzUH4oVVGhsUsUBdgnoB/njX4
         40SquIGTHF0dN/wWJxOWB3jMtfi5RMh/fntpyb0AyVIXiGTji0D1iFznFCITeLqp0LkF
         SzrCOXVtLRK++ZqEYdObbijmQHPpW0HjJRHtAgCAoTek0FF0wh2X2a28QpwGAKeLC8p/
         LiIA==
X-Gm-Message-State: AOJu0YwOP0W3pfbuMmjclqNLmUiIvP7nWXipKeVAaIa7CVp3tvBFtizU
	+DTKMrJZgbrK78NyWPNDvqwaN/pMBQKS7LdvMsVnsGPL3NZcDH8rOVnZKy4ddOvWyXSMZbWJcOr
	1//pPtnx3DrIVrTbQEEKw5PhAdUg=
X-Google-Smtp-Source: AGHT+IESVNmkqTxmfnQfVqNJZli2dbk2J7qalQUKTZp8u/z+qqQmF4ZwHQUED/Pyx8Ao6A/y0POX0cI/ejK6M0Ot7rk=
X-Received: by 2002:a67:e348:0:b0:46d:20a1:e884 with SMTP id
 s8-20020a67e348000000b0046d20a1e884mr1803438vsm.19.1707277560862; Tue, 06 Feb
 2024 19:46:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
 <87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7DbE=L24m8dhU7Bu324Ym=34LyZFB8Df32NYwKVapLGKQ@mail.gmail.com>
In-Reply-To: <CAMgjq7DbE=L24m8dhU7Bu324Ym=34LyZFB8Df32NYwKVapLGKQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Wed, 7 Feb 2024 16:45:49 +1300
Message-ID: <CAGsJ_4wc920zQ8niaQgn9V48P1S_KX2F5To9et+enJx8iR7+Bg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 3:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Wed, Feb 7, 2024 at 10:10=E2=80=AFAM Huang, Ying <ying.huang@intel.com=
> wrote:
> >
> > Barry Song <21cnbao@gmail.com> writes:
> >
> > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org> w=
rote:
> > >>
> > >> Hi Kairui,
> > >>
> > >> Sorry replying to your patch V1 late, I will reply on the V2 thread.
> > >>
> > >> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.co=
m> wrote:
> > >> >
> > >> > From: Kairui Song <kasong@tencent.com>
> > >> >
> > >> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more thr=
eads
> > >> > swapin the same entry at the same time, they get different pages (=
A, B).
> > >> > Before one thread (T0) finishes the swapin and installs page (A)
> > >> > to the PTE, another thread (T1) could finish swapin of page (B),
> > >> > swap_free the entry, then swap out the possibly modified page
> > >> > reusing the same entry. It breaks the pte_same check in (T0) becau=
se
> > >> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > >> > install a stalled page (A) into the PTE and cause data corruption.
> > >> >
> > >> > One possible callstack is like this:
> > >> >
> > >> > CPU0                                 CPU1
> > >> > ----                                 ----
> > >> > do_swap_page()                       do_swap_page() with same entr=
y
> > >> > <direct swapin path>                 <direct swapin path>
> > >> > <alloc page A>                       <alloc page B>
> > >> > swap_read_folio() <- read to page A  swap_read_folio() <- read to =
page B
> > >> > <slow on later locks or interrupt>   <finished swapin first>
> > >> > ...                                  set_pte_at()
> > >> >                                      swap_free() <- entry is free
> > >> >                                      <write to page B, now page A =
stalled>
> > >> >                                      <swap out page B to same swap=
 entry>
> > >> > pte_same() <- Check pass, PTE seems
> > >> >               unchanged, but page A
> > >> >               is stalled!
> > >> > swap_free() <- page B content lost!
> > >> > set_pte_at() <- staled page A installed!
> > >> >
> > >> > And besides, for ZRAM, swap_free() allows the swap device to disca=
rd
> > >> > the entry content, so even if page (B) is not modified, if
> > >> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > >> > it may also cause data loss.
> > >> >
> > >> > To fix this, reuse swapcache_prepare which will pin the swap entry=
 using
> > >> > the cache flag, and allow only one thread to pin it. Release the p=
in
> > >> > after PT unlocked. Racers will simply busy wait since it's a rare
> > >> > and very short event.
> > >> >
> > >> > Other methods like increasing the swap count don't seem to be a go=
od
> > >> > idea after some tests, that will cause racers to fall back to use =
the
> > >> > swap cache again. Parallel swapin using different methods leads to
> > >> > a much more complex scenario.
> > >> >
> > >> > Reproducer:
> > >> >
> > >> > This race issue can be triggered easily using a well constructed
> > >> > reproducer and patched brd (with a delay in read path) [1]:
> > >> >
> > >> > With latest 6.8 mainline, race caused data loss can be observed ea=
sily:
> > >> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > >> >   Polulating 32MB of memory region...
> > >> >   Keep swapping out...
> > >> >   Starting round 0...
> > >> >   Spawning 65536 workers...
> > >> >   32746 workers spawned, wait for done...
> > >> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data los=
s!
> > >> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data lo=
ss!
> > >> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data lo=
ss!
> > >> >   Round 0 Failed, 15 data loss!
> > >> >
> > >> > This reproducer spawns multiple threads sharing the same memory re=
gion
> > >> > using a small swap device. Every two threads updates mapped pages =
one by
> > >> > one in opposite direction trying to create a race, with one dedica=
ted
> > >> > thread keep swapping out the data out using madvise.
> > >> >
> > >> > The reproducer created a reproduce rate of about once every 5 minu=
tes,
> > >> > so the race should be totally possible in production.
> > >> >
> > >> > After this patch, I ran the reproducer for over a few hundred roun=
ds
> > >> > and no data loss observed.
> > >> >
> > >> > Performance overhead is minimal, microbenchmark swapin 10G from 32=
G
> > >> > zram:
> > >> >
> > >> > Before:     10934698 us
> > >> > After:      11157121 us
> > >> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > >> >
> > >> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synch=
ronous device")
> > >> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > >> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-des=
k2.ccr.corp.intel.com/
> > >> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-=
stress-race [1]
> > >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > >> > Acked-by: Yu Zhao <yuzhao@google.com>
> > >> >
> > >> > ---
> > >> > Update from V1:
> > >> > - Add some words on ZRAM case, it will discard swap content on swa=
p_free so the race window is a bit different but cure is the same. [Barry S=
ong]
> > >> > - Update comments make it cleaner [Huang, Ying]
> > >> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJ=
ae Park]
> > >> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_=
IO instead of "direct swapin path" [Yu Zhao]
> > >> > - Update commit message.
> > >> > - Collect Review and Acks.
> > >> >
> > >> >  include/linux/swap.h |  5 +++++
> > >> >  mm/memory.c          | 15 +++++++++++++++
> > >> >  mm/swap.h            |  5 +++++
> > >> >  mm/swapfile.c        | 13 +++++++++++++
> > >> >  4 files changed, 38 insertions(+)
> > >> >
> > >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > >> > index 4db00ddad261..8d28f6091a32 100644
> > >> > --- a/include/linux/swap.h
> > >> > +++ b/include/linux/swap.h
> > >> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t =
swp)
> > >> >         return 0;
> > >> >  }
> > >> >
> > >> > +static inline int swapcache_prepare(swp_entry_t swp)
> > >> > +{
> > >> > +       return 0;
> > >> > +}
> > >> > +
> > >> >  static inline void swap_free(swp_entry_t swp)
> > >> >  {
> > >> >  }
> > >> > diff --git a/mm/memory.c b/mm/memory.c
> > >> > index 7e1f4849463a..1749c700823d 100644
> > >> > --- a/mm/memory.c
> > >> > +++ b/mm/memory.c
> > >> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> > >> >         if (!folio) {
> > >> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >> >                     __swap_count(entry) =3D=3D 1) {
> > >> > +                       /*
> > >> > +                        * Prevent parallel swapin from proceeding=
 with
> > >> > +                        * the cache flag. Otherwise, another thre=
ad may
> > >> > +                        * finish swapin first, free the entry, an=
d swapout
> > >> > +                        * reusing the same entry. It's undetectab=
le as
> > >> > +                        * pte_same() returns true due to entry re=
use.
> > >> > +                        */
> > >> > +                       if (swapcache_prepare(entry))
> > >> > +                               goto out;
> > >> > +
> > >>
> > >> I am puzzled by this "goto out". If I understand this correctly, you
> > >> have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACHE=
.
> > >> The CPU1 will succeed in adding the flag and  the CPU2 will get
> > >> "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> > >> correctly so far?
> > >>
> > >> Then the goto out seems wrong to me. For the CPU2, the page fault wi=
ll
> > >> return *unhandled*. Even worse, the "-EEXIST" error is not preserved=
,
> > >> CPU2 does not even know the page fault is not handled, it will resum=
e
> > >> from the page fault instruction, possibly generate another page faul=
t
> > >> at the exact same location. That page fault loop will repeat until
> > >> CPU1 install the new pte on that faulting virtual address and pick u=
p
> > >> by CPU2.
> > >>
> > >> Am I missing something obvious there?
> > >
> > > I feel you are right. any concurrent page faults at the same pte
> > > will increase the count of page faults for a couple of times now.
> > >
> > >>
> > >> I just re-read your comment: "Racers will simply busy wait since it'=
s
> > >> a rare and very short event." That might be referring to the above
> > >> CPU2 page fault looping situation. I consider the page fault looping
> > >> on CPU2 not acceptable. For one it will mess up the page fault
> > >> statistics.
> > >> In my mind, having an explicit loop for CPU2 waiting for the PTE to
> > >> show up is still better than this page fault loop. You can have more
> > >> CPU power friendly loops.
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
> > >
> > > is it possible to loop for the success of swapcache_prepare(entry)
> > > instead?
> >
> > This doesn't work too.  The swap count can increase to > 1 and be put i=
n
> > swap cache for long time.
> >
> > Another possibility is to move swapcache_prepare() after
> > vma_alloc_folio() to reduce the race window.

what about we make everything go as it is. I mean, we only need to
record we have failed on swapcache_prepare, but we don't goto out.

bool swapcache_prepare_failed =3D  swapcache_prepare();
... // don't change any code


but we only change the last code to set pte from the below
   ptl
   if(pte_same)
       set_pte

to

   ptl
   if(pte_same && !swapcache_prepare_failed)
        set_pte

as the chance is close to 0%, the increased count should be very minor.


>
> Reducing the race window seems like a good way. Or maybe we can just
> add a cpu_relax() so raced swapins will just slow down, and won't loop
> too much time and so the side effect (counter or power consumption)
> should be much smaller?

Thanks
Barry

