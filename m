Return-Path: <linux-kernel+bounces-66191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E472855862
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 01:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9CA285125
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD69BED9;
	Thu, 15 Feb 2024 00:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAPsJzE9"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82C0623;
	Thu, 15 Feb 2024 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707957860; cv=none; b=YrhLYBdGW6IDA8TNIPrhaIrZgagl5M7Dif4Q6utt/wXsAMOvkoB5K39gC9OWvpgG/xSgVQ/rSW5eeazCDAsgp4+uKTl5yplbqnfph2wi6qMoJ//mEUZi3Fm2YelNzEwtvvlFumEdW4syy1RgE+FZWXcQ0Qp0st9DDSHsZ9yWwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707957860; c=relaxed/simple;
	bh=lRVVMnxSv8p5u7VkRE5GnF1jgycyhab4L6goNWPE7es=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWAFQuin3OSXCvx2nR0yLOeAIZrhqii833Qnf5LDwv/WyJF8EK9fqlTokOBexlENCjrwMPyWV9MQGe/rCm6heIf2etaR0ozLwsdJ/rm5R34scrhagkUI3GIOcgtdBtCvJfWfnfGbhzOerll98GWx87A9Is+h6ADgOzSN9byadPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAPsJzE9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d70b0e521eso2632845ad.1;
        Wed, 14 Feb 2024 16:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707957858; x=1708562658; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v0IOozxc9pPX/tQufgjCUsjtIdktPjhqKeQuwoGygOY=;
        b=TAPsJzE9O8P79EfM1wRh5+LHwnGQV5PWuTfb1WgrwT6pZaDkRjY3XH6E1KB1d31ygx
         xeYkm72Iss5sgQOgV4UszdHGKQrr3bDTGcnwIb5CH4tv6rdxKUX0Ape/5dFXvprJYoC/
         ie9QvTbBquSw31XoQAeOmN+PC1Bm9St0sk0Rn4rP/daVIFcvaMP/5vDOjoXBoHkMR5v3
         /h/7zsLcxi/iWgenN/o9oXln2SgasBkZcQHcdHgOmVuS8ngOU8Lc19rxiqnh+NC95BYW
         nIEyIPwZCyiZVWCyBvBIqh7eVYehmxjHt5dXh/rcsz/4p8jGlacF60G0QvPkhPT1EKBa
         WuOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707957858; x=1708562658;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v0IOozxc9pPX/tQufgjCUsjtIdktPjhqKeQuwoGygOY=;
        b=eVcTCubc9csLsVk5mZVExO3HidgCwE6RyWLolOJO3XcVaNaEANbogkAuxtqjrtAC9D
         U3NvD3ZZcMkfq0y9TsvxTtXPOZIm4dgfLnQI9ZPlCYmNdCx15aCaco3uIHtWEe6lLDJf
         CbbZvnINDEEEmrKr8q6E5P0aWGk82K1LANQGtUnTOz7njzdyXUqwpEsyIO+aqmn1oACZ
         DQeeOw6K8EZT6K/ZZAV2o6WONeqHmoGRYISxPzbi0a745HWM0tiKKJEnS4R4TuaEJLJN
         Grac8TvCqNjvrrJJ6rQp0s32cZGwghuykCEYB0YbVGUV39QFGWUxUtDqJA6nqmxE5ru3
         Lwlw==
X-Forwarded-Encrypted: i=1; AJvYcCV10WBH1vYXwCUMPYZSflChYfYh+C5XGVHKENc5otmdfQNPfhmXH0y1MrOw/M75rlt+FqlwT/mNiJ8EnwFVvyl3kALKfCwSRFVbYgwWSOUlBE0ob+jXloz/Hl1bRa1nMVLvJ9dh
X-Gm-Message-State: AOJu0Yy+lFdp7OE/7Tcj+Q4Sf/zBafcKIk7n6mrofMdLGs15oeQ6WT61
	nSqmQSP5qcVqKgCtpMk+ToM1dtNjfPaXAygszCECuOFMDY0ZZMIM
