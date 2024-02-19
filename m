Return-Path: <linux-kernel+bounces-70830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B6859CDD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B5C282CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EE8208DA;
	Mon, 19 Feb 2024 07:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VbAwplfO"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD15820DCB;
	Mon, 19 Feb 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327792; cv=none; b=M1ZSTPSBU2rQBWRGPTyVXbFgy5eTwDgLfczo3fj/H26UgUf0As9qwgR+iu6D4B39RE+RKpx7kBPEYlOjo7//WXjJzQsPLYRdrNP52GkS+/8zSCpenMjkuHRV64wH0nnPKEIMmEMRbyYiB9T5CyskSgsYgeNET44/UT7cA5hmEkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327792; c=relaxed/simple;
	bh=CcguIBEyUZfrIQCJT2cSGh1qgMmycC5HEpnODrXHg5M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lDvlcIRqh33kjwn47MNOROT8jYoqs3ktM/eUU2fEm0iJ7syKwf+EhXooyF7Sr2rnUFjEqF5Io92B2tWE7vKf2PEYXKJybLTy1wsFDQrPgzy0aPoyGUgpNo1nvugT87qsDdn2UPetlv78kzKnmTb0ayK2p1UW7LdvrVyqeu/ME1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VbAwplfO; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d220e39907so32529101fa.1;
        Sun, 18 Feb 2024 23:29:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708327789; x=1708932589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X4jRpIVVFkwHJggu+vIwvnZ/bia4Q4PW4RNzbM25CuI=;
        b=VbAwplfO33T0wYoNpUjH299iTjwDQrfkTUHJqm8I6ust79mIXHPzdD937s1XDnpJLV
         9UZRfGF8yhV17v+G3a4i8Tod3eNfBEj9ZGaCBM1F6H9FXS8hQPeyl4UwnWcXImw3tRQg
         Vx5Y/UXnmsXWrQtfdDTNE0RrP+LhFec5D6TeiLwU+O1sMNeFsi3LN2BoDELqVVa4QuwP
         SlVExVhwJ592Cp6DZnJbD6jOkurxCn+RNfTZ5+skeZnz+6g9NAaU/bJH4lggSzilN+UL
         EAZK732jeYPLnaA/AZTuCQY+DsUnQaGzj4Rfh1GmcN6Z9y08/64kRSCm5bhB1vF9//Ed
         afGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327789; x=1708932589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X4jRpIVVFkwHJggu+vIwvnZ/bia4Q4PW4RNzbM25CuI=;
        b=gmhA1ImytX4h7+lpTjeE3tJQqg/kPRMjFli/6xdX+Nq9mDj0uiyHR35LshfPR8upSq
         SPyqhcXuzGy3eowNeBwDhuaw0VkKBPNtyBMW5DWOPt8LIrZ7CW9zVhpozLXZyn5ch/H9
         jQWMb+wY5FZe9LLf4YTtT+LRGiU+ThGsO6uJQTfSM3VjR9nRlnpi05l35IPusY+dYTzs
         BDQuR6XB0mAw7I62SdW2LDiVzBH/fOnTL3zIotUENs9Wn2Zhp9Q1iPQXDx2OhutyvL4t
         YO6lFa4vonXnOXhUItl+xo/xhJQKKt+Zfb8TLt87FdE7DsqNNWnQ8BvBtYyqxJNQJLNi
         z4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCX/4Ujnszevw7TtNumGYeZSNbxB98YzMLsVij8YdK/6juZMMoWSpOeuu/hJK/q5j8Wy7rkzz3GsoSwf7ES+yHMWaJmXVmLqugm72GKxXgtlelse35S4OiZjFhGwhrDMdRi20053
X-Gm-Message-State: AOJu0YwInLqiZarjNBsvKHKZu7dUcSWhqc/MOxlYYFdHQiNboLVeLVq6
	00yks7kzoZ+Lb/Swkp3ybBk4ERB1Fj9m7yIJiaHQVbegLa8SVNYTmuxVHI8fv23lZWMmXd5sEHJ
	vUHkPftaQlIcescxi6OYjrS26d8c=
