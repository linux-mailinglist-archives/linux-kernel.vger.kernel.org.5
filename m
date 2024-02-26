Return-Path: <linux-kernel+bounces-80632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9373866AA8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43A1A1F212F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB31BDED;
	Mon, 26 Feb 2024 07:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtPp6jYj"
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763D41BC30
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708932587; cv=none; b=Yqv+/L67ykYrATva53GcdXo4rDBCJwdoAhuJ8dx5vQC91qotlG+6/lpn1CZO+RwilHCEWnzIzkFYtTYgxNH49oJar2cK2MJyo6nS8Gp5feAz5Za9hhJ5I6BzTLkK7Lo/KDdZxY4ES5G8MzJnCTbgjj+ZwVHKsGgwdW5dzDS5Bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708932587; c=relaxed/simple;
	bh=X9rag6aryovz/bLDmGDedXKRWhFWdqZ//HmzgM2lsWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgOi4ETh32hQdjXefC7YkPhsTWGCBcNwuUHuanS40j6UADfgHO72MWf4ufkmmIr1TCo6fW3/I9sPsLhdKFvAUd/KRl8vfqHn0vwZWv3yPbcwALR0ruJblGI/K9jdgdJJHZgTK8c5wAkvr0cJvVkVYfOWLV+M/qMd3jgARyAgk+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtPp6jYj; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2e21181c1so1847162241.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 23:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708932584; x=1709537384; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKJawSF+80WKgrYbPE1LdDWc1xxOWl+XCE+fh2kLK+E=;
        b=AtPp6jYj2TWVp4tGLTxAIGX6jP4+i23tCxn7iFQ0YA1m9VCnvaRANklsAdDVtUoOBT
         dA05kcgtNw5xPEnTbcMDQpPT8OK6Eb8b+eUpKkMQctGtKyGJ/N/wJrs5DSyd8KYYTrgE
         QEVsoE+WJnePYZxma+XwE3en6vUHM5toQdtOFqeyhjke5nZnkNAf9fvFIVSoWeLcf45h
         JJjnottMylqbVe/swX4Z82DN4LRteScnrb1k57VD28grWaVY7tqgfxWVP/VCIF3mht9y
         Zmta+ZMMVBlis1IVA2T6VQk0/EGnBsloeNwdwaT9v6SLLVklPbTFtaqj34ZsGEj8a1Hi
         6ogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708932584; x=1709537384;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKJawSF+80WKgrYbPE1LdDWc1xxOWl+XCE+fh2kLK+E=;
        b=YL5+u3EHtrFT6TJbxQU7Ts+trHVvA9C323MDFJS/PCTWYEMYNPgJdBJEPuXnMBlj+q
         mlHIpLMflWiYGIPRztHZef2XUo1d0rgD061tsLdYtozaxTa8PjqpR6YLLbDQb5PCD6W3
         3+9S9tDHwudWUk/fFxSVlP+91WfHKYYd+1O6ea1+Y24YOSPqUKdQoy7jjIyC0vsoK7hw
         SWfuIeuC/0jmIkAChFXujPWPhIpSo9QY18/gTEELOrF09LNeZ4ZWEDBa1hek/fkl2HDv
         Tw6JjjVzUsrxDzOasWinyuH8I9ukERMquqng27uREe6w0oUjq7611Y0rgPlptjuLHww4
         IrBA==
X-Forwarded-Encrypted: i=1; AJvYcCURIYv+Z/pI4TJ2Z80Al/+2o7V9FjwdleyWUqXEuhl7qBrEewM8jeq1KmLB3iihh7jE2OYzdwrdSZBhndOq6ZF5+WUhv5wAg0eAU/Xl
X-Gm-Message-State: AOJu0YwdzqUoXwLFnNEtKSoDbffbuBGGqk3pgGEovMKcz+FFSEPjCgcx
	soJLAAC/FHAru1zqkq31/naHZTc6rl/dIE0uI4/6/iDzXKAvgese1LN2o5M3xG4meogGgIWxOip
	qTwzPuUjX/6QEMq3yQnaJF5619Ok=
X-Google-Smtp-Source: AGHT+IGAjx5/UwSuEgwsUSSOrhX9aho3posNHIVhxxSWkBCmz87LXVD/OcRr4j8soC9fkAB3GhMoQZRC7NZvHJeHuMA=
X-Received: by 2002:a05:6102:c4b:b0:470:4e67:3b38 with SMTP id
 y11-20020a0561020c4b00b004704e673b38mr3949794vss.14.1708932584176; Sun, 25
 Feb 2024 23:29:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-5-21cnbao@gmail.com> <CAF8kJuNDH4zVoLXJEVQLa0u5f=B0vHodrDZbUdoS+rug+wessw@mail.gmail.com>
