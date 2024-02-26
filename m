Return-Path: <linux-kernel+bounces-80596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD7C866A26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D930E1F2332A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 06:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F451BDD0;
	Mon, 26 Feb 2024 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7ZE94TP"
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA501BDD3
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 06:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708929605; cv=none; b=fZ+0diwE0l4RC/MfDYQrGzEG1uEPuzuUt3/3Izmh2RYZja/nVMaGRBWVwhyGuRHsrcyjGprvMz8Mmyz8mnisxcGPR3hspU7kO6XpiUCQ56/xgD/0pBwOf8MGD1/jDfprjXPhD+A2AxARu6r1Uhe+90IQQ4lf7f2fRS0kJg3IeSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708929605; c=relaxed/simple;
	bh=BuYbqj6n+VTwewglU6jsgUTQ288dNBNEMZnCTZs6E3A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nOXTtQLbhL5ki9pLPejmn7sd6Y8691HK76ZYhtZdy6qVO4z/IML7kXXSzCqOjbp65eL2HYVgXf1TmuJTyxpFdycksXo0kBDpImU29yvqPh2W1BHbsdlP/Qy7C8s9VVA942O1dqpKPGUFu1K0ODvWF/NPE1I/y8074rWrawqUBtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7ZE94TP; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-7d5bbbe57b9so1028652241.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708929603; x=1709534403; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=REJoyVQFOAk4vMMCZgTE8cBGw5DeBzilZygz2Qptoq8=;
        b=R7ZE94TP83+nYiKpfRspbfwWsg6o8QImCD1lqCmAtntnifrMSW00pbSfMfBfdx8Q/a
         pghToiIJkaBPkKZXwpGzp/kF49OI9lpfJ7rdgfnWYAXf4BRCfWMTueeo0COv0c71in0s
         SmA2ccMQof5XGmbZu6DDM5oljS4Zx5rViLdpz7S62bj4C94ESHU10S6p+uf+BgC96hDm
         JByAUS1Z3OXrw1FdSZxN/2EQD3dLw5F6OlZeEGy/1OlHb0WwdfIKSHBpYr6k/R09QEQJ
         qT1KnT4vUwYDKZMgWxURsLIdTOeCRXuhgT8yrZBJPPcT+SZdCgA3ZItmlBgFn/3sD0Dm
         qXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708929603; x=1709534403;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=REJoyVQFOAk4vMMCZgTE8cBGw5DeBzilZygz2Qptoq8=;
        b=UobTmpV2GIHeHB1zR+JZX9+qK16DPKncINcifkFHUoTfFc14vXurSKpikFMXerMgeo
         woxR9nJspbDVFbS7XVZ2jR/Y7DbEymcOQ2Iy99xymNzeDBO1PKuZJsT6yr37GISakZgX
         l7dtxjPGqPDnGvdU6GP3OShh8KiEfIgHOsEVfTM7zTTZuDg7qGt8xTcqSjGyqxXmhK8n
         cbmYlUS/yfjF+v06+Q+mIS9okbnempxKbatigQZUHzF1y48K3+Mqu7kRIBHTDxwP9FRK
         wTsyqu8UVIaTNGncJ2rgvwd8iR8yZyRFD7atEZtEvjfW3CvW8+EqsC7VtaWmD9HYdFe6
         UDTg==
X-Forwarded-Encrypted: i=1; AJvYcCUaf6V5R2PI29InnXWNRWJAqav92/gIPG49ExGHQeg6G5QszDQ6AiriouiyNbFSFb19TEyPDCQxsF5JpbjKjhQIOFk0MKQtAnif/Mi5
X-Gm-Message-State: AOJu0YyOhf0uXmABJgoEj6aBTZXjXq2y18fvmw/szCVD/kYhdjqqPkj4
	HMtiD/plUurvbuD/TJH/Waju6rGYjqqv4sbJTXF5YGBj8JqvWwNWiboQVmHXvCjhJnit1coq/VN
	0h2RZYJ0+kpnil7vMoxK+xU5EXFo=
X-Google-Smtp-Source: AGHT+IHfxC1NeGX3vv+EHcFyZF/5L/kv3Pc3b6Cd85946cbSRvxmRbJpfUc8s+Pd/MyLQDjd+l6aQl+akvXTpJlDg5Q=
X-Received: by 2002:a67:c791:0:b0:470:79da:d606 with SMTP id
 t17-20020a67c791000000b0047079dad606mr2433322vsk.21.1708929602705; Sun, 25
 Feb 2024 22:40:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com> <CAF8kJuNAj0AfXy1zNi8KuK9VQuDaALF3-qyM42gjuLuqxrhDLQ@mail.gmail.com>