X-Google-Smtp-Source: AGHT+IEbNABZCLhbmvv2aI0SPEB1mHThVrIE6LTbEDZETMMxMcJH7KU150K/Nlpe3ibR+BNbbG2Etsnvg8qpouaTfX4=
X-Received: by 2002:a2e:3318:0:b0:2d2:426b:455c with SMTP id
 d24-20020a2e3318000000b002d2426b455cmr185931ljc.0.1708327788596; Sun, 18 Feb
 2024 23:29:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240216095105.14502-1-ryncsn@gmail.com> <87wmr2rx4a.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7CArJDbEev3YR2OB4aZjE9n6PzuzC6WLmsxCKhwq-jb3Q@mail.gmail.com>
 <87jzn1s2xe.fsf@yhuang6-desk2.ccr.corp.intel.com> <87frxprxm8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <CAMgjq7C4UmRgrqycrM=Na18+ONeFT57_Nr6b2jhbKb=7f10YMA@mail.gmail.com>
In-Reply-To: <CAMgjq7C4UmRgrqycrM=Na18+ONeFT57_Nr6b2jhbKb=7f10YMA@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Mon, 19 Feb 2024 15:29:31 +0800
Message-ID: <CAMgjq7ATVuaGk3tRh6pk4ttV574fk5aYC7SvR4ggFAgpbmzNxg@mail.gmail.com>
Subject: Re: [PATCH v3] mm/swap: fix race when skipping swapcache
To: "Huang, Ying" <ying.huang@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Aaron Lu <aaron.lu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 11:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> On Mon, Feb 19, 2024 at 10:35=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
> > "Huang, Ying" <ying.huang@intel.com> writes:
> > > Kairui Song <ryncsn@gmail.com> writes:
> > >
> > >> On Sun, Feb 18, 2024 at 4:34=E2=80=AFPM Huang, Ying <ying.huang@inte=
l.com> wrote:
> > >>>
> > >>> Kairui Song <ryncsn@gmail.com> writes:
> > >>>
> > >>> > From: Kairui Song <kasong@tencent.com>
> > >>> >
> > >>> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more th=
reads
> > >>> > swapin the same entry at the same time, they get different pages =
(A, B).
> > >>> > Before one thread (T0) finishes the swapin and installs page (A)
> > >>> > to the PTE, another thread (T1) could finish swapin of page (B),
> > >>> > swap_free the entry, then swap out the possibly modified page
> > >>> > reusing the same entry. It breaks the pte_same check in (T0) beca=
use
> > >>> > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > >>> > install a stalled page (A) into the PTE and cause data corruption=
.
> > >>> >
> > >>> > One possible callstack is like this:
> > >>> >
> > >>> > CPU0                                 CPU1
> > >>> > ----                                 ----
> > >>> > do_swap_page()                       do_swap_page() with same ent=
ry
> > >>> > <direct swapin path>                 <direct swapin path>
> > >>> > <alloc page A>                       <alloc page B>
> > >>> > swap_read_folio() <- read to page A  swap_read_folio() <- read to=
 page B
> > >>> > <slow on later locks or interrupt>   <finished swapin first>
> > >>> > ...                                  set_pte_at()
> > >>> >                                      swap_free() <- entry is free
> > >>> >                                      <write to page B, now page A=
 stalled>
> > >>> >                                      <swap out page B to same swa=
p entry>
> > >>> > pte_same() <- Check pass, PTE seems
> > >>> >               unchanged, but page A
> > >>> >               is stalled!
> > >>> > swap_free() <- page B content lost!
> > >>> > set_pte_at() <- staled page A installed!
> > >>> >
> > >>> > And besides, for ZRAM, swap_free() allows the swap device to disc=
ard
> > >>> > the entry content, so even if page (B) is not modified, if
> > >>> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> > >>> > it may also cause data loss.
> > >>> >
> > >>> > To fix this, reuse swapcache_prepare which will pin the swap entr=
y using
> > >>> > the cache flag, and allow only one thread to pin it. Release the =
pin
> > >>> > after PT unlocked. Racers will simply wait since it's a rare and =
very
> > >>> > short event. A schedule() call is added to avoid wasting too much=
 CPU
