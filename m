Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909DB7F3CF7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 05:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjKVEkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 23:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVEkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 23:40:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B749493
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:40:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44A43C433CA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700628041;
        bh=fqm+RgaDH3Xmb+EzKB3u8ayVNYdSSNdS9/AfVRa6Iok=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aS87ZZoDfgqVs7q9HElrvCYahNQsKKKuQkgLWyIOSM2UBzG8zXtllez/87rXjDLSD
         znZ5ZLtQdFSzELxpwCBU1MkIs3xuQAzAi1oD2CetikVPUSRfB4XQ5eV5KOCeWNcWgd
         hXUJKVGJIkw/zi6tTPEB7bAVGXAmhSYvlbtmCdWPXJG+dezkVqXoROZUYG+714MXAm
         xnUJZ1vHNQ9JDD1NB3SGs+6+dKCOuysfWjQv6uH0fkifrRQtoJ6QG9BDd+E/8wpOUE
         5jS7RHZLwi7ab4chQUsgu6/4V9jy9WssEIF9wSFdPgMGoSu1Jab9u9NF2jJJbR0lwq
         0cMeKUds+HW2Q==
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso5440416a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 20:40:41 -0800 (PST)
X-Gm-Message-State: AOJu0YwTE3SB8YA8FVvwzuio0wzWyXyiusYDxlhid/b/k0Lm3TmscAf/
        hcE0gP9jVn1QHanFsU2MhRHUpRgvlPD2f5lfr6ryEg==
X-Google-Smtp-Source: AGHT+IEuwUWEGCQfaPLdF+t0txZETzdSGaYG2KODSw+ICwD856mDZ05x0Yq+mxOC5jccSFOlib85BDy9P/Vu4nfe3Vw=
X-Received: by 2002:a17:90b:384c:b0:27d:7887:ddc5 with SMTP id
 nl12-20020a17090b384c00b0027d7887ddc5mr1609130pjb.32.1700628038735; Tue, 21
 Nov 2023 20:40:38 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-19-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-19-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 20:40:27 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNmzGSCE_VhXboXF4tGbLvJXxXYM6j-vkF4d1CkRB-z5A@mail.gmail.com>
Message-ID: <CAF8kJuNmzGSCE_VhXboXF4tGbLvJXxXYM6j-vkF4d1CkRB-z5A@mail.gmail.com>
Subject: Re: [PATCH 18/24] mm/swap: introduce a helper non fault swapin
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

On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> There are two places where swapin is not direct caused by page fault:
> shmem swapin is invoked through shmem mapping, swapoff cause swapin by
> walking the page table. They used to construct a pseudo vmfault struct
> for swapin function.
>
> Shmem has dropped the pseudo vmfault recently in commit ddc1a5cbc05d
> ("mempolicy: alloc_pages_mpol() for NUMA policy without vma"). Swapoff
> path is still using a pseudo vmfault.
>
> Introduce a helper for them both, this help save stack usage for swapoff
> path, and help apply a unified swapin cache and readahead policy check.
>
> Also prepare for follow up commits.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c      | 51 ++++++++++++++++---------------------------------
>  mm/swap.h       | 11 +++++++++++
>  mm/swap_state.c | 38 ++++++++++++++++++++++++++++++++++++
>  mm/swapfile.c   | 23 +++++++++++-----------
>  4 files changed, 76 insertions(+), 47 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index f9ce4067c742..81d129aa66d1 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1565,22 +1565,6 @@ static inline struct mempolicy *shmem_get_sbmpol(s=
truct shmem_sb_info *sbinfo)
>  static struct mempolicy *shmem_get_pgoff_policy(struct shmem_inode_info =
*info,
>                         pgoff_t index, unsigned int order, pgoff_t *ilx);
>
> -static struct folio *shmem_swapin_cluster(swp_entry_t swap, gfp_t gfp,
> -                       struct shmem_inode_info *info, pgoff_t index)
> -{
> -       struct mempolicy *mpol;
> -       pgoff_t ilx;
> -       struct page *page;
> -
> -       mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
> -       page =3D swap_cluster_readahead(swap, gfp, mpol, ilx);
> -       mpol_cond_put(mpol);
> -
> -       if (!page)
> -               return NULL;
> -       return page_folio(page);
> -}
> -

