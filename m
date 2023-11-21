Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7127F33E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUQgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233677AbjKUQgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:36:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1190F199
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:36:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF569C433CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584599;
        bh=xTCdppnNrLRTcBODBfq5VC+EuncNcZtVGMcvlAsIibA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BgoUGj0oDfEZAUdRUYuX4JDhOar8o4U1ifqa+rJ2kRXQ5aVWZqKDVJhmwQs5RRu9k
         04Eyb+uqa4EXDQZd1i4LfvdRni3fCgcboktrp1bBhUHFTlgGgLr9rO6N/EPH3um1SR
         HmpuaVlcGkJ9IoK8WqHm7d8UR+SF1UDI3BRX4z1rsOH1gKF4rAgfRPBH3rkR01Q+vI
         8Ed35lMkh2/1hm99hbPDgJsv/bcr8KA5T74S+Rqmvu8PmyYuf5MV+TrJMMLjQCF8sJ
         +XP00xqz5/UhAxZkM+hXQkrwks5LcbZS2b3/9L+47IZlBbvYNes//7aiH8jqo9z9vQ
         154A2jevKg/aw==
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-280351c32afso4626371a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:36:39 -0800 (PST)
X-Gm-Message-State: AOJu0Yw2PzqSGAYIPsaakHR+Bjog3mNzebaCciBW/XNNxU36c+AQZuwg
        zGbS+DzRJr+jP5UCfT1yzZfdZZO+ooFiFio+C+rMdg==
X-Google-Smtp-Source: AGHT+IH6IoyINXEZ0TIOrDraOuXN3B9BBXWyVXtW359TMm6L7e6eGHpW8VA1zNNeUHiMXVZPpT2An3TtuM5uCHNMgEk=
X-Received: by 2002:a17:90a:ea88:b0:280:1dfc:1302 with SMTP id
 h8-20020a17090aea8800b002801dfc1302mr11830833pjz.17.1700584599143; Tue, 21
 Nov 2023 08:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-13-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-13-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 08:36:27 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMM_UYS6mPD4hkfa4VJE4M4CTZh92O9zhL_CW+Tj=oapQ@mail.gmail.com>
Message-ID: <CAF8kJuMM_UYS6mPD4hkfa4VJE4M4CTZh92O9zhL_CW+Tj=oapQ@mail.gmail.com>
Subject: Re: [PATCH 12/24] mm/swap: simplify arguments for swap_cache_get_folio
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
> There are only two caller now, simplify the arguments.

I don't think this patch is needed. It will not have a real impact on
the resulting kernel.

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c      |  2 +-
>  mm/swap.h       |  2 +-
>  mm/swap_state.c | 15 +++++++--------
>  3 files changed, 9 insertions(+), 10 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 0d1ce70bce38..72239061c655 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1875,7 +1875,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         }
>
>         /* Look it up and read it in.. */
> -       folio =3D swap_cache_get_folio(swap, NULL, 0);
> +       folio =3D swap_cache_get_folio(swap, NULL);
>         if (!folio) {
>                 /* Or update major stats only when swapin succeeds?? */
>                 if (fault_type) {
> diff --git a/mm/swap.h b/mm/swap.h
> index ac9136eee690..e43e965f123f 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -47,7 +47,7 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
> -               struct vm_area_struct *vma, unsigned long addr);
> +                                  struct vm_fault *vmf);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>                 pgoff_t index);
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index e96d63bf8a22..91461e26a8cc 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -334,8 +334,7 @@ static inline bool swap_use_vma_readahead(struct swap=
_info_struct *si)
>   *
>   * Caller must lock the swap device or hold a reference to keep it valid=
.
>   */
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -               struct vm_area_struct *vma, unsigned long addr)
> +struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *v=
mf)

I actually prefer the original code. The vm_fault is a much heavier object.
vma and address is really what this function needs minimally. I
consider vma and address,
even though two arguments are simpler than vm_fault struct.

It is possible some other non fault patch wants to lookup the swap_cache,
then construct a vmf just for the vma and address is kind of unnatural.

Chris

>  {
>         struct folio *folio;
>
> @@ -352,22 +351,22 @@ struct folio *swap_cache_get_folio(swp_entry_t entr=
y,
>                         return folio;
>
>                 readahead =3D folio_test_clear_readahead(folio);
> -               if (vma && vma_ra) {
> +               if (vmf && vma_ra) {
>                         unsigned long ra_val;
>                         int win, hits;
>
> -                       ra_val =3D GET_SWAP_RA_VAL(vma);
> +                       ra_val =3D GET_SWAP_RA_VAL(vmf->vma);
>                         win =3D SWAP_RA_WIN(ra_val);
>                         hits =3D SWAP_RA_HITS(ra_val);
>                         if (readahead)
>                                 hits =3D min_t(int, hits + 1, SWAP_RA_HIT=
S_MAX);
> -                       atomic_long_set(&vma->swap_readahead_info,
> -                                       SWAP_RA_VAL(addr, win, hits));
> +                       atomic_long_set(&vmf->vma->swap_readahead_info,
> +                                       SWAP_RA_VAL(vmf->address, win, hi=
ts));
>                 }
>
>                 if (readahead) {
>                         count_vm_event(SWAP_RA_HIT);
> -                       if (!vma || !vma_ra)
> +                       if (!vmf || !vma_ra)
>                                 atomic_inc(&swapin_readahead_hits);
>                 }
>         } else {
> @@ -926,7 +925,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_=
t gfp_mask,
>         struct page *page;
>         pgoff_t ilx;
>
> -       folio =3D swap_cache_get_folio(entry, vmf->vma, vmf->address);
> +       folio =3D swap_cache_get_folio(entry, vmf);
>         if (folio) {
>                 page =3D folio_file_page(folio, swp_offset(entry));
>                 cache_result =3D SWAP_CACHE_HIT;
> --
> 2.42.0
>
>
