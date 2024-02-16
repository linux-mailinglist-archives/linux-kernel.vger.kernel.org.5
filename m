Return-Path: <linux-kernel+bounces-68475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48891857AC4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB9871F24D30
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE4154FB6;
	Fri, 16 Feb 2024 10:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnvZh1Av"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E2E54F8F;
	Fri, 16 Feb 2024 10:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708080980; cv=none; b=smk//aRrFUDjp01gnn3CPiEOdAaZwv10h5DDYcz+JRFpM57VPM0g7377ZlRaDg8suLWPw+RzN+uQ8AJnIGJqSQC3HxmnekOUHq4UXvAjRxQD1KCTcQMAwc1gzLl43Dn1v86mTGdPPiQTGdWp693/3+5XYMwG21EsLAo1FCfO25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708080980; c=relaxed/simple;
	bh=NjE8nGi7wiZ2fybvEv4aR2xVZcoDtwme8fnDnaNKmQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M7OOF/CMn7qQyy3GEGCyj8yr46daKjDjq8ET+1qRDaBtP3NzgwtKaMqtD5ByVVuyhzcyT8emxDNsH58+yU1prR9j3COzMHVwYmvIR+euVw+FxfsVLeTMjUqr6HzLtQ45rugOoNEECyZmz+LBy7MKbuAqF7RtfFZn63B2kfMR7Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnvZh1Av; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d0d799b55cso22271921fa.0;
        Fri, 16 Feb 2024 02:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708080977; x=1708685777; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGg08ojxntkhhDsQku4futyKqz14l8R5h9U6BLyyIe4=;
        b=lnvZh1Avab8bnWW3C59xqfspOph65w4YqJVKlx/cjF3jzV3uQPgSfUc5h/5xavTiEi
         WNrZtKtaRLwnNOtPrt6G0i/HqRaPYE1XaZI9ns1ME0i8HWlm1ephofqExHLM/AsNyvgx
         YfsXoRbaoN46CVB1ZPPzZLF9hBCfe1GilLrbHLgWYvEp747E+z8G99GMfyy/VB0u67Wr
         f0ACUZpwI7tf7zbGY/AV7bxkvc4bBjYvsiPU8rhCSh+jdCWkLiwdY6/hRqZSTmdfVOuU
         Hvp9HIKhYjnyUrEcTJ8IuFf/5Oa8fQXFGfnITRmWiriSEC5GJnXKdDdEW2XdA4vw/lUx
         vV7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708080977; x=1708685777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NGg08ojxntkhhDsQku4futyKqz14l8R5h9U6BLyyIe4=;
        b=VpCxdC+k9mCK0WKO7DM41wueoOPp069d55gyV12DzD01TAy61yodzH+bdnWz0scZWT
         X9+CFMxGzEc0wxPvmdBYZbqIpAJuLsU4k113r5B3s3wG6CUX3JOUaRZPOkBRnLWebzRM
         Mo7JNGXuF9l43S7uYnOTYNRoVNWU+jpYcnEMJmGw/YqlZlOA/Xo/AtDmhvA+CHjlsxDD
         rrG/H5M5BupMuzpSc6tps3t65iGZd9xnYrQdGlbtqB3r49K1jgUYIWOpYaJpZEg4K0Sk
         V7tCk9t84qc+iH2AcCIfO2oWCD15T18wOGXGnwlWYxMCKC7Ti0mIdOM7x2gVN5MSq0Db
         1gvw==
X-Forwarded-Encrypted: i=1; AJvYcCXpaCPr6qawekjugW0tUvV2p5SaiG9RtAxbIDvdxUxMzt5vGSvvrUx91D44fT/QOnI5QH4BhzRPOFYCqx21t/xPpdsW2L+55xHNPc1e2qKzq+fYjOVLZMh0bP5qGFDsnnDNftYl
X-Gm-Message-State: AOJu0YxZ3yjAhoJhPq2WP/rbi09pnL9a33XhCNBYeCIWX9jYbEWRxeEM
	BTOMNviVpC59ACUF2BH9p6SCRBS1jCM+MqnpOaEot8FrzHoxWXAoEuguNMGTTEjfGRh0MoIKov5
	++P9htzENojbP8ppKihBTyOEdBzs=
X-Google-Smtp-Source: AGHT+IFpyDTFOcMj3ClvLTCcN93JDJCcX10HC9mbHDXDYofQLci0+t4Z1bna18u/N5ucidk4kUMlTl/kQyAFjQeYLhU=
X-Received: by 2002:a2e:3a07:0:b0:2d2:1d51:333e with SMTP id
 h7-20020a2e3a07000000b002d21d51333emr475538lja.49.1708080976588; Fri, 16 Feb
 2024 02:56:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <CAGsJ_4yJFtPdJapjboOxnmg=jdvatTGvTN50r_LKCRNoB0P0fA@mail.gmail.com>