X-Google-Smtp-Source: AGHT+IESPmDs3SDqnuC4XZSDz8OvmdID20fX33yEAO++64dbip+o7i6RsA4LQItbqlW+jlyVVkCl4g==
X-Received: by 2002:a17:902:f812:b0:1db:466d:f309 with SMTP id ix18-20020a170902f81200b001db466df309mr206701plb.49.1707957858055;
        Wed, 14 Feb 2024 16:44:18 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:c38e:7969:a636:ba7f])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902729700b001d8a93fa5b1sm45782pll.131.2024.02.14.16.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 16:44:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date: Wed, 14 Feb 2024 16:44:14 -0800
From: Minchan Kim <minchan@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: Chris Li <chrisl@kernel.org>, "Huang, Ying" <ying.huang@intel.com>,
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Yu Zhao <yuzhao@google.com>, Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Message-ID: <Zc1eXmliu09sElxQ@google.com>
References: <CAMgjq7CV-Cxar8cRj1SxB4ZtO8QPTUuA5mj9_vQro7sm+eFH=w@mail.gmail.com>
 <CAF8kJuOQqqqM6MvOvo4PyOhT9eyNFreQjWC+TybGYDgXRfpweA@mail.gmail.com>
 <CAMgjq7CBV4dVo7ETr0K1VbLE=M7T0Go5=7pHBUY6=o0cuXaZXg@mail.gmail.com>
 <ZcPMi6DX5PN4WwHr@google.com>
 <CAMgjq7AJo1SKzRc-w5UuK3Ojk5PaXxRV2_G2Ww9BGgiNRp_5Eg@mail.gmail.com>
 <87eddnxy47.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7Cg+8zy25Cif2DJ0Qey3bC=Ni0q7xHNO9ka+ezoK1rgxA@mail.gmail.com>
 <CAF8kJuNXr7CT7-homTfOX=XYfie2woPbcS9sKkt4R3HSiHUmng@mail.gmail.com>
 <CAMgjq7A+B4s52XYOFSan0fzUV-7o-GeAD3pfKkQtHo6uPHbrxQ@mail.gmail.com>
 <CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMGde4Ov=gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMGde4Ov=gA@mail.gmail.com>

Hi Kairui,

