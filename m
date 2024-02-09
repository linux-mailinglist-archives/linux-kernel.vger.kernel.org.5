Return-Path: <linux-kernel+bounces-59020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A589B84EFED
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D21EB23ACD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401CC56B88;
	Fri,  9 Feb 2024 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMU+vTID"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D61D56B63;
	Fri,  9 Feb 2024 05:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707456647; cv=none; b=Jlu1z6q7q/wDwVV/EQtBMPcrq+AWce2ngcnqCUKVkWpISC1U1i3l6bmN9zX+soip+zW+Dz4RlC7McdyKr52zL49v21Q0jlL/RWolsicMjfH7bs9YwXytVylCZA6D/ax6firCTM7W9fOFubUuyyqFmkE6l9uLO/Zh/f9LLCirWaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707456647; c=relaxed/simple;
	bh=+tff2bs6/kgi3GGmnBg9T9adJJtNTjxqOTrIN9FQzSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HOCyh7wfEAe97CELAStF/6Hmpkb0ae7VlXb+WNq0kXgsZP900LBDOTMPAkhMApoRyXkUmuUNMT3JpENmUnxcY63uvOr+tThNivk4SwBlPDmG3vi64XhjPxXZL0xxLslU4XVgTEGyGeFR8yH/nzJmQ/iJ2V6DA+DWGrMavCJB2QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMU+vTID; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d0c9967fdcso16347271fa.0;
        Thu, 08 Feb 2024 21:30:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707456643; x=1708061443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnmEWz5a9VZuWo5s10vDw3zkzlf9uATYxTr3CqxCnlA=;
        b=IMU+vTIDVoW9Jtw1GS1onAbroJlcz+4u0oVC2+75AE4V9+3FxEeGyCQqzMNQuzpDg+
         dIPnZIixBi0TfUaElUEIRoJgEsGsG8SGFSXNewymHuYtLuWD0qAi8RWOsRYrSITmy9ru
         U6x6xtwWvSi7Bbp5hyB/mYxCx6o2rYLNfj7JnXNM7syAM9ZlW9e8ftAPQgg+2V8SmiSM
         mkvXgR7DQqeGBbiQhPy8C9oTBSUPzoziwfJbZ037DldcOxHRbTHkUazZVfETGKmhN9hm
         fC9UZ5y99W7AEqMjXUnwP5Vyt8I3ECFkQRpARM6OqsknWSt3k9JEZYz/4qy/nwdDD8VS
         FvBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707456643; x=1708061443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnmEWz5a9VZuWo5s10vDw3zkzlf9uATYxTr3CqxCnlA=;
        b=D6ve/FJbzafYIcmT82g+aCSvM4OwEtuCUHE+QScqHOHsnHxIJtRBEzOUxo1nDH00b3
         YnmmgoQZelsGVP3ODV3M/069HdcxXJ5SiaREyRDV15WCfCiMArD/JvgbOhNNjzgS0Nw3
         p3Hcn7SJ4iDcFr1lqWleoqJgj2h9bvydBDhhuq8B5LbRoi1UphaP/j8bWWJ74ztjOmW0
         GC3UcifIxM/7g4tPBFwqUrwwn9hOjT9hR+4BIDmNuj4iuLbzHm6TFIrONr9eRDbIKStW
         5pSTd0X5AySWpySO0vy6OxQg8S9ov0iR+oCR6yMe4mkJuI3tmWseeNRepilKQH8l28HH
         AkAw==
X-Gm-Message-State: AOJu0Yz6HoySoSOUVl+t7fl0Oe/IQM11hluPbozXZ6O+PSraYQ8HbnzC
	hlTYFGf2q3qbX585eNYqDTRaj5X7MxIaIa5azfW6U/rcicC+7mfBdYfBCfRabiC8Vo5C1H0ocaL
	kT1rUBtSFCTy+sH/Pndfe3xHULqA=
X-Google-Smtp-Source: AGHT+IG3UdXf8b1QaEDvzXBaD37F4gAJgiMom5kqohKio3STb9b4HlJpd+bvTLIXyQRvxZz3Fnm7rz2h+hM3UbHBlPs=
X-Received: by 2002:a2e:86d9:0:b0:2d0:9c60:4d73 with SMTP id
 n25-20020a2e86d9000000b002d09c604d73mr180202ljj.11.1707456643255; Thu, 08 Feb
 2024 21:30:43 -0800 (PST)
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
 <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
In-Reply-To: <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 9 Feb 2024 13:30:25 +0800
Message-ID: <CAMgjq7A+B4s52XYOFSan0fzUV-7o-GeAD3pfKkQtHo6uPHbrxQ@mail.gmail.com>
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

