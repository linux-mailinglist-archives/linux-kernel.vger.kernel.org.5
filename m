Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84FA57F344F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231216AbjKUQza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKUQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:55:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A176F122
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:55:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48580C433CD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 16:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700585725;
        bh=BPPgPgKcY3SOUFT/m046HQ005it97DrTli/SOEvkQKo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AyIB+p/uoUU3ZISYJX0QPlyP5YrCnqpIB2Ni+TmVHiJnNMoFecb8fEDnx00wDxxcs
         gH4aZ5fPsL0dNwBA7KWvXA1YCJ2CmvqOrdt54SAoQionaPJtk3z3U86dWmI4Paxr5u
         wLJrYqkxSqxp9lOJWQMr3FD5opwDt9KxzCYzrMZaWQqZhBRasOyaU8KgwHxGlKve4P
         BgIv9FsvqVF142cEVZfsx9hjbVo+4pBX7Wn88C2+/4QCmb7Enk8jex7twibpzRo3wZ
         cWq4TcSutJz51JXnHsE8joAeGIjWyD7hkDbE8JSZjTwIDv3mR2gdso2//0onCGdxyx
         I8keks/lHrRuw==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5be30d543c4so3871458a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:55:25 -0800 (PST)
X-Gm-Message-State: AOJu0YwV4E5Fb5JHlVe+Jkye3vQ3Phn8rGvuLzbfThMSb+0h5Ec9H/YZ
        pgPYCZrnQ4HpUfVH1oY9mWf22oNFUXHTLyjxQ2FyXQ==
X-Google-Smtp-Source: AGHT+IGoSNcrUquRFAr5cOwbm7HO1VPZS01Auc5YCOQnAEpE2mJ8dQoJTyd0GmXa0yLkD6c93EChhkWvJTyOvG2JclI=
X-Received: by 2002:a17:90b:4aca:b0:27d:b9d:bd6f with SMTP id
 mh10-20020a17090b4aca00b0027d0b9dbd6fmr10142174pjb.45.1700585724698; Tue, 21
 Nov 2023 08:55:24 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-15-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-15-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 08:55:13 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP5Bnz1PncU265+YnaSQG1CmdxqvuvzZK5Xuu6Pd==peg@mail.gmail.com>
Message-ID: <CAF8kJuP5Bnz1PncU265+YnaSQG1CmdxqvuvzZK5Xuu6Pd==peg@mail.gmail.com>
Subject: Re: [PATCH 14/24] mm/swap: do shadow lookup as well when doing swap
 cache lookup
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

Hi Kairui,

Too trivial to stand alone as a patch. Merge it with the patch needed
to use that "*shadow".

Chris

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Make swap_cache_get_folio capable of returning the shadow value when the
> xarray contains a shadow instead of a valid folio. Just extend the
> arguments to be used later.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/shmem.c      |  2 +-
>  mm/swap.h       |  2 +-
>  mm/swap_state.c | 11 +++++++----
>  3 files changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 72239061c655..f9ce4067c742 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1875,7 +1875,7 @@ static int shmem_swapin_folio(struct inode *inode, =
pgoff_t index,
>         }
>
>         /* Look it up and read it in.. */
> -       folio =3D swap_cache_get_folio(swap, NULL);
> +       folio =3D swap_cache_get_folio(swap, NULL, NULL);
>         if (!folio) {
>                 /* Or update major stats only when swapin succeeds?? */
>                 if (fault_type) {
> diff --git a/mm/swap.h b/mm/swap.h
> index e43e965f123f..da9deb5ba37d 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -47,7 +47,7 @@ void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
>  struct folio *swap_cache_get_folio(swp_entry_t entry,
> -                                  struct vm_fault *vmf);
> +                                  struct vm_fault *vmf, void **shadowp);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>                 pgoff_t index);
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 3b5a34f47192..e057c79fb06f 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -334,14 +334,17 @@ static inline bool swap_use_vma_readahead(struct sw=
ap_info_struct *si)
>   *
>   * Caller must lock the swap device or hold a reference to keep it valid=
.
>   */
> -struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *v=
mf)
> +struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *v=
mf, void **shadowp)
>  {
>         bool vma_ra, readahead;
>         struct folio *folio;
>
> -       folio =3D filemap_get_folio(swap_address_space(entry), swp_offset=
(entry));
> -       if (IS_ERR(folio))
> +       folio =3D filemap_get_entry(swap_address_space(entry), swp_offset=
(entry));
> +       if (xa_is_value(folio)) {
> +               if (shadowp)
> +                       *shadowp =3D folio;
>                 return NULL;
> +       }
>
>         /*
>          * At the moment, we don't support PG_readahead for anon THP
> @@ -923,7 +926,7 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_=
t gfp_mask,
>         struct page *page;
>         pgoff_t ilx;
>
> -       folio =3D swap_cache_get_folio(entry, vmf);
> +       folio =3D swap_cache_get_folio(entry, vmf, NULL);
>         if (folio) {
>                 page =3D folio_file_page(folio, swp_offset(entry));
>                 cache_result =3D SWAP_CACHE_HIT;
> --
> 2.42.0
>
>
