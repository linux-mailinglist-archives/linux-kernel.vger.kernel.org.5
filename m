Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6667F268B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 08:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbjKUHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 02:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbjKUHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 02:41:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FB4FC1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:41:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1842C433D9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700552481;
        bh=CkcDYqgQRoD2zoMrak1bNuzvj1Qcym8S5XxjpFCbSWg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LNt7ZCGsnJVbhRdfReUmJH9nfTWH+zr404o5lp6kK2fA9m51t4NfZcsPpRT1WYeKQ
         xfP5dJEsK8slDV13CpyatNGNnxUv8HYP2gARMWj7i06PTER71RqGkOU2QTzWYBUcPy
         CnjONGTSd1oFi6fXGwxFKvqXkJlZA/W2mgtVYR5QwcvCkAlVbY76J8mUE8mFA2BSfq
         2Fp/Hp5Vby1WJR0UbZBRH/XptnQRHJC14s4zwGNNL02uZWqqbEVwXgSTEq3897pWQ/
         WGvhcqiXLxtilzW66GNTvzPiayxfwSPS/c6cGTXMU+kGcY+draGGQSkMVvl2jNyxD+
         Oa53qN0qoYz4Q==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-28039ee1587so3561191a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 23:41:21 -0800 (PST)
X-Gm-Message-State: AOJu0Yxe1tvJmECttVpA21FdfNA4raKAKoRbWHdRdDOiS/IY63E60kUb
        R0Bj6Zi1hYgHYrKZr/YEvlP/loTf6Rk0pZESZV8CmQ==
X-Google-Smtp-Source: AGHT+IG607BAXAWtwI4XGxPpyU0UKUvlanBHdhsBttKjjENgvW00PUrgWjPmXLV4b6YB9xSB6n/mmKkDhUmdKriB97s=
X-Received: by 2002:a17:90b:344a:b0:27d:4ab9:fcd9 with SMTP id
 lj10-20020a17090b344a00b0027d4ab9fcd9mr8271422pjb.21.1700552481234; Mon, 20
 Nov 2023 23:41:21 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-6-ryncsn@gmail.com>
 <CAF8kJuMx5HbSRogY4mVoZ1EELHbmZpOnwv5fRdOE7xvNhjZDbA@mail.gmail.com> <CAMgjq7Bo8=gTe2LTtwVruakvj2RLjMHkqxDC3bY0gwpEPKjzRw@mail.gmail.com>
In-Reply-To: <CAMgjq7Bo8=gTe2LTtwVruakvj2RLjMHkqxDC3bY0gwpEPKjzRw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 23:41:09 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMoiGe3e98Lx0NWmb25vVx0s3SdKqR3yiiG2rQKk0ztNQ@mail.gmail.com>
Message-ID: <CAF8kJuMoiGe3e98Lx0NWmb25vVx0s3SdKqR3yiiG2rQKk0ztNQ@mail.gmail.com>
Subject: Re: [PATCH 05/24] mm/swap: move readahead policy checking into swapin_readahead
To:     Kairui Song <ryncsn@gmail.com>
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

On Mon, Nov 20, 2023 at 10:35=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8821=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:18=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > This makes swapin_readahead a main entry for swapin pages,
> > > prepare for optimizations in later commits.
> > >
> > > This also makes swapoff able to make use of readahead checking
> > > based on entry. Swapping off a 10G ZRAM (lzo-rle) is faster:
> > >
> > > Before:
> > > time swapoff /dev/zram0
> > > real    0m12.337s
> > > user    0m0.001s
> > > sys     0m12.329s
> > >
> > > After:
> > > time swapoff /dev/zram0
> > > real    0m9.728s
> > > user    0m0.001s
> > > sys     0m9.719s
> > >
> > > And what's more, because now swapoff will also make use of no-readahe=
ad
> > > swapin helper, this also fixed a bug for no-readahead case (eg. ZRAM)=
:
> > > when a process that swapped out some memory previously was moved to a=
 new
> > > cgroup, and the original cgroup is dead, swapoff the swap device will
> > > make the swapped in pages accounted into the process doing the swapof=
f
> > > instead of the new cgroup the process was moved to.
> > >
> > > This can be easily reproduced by:
> > > - Setup a ramdisk (eg. ZRAM) swap.
> > > - Create memory cgroup A, B and C.
> > > - Spawn process P1 in cgroup A and make it swap out some pages.
> > > - Move process P1 to memory cgroup B.
> > > - Destroy cgroup A.
> > > - Do a swapoff in cgroup C.
> > > - Swapped in pages is accounted into cgroup C.

In a strange way it makes sense to charge to C.
Swap out =3D=3D free up memory.
Swap in =3D=3D consume memory.
C turn off swap, effectively this behavior will consume a lot of memory.
C gets charged, so if the C is out of memory, it will punish C.
C will not be able to continue swap in memory. The problem gets under contr=
ol.

> > >
> > > This patch will fix it make the swapped in pages accounted in cgroup =
B.

