Return-Path: <linux-kernel+bounces-55926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66F8984C378
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68FE1F25BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B1411718;
	Wed,  7 Feb 2024 04:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="llG658r/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E843D10A0C;
	Wed,  7 Feb 2024 04:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707279524; cv=none; b=kOpkzvSfNtR70U8li7HyVwyU8Ms1WbzII2uEaUn1wlTWU8STMyI3M5kpmFOxMdKxR3lTJpha4Y9hJpRMfRIOpL8WvE0htwwidKjRajEzp+j8VUSdIr4KuQdk4MK8xz7hwE4UkZqgDzD8DJi6AXSjwzu9gQlVAWkKmJTmMWdRmPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707279524; c=relaxed/simple;
	bh=lfVB66lF5RzGYJMOQQ5G9fbHxH4T9DH6xYYAXpwCNMg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=J2pUTp++edngrM1nxVIhi9646r1rL99K54E4ErJJJ6PxB4BwegCDSxUOxoFzo0HemXGY5vVjQBtOASqCUBo4wgImiyg6eLZIspj174kwOgsnmrly3MuRq+Mz8WrRJLZDE8J9dwJmt/dAbb2xjCUSkvbhxEFOBxNMA2Yu1/KUqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=llG658r/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707279522; x=1738815522;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=lfVB66lF5RzGYJMOQQ5G9fbHxH4T9DH6xYYAXpwCNMg=;
  b=llG658r/f5dAV7lK07R/hcCv+tNrcdEM5710SnUTqQ9RQ0uZfFyoN/jG
   Mj37C2TPcKoFjBxbVJl3HsNKLgjuqeZ940XAC0CwTNx8k0YeB0ZNNEg3s
   LOCvg46X1Oohnb8sy5mLTZZxZIbHZgmLqjZL/bEjbaG930C6iVoaWJeVy
   0EkIilrSUdSrhoMYuDwBiyxlhyKLli2jEwOs3RsBpk1SNsoWbQvTgNOR4
   uKq5sX7wpNglQ3PaoBm/Dd4ygdLQl9lTgBldWSsVHXN8vgjviyeMJafAy
   e/sVhG9MdAaSydIk9tDvj50A1TDO8jDBsr+5sdB8syPrs6lrKfV3FwBfK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="813893"
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="813893"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 20:18:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,250,1701158400"; 
   d="scan'208";a="1206627"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 20:18:37 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Barry Song <21cnbao@gmail.com>
Cc: Kairui Song <ryncsn@gmail.com>,  Chris Li <chrisl@kernel.org>,
  linux-mm@kvack.org,  Andrew Morton <akpm@linux-foundation.org>,  Minchan
 Kim <minchan@kernel.org>,  Yu Zhao <yuzhao@google.com>,  Barry Song
 <v-songbaohua@oppo.com>,  SeongJae Park <sj@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  stable@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