On Fri, Feb 9, 2024 at 3:42=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Feb 8, 2024 at 11:01=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wr=
ote:
> >
> > On Thu, Feb 8, 2024 at 2:36=E2=80=AFPM Huang, Ying <ying.huang@intel.co=
m> wrote:
> > >
> > > Kairui Song <ryncsn@gmail.com> writes:
> > >
> > > > On Thu, Feb 8, 2024 at 2:31=E2=80=AFAM Minchan Kim <minchan@kernel.=
org> wrote:
> > > >>
> > > >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> > >
> > > [snip]
> > >
> > > >> >
> > > >> > So I think the thing is, it's getting complex because this patch
> > > >> > wanted to make it simple and just reuse the swap cache flags.
> > > >>
> > > >> I agree that a simple fix would be the important at this point.
> > > >>
> > > >> Considering your description, here's my understanding of the other=
 idea:
> > > >> Other method, such as increasing the swap count, haven't proven ef=
fective
> > > >> in your tests. The approach risk forcing racers to rely on the swa=
p cache
> > > >> again and the potential performance loss in race scenario.
> > > >>
> > > >> While I understand that simplicity is important, and performance l=
oss
> > > >> in this case may be infrequent, I believe swap_count approach coul=
d be a
> > > >> suitable solution. What do you think?
> > > >
> > > > Hi Minchan
> > > >
> > > > Yes, my main concern was about simplicity and performance.
> > > >
> > > > Increasing swap_count here will also race with another process from
> > > > releasing swap_count to 0 (swapcache was able to sync callers in ot=
her
> > > > call paths but we skipped swapcache here).
> > >
> > > What is the consequence of the race condition?
> >
> > Hi Ying,
> >
> > It will increase the swap count of an already freed entry, this race
> > with multiple swap free/alloc logic that checks if count =3D=3D
> > SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
> > all result in random corruption of the swap map. This happens a lot
> > during stress testing.
>
> In theory, the original code before your patch can get into a
> situation similar to what you try to avoid.
> CPU1 enters the do_swap_page() with entry swap count =3D=3D 1 and
> continues handling the swap fault without swap cache.  Then some
> operation bumps up the swap entry count and CPU2 enters the
> do_swap_page() racing with CPU1 with swap count =3D=3D 2. CPU2 will need
> to go through the swap cache case.  We still need to handle this
> situation correctly.

Hi Chris,

This won't happen, nothing can bump the swap entry count unless it's
swapped in and freed. There are only two places that call
swap_duplicate: unmap or fork, unmap need page mapped and entry alloc,
so it won't happen unless we hit the entry reuse issue. Fork needs the
VMA lock which we hold it during page fault.

> So the complexity is already there.
>
> If we can make sure the above case works correctly, then one way to
> avoid the problem is just send the CPU2 to use the swap cache (without
> the swap cache by-passing).

Yes, more auditing of existing code and explanation is needed to
ensure things won't go wrong, that's the reason I tried to avoid
things from going too complex...

> > > > So the right step is: 1. Lock the cluster/swap lock; 2. Check if st=
ill
> > > > have swap_count =3D=3D 1, bail out if not; 3. Set it to 2;
> > > > __swap_duplicate can be modified to support this, it's similar to
> > > > existing logics for SWAP_HAS_CACHE.
> > > >
> > > > And swap freeing path will do more things, swapcache clean up needs=
 to
> > > > be handled even in the bypassing path since the racer may add it to
> > > > swapcache.
> > > >
> > > > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided ma=
ny
> > > > overhead, so I used that way in this patch, the only issue is
> > > > potentially repeated page faults now.
> > > >
> > > > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm =
bad
> > > > at naming it) special value, so any racer can just spin on it to av=
oid
> > > > all the problems, how do you think about this?
> > >
> > > Let's try some simpler method firstly.
> >
> > Another simpler idea is, add a schedule() or
> > schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
> > path before goto out (just like __read_swap_cache_async). I think this
> > should ensure in almost all cases, PTE is ready after it returns, also
> > yields more CPU.
>
> I mentioned in my earlier email and Ying points out that as well.
> Looping waiting inside do_swap_page() is bad because it is holding
> other locks.

It's not looping here though, just a tiny delay, since
SWP_SYNCHRONOUS_IO is supposed to be super fast devices so a tiny
delay should be enough.

> Sorry I started this idea but it seems no good.

Not at all, more reviewing helps to find a better solution :)

> If we can have CPU2 make forward progress without retrying
> the page fault would be the best, if possible.

Yes, making CPU2 fall back to cached swapin path is doable after
careful auditing. Just CPU2 is usually slower than CPU1 due to cache
and timing, so what it does will most likely be in vain and need to be
reverted, causing more work for both code logic and CPU. The case of
the race (CPU2 went faster) is very rare.

I'm not against the idea of bump count, it's better if things that can
be done without introducing too much noise. Will come back after more
tests and work on this.