One problem I can see with your fix is that. C is the one doing the
bad deeds, causing consumption of system memory. Punish B is not going
to stop C continuing doing the bad deeds. If you let C run in B's
context limit, things get complicated very quickly.

> > Can you help me understand where the code makes this behavior change?
> > As far as I can tell, the patch just allows swap off to use the code
> > path to avoid read ahead and avoid swap cache path. I haven't figured
> > out where the code makes the swapin charge to B.
>
> Yes, swapoff always call swapin_readahead to swapin pages. Before this
> patch, the page allocate/charge path is like this:
> (Here we assume there ia only a ZRAM device so VMA readahead is used)
> swapoff
>   swapin_readahead
>     swap_vma_readahead
>       __read_swap_cache_async
>         alloc_pages_mpol
>         // *** Page charge happens here, and
>         // note the second argument is NULL
>         mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry)
>
> After the patch:
> swapoff
>   swapin_readahead
>     swapin_no_readahead
>       vma_alloc_folio
>         // *** Page charge happens here, and
>         // note the second argument is vma->mm
>       mem_cgroup_swapin_charge_folio(folio, vma->vm_mm, GFP_KERNEL, entry=
)

I see. Thanks for the detailed explanation. With that information, let
me go over your patch again.

> In the previous callpath (swap_vma_readahead), the mm struct info is
> not passed to the final allocation/charge.
> But now swapin_no_readahead can simply pass the mm struct to the
> allocation/charge.
>
> mem_cgroup_swapin_charge_folio will take the memcg of the mm_struct as
> the charge target when the entry memcg is not online.
>
> > Does it need to be ZRAM? Will zswap or SSD work in your example?
>
> The "swapoff moves memory charge out of a dying cgroup" issue exists

There is a whole class of zombie memcg issues the current memory
cgroup model can't handle well.

> for all swap devices, just this patch changed the behavior for ZRAM
> (which bypass swapcache and uses swapin_no_readahead).

Thanks for the clarification.

Chris

