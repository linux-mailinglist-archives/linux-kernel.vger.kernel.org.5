Return-Path: <linux-kernel+bounces-62295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E77851E2F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A986E2842D8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDBC47A40;
	Mon, 12 Feb 2024 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iq5ZBchw"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081C645C14;
	Mon, 12 Feb 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767612; cv=none; b=ZxN2oYniAYpe7nWJOdtHE1rGdX6Rc+CMTyxkgr829g+n7QO5CKpgUQjrejdZOr5iDZucIV63mi7+FQH5vqTxhRTEBcb+B0Lh3OkQuhuy+ImDf2nzDJZJWXT3jvgG4V2kctmp/qPEyrAb+b2LwuYFFDP9al5XIBJP0xnrQq4ZhDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767612; c=relaxed/simple;
	bh=SYpILfxnJBftX3d8ipN1rFbW+nAmqKnfLZBCjozWMYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o1HAMe8DI1mRY8B/GVgyIAqC+tY2Dnmyb9MhkiYKOqmisODQFgzmOL9jb1F67s6rgV2b9Y3HFVnleEVyhoieKI2kKjMM8NmGdC2hyfz8TsmNNwudLL+ylYy8SKz63OivDa2c47r+xooGTpJFV1ztSW1kW5c9oxqZAKIyioltHm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iq5ZBchw; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d07ffa0a9cso41150861fa.2;
        Mon, 12 Feb 2024 11:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707767608; x=1708372408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7fm4hX9W12F7JLAHxenWMNhY+lYQBb+lHuuTkMdNBo=;
        b=iq5ZBchwpfkEzyEZmAQk/2K6nVsPqN5/lTVqSBMCi9E+NFoPCHY2vFlEWRh4notaxG
         zTyoHLvhdL6kRzpjrRzKqoH8KhyQ03C8DOYOyfhKfATFk0xydnYKgeLiOL6V3Q4ZABRG
         7wGdgx+bR3iMYzC6OTjJ4imguIbvJiVcOc+vvJX5pJBCa+EsAcqkeu6KNAhUq68P2Nx7
         7vmrDvKHvYxWQ+fl/WyKXhfpYwVJIEcykfvWcs8iNbeN5HovVBW5S4dQUAo+qIL11+UO
         39XvB+85sN8RdNAkeTMWMxsiuXqZtph0rjQH633/cmQnMR21RuQpUOl49jmdU+SY8Fa7
         BZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707767608; x=1708372408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7fm4hX9W12F7JLAHxenWMNhY+lYQBb+lHuuTkMdNBo=;
        b=EPCe85Mky8Vblg8QOuRcfntu63ZGrDVnGsBkHXoo9hMXDTV4HGW1cskBCucXeptaOA
         m3C+tTS29grLnRd++Pzs6J9Tox+46r1xyPPWLh6DSDh+CT4VZQHfDsyEm4IConvgwu/+
         4AgbrQYQIlvgzyIIjOIwJioJ2hi8bPMPIbJUvpWCjl6hXyTMyqJ4QPIkrCXktnHAFQ+0
         JXAqGQf9SXyw5cYc3IDojg79jz7Qkz4DSfFvYre8k+BCjN39WfKxQYFAbrjnu+B4GdUg
         HuCm4nelNfW6O7nrcLZPbV8hL7Q+pKiknWvOU7o97VpT6eUxt6rfnLW+clDzp4atVD+Y
         VHyg==
X-Gm-Message-State: AOJu0YxKE/1RT+G7W0KMmdbETOEoMFccZDK+AYjkoB/YNCdJSWntWsku
	mR0Iy3iy4sJO1kHI1JybIX9yplHYEbNYI5vGDoJYmjO918MidUxI4OtxB817FGK8jZc9TDHX+A4
	1R8f/mOuEQGdLf8abGi6B85l6bDM=
X-Google-Smtp-Source: AGHT+IF86cB2lsmSMqTMtcHqjmIrV84/7dmv2VDTK/yXJRQOMJBizDxjO6x/EUsrBw9c0Mq/IZ6Y1/OC/PR6a5YUUf8=
X-Received: by 2002:a2e:879a:0:b0:2d0:a6d3:56c6 with SMTP id
 n26-20020a2e879a000000b002d0a6d356c6mr4751073lji.32.1707767607601; Mon, 12
 Feb 2024 11:53:27 -0800 (PST)
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
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
 <ZcPMi6DX5PN4WwHr@google.com> <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
 <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
 <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com> <CAMgjq7A+B4s52XYOFSan0fzUV-7o-GeAD3pfKkQtHo6uPHbrxQ@mail.gmail.com>
