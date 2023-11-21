Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F427F25A8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjKUGPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233501AbjKUGPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:15:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AA2121
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:15:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35689C433BA
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700547333;
        bh=VZMiiipzB+r0tUCKJdzejnCuWSnaapfEqCXwI1yoj5A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZdXTo3mGjd1tm2XrmHG7HtjK0pW2IanHjrZfjML+atA8unsTk8axmUnTZzg+YpRri
         hg9AfTn6rKp67dE8AeNOy41b9nP4ZlQvfoNw5QIYMqvPbiY8oOCYcpACSX6zpTWw7I
         W6/6gi6GHk7hdsy0Pf4iX+tQwer9fupjKxRgxUClj13zdTay+Hzc3keoLdxNuA8Yd+
         s4XyVb7kJraQOGRVSIWj2p+nrdm7HdMYMF2ejRj8H1b/QRYV2DNvpDtXFefDhSEGe9
         auesY5df+8Wd184D0hNivJcuy7xQShX19jaTKfMWEMgd20Yrn+MfB7Jm6fAa0a3urK
         qe3T2jIH6LEyg==
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1cc394f4cdfso38337025ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:15:33 -0800 (PST)
X-Gm-Message-State: AOJu0YxXhm9BUbpDe1x4ClyedHuE4Siw+83scSIeRNFJq5ljB4toMO/l
        GqRSekagfD8yVaHcWlHfkCUg0qOl5yU/OWoS1Sg37A==
X-Google-Smtp-Source: AGHT+IGAGvZg8J7hAVbt8RyEh/yx7o91GvLJ/7sojB7/Ix+6lUS6fsLJsd5FUsYlGlrOOSzJ2M4PJ/m59oAAh7A+UC8=
X-Received: by 2002:a17:90b:3e87:b0:27d:492e:137a with SMTP id
 rj7-20020a17090b3e8700b0027d492e137amr8470262pjb.45.1700547332492; Mon, 20
 Nov 2023 22:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-6-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-6-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 22:15:21 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMx5HbSRogY4mVoZ1EELHbmZpOnwv5fRdOE7xvNhjZDbA@mail.gmail.com>
Message-ID: <CAF8kJuMx5HbSRogY4mVoZ1EELHbmZpOnwv5fRdOE7xvNhjZDbA@mail.gmail.com>
Subject: Re: [PATCH 05/24] mm/swap: move readahead policy checking into swapin_readahead
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> This makes swapin_readahead a main entry for swapin pages,
> prepare for optimizations in later commits.
>
> This also makes swapoff able to make use of readahead checking
> based on entry. Swapping off a 10G ZRAM (lzo-rle) is faster:
>
> Before:
> time swapoff /dev/zram0
> real    0m12.337s
> user    0m0.001s
> sys     0m12.329s
>
> After:
> time swapoff /dev/zram0
> real    0m9.728s
> user    0m0.001s
> sys     0m9.719s
>
> And what's more, because now swapoff will also make use of no-readahead
> swapin helper, this also fixed a bug for no-readahead case (eg. ZRAM):
> when a process that swapped out some memory previously was moved to a new
> cgroup, and the original cgroup is dead, swapoff the swap device will
> make the swapped in pages accounted into the process doing the swapoff
> instead of the new cgroup the process was moved to.
>
> This can be easily reproduced by:
> - Setup a ramdisk (eg. ZRAM) swap.
> - Create memory cgroup A, B and C.
> - Spawn process P1 in cgroup A and make it swap out some pages.
> - Move process P1 to memory cgroup B.
> - Destroy cgroup A.
> - Do a swapoff in cgroup C.
> - Swapped in pages is accounted into cgroup C.
>
> This patch will fix it make the swapped in pages accounted in cgroup B.

Can you help me understand where the code makes this behavior change?
As far as I can tell, the patch just allows swap off to use the code
path to avoid read ahead and avoid swap cache path. I haven't figured
out where the code makes the swapin charge to B.
Does it need to be ZRAM? Will zswap or SSD work in your example?

>
> The same bug exists for readahead path too, we'll fix it in later
> commits.

