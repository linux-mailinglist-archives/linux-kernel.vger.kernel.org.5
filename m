Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC497F332A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:06:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232572AbjKUQGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:06:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjKUQGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:06:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD68BC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:06:32 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CC3C4339A
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700582791;
        bh=ePKC0MeblKMps/7S6gLuFwH40gWsMZm5efTapHlDGXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QvmCXyO6VpEFa/MqeWBSV6Wcbv8lme9yX8emA0dlbYSQhi+ZPPNu2+/FHniDn9Rks
         AdkXiWn3ZRLbzRWqJoUxL8fYpvDIC6te3Xn5D3uhdP0cO9v8aZ0kJbbM7BahoLu8K7
         ybo0gtMWt7E2w5BOY37llmiQtORybCOsYp2SYClu3DwHHsU4raqKZitWnCituMu89/
         /7dm5agC/6EcO75/Aj3p7GYcnIHStqtu91j0PIeGgQRl7xQFcnQ63R7Hy1obq+ZTVZ
         8jVoGN/AHi3w7x1sM0IpdCblKbZbdeg3mox9bI8xMsObp+gs/zNXjlkeDEtDLXAjG3
         0D216TOwBD61w==
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5bde80aad05so4483969a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:06:31 -0800 (PST)
X-Gm-Message-State: AOJu0YzL8x/zM+7QVWTTEJP6OuDkLAN+1c+dFZlBPVhoNq/nPcfd8pv0
        m+YtHoDfXmz8jPmCB9bWZ+H1uDIU2uExu9kSE9P8+w==
X-Google-Smtp-Source: AGHT+IFugt8donad+hMnLy4aSWfmTMDvul2xNH+gshB3rbWy/B7E/Ldr7uzXzMZ1rkdwRyz2k55OLHCcj5Oat/UHziw=
X-Received: by 2002:a17:90a:f181:b0:280:125:e52e with SMTP id
 bv1-20020a17090af18100b002800125e52emr11158364pjb.35.1700582791085; Tue, 21
 Nov 2023 08:06:31 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-12-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-12-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 08:06:19 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN+4HswStj4wSZHGQdx9g2tqzCtMA+6CLO7+HmozL6t2Q@mail.gmail.com>
Message-ID: <CAF8kJuN+4HswStj4wSZHGQdx9g2tqzCtMA+6CLO7+HmozL6t2Q@mail.gmail.com>
Subject: Re: [PATCH 11/24] mm/swap: also handle swapcache lookup in swapin_readahead
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
> No feature change, just prepare for later commits.

You need to have a proper commit message why this change needs to happen.
Preparing is too generic, it does not give any real information.
For example, it seems you want to reduce one swap cache lookup because
swap_readahead already has it?

