Return-Path: <linux-kernel+bounces-95030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2C0874864
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A85372824AC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C99201CD3C;
	Thu,  7 Mar 2024 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W+ZvPU1n"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4F31848
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709794851; cv=none; b=D+HrG4/6eEype4PNeBBzsYTGhq3HguRWhnE1khaMAPq8okOe6eA0Msjv8+MIOcTRMjS9fvkxjpjwQ0rZ1Ozb5iGQotSSI8/jhP6RmZaYH1Jrt/5OeTrAsms3mSb/GABf3Q2ZtWIpBXVdJW79gq7CGFWpjxD+7khbMCflfQvBzcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709794851; c=relaxed/simple;
	bh=4cMxip8xCIAMqPuUEDwo+KS/82ga36dt6e7yQ+QuQbs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQ8Rk8W/WqETgx24X/dmeyK8HafXdQs9qDB2AK2/bfoGdJlf+7NdYM2X2FgqdHph/5NyGo9erTU9pv7R6CBfnQTCYlyhIGmJHj7+Di1yDyu2qRBSnSvESY8maugOjGIMIdK03r3WXYwtJsJs1TO264b6KuuQzS1wve9u27oSmmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W+ZvPU1n; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-7db83d59c6eso240589241.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709794849; x=1710399649; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNTeL6IKZ5heYcCREvrxCiHE/iraw/jJfZmDBZOkIYI=;
        b=W+ZvPU1nmsQi2NoIhFtxBGLC0SBb+5BQlqIRUgdn+Fvj6jwukuM7Zoo9SPVZLF4CEm
         h31TNdTxfE+lAwtsV4M5meRhy4E8CiTyB9p8yPwp0UBVuHZnu0s7h2haRTmZPJacSY1F
         10uCfuaaUsMvK/JluE1pTK2QDX3A4YD6PwaQGBzyHnvqvd2i2x91p3BB0BWCSyp3InNJ
         IZHwsHYTxHnEh77w8sW05gefRQV2N34OF5gYq4tJl1YCN9NlXJt5gsCIxfl/Cog7sxyQ
         GNPWR4j2SsmFaeTWaSZ9IJsewiUjpuKjCp9xVw50ZIG7RvY4CChmFpRm+DnLqk3KGfNO
         oyBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709794849; x=1710399649;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNTeL6IKZ5heYcCREvrxCiHE/iraw/jJfZmDBZOkIYI=;
        b=HoO81WJ56LpUBvVqInHikc46lteC7LDdCYsRo7lV1qXu6AkQw6Eac3IyJ5Zeafn17x
         NBC63PUTSFV0PLQG5xJPGNhEAzFWYHG2RnWDRuXNzwyB+VR62FDa1WcMh6Jj1Bd8GNM7
         MbG4ZIKURjVMJ3eAVzgROhskhHYf0+wSMD0voD8eY5Rb8lRGRBc8zokdD42mucCeDUBq
         1S3DAuHvWSCh6EaS+kUNlB8XXBLMBhze4vMMW8t/H9slhUZ4Q2jKB6jq8b2awhfwh9bH
         7Q4qpMDCuyjZ9WYD1sCLq6hRXXYJkBk9tcYRzNheRYf2/f/dUXQwf1eHj18uLLDr4NEe
         NTpw==
X-Forwarded-Encrypted: i=1; AJvYcCX8zUVdINE4lgQIbjSOMAhkRZLkammLfs7VUslvm/DRCMd15PxRpifyCoMP94HpgJkIa766+dz/oFMTGMu7sWsVAN9EmPqdhmGrWSAR
X-Gm-Message-State: AOJu0YwmedikIk+xx3DLQFXMN0S+wAduayXhH/7S71wy3R8mljR9DiaL
	Nqdf8vJ3MQfvOYwiS7aGPu0/BtPTZR7swyB6FW+5ZiiKGx5ezn5kt/BK0w9mahhWh2EBxm+xAet
	SS1zFgrzhBi+Vz2MQYx6ZITmaJHw=
X-Google-Smtp-Source: AGHT+IGhiMcsWbBj8ZtwzznNYVEk1GIbrmzL/JeNsapt2JP3sPZIyrvOAlFwGihIFpebgJeuy7q6I/p+5fydqIPhjFc=
X-Received: by 2002:a05:6122:2908:b0:4d3:36b9:2c26 with SMTP id
 fm8-20020a056122290800b004d336b92c26mr7415048vkb.14.1709794849085; Wed, 06
 Mar 2024 23:00:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307061425.21013-1-ioworker0@gmail.com>
