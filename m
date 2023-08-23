Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55014785B9D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 17:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbjHWPMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 11:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236905AbjHWPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:12:45 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185AEEC
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:12:43 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99de884ad25so768149066b.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692803561; x=1693408361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpoAy4jnvOK1xW6jFL+0DmNbwXzcQEUlVeR2jyjxQ1A=;
        b=W5i1r1gIPpq7njhCQ839rCz/rmhoPQ98F/D86/DYZROi14613JsrXcVrCCQL7CY+Pa
         YR2JiftWJqLyVLfnxbacHoN6P9eJjYRm6T0BgPK7WLs6W/iO6RWEmpnYKtTsMYNTXwmC
         ilr0e+XcXUfZ4u49neUSHfNjO6XHf0AohNg+5MStLyYTQEZV17fSocFIgdUWTLsP/tz2
         sOzj0bl3TAQ1H6tgIua/ZuMLnytj6Au7zgQ/7DBeUMxx4bFQXwTQHjzfE2aMEla7ovMR
         JWOf9NmVQJg+OLCGnKAzrrHjJTekZVaVzktNWgrjVKfEjcRJRawUf/6tsvIgQuzvdXOI
         N2jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692803561; x=1693408361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpoAy4jnvOK1xW6jFL+0DmNbwXzcQEUlVeR2jyjxQ1A=;
        b=ElT5PEVEOauuhq7RLqhmOSXCrrLaSubCf8v0nVEYLOYi16juhMX4rOFFDq1NVv0G15
         qwmpmq0yBjODvVBF/nwCwzDnekgG5CUnTa/qkWdEwrF4RU8BSe6ML10Z9F2QqmDqooe6
         kulucOMt+klXsss3BPa0kn6CRG24ukrRJjVMpem/azrTA8MVVtDx00NTzn1deND+CBbc
         bUVGREpfefbPm8mioGbYwhg0veLtCwtqfWczBvyDnH1VdzetIrgoPARkDBizVIH6LZYl
         xAiWUj/oTtyRy7XDI9Th+CUDIoAw9wLMw5MUr7bJhylUjENpMkdlO75EeJipfH6eoaDq
         OHJA==
X-Gm-Message-State: AOJu0Yx4PUlQAq80j1pGCspIPEHijVatDaa9e6piNV/KWoQ0BdOLGtdy
        otdRcprI4CfuzC2UlUFwuc5nkd44kHp4ia7tJ5zW5Q==
X-Google-Smtp-Source: AGHT+IEKeKdtIHQh5mZfaEHRRPX3jGpU0RqmjPEr4eDQfl7Gcd2SKTSFMl3JnY6Axip7ScrNd8RUJLaXRfHLgQg2XyU=
X-Received: by 2002:a17:906:9d2:b0:99e:39d:4fa7 with SMTP id
 r18-20020a17090609d200b0099e039d4fa7mr9787481eje.22.1692803561333; Wed, 23
 Aug 2023 08:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-2-david@redhat.com>
In-Reply-To: <20230821160849.531668-2-david@redhat.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Aug 2023 08:12:05 -0700
Message-ID: <CAJD7tkYbHUVbg8LexkBsC9rLFBRrBSQYgOZ1tPKTDGEcWrAghQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 1/4] mm/swap: stop using page->private on
 tail pages for THP_SWAP
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's stop using page->private on tail pages, making it possible to
> just unconditionally reuse that field in the tail pages of large folios.
>
> The remaining usage of the private field for THP_SWAP is in the THP
> splitting code (mm/huge_memory.c), that we'll handle separately later.
>
> Update the THP_SWAP documentation and sanity checks in mm_types.h and
> __split_huge_page_tail().
>
> Signed-off-by: David Hildenbrand <david@redhat.com>

