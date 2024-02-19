Return-Path: <linux-kernel+bounces-72045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D185AE32
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 23:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A88B91C220C5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D9A54FA0;
	Mon, 19 Feb 2024 22:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXepJD+i"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1205466C;
	Mon, 19 Feb 2024 22:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708380619; cv=none; b=HTuxtBjSIJe5b3DJ99LkqlyhmgbxSTR+qOzCoQ0/ZKZCaVWStDv11+ILb7pVeS67YkzufGa8vdhvkCIZJ17rnYqhBbeknkIbRFosXcd6f6bI35THaMKsaPNy15UDVAfjvZxLxdglMNrkS407lJteISEl9CuBULYyvwKRsHVeLTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708380619; c=relaxed/simple;
	bh=Gzhssg4it0PUqTWNkQWQX2aAj4WDziDGDA74eg5y0s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vv+yr9NksbetohpsP7PKmIpPDM7JhOWPCHH68b9digdUp7MX5Q+G8+/Msa2lVPV6QMTUle55NuXKpUkYe+tkhCIhL8I1oH97bxhsnH8wdt62tINn3/BSxbc6cRbXszDUpH9m6T5+2TlK4wZjzKFcCtNbhjHzYBgSvomzfyelTTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXepJD+i; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4cc13005119so263407e0c.1;
        Mon, 19 Feb 2024 14:10:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708380616; x=1708985416; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TU80jGBCqABo3zY+nH+epq+7dJIVZw0rvVamU3XUKs=;
        b=aXepJD+i4YDnNMkHO7z5lW+tJYhDwFt9dXmghMoS7qe3t6i+OSITjMnHmEaY+bZXgc
         MWPYaQzTRqCwR8Vh6tpcC+0dKfd8Aa8hyTvutmp5fDXjZbkHsWgu3T21yG5yZjOz4q00
         qmaGzcoV9CnQeW2jUwi+TF4z7p83F5mv2RCJDbe+ijvojAJYIHN21vB4VuyWswi6gj+h
         Lpupv5KVYtke7yRD1owkYl57fOQROIxOouW98cOC6uXFvAuGTSmU0EMpXwvK81Br/qT3
         Ou6mz1X0/SQXFXTzz0jxZms5JIztiAhj0oo3b4EN0Sq1EMfgq76WHP8/zbpl41bdzSDd
         mgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708380616; x=1708985416;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TU80jGBCqABo3zY+nH+epq+7dJIVZw0rvVamU3XUKs=;
        b=jFobKnuZTPieJKig3X+UznyAyU4OhC1czCKH8SYraDdG3FbLbvJ+eRNngosCt0uBRY
         p2V9htgI2lDuupbm67MXrWBMC+3nc0625WGPGw+bXGN4yb2k8zsOMKrlJT0JnuUluGsm
         w5gTX20+cwnP8sCgb2NKp+doLRdBw0WNX7B5PB4/u2iwSVw5JQ8KMaeLsgk+lDvKUsMh
         Gsk5up8iuxX5LaEYHbn7Tn9EMFZcu/0jza0BmOLjEe6fFuqDPxMmx2nRUpkEgXAKcQyV
         mlMOY8VnnoGcTepbt84KpNm526oBUH0QuJbq4z2gGOb1jdqCoR56mjGB9QNoUbBXk8lF
         aCQg==
X-Forwarded-Encrypted: i=1; AJvYcCXRrISLLzcqcopoTp0Sp+4wZ71KwRkKfTZR+u8tEqV02VjXY9Y6LjMihVxc8IVglRdWDowz5AG3qI2syq7bGhLKtbUPzQr7T8lwcV0pYawox0ubsoRi+79u1CY7EkDdOSUxh06L
X-Gm-Message-State: AOJu0YwQqcz35wIarZPBEwcq3sE0VTTvDDxCJq76CR1Pcg52fsKhnIVQ
	jdBNoN5YoZcQzT41EVSQKHGdFCWuTRiQ3wrgKPd6AQlFEx40TyYP69KFHd0p4H0vzOyTEcApf/G
	7yhS3t9L/LM7HDE5vJig79PkLmrs=
X-Google-Smtp-Source: AGHT+IGgNKrFeBAv/NkKfJDEzsh0SuIe/v1Y3YTXMygoTuKxPVdJ4r/5hNir4fKs/52mkEEQ9fAyFuGjJhZUSsJvkRs=
X-Received: by 2002:a1f:4f02:0:b0:4c0:2d32:612f with SMTP id
 d2-20020a1f4f02000000b004c02d32612fmr7847028vkb.15.1708380616190; Mon, 19 Feb
 2024 14:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com>