I am a bit puzzled at this patch. It shuffles a lot of sensitive code.
However I do not get  the value.
It seems like this patch should be merged with the later patch that
depends on it to be judged together.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 61 +++++++++++++++++++++++--------------------------
>  mm/swap.h       | 10 ++++++--
>  mm/swap_state.c | 26 +++++++++++++--------
>  mm/swapfile.c   | 30 +++++++++++-------------
>  4 files changed, 66 insertions(+), 61 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index f4237a2e3b93..22af9f3e8c75 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3786,13 +3786,13 @@ static vm_fault_t handle_pte_marker(struct vm_fau=
lt *vmf)
>  vm_fault_t do_swap_page(struct vm_fault *vmf)
>  {
>         struct vm_area_struct *vma =3D vmf->vma;
> -       struct folio *swapcache, *folio =3D NULL;
> +       struct folio *swapcache =3D NULL, *folio =3D NULL;
> +       enum swap_cache_result cache_result;
>         struct page *page;
>         struct swap_info_struct *si =3D NULL;
>         rmap_t rmap_flags =3D RMAP_NONE;
>         bool exclusive =3D false;
>         swp_entry_t entry;
> -       bool swapcached;
>         pte_t pte;
>         vm_fault_t ret =3D 0;
>
> @@ -3850,42 +3850,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (unlikely(!si))
>                 goto out;
>
> -       folio =3D swap_cache_get_folio(entry, vma, vmf->address);
> -       if (folio)
> -               page =3D folio_file_page(folio, swp_offset(entry));
> -       swapcache =3D folio;

Is the motivation that swap_readahead() already has a swap cache look up so=
 you
remove this look up here?


> -
> -       if (!folio) {
> -               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> -                                       vmf, &swapcached);
> -               if (page) {
> -                       folio =3D page_folio(page);
> -                       if (swapcached)
> -                               swapcache =3D folio;
> -               } else {
> +       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +                               vmf, &cache_result);
> +       if (page) {
> +               folio =3D page_folio(page);
> +               if (cache_result !=3D SWAP_CACHE_HIT) {
> +                       /* Had to read the page from swap area: Major fau=
lt */
> +                       ret =3D VM_FAULT_MAJOR;
> +                       count_vm_event(PGMAJFAULT);
> +                       count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> +               }
> +               if (cache_result !=3D SWAP_CACHE_BYPASS)
> +                       swapcache =3D folio;
> +               if (PageHWPoison(page)) {

There is a lot of code shuffle here. From the diff it is hard to tell
if they are doing the same thing as before.

>                         /*
> -                        * Back out if somebody else faulted in this pte
> -                        * while we released the pte lock.
> +                        * hwpoisoned dirty swapcache pages are kept for =
killing
> +                        * owner processes (which may be unknown at hwpoi=
son time)
>                          */
> -                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf-=
>pmd,
> -                                       vmf->address, &vmf->ptl);
> -                       if (likely(vmf->pte &&
> -                                  pte_same(ptep_get(vmf->pte), vmf->orig=
_pte)))
> -                               ret =3D VM_FAULT_OOM;
> -                       goto unlock;
> +                       ret =3D VM_FAULT_HWPOISON;
> +                       goto out_release;
>                 }
> -
> -               /* Had to read the page from swap area: Major fault */
> -               ret =3D VM_FAULT_MAJOR;
> -               count_vm_event(PGMAJFAULT);
> -               count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> -       } else if (PageHWPoison(page)) {
> +       } else {
>                 /*
> -                * hwpoisoned dirty swapcache pages are kept for killing
> -                * owner processes (which may be unknown at hwpoison time=
)
> +                * Back out if somebody else faulted in this pte
> +                * while we released the pte lock.
>                  */
> -               ret =3D VM_FAULT_HWPOISON;
> -               goto out_release;
> +               vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd,
> +                               vmf->address, &vmf->ptl);
> +               if (likely(vmf->pte &&
> +                          pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
> +                       ret =3D VM_FAULT_OOM;
> +               goto unlock;
>         }
>
>         ret |=3D folio_lock_or_retry(folio, vmf);
> diff --git a/mm/swap.h b/mm/swap.h
> index a9a654af791e..ac9136eee690 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -30,6 +30,12 @@ extern struct address_space *swapper_spaces[];
>         (&swapper_spaces[swp_type(entry)][swp_offset(entry) \
>                 >> SWAP_ADDRESS_SPACE_SHIFT])
>
> +enum swap_cache_result {
> +       SWAP_CACHE_HIT,
> +       SWAP_CACHE_MISS,
> +       SWAP_CACHE_BYPASS,
> +};

Does any function later care about CACHE_BYPASS?

Again, better introduce it with the function that uses it. Don't
introduce it for "just in case I might use it later".

> +
>  void show_swap_cache_info(void);
>  bool add_to_swap(struct folio *folio);
>  void *get_shadow_from_swap_cache(swp_entry_t entry);
> @@ -55,7 +61,7 @@ struct page *__read_swap_cache_async(swp_entry_t entry,=
 gfp_t gfp_mask,
>  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
>                                     struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> -                             struct vm_fault *vmf, bool *swapcached);
> +                             struct vm_fault *vmf, enum swap_cache_resul=
t *result);
>
>  static inline unsigned int folio_swap_flags(struct folio *folio)
>  {
> @@ -92,7 +98,7 @@ static inline struct page *swap_cluster_readahead(swp_e=
ntry_t entry,
>  }
>
>  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_m=
ask,
> -                       struct vm_fault *vmf, bool *swapcached)
> +                       struct vm_fault *vmf, enum swap_cache_result *res=
ult)
>  {
>         return NULL;
>  }
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index d87c20f9f7ec..e96d63bf8a22 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -908,8 +908,7 @@ static struct page *swapin_no_readahead(swp_entry_t e=
ntry, gfp_t gfp_mask,
>   * @entry: swap entry of this memory
>   * @gfp_mask: memory allocation flags
>   * @vmf: fault information
> - * @swapcached: pointer to a bool used as indicator if the
> - *              page is swapped in through swapcache.
> + * @result: a return value to indicate swap cache usage.
>   *
>   * Returns the struct page for entry and addr, after queueing swapin.
>   *
> @@ -918,30 +917,39 @@ static struct page *swapin_no_readahead(swp_entry_t=
 entry, gfp_t gfp_mask,
>   * or vma-based(ie, virtual address based on faulty address) readahead.
>   */
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -                             struct vm_fault *vmf, bool *swapcached)
> +                             struct vm_fault *vmf, enum swap_cache_resul=
t *result)
>  {
> +       enum swap_cache_result cache_result;
>         struct swap_info_struct *si;
>         struct mempolicy *mpol;
> +       struct folio *folio;
>         struct page *page;
>         pgoff_t ilx;
> -       bool cached;
> +
> +       folio =3D swap_cache_get_folio(entry, vmf->vma, vmf->address);
> +       if (folio) {
> +               page =3D folio_file_page(folio, swp_offset(entry));
> +               cache_result =3D SWAP_CACHE_HIT;
> +               goto done;
> +       }
>
>         si =3D swp_swap_info(entry);
>         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>         if (swap_use_no_readahead(si, swp_offset(entry))) {
>                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
> -               cached =3D false;
> +               cache_result =3D SWAP_CACHE_BYPASS;
>         } else if (swap_use_vma_readahead(si)) {
>                 page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
> -               cached =3D true;
> +               cache_result =3D SWAP_CACHE_MISS;
>         } else {
>                 page =3D swap_cluster_readahead(entry, gfp_mask, mpol, il=
x);
> -               cached =3D true;
> +               cache_result =3D SWAP_CACHE_MISS;
>         }
>         mpol_cond_put(mpol);
>
> -       if (swapcached)
> -               *swapcached =3D cached;
> +done:
> +       if (result)
> +               *result =3D cache_result;
>
>         return page;
>  }
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index 01c3f53b6521..b6d57fff5e21 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -1822,13 +1822,21 @@ static int unuse_pte_range(struct vm_area_struct =
*vma, pmd_t *pmd,
>
>         si =3D swap_info[type];
>         do {
> -               struct folio *folio;
> +               struct page *page;
>                 unsigned long offset;
>                 unsigned char swp_count;
> +               struct folio *folio =3D NULL;
>                 swp_entry_t entry;
>                 int ret;
>                 pte_t ptent;
>
> +               struct vm_fault vmf =3D {
> +                       .vma =3D vma,
> +                       .address =3D addr,
> +                       .real_address =3D addr,
> +                       .pmd =3D pmd,
> +               };

Is this code move caused by skipping the swap cache look up here?

This is very sensitive code related to swap cache racing. It needs
very careful reviewing. Better not shuffle it for no good reason.

Chris

> +
>                 if (!pte++) {
>                         pte =3D pte_offset_map(pmd, addr);
>                         if (!pte)
> @@ -1847,22 +1855,10 @@ static int unuse_pte_range(struct vm_area_struct =
*vma, pmd_t *pmd,
>                 offset =3D swp_offset(entry);
>                 pte_unmap(pte);
>                 pte =3D NULL;
> -
> -               folio =3D swap_cache_get_folio(entry, vma, addr);
> -               if (!folio) {
> -                       struct page *page;
> -                       struct vm_fault vmf =3D {
> -                               .vma =3D vma,
> -                               .address =3D addr,
> -                               .real_address =3D addr,
> -                               .pmd =3D pmd,
> -                       };
> -
> -                       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOV=
ABLE,
> -                                               &vmf, NULL);
> -                       if (page)
> -                               folio =3D page_folio(page);
> -               }
> +               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> +                                       &vmf, NULL);
> +               if (page)
> +                       folio =3D page_folio(page);
>                 if (!folio) {
>                         /*
>                          * The entry could have been freed, and will not
> --
> 2.42.0
>
>