Nice. Thank you.

>  /*
>   * Make sure huge_gfp is always more limited than limit_gfp.
>   * Some of the flags set permissions, while others set limitations.
> @@ -1854,9 +1838,12 @@ static int shmem_swapin_folio(struct inode *inode,=
 pgoff_t index,
>  {
>         struct address_space *mapping =3D inode->i_mapping;
>         struct shmem_inode_info *info =3D SHMEM_I(inode);
> -       struct swap_info_struct *si;
> +       enum swap_cache_result result;
>         struct folio *folio =3D NULL;
> +       struct mempolicy *mpol;
> +       struct page *page;
>         swp_entry_t swap;
> +       pgoff_t ilx;
>         int error;
>
>         VM_BUG_ON(!*foliop || !xa_is_value(*foliop));
> @@ -1866,34 +1853,30 @@ static int shmem_swapin_folio(struct inode *inode=
, pgoff_t index,
>         if (is_poisoned_swp_entry(swap))
>                 return -EIO;
>
> -       si =3D get_swap_device(swap);
> -       if (!si) {
> +       mpol =3D shmem_get_pgoff_policy(info, index, 0, &ilx);
> +       page =3D swapin_page_non_fault(swap, gfp, mpol, ilx, fault_mm, &r=
esult);

Notice this "result" CAN be outdated. e.g. after this call, the swap
cache can be changed by another thread generating the swap page fault
and installing the folio into the swap cache or removing it.

> +       mpol_cond_put(mpol);
> +
> +       if (PTR_ERR(page) =3D=3D -EBUSY) {
>                 if (!shmem_confirm_swap(mapping, index, swap))
>                         return -EEXIST;
Not your fault . The if statement already returned.
>                 else
This is not needed, the next return -EINVAL can be one less indent level.
>                         return -EINVAL;
> -       }
> -
> -       /* Look it up and read it in.. */
> -       folio =3D swap_cache_get_folio(swap, NULL, NULL);
> -       if (!folio) {
> -               /* Or update major stats only when swapin succeeds?? */
> -               if (fault_type) {
> +       } else if (!page) {
Don't need the else here because previous if statement always return.

> +               error =3D -ENOMEM;
> +               goto failed;
> +       } else {

Don't need the else here. Previous goto terminate the flow.

> +               folio =3D page_folio(page);
> +               if (fault_type && result !=3D SWAP_CACHE_HIT) {
>                         *fault_type |=3D VM_FAULT_MAJOR;
>                         count_vm_event(PGMAJFAULT);
>                         count_memcg_event_mm(fault_mm, PGMAJFAULT);
>                 }
> -               /* Here we actually start the io */
> -               folio =3D shmem_swapin_cluster(swap, gfp, info, index);
> -               if (!folio) {
> -                       error =3D -ENOMEM;
> -                       goto failed;
> -               }
>         }
>
>         /* We have to do this with folio locked to prevent races */
>         folio_lock(folio);
> -       if (!folio_test_swapcache(folio) ||
> +       if ((result !=3D SWAP_CACHE_BYPASS && !folio_test_swapcache(folio=
)) ||

I think there is a possible racing bug here. Because the result can be outd=
ated.

>             folio->swap.val !=3D swap.val ||
>             !shmem_confirm_swap(mapping, index, swap)) {
>                 error =3D -EEXIST;
> @@ -1930,7 +1913,6 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         delete_from_swap_cache(folio);
>         folio_mark_dirty(folio);
>         swap_free(swap);
> -       put_swap_device(si);
>
>         *foliop =3D folio;
>         return 0;
> @@ -1944,7 +1926,6 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>                 folio_unlock(folio);
>                 folio_put(folio);
>         }
> -       put_swap_device(si);
>
>         return error;
>  }
> diff --git a/mm/swap.h b/mm/swap.h
> index da9deb5ba37d..b073c29c9790 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -62,6 +62,10 @@ struct page *swap_cluster_readahead(swp_entry_t entry,=
 gfp_t flag,
>                                     struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
>                               struct vm_fault *vmf, enum swap_cache_resul=
t *result);
> +struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
> +                                  struct mempolicy *mpol, pgoff_t ilx,
> +                                  struct mm_struct *mm,
> +                                  enum swap_cache_result *result);
>
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -103,6 +107,13 @@ static inline struct page *swapin_readahead(swp_entr=
y_t swp, gfp_t gfp_mask,
>         return NULL;
>  }
>
> +static inline struct page *swapin_page_non_fault(swp_entry_t entry, gfp_=
t gfp_mask,
> +               struct mempolicy *mpol, pgoff_t ilx, struct mm_struct *mm=
,
> +               enum swap_cache_result *result)
> +{
> +       return NULL;
> +}
> +
>  static inline int swap_writepage(struct page *p, struct writeback_contro=
l *wbc)
>  {
>         return 0;
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ff8a166603d0..eef66757c615 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -956,6 +956,44 @@ struct page *swapin_readahead(swp_entry_t entry, gfp=
_t gfp_mask,
>         return page;
>  }
>
> +struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
> +                                  struct mempolicy *mpol, pgoff_t ilx,
> +                                  struct mm_struct *mm, enum swap_cache_=
result *result)

