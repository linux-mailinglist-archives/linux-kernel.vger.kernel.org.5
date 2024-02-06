Return-Path: <linux-kernel+bounces-55714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F4384C0AA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 00:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAF31F25793
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 23:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACCB1C6A6;
	Tue,  6 Feb 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMCUVEgg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8191CAA5
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261017; cv=none; b=j93BRdqxFKYwkiIWgK3Ii3wl7yEVuAdFz7hKwd5Q9POP/YuVx2BlrFYk95L0+kNVesG0X9//Uvba4bC6dXm52unf/A0OoZ643M11rVD0ejX3E3K3mVuxgPY8lZUJBIdQ8B3POknKc++b0QusLT4jpsk06Mgg7IvFRAYdRlmgo3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261017; c=relaxed/simple;
	bh=yxj68K9e37rGFnpmy7C2BRyFUtUM8Wn0FvfR3DUWNrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kFKvCC4oo6Txo1ZXyW69DmOlLvnkPG1FaiN3EWFfsA89yLPlGQYGZfn2f7WIdblJLAD94fif0WiekbA6yJAGwV8oI+AXqngfIGKoVu0ep1wpoLLKE1ZszzdCQW1Xc/S+WT51QePk1F6sK230R3V4GI7OWPcHLgTNTyXAMEE+jak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMCUVEgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087AC43609
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 23:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707261016;
	bh=yxj68K9e37rGFnpmy7C2BRyFUtUM8Wn0FvfR3DUWNrA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TMCUVEggzvVanx+e/Uu4EqSf3yXVWaVGoPvI4NlSXwK1cv7CeMOyYJ/8z1WaDCTrt
	 BhqnJN9isbF8uhQt3EbidJJJYlD2SKHwRcbBZjnNq8l3wbVAlNllqr941cMeVQR9+7
	 tAehqQ43fWSDn2x0sz8jvzH+zQJSTgviAAk2QnAxAiA5MtFg6Lc/5wDC5rhPeRb8Yf
	 SRAY7H27yrmig3AJZR70T0uFR6uo08v1d9GRP2w/+6Ef/+dFpWAfrWGLoDRMsaLwn/
	 edxYTRZHXKbSStBQQA8bubM5X2eCbwZpDOgw4ph7fJ7DOFBX+/uH+5YissW1lWjFIx
	 SxLJ3Pon5ZUdQ==
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-363ca193a7eso10895ab.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 15:10:16 -0800 (PST)
X-Gm-Message-State: AOJu0YyKKgjCPUtIWgowV4Ifq3yHPda+UlwFwZe3q70k+rNKcFWIiqRR
	GmHfPRwWCYrQxSmriMoPBVoUrypPWWarCi86Ore9Tz4ri0IG87jZwa81syNxBkTM4XBVdA4Tm08
	LH0haD3URFWA9hMLtGHCPKc1zbqkCQKWFyzJV
X-Google-Smtp-Source: AGHT+IHV3jN4FC+kIzyEfyDAHrgmmaKZzwZWDknKMhHOe89mGhU8ReTYcaUpTN9+YVa12xZRpbqsJEhSypyO47A2sGI=
X-Received: by 2002:a05:6e02:144:b0:363:b21d:9d2d with SMTP id
 j4-20020a056e02014400b00363b21d9d2dmr4167280ilr.11.1707261016008; Tue, 06 Feb
 2024 15:10:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206182559.32264-1-ryncsn@gmail.com>
In-Reply-To: <20240206182559.32264-1-ryncsn@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 6 Feb 2024 15:10:04 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
Message-ID: <CAF8kJuMe7MYsAhwX804jZfO4w6kt74YMZXuz+FqUbZEt70p7Rg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Huang, Ying" <ying.huang@intel.com>, Minchan Kim <minchan@kernel.org>, Yu Zhao <yuzhao@google.com>, 
	Barry Song <v-songbaohua@oppo.com>, SeongJae Park <sj@kernel.org>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, David Hildenbrand <david@redhat.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kairui,

Sorry replying to your patch V1 late, I will reply on the V2 thread.

On Tue, Feb 6, 2024 at 10:28=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
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
> ...                                  set_pte_at()
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
> the cache flag, and allow only one thread to pin it. Release the pin
> after PT unlocked. Racers will simply busy wait since it's a rare
> and very short event.
>
> Other methods like increasing the swap count don't seem to be a good
> idea after some tests, that will cause racers to fall back to use the
> swap cache again. Parallel swapin using different methods leads to
> a much more complex scenario.
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
> Non-direct: 13155355 us (Dropping SWP_SYNCHRONOUS_IO flag)
>
> Fixes: 0bcac06f27d7 ("mm, swap: skip swapcache for swapin of synchronous =
device")
> Reported-by: "Huang, Ying" <ying.huang@intel.com>
> Closes: https://lore.kernel.org/lkml/87bk92gqpx.fsf_-_@yhuang6-desk2.ccr.=
corp.intel.com/
> Link: https://github.com/ryncsn/emm-test-project/tree/master/swap-stress-=
race [1]
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Acked-by: Yu Zhao <yuzhao@google.com>
>
> ---
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free =
so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=3Dn built [SeongJae Park=
]
> - Update the commit message and summary, refer to SWP_SYNCHRONOUS_IO inst=
ead of "direct swapin path" [Yu Zhao]
> - Update commit message.
> - Collect Review and Acks.
>
>  include/linux/swap.h |  5 +++++
>  mm/memory.c          | 15 +++++++++++++++
>  mm/swap.h            |  5 +++++
>  mm/swapfile.c        | 13 +++++++++++++
>  4 files changed, 38 insertions(+)
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
> index 7e1f4849463a..1749c700823d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3867,6 +3867,16 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> +                       if (swapcache_prepare(entry))
> +                               goto out;
> +

I am puzzled by this "goto out". If I understand this correctly, you
have two threads CPU1 and CPU2 racing to set the flag SWAP_HAS_CACHE.
The CPU1 will succeed in adding the flag and  the CPU2 will get
"-EEXIST" from "swapcache_prepare(entry)".  Am I understanding it
correctly so far?

Then the goto out seems wrong to me. For the CPU2, the page fault will
return *unhandled*. Even worse, the "-EEXIST" error is not preserved,
CPU2 does not even know the page fault is not handled, it will resume
from the page fault instruction, possibly generate another page fault
at the exact same location. That page fault loop will repeat until
CPU1 install the new pte on that faulting virtual address and pick up
by CPU2.

Am I missing something obvious there?

I just re-read your comment: "Racers will simply busy wait since it's
a rare and very short event." That might be referring to the above
CPU2 page fault looping situation. I consider the page fault looping
on CPU2 not acceptable. For one it will mess up the page fault
statistics.
In my mind, having an explicit loop for CPU2 waiting for the PTE to
show up is still better than this page fault loop. You can have more
CPU power friendly loops.

This behavior needs more discussion.

Chris


Chris


>                         /* skip swapcache */
>                         folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
>                                                 vma, vmf->address, false)=
;
> @@ -4116,6 +4126,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  unlock:
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> +       /* Clear the swap cache pin for direct swapin after PTL unlock */
> +       if (folio && !swapcache)
> +               swapcache_clear(si, entry);
>  out:
>         if (si)
>                 put_swap_device(si);
> @@ -4124,6 +4137,8 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (vmf->pte)
>                 pte_unmap_unlock(vmf->pte, vmf->ptl);
>  out_page:
> +       if (!swapcache)
> +               swapcache_clear(si, entry);
>         folio_unlock(folio);
>  out_release:
>         folio_put(folio);
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