On Tue, Feb 13, 2024 at 03:53:09AM +0800, Kairui Song wrote:
> On Fri, Feb 9, 2024 at 1:30 PM Kairui Song <ryncsn@gmail.com> wrote:
> >
> > On Fri, Feb 9, 2024 at 3:42 AM Chris Li <chrisl@kernel.org> wrote:
> > >
> > > On Thu, Feb 8, 2024 at 11:01 AM Kairui Song <ryncsn@gmail.com> wrote:
> > > >
> > > > On Thu, Feb 8, 2024 at 2:36 PM Huang, Ying <ying.huang@intel.com> wrote:
> > > > >
> > > > > Kairui Song <ryncsn@gmail.com> writes:
> > > > >
> > > > > > On Thu, Feb 8, 2024 at 2:31 AM Minchan Kim <minchan@kernel.org> wrote:
> > > > > >>
> > > > > >> On Wed, Feb 07, 2024 at 12:06:15PM +0800, Kairui Song wrote:
> > > > >
> > > > > [snip]
> > > > >
> > > > > >> >
> > > > > >> > So I think the thing is, it's getting complex because this patch
> > > > > >> > wanted to make it simple and just reuse the swap cache flags.
> > > > > >>
> > > > > >> I agree that a simple fix would be the important at this point.
> > > > > >>
> > > > > >> Considering your description, here's my understanding of the other idea:
> > > > > >> Other method, such as increasing the swap count, haven't proven effective
> > > > > >> in your tests. The approach risk forcing racers to rely on the swap cache
> > > > > >> again and the potential performance loss in race scenario.
> > > > > >>
> > > > > >> While I understand that simplicity is important, and performance loss
> > > > > >> in this case may be infrequent, I believe swap_count approach could be a
> > > > > >> suitable solution. What do you think?
> > > > > >
> > > > > > Hi Minchan
> > > > > >
> > > > > > Yes, my main concern was about simplicity and performance.
> > > > > >
> > > > > > Increasing swap_count here will also race with another process from
> > > > > > releasing swap_count to 0 (swapcache was able to sync callers in other
> > > > > > call paths but we skipped swapcache here).
> > > > >
> > > > > What is the consequence of the race condition?
> > > >
> > > > Hi Ying,
> > > >
> > > > It will increase the swap count of an already freed entry, this race
> > > > with multiple swap free/alloc logic that checks if count ==
> > > > SWAP_HAS_CACHE or sets count to zero, or repeated free of an entry,
> > > > all result in random corruption of the swap map. This happens a lot
> > > > during stress testing.
> > >
> > > In theory, the original code before your patch can get into a
> > > situation similar to what you try to avoid.
> > > CPU1 enters the do_swap_page() with entry swap count == 1 and
> > > continues handling the swap fault without swap cache.  Then some
> > > operation bumps up the swap entry count and CPU2 enters the
> > > do_swap_page() racing with CPU1 with swap count == 2. CPU2 will need
> > > to go through the swap cache case.  We still need to handle this
> > > situation correctly.
> >
> > Hi Chris,
> >
> > This won't happen, nothing can bump the swap entry count unless it's
> > swapped in and freed. There are only two places that call
> > swap_duplicate: unmap or fork, unmap need page mapped and entry alloc,
> > so it won't happen unless we hit the entry reuse issue. Fork needs the
> > VMA lock which we hold it during page fault.
> >
> > > So the complexity is already there.
> > >
> > > If we can make sure the above case works correctly, then one way to
> > > avoid the problem is just send the CPU2 to use the swap cache (without
> > > the swap cache by-passing).
> >
> > Yes, more auditing of existing code and explanation is needed to
> > ensure things won't go wrong, that's the reason I tried to avoid
> > things from going too complex...
> >
> > > > > > So the right step is: 1. Lock the cluster/swap lock; 2. Check if still
> > > > > > have swap_count == 1, bail out if not; 3. Set it to 2;
> > > > > > __swap_duplicate can be modified to support this, it's similar to
> > > > > > existing logics for SWAP_HAS_CACHE.
> > > > > >
> > > > > > And swap freeing path will do more things, swapcache clean up needs to
> > > > > > be handled even in the bypassing path since the racer may add it to
> > > > > > swapcache.
> > > > > >
> > > > > > Reusing SWAP_HAS_CACHE seems to make it much simpler and avoided many
> > > > > > overhead, so I used that way in this patch, the only issue is
> > > > > > potentially repeated page faults now.
> > > > > >
> > > > > > I'm currently trying to add a SWAP_MAP_LOCK (or SWAP_MAP_SYNC, I'm bad
> > > > > > at naming it) special value, so any racer can just spin on it to avoid
> > > > > > all the problems, how do you think about this?
> > > > >
> > > > > Let's try some simpler method firstly.
> > > >
> > > > Another simpler idea is, add a schedule() or
> > > > schedule_timeout_uninterruptible(1) in the swapcache_prepare failure
> > > > path before goto out (just like __read_swap_cache_async). I think this
> > > > should ensure in almost all cases, PTE is ready after it returns, also
> > > > yields more CPU.
> > >
> > > I mentioned in my earlier email and Ying points out that as well.
> > > Looping waiting inside do_swap_page() is bad because it is holding
> > > other locks.
> >
> > It's not looping here though, just a tiny delay, since
> > SWP_SYNCHRONOUS_IO is supposed to be super fast devices so a tiny
> > delay should be enough.
> >
> > > Sorry I started this idea but it seems no good.
> >
> > Not at all, more reviewing helps to find a better solution :)
> >
> > > If we can have CPU2 make forward progress without retrying
> > > the page fault would be the best, if possible.
> >
> > Yes, making CPU2 fall back to cached swapin path is doable after
> > careful auditing. Just CPU2 is usually slower than CPU1 due to cache
> > and timing, so what it does will most likely be in vain and need to be
> > reverted, causing more work for both code logic and CPU. The case of
> > the race (CPU2 went faster) is very rare.
> >
> > I'm not against the idea of bump count, it's better if things that can
> > be done without introducing too much noise. Will come back after more
> > tests and work on this.
> 
> Hi,
> 
> After some more testing, I still think bump swap count is a bad idea
> here. Besides the issues I mentioned above, adding folio into cache is
> fundamentally in conflict with the problem we are trying to solve:
> folio in swapcache can be swapped out without allocating a new entry,
> so the entry reuse issue will be much more serious.
> 
> If we want to avoid this we have to release the cache unconditionally
> before folio unlock because it can't tell if there is a parallel cache
> bypassing swapin going on or not. This is unacceptable, it breaks
> normal usage of swap cache. There are also other potential issues like
> read ahead, race causing stalled folio remain in swap cache, so I dont
> think this is a good approach.

