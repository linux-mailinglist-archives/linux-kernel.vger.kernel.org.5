Return-Path: <linux-kernel+bounces-42082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BE3983FC11
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C605E1F22FA9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 02:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9794EAE4;
	Mon, 29 Jan 2024 02:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7fuT1X6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97356DF69
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706494516; cv=none; b=uaTySdBM8lvg3X9MZJP8LiZUKStSkGwgKXmSqHNfk7Uuz5rdGNQ2QLzXqwHBIOywghI6VLcClzxioPaBEIZr2E+b4aaf2dXv80SuXsRAt4AsyGSOiWD2XrkjsTEnOMphz+/0xycAHFzPqhvdFbftAk9NbaUzXPWOC9+LVaXtj6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706494516; c=relaxed/simple;
	bh=7055U/9Nxv5bXUdnlD++5r6zZXVPj28DxkcLh6h6JgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RB1a7XdkDFEiK3uutkCvoP9knj9UzGTH2Jw8HzLrmX9+w6EoGvpq91g/TumXtX6dPFrN1GJddBhSmrPJE7KD46gEEazDe44exNZ0P7+sxWTgSg3+eo00FdeDasYHASJUSWKtLVvOZ3Dh5vePsCFg+On3wzwTG+bJD1cbQ8i3JZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7fuT1X6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0CFC43399
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 02:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706494516;
	bh=7055U/9Nxv5bXUdnlD++5r6zZXVPj28DxkcLh6h6JgA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Z7fuT1X6IyKphgcImv6Ykm47ABZiD2GM5GnUNxemHnSy1Awg8vRetFR5HijZO4EZP
	 aJDXHqJmKhv1IMBNETgFSjKPhJ6F1o9qEoihV5F4eN8KovEir4q7Ub0//AE3M7TUeK
	 a/rZ7CIQ0HM7+Pw7gMx6IJ9PMnm3Tlahk4HkgFegw52pKsLCNXtTFUowlbQEcy6bkM
	 qx44r2J6q4RNlD7nPs8WJELo3+yvcdbcsZOLj58YVYBHyZFurZg4jbVrtodzrDm/1W
	 mA3Fd4vycib3VPieknw6Sv9sok4GL4vBNgzy9be9PQi0Fl/yVMQY2fNfO0D0LHtBzO
	 zSCWKoE6rom4Q==
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7bfeacc32d2so40127339f.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 18:15:15 -0800 (PST)
X-Gm-Message-State: AOJu0YxG87QgrCigdy8sYB3nVpEUDkPa5Xnog2qoz1yvDP7cyU/V0rTB
	vIxJyNi7vMlHKBAxI3uSWY85YocgJi5sUPIxqPpJjCy09q4gQTPXyXwzZh6AUmTgAXLQvNvlxWe
	OhU80mcHFWUGKDZR3ER0niqKuOxHm89xosCtc
X-Google-Smtp-Source: AGHT+IEvOpo+ECoXVFn7hv2AVOp8va3Wt0QdiIVOOWoN1MX9U9R8xdEZCYi3P/pz3z/fNn14gfjoa8NV2HIbgL0orU0=
X-Received: by 2002:a05:6e02:1a4a:b0:361:a7a2:9daf with SMTP id
 u10-20020a056e021a4a00b00361a7a29dafmr7366338ilv.27.1706494515194; Sun, 28
 Jan 2024 18:15:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025144546.577640-1-ryan.roberts@arm.com> <20240118111036.72641-1-21cnbao@gmail.com>
 <20240118111036.72641-7-21cnbao@gmail.com>
