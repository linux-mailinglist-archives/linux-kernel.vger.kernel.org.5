Return-Path: <linux-kernel+bounces-80522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51DFC86691C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1461F21B26
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DA41E895;
	Mon, 26 Feb 2024 04:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMOkLHvZ"
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CBB1E878
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:00:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708920057; cv=none; b=Qi8ua/oTHd9Wva6kfHbzJOVc3V3itSuK/tHXGSViAxYcvI+ynZOp4jYC5P/ocOQaoxK3Q1TMlYXHLaprAlEBHHL8obyrYPhB4PtoiiH1QW6v9gQnsxVEvRlF/SO7pv3xMrE3ws0Nx5EN64LnEPqmaTad3kuWIUY/LeLhiNU4q5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708920057; c=relaxed/simple;
	bh=8tYqG/t+1SP08HM4S1Xj39Stbi0RUEV2lL4f/lqPoDI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yv17XQlJGhk3RoAX7bKSu9LHmmXDr2NSfEJqPFL5j39buT2y1YLU6ETYx4A/ej6qdkHs8XHBaa75GWcZ5AUIUquEvpp45RhqHAyC4i+dKMrJlnaphOaN/L2HiyVLwGnJ7i4b4+AXseVLM3a5BZEGBT1Jl/R5Qc0WmcLRuDvw8uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMOkLHvZ; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-7d2e19120b5so1724313241.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708920055; x=1709524855; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wx6scJy++Ki5ZJPsfnA0F/ArC+ZMcpgrqxfkAiYtClk=;
        b=fMOkLHvZ3lliFAiuSBliYk10B7aFz0AWhGbr5in0vgqo7GbRVahltGv0mM5hbUp1IT
         7XnDp3AFxR417c5U9JFsWi2B6hh2g1sVlCU6jaXeXJaLnW/7hItr+Op3KYcMrFutN8Jc
         GCZb1q8nPG2OTqNqHgnX2RaH1Bf+tG+QOfBnQMIpHRJBonWnfBzjArlp0ujFHC7aF70u
         89ccNWnMbKfeVefIfxDg6fyQNgbWqUswE0IsssakqHy5oJ+T0pU0B5xA53C8yQVJyg91
         V5UnmFnwABUlLZdR8da7eZaf1h+JYEvM8EXXatFMoZtgNcR0ntBdEvJkmH1CO8+rJwP4
         ErqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708920055; x=1709524855;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wx6scJy++Ki5ZJPsfnA0F/ArC+ZMcpgrqxfkAiYtClk=;
        b=LHDTd/Dv3cjjCUEphHNcXgEgIJjt68IrfmmRkhdcvq1TbHC19AI8JCuPzWeAUuxRHk
         NNAM1QIrFADfyZ8oXIAjcR1o/143J0/9lCFnpXyHipe3Mmr/9ciISnFLcJPBpOWXGvtM
         DEAJprKHJTVAu5SiTaPqzVnGRHhFGysHA14dpx3+QC6kCuDDKhGKHJNuggzrTvIFEnEh
         QVYk+XUdJookw9X4toU2ucWbPJuReAH5OUfKDbaIbKIcWtVb2Y0OsHEth2zyXIbWx3Un
         MgdwquzKYoyaza0//KcRfajVF0MnfRacmC/LU3pmbjPh2ENV1wpFl3yFSPhPKD2fAnNM
         vPdA==
X-Forwarded-Encrypted: i=1; AJvYcCXyUFAWXo59hZ9+1DADNf0DCn4812h8XrboovtbVxCxbhpWOj2LBq0LtE88Nmi8tun6AsOPnzGjRDgC6VR/OVpCt33U7JhFOqAU1H5H
X-Gm-Message-State: AOJu0YwE0VNJQT8ze+LDjV2SiJT+NNHoxoGZh/7+RS558tcFQF5aEOYY
	stj9nsPnlGR9FzbDsC2pikX1A9Q8N41Rh0vLF1srdd9siWt38HGiQSpkeHJFp5owGmjGWmC5Q3I
	xuGxKXnlb37XIiqTDMhpeSV3EwvY=
X-Google-Smtp-Source: AGHT+IHRTq8LjYB5t3A9k73Cd2X7/8pF9CIj1efeI4Cgnzl8bChG5hssDoUkqsBIDvGLA1HwW/C7eS3idXmrrt5jkgw=
X-Received: by 2002:a1f:4bc2:0:b0:4ca:15b2:a09b with SMTP id
 y185-20020a1f4bc2000000b004ca15b2a09bmr2735352vka.13.1708920054985; Sun, 25
 Feb 2024 20:00:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240225123215.86503-1-ioworker0@gmail.com>
In-Reply-To: <20240225123215.86503-1-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 26 Feb 2024 17:00:43 +1300
Message-ID: <CAGsJ_4zera4+bWuXHKjdU3QdiR3sqcUQB3gF08DPD49OCT4S9w@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, shy828301@gmail.com, 
	david@redhat.com, mhocko@suse.com, ryan.roberts@arm.com, 
	wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com, 
	minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lance,


On Mon, Feb 26, 2024 at 1:33=E2=80=AFAM Lance Yang <ioworker0@gmail.com> wr=
ote:
>
> This patch improves madvise_free_pte_range() to correctly
> handle large folio that is smaller than PMD-size
> (for example, 16KiB to 1024KiB[1]). It=E2=80=99s probably part of
> the preparation to support anonymous multi-size THP.
>
> Additionally, when the consecutive PTEs are mapped to
> consecutive pages of the same large folio (mTHP), if the
> folio is locked before madvise(MADV_FREE) or cannot be
> split, then all subsequent PTEs within the same PMD will
> be skipped. However, they should have been MADV_FREEed.
>
> Moreover, this patch also optimizes lazyfreeing with
> PTE-mapped mTHP (Inspired by David Hildenbrand[2]). We
> aim to avoid unnecessary folio splitting if the large
> folio is entirely within the given range.
>