I also played the swap refcount stuff ideas and encoutered a lot
problems(e.g., kernel crash and/or data missing).

Now I realize your original solution would be best to fix under such a
small change.

Folks, please chime in if you have another idea.


> 
> Instead if we add a schedule or schedule_timeout_uninterruptible(1),

How much your workload is going If we use schedule instead of
schedule_timeout_uninterruptible(1)? If that doesn't increase the
statistics a lot, I prefer the schedule.
(TBH, I didn't care much about the stat since it would be
very rare).


> it seems quite enough to avoid repeated page faults. I did following
> test with the reproducer I provided in the commit message:
> 
> Using ZRAM instead of brd for more realistic workload:
> $ perf stat -e minor-faults,major-faults -I 30000 ./a.out
> 
> Unpatched kernel:
> #           time             counts unit events
>     30.000096504             33,089      minor-faults:u
>     30.000096504            958,745      major-faults:u
>     60.000375308             22,150      minor-faults:u
>     60.000375308          1,221,665      major-faults:u
>     90.001062176             24,840      minor-faults:u
>     90.001062176          1,005,427      major-faults:u
>    120.004233268             23,634      minor-faults:u
>    120.004233268          1,045,596      major-faults:u
>    150.004530091             22,358      minor-faults:u
>    150.004530091          1,097,871      major-faults:u
> 
> Patched kernel:
> #           time             counts unit events
>     30.000069753            280,094      minor-faults:u
>     30.000069753          1,198,871      major-faults:u
>     60.000415915            436,862      minor-faults:u
>     60.000415915            919,860      major-faults:u
>     90.000651670            359,176      minor-faults:u
>     90.000651670            955,340      major-faults:u
>    120.001088135            289,137      minor-faults:u
>    120.001088135            992,317      major-faults:u
> 
> Indeed there is a huge increase of minor page faults, which indicate
> the raced path returned without handling the fault. This reproducer
> tries to maximize the race chance so the reading is more terrifying
> than usual.
> 
> But after adding a schedule/schedule_timeout_uninterruptible(1) after
> swapcache_prepare failed, still using the same test:
> 
> Patched kernel (adding a schedule() before goto out):
> #           time             counts unit events
>     30.000335901             43,066      minor-faults:u
>     30.000335901          1,163,232      major-faults:u
>     60.034629687             35,652      minor-faults:u
>     60.034629687            844,188      major-faults:u
>     90.034941472             34,957      minor-faults:u
>     90.034941472          1,218,174      major-faults:u
>    120.035255386             36,241      minor-faults:u
>    120.035255386          1,073,395      major-faults:u
>    150.035535786             33,057      minor-faults:u
>    150.035535786          1,171,684      major-faults:u
> 
> Patched kernel (adding a schedule_timeout_uninterruptible(1) before goto out):
> #           time             counts unit events
>     30.000044452             26,748      minor-faults:u
>     30.000044452          1,202,064      major-faults:u
>     60.000317379             19,883      minor-faults:u
>     60.000317379          1,186,152      major-faults:u
>     90.000568779             18,333      minor-faults:u
>     90.000568779          1,151,015      major-faults:u
>    120.000787253             22,844      minor-faults:u
>    120.000787253            887,531      major-faults:u
>    150.001309065             18,900      minor-faults:u
>    150.001309065          1,211,894      major-faults:u
> 
> The minor faults are basically the same as before, or even lower since
> other races are also reduced, with no observable performance
> regression so far.
> If the vague margin of this schedule call is still concerning, I think
> another approach is just a new swap map value for parallel cache
> bypassed swapping to loop on.

Long term, the swap map vaule would be good but for now, I prefer
your original solution with some delay with schedule.

Thanks, Kairui!