In-Reply-To: <20240307061425.21013-1-ioworker0@gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 7 Mar 2024 20:00:37 +1300
Message-ID: <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in madvise_free
To: Lance Yang <ioworker0@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, ryan.roberts@arm.com, 
	shy828301@gmail.com, david@redhat.com, mhocko@suse.com, fengwei.yin@intel.com, 
	xiehuan09@gmail.com, wangkefeng.wang@huawei.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 7:15=E2=80=AFPM Lance Yang <ioworker0@gmail.com> wro=
te:
>
> This patch optimizes lazyfreeing with PTE-mapped mTHP[1]
> (Inspired by David Hildenbrand[2]). We aim to avoid unnecessary
> folio splitting if the large folio is entirely within the given
> range.
>
> On an Intel I5 CPU, lazyfreeing a 1GiB VMA backed by
> PTE-mapped folios of the same size results in the following
> runtimes for madvise(MADV_FREE) in seconds (shorter is better):
>
> Folio Size |   Old    |   New    | Change
> ------------------------------------------
>       4KiB | 0.590251 | 0.590259 |    0%
>      16KiB | 2.990447 | 0.185655 |  -94%
>      32KiB | 2.547831 | 0.104870 |  -95%
>      64KiB | 2.457796 | 0.052812 |  -97%
>     128KiB | 2.281034 | 0.032777 |  -99%
>     256KiB | 2.230387 | 0.017496 |  -99%
>     512KiB | 2.189106 | 0.010781 |  -99%
>    1024KiB | 2.183949 | 0.007753 |  -99%
>    2048KiB | 0.002799 | 0.002804 |    0%
>
> [1] https://lkml.kernel.org/r/20231207161211.2374093-5-ryan.roberts@arm.c=
om
> [2] https://lore.kernel.org/linux-mm/20240214204435.167852-1-david@redhat=
com/
>
> Signed-off-by: Lance Yang <ioworker0@gmail.com>
> ---
> v1 -> v2:
>  * Update the performance numbers
>  * Update the changelog, suggested by Ryan Roberts
>  * Check the COW folio, suggested by Yin Fengwei
>  * Check if we are mapping all subpages, suggested by Barry Song,
>  David Hildenbrand, Ryan Roberts
>  * https://lore.kernel.org/linux-mm/20240225123215.86503-1-ioworker0@gmai=
l.com/
>
>  mm/madvise.c | 85 +++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 74 insertions(+), 11 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 44a498c94158..1437ac6eb25e 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -616,6 +616,20 @@ static long madvise_pageout(struct vm_area_struct *v=
ma,
>         return 0;
>  }
>
> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
> +                                                struct folio *folio, pte=
_t *start_pte)
> +{
> +       int nr_pages =3D folio_nr_pages(folio);
> +       fpb_t flags =3D FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
> +
> +       for (int i =3D 0; i < nr_pages; i++)
> +               if (page_mapcount(folio_page(folio, i)) !=3D 1)
> +                       return false;

we have moved to folio_estimated_sharers though it is not precise, so
we don't do
this check with lots of loops and depending on the subpage's mapcount.
BTW, do we need to rebase our work against David's changes[1]?
[1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.c=
om/

> +
> +       return nr_pages =3D=3D folio_pte_batch(folio, addr, start_pte,
> +                                        ptep_get(start_pte), nr_pages, f=
lags, NULL);
> +}
> +
>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>                                 unsigned long end, struct mm_walk *walk)
>
> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
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


I don't think we can skip all the PTEs for nr_pages, as some of them might =
be
pointing to other folios.

for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
and PTE16 will point to two different small folios. We can only skip when w=
e
are sure nr_pages =3D=3D folio_pte_batch() is sure.

> +
> +                       align =3D folio_nr_pages(folio) * PAGE_SIZE;
> +                       next_addr =3D ALIGN_DOWN(addr + align, align);
> +
> +                       /*
> +                        * If we mark only the subpages as lazyfree, or
> +                        * cannot mark the entire large folio as lazyfree=
,
> +                        * then just split it.
> +                        */
> +                       if (next_addr > end || next_addr - addr !=3D alig=
n ||
> +                           !can_mark_large_folio_lazyfree(addr, folio, p=
te))
> +                               goto split_large_folio;
> +
> +                       /*
> +                        * Avoid unnecessary folio splitting if the large
> +                        * folio is entirely within the given range.
> +                        */
> +                       folio_clear_dirty(folio);
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

Can we do this in batches? for a CONT-PTE mapped large folio, you are unfol=
ding
and folding again. It seems quite expensive.

> +                       }
> +                       folio_mark_lazyfree(folio);
> +                       goto next_folio;
> +
> +split_large_folio:
>                         folio_get(folio);
>                         arch_leave_lazy_mmu_mode();
>                         pte_unmap_unlock(start_pte, ptl);
> @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsig=
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
> +                        * If the large folio is locked or cannot be spli=
t,
> +                        * we just skip it.
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

Thanks
Barry

