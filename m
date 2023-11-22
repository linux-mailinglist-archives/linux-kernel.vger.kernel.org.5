Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 432CC7F3D33
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKVFPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjKVFPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:15:38 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F07185
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:15:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BF2C43391
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700630133;
        bh=8yQOtqhJDbJqJorbHOFHuOJO2GdlJMbA2UvGLCtMCfw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N8GUQTDJrBHnViR8kmwBc7GLdhYNNTLs6n0VJZrrLD2stFjGfiq16elnPlxnbQ1Is
         utHT21XjjdPT02HRZ1MRhJDnX+JE2TMOqCe54xcH86gjqfVGmATK97Dlne489i05ur
         QlImiXkNMESgHn54FB7OIYt7TH2trSdPbj1nr7fOS/PxInjzZyZqV6yeUOP6SYS6Y+
         Ypb1SlQtLJBg4TSmRhaz0LC7gkKtPiuyDSfCRu3NJwVCVu8QonhIP7WQ/w7ZfaZ8eo
         H+woImxXZcMU9SaLo3PzrR+10LC6P1JrPvGW0kojsPr9X38lh8bDmzwFHD8jfZNJzo
         oHU6dF5uxiThQ==
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5be24d41bb8so369009a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:15:33 -0800 (PST)
X-Gm-Message-State: AOJu0YzojkKiphqTvPxLcZmSIIeQ+xPY/2dinAAZBCvYETWfoWqCmROo
        Fbr1FUza0ZbbKJcO2YlY/Wv64oDebYf55CfVTBzz2w==
X-Google-Smtp-Source: AGHT+IEa0OQTgkVX+7OZdO/Lyluv4nYZ1dytNefxGRLhdNMg7CjH0/ntePhtiyQ5RlEPm7/jzJ8DB+qPQAkITVmO0dg=
X-Received: by 2002:a17:90b:1bca:b0:27d:8a04:f964 with SMTP id
 oa10-20020a17090b1bca00b0027d8a04f964mr2097699pjb.24.1700630133034; Tue, 21
 Nov 2023 21:15:33 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-22-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-22-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 21:15:22 -0800
X-Gmail-Original-Message-ID: <CAF8kJuN5GELAdh5ZJHthtgJCaYkgQ38BmzLZerUp6fS+pVU=WQ@mail.gmail.com>
Message-ID: <CAF8kJuN5GELAdh5ZJHthtgJCaYkgQ38BmzLZerUp6fS+pVU=WQ@mail.gmail.com>
Subject: Re: [PATCH 21/24] swap: make swapin_readahead result checking
 argument mandatory
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
> This is only one caller now in page fault path, make the result return
> argument mandatory.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 6f39aa8394f1..0433a2586c6d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -913,7 +913,6 @@ static struct page *swapin_no_readahead(swp_entry_t e=
ntry, gfp_t gfp_mask,
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
>                               struct vm_fault *vmf, enum swap_cache_resul=
t *result)
>  {
> -       enum swap_cache_result cache_result;
>         struct swap_info_struct *si;
>         struct mempolicy *mpol;
>         void *shadow =3D NULL;
> @@ -928,29 +927,27 @@ struct page *swapin_readahead(swp_entry_t entry, gf=
p_t gfp_mask,
>
>         folio =3D swap_cache_get_folio(entry, vmf, &shadow);
>         if (folio) {
> +               *result =3D SWAP_CACHE_HIT;
>                 page =3D folio_file_page(folio, swp_offset(entry));
> -               cache_result =3D SWAP_CACHE_HIT;
>                 goto done;
>         }
>
>         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
>         if (swap_use_no_readahead(si, swp_offset(entry))) {
> +               *result =3D SWAP_CACHE_BYPASS;

Each of this "*result" will compile into memory store instructions.
The compiler most likely can't optimize and combine them together
because the store can cause segfault from the compiler's point of
view. The multiple local variable assignment can be compiled into a
few registers assignment so it does not cost as much as multiple
memory stores.

>                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
> -               cache_result =3D SWAP_CACHE_BYPASS;
>                 if (shadow)
>                         workingset_refault(page_folio(page), shadow);
> -       } else if (swap_use_vma_readahead(si)) {
> -               page =3D swap_vma_readahead(entry, gfp_mask, mpol, ilx, v=
mf);
> -               cache_result =3D SWAP_CACHE_MISS;
>         } else {
> -               page =3D swap_cluster_readahead(entry, gfp_mask, mpol, il=
x);
> -               cache_result =3D SWAP_CACHE_MISS;
> +               *result =3D SWAP_CACHE_MISS;
> +               if (swap_use_vma_readahead(si))
> +                       page =3D swap_vma_readahead(entry, gfp_mask, mpol=
, ilx, vmf);
> +               else
> +                       page =3D swap_cluster_readahead(entry, gfp_mask, =
mpol, ilx);

I recall you introduce or heavy modify this function in previous patch befo=
re.
Consider combine some of the patch and present the final version sooner.
From the reviewing point of view, don't need to review so many
internal version which get over written any way.

>         }
>         mpol_cond_put(mpol);
>  done:
>         put_swap_device(si);
> -       if (result)
> -               *result =3D cache_result;

The original version with check and assign it at one place is better.
Safer and produce better code.

Chris
