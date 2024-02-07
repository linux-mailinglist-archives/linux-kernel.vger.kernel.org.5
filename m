Return-Path: <linux-kernel+bounces-55852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD284C280
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09927B2267B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA257EEDE;
	Wed,  7 Feb 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EbsIWgBb"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71B1FBF7;
	Wed,  7 Feb 2024 02:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707272961; cv=none; b=aFhXY0sFuzE/Me4XFVwE0cEpHot0hu7qkF5ZXqPbBeg2Tyt1zj4cy9FACulXCOPZkbvOdJ5eqhGAsx8dX9nA2jCA0UYA8rdyOjxW+HpDiCP7WqCVqR3X4NMgnpyPq3BspqvwoYItgPKLIf3qFYMxWEuYJ/SdPZlHRQa7u/i88JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707272961; c=relaxed/simple;
	bh=CPunz6O20Ix5CWDUBWwr8krKIcLBnHDRTmWhVDlcxr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eos3n7kzT2l/YWEu3Yov9xWOP45GmICkWWNYgnHy1sl7CVoObOw0RPm7VNAjbWHr1WnApmWQOUHD56GOIDxSKMwHG9MAL/c3Tvpvrfr/LTWJ0oMqGUxOZui/4t6q65rfrJfk+9E/sxqV5RKAth3qZ0h0KyaDKA2x0R/nl1T1wX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EbsIWgBb; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511234430a4so225359e87.3;
        Tue, 06 Feb 2024 18:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707272958; x=1707877758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RB1KJ0JdRvMYNf1s/iIEygXVJP41nn64OktYdzwiagE=;
        b=EbsIWgBbM3MIT0qQgd+/WKwE675eSm+j4HJdMh3Dmtf0DlhhXhQ6cmfs8+D+S8tQiD
         /ydcW6/nbz2fZWpcvTgX1GdGlgZfhCP8eG1JyromQ0xQxz+Wew2m9ErnOe2iv9O+0Gbv
         nFaZsmqOILHrd5cw58FP+IhyvkiGUHD8aKCU+Crcayra8dTm9yFwWOvMTzobR5EIMsEK
         79b5M7nN7Fw/i7jwTWgkVov6DrV4ONrh223rZKtF1JOsORd0daP6dox5qCkFiozMuZVF
         f5I2nVxLYJWD5SfP2iOPKLRoaDQ8oZ0MXErCmo7eZc4IyvUpSK0TADVPDe0SFxbPA8hz
         twBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707272958; x=1707877758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RB1KJ0JdRvMYNf1s/iIEygXVJP41nn64OktYdzwiagE=;
        b=Jmg198ixWV48Bwq8yChraUaKeg4yUQoLBNHeQ0U/yAROfKn32klqNrwFXu+vJ+Thbg
         KSixtox9pc1+PKRR4YnEUBvii12UcnYIwHDoqeXo++atGvmf8LwGYHWxaxmO7lCUy6cb
         1fNznWpF/zBlNnsfJIxt5nrcHk2YbUOknJ1a47DTbYjFBxUO/pqhFoxUlu6hQq22jlj2
         JfUEibEb7qjAtf/xyKGMILH+ub3IoGiKTJDk31hZjIL0zJH49FpqbqstR3R0aDq6TIqT
         f+/yhTP4XPR0Ib9geCtd+KtutEUnZIiNVBXTWoHUUdeNGw/yh+qdgEiPhps5qHCIPs7S
         n0tw==
X-Forwarded-Encrypted: i=1; AJvYcCXuDLs5vnqr38Nia6vmPrvfWpV7mBaTBi6UVMvPaXV3Egxwt+M4xq9n/Eb3Vg9x9sRxSIKS3zOTx6UugjXDzToX60g82B5nBoKoFatEkN70N5Z3mMIvwBMgzSg3G8fZ6/Y7Jnmd
X-Gm-Message-State: AOJu0Yzq8ioYs9lNQxIx1967zVwzf0+CXDstomgDh0caRYDg+NYdhpIK
	b36XQBPyDOYRIpYOQVsPm/xCA+zcSuwcwk0d5ajE3utTEzsdsXuI+SnWdriFl0mS0coFj4iOZvd
	H8iQmCo3IzgxRVuxCYqi1RXuyokk=