>
> >
> > >
> > > The same bug exists for readahead path too, we'll fix it in later
> > > commits.
> >
> > As discussed in another email, this behavior change is against the
> > current memcg memory charging model.
> > Better separate out this behavior change with code clean up.
>
> Good suggestion.
>
> >
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memory.c     | 22 +++++++---------------
> > >  mm/swap.h       |  6 ++----
> > >  mm/swap_state.c | 33 ++++++++++++++++++++++++++-------
> > >  mm/swapfile.c   |  2 +-
> > >  4 files changed, 36 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index fba4a5229163..f4237a2e3b93 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3792,6 +3792,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >         rmap_t rmap_flags =3D RMAP_NONE;
> > >         bool exclusive =3D false;
> > >         swp_entry_t entry;
> > > +       bool swapcached;
> > >         pte_t pte;
> > >         vm_fault_t ret =3D 0;
> > >
> > > @@ -3855,22 +3856,13 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >         swapcache =3D folio;
> > >
> > >         if (!folio) {
> > > -               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > > -                   __swap_count(entry) =3D=3D 1) {
> > > -                       /* skip swapcache and readahead */
> > > -                       page =3D swapin_no_readahead(entry, GFP_HIGHU=
SER_MOVABLE,
> > > -                                               vmf);
> > > -                       if (page)
> > > -                               folio =3D page_folio(page);
> > > +               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE=
,
> > > +                                       vmf, &swapcached);
> > > +               if (page) {
> > > +                       folio =3D page_folio(page);
> > > +                       if (swapcached)
> > > +                               swapcache =3D folio;
> > >                 } else {
> > > -                       page =3D swapin_readahead(entry, GFP_HIGHUSER=
_MOVABLE,
> > > -                                               vmf);
> > > -                       if (page)
> > > -                               folio =3D page_folio(page);
> > > -                       swapcache =3D folio;
> > > -               }
> > > -
> > > -               if (!folio) {
> > >                         /*
> > >                          * Back out if somebody else faulted in this =
pte
> > >                          * while we released the pte lock.
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index ea4be4791394..f82d43d7b52a 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -55,9 +55,7 @@ struct page *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
> > >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> > >                                     struct mempolicy *mpol, pgoff_t i=
lx);
> > >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > > -                             struct vm_fault *vmf);
> > > -struct page *swapin_no_readahead(swp_entry_t entry, gfp_t flag,
> > > -                                struct vm_fault *vmf);
> > > +                             struct vm_fault *vmf, bool *swapcached)=
;
> > >
> > >  static inline unsigned int folio_swap_flags(struct folio *folio)
> > >  {
> > > @@ -89,7 +87,7 @@ static inline struct page *swap_cluster_readahead(s=
wp_entry_t entry,
> > >  }
> > >
> > >  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t g=
fp_mask,
> > > -                       struct vm_fault *vmf)
> > > +                       struct vm_fault *vmf, bool *swapcached)
> > >  {
> > >         return NULL;
> > >  }
> > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > index 45dd8b7c195d..fd0047ae324e 100644
> > > --- a/mm/swap_state.c
> > > +++ b/mm/swap_state.c
> > > @@ -316,6 +316,11 @@ void free_pages_and_swap_cache(struct encoded_pa=
ge **pages, int nr)
> > >         release_pages(pages, nr);
> > >  }
> > >
> > > +static inline bool swap_use_no_readahead(struct swap_info_struct *si=
, swp_entry_t entry)
> > > +{
> > > +       return data_race(si->flags & SWP_SYNCHRONOUS_IO) && __swap_co=
unt(entry) =3D=3D 1;
> > > +}
> > > +
> > >  static inline bool swap_use_vma_readahead(void)
> > >  {
> > >         return READ_ONCE(enable_vma_readahead) && !atomic_read(&nr_ro=
tate_swap);
> > > @@ -861,8 +866,8 @@ static struct page *swap_vma_readahead(swp_entry_=
t targ_entry, gfp_t gfp_mask,
> > >   * Returns the struct page for entry and addr after the swap entry i=
s read
> > >   * in.
> > >   */
> > > -struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp_mask,
> > > -                                struct vm_fault *vmf)
> > > +static struct page *swapin_no_readahead(swp_entry_t entry, gfp_t gfp=
_mask,
> > > +                                       struct vm_fault *vmf)
> > >  {
> > >         struct vm_area_struct *vma =3D vmf->vma;
> > >         struct page *page =3D NULL;
> > > @@ -904,6 +909,8 @@ struct page *swapin_no_readahead(swp_entry_t entr=
y, gfp_t gfp_mask,
> > >   * @entry: swap entry of this memory
> > >   * @gfp_mask: memory allocation flags
> > >   * @vmf: fault information
> > > + * @swapcached: pointer to a bool used as indicator if the
> > > + *              page is swapped in through swapcache.
> > >   *
> > >   * Returns the struct page for entry and addr, after queueing swapin=
.
> > >   *
> > > @@ -912,17 +919,29 @@ struct page *swapin_no_readahead(swp_entry_t en=
try, gfp_t gfp_mask,
> > >   * or vma-based(ie, virtual address based on faulty address) readahe=
ad.
> > >   */
> > >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> > > -                               struct vm_fault *vmf)
> > > +                             struct vm_fault *vmf, bool *swapcached)
> >
> > At this point the function name "swapin_readahead" does not match what
> > it does any more. Because readahead is just one of the behaviors it
> > does. It also can do without readahead. It needs a better name. This
> > function becomes a generic swapin_entry.
>
> I renamed this function in later commits, I can rename it here to
> avoid confusion.
>
> >
> > >  {
> > >         struct mempolicy *mpol;
> > > -       pgoff_t ilx;
> > >         struct page *page;
> > > +       pgoff_t ilx;
> > > +       bool cached;
> > >
> > >         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> > > -       page =3D swap_use_vma_readahead() ?
> > > -               swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
> > > -               swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
> > > +       if (swap_use_no_readahead(swp_swap_info(entry), entry)) {
> > > +               page =3D swapin_no_readahead(entry, gfp_mask, vmf);
> > > +               cached =3D false;
> > > +       } else if (swap_use_vma_readahead()) {
> > > +               page =3D swap_vma_readahead(entry, gfp_mask, mpol, il=
x, vmf);
> > > +               cached =3D true;
> > > +       } else {
> >
> > Notice that which flavor of swapin_read is actually a property of the
> > swap device.
> > For that device, it always calls the same swapin_entry function.
> >
> > One idea is to have a VFS-like API for swap devices. This can be a
> > swapin_entry function callback from the swap_ops struct. Difference
> > swap devices just register different swapin_entry hooks. That way we
> > don't need to look at the device flags to decide what to do. We can
> > just call the VFS like swap_ops->swapin_entry(), the function pointer
> > will point to the right implementation. Then we don't need these three
> > levels if/else block. It is more flexible to register custom
> > implementations of swap layouts as well. Something to consider for the
> > future, you don't have to implement it in this series.
>
> Interesting idea, we may look into this later.
>
> >
> > > +               page =3D swap_cluster_readahead(entry, gfp_mask, mpol=
, ilx);
> > > +               cached =3D true;
> > > +       }
> > >         mpol_cond_put(mpol);
> > > +
> > > +       if (swapcached)
> > > +               *swapcached =3D cached;
> > > +
> > >         return page;
> > >  }
> > >
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 756104ebd585..0142bfc71b81 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1874,7 +1874,7 @@ static int unuse_pte_range(struct vm_area_struc=
t *vma, pmd_t *pmd,
> > >                         };
> > >
> > >                         page =3D swapin_readahead(entry, GFP_HIGHUSER=
_MOVABLE,
> > > -                                               &vmf);
> > > +                                               &vmf, NULL);
> > >                         if (page)
> > >                                 folio =3D page_folio(page);
> > >                 }
> > > --
> > > 2.42.0
> > >
> > >
>
> Thanks!
>