In-Reply-To: <CAF8kJuNAj0AfXy1zNi8KuK9VQuDaALF3-qyM42gjuLuqxrhDLQ@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 19:39:51 +1300
Message-ID: <CAGsJ_4wvEQA91M+RBy0hp5B3qpb5q4rtZT+qsWcVcXgstL+NKw@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
To: Chris Li <chrisl@kernel.org>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 3:15=E2=80=AFPM Chris Li <chrisl@kernel.org> wrote:
>
> On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > From: Chuanhua Han <hanchuanhua@oppo.com>
> >
> > MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset=
 has
> > supported swapping large folios out as a whole for vmscan case. This pa=
tch
> > extends the feature to madvise.
> >
> > If madvised range covers the whole large folio, we don't split it. Othe=
rwise,
> > we still need to split it.
> >
> > This patch doesn't depend on ARM64's CONT-PTE, alternatively, it define=
s one
> > helper named pte_range_cont_mapped() to check if all PTEs are contiguou=
sly
> > mapped to a large folio.
> >
> > Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> > Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> > Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> > ---
> >  include/asm-generic/tlb.h | 10 +++++++
> >  include/linux/pgtable.h   | 60 +++++++++++++++++++++++++++++++++++++++
> >  mm/madvise.c              | 48 +++++++++++++++++++++++++++++++
> >  3 files changed, 118 insertions(+)
> >
> > diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> > index 129a3a759976..f894e22da5d6 100644
> > --- a/include/asm-generic/tlb.h
> > +++ b/include/asm-generic/tlb.h
> > @@ -608,6 +608,16 @@ static inline void tlb_flush_p4d_range(struct mmu_=
gather *tlb,
> >                 __tlb_remove_tlb_entry(tlb, ptep, address);     \
> >         } while (0)
> >
> > +#define tlb_remove_nr_tlb_entry(tlb, ptep, address, nr)               =
         \
