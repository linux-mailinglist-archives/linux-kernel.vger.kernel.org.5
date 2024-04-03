Return-Path: <linux-kernel+bounces-130669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC95897B76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A472B28B402
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1E7E15696C;
	Wed,  3 Apr 2024 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQNszzG1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F14138494
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712182368; cv=none; b=UelgkR86MUJ4aKkG6fLJDZhp3KXeRdGnAVP5AarmvuslSITeVi2ecEuuu5WwIWwSt8kngh4bXW8HXs0hFSaI+HMPVUDZWS31ZpctT5DRktcpm7WCeqeAAl4zTqsmnTnVBfybyZDBaTggxXx/0cmJlIcxocBhs6f4HCil8d0si6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712182368; c=relaxed/simple;
	bh=/HPUolIV4qnx/38VAY1/5mn4Zx7EV4vJjiHi32F9GQg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VASt9ZGii1q7NDnmWG37GGL4z3yOJXtJ1N5Hke2X3Ck1WbhCPxVbuAfgFwewa+Yh/w1jpKbB04TwYmTC2RNS0FPzcO9IEjKIDSW3DaqNdmMdBQ7wJ7AqOS7mLmknhtHVRYZ08qquSB/1kPQ8encjuNG2/XEP8J33FlwBaMatvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQNszzG1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0AEC433B1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712182368;
	bh=/HPUolIV4qnx/38VAY1/5mn4Zx7EV4vJjiHi32F9GQg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oQNszzG1O1VwSlUU/J4JQFDpHJ8ZpOEpLzTr7JVT98oWBzdpXbS57FIQ+plIqAw3k
	 NKhetL3JtYTzBJ9LZ0iCTjSOLuEAwK9Gv3V/YTTLq/GtOY7FJA9SfCggG0fgjCvH4b
	 sUY6wtf2LRNEJZPM4+U0xGqE43bozkZgMu8pt2vIeC0CVi5+h4Bray4gaWUYlcbDXI
	 AotfSqA5gYOje66y/JW8RFPcTMx3xhi6hnNhaPcPGkEoGs7C4fbystDxbIh5hSXzVZ
	 2p3AmcoG775G6rerzoyebZWWqBGc7ZenIQqkiDkVaslTqV7qpuDAmLvCeGvL92xkgW
	 kDQLZHTfYD+Ww==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-516c403cc46so589422e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 15:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVRpB6/QL2XJySNbqru8qy5kzTnq9D17bG/YtW82preddeAB+IDhNbQgOYXO1wVvJm1zYqOqhQUTP1+Uu02HJ1PoclY4wIdjuYLQDlq
X-Gm-Message-State: AOJu0YxvDgdV99Ht5jkpLxoJzAVWD2vJW4E/LdkzWRmU/HkIkSFkS3mh
	B4I5+Zq4oVTXsFyWQdTtf+dlbtpvkMrPYYTEf29/U17g+GlpGsXtM+vV/sensy4WvDb9rk8Dw9N
	pIvrkXyR/M0A/0HC0hZfMFzSgzQ==
X-Google-Smtp-Source: AGHT+IH6Lj62mM3ql9z7o6I1ekekhOu2//NjTGy4ULjobkWWaeVE30JWwwHp4UCj8exo8Fvkn3AWPYxAYPWt978yK5c=
X-Received: by 2002:ac2:41ca:0:b0:515:952b:7886 with SMTP id
 d10-20020ac241ca000000b00515952b7886mr580025lfi.61.1712182366804; Wed, 03 Apr
 2024 15:12:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403114032.1162100-1-ryan.roberts@arm.com> <20240403114032.1162100-2-ryan.roberts@arm.com>
In-Reply-To: <20240403114032.1162100-2-ryan.roberts@arm.com>
From: Chris Li <chrisl@kernel.org>
Date: Wed, 3 Apr 2024 15:12:34 -0700
X-Gmail-Original-Message-ID: <CANeU7QnYOx-=xoeoLWotdQWOs2KMvw0E7LuRq27LO4RDA_ManQ@mail.gmail.com>
Message-ID: <CANeU7QnYOx-=xoeoLWotdQWOs2KMvw0E7LuRq27LO4RDA_ManQ@mail.gmail.com>
Subject: Re: [PATCH v6 1/6] mm: swap: Remove CLUSTER_FLAG_HUGE from swap_cluster_info:flags
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>, Gao Xiang <xiang@kernel.org>, 
	Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>, 
	Lance Yang <ioworker0@gmail.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ryan,

Sorry for the late reply. I want to review this series but don't have
the chance to do it sooner.

