Return-Path: <linux-kernel+bounces-67536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8969856D29
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C61ACB21D1C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059731386C6;
	Thu, 15 Feb 2024 18:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XkKcG2r3"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ED21384B0;
	Thu, 15 Feb 2024 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708022967; cv=none; b=qZWreC07MYKghgab+VSfRYqPjdF18tOHkL8pqltarYGgCrzdJquSWn4raLDkq55nxVz6Smrh5ndvLv4Qh5O92IJ9wG3D3AkMQhX/X4+l28WxRk6ut416uCzze9vXCCMygn+WUDinOZiMI6rOqSE2pwRyyFCrJPUhLplWkoU5Wt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708022967; c=relaxed/simple;
	bh=n+/caBm2MEV+X8kdsWDICyVxMjQFRoQwKdK3Leyl3PA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dEvjgW0M2YTgjpfpFaXO8WggdTU1Qyo3Qt9DLnHuGTjPCcJtTlvCuwx0oCbRTYosVLLVWS3Wzgl9f6XSSPjm6s1u1AzxJSOcY9BNFLhSc1ZMBaD/V1OUBg8ceDZ3ZwDXvc97Q2/K9qZKdH4dQOvSnpC5+4VSIaefPmJcC18a0kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XkKcG2r3; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d10f52e7d8so13287741fa.3;
        Thu, 15 Feb 2024 10:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708022963; x=1708627763; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjmxs1/XFDuKA1CW6hbrEvgCagLuf21iVpMkEqqePsA=;
        b=XkKcG2r3V1g8aDLy+ENxK9H9cT+MUJhdWrfdgRJ2mr98+Dr7uszGzioWj2wMC/mXtA
         oyyeL4rj1Y4wiPfXsHZecDVL5BVhGi8/wsJvHfgn1ZIU+uEJNb5+1WUTK6/bW0UBeb7B
         x87aejwWm52ivRyr2ib9NLnp3cWNXbsgtUokEazqQb82eGBcA/4UcoEkXCX3athQMoFT
         y3IX2VLgaic8MyX3JBGDrPC9ydiab3mcYva7y3jPeLPZhH+O9jBDoNqsep7n9dzVCkV8
         4CKJPP8YJq/wOopZUvcQoS+9/AXCqbTSbB0xZ3rbiOgHM6hxT9Cq2koxJ/5bBBxhwhIv
         SfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708022963; x=1708627763;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mjmxs1/XFDuKA1CW6hbrEvgCagLuf21iVpMkEqqePsA=;
        b=QSMRcph06N0uAePmsveKtt5+bxf/BT74XqXWohh4DrkD/O0i3eveY4SWltUlAJU6iE
         RJXNAjDuElyjE47I7wZU+F8xKSZnX17G+easrLR+hg0Y8i9zoI+B/8cpLoONnEjC3LaF
         ywEKcKX7efRdvLyNexIeXUmVsq/hjlxUd4yFnrbtTnX2q+sPZEXn804uqTea5hsbLEO9
         pjUk1WOe4WpOjCNGUHdtIYlflerXFAqb0YgVKTXY9OcbAP+21w6Zaof/x3mUY72/p2bY
         SHVHuhp1X0Xjb/kDQEslJqD+wBL8SrSY9OVR6f/7GRHvpFWYapgnv7DOKHVUGraeafK/
         YZUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlNdtFXHwg2KuEQGMoacKfIiNFxQtN9ypajSKjREbk9hg6tMCfUcMWk8oKjgaFHFK3KpXtkF2P2E/TRxFiRdF+xMDPUPaYNpL7h76vCfhdIBZ9CyVXB1VxO72WqlBgKEagzJIN
X-Gm-Message-State: AOJu0Yx6COLa6rx/y1ew09EJiHeCOrqV85Sn8Ft+8/whQK5/Lb5JV/OA
	9SIN8PUH6wAnzhXXu9w6LY7qlUbTGPj9Z2HoDv0KCn0eZNGDdyIaQQE7lBBtevUmxxYWBs7X3us
	qkQezRHCFjZT6kquNx3mOz5fu0M4=