In-Reply-To: <CAMgjq7A+B4s52XYOFSan0fzUV-7o-GeAD3pfKkQtHo6uPHbrxQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 13 Feb 2024 03:53:09 +0800
Message-ID: <CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMGde4Ov=gA@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Chris Li <chrisl@kernel.org>
Cc: "Huang, Ying" <ying.huang@intel.com>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 1:30=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrote=
:
>
> On Fri, Feb 9, 2024 at 3:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote=
:
> >
> > On Thu, Feb 8, 2024 at 11:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Thu, Feb 8, 2024 at 2:36=E2=80=AFPM Huang, Ying <ying.huang@intel.=
com> wrote:
> > > >
> > > > Kairui Song <ryncsn@gmail.com> writes:
> > > >
> > > > > On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kerne=
l.org> wrote:
> > > > >>
> > > > >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> > > >
> > > > [snip]
> > > >
> > > > >> >
> > > > >> > So I think the thing is, it's getting complex because this pat=
ch
> > > > >> > wanted to make it simple and just reuse the swap cache flags.
> > > > >>
> > > > >> I agree that a simple fix would be the important at this point.
> > > > >>
> > > > >> Considering your description, here's my understanding of the oth=
er idea:
> > > > >> Other method, such as increasing the swap count, haven't proven =
effective
> > > > >> in your tests. The approach risk forcing racers to rely on the s=
wap cache
> > > > >> again and the potential performance loss in race scenario.
> > > > >>
> > > > >> While I understand that simplicity is important, and performance=
 loss
> > > > >> in this case may be infrequent, I believe swap_count approach co=
uld be a
> > > > >> suitable solution. What do you think?
> > > > >
> > > > > Hi Minchan
> > > > >
> > > > > Yes, my main concern was about simplicity and performance.
> > > > >
> > > > > Increasing swap_count here will also race with another process fr=
om
> > > > > releasing swap_count to 0 (swapcache was able to sync callers in =
other
> > > > > call paths but we skipped swapcache here).
> > > >
> > > > What is the consequence of the race condition?
> > >
> > > Hi Ying,
> > >
> > > It will increase the swap count of an already freed entry, this race
> > > with multiple swap free/alloc logic that checks if count =3D=3D
> > > SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
> > > all result in random corruption of the swap map. This happens a lot
> > > during stress testing.
> >
> > In theory, the original code before your patch can get into a
> > situation similar to what you try to avoid.
> > CPU1 enters the do_swap_page() with entry swap count =3D=3D 1 and
> > continues handling the swap fault without swap cache.  Then some
> > operation bumps up the swap entry count and CPU2 enters the
> > do_swap_page() racing with CPU1 with swap count =3D=3D 2. CPU2 will nee=
d
> > to go through the swap cache case.  We still need to handle this
> > situation correctly.
>
> Hi Chris,
>
> This won't happen, nothing can bump the swap entry count unless it's
> swapped in and freed. There are only two places that call
> swap_duplicate: unmap or fork, unmap need page mapped and entry alloc,
> so it won't happen unless we hit the entry reuse issue. Fork needs the
> VMA lock which we hold it during page fault.
>
> > So the complexity is already there.
> >
> > If we can make sure the above case works correctly, then one way to
> > avoid the problem is just send the CPU2 to use the swap cache (without
> > the swap cache by-passing).
>
> Yes, more auditing of existing code and explanation is needed to
> ensure things won't go wrong, that's the reason I tried to avoid
> things from going too complex...
>
> > > > > So the right step is: 1. Lock the cluster/swap lock; 2. Check if =
still
> > > > > have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> > > > > __swap_duplicate can be modified to support this, it's similar to
> > > > > existing logics for SWAP_HAS_CACHE.
> > > > >
> > > > > And swap freeing path will do more things, swapcache clean up nee=
ds to
> > > > > be handled even in the bypassing path since the racer may add it =
to
> > > > > swapcache.
> > > > >
> > > > > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided =
many
> > > > > overhead, so I used that way in this patch, the only issue is
> > > > > potentially repeated page faults now.
> > > > >
> > > > > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'=
m bad
> > > > > at naming it) special value, so any racer can just spin on it to =
avoid
> > > > > all the problems, how do you think about this?
> > > >
> > > > Let's try some simpler method firstly.
> > >
> > > Another simpler idea is, add a schedule() or
> > > schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
> > > path before goto out (just like __read_swap_cache_async). I think thi=
s
> > > should ensure in almost all cases, PTE is ready after it returns, als=
o
> > > yields more CPU.
> >
> > I mentioned in my earlier email and Ying points out that as well.
> > Looping waiting inside do_swap_page() is bad because it is holding
> > other locks.
>
> It's not looping here though, just a tiny delay, since
> SWP_SYNCHRONOUS_IO is supposed to be super fast devices so a tiny
> delay should be enough.
>
> > Sorry I started this idea but it seems no good.
>
> Not at all, more reviewing helps to find a better solution :)
>
> > If we can have CPU2 make forward progress without retrying
> > the page fault would be the best, if possible.
>
> Yes, making CPU2 fall back to cached swapin path is doable after
> careful auditing. Just CPU2 is usually slower than CPU1 due to cache
> and timing, so what it does will most likely be in vain and need to be
> reverted, causing more work for both code logic and CPU. The case of
> the race (CPU2 went faster) is very rare.
>
> I'm not against the idea of bump count, it's better if things that can
> be done without introducing too much noise. Will come back after more
> tests and work on this.