In-Reply-To: <20240219082040.7495-1-ryncsn@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 11:10:03 +1300
Message-ID: <CAGsJ_4xX+K=f_4g2c7NcpYqWH0_bvQshxgz_YoDscqeHwWpM0w@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 9:21=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> From: Kairui Song <kasong@tencent.com>
>
> When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more threads
> swapin the same entry at the same time, they get different pages (A, B).
> Before one thread (T0) finishes the swapin and installs page (A)
> to the PTE, another thread (T1) could finish swapin of page (B),
> swap_free the entry, then swap out the possibly modified page
> reusing the same entry. It breaks the pte_same check in (T0) because
> PTE value is unchanged, causing ABA problem. Thread (T0) will
> install a stalled page (A) into the PTE and cause data corruption.
>
> One possible callstack is like this:
>
> CPU0                                 CPU1
> ----                                 ----
> do_swap_page()                       do_swap_page() with same entry
> <direct swapin path>                 <direct swapin path>
> <alloc page A>                       <alloc page B>
> swap_read_folio() <- read to page A  swap_read_folio() <- read to page B
> <slow on later locks or interrupt>   <finished swapin first>
> ..                                  set_pte_at()
>                                      swap_free() <- entry is free
>                                      <write to page B, now page A stalled=
>
>                                      <swap out page B to same swap entry>
> pte_same() <- Check pass, PTE seems
>               unchanged, but page A
>               is stalled!
> swap_free() <- page B content lost!
> set_pte_at() <- staled page A installed!
>
> And besides, for ZRAM, swap_free() allows the swap device to discard
> the entry content, so even if page (B) is not modified, if
> swap_read_folio() on CPU0 happens later than swap_free() on CPU1,
> it may also cause data loss.
>
> To fix this, reuse swapcache_prepare which will pin the swap entry using
> the cache flag, and allow only one thread to swap it in, also prevent
> any parallel code from putting the entry in the cache. Release the pin
> after PT unlocked.
>
> Racers just loop and wait since it's a rare and very short event.
> A schedule_timeout_uninterruptible(1) call is added to avoid repeated
> page faults wasting too much CPU, causing livelock or adding too much
> noise to perf statistics. A similar livelock issue was described in
> commit 029c4628b2eb ("mm: swap: get rid of livelock in swapin readahead")
>
> Reproducer:
>
> This race issue can be triggered easily using a well constructed
> reproducer and patched brd (with a delay in read path) [1]:
>
> With latest 6.8 mainline, race caused data loss can be observed easily:
> $ gcc -g -lpthread test-thread-swap-race.c && ./a.out
>   Polulating 32MB of memory region...
>   Keep swapping out...
>   Starting round 0...
>   Spawning 65536 workers...
>   32746 workers spawned, wait for done...
>   Round 0: Error on 0x5aa00, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x395200, expected 32746, got 32743, 3 data loss!
>   Round 0: Error on 0x3fd000, expected 32746, got 32737, 9 data loss!
>   Round 0 Failed, 15 data loss!
>
> This reproducer spawns multiple threads sharing the same memory region
> using a small swap device. Every two threads updates mapped pages one by
> one in opposite direction trying to create a race, with one dedicated
> thread keep swapping out the data out using madvise.
>
> The reproducer created a reproduce rate of about once every 5 minutes,
> so the race should be totally possible in production.
>
> After this patch, I ran the reproducer for over a few hundred rounds
> and no data loss observed.
>
> Performance overhead is minimal, microbenchmark swapin 10G from 32G
> zram:
>
> Before:     10934698 us
> After:      11157121 us
> Cached:     13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.=
corp.intel.com/
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Cc: stable@vger.kernel.org
>
> ---
> V3: https://lore.kernel.org/all/20240216095105.14502-1-ryncsn@gmail.com/
> Update from V3:
> - Use schedule_timeout_uninterruptible(1) for now instead of schedule() t=
o
>   prevent the busy faulting task holds CPU and livelocks [Huang, Ying]
>
> V2: https://lore.kernel.org/all/20240206182559.32264-1-ryncsn@gmail.com/
> Update from V2:
> - Add a schedule() if raced to prevent repeated page faults wasting CPU
>   and add noise to perf statistics.
> - Use a bool to state the special case instead of reusing existing
>   variables fixing error handling [Minchan Kim].
>
> V1: https://lore.kernel.org/all/20240205110959.4021-1-ryncsn@gmail.com/
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free
>   so the race window is a bit different but cure is the same. [Barry Song=
]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Park=
]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO
>   instead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
>
>  include/linux/swap.h |  5 +++++
>  mm/memory.c          | 20 ++++++++++++++++++++
>  mm/swap.h            |  5 +++++
>  mm/swapfile.c        | 13 +++++++++++++
>  4 files changed, 43 insertions(+)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 4db00ddad261..8d28f6091a32 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -549,6 +549,11 @@ static inline int swap_duplicate(swp_entry_t swp)
>         return 0;
>  }
>
> +static inline int swapcache_prepare(swp_entry_t swp)
> +{
> +       return 0;
> +}
> +
>  static inline void swap_free(swp_entry_t swp)
>  {
>  }
> diff --git a/mm/memory.c b/mm/memory.c
> index 7e1f4849463a..a99f5e7be9a5 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3799,6 +3799,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
> +       bool need_clear_cache =3D false;
>         bool exclusive =3D false;
>         swp_entry_t entry;
>         pte_t pte;
> @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> +                       /*
> +                        * Prevent parallel swapin from proceeding with
> +                        * the cache flag. Otherwise, another thread may
> +                        * finish swapin first, free the entry, and swapo=
ut
> +                        * reusing the same entry. It's undetectable as
> +                        * pte_same() returns true due to entry reuse.
> +                        */
> +                       if (swapcache_prepare(entry)) {
> +                               /* Relax a bit to prevent rapid repeated =
page faults */
> +                               schedule_timeout_uninterruptible(1);

Not a ideal model, imaging two tasks,

task A  - low priority running on a LITTLE core
task B - high priority and have real-time requirements such as audio,
              graphics running on a big core.

The original code will make B win even if it is a bit later than A as its C=
PU is
much faster to finish swap_read_folio for example from zRAM. task B's
swap-in can finish very soon.

With the patch, B will wait a tick and its real-time performance will be
negatively affected from time to time once low priority and high priority
tasks fault in the same PTE and high priority tasks are a bit later than
low priority tasks. This is a kind of priority inversion.

When we support large folio swap-in, things can get worse. For example,
to swap-in 16 or even more pages in one do_swap_page, the chance for
task A and task B located in the same range of 16 PTEs will increase
though they are not located in the same PTE.

Please consider this is not a blocker for this patch. But I will put the pr=
oblem
in my list and run some real tests on Android phones later.

> +                               goto out;
> +                       }
> +                       need_clear_cache =3D true;
> +
>                         /* skip swapcache */
>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
>                                                 vma, vmf->address, false)=
;
> @@ -4117,6 +4132,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out:
> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
> +       if (need_clear_cache)
> +               swapcache_clear(si, entry);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> @@ -4131,6 +4149,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                 folio_unlock(swapcache);
>                 folio_put(swapcache);
>         }
> +       if (need_clear_cache)
> +               swapcache_clear(si, entry);
>         if (si)
>                 put_swap_device(si);
>         return ret;
> diff --git a/mm/swap.h b/mm/swap.h
> index 758c46ca671e..fc2f6ade7f80 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,6 +41,7 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
> @@ -97,6 +98,10 @@ static inline int swap_writepage(struct page *p, struc=
t writeback_control *wbc)
>         return 0;
>  }
>
> +static inline void swapcache_clear(struct swap_info_struct *si, swp_entr=
y_t entry)
> +{
> +}
> +
>  static inline struct folio *swap_cache_get_folio(swp_entry_t entry,
>                 struct vm_area_struct *vma, unsigned long addr)
>  {
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 556ff7347d5f..746aa9da5302 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3365,6 +3365,19 @@ int swapcache_prepare(swp_entry_t entry)
>         return __swap_duplicate(entry, SWAP_HAS_CACHE);
>  }
>
> +void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
> +{
> +       struct swap_cluster_info *ci;
> +       unsigned long offset =3D swp_offset(entry);
> +       unsigned char usage;
> +
> +       ci =3D lock_cluster_or_swap_info(si, offset);
> +       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
> +       unlock_cluster_or_swap_info(si, ci);
> +       if (!usage)
> +               free_swap_slot(entry);
> +}
> +
>  struct swap_info_struct *swp_swap_info(swp_entry_t entry)
>  {
>         return swap_type_to_swap_info(swp_type(entry));
> --
> 2.43.0
>
>

Thanks
Barry