In-Reply-To: <CAF8kJuNDH4zVoLXJEVQLa0u5f=B0vHodrDZbUdoS+rug+wessw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 20:29:33 +1300
Message-ID: <CAGsJ_4yZwpMxkM0K52fY8F1E-uMTzPJTd28YgMKkK8BaibUKqg@mail.gmail.com>
Subject: Re: [PATCH RFC 4/6] mm: support large folios swapin as a whole
To: Chris Li <chrisl@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 28, 2024 at 8:53=E2=80=AFAM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > On an embedded system like Android, more than half of anon memory is ac=
tually
> > in swap devices such as zRAM. For example, while an app is switched to =
back-
> > ground, its most memory might be swapped-out.
> >
> > Now we have mTHP features, unfortunately, if we don't support large fol=
ios
> > swap-in, once those large folios are swapped-out, we immediately lose t=
he
> > performance gain we can get through large folios and hardware optimizat=
ion
> > such as CONT-PTE.
> >
> > This patch brings up mTHP swap-in support. Right now, we limit mTHP swa=
p-in
> > to those contiguous swaps which were likely swapped out from mTHP as a =
whole.
> >
> > On the other hand, the current implementation only covers the SWAP_SYCH=
RONOUS
> > case. It doesn't support swapin_readahead as large folios yet.
> >
> > Right now, we are re-faulting large folios which are still in swapcache=
 as a
> > whole, this can effectively decrease extra loops and early-exitings whi=
ch we
> > have increased in arch_swap_restore() while supporting MTE restore for =
folios
> > rather than page.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  mm/memory.c | 108 +++++++++++++++++++++++++++++++++++++++++++++-------
> >  1 file changed, 94 insertions(+), 14 deletions(-)
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index f61a48929ba7..928b3f542932 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -107,6 +107,8 @@ EXPORT_SYMBOL(mem_map);
> >  static vm_fault_t do_fault(struct vm_fault *vmf);
> >  static vm_fault_t do_anonymous_page(struct vm_fault *vmf);
> >  static bool vmf_pte_changed(struct vm_fault *vmf);
> > +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> > +                                     bool (*pte_range_check)(pte_t *, =
int));
>
> Instead of returning "bool", the pte_range_check() can return the
> start of the swap entry of the large folio.
> That will save some of the later code needed to get the start of the
> large folio.

I am trying to reuse alloc_anon_folio() for both do_anon_page and
do_swap_page. Unfortunately, this func returns a folio, no more
place to return a swap entry unless we add a parameter. Getting
start swap is quite cheap on the other hand.