X-Google-Smtp-Source: AGHT+IH61BSwULQr4L1a6aIKcdwGLWuKzrlFSjf0/lzC40o7jjLa/Fc9NG/MkE+GL4cZTTlWNTb82qUUw2Xoi3WxPdk=
X-Received: by 2002:a2e:9098:0:b0:2d0:996e:b014 with SMTP id
 l24-20020a2e9098000000b002d0996eb014mr2785728ljg.32.1707272957649; Tue, 06
 Feb 2024 18:29:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
 <CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com> <87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 7 Feb 2024 10:28:59 +0800
Message-ID: <CAMgjq7DbE=L24m8dhU7Bu324Ym=34LyZFB8Df32NYwKVapLGKQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Barry Song <21cnbao@gmail.com>, Chris Li <chrisl@kernel.org>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Minchan Kim <minchan@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:10=E2=80=AFAM Huang, Ying <ying.huang@intel.com> =
wrote:
>
> Barry Song <21cnbao@gmail.com> writes:
>
> > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org> wro=
te:
> >>
> >> Hi Kairui,
> >>
> >> Sorry replying to your patch V1 late, I will reply on the V2 thread.
> >>
> >> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> >> >
> >> > From: Kairui Song <kasong@tencent.com>
> >> >
> >> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threa=
ds
> >> > swapin the same entry at the same time, they get different pages (A,=
 B).
> >> > Before one thread (T0) finishes the swapin and installs page (A)
> >> > to the PTE, another thread (T1) could finish swapin of page (B),
> >> > swap_free the entry, then swap out the possibly modified page
> >> > reusing the same entry. It breaks the pte_same check in (T0) because
> >> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> >> > install a stalled page (A) into the PTE and cause data corruption.
> >> >
> >> > One possible callstack is like this:
> >> >
> >> > CPU0                                 CPU1
> >> > ----                                 ----
> >> > do_swap_page()                       do_swap_page() with same entry
> >> > <direct swapin path>                 <direct swapin path>
> >> > <alloc page A>                       <alloc page B>
> >> > swap_read_folio() <- read to page A  swap_read_folio() <- read to pa=
ge B
> >> > <slow on later locks or interrupt>   <finished swapin first>
> >> > ...                                  set_pte_at()
> >> >                                      swap_free() <- entry is free
> >> >                                      <write to page B, now page A st=
alled>
> >> >                                      <swap out page B to same swap e=
ntry>
> >> > pte_same() <- Check pass, PTE seems
> >> >               unchanged, but page A
> >> >               is stalled!
> >> > swap_free() <- page B content lost!
> >> > set_pte_at() <- staled page A installed!
> >> >
> >> > And besides, for ZRAM, swap_free() allows the swap device to discard
> >> > the entry content, so even if page (B) is not modified, if
> >> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> >> > it may also cause data loss.
> >> >
> >> > To fix this, reuse swapcache_prepare which will pin the swap entry u=
sing
> >> > the cache flag, and allow only one thread to pin it. Release the pin
> >> > after PT unlocked. Racers will simply busy wait since it's a rare
> >> > and very short event.
> >> >
> >> > Other methods like increasing the swap count don't seem to be a good
> >> > idea after some tests, that will cause racers to fall back to use th=
e
> >> > swap cache again. Parallel swapin using different methods leads to
> >> > a much more complex scenario.
> >> >
> >> > Reproducer:
> >> >
> >> > This race issue can be triggered easily using a well constructed
> >> > reproducer and patched brd (with a delay in read path) [1]:
> >> >
> >> > With latest 6.8 mainline, race caused data loss can be observed easi=
ly:
> >> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >> >   Polulating 32MB of memory region...
> >> >   Keep swapping out...
> >> >   Starting round 0...
> >> >   Spawning 65536 workers...
> >> >   32746 workers spawned, wait for done...
> >> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss=
!
> >> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss=
!
> >> >   Round 0 Failed, 15 data loss!
> >> >
> >> > This reproducer spawns multiple threads sharing the same memory regi=
on
> >> > using a small swap device. Every two threads updates mapped pages on=
e by
> >> > one in opposite direction trying to create a race, with one dedicate=
d
> >> > thread keep swapping out the data out using madvise.
> >> >
> >> > The reproducer created a reproduce rate of about once every 5 minute=
s,
> >> > so the race should be totally possible in production.
> >> >
> >> > After this patch, I ran the reproducer for over a few hundred rounds
> >> > and no data loss observed.
> >> >
> >> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> >> > zram:
> >> >
> >> > Before:     10934698 us
> >> > After:      11157121 us
> >> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >> >
> >> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchro=
nous device")
> >> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> >> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2=
ccr.corp.intel.com/
> >> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-st=
ress-race [1]
> >> > Signed-off-by: Kairui Song <kasong@tencent.com>
> >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> >> > Acked-by: Yu Zhao <yuzhao@google.com>
> >> >
> >> > ---
> >> > Update from V1:
> >> > - Add some words on ZRAM case, it will discard swap content on swap_=
free so the race window is a bit different but cure is the same. [Barry Son=
g]
> >> > - Update comments make it cleaner [Huang, Ying]
> >> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae=
 Park]