The mm part looks good to me (with the added fixup):

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Minor nit below, not worth a respin, but perhaps if you respin anyway
for something else.
> ---
>  arch/arm64/mm/mteswap.c  |  5 +++--
>  include/linux/mm_types.h | 12 +-----------
>  include/linux/swap.h     |  9 +++++++++
>  mm/huge_memory.c         | 15 ++++++---------
>  mm/memory.c              |  2 +-
>  mm/rmap.c                |  2 +-
>  mm/swap_state.c          |  5 +++--
>  mm/swapfile.c            |  4 ++--
>  8 files changed, 26 insertions(+), 28 deletions(-)
>
> diff --git a/arch/arm64/mm/mteswap.c b/arch/arm64/mm/mteswap.c
> index cd508ba80ab1..a31833e3ddc5 100644
> --- a/arch/arm64/mm/mteswap.c
> +++ b/arch/arm64/mm/mteswap.c
> @@ -33,8 +33,9 @@ int mte_save_tags(struct page *page)
>
>         mte_save_page_tags(page_address(page), tag_storage);
>
> -       /* page_private contains the swap entry.val set in do_swap_page *=
/
> -       ret =3D xa_store(&mte_pages, page_private(page), tag_storage, GFP=
_KERNEL);
> +       /* lookup the swap entry.val from the page */
> +       ret =3D xa_store(&mte_pages, page_swap_entry(page).val, tag_stora=
ge,
> +                      GFP_KERNEL);
>         if (WARN(xa_is_err(ret), "Failed to store MTE tags")) {
>                 mte_free_tag_storage(tag_storage);
>                 return xa_err(ret);
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index b9b6c88875b9..61361f1750c3 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -333,11 +333,8 @@ struct folio {
>                         atomic_t _pincount;
>  #ifdef CONFIG_64BIT
>                         unsigned int _folio_nr_pages;
> -                       /* 4 byte gap here */
> -       /* private: the union with struct page is transitional */
> -                       /* Fix THP_SWAP to not use tail->private */
> -                       unsigned long _private_1;
>  #endif
> +       /* private: the union with struct page is transitional */
>                 };
>                 struct page __page_1;
>         };
> @@ -358,9 +355,6 @@ struct folio {
>         /* public: */
>                         struct list_head _deferred_list;
>         /* private: the union with struct page is transitional */
> -                       unsigned long _avail_2a;
> -                       /* Fix THP_SWAP to not use tail->private */
> -                       unsigned long _private_2a;
>                 };
>                 struct page __page_2;
>         };
> @@ -385,9 +379,6 @@ FOLIO_MATCH(memcg_data, memcg_data);
>                         offsetof(struct page, pg) + sizeof(struct page))
>  FOLIO_MATCH(flags, _flags_1);
>  FOLIO_MATCH(compound_head, _head_1);
> -#ifdef CONFIG_64BIT
> -FOLIO_MATCH(private, _private_1);
> -#endif
>  #undef FOLIO_MATCH
>  #define FOLIO_MATCH(pg, fl)                                            \
>         static_assert(offsetof(struct folio, fl) =3D=3D                  =
   \
> @@ -396,7 +387,6 @@ FOLIO_MATCH(flags, _flags_2);
>  FOLIO_MATCH(compound_head, _head_2);
>  FOLIO_MATCH(flags, _flags_2a);
>  FOLIO_MATCH(compound_head, _head_2a);
> -FOLIO_MATCH(private, _private_2a);
>  #undef FOLIO_MATCH
>
>  /**
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index bb5adc604144..84fe0e94f5cd 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -339,6 +339,15 @@ static inline swp_entry_t folio_swap_entry(struct fo=
lio *folio)
>         return entry;
>  }
>
> +static inline swp_entry_t page_swap_entry(struct page *page)
> +{
> +       struct folio *folio =3D page_folio(page);
> +       swp_entry_t entry =3D folio_swap_entry(folio);
> +
> +       entry.val +=3D page - &folio->page;
> +       return entry;
> +}
> +
>  static inline void folio_set_swap_entry(struct folio *folio, swp_entry_t=
 entry)
>  {
>         folio->private =3D (void *)entry.val;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index cc2f65f8cc62..c04702ae71d2 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2446,18 +2446,15 @@ static void __split_huge_page_tail(struct page *h=
ead, int tail,
>         page_tail->index =3D head->index + tail;
>
>         /*
> -        * page->private should not be set in tail pages with the excepti=
on
> -        * of swap cache pages that store the swp_entry_t in tail pages.
> -        * Fix up and warn once if private is unexpectedly set.
> -        *
> -        * What of 32-bit systems, on which folio->_pincount overlays
> -        * head[1].private?  No problem: THP_SWAP is not enabled on 32-bi=
t, and
> -        * pincount must be 0 for folio_ref_freeze() to have succeeded.
> +        * page->private should not be set in tail pages. Fix up and warn=
 once
> +        * if private is unexpectedly set.
>          */
> -       if (!folio_test_swapcache(page_folio(head))) {
> -               VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page_tail=
);
> +       if (unlikely(page_tail->private)) {
> +               VM_WARN_ON_ONCE_PAGE(true, page_tail);
>                 page_tail->private =3D 0;
>         }

Could probably save a couple of lines here:

if (VM_WARN_ON_ONCE_PAGE(page_tail->private !=3D 0, page_tail))

       page_tail->private =3D 0;

> +       if (PageSwapCache(head))
> +               set_page_private(page_tail, (unsigned long)head->private =
+ tail);
>
>         /* Page flags must be visible before we make the page non-compoun=
d. */
>         smp_wmb();
> diff --git a/mm/memory.c b/mm/memory.c
> index d003076b218d..ff13242c1589 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3882,7 +3882,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>                  * changed.
>                  */
>                 if (unlikely(!folio_test_swapcache(folio) ||
> -                            page_private(page) !=3D entry.val))
> +                            page_swap_entry(page).val !=3D entry.val))
>                         goto out_page;
>
>                 /*
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 1f04debdc87a..ec7f8e6c9e48 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -1647,7 +1647,7 @@ static bool try_to_unmap_one(struct folio *folio, s=
truct vm_area_struct *vma,
>                          */
>                         dec_mm_counter(mm, mm_counter(&folio->page));
>                 } else if (folio_test_anon(folio)) {
> -                       swp_entry_t entry =3D { .val =3D page_private(sub=
page) };
> +                       swp_entry_t entry =3D page_swap_entry(subpage);
>                         pte_t swp_pte;
>                         /*
>                          * Store the swap location in the pte.
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 01f15139b7d9..2f2417810052 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -100,6 +100,7 @@ int add_to_swap_cache(struct folio *folio, swp_entry_=
t entry,
>
>         folio_ref_add(folio, nr);
>         folio_set_swapcache(folio);
> +       folio_set_swap_entry(folio, entry);
>
>         do {
>                 xas_lock_irq(&xas);
> @@ -113,7 +114,6 @@ int add_to_swap_cache(struct folio *folio, swp_entry_=
t entry,
>                                 if (shadowp)
>                                         *shadowp =3D old;
>                         }
> -                       set_page_private(folio_page(folio, i), entry.val =
+ i);
>                         xas_store(&xas, folio);
>                         xas_next(&xas);
>                 }
> @@ -154,9 +154,10 @@ void __delete_from_swap_cache(struct folio *folio,
>         for (i =3D 0; i < nr; i++) {
>                 void *entry =3D xas_store(&xas, shadow);
>                 VM_BUG_ON_PAGE(entry !=3D folio, entry);
> -               set_page_private(folio_page(folio, i), 0);
>                 xas_next(&xas);
>         }
> +       entry.val =3D 0;
> +       folio_set_swap_entry(folio, entry);
>         folio_clear_swapcache(folio);
>         address_space->nrpages -=3D nr;
>         __node_stat_mod_folio(folio, NR_FILE_PAGES, -nr);
> diff --git a/mm/swapfile.c b/mm/swapfile.c
> index d46933adf789..bd9d904671b9 100644
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -3369,7 +3369,7 @@ struct swap_info_struct *swp_swap_info(swp_entry_t =
entry)
>
>  struct swap_info_struct *page_swap_info(struct page *page)
>  {
> -       swp_entry_t entry =3D { .val =3D page_private(page) };
> +       swp_entry_t entry =3D page_swap_entry(page);
>         return swp_swap_info(entry);
>  }
>
> @@ -3384,7 +3384,7 @@ EXPORT_SYMBOL_GPL(swapcache_mapping);
>
>  pgoff_t __page_file_index(struct page *page)
>  {
> -       swp_entry_t swap =3D { .val =3D page_private(page) };
> +       swp_entry_t swap =3D page_swap_entry(page);
>         return swp_offset(swap);
>  }
>  EXPORT_SYMBOL_GPL(__page_file_index);
> --
> 2.41.0
>
>