In-Reply-To: <20240118111036.72641-7-21cnbao@gmail.com>
From: Chris Li <chrisl@kernel.org>
Date: Sun, 28 Jan 2024 18:15:03 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNAj0AfXy1zNi8KuK9VQuDaALF3-qyM42gjuLuqxrhDLQ@mail.gmail.com>
Message-ID: <CAF8kJuNAj0AfXy1zNi8KuK9VQuDaALF3-qyM42gjuLuqxrhDLQ@mail.gmail.com>
Subject: Re: [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
To: Barry Song <21cnbao@gmail.com>
Cc: ryan.roberts@arm.com, akpm@linux-foundation.org, david@redhat.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, mhocko@suse.com, 
	shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org, 
	xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com, surenb@google.com, 
	steven.price@arm.com, Chuanhua Han <hanchuanhua@oppo.com>, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 3:12=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Chuanhua Han <hanchuanhua@oppo.com>
>
> MADV_PAGEOUT and MADV_FREE are common cases in Android. Ryan's patchset h=
as
> supported swapping large folios out as a whole for vmscan case. This patc=
h
> extends the feature to madvise.
>
> If madvised range covers the whole large folio, we don't split it. Otherw=
ise,
> we still need to split it.
>
> This patch doesn't depend on ARM64's CONT-PTE, alternatively, it defines =
one
> helper named pte_range_cont_mapped() to check if all PTEs are contiguousl=
y
> mapped to a large folio.
>
> Signed-off-by: Chuanhua Han <hanchuanhua@oppo.com>
> Co-developed-by: Barry Song <v-songbaohua@oppo.com>
> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  include/asm-generic/tlb.h | 10 +++++++
>  include/linux/pgtable.h   | 60 +++++++++++++++++++++++++++++++++++++++
>  mm/madvise.c              | 48 +++++++++++++++++++++++++++++++
>  3 files changed, 118 insertions(+)
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 129a3a759976..f894e22da5d6 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -608,6 +608,16 @@ static inline void tlb_flush_p4d_range(struct mmu_ga=
ther *tlb,
>                 __tlb_remove_tlb_entry(tlb, ptep, address);     \
>         } while (0)
>
> +#define tlb_remove_nr_tlb_entry(tlb, ptep, address, nr)                 =
       \
> +       do {                                                            \
> +               int i;                                                  \
> +               tlb_flush_pte_range(tlb, address,                       \
> +                               PAGE_SIZE * nr);                        \
> +               for (i =3D 0; i < nr; i++)                               =
 \
> +                       __tlb_remove_tlb_entry(tlb, ptep + i,           \
> +                                       address + i * PAGE_SIZE);       \
> +       } while (0)
> +
>  #define tlb_remove_huge_tlb_entry(h, tlb, ptep, address)       \
>         do {                                                    \
>                 unsigned long _sz =3D huge_page_size(h);          \
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 37fe83b0c358..da0c1cf447e3 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -320,6 +320,42 @@ static inline pgd_t pgdp_get(pgd_t *pgdp)
>  }
>  #endif
>
> +#ifndef pte_range_cont_mapped
> +static inline bool pte_range_cont_mapped(unsigned long start_pfn,
> +                                        pte_t *start_pte,
> +                                        unsigned long start_addr,
> +                                        int nr)
> +{
> +       int i;
> +       pte_t pte_val;
> +
> +       for (i =3D 0; i < nr; i++) {
> +               pte_val =3D ptep_get(start_pte + i);
> +
> +               if (pte_none(pte_val))
> +                       return false;

Hmm, the following check pte_pfn =3D=3D start_pfn + i should have covered
the pte none case?

I think the pte_none means it can't have a valid pfn. So this check
can be skipped?

> +
> +               if (pte_pfn(pte_val) !=3D (start_pfn + i))
> +                       return false;
> +       }
> +
> +       return true;
> +}
> +#endif
> +
> +#ifndef pte_range_young
> +static inline bool pte_range_young(pte_t *start_pte, int nr)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < nr; i++)
> +               if (pte_young(ptep_get(start_pte + i)))
> +                       return true;
> +
> +       return false;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>  static inline int ptep_test_and_clear_young(struct vm_area_struct *vma,
>                                             unsigned long address,
> @@ -580,6 +616,23 @@ static inline pte_t ptep_get_and_clear_full(struct m=
m_struct *mm,
>  }
>  #endif
>
> +#define __HAVE_ARCH_PTEP_GET_AND_CLEAR_RANGE_FULL
> +static inline pte_t ptep_get_and_clear_range_full(struct mm_struct *mm,
> +                                                 unsigned long start_add=
r,
> +                                                 pte_t *start_pte,
> +                                                 int nr, int full)
> +{
> +       int i;
> +       pte_t pte;
> +
> +       pte =3D ptep_get_and_clear_full(mm, start_addr, start_pte, full);
> +
> +       for (i =3D 1; i < nr; i++)
> +               ptep_get_and_clear_full(mm, start_addr + i * PAGE_SIZE,
> +                                       start_pte + i, full);
> +
> +       return pte;
> +}
>
>  /*
>   * If two threads concurrently fault at the same page, the thread that
> @@ -995,6 +1048,13 @@ static inline void arch_swap_restore(swp_entry_t en=
try, struct folio *folio)
>  })
>  #endif
>
> +#ifndef pte_nr_addr_end
> +#define pte_nr_addr_end(addr, size, end)                               \
> +({     unsigned long __boundary =3D ((addr) + size) & (~(size - 1));    =
 \
> +       (__boundary - 1 < (end) - 1)? __boundary: (end);                \
> +})
> +#endif
> +
>  /*
>   * When walking page tables, we usually want to skip any p?d_none entrie=
s;
>   * and any p?d_bad entries - reporting the error before resetting to non=
e.
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 912155a94ed5..262460ac4b2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -452,6 +452,54 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *=
pmd,
>                 if (folio_test_large(folio)) {
>                         int err;
>
> +                       if (!folio_test_pmd_mappable(folio)) {

This session of code indent into the right too much.
You can do:

if (folio_test_pmd_mappable(folio))
         goto split;

to make the code flatter.

> +                               int nr_pages =3D folio_nr_pages(folio);
> +                               unsigned long folio_size =3D PAGE_SIZE * =
nr_pages;
> +                               unsigned long start_addr =3D ALIGN_DOWN(a=
ddr, nr_pages * PAGE_SIZE);;
> +                               unsigned long start_pfn =3D page_to_pfn(f=
olio_page(folio, 0));
> +                               pte_t *start_pte =3D pte - (addr - start_=
addr) / PAGE_SIZE;
> +                               unsigned long next =3D pte_nr_addr_end(ad=
dr, folio_size, end);
> +
> +                               if (!pte_range_cont_mapped(start_pfn, sta=
rt_pte, start_addr, nr_pages))
> +                                       goto split;
> +
> +                               if (next - addr !=3D folio_size) {

Nitpick: One line statement does not need {

> +                                       goto split;
> +                               } else {

When the previous if statement already "goto split", there is no need
for the else. You can save one level of indentation.



> +                                       /* Do not interfere with other ma=
ppings of this page */
> +                                       if (folio_estimated_sharers(folio=
) !=3D 1)
> +                                               goto skip;
> +
> +                                       VM_BUG_ON(addr !=3D start_addr ||=
 pte !=3D start_pte);
> +
> +                                       if (pte_range_young(start_pte, nr=
_pages)) {
> +                                               ptent =3D ptep_get_and_cl=
ear_range_full(mm, start_addr, start_pte,
> +                                                                        =
             nr_pages, tlb->fullmm);
> +                                               ptent =3D pte_mkold(ptent=
);
> +
> +                                               set_ptes(mm, start_addr, =
start_pte, ptent, nr_pages);
> +                                               tlb_remove_nr_tlb_entry(t=
lb, start_pte, start_addr, nr_pages);
> +                                       }
> +
> +                                       folio_clear_referenced(folio);
> +                                       folio_test_clear_young(folio);
> +                                       if (pageout) {
> +                                               if (folio_isolate_lru(fol=
io)) {
> +                                                       if (folio_test_un=
evictable(folio))
> +                                                               folio_put=
back_lru(folio);
> +                                                       else
> +                                                               list_add(=
&folio->lru, &folio_list);
> +                                               }
> +                                       } else
> +                                               folio_deactivate(folio);

I notice this section is very similar to the earlier statements inside
the same function.
"if (pmd_trans_huge(*pmd)) {"

Wondering if there is some way to unify the two a bit somehow.

Also notice if you test the else condition first,

If (!pageout) {
    folio_deactivate(folio);
    goto skip;
}

You can save one level of indentation.
Not your fault, I notice the section inside (pmd_trans_huge(*pmd))
does exactly the same thing.

Chris


> +                               }
> +skip:
> +                               pte +=3D (next - PAGE_SIZE - (addr & PAGE=
_MASK))/PAGE_SIZE;
> +                               addr =3D next - PAGE_SIZE;
> +                               continue;
> +
> +                       }
> +split:
>                         if (folio_estimated_sharers(folio) !=3D 1)
>                                 break;
>                         if (pageout_anon_only_filter && !folio_test_anon(=
folio))
> --
> 2.34.1
>
>

