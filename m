Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF707F6F2B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 10:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233055AbjKXJKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 04:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbjKXJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 04:10:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CDE10F9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:10:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC4DC433CD
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700817019;
        bh=6ZkRiniu8/O5HHUlahhrxMHGkSqH9Z2eWrnLAXchLsY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZBrc0AIVIG0PxCXQCzgC6RUAJZ7KgCGi4q6OiVoq4wBW4w8sddc/wKgd4sLSScCJQ
         cSsaW/SE9h2Z2HVS8ixMfqXSQsZGCxN0jCrMJNhNCMD5jXRqN2BZsS5MUjejjV+zqX
         ZtB0GV8R/dAqxE2Mfn0W7VRRFx57ZDZR4s94tHOkE2SR5/bBdZOpPFsAZ4Evuf2ruz
         DQnT441T4eEjXesTjgkJZrAh8T9sRr/QPyjYs9RJ69XVX8SAWQZr3CG3rHSlHenof/
         xWZrTWI4daAepXJ7eIYjNkAo+lybxSmjPNPJTJ4XRbkfRH1V07ZcZocdjsxvFWtuqv
         HxKccZd0DLkbg==
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6c33ab26dddso1377959b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 01:10:18 -0800 (PST)
X-Gm-Message-State: AOJu0YyVMrr2sTmfYvmGB0gu/HiTyMEEamBLjc5x9gtJUvX0fYWLEjBn
        ROeDdAx9cuDPFuJcASG1wfkeG7lWeI0b0zzy/0naUg==
X-Google-Smtp-Source: AGHT+IFVXZCjmkD6a/qm586SxR1LV99Nsj/ztc3ipvhU6Ikz1YBLYi/XEO07xoof6uQrJbuwqoWSw+zYKu7OmCRTnw8=
X-Received: by 2002:a05:6a20:6728:b0:18b:8b4:2dde with SMTP id
 q40-20020a056a20672800b0018b08b42ddemr2158097pzh.61.1700817018259; Fri, 24
 Nov 2023 01:10:18 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-12-ryncsn@gmail.com>
 <CAF8kJuN+4HswStj4wSZHGQdx9g2tqzCtMA+6CLO7+HmozL6t2Q@mail.gmail.com> <CAMgjq7DpBOYec5FLvByZY8-xMwdWH2HRA9hFvNT3PDyxfaqBYw@mail.gmail.com>
In-Reply-To: <CAMgjq7DpBOYec5FLvByZY8-xMwdWH2HRA9hFvNT3PDyxfaqBYw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 24 Nov 2023 01:10:07 -0800
X-Gmail-Original-Message-ID: <CAF8kJuO6Jy3HBWUekKnZPXmhvUebY3jQWA4RFVOsWJDVEcQx6w@mail.gmail.com>
Message-ID: <CAF8kJuO6Jy3HBWUekKnZPXmhvUebY3jQWA4RFVOsWJDVEcQx6w@mail.gmail.com>
Subject: Re: [PATCH 11/24] mm/swap: also handle swapcache lookup in swapin_readahead
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
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:42=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> Chris Li <chrisl@kernel.org> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=97=A5=
=E5=91=A8=E4=B8=89 00:07=E5=86=99=E9=81=93=EF=BC=9A
>
>
> >
> > On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com>=
 wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > No feature change, just prepare for later commits.