We did something similar on MADV_PAGEOUT[1]

[1] https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.c=
om/


> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
> PTE-mapped folios of the same size results in the following
> runtimes for madvise(MADV_FREE) in seconds (shorter is better):
>
> Folio Size  |    Old     |    New     |  Change
> ----------------------------------------------
>       4KiB  |  0.590251  |  0.590264  |     0%
>      16KiB  |  2.990447  |  0.182167  |   -94%
>      32KiB  |  2.547831  |  0.101622  |   -96%
>      64KiB  |  2.457796  |  0.049726  |   -98%
>     128KiB  |  2.281034  |  0.030109  |   -99%
>     256KiB  |  2.230387  |  0.015838  |   -99%
>     512KiB  |  2.189106  |  0.009149  |   -99%
>    1024KiB  |  2.183949  |  0.006620  |   -99%
>    2048KiB  |  0.002799  |  0.002795  |     0%
>
> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.c=
om
> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat=
com/
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
>  mm/madvise.c | 69 +++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 58 insertions(+), 11 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index cfa5e7288261..bcbf56595a2e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -676,11 +676,43 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
>                  */
>                 if (folio_test_large(folio)) {
>                         int err;
> +                       unsigned long next_addr, align;
>
> -                       if (folio_estimated_sharers(folio) !=3D 1)
> -                               break;
> -                       if (!folio_trylock(folio))
> -                               break;
> +                       if (folio_estimated_sharers(folio) !=3D 1 ||
> +                           !folio_trylock(folio))
> +                               goto skip_large_folio;
> +
> +                       align =3D folio_nr_pages(folio) * PAGE_SIZE;
> +                       next_addr =3D ALIGN_DOWN(addr + align, align);
> +
> +                       /*
> +                        * If we mark only the subpages as lazyfree,
> +                        * split the large folio.
> +                        */
> +                       if (next_addr > end || next_addr - addr !=3D alig=
n)
> +                               goto split_large_folio;
> +
> +                       /*
> +                        * Avoid unnecessary folio splitting if the large
> +                        * folio is entirely within the given range.
> +                        */
> +                       folio_test_clear_dirty(folio);
> +                       folio_unlock(folio);
> +                       for (; addr !=3D next_addr; pte++, addr +=3D PAGE=
_SIZE) {
> +                               ptent =3D ptep_get(pte);
> +                               if (pte_young(ptent) || pte_dirty(ptent))=
 {
> +                                       ptent =3D ptep_get_and_clear_full=
(
> +                                               mm, addr, pte, tlb->fullm=
m);
> +                                       ptent =3D pte_mkold(ptent);
> +                                       ptent =3D pte_mkclean(ptent);
> +                                       set_pte_at(mm, addr, pte, ptent);
> +                                       tlb_remove_tlb_entry(tlb, pte, ad=
dr);
> +                               }

The code works under the assumption the large folio is entirely mapped
in all PTEs in the range. This is not always true.

This won't work in some cases as some PTEs might be mapping to the
large folios. some others might have been unmapped or mapped
to different folios.

so in MADV_PAGEOUT, we have a function to check the folio is
really entirely mapped:

+static inline bool pte_range_cont_mapped(unsigned long start_pfn,
+ pte_t *start_pte, unsigned long start_addr, int nr)
+{
+              int i;
+              pte_t pte_val;
+
+              for (i =3D 0; i < nr; i++) {
+                           pte_val =3D ptep_get(start_pte + i);
+
+                           if (pte_none(pte_val))
+                                        return false;
+
+                           if (pte_pfn(pte_val) !=3D (start_pfn + i))
+                                        return false;
+              }
+
+              return true;
+}

> +                       }
> +                       folio_mark_lazyfree(folio);
> +                       goto next_folio;
> +
> +split_large_folio:
>                         folio_get(folio);
>                         arch_leave_lazy_mmu_mode();
>                         pte_unmap_unlock(start_pte, ptl);
> @@ -688,13 +720,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
ned long addr,
>                         err =3D split_folio(folio);
>                         folio_unlock(folio);
>                         folio_put(folio);
> -                       if (err)
> -                               break;
> -                       start_pte =3D pte =3D
> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
> -                       if (!start_pte)
> -                               break;
> -                       arch_enter_lazy_mmu_mode();
> +
> +                       /*
> +                        * If the large folio is locked before madvise(MA=
DV_FREE)
> +                        * or cannot be split, we just skip it.
> +                        */
> +                       if (err) {
> +skip_large_folio:
> +                               if (next_addr >=3D end)
> +                                       break;
> +                               pte +=3D (next_addr - addr) / PAGE_SIZE;
> +                               addr =3D next_addr;
> +                       }
> +
> +                       if (!start_pte) {
> +                               start_pte =3D pte =3D pte_offset_map_lock=
(
> +                                       mm, pmd, addr, &ptl);
> +                               if (!start_pte)
> +                                       break;
> +                               arch_enter_lazy_mmu_mode();
> +                       }
> +
> +next_folio:
>                         pte--;
>                         addr -=3D PAGE_SIZE;
>                         continue;
> --
> 2.33.1
>
>

Thanks
Barry