On Wed, Apr 3, 2024 at 4:40=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com> =
wrote:
>
> As preparation for supporting small-sized THP in the swap-out path,
> without first needing to split to order-0, Remove the CLUSTER_FLAG_HUGE,
> which, when present, always implies PMD-sized THP, which is the same as
> the cluster size.
>
> The only use of the flag was to determine whether a swap entry refers to
> a single page or a PMD-sized THP in swap_page_trans_huge_swapped().
> Instead of relying on the flag, we now pass in nr_pages, which
> originates from the folio's number of pages. This allows the logic to
> work for folios of any order.
>
> The one snag is that one of the swap_page_trans_huge_swapped() call
> sites does not have the folio. But it was only being called there to
> shortcut a call __try_to_reclaim_swap() in some cases.
> __try_to_reclaim_swap() gets the folio and (via some other functions)
> calls swap_page_trans_huge_swapped(). So I've removed the problematic
> call site and believe the new logic should be functionally equivalent.
>
> That said, removing the fast path means that we will take a reference
> and trylock a large folio much more often, which we would like to avoid.
> The next patch will solve this.
>
> Removing CLUSTER_FLAG_HUGE also means we can remove split_swap_cluster()
> which used to be called during folio splitting, since
> split_swap_cluster()'s only job was to remove the flag.

Seems necessary to remove the assumption of large folio be PMD size.

Acked-by: Chris Li <chrisl@kernel.org>

