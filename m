Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF26771974
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 07:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjHGFYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 01:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjHGFYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 01:24:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A2EF170B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 22:24:46 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-40c72caec5cso329571cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Aug 2023 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691385885; x=1691990685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/kSq9xcOo1BBr2m7q9JhO/3H55Aq03K2ZqsUKR1E/gQ=;
        b=yfZfF2Dsl5/ihnoOiwk2qA6Q0RxUu4/8uwXaz+lyogsMNgmMYKm29MgvOXtTR6Mvq5
         Pfa0//Do4C/BviHl5b2YKaoxZJyD4C0p4y2eLQNJYUWlwG9FfIp2kSoLZD5NrFUXrKpw
         3AsLEN3yAkTxAQqfXbmXkB9KnwjTC6bWysgjlgCsz19/5rK6IWFCh/iQSCTgvRoOrquz
         9cBHkX0wfYG4MQ6ikRwCITOFBoDyQ24xpUbpRv48yOVvqW4AyxAF/YDgLXoHlGLz4st9
         6+doB3697jMHvp0QuecvPnZ19aK9P8MaU4kShOFbdt/xIKU1gTee5wwfHTG87Nogw1ir
         xcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691385885; x=1691990685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/kSq9xcOo1BBr2m7q9JhO/3H55Aq03K2ZqsUKR1E/gQ=;
        b=VWkjL+p8OWvSWs6h0bXIPNtvP4IHtlcns8+Iv3P9AdhULcN8zc3PXkZlWpqsBmowxU
         t/9krblRUrld1qT/9tlqGCffdCvIvh+iQlfgGwFXVGpfxrUaARrx8tNiVhaBon4qd0Jb
         lOScbO+DzPzwdVMEotm+tUxiRS9+jyOk+CmF3zxg9JRmtDsfYS6o3FzO7p42FbK+zVnU
         broEQFQA+sodFgt28r4Z3KCK9/maesc/NGKjvIz76IIK1ryG+O7m+5zQ3qhqzZ6c/P+a
         AFJjoxsnuQ7vmMAUMJw5/U9M/Pwb8hj4bXEAfwG3QE+bbQn9bYHoRbGOGKlfPs4BPRkm
         cwIg==
X-Gm-Message-State: AOJu0YyubX99pkyya3z+xT3aFxTbpaIkNWOjO0wZ3xWUBVdHsY82700g
        D3EeV50uiZa04ca9vlJyxi2lgtzlllsKRu7QJZFeYA==
X-Google-Smtp-Source: AGHT+IHE4PMHH4FZemX2qPyeWntEc8HaNqjc/Ov4LZlU8uANNSlaPkMqWUjJYu3BdP5xUL1TlNPaoZbZ7nQV3g4khWY=
X-Received: by 2002:a05:622a:81:b0:3f0:af20:1a37 with SMTP id
 o1-20020a05622a008100b003f0af201a37mr392332qtw.15.1691385885361; Sun, 06 Aug
 2023 22:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com> <20230726095146.2826796-3-ryan.roberts@arm.com>
In-Reply-To: <20230726095146.2826796-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Sun, 6 Aug 2023 23:24:08 -0600
Message-ID: <CAOUHufbdbeFhpXw_w4z62=PwCjCa-yuvE6Brhpd3AOxiswa_2Q@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] mm: LARGE_ANON_FOLIO for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Wed, Jul 26, 2023 at 3:52=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com>=
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
> When enabled, the folio order is determined as such: For a vma, process
> or system that has explicitly disabled THP, we continue to allocate
> order-0. THP is most likely disabled to avoid any possible internal
> fragmentation so we honour that request.
>
> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> that have not explicitly opted-in to use transparent hugepages (e.g.
> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> arch_wants_pte_order() is limited to 64K (or PAGE_SIZE, whichever is
> bigger). This allows for a performance boost without requiring any
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
>  mm/memory.c             | 166 ++++++++++++++++++++++++++++++++++++----
>  3 files changed, 172 insertions(+), 17 deletions(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5063b482e34f..2a1d83775837 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -313,6 +313,19 @@ static inline bool arch_has_hw_pte_young(void)
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
> index 09130434e30d..fa61ea160447 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -1238,4 +1238,14 @@ config LOCK_MM_AND_FIND_VMA
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
> index 01f39e8144ef..64c3f242c49a 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4050,6 +4050,127 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> +        * If THP is explicitly disabled for either the vma, the process =
or the
> +        * system, then this is very likely intended to limit internal
> +        * fragmentation; in this case, don't attempt to allocate a large
> +        * anonymous folio.
> +        *
> +        * Else, if the vma is eligible for thp, allocate a large folio o=
f the
> +        * size preferred by the arch. Or if the arch requested a very sm=
all
> +        * size or didn't request a size, then use PAGE_ALLOC_COSTLY_ORDE=
R,
> +        * which still meets the arch's requirements but means we still t=
ake
> +        * advantage of SW optimizations (e.g. fewer page faults).
> +        *
> +        * Finally if thp is enabled but the vma isn't eligible, take the
> +        * arch-preferred size and limit it to ANON_FOLIO_MAX_ORDER_UNHIN=
TED.
> +        * This ensures workloads that have not explicitly opted-in take =
benefit
> +        * while capping the potential for internal fragmentation.
> +        */
> +
> +       if ((vma->vm_flags & VM_NOHUGEPAGE) ||
> +           test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags) ||
> +           !hugepage_flags_enabled())
> +               order =3D 0;
> +       else {
> +               order =3D max(arch_wants_pte_order(), PAGE_ALLOC_COSTLY_O=
RDER);
> +
> +               if (!hugepage_vma_check(vma, vma->vm_flags, false, true, =
true))
> +                       order =3D min(order, ANON_FOLIO_MAX_ORDER_UNHINTE=
D);
> +       }
> +
> +       return order;
> +}
> +
> +static int alloc_anon_folio(struct vm_fault *vmf, struct folio **folio)
> +{
> +       int i;
> +       gfp_t gfp;
> +       pte_t *pte;
> +       unsigned long addr;
> +       struct vm_area_struct *vma =3D vmf->vma;
> +       int prefer =3D anon_folio_order(vma);
> +       int orders[] =3D {
> +               prefer,
> +               prefer > PAGE_ALLOC_COSTLY_ORDER ? PAGE_ALLOC_COSTLY_ORDE=
R : 0,
> +               0,
> +       };
> +
> +       *folio =3D NULL;
> +
> +       if (vmf_orig_pte_uffd_wp(vmf))
> +               goto fallback;

Per the discussion, we need to check hugepage_vma_check() for
correctness of VM LM. I'd just check it here and fall back to order 0
if that helper returns false.
