Return-Path: <linux-kernel+bounces-58633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E6284E914
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA1881F2FF11
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90AE381CB;
	Thu,  8 Feb 2024 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwyL+pHr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B12B3218B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707421350; cv=none; b=T7bmXrz39A143H4HHWViDkmqS6zfJWpHg0Bl/RPft7O+S7h/vpEBXixSpXh5aKXQnV1ZyvR+GYdLLQRrGVUlRwP+5oCPbjQ0BojR/ouaAI8vBdt8uXevrypXEtn2Ji68uBowx/nbYAmSrxtZinhht2iHU/OfywTYw45548Xdsdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707421350; c=relaxed/simple;
	bh=Rtu/dgNHowIMhZUa88CnntQ6SugfUthYsgnqdjsX7Go=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIkJSHfjQc1SrFRtIukefPneCuDQKgMBRG8U4CQXC78ZmCrd5CI3xhEQivME29tpCpXlwaSNex3lRpa2EyEF0Fp0BArRWWQmsjOR/bO+cskPU+oQfaGi/2QWANwcNOq8vOG5M2Ep0XAHh7/R1HHL2yl72g8tqijZaUzODbW98j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwyL+pHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF5EC43394
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707421349;
	bh=Rtu/dgNHowIMhZUa88CnntQ6SugfUthYsgnqdjsX7Go=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=nwyL+pHrtUggAFG7+gq7rpvp4fptaBg+1myWc3chKSCN2XvuCRzfkgy2Rilz3gP0T
	 IwCUG3APe8Gnp3Uzg1F1hfJKyN0dBFYEdb0nsfkHawXiKV44TY98l6Umq+r9OlEOK+
	 T4Yb7DlyaHmiqU3khye1tas4BiFKtbmvgm8pusH55z/xukK70zcFUbT1WMQ/BO2lLy
	 N4w3XWZIfHv3tmeYiR3wevs7VRZmd5VJtUIa4N1HJ5TOBktvgHDPe40V/GjQpCThPH
	 AWitEdB9uk5PtdOiTdtU/9RQPflOgF2UWmk/eK3kDpzFG7RZSCRHj/ORY65dhqPTPJ
	 WN6GI5SDvEUzA==
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7ba9f1cfe94so45042739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 11:42:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXZW14I/Wrc5hW0ULue83jUqXgthPMvTOGCCm6kTIL8aLP8GAj6wDPTDflf7k/7vhsGfle1QC904XlomK5/Be25KS6OkIFjn3O7VppB
X-Gm-Message-State: AOJu0YxpfCj09q5GXdGcuYRRu8CRA1KHx/bIwkDaIHvF66p/2yKXGwaY
	nX+q5k7yMFmdcCJuvN1PIYH9PsFwNsD7TVG4VzitIirAE4YROQrw393LJ5hwUYDwHi1vCB+qagi
	OrfsDHaTM9kWVjVafXBJqCbZn+ctzB9RQrmHD
X-Google-Smtp-Source: AGHT+IGcfRhtd9MGWZfmF3BJHfebS6aqh8aEn9feq7jKiTcP0qZsciSIAAE7Fq6y/oaDjz3cb6cf2XLBXQ6TGFiCDb8=
X-Received: by 2002:a92:d481:0:b0:363:8882:d86 with SMTP id
 p1-20020a92d481000000b0036388820d86mr501941ilg.1.1707421348650; Thu, 08 Feb
 2024 11:42:28 -0800 (PST)
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
In-Reply-To: <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 8 Feb 2024 11:42:16 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
Message-ID: <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Minchan Kim <minchan@kernel.org>, 
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 11:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Thu, Feb 8, 2024 at 2:36=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
> >
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> > > On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.or=
g> wrote:
> > >>
> > >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> >
> > [snip]
> >
> > >> >
> > >> > So I think the thing is, it's getting complex because this patch
> > >> > wanted to make it simple and just reuse the swap cache flags.
> > >>
> > >> I agree that a simple fix would be the important at this point.
> > >>
> > >> Considering your description, here's my understanding of the other i=
dea:
> > >> Other method, such as increasing the swap count, haven't proven effe=
ctive
> > >> in your tests. The approach risk forcing racers to rely on the swap =
cache
> > >> again and the potential performance loss in race scenario.
> > >>
> > >> While I understand that simplicity is important, and performance los=
s
> > >> in this case may be infrequent, I believe swap_count approach could =
be a
> > >> suitable solution. What do you think?
> > >
> > > Hi Minchan
> > >
> > > Yes, my main concern was about simplicity and performance.
> > >
> > > Increasing swap_count here will also race with another process from
> > > releasing swap_count to 0 (swapcache was able to sync callers in othe=
r
> > > call paths but we skipped swapcache here).
> >
> > What is the consequence of the race condition?
>
> Hi Ying,
>
> It will increase the swap count of an already freed entry, this race
> with multiple swap free/alloc logic that checks if count =3D=3D
> SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
> all result in random corruption of the swap map. This happens a lot
> during stress testing.

In theory, the original code before your patch can get into a
situation similar to what you try to avoid.
CPU1 enters the do_swap_page() with entry swap count =3D=3D 1 and
continues handling the swap fault without swap cache.  Then some
operation bumps up the swap entry count and CPU2 enters the
do_swap_page() racing with CPU1 with swap count =3D=3D 2. CPU2 will need
to go through the swap cache case.  We still need to handle this
situation correctly.
So the complexity is already there.

If we can make sure the above case works correctly, then one way to
avoid the problem is just send the CPU2 to use the swap cache (without
the swap cache by-passing).



>
> >
> > > So the right step is: 1. Lock the cluster/swap lock; 2. Check if stil=
l
> > > have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> > > __swap_duplicate can be modified to support this, it's similar to
> > > existing logics for SWAP_HAS_CACHE.
> > >
> > > And swap freeing path will do more things, swapcache clean up needs t=
o
> > > be handled even in the bypassing path since the racer may add it to
> > > swapcache.
> > >
> > > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
> > > overhead, so I used that way in this patch, the only issue is
> > > potentially repeated page faults now.
> > >
> > > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm ba=
d
> > > at naming it) special value, so any racer can just spin on it to avoi=
d
> > > all the problems, how do you think about this?
> >
> > Let's try some simpler method firstly.
>
> Another simpler idea is, add a schedule() or
> schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
> path before goto out (just like __read_swap_cache_async). I think this
> should ensure in almost all cases, PTE is ready after it returns, also
> yields more CPU.

I mentioned in my earlier email and Ying points out that as well.
Looping waiting inside do_swap_page() is bad because it is holding
other locks. Sorry I started this idea but it seems no good. If we can
have CPU2 make forward progress without retrying the page fault would
be the best, if possible.

Chris