In-Reply-To: <CAGsJ_4yJFtPdJapjboOxnmg=jdvatTGvTN50r_LKCRNoB0P0fA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Feb 2024 18:55:58 +0800
Message-ID: <CAMgjq7CjOUbX0ihFwryd=E7eX+=QVOQWpNavtSW-YznYfvzY-g@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: Barry Song <21cnbao@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 6:15=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Feb 16, 2024 at 10:53=E2=80=AFPM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> > swapin the same entry at the same time, they get different pages (A, B)=
.
> > Before one thread (T0) finishes the swapin and installs page (A)
> > to the PTE, another thread (T1) could finish swapin of page (B),
> > swap_free the entry, then swap out the possibly modified page
> > reusing the same entry. It breaks the pte_same check in (T0) because
> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > install a stalled page (A) into the PTE and cause data corruption.
> >
> > One possible callstack is like this:
> >
> > CPU0                                 CPU1
> > ----                                 ----
> > do_swap_page()                       do_swap_page() with same entry
> > <direct swapin path>                 <direct swapin path>
> > <alloc page A>                       <alloc page B>
> > swap_read_folio() <- read to page A  swap_read_folio() <- read to page =
B
> > <slow on later locks or interrupt>   <finished swapin first>
> > ..                                  set_pte_at()
> >                                      swap_free() <- entry is free
> >                                      <write to page B, now page A stall=
ed>
> >                                      <swap out page B to same swap entr=
y>
> > pte_same() <- Check pass, PTE seems
> >               unchanged, but page A
> >               is stalled!
> > swap_free() <- page B content lost!
> > set_pte_at() <- staled page A installed!
> >
> > And besides, for ZRAM, swap_free() allows the swap device to discard
> > the entry content, so even if page (B) is not modified, if
> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > it may also cause data loss.
> >
> > To fix this, reuse swapcache_prepare which will pin the swap entry usin=
g
> > the cache flag, and allow only one thread to pin it. Release the pin
> > after PT unlocked. Racers will simply wait since it's a rare and very
> > short event. A schedule() call is added to avoid wasting too much CPU
> > or adding too much noise to perf statistics
> >
> > Other methods like increasing the swap count don't seem to be a good
> > idea after some tests, that will cause racers to fall back to use the
> > swap cache again. Parallel swapin using different methods leads to
> > a much more complex scenario.
> >
> > Reproducer:
> >
> > This race issue can be triggered easily using a well constructed
> > reproducer and patched brd (with a delay in read path) [1]:
> >
> > With latest 6.8 mainline, race caused data loss can be observed easily:
> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> >   Polulating 32MB of memory region...
> >   Keep swapping out...
> >   Starting round 0...
> >   Spawning 65536 workers...
> >   32746 workers spawned, wait for done...
> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >   Round 0 Failed, 15 data loss!
> >
> > This reproducer spawns multiple threads sharing the same memory region
> > using a small swap device. Every two threads updates mapped pages one b=
y
> > one in opposite direction trying to create a race, with one dedicated
> > thread keep swapping out the data out using madvise.
> >
> > The reproducer created a reproduce rate of about once every 5 minutes,
> > so the race should be totally possible in production.
> >
> > After this patch, I ran the reproducer for over a few hundred rounds
> > and no data loss observed.
> >
> > Performance overhead is minimal, microbenchmark swapin 10G from 32G
> > zram:
> >
> > Before:     10934698 us
> > After:      11157121 us
> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> >
> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronou=
s device")
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.cc=
r.corp.intel.com/
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Cc: stable@vger.kernel.org
> >
> > ---
> > Update from V2:
> > - Add a schedule() if raced to prevent repeated page faults wasting CPU
> >   and add noise to perf statistics.
> > - Use a bool to state the special case instead of reusing existing
> >   variables fixing error handling [Minchan Kim].
> >
> > V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com=
/
> >
> > Update from V1:
> > - Add some words on ZRAM case, it will discard swap content on swap_fre=
e so the race window is a bit different but cure is the same. [Barry Song]
> > - Update comments make it cleaner [Huang, Ying]
> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Pa=
rk]
> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO in=
stead of "direct swapin path" [Yu Zhao]
> > - Update commit message.
> > - Collect Review and Acks.
> >
> > V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> >
> >  include/linux/swap.h |  5 +++++
> >  mm/memory.c          | 20 ++++++++++++++++++++
> >  mm/swap.h            |  5 +++++
> >  mm/swapfile.c        | 13 +++++++++++++
> >  4 files changed, 43 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4db00ddad261..8d28f6091a32 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> >         return 0;
> >  }
> >
> > +static inline int swapcache_prepare(swp_entry_t swp)
> > +{
> > +       return 0;
> > +}
> > +
> >  static inline void swap_free(swp_entry_t swp)
> >  {
> >  }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7e1f4849463a..7059230d0a54 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         struct page *page;
> >         struct swap_info_struct *si =3D NULL;
> >         rmap_t rmap_flags =3D RMAP_NONE;
> > +       bool need_clear_cache =3D false;
> >         bool exclusive =3D false;
> >         swp_entry_t entry;
> >         pte_t pte;
> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         if (!folio) {
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> > +                       /*
> > +                        * Prevent parallel swapin from proceeding with
> > +                        * the cache flag. Otherwise, another thread ma=
y
> > +                        * finish swapin first, free the entry, and swa=
pout
> > +                        * reusing the same entry. It's undetectable as
> > +                        * pte_same() returns true due to entry reuse.
> > +                        */
> > +                       if (swapcache_prepare(entry)) {
> > +                               /* Relax a bit to prevent rapid repeate=
d page faults */
> > +                               schedule();
> > +                               goto out;
> > +                       }
> > +                       need_clear_cache =3D true;
>
> Hi Kairui,
> i remember Ying had a suggestion to move swapcache_prepare after
> swap_read_folio() to decrease race window. does that one even help
> more to somehow "fix" the counting issue?
>

Hi Barry,

Thanks for the comments!

Yes, that's one of the suggestions, I found the result already looks
good enough in test scenario I've posted after adding scheduler()
change. After moving swapcache_prepare actually waste more CPU as it
need to alloc/free extra folios now, and test result for the counting
issue barely changed, so I kept the original code.