Can you get a better function name? e.g. no negative works. The
function should be named after what it does, not who calls it. The
caller usage might change over time.
I saw that swapin_page_non_fault() and swapin_readahead() are doing
similar things and with similar structure. Can you unify these two
somehow?

Chris

> +{
> +       enum swap_cache_result cache_result;
> +       struct swap_info_struct *si;
> +       void *shadow =3D NULL;
> +       struct folio *folio;
> +       struct page *page;
> +
> +       /* Prevent swapoff from happening to us */
> +       si =3D get_swap_device(entry);
> +       if (unlikely(!si))
> +               return ERR_PTR(-EBUSY);
> +
> +       folio =3D swap_cache_get_folio(entry, NULL, &shadow);
> +       if (folio) {
> +               page =3D folio_file_page(folio, swp_offset(entry));
> +               cache_result =3D SWAP_CACHE_HIT;
> +               goto done;
> +       }
> +
> +       if (swap_use_no_readahead(si, swp_offset(entry))) {
> +               page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
mm);
> +               if (shadow)
> +                       workingset_refault(page_folio(page), shadow);
> +               cache_result =3D SWAP_CACHE_BYPASS;
> +       } else {
> +               page =3D swap_cluster_readahead(entry, gfp_mask, mpol, il=
x);
> +               cache_result =3D SWAP_CACHE_MISS;
> +       }
> +done:
> +       put_swap_device(si);
> +       if (result)
> +               *result =3D cache_result;
> +       return page;
> +}
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t vma_ra_enabled_show(struct kobject *kobj,
>                                      struct kobj_attribute *attr, char *b=
uf)
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 925ad92486a4..f8c5096fe0f0 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1822,20 +1822,15 @@ static int unuse_pte_range(struct vm_area_struct =
*vma, pmd_t *pmd,
>
>         si =3D swap_info[type];
>         do {
> +               int ret;
> +               pte_t ptent;
> +               pgoff_t ilx;
> +               swp_entry_t entry;
>                 struct page *page;
>                 unsigned long offset;
> +               struct mempolicy *mpol;
>                 unsigned char swp_count;
>                 struct folio *folio =3D NULL;
> -               swp_entry_t entry;
> -               int ret;
> -               pte_t ptent;
> -
> -               struct vm_fault vmf =3D {
> -                       .vma =3D vma,
> -                       .address =3D addr,
> -                       .real_address =3D addr,
> -                       .pmd =3D pmd,
> -               };
>
>                 if (!pte++) {
>                         pte =3D pte_offset_map(pmd, addr);
> @@ -1855,8 +1850,12 @@ static int unuse_pte_range(struct vm_area_struct *=
vma, pmd_t *pmd,
>                 offset =3D swp_offset(entry);
>                 pte_unmap(pte);
>                 pte =3D NULL;
> -               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -                                       &vmf, NULL);
> +
> +               mpol =3D get_vma_policy(vma, addr, 0, &ilx);
> +               page =3D swapin_page_non_fault(entry, GFP_HIGHUSER_MOVABL=
E,
> +                                            mpol, ilx, vma->vm_mm, NULL)=
;
> +               mpol_cond_put(mpol);
> +
>                 if (IS_ERR(page))
>                         return PTR_ERR(page);
>                 else if (page)
> --
> 2.42.0
>
>
