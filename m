Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 186DF76A8D6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 08:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjHAGTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 02:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjHAGS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 02:18:58 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680F7172A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:18:57 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-407db3e9669so139301cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 23:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690870736; x=1691475536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XnQmdBO+sQiEeREpmllXHSrex2CdPULNl4Hy44lzRY0=;
        b=aq58tPJR/4zjaqO6D9oGuMVuamG3dpBItK5mCYBPT7uiNwoUi3qknB6/rJcp0rrskM
         Z1yjgmcTJ/qGVkueD3wRNpvV8ior5hPPUl5ONRyUc82pQzCK8qzyt0l+viqOMJoCmL7n
         MzplLdf4SAIqdRFNaaNqhGU5DrN3dOYOdw3YyG/3LTt5nN1bVz9dy1jOc4jdhOrC+xXD
         GB3nealCBvgkV9wPLbHujAQCU0vQ8H+LqAxYMmruKiQNm70TiN1flGo2j3SK9fotckdn
         6UXOEN/z6Ju+gwEGmy0Wcm7HbaGjiPqxoRN4grxpiK0FCFwLqOt045wpNbUZU8IAfQ4m
         Um8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690870736; x=1691475536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XnQmdBO+sQiEeREpmllXHSrex2CdPULNl4Hy44lzRY0=;
        b=AJzbQ1l9Qqs1H1bSSM8PB88SfEJOiStNwc9xQu/xZYAPZ4mJMdrE/4T/XQeVBHB/Q6
         6xyAe9w5A7JSFfAMUv1//GAEh8pa5dG6fDXt5hAMRiFgpsscRYSU860KerbqHAZbjog7
         TqmxJL0KBph2TdlCxEqdLfbTrLpfNZYONS2Wpkdl1YaYk7K9BvwgLbbBZ8rvx1wv9Bom
         IyBpfMyWpMMylVEjSUSo9YtOiSp0j4q68c6R/0Oc7v2csIeEx93OcgZ/p6jwSmQBtnjo
         3MgyHmJjJqZWw/xXSle9tNDCcegwIKZ8fpZNPhlNoKaFsGPEc+Lit6RD89yPM4E/Jb+o
         IppQ==
X-Gm-Message-State: ABy/qLaeoXgvYzuUieqVwJ/Nf30PnNRcsO3MxiRAJsVmJXYdsomLdWvx
        n5J4tjFM+jeDgjrWiJKIlM7xDXWmj3O1Ad1j//zsiA==
X-Google-Smtp-Source: APBJJlHSDttDk2v1YrLbv3qbnqqDCXyKJI9nRdWol4jD2Hsajqgxf64VVzSnMhgwT4nxy72Df+xlX3oc5pNE30WzMNM=
X-Received: by 2002:a05:622a:1a8a:b0:3f9:a770:7279 with SMTP id
 s10-20020a05622a1a8a00b003f9a7707279mr554036qtc.9.1690870736427; Mon, 31 Jul
 2023 23:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230726095146.2826796-1-ryan.roberts@arm.com> <20230726095146.2826796-3-ryan.roberts@arm.com>
In-Reply-To: <20230726095146.2826796-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 1 Aug 2023 00:18:20 -0600
Message-ID: <CAOUHufZDt4i=YLpQCGTgsya+kfzDCJvYCE+-cXf0PUmFVpL9zg@mail.gmail.com>
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
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

I think we need to s/vmf_orig_pte_uffd_wp/userfaultfd_armed/ here;
otherwise UFFD would miss VM_UFFD_MISSING/MINOR.