X-Google-Smtp-Source: AGHT+IGack4lWALoh4qTHm0VjSJHKO55NNraNbak/+vWzwZN8buGh6WtX8PXLzJGtR+arpXe5iDmxgFjm6KIbx9RgDI=
X-Received: by 2002:a2e:a706:0:b0:2d0:b646:3bc9 with SMTP id
 s6-20020a2ea706000000b002d0b6463bc9mr1656235lje.23.1708022962756; Thu, 15 Feb
 2024 10:49:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com> <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
In-Reply-To: <1d259a51-46e6-4d3b-9455-38dbcc17b168@redhat.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Fri, 16 Feb 2024 02:49:04 +0800
Message-ID: <CAMgjq7Cy3njsQzGi5Wa_JaM4NaO4eDGO5D8cY+KEB0ERd_JrGw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 11:36=E2=80=AFPM David Hildenbrand <david@redhat.co=
m> wrote:
> On 06.02.24 19:25, Kairui Song wrote:
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
> > ...                                  set_pte_at()
> >                                       swap_free() <- entry is free
> >                                       <write to page B, now page A stal=
led>
> >                                       <swap out page B to same swap ent=
ry>
> > pte_same() <- Check pass, PTE seems
> >                unchanged, but page A
> >                is stalled!
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
> > after PT unlocked. Racers will simply busy wait since it's a rare
> > and very short event.
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
> >    Polulating 32MB of memory region...
> >    Keep swapping out...
> >    Starting round 0...
> >    Spawning 65536 workers...
> >    32746 workers spawned, wait for done...
> >    Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
> >    Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
> >    Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
> >    Round 0 Failed, 15 data loss!
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
> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.cc=
r.corp.intel.com/
> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stres=
s-race [1]
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > Acked-by: Yu Zhao <yuzhao@google.com>
> >
> > ---
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
> >   include/linux/swap.h |  5 +++++
> >   mm/memory.c          | 15 +++++++++++++++
> >   mm/swap.h            |  5 +++++
> >   mm/swapfile.c        | 13 +++++++++++++
> >   4 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 4db00ddad261..8d28f6091a32 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
> >       return 0;
> >   }
> >
> > +static inline int swapcache_prepare(swp_entry_t swp)
> > +{
> > +     return 0;
> > +}
> > +
> >   static inline void swap_free(swp_entry_t swp)
> >   {
> >   }
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 7e1f4849463a..1749c700823d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >       if (!folio) {
> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                   __swap_count(entry) =3D=3D 1) {
> > +                     /*
> > +                      * Prevent parallel swapin from proceeding with
> > +                      * the cache flag. Otherwise, another thread may
> > +                      * finish swapin first, free the entry, and swapo=
ut
> > +                      * reusing the same entry. It's undetectable as
> > +                      * pte_same() returns true due to entry reuse.
> > +                      */
> > +                     if (swapcache_prepare(entry))
> > +                             goto out;
> > +
>
> Is there anything that guarantees that the following won't
> happen concurrently, and if it would happen, could it be a problem?
>
> Other thread MADV_DONTNEED's the swap entry, swap slot is freed.
> Some other page gets swapped out, reuses that swap slot.

Hi David,

Thanks for adding more comments and sharing your thoughts!

I'm not sure what you mean by "reuses that swap slot" here, I think
you just mean reuse that swap entry (and the actual content on swap
device)?

> We call swapcache_prepare() on that slot that is being reused
> elsewhere. (possibly some other thread in the context of the reuses
> swap slot might do the same!)

I think this kind of swapcache_prepare() or false swapin read is
already happening quite frequently by swap readaheads. I've seen swap
cluster readahead mess up working set activation and memory policy
already. Swap cluster readahead simply read in nearby entries of
target entry, regardless of whether they are owned by the reader or
not.

For this patch, similar issues also exist, I think it only hurts the
performance, but that's a really rare thing to happen, so should not
be a problem.

>
> We would detect later, that the PTE changed, but we would temporarily
> mess with that swap slot that we might no longer "own".
>
> I was thinking about alternatives, it's tricky because of the concurrent
> MADV_DONTNEED possibility. Something with another fake-swap entry type
> (similar to migration entries) might work, but would require more changes=
.

Yeah, in the long term I also think more work is needed for the swap subsys=
tem.

In my opinion, for this particular issue, or, for cache bypassed
swapin, a new swap map value similar to SWAP_MAP_BAD/SWAP_MAP_SHMEM
might be needed, that may even help to simplify the swap count release
routine for cache bypassed swapin, and improve the performance.

