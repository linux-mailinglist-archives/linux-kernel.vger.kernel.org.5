Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F98D7F25E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 07:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjKUGov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 01:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjKUGou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 01:44:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3E390
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:44:47 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FE2C433CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 06:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700549086;
        bh=HbjMaa08XhBMvqPbiqjjtUENS42bCNLumGs9hHt3ya4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SIRW9Anh8qnnEi0pqIZrHl/fUoObs5IT4mlXxZdiLYfNT2uiqEN1kcs8ERj/PGm88
         BB6Ek0Jym8SyhnAurieBaxz/TzmI0/Ta9U+Tk452F/BHXkxbLnvQzUzuqBjJkugvK9
         yTnVY9mw/7vHuRngHLiQIIDiOkThnsgFXfRVVt9utyLMCAkesxmS0kAZHIUVgCcYq8
         nio6IKIF63G91T94NSsUJTrOHnTxzR3/v1bSMLhDXKi2oa27vvFKhIDUhdv1rztw/d
         9l4r4U88D62cVR3ZQMCNS80soKnV2l0EJuujsKt3Ul756DIWgeFuoxiyPK+mp/sj88
         k/pzY3Pb+vU2g==
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1cc9b626a96so38325105ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 22:44:46 -0800 (PST)
X-Gm-Message-State: AOJu0YzmkNSpzUXTr/9H8zGjqL9+fY7Ita5J+LUKHJK263GFwWOTAdKO
        D61KYQpHenc772WFL063ZbzfCWMK3hbL4xgDmZQy1w==
X-Google-Smtp-Source: AGHT+IGHAYyJkX0fTvu8sfcaQjbc+N0MzAsCY8/vIH+MOfw0Dl3I8GwbvhRqLx7yrhUEwJyac2G55exzEd/s8SN2iQQ=
X-Received: by 2002:a17:90b:4c8c:b0:280:74fc:ac2c with SMTP id
 my12-20020a17090b4c8c00b0028074fcac2cmr8436665pjb.13.1700549085867; Mon, 20
 Nov 2023 22:44:45 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-7-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-7-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 22:44:34 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO_ztE=M3EF-7pSkUL73tL8kfi2KqQPsYVC2VE-J_nu6Q@mail.gmail.com>
Message-ID: <CAF8kJuO_ztE=M3EF-7pSkUL73tL8kfi2KqQPsYVC2VE-J_nu6Q@mail.gmail.com>
Subject: Re: [PATCH 06/24] swap: rework swapin_no_readahead arguments
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
> Make it use alloc_pages_mpol instead of vma_alloc_folio, and accept
> mm_struct directly as an argument instead of taking a vmf as argument.
> Make its arguments similar to swap_{cluster,vma}_readahead, to
> make the code more aligned.

It is unclear to me what is the value of making the
swap_{cluster,vma}_readahead more aligned here.

> Also prepare for following commits which will skip vmf for certain
> swapin paths.

The following patch 07/24 does not seem to use this patch.
Can it merge with the other patch that uses it?

As it is, this patch does not serve a stand alone value to justify it.

Chris

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index fd0047ae324e..ff6756f2e8e4 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -867,17 +867,17 @@ static struct page *swap_vma_readahead(swp_entry_t =
targ_entry, gfp_t gfp_mask,
>   * in.
>   */
>  static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mas=
k,
> -                                       struct vm_fault *vmf)
> +                                       struct mempolicy *mpol, pgoff_t i=
lx,
> +                                       struct mm_struct *mm)
>  {
> -       struct vm_area_struct *vma =3D vmf->vma;
> -       struct page *page =3D NULL;
>         struct folio *folio;
> +       struct page *page;
>         void *shadow =3D NULL;
>
> -       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
> -                               vma, vmf->address, false);
> +       page =3D alloc_pages_mpol(gfp_mask, 0, mpol, ilx, numa_node_id())=
;
> +       folio =3D (struct folio *)page;
>         if (folio) {
> -               if (mem_cgroup_swapin_charge_folio(folio, vma->vm_mm,
> +               if (mem_cgroup_swapin_charge_folio(folio, mm,
>                                                    GFP_KERNEL, entry)) {
>                         folio_put(folio);
>                         return NULL;
> @@ -896,7 +896,6 @@ static struct page *swapin_no_readahead(swp_entry_t e=
ntry, gfp_t gfp_mask,
>
>                 /* To provide entry to swap_readpage() */
>                 folio->swap =3D entry;
> -               page =3D &folio->page;
>                 swap_readpage(page, true, NULL);
>                 folio->private =3D NULL;
>         }
> @@ -928,7 +927,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_=
t gfp_mask,
>
>         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>         if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> -               page =3D swapin_no_readahead(entry, gfp_mask, vmf);
> +               page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
>                 cached =3D false;
>         } else if (swap_use_vma_readahead()) {
>                 page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
> --
> 2.42.0
>
>