Hi,

After some more testing, I still think bump swap count is a bad idea
here. Besides the issues I mentioned above, adding folio into cache is
fundamentally in conflict with the problem we are trying to solve:
folio in swapcache can be swapped out without allocating a new entry,
so the entry reuse issue will be much more serious.

If we want to avoid this we have to release the cache unconditionally
before folio unlock because it can't tell if there is a parallel cache
bypassing swapin going on or not. This is unacceptable, it breaks
normal usage of swap cache. There are also other potential issues like
read ahead, race causing stalled folio remain in swap cache, so I dont
think this is a good approach.

Instead if we add a schedule or schedule_timeout_uninterruptible(1),
it seems quite enough to avoid repeated page faults. I did following
test with the reproducer I provided in the commit message:

Using ZRAM instead of brd for more realistic workload:
$ perf stat -e minor-faults,major-faults -I 30000 ./a.out

Unpatched kernel:
#           time             counts unit events
    30.000096504             33,089      minor-faults:u
    30.000096504            958,745      major-faults:u
    60.000375308             22,150      minor-faults:u
    60.000375308          1,221,665      major-faults:u
    90.001062176             24,840      minor-faults:u
    90.001062176          1,005,427      major-faults:u
   120.004233268             23,634      minor-faults:u
   120.004233268          1,045,596      major-faults:u
   150.004530091             22,358      minor-faults:u
   150.004530091          1,097,871      major-faults:u

Patched kernel:
#           time             counts unit events
    30.000069753            280,094      minor-faults:u
    30.000069753          1,198,871      major-faults:u
    60.000415915            436,862      minor-faults:u
    60.000415915            919,860      major-faults:u
    90.000651670            359,176      minor-faults:u
    90.000651670            955,340      major-faults:u
   120.001088135            289,137      minor-faults:u
   120.001088135            992,317      major-faults:u

Indeed there is a huge increase of minor page faults, which indicate
the raced path returned without handling the fault. This reproducer
tries to maximize the race chance so the reading is more terrifying
than usual.

But after adding a schedule/schedule_timeout_uninterruptible(1) after
swapcache_prepare failed, still using the same test:

Patched kernel (adding a schedule() before goto out):
#           time             counts unit events
    30.000335901             43,066      minor-faults:u
    30.000335901          1,163,232      major-faults:u
    60.034629687             35,652      minor-faults:u
    60.034629687            844,188      major-faults:u
    90.034941472             34,957      minor-faults:u
    90.034941472          1,218,174      major-faults:u
   120.035255386             36,241      minor-faults:u
   120.035255386          1,073,395      major-faults:u
   150.035535786             33,057      minor-faults:u
   150.035535786          1,171,684      major-faults:u

Patched kernel (adding a schedule_timeout_uninterruptible(1) before goto ou=
t):
#           time             counts unit events
    30.000044452             26,748      minor-faults:u
    30.000044452          1,202,064      major-faults:u
    60.000317379             19,883      minor-faults:u
    60.000317379          1,186,152      major-faults:u
    90.000568779             18,333      minor-faults:u
    90.000568779          1,151,015      major-faults:u
   120.000787253             22,844      minor-faults:u
   120.000787253            887,531      major-faults:u
   150.001309065             18,900      minor-faults:u
   150.001309065          1,211,894      major-faults:u

The minor faults are basically the same as before, or even lower since
other races are also reduced, with no observable performance
regression so far.
If the vague margin of this schedule call is still concerning, I think
another approach is just a new swap map value for parallel cache
bypassed swapping to loop on.