> > >>> > or adding too much noise to perf statistics
> > >>> >
> > >>> > Other methods like increasing the swap count don't seem to be a g=
ood
> > >>> > idea after some tests, that will cause racers to fall back to use=
 the
> > >>> > swap cache again. Parallel swapin using different methods leads t=
o
> > >>> > a much more complex scenario.
> > >>>
> > >>> The swap entry may be put in swap cache by some parallel code path
> > >>> anyway.  So, we always need to consider that when reasoning the cod=
e.
> > >>>
> > >>> > Reproducer:
> > >>> >
> > >>> > This race issue can be triggered easily using a well constructed
> > >>> > reproducer and patched brd (with a delay in read path) [1]:
> > >>> >
> > >>> > With latest 6.8 mainline, race caused data loss can be observed e=
asily:
> > >>> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
> > >>> >   Polulating 32MB of memory region...
> > >>> >   Keep swapping out...
> > >>> >   Starting round 0...
> > >>> >   Spawning 65536 workers...
> > >>> >   32746 workers spawned, wait for done...
> > >>> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data lo=
ss!
> > >>> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data l=
oss!
> > >>> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data l=
oss!
> > >>> >   Round 0 Failed, 15 data loss!
> > >>> >
> > >>> > This reproducer spawns multiple threads sharing the same memory r=
egion
> > >>> > using a small swap device. Every two threads updates mapped pages=
 one by
> > >>> > one in opposite direction trying to create a race, with one dedic=
ated
> > >>> > thread keep swapping out the data out using madvise.
> > >>> >
> > >>> > The reproducer created a reproduce rate of about once every 5 min=
utes,
> > >>> > so the race should be totally possible in production.
> > >>> >
> > >>> > After this patch, I ran the reproducer for over a few hundred rou=
nds
> > >>> > and no data loss observed.
> > >>> >
> > >>> > Performance overhead is minimal, microbenchmark swapin 10G from 3=
2G
> > >>> > zram:
> > >>> >
> > >>> > Before:     10934698 us
> > >>> > After:      11157121 us
> > >>> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
> > >>> >
> > >>> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of sync=
hronous device")
> > >>> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap=
-stress-race [1]
> > >>> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
> > >>> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-de=
sk2.ccr.corp.intel.com/
> > >>> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > >>> > Cc: stable@vger.kernel.org
> > >>> >
> > >>> > ---
> > >>> > Update from V2:
> > >>> > - Add a schedule() if raced to prevent repeated page faults wasti=
ng CPU
> > >>> >   and add noise to perf statistics.
> > >>> > - Use a bool to state the special case instead of reusing existin=
g
> > >>> >   variables fixing error handling [Minchan Kim].
> > >>> >
> > >>> > V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gma=
il.com/
> > >>> >
> > >>> > Update from V1:
> > >>> > - Add some words on ZRAM case, it will discard swap content on sw=
ap_free so the race window is a bit different but cure is the same. [Barry =
Song]
> > >>> > - Update comments make it cleaner [Huang, Ying]
> > >>> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seong=
Jae Park]
> > >>> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS=
_IO instead of "direct swapin path" [Yu Zhao]
> > >>> > - Update commit message.
> > >>> > - Collect Review and Acks.
> > >>> >
> > >>> > V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmai=
l.com/
> > >>> >
> > >>> >  include/linux/swap.h |  5 +++++
> > >>> >  mm/memory.c          | 20 ++++++++++++++++++++
> > >>> >  mm/swap.h            |  5 +++++
> > >>> >  mm/swapfile.c        | 13 +++++++++++++
> > >>> >  4 files changed, 43 insertions(+)
> > >>> >
> > >>> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > >>> > index 4db00ddad261..8d28f6091a32 100644
> > >>> > --- a/include/linux/swap.h
> > >>> > +++ b/include/linux/swap.h
> > >>> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t=
 swp)