> > +       do {                                                           =
 \
> > +               int i;                                                 =
 \
> > +               tlb_flush_pte_range(tlb, address,                      =
 \
> > +                               PAGE_SIZE * nr);                       =
 \
> > +               for (i =3D 0; i < nr; i++)                             =
   \
> > +                       __tlb_remove_tlb_entry(tlb, ptep + i,          =
 \
> > +                                       address + i * PAGE_SIZE);      =
 \
> > +       } while (0)
> > +
> >  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)       \
> >         do {                                                    \
> >                 unsigned long _sz =3D huge_page_size(h);          \
> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 37fe83b0c358..da0c1cf447e3 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -320,6 +320,42 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
> >  }
> >  #endif
> >
> > +#ifndef pte_range_cont_mapped
> > +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
> > +                                        pte_t *start_pte,
> > +                                        unsigned long start_addr,
> > +                                        int nr)
> > +{
> > +       int i;
> > +       pte_t pte_val;
> > +
> > +       for (i =3D 0; i < nr; i++) {
> > +               pte_val =3D ptep_get(start_pte + i);
> > +
> > +               if (pte_none(pte_val))
> > +                       return false;
>
> Hmm, the following check pte_pfn =3D=3D start_pfn + i should have covered
> the pte none case?
>
> I think the pte_none means it can't have a valid pfn. So this check
> can be skipped?

yes. check pte_pfn =3D=3D start_pfn + i should have covered the pte none
case. but leaving pte_none there seems to make the code more
readable.  i guess we need to check pte_present() too, a small chance is
swp_offset can equal pte_pfn after some shifting? in case, a PTE
within the large folio range has been a swap entry?

I am still thinking about if we have some cheaper way to check if a folio
is still entirely mapped. maybe sth like if
(list_empty(&folio->_deferred_list))?

>
> > +
> > +               if (pte_pfn(pte_val) !=3D (start_pfn + i))
> > +                       return false;
> > +       }
> > +
> > +       return true;
> > +}
> > +#endif
> > +
> > +#ifndef pte_range_young
> > +static inline bool pte_range_young(pte_t *start_pte, int nr)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < nr; i++)
> > +               if (pte_young(ptep_get(start_pte + i)))
> > +                       return true;
> > +
> > +       return false;
> > +}
> > +#endif
> > +
> >  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> >  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma=
,
> >                                             unsigned long address,
> > @@ -580,6 +616,23 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
> >  }
> >  #endif
> >
> > +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_RANGE_FULL
> > +static inline pte_t ptep_get_and_clear_range_full(struct mm_struct *mm=
,
> > +                                                 unsigned long start_a=
ddr,
> > +                                                 pte_t *start_pte,
> > +                                                 int nr, int full)
> > +{
> > +       int i;
> > +       pte_t pte;
> > +
> > +       pte =3D ptep_get_and_clear_full(mm, start_addr, start_pte, full=
);
> > +
> > +       for (i =3D 1; i < nr; i++)
> > +               ptep_get_and_clear_full(mm, start_addr + i * PAGE_SIZE,
> > +                                       start_pte + i, full);
> > +
> > +       return pte;
> > +}
> >
> >  /*
> >   * If two threads concurrently fault at the same page, the thread that
> > @@ -995,6 +1048,13 @@ static inline void arch_swap_restore(swp_entry_t =
entry, struct folio *folio)
> >  })
> >  #endif
> >
> > +#ifndef pte_nr_addr_end
> > +#define pte_nr_addr_end(addr, size, end)                              =
 \
> > +({     unsigned long __boundary =3D ((addr) + size) & (~(size - 1));  =
   \
> > +       (__boundary - 1 < (end) - 1)? __boundary: (end);               =
 \
> > +})
> > +#endif
> > +
> >  /*
> >   * When walking page tables, we usually want to skip any p?d_none entr=
ies;
> >   * and any p?d_bad entries - reporting the error before resetting to n=
one.
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index 912155a94ed5..262460ac4b2e 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -452,6 +452,54 @@ static int madvise_cold_or_pageout_pte_range(pmd_t=
 *pmd,
> >                 if (folio_test_large(folio)) {
> >                         int err;
> >
> > +                       if (!folio_test_pmd_mappable(folio)) {
>
> This session of code indent into the right too much.
> You can do:
>
> if (folio_test_pmd_mappable(folio))
>          goto split;
>
> to make the code flatter.

I guess we don't need  "if (!folio_test_pmd_mappable(folio))" at all
as the pmd case has been
handled at the first beginning of  madvise_cold_or_pageout_pte_range().

>
> > +                               int nr_pages =3D folio_nr_pages(folio);
> > +                               unsigned long folio_size =3D PAGE_SIZE =
* nr_pages;
> > +                               unsigned long start_addr =3D ALIGN_DOWN=
(addr, nr_pages * PAGE_SIZE);;
> > +                               unsigned long start_pfn =3D page_to_pfn=
(folio_page(folio, 0));
> > +                               pte_t *start_pte =3D pte - (addr - star=
t_addr) / PAGE_SIZE;
> > +                               unsigned long next =3D pte_nr_addr_end(=
addr, folio_size, end);
> > +
> > +                               if (!pte_range_cont_mapped(start_pfn, s=
tart_pte, start_addr, nr_pages))
> > +                                       goto split;
> > +
> > +                               if (next - addr !=3D folio_size) {
>
> Nitpick: One line statement does not need {
>
> > +                                       goto split;
> > +                               } else {
>
> When the previous if statement already "goto split", there is no need
> for the else. You can save one level of indentation.

right!

>
>
>
> > +                                       /* Do not interfere with other =
mappings of this page */
> > +                                       if (folio_estimated_sharers(fol=
io) !=3D 1)
> > +                                               goto skip;
> > +
> > +                                       VM_BUG_ON(addr !=3D start_addr =
|| pte !=3D start_pte);
> > +
> > +                                       if (pte_range_young(start_pte, =
nr_pages)) {
> > +                                               ptent =3D ptep_get_and_=
clear_range_full(mm, start_addr, start_pte,
> > +                                                                      =
               nr_pages, tlb->fullmm);
> > +                                               ptent =3D pte_mkold(pte=
nt);
> > +
> > +                                               set_ptes(mm, start_addr=
, start_pte, ptent, nr_pages);
> > +                                               tlb_remove_nr_tlb_entry=
(tlb, start_pte, start_addr, nr_pages);
> > +                                       }
> > +
> > +                                       folio_clear_referenced(folio);
> > +                                       folio_test_clear_young(folio);
> > +                                       if (pageout) {
> > +                                               if (folio_isolate_lru(f=
olio)) {
> > +                                                       if (folio_test_=
unevictable(folio))
> > +                                                               folio_p=
utback_lru(folio);
> > +                                                       else
> > +                                                               list_ad=
d(&folio->lru, &folio_list);
> > +                                               }
> > +                                       } else
> > +                                               folio_deactivate(folio)=
;
>
> I notice this section is very similar to the earlier statements inside
> the same function.
> "if (pmd_trans_huge(*pmd)) {"
>
> Wondering if there is some way to unify the two a bit somehow.

we have duplicated the code three times - pmd, pte-mapped large, normal fol=
io.
I am quite sure if we can extract a common function.

>
> Also notice if you test the else condition first,
>
> If (!pageout) {
>     folio_deactivate(folio);
>     goto skip;
> }
>
> You can save one level of indentation.
> Not your fault, I notice the section inside (pmd_trans_huge(*pmd))
> does exactly the same thing.
>

can address this issue once we have a common func.

> Chris
>
>
> > +                               }
> > +skip:
> > +                               pte +=3D (next - PAGE_SIZE - (addr & PA=
GE_MASK))/PAGE_SIZE;
> > +                               addr =3D next - PAGE_SIZE;
> > +                               continue;
> > +
> > +                       }
> > +split:
> >                         if (folio_estimated_sharers(folio) !=3D 1)
> >                                 break;
> >                         if (pageout_anon_only_filter && !folio_test_ano=
n(folio))
> > --
> > 2.34.1
> >
> >

Thanks
Barry