>
> >
> >  /*
> >   * Return true if the original pte was a uffd-wp pte marker (so the pt=
e was
> > @@ -3784,6 +3786,34 @@ static vm_fault_t handle_pte_marker(struct vm_fa=
ult *vmf)
> >         return VM_FAULT_SIGBUS;
> >  }
> >
> > +static bool pte_range_swap(pte_t *pte, int nr_pages)
>
> This function name seems to suggest it will perform the range swap.
> That is not what it is doing.
> Suggest change to some other name reflecting that it is only a
> condition test without actual swap action.
> I am not very good at naming functions. Just think it out loud: e.g.
> pte_range_swap_check, pte_test_range_swap. You can come up with
> something better.

Ryan has a function named pte_range_none, which is checking the whole
range is pte_none. Maybe we can have an is_pte_range_contig_swap
which includes both swap and contiguous as we only need contiguous
swap entries.

>
>
> > +{
> > +       int i;
> > +       swp_entry_t entry;
> > +       unsigned type;
> > +       pgoff_t start_offset;
> > +
> > +       entry =3D pte_to_swp_entry(ptep_get_lockless(pte));
> > +       if (non_swap_entry(entry))
> > +               return false;
> > +       start_offset =3D swp_offset(entry);
> > +       if (start_offset % nr_pages)
> > +               return false;
>
> This suggests the pte argument needs to point to the beginning of the
> large folio equivalent of swap entry(not sure what to call it. Let me
> call it "large folio swap" here.).
> We might want to unify the terms for that.
> Any way, might want to document this requirement, otherwise the caller
> might consider passing the current pte that generates the fault. From
> the function name it is not obvious which pte should pass it.

ok, Ryan's swap-out will allocate swap entries whose start offset is
aligned with nr_pages. will add some doc to describe the first entry.

>
> > +
> > +       type =3D swp_type(entry);
> > +       for (i =3D 1; i < nr_pages; i++) {
>
> You might want to test the last page backwards, because if the entry
> is not the large folio swap, most likely it will have the last entry
> invalid.  Some of the beginning swap entries might match due to batch
> allocation etc. The SSD likes to group the nearby swap entry write out
> together on the disk.

I am not sure I got your point. This is checking all pages within
the range of a large folio, Ryan's patch allocates swap entries
all together as a whole for a large folio while swapping out.

@@ -1073,14 +1133,13 @@ int get_swap_pages(int n_goal, swp_entry_t
swp_entries[], int entry_size)
         spin_unlock(&si->lock);
         goto nextsi;
  }
-        if (size =3D=3D SWAPFILE_CLUSTER) {
-               if (si->flags & SWP_BLKDEV)
-                      n_ret =3D swap_alloc_cluster(si, swp_entries);
+               if (size > 1) {
+                      n_ret =3D swap_alloc_large(si, swp_entries, size);
                } else
                       n_ret =3D scan_swap_map_slots(si, SWAP_HAS_CACHE,
     n_goal, swp_entries);


>
>
>
> > +               entry =3D pte_to_swp_entry(ptep_get_lockless(pte + i));
>
> > +               if (non_swap_entry(entry))
> > +                       return false;
> > +               if (swp_offset(entry) !=3D start_offset + i)
> > +                       return false;
> > +               if (swp_type(entry) !=3D type)
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +
> >  /*
> >   * We enter with non-exclusive mmap_lock (to exclude vma changes,
> >   * but allow concurrent faults), and pte mapped but not yet locked.
> > @@ -3804,6 +3834,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         pte_t pte;
> >         vm_fault_t ret =3D 0;
> >         void *shadow =3D NULL;
> > +       int nr_pages =3D 1;
> > +       unsigned long start_address;
> > +       pte_t *start_pte;
> >
> >         if (!pte_unmap_same(vmf))
> >                 goto out;
> > @@ -3868,13 +3901,20 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> >                     __swap_count(entry) =3D=3D 1) {
> >                         /* skip swapcache */
> > -                       folio =3D vma_alloc_folio(GFP_HIGHUSER_MOVABLE,=
 0,
> > -                                               vma, vmf->address, fals=
e);
> > +                       folio =3D alloc_anon_folio(vmf, pte_range_swap)=
;
>
> This function can call pte_range_swap() twice(), one here, another one
> in folio_test_large().
> Consider caching the result so it does not need to walk the pte range
> swap twice.
>
> I think alloc_anon_folio should either be told what is the
> size(prefered) or just figure out the right size. I don't think it
> needs to pass in the checking function as function callbacks. There
> are two call sites of alloc_anon_folio, they are all within this
> function. The call back seems a bit overkill here. Also duplicate the
> range swap walk.

alloc_anon_folio is reusing the one for do_anon_page. in both
cases, scanning PTEs to figure out the proper size is done.
The other call site is within do_anonymous_page().