In-Reply-To: <CAGsJ_4wc920zQ8niaQgn9V48P1S_KX2F5To9et+enJx8iR7+Bg@mail.gmail.com>
	(Barry Song's message of "Wed, 7 Feb 2024 16:45:49 +1300")
References: <20240206182559.32264-1-ryncsn@gmail.com>
	<CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
	<CAGsJ_4zF+U5JG8XYANe2x0VbjovokFCirf=YLHOfO3E-U8b4sg@mail.gmail.com>
	<87sf25yqj2.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<CAMgjq7DbE=L24m8dhU7Bu324Ym=34LyZFB8Df32NYwKVapLGKQ@mail.gmail.com>
	<CAGsJ_4wc920zQ8niaQgn9V48P1S_KX2F5To9et+enJx8iR7+Bg@mail.gmail.com>
Date: Wed, 07 Feb 2024 12:16:41 +0800
Message-ID: <874jekzz6e.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Barry Song <21cnbao@gmail.com> writes:

> On Wed, Feb 7, 2024 at 3:29=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>>
>> On Wed, Feb 7, 2024 at 10:10=E2=80=AFAM Huang, Ying <ying.huang@intel.co=
m> wrote:
>> >
>> > Barry Song <21cnbao@gmail.com> writes:
>> >
>> > > On Wed, Feb 7, 2024 at 7:18=E2=80=AFAM Chris Li <chrisl@kernel.org> =
wrote:
>> > >>
>> > >> Hi Kairui,
>> > >>
>> > >> Sorry replying to your patch V1 late, I will reply on the V2 thread.
>> > >>
>> > >> On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.c=
om> wrote:
>> > >> >
>> > >> > From: Kairui Song <kasong@tencent.com>
>> > >> >
>> > >> > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more th=
reads
>> > >> > swapin the same entry at the same time, they get different pages =
(A, B).
>> > >> > Before one thread (T0) finishes the swapin and installs page (A)
>> > >> > to the PTE, another thread (T1) could finish swapin of page (B),
>> > >> > swap_free the entry, then swap out the possibly modified page
>> > >> > reusing the same entry. It breaks the pte_same check in (T0) beca=
use
>> > >> > PTE value is unchanged, causing ABA problem. Thread (T0) will
>> > >> > install a stalled page (A) into the PTE and cause data corruption.
>> > >> >
>> > >> > One possible callstack is like this:
>> > >> >
>> > >> > CPU0                                 CPU1
>> > >> > ----                                 ----
>> > >> > do_swap_page()                       do_swap_page() with same ent=
ry
>> > >> > <direct swapin path>                 <direct swapin path>
>> > >> > <alloc page A>                       <alloc page B>
>> > >> > swap_read_folio() <- read to page A  swap_read_folio() <- read to=
 page B
>> > >> > <slow on later locks or interrupt>   <finished swapin first>
>> > >> > ...                                  set_pte_at()
>> > >> >                                      swap_free() <- entry is free
>> > >> >                                      <write to page B, now page A=
 stalled>
>> > >> >                                      <swap out page B to same swa=
p entry>
>> > >> > pte_same() <- Check pass, PTE seems
>> > >> >               unchanged, but page A
>> > >> >               is stalled!
>> > >> > swap_free() <- page B content lost!
>> > >> > set_pte_at() <- staled page A installed!
>> > >> >
>> > >> > And besides, for ZRAM, swap_free() allows the swap device to disc=
ard
>> > >> > the entry content, so even if page (B) is not modified, if
>> > >> > swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
>> > >> > it may also cause data loss.
>> > >> >
>> > >> > To fix this, reuse swapcache_prepare which will pin the swap entr=
y using
>> > >> > the cache flag, and allow only one thread to pin it. Release the =
pin
>> > >> > after PT unlocked. Racers will simply busy wait since it's a rare
>> > >> > and very short event.
>> > >> >
>> > >> > Other methods like increasing the swap count don't seem to be a g=
ood
>> > >> > idea after some tests, that will cause racers to fall back to use=
 the
>> > >> > swap cache again. Parallel swapin using different methods leads to
>> > >> > a much more complex scenario.
>> > >> >
>> > >> > Reproducer:
>> > >> >
>> > >> > This race issue can be triggered easily using a well constructed
>> > >> > reproducer and patched brd (with a delay in read path) [1]:
>> > >> >
>> > >> > With latest 6.8 mainline, race caused data loss can be observed e=
asily:
>> > >> > $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>> > >> >   Polulating 32MB of memory region...
>> > >> >   Keep swapping out...
>> > >> >   Starting round 0...
>> > >> >   Spawning 65536 workers...
>> > >> >   32746 workers spawned, wait for done...
>> > >> >   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data lo=
ss!
>> > >> >   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data l=
oss!
>> > >> >   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data l=
oss!
>> > >> >   Round 0 Failed, 15 data loss!
>> > >> >
>> > >> > This reproducer spawns multiple threads sharing the same memory r=
egion
>> > >> > using a small swap device. Every two threads updates mapped pages=
 one by
>> > >> > one in opposite direction trying to create a race, with one dedic=
ated
>> > >> > thread keep swapping out the data out using madvise.
>> > >> >
>> > >> > The reproducer created a reproduce rate of about once every 5 min=
utes,
>> > >> > so the race should be totally possible in production.
>> > >> >
>> > >> > After this patch, I ran the reproducer for over a few hundred rou=
nds
>> > >> > and no data loss observed.
>> > >> >
>> > >> > Performance overhead is minimal, microbenchmark swapin 10G from 3=
2G
>> > >> > zram:
>> > >> >
>> > >> > Before:     10934698 us
>> > >> > After:      11157121 us
>> > >> > Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>> > >> >
>> > >> > Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of sync=
hronous device")
>> > >> > Reported-by: "Huang, Ying" <ying.huang@intel.com>
>> > >> > Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-de=
sk2.ccr.corp.intel.com/
>> > >> > Link: https://github.com/ryncsn/emm-test-project/tree/master/swap=
-stress-race [1]
>> > >> > Signed-off-by: Kairui Song <kasong@tencent.com>
>> > >> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
>> > >> > Acked-by: Yu Zhao <yuzhao@google.com>
>> > >> >
>> > >> > ---
>> > >> > Update from V1:
>> > >> > - Add some words on ZRAM case, it will discard swap content on sw=
ap_free so the race window is a bit different but cure is the same. [Barry =
Song]
>> > >> > - Update comments make it cleaner [Huang, Ying]
>> > >> > - Add a function place holder to fix CONFIG_SWAP=3Dn built [Seong=
Jae Park]
>> > >> > - Update the commit message and summary, refer to SWP_SYNCHRONOUS=
_IO instead of "direct swapin path" [Yu Zhao]
>> > >> > - Update commit message.
>> > >> > - Collect Review and Acks.
>> > >> >
>> > >> >  include/linux/swap.h |  5 +++++
>> > >> >  mm/memory.c          | 15 +++++++++++++++
>> > >> >  mm/swap.h            |  5 +++++
>> > >> >  mm/swapfile.c        | 13 +++++++++++++
>> > >> >  4 files changed, 38 insertions(+)
>> > >> >
>> > >> > diff --git a/include/linux/swap.h b/include/linux/swap.h
>> > >> > index 4db00ddad261..8d28f6091a32 100644
>> > >> > --- a/include/linux/swap.h
>> > >> > +++ b/include/linux/swap.h
>> > >> > @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t=
 swp)