> >> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO=
 instead of "direct swapin path" [Yu Zhao]
> >> > - Update commit message.
> >> > - Collect Review and Acks.
> >> >
> >> >  include/linux/swap.h |  5 +++++
> >> >  mm/memory.c          | 15 +++++++++++++++
> >> >  mm/swap.h            |  5 +++++
> >> >  mm/swapfile.c        | 13 +++++++++++++
> >> >  4 files changed, 38 insertions(+)
> >> >
> >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> > index 4db00ddad261..8d28f6091a32 100644
> >> > --- a/include/linux/swap.h
> >> > +++ b/include/linux/swap.h
> >> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t sw=
p)
> >> >         return 0;
> >> >  }
> >> >
> >> > +static inline int swapcache_prepare(swp_entry_t swp)
> >> > +{
> >> > +       return 0;
> >> > +}
> >> > +
> >> >  static inline void swap_free(swp_entry_t swp)
> >> >  {
> >> >  }
> >> > diff --git a/mm/memory.c b/mm/memory.c
> >> > index 7e1f4849463a..1749c700823d 100644
> >> > --- a/mm/memory.c
> >> > +++ b/mm/memory.c
> >> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >> >         if (!folio) {
> >> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >> >                     __swap_count(entry) =3D=3D 1) {
> >> > +                       /*
> >> > +                        * Prevent parallel swapin from proceeding w=
ith
> >> > +                        * the cache flag. Otherwise, another thread=
 may
> >> > +                        * finish swapin first, free the entry, and =
swapout
> >> > +                        * reusing the same entry. It's undetectable=
 as
> >> > +                        * pte_same() returns true due to entry reus=
e.
> >> > +                        */
> >> > +                       if (swapcache_prepare(entry))
> >> > +                               goto out;
> >> > +
> >>
> >> I am puzzled by this "goto out". If I understand this correctly, you
> >> have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACHE.
> >> The CPU1 will succeed in adding the flag and  the CPU2 will get
> >> "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
> >> correctly so far?
> >>
> >> Then the goto out seems wrong to me. For the CPU2, the page fault will
> >> return *unhandled*. Even worse, the "-EEXIST" error is not preserved,
> >> CPU2 does not even know the page fault is not handled, it will resume
> >> from the page fault instruction, possibly generate another page fault
> >> at the exact same location. That page fault loop will repeat until
> >> CPU1 install the new pte on that faulting virtual address and pick up
> >> by CPU2.
> >>
> >> Am I missing something obvious there?
> >
> > I feel you are right. any concurrent page faults at the same pte
> > will increase the count of page faults for a couple of times now.
> >
> >>
> >> I just re-read your comment: "Racers will simply busy wait since it's
> >> a rare and very short event." That might be referring to the above
> >> CPU2 page fault looping situation. I consider the page fault looping
> >> on CPU2 not acceptable. For one it will mess up the page fault
> >> statistics.
> >> In my mind, having an explicit loop for CPU2 waiting for the PTE to
> >> show up is still better than this page fault loop. You can have more
> >> CPU power friendly loops.
> >
> > I assume you mean something like
> >
> > while(!pte_same())
> >    cpu_relax();
> >
> > then we still have a chance to miss the change of B.
> >
> > For example, another thread is changing pte to A->B->A, our loop can
> > miss B. Thus we will trap into an infinite loop. this is even worse.
> >
> > is it possible to loop for the success of swapcache_prepare(entry)
> > instead?
>
> This doesn't work too.  The swap count can increase to > 1 and be put in
> swap cache for long time.
>
> Another possibility is to move swapcache_prepare() after
> vma_alloc_folio() to reduce the race window.

Reducing the race window seems like a good way. Or maybe we can just
add a cpu_relax() so raced swapins will just slow down, and won't loop
too much time and so the side effect (counter or power consumption)
should be much smaller?

