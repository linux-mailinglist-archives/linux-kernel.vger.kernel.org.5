Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C75777EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 19:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjHJRCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 13:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233997AbjHJRCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 13:02:04 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2213C268E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:02:04 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso14981cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 10:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691686923; x=1692291723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VgJtiDLaOXreWlpDuZr8GRrlR/LiYN/zYmNHHchv/Qw=;
        b=og3puj3CafyyWKCAiIg9b89DciXir2SQFxLRgBKas7ojE9Q/T9oQxRgV+a95R+3DYR
         sr5rNijrJQRvnfC1uOSkn0PMbZ1WORGkXmY+zEaCLE+Ad59+e8kvO0jEoKUclQBbaSc+
         VmN/Wm+G6zwORTMsStCElnKq+GrwAE7zWaZrlb95zaw8VDwqGOj6YP47T73/KPnPwNma
         yi72fQIZ7k5ypE5t9IOnwoxWzlqPCUkd+5QE6bRhUJRKFqRq2Li/R9mY61VxBLqkuHt9
         XRoFw0LGIwbuNMilIBX4IiOKLa7a7mc3U+//yaPoF4/m2rbl01imFVB4+HtKx2RIACNl
         UMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691686923; x=1692291723;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VgJtiDLaOXreWlpDuZr8GRrlR/LiYN/zYmNHHchv/Qw=;
        b=lOBPDC9H5zw8xePnQhJdD7ie0W9uyhByMwm2MqOhBukmOI3h8xqJxfM/yPEPOHFTfZ
         4iS+0ndsvLSAj3IQYk5J1Ye/w8jn6twCUwNBjm1SmZTXOXVm2u7ZoNQDUR0ZH7GnuKAX
         qPY2Ryd15/oneQQd9tmmvWH0+bzrCVTZRkX6D/DEeH7uIcbhALlZilMm1h52/NdFBZH8
         8AsUa+gzeLmHt8UG0MEhZOeG7bPUXuOjGCT6jJTGO6CFhio294Mk1ex+0GVjjgy6jiPI
         8LwwUFnXfK0eU3H2VNe1adzzvXqjWQ4rjXik/1e4wu29jOae1ND68Kt+IwhboM2HRtAB
         X4Vg==
X-Gm-Message-State: AOJu0YzC5xKUBnO+TRHRFAOLQ4jTrsVqLwwzLTNBu+d+penJH6AqmmPP
        CCmsUQnt0qyLiFVlNbNaJi8Zdii+N7TkDJc5EG4UcQ==
X-Google-Smtp-Source: AGHT+IFV6tfaj0UQ8ATzcITh54+A+d7nOCEmyXkaBukUcN1DOUffRbHtEL+OKi3cV6jmq7AY4LRd00Y/QQNAxU6IzHg=
X-Received: by 2002:ac8:5a8c:0:b0:3f8:5b2:aef0 with SMTP id
 c12-20020ac85a8c000000b003f805b2aef0mr6997qtc.24.1691686923043; Thu, 10 Aug
 2023 10:02:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230810142942.3169679-1-ryan.roberts@arm.com> <20230810142942.3169679-4-ryan.roberts@arm.com>
In-Reply-To: <20230810142942.3169679-4-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 10 Aug 2023 11:01:26 -0600
Message-ID: <CAOUHufbUGwc2XvZOBmTCzMsOHxP-eLB60EdysKYzrkRMScOyMg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 8:30=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
 wrote:
>
> Introduce LARGE_ANON_FOLIO feature, which allows anonymous memory to be
> allocated in large folios of a determined order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
>
> The new behaviour is hidden behind the new LARGE_ANON_FOLIO Kconfig,
> which defaults to disabled for now; The long term aim is for this to
> defaut to enabled, but there are some risks around internal
> fragmentation that need to be better understood first.
>
> Large anonymous folio (LAF) allocation is integrated with the existing
> (PMD-order) THP and single (S) page allocation according to this policy,
> where fallback (>) is performed for various reasons, such as the
> proposed folio order not fitting within the bounds of the VMA, etc:
>
>                 | prctl=3Ddis | prctl=3Dena   | prctl=3Dena     | prctl=
=3Dena
>                 | sysfs=3DX   | sysfs=3Dnever | sysfs=3Dmadvise | sysfs=
=3Dalways
> ----------------|-----------|-------------|---------------|-------------
> no hint         | S         | LAF>S       | LAF>S         | THP>LAF>S
> MADV_HUGEPAGE   | S         | LAF>S       | THP>LAF>S     | THP>LAF>S
> MADV_NOHUGEPAGE | S         | S           | S             | S
>
> This approach ensures that we don't violate existing hints to only
> allocate single pages - this is required for QEMU's VM live migration
> implementation to work correctly - while allowing us to use LAF
> independently of THP (when sysfs=3Dnever). This makes wide scale
> performance characterization simpler, while avoiding exposing any new
> ABI to user space.
>
> When using LAF for allocation, the folio order is determined as follows:
> The return value of arch_wants_pte_order() is used. For vmas that have
> not explicitly opted-in to use transparent hugepages (e.g. where
> sysfs=3Dmadvise and the vma does not have MADV_HUGEPAGE or sysfs=3Dnever)=
,
> then arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever
> is bigger). This allows for a performance boost without requiring any
> explicit opt-in from the workload while limitting internal
> fragmentation.
>
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order; first
> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>
> arch_wants_pte_order() can be overridden by the architecture if desired.
> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
> set of ptes map physically contigious, naturally aligned memory, so this
> mechanism allows the architecture to optimize as required.
>
> Here we add the default implementation of arch_wants_pte_order(), used
> when the architecture does not define it, which returns -1, implying
> that the HW has no preference. In this case, mm will choose it's own
> default order.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  include/linux/pgtable.h |  13 ++++
>  mm/Kconfig              |  10 +++
>  mm/memory.c             | 144 +++++++++++++++++++++++++++++++++++++---
>  3 files changed, 158 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 222a33b9600d..4b488cc66ddc 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -369,6 +369,19 @@ static inline bool arch_has_hw_pte_young(void)
>  }
>  #endif
>
> +#ifndef arch_wants_pte_order
> +/*
> + * Returns preferred folio order for pte-mapped memory. Must be in range=
 [0,
> + * PMD_SHIFT-PAGE_SHIFT) and must not be order-1 since THP requires larg=
e folios
> + * to be at least order-2. Negative value implies that the HW has no pre=
ference
> + * and mm will choose it's own default order.
> + */
> +static inline int arch_wants_pte_order(void)
> +{
> +       return -1;
> +}
> +#endif
> +
>  #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>                                        unsigned long address,
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 721dc88423c7..a1e28b8ddc24 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1243,4 +1243,14 @@ config LOCK_MM_AND_FIND_VMA
>
>  source "mm/damon/Kconfig"
>
> +config LARGE_ANON_FOLIO
> +       bool "Allocate large folios for anonymous memory"
> +       depends on TRANSPARENT_HUGEPAGE
> +       default n
> +       help
> +         Use large (bigger than order-0) folios to back anonymous memory=
 where
> +         possible, even for pte-mapped memory. This reduces the number o=
f page
> +         faults, as well as other per-page overheads to improve performa=
nce for
> +         many workloads.
> +
>  endmenu
> diff --git a/mm/memory.c b/mm/memory.c
> index d003076b218d..bbc7d4ce84f7 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4073,6 +4073,123 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>         return ret;
>  }
>
> +static bool vmf_pte_range_changed(struct vm_fault *vmf, int nr_pages)
> +{
> +       int i;
> +
> +       if (nr_pages =3D=3D 1)
> +               return vmf_pte_changed(vmf);
> +
> +       for (i =3D 0; i < nr_pages; i++) {
> +               if (!pte_none(ptep_get_lockless(vmf->pte + i)))
> +                       return true;
> +       }
> +
> +       return false;
> +}
> +
> +#ifdef CONFIG_LARGE_ANON_FOLIO
> +#define ANON_FOLIO_MAX_ORDER_UNHINTED \
> +               (ilog2(max_t(unsigned long, SZ_64K, PAGE_SIZE)) - PAGE_SH=
IFT)
> +
> +static int anon_folio_order(struct vm_area_struct *vma)
> +{
> +       int order;
> +
> +       /*
> +        * If the vma is eligible for thp, allocate a large folio of the =
size
> +        * preferred by the arch. Or if the arch requested a very small s=
ize or
> +        * didn't request a size, then use PAGE_ALLOC_COSTLY_ORDER, which=
 still
> +        * meets the arch's requirements but means we still take advantag=
e of SW
> +        * optimizations (e.g. fewer page faults).
> +        *
> +        * If the vma isn't eligible for thp, take the arch-preferred siz=
e and
> +        * limit it to ANON_FOLIO_MAX_ORDER_UNHINTED. This ensures worklo=
ads
> +        * that have not explicitly opted-in take benefit while capping t=
he
> +        * potential for internal fragmentation.
> +        */
> +
> +       order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_ORDER);
> +
> +       if (!hugepage_vma_check(vma, vma->vm_flags, false, true, true))
> +               order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTED);
> +
> +       return order;
> +}

I don't understand why we still want to keep ANON_FOLIO_MAX_ORDER_UNHINTED.
1. It's not used, since no archs at the moment implement
arch_wants_pte_order() that returns >64KB.
2. As far as I know, there is no plan for any arch to do so.
3. Again, it seems to me the rationale behind
ANON_FOLIO_MAX_ORDER_UNHINTED isn't convincing at all.

Can we introduce ANON_FOLIO_MAX_ORDER_UNHINTED  if/when needed please?

Also you made arch_wants_pte_order() return -1, and I acknowledged [1]:
  Thanks: -1 actually is better than 0 (what I suggested) for the
  obvious reason.

I thought we were on the same page, i.e., the "obvious reason" is that
h/w might prefer 0. But here you are not respecting 0. But then why
-1?

[1] https://lore.kernel.org/linux-mm/CAOUHufZ7HJZW8Srwatyudf=3DFbwTGQtyq4Dy=
L2SHwSg37N_Bo_A@mail.gmail.com/
