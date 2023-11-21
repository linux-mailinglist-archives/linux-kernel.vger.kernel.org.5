Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292F7F34B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjKURQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:16:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjKURQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:16:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B2418C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39A2C433CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700586961;
        bh=C2o6Du8XtSWYB4gbq77qkTzMSqsl//9Xx/hGvIH9cJI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dPoMeaIf6+HEqOv8P3GDpkfza+aXvuy1cRAG5921pE3EusZ0JkMjwnWq8VAUKmOMK
         e72/S/zdceQ5tzVOCGvzjxiVix2nLbvB68AcxodbYt7J8ojHV/idr73o2K7EMFfPH9
         GAtu+lsOVzWKtjFQENnDEL8ND9ftKIvgBIYKH/w1EkBcKAcHNEqqpOFp1hbskBjcZD
         dKrU882xe1tLnQeH2JABE7GfdW7FiOF24EESLVKLOK9l2BlDKYmB5wf/rOUZfBPvj/
         Uhh7ehd3eMTPLEZxOKjKrBFfqSSXcp9F4c7y4s+l7f4OtWhIXGhO+uZo5BmWdNY81W
         MAOJN201ViAiA==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28035cf6a30so4538220a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:16:01 -0800 (PST)
X-Gm-Message-State: AOJu0YyEZQO78vJwoT3cJFl5jHE7tTMChr6jUkAz0w+lggRw0JBmOSAQ
        ajT+1TP/bo2+8dqJPdplIkqnAA/14doB1LuBRe2vFg==
X-Google-Smtp-Source: AGHT+IH/Jim9Fey3EiHvbDawPJNw5h8OgyvTVFblOywnUJCMzMkU4OccUtDTcvFWeAi5rp7XQT0XwSIcyW5EU5b2f98=
X-Received: by 2002:a17:90b:3b4b:b0:280:2823:6612 with SMTP id
 ot11-20020a17090b3b4b00b0028028236612mr8785203pjb.35.1700586961111; Tue, 21
 Nov 2023 09:16:01 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-16-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-16-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 09:15:50 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM3Czmr1Up9mYGK9k9HH8r0CHkXvZ8rWyqniM4vtExF+Q@mail.gmail.com>
Message-ID: <CAF8kJuM3Czmr1Up9mYGK9k9HH8r0CHkXvZ8rWyqniM4vtExF+Q@mail.gmail.com>
Subject: Re: [PATCH 15/24] mm/swap: avoid an duplicated swap cache lookup for
 SYNCHRONOUS_IO device
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
> When a xa_value is returned by the cache lookup, keep it to be used
> later for workingset refault check instead of doing the looking up again
> in swapin_no_readahead.
>
> This does have a side effect of making swapoff also triggers workingset
> check, but should be fine since swapoff does effect the workload in many
> ways already.

I need to sleep on it a bit to see if this will create another problem or n=
ot.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index e057c79fb06f..51de2a0412df 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -872,7 +872,6 @@ static struct page *swapin_no_readahead(swp_entry_t e=
ntry, gfp_t gfp_mask,
>  {
>         struct folio *folio;
>         struct page *page;
> -       void *shadow =3D NULL;
>
>         page =3D alloc_pages_mpol(gfp_mask, 0, mpol, ilx, numa_node_id())=
;
>         folio =3D (struct folio *)page;
> @@ -888,10 +887,6 @@ static struct page *swapin_no_readahead(swp_entry_t =
entry, gfp_t gfp_mask,
>
>                 mem_cgroup_swapin_uncharge_swap(entry);
>
> -               shadow =3D get_shadow_from_swap_cache(entry);
> -               if (shadow)
> -                       workingset_refault(folio, shadow);
> -
>                 folio_add_lru(folio);
>
>                 /* To provide entry to swap_readpage() */
> @@ -922,11 +917,12 @@ struct page *swapin_readahead(swp_entry_t entry, gf=
p_t gfp_mask,
>         enum swap_cache_result cache_result;
>         struct swap_info_struct *si;
>         struct mempolicy *mpol;
> +       void *shadow =3D NULL;
>         struct folio *folio;
>         struct page *page;
>         pgoff_t ilx;
>
> -       folio =3D swap_cache_get_folio(entry, vmf, NULL);
> +       folio =3D swap_cache_get_folio(entry, vmf, &shadow);
>         if (folio) {
>                 page =3D folio_file_page(folio, swp_offset(entry));
>                 cache_result =3D SWAP_CACHE_HIT;
> @@ -938,6 +934,8 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_=
t gfp_mask,
>         if (swap_use_no_readahead(si, swp_offset(entry))) {
>                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
>                 cache_result =3D SWAP_CACHE_BYPASS;
> +               if (shadow)
> +                       workingset_refault(page_folio(page), shadow);

It is inconsistent why other flavors of readahead do not do the
workingset_refault here.
I suggest keeping the workingset_refault in swapin_no_readahead() and
pass the shadow argument in.

Chris

>         } else if (swap_use_vma_readahead(si)) {
>                 page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
>                 cache_result =3D SWAP_CACHE_MISS;
> --
> 2.42.0
>
>