>
> Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/swap.h | 10 ----------
>  mm/huge_memory.c     |  3 ---
>  mm/swapfile.c        | 47 ++++++++------------------------------------
>  3 files changed, 8 insertions(+), 52 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index a211a0383425..f6f78198f000 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -259,7 +259,6 @@ struct swap_cluster_info {
>  };
>  #define CLUSTER_FLAG_FREE 1 /* This cluster is free */
>  #define CLUSTER_FLAG_NEXT_NULL 2 /* This cluster has no next cluster */
> -#define CLUSTER_FLAG_HUGE 4 /* This cluster is backing a transparent hug=
e page */
>
>  /*
>   * We assign a cluster to each CPU, so each CPU can allocate swap entry =
from
> @@ -590,15 +589,6 @@ static inline int add_swap_extent(struct swap_info_s=
truct *sis,
>  }
>  #endif /* CONFIG_SWAP */
>
> -#ifdef CONFIG_THP_SWAP
> -extern int split_swap_cluster(swp_entry_t entry);
> -#else
> -static inline int split_swap_cluster(swp_entry_t entry)
> -{
> -       return 0;
> -}
> -#endif
> -
>  #ifdef CONFIG_MEMCG
>  static inline int mem_cgroup_swappiness(struct mem_cgroup *memcg)
>  {
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index ea6d1f09a0b9..3ca9282a0dc9 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2844,9 +2844,6 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>                 shmem_uncharge(folio->mapping->host, nr_dropped);
>         remap_page(folio, nr);
>
> -       if (folio_test_swapcache(folio))
> -               split_swap_cluster(folio->swap);
> -
>         /*
>          * set page to its compound_head when split to non order-0 pages,=
 so
>          * we can skip unlocking it below, since PG_locked is transferred=
 to
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 5e6d2304a2a4..0d44ee2b4f9c 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -343,18 +343,6 @@ static inline void cluster_set_null(struct swap_clus=
ter_info *info)
>         info->data =3D 0;
>  }
>
> -static inline bool cluster_is_huge(struct swap_cluster_info *info)
> -{
> -       if (IS_ENABLED(CONFIG_THP_SWAP))
> -               return info->flags & CLUSTER_FLAG_HUGE;
> -       return false;
> -}
> -
> -static inline void cluster_clear_huge(struct swap_cluster_info *info)
> -{
> -       info->flags &=3D ~CLUSTER_FLAG_HUGE;
> -}
> -
>  static inline struct swap_cluster_info *lock_cluster(struct swap_info_st=
ruct *si,
>                                                      unsigned long offset=
)
>  {
> @@ -1027,7 +1015,7 @@ static int swap_alloc_cluster(struct swap_info_stru=
ct *si, swp_entry_t *slot)
>         offset =3D idx * SWAPFILE_CLUSTER;
>         ci =3D lock_cluster(si, offset);
>         alloc_cluster(si, idx);
> -       cluster_set_count_flag(ci, SWAPFILE_CLUSTER, CLUSTER_FLAG_HUGE);
> +       cluster_set_count(ci, SWAPFILE_CLUSTER);
>
>         memset(si->swap_map + offset, SWAP_HAS_CACHE, SWAPFILE_CLUSTER);
>         unlock_cluster(ci);
> @@ -1365,7 +1353,6 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>
>         ci =3D lock_cluster_or_swap_info(si, offset);
>         if (size =3D=3D SWAPFILE_CLUSTER) {
> -               VM_BUG_ON(!cluster_is_huge(ci));
>                 map =3D si->swap_map + offset;
>                 for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
>                         val =3D map[i];
> @@ -1373,7 +1360,6 @@ void put_swap_folio(struct folio *folio, swp_entry_=
t entry)
>                         if (val =3D=3D SWAP_HAS_CACHE)
>                                 free_entries++;
>                 }
> -               cluster_clear_huge(ci);
>                 if (free_entries =3D=3D SWAPFILE_CLUSTER) {
>                         unlock_cluster_or_swap_info(si, ci);
>                         spin_lock(&si->lock);
> @@ -1395,23 +1381,6 @@ void put_swap_folio(struct folio *folio, swp_entry=
_t entry)
>         unlock_cluster_or_swap_info(si, ci);
>  }
>
> -#ifdef CONFIG_THP_SWAP
> -int split_swap_cluster(swp_entry_t entry)
> -{
> -       struct swap_info_struct *si;
> -       struct swap_cluster_info *ci;
> -       unsigned long offset =3D swp_offset(entry);
> -
> -       si =3D _swap_info_get(entry);
> -       if (!si)
> -               return -EBUSY;
> -       ci =3D lock_cluster(si, offset);
> -       cluster_clear_huge(ci);
> -       unlock_cluster(ci);
> -       return 0;
> -}
> -#endif
> -
>  static int swp_entry_cmp(const void *ent1, const void *ent2)
>  {
>         const swp_entry_t *e1 =3D ent1, *e2 =3D ent2;
> @@ -1519,22 +1488,23 @@ int swp_swapcount(swp_entry_t entry)
>  }
>
>  static bool swap_page_trans_huge_swapped(struct swap_info_struct *si,
> -                                        swp_entry_t entry)
> +                                        swp_entry_t entry,
> +                                        unsigned int nr_pages)
>  {
>         struct swap_cluster_info *ci;
>         unsigned char *map =3D si->swap_map;
>         unsigned long roffset =3D swp_offset(entry);
> -       unsigned long offset =3D round_down(roffset, SWAPFILE_CLUSTER);
> +       unsigned long offset =3D round_down(roffset, nr_pages);

It is obvious this code only works for powers two nr_pages. The
SWAPFILE_CLSTER is a power of two. If we switch to an API for
nr_pages, we might want to warn/ban passing in the non-power of two
nr_pages.

>         int i;
>         bool ret =3D false;
>
>         ci =3D lock_cluster_or_swap_info(si, offset);
> -       if (!ci || !cluster_is_huge(ci)) {
> +       if (!ci || nr_pages =3D=3D 1) {
>                 if (swap_count(map[roffset]))
>                         ret =3D true;
>                 goto unlock_out;
>         }
> -       for (i =3D 0; i < SWAPFILE_CLUSTER; i++) {
> +       for (i =3D 0; i < nr_pages; i++) {

Here we assume the swap entry offset is contiguous. That is beyond
your patch's scope. If in the future we want to have non-contiguous
swap entries to swap out large pages, we will need to find out and
change all the places that have the assumption of contiguous swap
entries.

Chris

>                 if (swap_count(map[offset + i])) {
>                         ret =3D true;
>                         break;
> @@ -1556,7 +1526,7 @@ static bool folio_swapped(struct folio *folio)
>         if (!IS_ENABLED(CONFIG_THP_SWAP) || likely(!folio_test_large(foli=
o)))
>                 return swap_swapcount(si, entry) !=3D 0;
>
> -       return swap_page_trans_huge_swapped(si, entry);
> +       return swap_page_trans_huge_swapped(si, entry, folio_nr_pages(fol=
io));
>  }
>
>  /**
> @@ -1622,8 +1592,7 @@ int free_swap_and_cache(swp_entry_t entry)
>                 }
>
>                 count =3D __swap_entry_free(p, entry);
> -               if (count =3D=3D SWAP_HAS_CACHE &&
> -                   !swap_page_trans_huge_swapped(p, entry))
> +               if (count =3D=3D SWAP_HAS_CACHE)
>                         __try_to_reclaim_swap(p, swp_offset(entry),
>                                               TTRS_UNMAPPED | TTRS_FULL);
>                 put_swap_device(p);
> --
> 2.25.1
>

