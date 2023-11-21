Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037597F26E4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjKUICc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 03:02:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjKUICa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 03:02:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4114C3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:02:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D1FC43391
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700553746;
        bh=Aphf+mDirAunLvOeekhNKcmKUP/49vVxIizS90M1uzs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Fmz3BH2Dx2URmDTm44twbm+qhDWnu1JktNcKnTMAQxSO0BRNXJgKQPoq+4JHFROTA
         o+UiMWZKIyNapr8WpIR2GttO9r2JrPqBhV52DuKIufi44ktpW14DlxoesUtOp/u5F9
         kxUtAcfsvqGLNZp8+NSECKiWFsdeRZRYEUoYh8xS4J6Vy2SMD6PSFzZGjxa+tN3olD
         7JDj/OtM1lWLvZnT4Utd1o7L0/y9UkyKPygCju4Bgsivbrc5BOW9xySy9+XfzHmVWZ
         RRgfB/j0L7IKp0tQnJimDltsUTycJ3/9bBtELZHIZm16rafZLbJkPWYsiTqICHMKED
         jfLOvWkPraBTQ==
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6cbb71c3020so764415b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 00:02:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyvdPirck2FowqCFkTrpB/PITAkcFqrCsx9Q/CcurVUeXUozxSv
        iwinEmAIygnE8Eb8NKN3bOOCH7dgTW5qugaXZMPDZQ==
X-Google-Smtp-Source: AGHT+IE6S7yndqjFyS51Kwja50fGAsdQyD8/0l6/IDiUeB8LhOjnae6kUqLxTWCK+Ur9OQkGskCEayDL/drdzaEi3QU=
X-Received: by 2002:a17:90b:783:b0:280:29df:747e with SMTP id
 l3-20020a17090b078300b0028029df747emr2785910pjz.1.1700553745798; Tue, 21 Nov
 2023 00:02:25 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-10-ryncsn@gmail.com>
 <87il5wc1nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87il5wc1nr.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 00:02:14 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOwPMJSsR2+q53gQTjWT9b0XS+AMZGJMOq1veut1OogWA@mail.gmail.com>
Message-ID: <CAF8kJuOwPMJSsR2+q53gQTjWT9b0XS+AMZGJMOq1veut1OogWA@mail.gmail.com>
Subject: Re: [PATCH 09/24] mm/swap: inline __swap_count
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
        Kairui Song <kasong@tencent.com>,
        Andrew Morton <akpm@linux-foundation.org>,
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

On Sun, Nov 19, 2023 at 11:43=E2=80=AFPM Huang, Ying <ying.huang@intel.com>=
 wrote:
>
> Kairui Song <ryncsn@gmail.com> writes:
>
> > From: Kairui Song <kasong@tencent.com>
> >
> > There is only one caller in swap subsystem now, where it can be inline
> > smoothly, avoid the memory access and function call overheads.
> >
> > Signed-off-by: Kairui Song <kasong@tencent.com>
> > ---
> >  include/linux/swap.h | 6 ------
> >  mm/swap_state.c      | 6 +++---
> >  mm/swapfile.c        | 8 --------
> >  3 files changed, 3 insertions(+), 17 deletions(-)
> >
> > diff --git a/include/linux/swap.h b/include/linux/swap.h
> > index 2401990d954d..64a37819a9b3 100644
> > --- a/include/linux/swap.h
> > +++ b/include/linux/swap.h
> > @@ -485,7 +485,6 @@ int swap_type_of(dev_t device, sector_t offset);
> >  int find_first_swap(dev_t *device);
> >  extern unsigned int count_swap_pages(int, int);
> >  extern sector_t swapdev_block(int, pgoff_t);
> > -extern int __swap_count(swp_entry_t entry);
> >  extern int swap_swapcount(struct swap_info_struct *si, swp_entry_t ent=
ry);
> >  extern int swp_swapcount(swp_entry_t entry);
> >  extern struct swap_info_struct *page_swap_info(struct page *);
> > @@ -559,11 +558,6 @@ static inline void put_swap_folio(struct folio *fo=
lio, swp_entry_t swp)
> >  {
> >  }
> >
> > -static inline int __swap_count(swp_entry_t entry)
> > -{
> > -     return 0;
> > -}
> > -
> >  static inline int swap_swapcount(struct swap_info_struct *si, swp_entr=
y_t entry)
> >  {
> >       return 0;
> > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > index fb78f7f18ed7..d87c20f9f7ec 100644
> > --- a/mm/swap_state.c
> > +++ b/mm/swap_state.c
> > @@ -316,9 +316,9 @@ void free_pages_and_swap_cache(struct encoded_page =
**pages, int nr)
> >       release_pages(pages, nr);
> >  }
> >
> > -static inline bool swap_use_no_readahead(struct swap_info_struct *si, =
swp_entry_t entry)
> > +static inline bool swap_use_no_readahead(struct swap_info_struct *si, =
pgoff_t offset)
> >  {
> > -     return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_count(=
entry) =3D=3D 1;
> > +     return data_race(si->flags & SWP_SYNCHRONOUS_IO) && swap_count(si=
->swap_map[offset]) =3D=3D 1;
> >  }
> >
> >  static inline bool swap_use_vma_readahead(struct swap_info_struct *si)
> > @@ -928,7 +928,7 @@ struct page *swapin_readahead(swp_entry_t entry, gf=
p_t gfp_mask,
> >
> >       si =3D swp_swap_info(entry);
> >       mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> > -     if (swap_use_no_readahead(si, entry)) {
> > +     if (swap_use_no_readahead(si, swp_offset(entry))) {
> >               page =3D swapin_no_readahead(entry, gfp_mask, mpol, ilx, =
vmf->vma->vm_mm);
> >               cached =3D false;
> >       } else if (swap_use_vma_readahead(si)) {
> > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > index a8ae472ed2b6..e15a6c464a38 100644
> > --- a/mm/swapfile.c
> > +++ b/mm/swapfile.c
> > @@ -1431,14 +1431,6 @@ void swapcache_free_entries(swp_entry_t *entries=
, int n)
> >               spin_unlock(&p->lock);
> >  }
> >
> > -int __swap_count(swp_entry_t entry)
> > -{
> > -     struct swap_info_struct *si =3D swp_swap_info(entry);
> > -     pgoff_t offset =3D swp_offset(entry);
> > -
> > -     return swap_count(si->swap_map[offset]);
> > -}
> > -
>
> I'd rather keep __swap_count() in the original place together with other
> swap count related functions.  And si->swap_map[] was hided in
> swapfile.c before.  I don't think the change will have any real
> performance improvement.

I agree with Ying here. Does not seem to have value high enough to
justify a patch by itself.

Chris