> > >>> >       return 0;
> > >>> >  }
> > >>> >
> > >>> > +static inline int swapcache_prepare(swp_entry_t swp)
> > >>> > +{
> > >>> > +     return 0;
> > >>> > +}
> > >>> > +
> > >>> >  static inline void swap_free(swp_entry_t swp)
> > >>> >  {
> > >>> >  }
> > >>> > diff --git a/mm/memory.c b/mm/memory.c
> > >>> > index 7e1f4849463a..7059230d0a54 100644
> > >>> > --- a/mm/memory.c
> > >>> > +++ b/mm/memory.c
> > >>> > @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vm=
f)
> > >>> >       struct page *page;
> > >>> >       struct swap_info_struct *si =3D NULL;
> > >>> >       rmap_t rmap_flags =3D RMAP_NONE;
> > >>> > +     bool need_clear_cache =3D false;
> > >>> >       bool exclusive =3D false;
> > >>> >       swp_entry_t entry;
> > >>> >       pte_t pte;
> > >>> > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> > >>> >       if (!folio) {
> > >>> >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > >>> >                   __swap_count(entry) =3D=3D 1) {
> > >>> > +                     /*
> > >>> > +                      * Prevent parallel swapin from proceeding =
with
> > >>> > +                      * the cache flag. Otherwise, another threa=
d may
> > >>> > +                      * finish swapin first, free the entry, and=
 swapout
> > >>> > +                      * reusing the same entry. It's undetectabl=
e as
> > >>> > +                      * pte_same() returns true due to entry reu=
se.
> > >>> > +                      */
> > >>> > +                     if (swapcache_prepare(entry)) {
> > >>> > +                             /* Relax a bit to prevent rapid rep=
eated page faults */
> > >>> > +                             schedule();
> > >>>
> > >>> The current task may be chosen in schedule().  So, I think that we
> > >>> should use cond_resched() here.
> > >>>
> > >>
> > >> I think if we are worried about current task got chosen again we can
> > >> use schedule_timeout_uninterruptible(1) here. Isn't cond_resched sti=
ll
> > >> __schedule() and and it can even get omitted, so it should be "weake=
r"
> > >> IIUC.
> > >
> > > schedule_timeout_uninterruptible(1) will introduce 1ms latency for th=
e
> > > second task.  That may kill performance of some workloads.
>
> It actually calls schedule_timeout so it should be a 1 jiffy latency,
> not 1ms, right?
>
> /**
>  * schedule_timeout - sleep until timeout
>  * @timeout: timeout value in jiffies
> ...
>
> But I think what we really want here is actually the set_current_state
> to force yield CPU for a short period. The latency should be mild.

I just forgot 1 jiffy >=3D 1 ms here, and uninterruptible should make it
unable to wakeup until timeout...

> > Just found that the cond_sched() in __read_swap_cache_async() has been
> > changed to schedule_timeout_uninterruptible(1) to fix some live lock.
> > Details are in the description of commit 029c4628b2eb ("mm: swap: get
> > rid of livelock in swapin readahead").  I think the similar issue may
> > happen here too.  So, we must use schedule_timeout_uninterruptible(1)
> > here until some other better idea becomes available.
>
> Indeed, I'll switch to schedule_timeout_uninterruptible(1). I've
> tested and posted the result with schedule_timeout_uninterruptible(1)
> before, it looked fine, or even better.

But this should be still the same though, the minor/major fault ratio
in previous test result [1] shows the race on ZRAM even with threads
set to race on purpose, the chance is low, and thanks for the info on
mentioning another commit!

[1] https://lore.kernel.org/all/CAMgjq7BvTJmxrWQOJvkLt4g_jnvmx07NdU63sGeRMG=
de4Ov=3DgA@mail.gmail.com/