>> > >> >         return 0;
>> > >> >  }
>> > >> >
>> > >> > +static inline int swapcache_prepare(swp_entry_t swp)
>> > >> > +{
>> > >> > +       return 0;
>> > >> > +}
>> > >> > +
>> > >> >  static inline void swap_free(swp_entry_t swp)
>> > >> >  {
>> > >> >  }
>> > >> > diff --git a/mm/memory.c b/mm/memory.c
>> > >> > index 7e1f4849463a..1749c700823d 100644
>> > >> > --- a/mm/memory.c
>> > >> > +++ b/mm/memory.c
>> > >> > @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
>> > >> >         if (!folio) {
>> > >> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>> > >> >                     __swap_count(entry) =3D=3D 1) {
>> > >> > +                       /*
>> > >> > +                        * Prevent parallel swapin from proceedin=
g with
>> > >> > +                        * the cache flag. Otherwise, another thr=
ead may
>> > >> > +                        * finish swapin first, free the entry, a=
nd swapout
>> > >> > +                        * reusing the same entry. It's undetecta=
ble as
>> > >> > +                        * pte_same() returns true due to entry r=
euse.
>> > >> > +                        */
>> > >> > +                       if (swapcache_prepare(entry))
>> > >> > +                               goto out;
>> > >> > +
>> > >>
>> > >> I am puzzled by this "goto out". If I understand this correctly, you
>> > >> have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACH=
E.
>> > >> The CPU1 will succeed in adding the flag and  the CPU2 will get
>> > >> "-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
>> > >> correctly so far?
>> > >>
>> > >> Then the goto out seems wrong to me. For the CPU2, the page fault w=
ill
>> > >> return *unhandled*. Even worse, the "-EEXIST" error is not preserve=
d,
>> > >> CPU2 does not even know the page fault is not handled, it will resu=
me
>> > >> from the page fault instruction, possibly generate another page fau=
lt
>> > >> at the exact same location. That page fault loop will repeat until
>> > >> CPU1 install the new pte on that faulting virtual address and pick =
up
>> > >> by CPU2.
>> > >>
>> > >> Am I missing something obvious there?
>> > >
>> > > I feel you are right. any concurrent page faults at the same pte
>> > > will increase the count of page faults for a couple of times now.
>> > >
>> > >>
>> > >> I just re-read your comment: "Racers will simply busy wait since it=
's
>> > >> a rare and very short event." That might be referring to the above
>> > >> CPU2 page fault looping situation. I consider the page fault looping
>> > >> on CPU2 not acceptable. For one it will mess up the page fault
>> > >> statistics.
>> > >> In my mind, having an explicit loop for CPU2 waiting for the PTE to
>> > >> show up is still better than this page fault loop. You can have more
>> > >> CPU power friendly loops.
>> > >
>> > > I assume you mean something like
>> > >
>> > > while(!pte_same())
>> > >    cpu_relax();
>> > >
>> > > then we still have a chance to miss the change of B.
>> > >
>> > > For example, another thread is changing pte to A->B->A, our loop can
>> > > miss B. Thus we will trap into an infinite loop. this is even worse.
>> > >
>> > > is it possible to loop for the success of swapcache_prepare(entry)
>> > > instead?
>> >
>> > This doesn't work too.  The swap count can increase to > 1 and be put =
in
>> > swap cache for long time.
>> >
>> > Another possibility is to move swapcache_prepare() after
>> > vma_alloc_folio() to reduce the race window.
>
> what about we make everything go as it is. I mean, we only need to
> record we have failed on swapcache_prepare, but we don't goto out.
>
> bool swapcache_prepare_failed =3D  swapcache_prepare();
> .... // don't change any code
>
>
> but we only change the last code to set pte from the below
>    ptl
>    if(pte_same)
>        set_pte
>
> to
>
>    ptl
>    if(pte_same && !swapcache_prepare_failed)
>         set_pte
>
> as the chance is close to 0%, the increased count should be very minor.

IIUC, if (!swapcache_prepare_failed), it will always fail.  If so, why
bother wasting CPU cycles?  If you return directly, and the first thread
runs quickly enough, you can use the installed PTE directly.

--
Best Regards,
Huang, Ying

>>
>> Reducing the race window seems like a good way. Or maybe we can just
>> add a cpu_relax() so raced swapins will just slow down, and won't loop
>> too much time and so the side effect (counter or power consumption)
>> should be much smaller?
>
> Thanks
> Barry