>
> >                         page =3D &folio->page;
> >                         if (folio) {
> >                                 __folio_set_locked(folio);
> >                                 __folio_set_swapbacked(folio);
> >
> > +                               if (folio_test_large(folio)) {
> > +                                       unsigned long start_offset;
> > +
> > +                                       nr_pages =3D folio_nr_pages(fol=
io);
> > +                                       start_offset =3D swp_offset(ent=
ry) & ~(nr_pages - 1);
> Here is the first place place we roll up the start offset with folio size
>
> > +                                       entry =3D swp_entry(swp_type(en=
try), start_offset);
> > +                               }
> > +
> >                                 if (mem_cgroup_swapin_charge_folio(foli=
o,
> >                                                         vma->vm_mm, GFP=
_KERNEL,
> >                                                         entry)) {
> > @@ -3980,6 +4020,39 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          */
> >         vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->add=
ress,
> >                         &vmf->ptl);
> > +
> > +       start_address =3D vmf->address;
> > +       start_pte =3D vmf->pte;
> > +       if (folio_test_large(folio)) {
> > +               unsigned long nr =3D folio_nr_pages(folio);
> > +               unsigned long addr =3D ALIGN_DOWN(vmf->address, nr * PA=
GE_SIZE);
> > +               pte_t *pte_t =3D vmf->pte - (vmf->address - addr) / PAG=
E_SIZE;
>
> Here is the second place we roll up the folio size.
> Maybe we can cache results and avoid repetition?

We have two paths getting into large folios
1. we allocate a new large folio
2. we find a large folio in swapcache

We have rolled up the folio size for case 1 before, but here we need to
take care of case 2 as well. so that is why we need both. let me think
if we can have some way to remove some redundant code for case 1.

>
> > +
> > +               /*
> > +                * case 1: we are allocating large_folio, try to map it=
 as a whole
> > +                * iff the swap entries are still entirely mapped;
> > +                * case 2: we hit a large folio in swapcache, and all s=
wap entries
> > +                * are still entirely mapped, try to map a large folio =
as a whole.
> > +                * otherwise, map only the faulting page within the lar=
ge folio
> > +                * which is swapcache
> > +                */
>
> One question I have in mind is that the swap device is locked. We
> can't change the swap slot allocations.
> It does not stop the pte entry getting changed right? Then we can have
> someone in the user pace racing to change the PTE vs we checking the
> pte there.
>
> > +               if (pte_range_swap(pte_t, nr)) {
>
> After this pte_range_swap() check, some of the PTE entries get changed
> and now we don't have the full large page swap any more?
> At least I can't conclude this possibility can't happen yet, please
> enlighten me.

This check is under PTL. no one else can change it as they have to
hold PTL to change pte.
        vmf->pte =3D pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address=
,
                        &vmf->ptl);


>
> > +                       start_address =3D addr;
> > +                       start_pte =3D pte_t;
> > +                       if (unlikely(folio =3D=3D swapcache)) {
> > +                               /*
> > +                                * the below has been done before swap_=
read_folio()
> > +                                * for case 1
> > +                                */
> > +                               nr_pages =3D nr;
> > +                               entry =3D pte_to_swp_entry(ptep_get(sta=
rt_pte));
>
> If we make pte_range_swap() return the entry, we can avoid refetching
> the swap entry here.

we will have to add a parameter swp_entry_t *first_entry to return
the entry. The difficulty is we will have to add this parameter in
alloc_anon_folio() as well, that's a bit overkill for that function.


>
> > +                               page =3D &folio->page;
> > +                       }
> > +               } else if (nr_pages > 1) { /* ptes have changed for cas=
e 1 */
> > +                       goto out_nomap;
> > +               }
> > +       }
> > +
> I rewrote the above to make the code indentation matching the execution f=
low.
> I did not add any functional change. Just rearrange the code to be a
> bit more streamlined. Get rid of the "else if goto".
>                if (!pte_range_swap(pte_t, nr)) {
>                         if (nr_pages > 1)  /* ptes have changed for case =
1 */
>                                 goto out_nomap;
>                         goto check_pte;
>                 }
>
>                 start_address =3D addr;
>                 start_pte =3D pte_t;
>                 if (unlikely(folio =3D=3D swapcache)) {
>                         /*
>                          * the below has been done before swap_read_folio=
()
>                          * for case 1
>                          */
>                         nr_pages =3D nr;
>                         entry =3D pte_to_swp_entry(ptep_get(start_pte));
>                         page =3D &folio->page;
>                 }
>         }

looks good to me.

