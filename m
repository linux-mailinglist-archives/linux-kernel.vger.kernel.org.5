Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D057F2547
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233374AbjKUFfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:35:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKUFfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:35:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF3C9E3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:35:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720D7C433C7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 05:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700544907;
        bh=Nop3Gevi48alowZBkJN+6yoWTajd7eKpQWuqRWMSkAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mGBfnrILdesKDAmZ2ERr9Ih3O7LOLxuq/SBTM0asbWVb/6ZsRaLG2JMiP1OH4FGn8
         /uAfXRnEipfHP2a78SMd45hNNWkbqWxcukvfvpFJvk41boeg6CIHicc39GjrTEm5FU
         SS4bjt9i02DtS/TnGG/CzO8k6YpSpszTOLxtRqLOapfMTI9IEP/x6GKVszIdZfyHTh
         BJ2LLbzDe1Acsd6cpkxgAQwSAr9Pto9dMN6Ky/I+6E08eFdcWDtumB6vc4gkKRTJ9K
         4iD4AapGRI7nNxHjAlLmOIj175z9icj87+44OFl193g/9oS+KHrGBsefYr5kUVjuG+
         w6KpxxQTMOODw==
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so4165963b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 21:35:07 -0800 (PST)
X-Gm-Message-State: AOJu0Yya0IjEVYOXGvxKR5BOviUmU5FYiQaRBevYGO0eKpVQd48KIdak
        dZmrTkxjvBNEBeXmzCPD2CMIVykznPxncSisDbOZqQ==
X-Google-Smtp-Source: AGHT+IE2T2dovn9JUJ3ms4TzULFEUnHYChzOP1n0L3VVBqeakkJs/5DeMQGnKuXLLqUKs1HgBmdKiAnIwauxVguIkTA=
X-Received: by 2002:a05:6a20:861d:b0:187:152d:c1e2 with SMTP id
 l29-20020a056a20861d00b00187152dc1e2mr5468910pze.46.1700544906866; Mon, 20
 Nov 2023 21:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-4-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-4-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 21:34:55 -0800
X-Gmail-Original-Message-ID: <CAF8kJuP3OyJ3e2ttiDrqJ4Ucs8BbysaDtuUY3STaJUC8oVkZkQ@mail.gmail.com>
Message-ID: <CAF8kJuP3OyJ3e2ttiDrqJ4Ucs8BbysaDtuUY3STaJUC8oVkZkQ@mail.gmail.com>
Subject: Re: [PATCH 03/24] mm/swap: move no readahead swapin code to a stand
 alone helper
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
> No feature change, simply move the routine to a standalone function to
> be used later. The error path handling is copied from the "out_page"
> label, to make the code change minimized for easier reviewing.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/memory.c     | 33 +++++----------------------------
>  mm/swap.h       |  2 ++
>  mm/swap_state.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+), 28 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 70ffa867b1be..fba4a5229163 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3794,7 +3794,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         swp_entry_t entry;
>         pte_t pte;
>         vm_fault_t ret =3D 0;
> -       void *shadow =3D NULL;
>
>         if (!pte_unmap_same(vmf))
>                 goto out;
> @@ -3858,33 +3857,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         if (!folio) {
>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>                     __swap_count(entry) =3D=3D 1) {
> -                       /* skip swapcache */
> -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0=
,
> -                                               vma, vmf->address, false)=
;
> -                       if (folio) {
> -                               __folio_set_locked(folio);
> -                               __folio_set_swapbacked(folio);
> -
> -                               if (mem_cgroup_swapin_charge_folio(folio,
> -                                                       vma->vm_mm, GFP_K=
ERNEL,
> -                                                       entry)) {
> -                                       ret =3D VM_FAULT_OOM;
> -                                       goto out_page;
> -                               }
> -                               mem_cgroup_swapin_uncharge_swap(entry);
> -
> -                               shadow =3D get_shadow_from_swap_cache(ent=
ry);
> -                               if (shadow)
> -                                       workingset_refault(folio, shadow)=
;
> -
> -                               folio_add_lru(folio);
> -                               page =3D &folio->page;
> -
> -                               /* To provide entry to swap_readpage() */
> -                               folio->swap =3D entry;
> -                               swap_readpage(page, true, NULL);
> -                               folio->private =3D NULL;
> -                       }
> +                       /* skip swapcache and readahead */
> +                       page =3D swapin_no_readahead(entry, GFP_HIGHUSER_=
MOVABLE,
> +                                               vmf);

A minor point,  swapin_no_readahead() is expressed in negative words.

Better use positive words to express what the function does rather
than what the function does not do.
I am terrible at naming functions myself. I can think of something
along the lines of:
swapin_direct (no cache).
swapin_minimal?
swapin_entry_only?

Please suggest better names for basic, bare minimum.

Chris