As discussed in another email, this behavior change is against the
current memcg memory charging model.
Better separate out this behavior change with code clean up.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 22 +++++++---------------
>  mm/swap.h       |  6 ++----
>  mm/swap_state.c | 33 ++++++++++++++++++++++++++-------
>  mm/swapfile.c   |  2 +-
>  4 files changed, 36 insertions(+), 27 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index fba4a5229163..f4237a2e3b93 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3792,6 +3792,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         rmap_t rmap_flags =3D RMAP_NONE;
>         bool exclusive =3D false;
>         swp_entry_t entry;
> +       bool swapcached;
>         pte_t pte;
>         vm_fault_t ret =3D 0;
>
> @@ -3855,22 +3856,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         swapcache =3D folio;
>
>         if (!folio) {
> -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> -                   __swap_count(entry) =3D=3D 1) {
> -                       /* skip swapcache and readahead */
> -                       page =3D swapin_no_readahead(entry, GFP_HIGHUSER_=
MOVABLE,
> -                                               vmf);
> -                       if (page)
> -                               folio =3D page_folio(page);
> +               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +                                       vmf, &swapcached);
> +               if (page) {
> +                       folio =3D page_folio(page);
> +                       if (swapcached)
> +                               swapcache =3D folio;
>                 } else {
> -                       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOV=
ABLE,
> -                                               vmf);
> -                       if (page)
> -                               folio =3D page_folio(page);
> -                       swapcache =3D folio;
> -               }
> -
> -               if (!folio) {
>                         /*
>                          * Back out if somebody else faulted in this pte
>                          * while we released the pte lock.
> diff --git a/mm/swap.h b/mm/swap.h
> index ea4be4791394..f82d43d7b52a 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -55,9 +55,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry,=
 gfp_t gfp_mask,
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>                                     struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> -                             struct vm_fault *vmf);
> -struct page *swapin_no_readahead(swp_entry_t entry, gfp_t flag,
> -                                struct vm_fault *vmf);
> +                             struct vm_fault *vmf, bool *swapcached);
>
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -89,7 +87,7 @@ static inline struct page *swap_cluster_readahead(swp_e=
ntry_t entry,
>  }
>
>  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_m=
ask,
> -                       struct vm_fault *vmf)
> +                       struct vm_fault *vmf, bool *swapcached)
>  {
>         return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 45dd8b7c195d..fd0047ae324e 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_page *=
*pages, int nr)
>         release_pages(pages, nr);
>  }
>
> +static inline bool swap_use_no_readahead(struct swap_info_struct *si, sw=
p_entry_t entry)
> +{
> +       return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(=
entry) =3D=3D 1;
> +}
> +
>  static inline bool swap_use_vma_readahead(void)
>  {
>         return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_rotate=
_swap);
> @@ -861,8 +866,8 @@ static struct page *swap_vma_readahead(swp_entry_t ta=
rg_entry, gfp_t gfp_mask,
>   * Returns the struct page for entry and addr after the swap entry is re=
ad
>   * in.
>   */
> -struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -                                struct vm_fault *vmf)
> +static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mas=
k,
> +                                       struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
>         struct page *page =3D NULL;
> @@ -904,6 +909,8 @@ struct page *swapin_no_readahead(swp_entry_t entry, g=
fp_t gfp_mask,
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
> + * @swapcached: pointer to a bool used as indicator if the
> + *              page is swapped in through swapcache.
>   *
>   * Returns the struct page for entry and addr, after queueing swapin.
>   *
> @@ -912,17 +919,29 @@ struct page *swapin_no_readahead(swp_entry_t entry,=
 gfp_t gfp_mask,
>   * or vma-based(ie, virtual address based on faulty address) readahead.
>   */
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -                               struct vm_fault *vmf)
> +                             struct vm_fault *vmf, bool *swapcached)

At this point the function name "swapin_readahead" does not match what
it does any more. Because readahead is just one of the behaviors it
does. It also can do without readahead. It needs a better name. This
function becomes a generic swapin_entry.

>  {
>         struct mempolicy *mpol;
> -       pgoff_t ilx;
>         struct page *page;
> +       pgoff_t ilx;
> +       bool cached;
>
>         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> -       page =3D swap_use_vma_readahead() ?
> -               swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
> -               swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> +       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> +               page =3D swapin_no_readahead(entry, gfp_mask, vmf);
> +               cached =3D false;
> +       } else if (swap_use_vma_readahead()) {
> +               page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
> +               cached =3D true;
> +       } else {

Notice that which flavor of swapin_read is actually a property of the
swap device.
For that device, it always calls the same swapin_entry function.

One idea is to have a VFS-like API for swap devices. This can be a
swapin_entry function callback from the swap_ops struct. Difference
swap devices just register different swapin_entry hooks. That way we
don't need to look at the device flags to decide what to do. We can
just call the VFS like swap_ops->swapin_entry(), the function pointer
will point to the right implementation. Then we don't need these three
levels if/else block. It is more flexible to register custom
implementations of swap layouts as well. Something to consider for the
future, you don't have to implement it in this series.

> +               page =3D swap_cluster_readahead(entry, gfp_mask, mpol, il=
x);
> +               cached =3D true;
> +       }
>         mpol_cond_put(mpol);
> +
> +       if (swapcached)
> +               *swapcached =3D cached;
> +
>         return page;
>  }
>
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 756104ebd585..0142bfc71b81 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1874,7 +1874,7 @@ static int unuse_pte_range(struct vm_area_struct *v=
ma, pmd_t *pmd,
>                         };
>
>                         page =3D swapin_readahead(entry, GFP_HIGHUSER_MOV=
ABLE,
> -                                               &vmf);
> +                                               &vmf, NULL);
>                         if (page)
>                                 folio =3D page_folio(page);
>                 }
> --
> 2.42.0
>
>