>
> check_pte:
>
> >         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->or=
ig_pte)))
> >                 goto out_nomap;
> >
> > @@ -4047,12 +4120,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          * We're already holding a reference on the page but haven't ma=
pped it
> >          * yet.
> >          */
> > -       swap_free(entry);
> > +       swap_nr_free(entry, nr_pages);
> >         if (should_try_to_free_swap(folio, vma, vmf->flags))
> >                 folio_free_swap(folio);
> >
> > -       inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
> > -       dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
> > +       folio_ref_add(folio, nr_pages - 1);
> > +       add_mm_counter(vma->vm_mm, MM_ANONPAGES, nr_pages);
> > +       add_mm_counter(vma->vm_mm, MM_SWAPENTS, -nr_pages);
> > +
> >         pte =3D mk_pte(page, vma->vm_page_prot);
> >
> >         /*
> > @@ -4062,14 +4137,14 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >          * exclusivity.
> >          */
> >         if (!folio_test_ksm(folio) &&
> > -           (exclusive || folio_ref_count(folio) =3D=3D 1)) {
> > +           (exclusive || folio_ref_count(folio) =3D=3D nr_pages)) {
> >                 if (vmf->flags & FAULT_FLAG_WRITE) {
> >                         pte =3D maybe_mkwrite(pte_mkdirty(pte), vma);
> >                         vmf->flags &=3D ~FAULT_FLAG_WRITE;
> >                 }
> >                 rmap_flags |=3D RMAP_EXCLUSIVE;
> >         }
> > -       flush_icache_page(vma, page);
> > +       flush_icache_pages(vma, page, nr_pages);
> >         if (pte_swp_soft_dirty(vmf->orig_pte))
> >                 pte =3D pte_mksoft_dirty(pte);
> >         if (pte_swp_uffd_wp(vmf->orig_pte))
> > @@ -4081,14 +4156,15 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >                 folio_add_new_anon_rmap(folio, vma, vmf->address);
> >                 folio_add_lru_vma(folio, vma);
> >         } else {
> > -               folio_add_anon_rmap_pte(folio, page, vma, vmf->address,
> > +               folio_add_anon_rmap_ptes(folio, page, nr_pages, vma, st=
art_address,
> >                                         rmap_flags);
> >         }
> >
> >         VM_BUG_ON(!folio_test_anon(folio) ||
> >                         (pte_write(pte) && !PageAnonExclusive(page)));
> > -       set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
> > -       arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig=
_pte);
> > +       set_ptes(vma->vm_mm, start_address, start_pte, pte, nr_pages);
> > +
> > +       arch_do_swap_page(vma->vm_mm, vma, start_address, pte, vmf->ori=
g_pte);
> >
> >         folio_unlock(folio);
> >         if (folio !=3D swapcache && swapcache) {
> > @@ -4105,6 +4181,9 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         }
> >
> >         if (vmf->flags & FAULT_FLAG_WRITE) {
> > +               if (folio_test_large(folio) && nr_pages > 1)
> > +                       vmf->orig_pte =3D ptep_get(vmf->pte);
> > +
> >                 ret |=3D do_wp_page(vmf);
> >                 if (ret & VM_FAULT_ERROR)
> >                         ret &=3D VM_FAULT_ERROR;
> > @@ -4112,7 +4191,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
> >         }
> >
> >         /* No need to invalidate - it was non-present before */
> > -       update_mmu_cache_range(vmf, vma, vmf->address, vmf->pte, 1);
> > +       update_mmu_cache_range(vmf, vma, start_address, start_pte, nr_p=
ages);
> >  unlock:
> >         if (vmf->pte)
> >                 pte_unmap_unlock(vmf->pte, vmf->ptl);
> > @@ -4148,7 +4227,8 @@ static bool pte_range_none(pte_t *pte, int nr_pag=
es)
> >         return true;
> >  }
> >
> > -static struct folio *alloc_anon_folio(struct vm_fault *vmf)
> > +static struct folio *alloc_anon_folio(struct vm_fault *vmf,
> > +                                     bool (*pte_range_check)(pte_t *, =
int))
> >  {
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> >         struct vm_area_struct *vma =3D vmf->vma;
> > @@ -4190,7 +4270,7 @@ static struct folio *alloc_anon_folio(struct vm_f=
ault *vmf)
>
> About this patch context we have the following comments in the source cod=
e.
>         /*
>          * Find the highest order where the aligned range is completely
>          * pte_none(). Note that all remaining orders will be completely
>          * pte_none().
>          */
> >         order =3D highest_order(orders);
> >         while (orders) {
> >                 addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << order);
> > -               if (pte_range_none(pte + pte_index(addr), 1 << order))
> > +               if (pte_range_check(pte + pte_index(addr), 1 << order))
>
> Again, I don't think we need to pass in the pte_range_check() as call
> back functions.
> There are only two call sites, all within this file. This will totally
> invalide the above comments about pte_none(). In the worst case, just
> make it accept one argument: it is checking swap range or none range
> or not. Depending on the argument, do check none or swap range.
> We should make it blend in with alloc_anon_folio better. My gut
> feeling is that there should be a better way to make the range check
> blend in with alloc_anon_folio better. e.g. Maybe store some of the
> large swap context in the vmf and pass to different places etc. I need
> to spend more time thinking about it to come up with happier
> solutions.

could pass a type to hint pte_range_none or pte_range_swap.
i'd like to avoid changing any global variable like vmf, as people
will have to cross two or more functions to understand what is
going on though the second function might be able to use the
changed vmf value in the first function. but it really makes the
code have more couples.

>
> Chris
>
> >                         break;
> >                 order =3D next_order(&orders, order);
> >         }
> > @@ -4269,7 +4349,7 @@ static vm_fault_t do_anonymous_page(struct vm_fau=
lt *vmf)
> >         if (unlikely(anon_vma_prepare(vma)))
> >                 goto oom;
> >         /* Returns NULL on OOM or ERR_PTR(-EAGAIN) if we must retry the=
 fault */
> > -       folio =3D alloc_anon_folio(vmf);
> > +       folio =3D alloc_anon_folio(vmf, pte_range_none);
> >         if (IS_ERR(folio))
> >                 return 0;
> >         if (!folio)
> > --
> > 2.34.1
> >

Thanks
Barry