> >
> > You need to have a proper commit message why this change needs to happe=
n.
> > Preparing is too generic, it does not give any real information.
> > For example, it seems you want to reduce one swap cache lookup because
> > swap_readahead already has it?
> >
> > I am a bit puzzled at this patch. It shuffles a lot of sensitive code.
> > However I do not get  the value.
> > It seems like this patch should be merged with the later patch that
> > depends on it to be judged together.
> >
> > >
> > > Signed-off-by: Kairui Song <kasong@tencent.com>
> > > ---
> > >  mm/memory.c     | 61 +++++++++++++++++++++++------------------------=
--
> > >  mm/swap.h       | 10 ++++++--
> > >  mm/swap_state.c | 26 +++++++++++++--------
> > >  mm/swapfile.c   | 30 +++++++++++-------------
> > >  4 files changed, 66 insertions(+), 61 deletions(-)
> > >
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index f4237a2e3b93..22af9f3e8c75 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -3786,13 +3786,13 @@ static vm_fault_t handle_pte_marker(struct vm=
_fault *vmf)
> > >  vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >  {
> > >         struct vm_area_struct *vma =3D vmf->vma;
> > > -       struct folio *swapcache, *folio =3D NULL;
> > > +       struct folio *swapcache =3D NULL, *folio =3D NULL;
> > > +       enum swap_cache_result cache_result;
> > >         struct page *page;
> > >         struct swap_info_struct *si =3D NULL;
> > >         rmap_t rmap_flags =3D RMAP_NONE;
> > >         bool exclusive =3D false;
> > >         swp_entry_t entry;
> > > -       bool swapcached;
> > >         pte_t pte;
> > >         vm_fault_t ret =3D 0;
> > >
> > > @@ -3850,42 +3850,37 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> > >         if (unlikely(!si))
> > >                 goto out;
> > >
> > > -       folio =3D swap_cache_get_folio(entry, vma, vmf->address);
> > > -       if (folio)
> > > -               page =3D folio_file_page(folio, swp_offset(entry));
> > > -       swapcache =3D folio;
> >
> > Is the motivation that swap_readahead() already has a swap cache look u=
p so you
> > remove this look up here?
>
> Yes, the cache look up can is moved and shared in swapin_readahead,
> and this also make it possible to use that look up to return a shadow
> when entry is not a page, so another shadow look up can be saved for
> sync (ZRAM) swapin path. This can help improve ZRAM performance for
> ~4% for a 10G ZRAM, and should improves more when the cache tree grows
> large.
>
> >
> > > -
> > > -       if (!folio) {
> > > -               page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE=
,
> > > -                                       vmf, &swapcached);
> > > -               if (page) {
> > > -                       folio =3D page_folio(page);
> > > -                       if (swapcached)
> > > -                               swapcache =3D folio;
> > > -               } else {
> > > +       page =3D swapin_readahead(entry, GFP_HIGHUSER_MOVABLE,
> > > +                               vmf, &cache_result);
> > > +       if (page) {
> > > +               folio =3D page_folio(page);
> > > +               if (cache_result !=3D SWAP_CACHE_HIT) {
> > > +                       /* Had to read the page from swap area: Major=
 fault */
> > > +                       ret =3D VM_FAULT_MAJOR;
> > > +                       count_vm_event(PGMAJFAULT);
> > > +                       count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > > +               }
> > > +               if (cache_result !=3D SWAP_CACHE_BYPASS)
> > > +                       swapcache =3D folio;
> > > +               if (PageHWPoison(page)) {
> >
> > There is a lot of code shuffle here. From the diff it is hard to tell
> > if they are doing the same thing as before.
> >
> > >                         /*
> > > -                        * Back out if somebody else faulted in this =
pte
> > > -                        * while we released the pte lock.
> > > +                        * hwpoisoned dirty swapcache pages are kept =
for killing
> > > +                        * owner processes (which may be unknown at h=
wpoison time)
> > >                          */
> > > -                       vmf->pte =3D pte_offset_map_lock(vma->vm_mm, =
vmf->pmd,
> > > -                                       vmf->address, &vmf->ptl);
> > > -                       if (likely(vmf->pte &&
> > > -                                  pte_same(ptep_get(vmf->pte), vmf->=
orig_pte)))
> > > -                               ret =3D VM_FAULT_OOM;
> > > -                       goto unlock;
> > > +                       ret =3D VM_FAULT_HWPOISON;
> > > +                       goto out_release;
> > >                 }
> > > -
> > > -               /* Had to read the page from swap area: Major fault *=
/
> > > -               ret =3D VM_FAULT_MAJOR;
> > > -               count_vm_event(PGMAJFAULT);
> > > -               count_memcg_event_mm(vma->vm_mm, PGMAJFAULT);
> > > -       } else if (PageHWPoison(page)) {
> > > +       } else {
> > >                 /*
> > > -                * hwpoisoned dirty swapcache pages are kept for kill=
ing
> > > -                * owner processes (which may be unknown at hwpoison =
time)
> > > +                * Back out if somebody else faulted in this pte
> > > +                * while we released the pte lock.
> > >                  */
> > > -               ret =3D VM_FAULT_HWPOISON;
> > > -               goto out_release;
> > > +               vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd=
,
> > > +                               vmf->address, &vmf->ptl);
> > > +               if (likely(vmf->pte &&
> > > +                          pte_same(ptep_get(vmf->pte), vmf->orig_pte=
)))
> > > +                       ret =3D VM_FAULT_OOM;
> > > +               goto unlock;
> > >         }
> > >
> > >         ret |=3D folio_lock_or_retry(folio, vmf);
> > > diff --git a/mm/swap.h b/mm/swap.h
> > > index a9a654af791e..ac9136eee690 100644
> > > --- a/mm/swap.h
> > > +++ b/mm/swap.h
> > > @@ -30,6 +30,12 @@ extern struct address_space *swapper_spaces[];
> > >         (&swapper_spaces[swp_type(entry)][swp_offset(entry) \
> > >                 >> SWAP_ADDRESS_SPACE_SHIFT])
> > >
> > > +enum swap_cache_result {
> > > +       SWAP_CACHE_HIT,
> > > +       SWAP_CACHE_MISS,
> > > +       SWAP_CACHE_BYPASS,
> > > +};
> >
> > Does any function later care about CACHE_BYPASS?
> >
> > Again, better introduce it with the function that uses it. Don't
> > introduce it for "just in case I might use it later".
>
> Yes,  callers in shmem will also need to know if the page is cached in
> swap, and need a value to indicate the bypass case. I can add some
> comments here to indicate the usage.

I also comment on the later patch. Because you do the look up without
the folio locked. The swap_cache can change by the time you use the
"*result". I suspect some of the swap_cache look up you need to add it
back due to the race before locking. This better introduces this field
with the user side together. Make it easier to reason the usage in one
patch.

BTW, one way to flatten the development history of the patch is to
flatten the branch as one big patch. Then copy/paste from the big
patch to introduce a sub patch step by step. That way the sub patch is
closer to the latest version of the code. Just something for you to
consider.

>
> >
> > > +
> > >  void show_swap_cache_info(void);
> > >  bool add_to_swap(struct folio *folio);
> > >  void *get_shadow_from_swap_cache(swp_entry_t entry);
> > > @@ -55,7 +61,7 @@ struct page *__read_swap_cache_async(swp_entry_t en=
try, gfp_t gfp_mask,
> > >  struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> > >                                     struct mempolicy *mpol, pgoff_t i=
lx);
> > >  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
> > > -                             struct vm_fault *vmf, bool *swapcached)=
;
> > > +                             struct vm_fault *vmf, enum swap_cache_r=
esult *result);
> > >
> > >  static inline unsigned int folio_swap_flags(struct folio *folio)
> > >  {
> > > @@ -92,7 +98,7 @@ static inline struct page *swap_cluster_readahead(s=
wp_entry_t entry,
> > >  }
> > >
> > >  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t g=
fp_mask,
> > > -                       struct vm_fault *vmf, bool *swapcached)
> > > +                       struct vm_fault *vmf, enum swap_cache_result =
*result)
> > >  {
> > >         return NULL;
> > >  }
> > > diff --git a/mm/swap_state.c b/mm/swap_state.c
> > > index d87c20f9f7ec..e96d63bf8a22 100644
> > > --- a/mm/swap_state.c
> > > +++ b/mm/swap_state.c
> > > @@ -908,8 +908,7 @@ static struct page *swapin_no_readahead(swp_entry=
_t entry, gfp_t gfp_mask,
> > >   * @entry: swap entry of this memory
> > >   * @gfp_mask: memory allocation flags
> > >   * @vmf: fault information
> > > - * @swapcached: pointer to a bool used as indicator if the
> > > - *              page is swapped in through swapcache.
> > > + * @result: a return value to indicate swap cache usage.
> > >   *
> > >   * Returns the struct page for entry and addr, after queueing swapin=
.
> > >   *
> > > @@ -918,30 +917,39 @@ static struct page *swapin_no_readahead(swp_ent=
ry_t entry, gfp_t gfp_mask,
> > >   * or vma-based(ie, virtual address based on faulty address) readahe=
ad.
> > >   */
> > >  struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
> > > -                             struct vm_fault *vmf, bool *swapcached)
> > > +                             struct vm_fault *vmf, enum swap_cache_r=
esult *result)
> > >  {
> > > +       enum swap_cache_result cache_result;
> > >         struct swap_info_struct *si;
> > >         struct mempolicy *mpol;
> > > +       struct folio *folio;
> > >         struct page *page;
> > >         pgoff_t ilx;
> > > -       bool cached;
> > > +
> > > +       folio =3D swap_cache_get_folio(entry, vmf->vma, vmf->address)=
;
> > > +       if (folio) {
> > > +               page =3D folio_file_page(folio, swp_offset(entry));
> > > +               cache_result =3D SWAP_CACHE_HIT;
> > > +               goto done;
> > > +       }
> > >
> > >         si =3D swp_swap_info(entry);
> > >         mpol =3D get_vma_policy(vmf->vma, vmf->address, 0, &ilx);
> > >         if (swap_use_no_readahead(si, swp_offset(entry))) {
> > >                 page =3D swapin_no_readahead(entry, gfp_mask, mpol, i=
lx, vmf->vma->vm_mm);
> > > -               cached =3D false;
> > > +               cache_result =3D SWAP_CACHE_BYPASS;
> > >         } else if (swap_use_vma_readahead(si)) {
> > >                 page =3D swap_vma_readahead(entry, gfp_mask, mpol, il=
x, vmf);
> > > -               cached =3D true;
> > > +               cache_result =3D SWAP_CACHE_MISS;
> > >         } else {
> > >                 page =3D swap_cluster_readahead(entry, gfp_mask, mpol=
, ilx);
> > > -               cached =3D true;
> > > +               cache_result =3D SWAP_CACHE_MISS;
> > >         }
> > >         mpol_cond_put(mpol);
> > >
> > > -       if (swapcached)
> > > -               *swapcached =3D cached;
> > > +done:
> > > +       if (result)
> > > +               *result =3D cache_result;
> > >
> > >         return page;
> > >  }
> > > diff --git a/mm/swapfile.c b/mm/swapfile.c
> > > index 01c3f53b6521..b6d57fff5e21 100644
> > > --- a/mm/swapfile.c
> > > +++ b/mm/swapfile.c
> > > @@ -1822,13 +1822,21 @@ static int unuse_pte_range(struct vm_area_str=
uct *vma, pmd_t *pmd,
> > >
> > >         si =3D swap_info[type];
> > >         do {
> > > -               struct folio *folio;
> > > +               struct page *page;
> > >                 unsigned long offset;
> > >                 unsigned char swp_count;
> > > +               struct folio *folio =3D NULL;
> > >                 swp_entry_t entry;
> > >                 int ret;
> > >                 pte_t ptent;
> > >
> > > +               struct vm_fault vmf =3D {
> > > +                       .vma =3D vma,
> > > +                       .address =3D addr,
> > > +                       .real_address =3D addr,
> > > +                       .pmd =3D pmd,
> > > +               };
> >
> > Is this code move caused by skipping the swap cache look up here?
>
> Yes.
>
> >
> > This is very sensitive code related to swap cache racing. It needs
> > very careful reviewing. Better not shuffle it for no good reason.
>
> Thanks for the suggestion, I'll try to avoid these shuffling, but
> cache lookup is moved into swappin_readahead so some changes in the
> original caller are not avoidable...
Yes I agree sometimes it is unavoidable.

Chris
