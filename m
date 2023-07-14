Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF13B754054
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 19:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjGNRS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 13:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236325AbjGNRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 13:18:21 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC620212B
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:18:17 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-403b622101bso11501cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 10:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689355097; x=1691947097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6qhY2FvgHNaLAJ232x1PvEWhcEAV6w0lGit60+MxsMU=;
        b=zxfjXqI2C02PrOiODwUaVgbgQds1zV1jCLyuiWILhuIG+KcurXQWBv8VgG8LzLKw9X
         CV3Th4E6GPE0nC/pvUMtbu29BsrQhXBr2Aj8ID7GnH+N34TN9d59upN5nEIT0NzK5CUc
         G3UuFdeY6s3kKHMS9uMvSGawaWx2RH+eehYAik71dPXgeaHxgF0SLeF1jgpEVmaeWfFW
         vytNK47qkyu5F6taSwuRfut/IuyrmTqDxa4a8XE1pOLXQaiceyea3iGyk1e00DMgSK5j
         Iqt8lx4qFnGeLBKRXWpmW4aTYcVuLW4aS9s9RTHMYpGChyDcqmVFxvzykVeNh0PV8hoG
         Viig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689355097; x=1691947097;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6qhY2FvgHNaLAJ232x1PvEWhcEAV6w0lGit60+MxsMU=;
        b=Ar0S+dpgreyA36HXxQcK78h49MhywsaVzoEQJEN8h2yUR52CXhUADaYRZSXpfBaPRc
         FWrERJXaW8UMN27xC4OnBKs1DVxwrVyYO1kV2MubX30CzaNTdnfbfk65i6AKhV4ImaG+
         zXef8xISwNUJZYZiwjKNrWpIhKxGXVJYiCHfTbvrTRGavPaNgpYHiIrheturxuQCssh+
         s6/nFboRrke8VQSd6zkWphAYmcaDz0iCP+j2qLf+3R1Bb7yvGDgrBrxPox3PBpXvZe8C
         2Hhqi6xrtXxnKoSbiOCuTwoPk4qe2qV+zuXAEU7DVJtg7oGFgh6tAv6j3JBz+e3kv/il
         JYog==
X-Gm-Message-State: ABy/qLY8xZgTBMJfGc0ByvDbGd0A2wO6LA4jVmvBWyFUdKXwDkfw3tmm
        2rqOSbYE2fUAlPghabfTbw4TiGQTnOXXyJ5shofKsA==
X-Google-Smtp-Source: APBJJlEmoD/7zJ9C9z9y/NZL8oag7SA+vmlRJZYvA8fwArdzLKnWj57dBRv4ErekiZZsO6s9FNj+kgwNh9byHjNW0QE=
X-Received: by 2002:ac8:7fd6:0:b0:3f9:ab2c:88b9 with SMTP id
 b22-20020ac87fd6000000b003f9ab2c88b9mr838373qtk.25.1689355096696; Fri, 14 Jul
 2023 10:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230714160407.4142030-1-ryan.roberts@arm.com> <20230714161733.4144503-3-ryan.roberts@arm.com>
In-Reply-To: <20230714161733.4144503-3-ryan.roberts@arm.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 14 Jul 2023 11:17:40 -0600
Message-ID: <CAOUHufacQ8Vx9WQ3BVjGGWKGhcRkL7u79UMX=O7oePDwZ0iNxw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] mm: FLEXIBLE_THP for improved performance
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 10:17=E2=80=AFAM Ryan Roberts <ryan.roberts@arm.com=
> wrote:
>
> Introduce FLEXIBLE_THP feature, which allows anonymous memory to be
> allocated in large folios of a determined order. All pages of the large
> folio are pte-mapped during the same page fault, significantly reducing
> the number of page faults. The number of per-page operations (e.g. ref
> counting, rmap management lru list management) are also significantly
> reduced since those ops now become per-folio.
>
> The new behaviour is hidden behind the new FLEXIBLE_THP Kconfig, which
> defaults to disabled for now; The long term aim is for this to defaut to
> enabled, but there are some risks around internal fragmentation that
> need to be better understood first.
>
> When enabled, the folio order is determined as such: For a vma, process
> or system that has explicitly disabled THP, we continue to allocate
> order-0. THP is most likely disabled to avoid any possible internal
> fragmentation so we honour that request.
>
> Otherwise, the return value of arch_wants_pte_order() is used. For vmas
> that have not explicitly opted-in to use transparent hugepages (e.g.
> where thp=3Dmadvise and the vma does not have MADV_HUGEPAGE), then
> arch_wants_pte_order() is limited by the new cmdline parameter,
> `flexthp_unhinted_max`. This allows for a performance boost without
> requiring any explicit opt-in from the workload while allowing the
> sysadmin to tune between performance and internal fragmentation.
>
> arch_wants_pte_order() can be overridden by the architecture if desired.
> Some architectures (e.g. arm64) can coalsece TLB entries if a contiguous
> set of ptes map physically contigious, naturally aligned memory, so this
> mechanism allows the architecture to optimize as required.
>
> If the preferred order can't be used (e.g. because the folio would
> breach the bounds of the vma, or because ptes in the region are already
> mapped) then we fall back to a suitable lower order; first
> PAGE_ALLOC_COSTLY_ORDER, then order-0.
>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  10 +
>  mm/Kconfig                                    |  10 +
>  mm/memory.c                                   | 187 ++++++++++++++++--
>  3 files changed, 190 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index a1457995fd41..405d624e2191 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -1497,6 +1497,16 @@
>                         See Documentation/admin-guide/sysctl/net.rst for
>                         fb_tunnels_only_for_init_ns
>
> +       flexthp_unhinted_max=3D
> +                       [KNL] Requires CONFIG_FLEXIBLE_THP enabled. The m=
aximum
> +                       folio size that will be allocated for an anonymou=
s vma
> +                       that has neither explicitly opted in nor out of u=
sing
> +                       transparent hugepages. The size must be a power-o=
f-2 in
> +                       the range [PAGE_SIZE, PMD_SIZE). A larger size im=
proves
> +                       performance by reducing page faults, while a smal=
ler
> +                       size reduces internal fragmentation. Default: max=
(64K,
> +                       PAGE_SIZE). Format: size[KMG].
> +

Let's split this parameter into a separate patch.

And I'm going to ask many questions about it (I can live with a sysctl
parameter but this boot parameter is unacceptable to me).

> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..e8bc729efb9d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4050,6 +4050,148 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
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
> +#ifdef CONFIG_FLEXIBLE_THP
> +static int flexthp_unhinted_max_order =3D
> +               ilog2(SZ_64K > PAGE_SIZE ? SZ_64K : PAGE_SIZE) - PAGE_SHI=
FT;
> +
> +static int __init parse_flexthp_unhinted_max(char *s)
> +{
> +       unsigned long long size =3D memparse(s, NULL);
> +
> +       if (!is_power_of_2(size) || size < PAGE_SIZE || size > PMD_SIZE) =
{
> +               pr_warn("flexthp: flexthp_unhinted_max=3D%s must be power=
-of-2 between PAGE_SIZE (%lu) and PMD_SIZE (%lu), ignoring\n",
> +                       s, PAGE_SIZE, PMD_SIZE);
> +               return 1;
> +       }
> +
> +       flexthp_unhinted_max_order =3D ilog2(size) - PAGE_SHIFT;
> +
> +       /* THP machinery requires at least 3 struct pages for meta data. =
*/
> +       if (flexthp_unhinted_max_order =3D=3D 1)
> +               flexthp_unhinted_max_order--;
> +
> +       return 1;
> +}
> +
> +__setup("flexthp_unhinted_max=3D", parse_flexthp_unhinted_max);
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
> +        * arch-preferred size and limit it to the flexthp_unhinted_max c=
mdline
> +        * parameter. This allows a sysadmin to tune performance vs inter=
nal
> +        * fragmentation.
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
> +                       order =3D min(order, flexthp_unhinted_max_order);
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
> +
> +       for (i =3D 0; orders[i]; i++) {
> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i])=
;
> +               if (addr >=3D vma->vm_start &&
> +                   addr + (PAGE_SIZE << orders[i]) <=3D vma->vm_end)
> +                       break;
> +       }
> +
> +       if (!orders[i])
> +               goto fallback;
> +
> +       pte =3D pte_offset_map(vmf->pmd, vmf->address & PMD_MASK);
> +       if (!pte)
> +               return -EAGAIN;

It would be a bug if this happens. So probably -EINVAL?

> +
> +       for (; orders[i]; i++) {
> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i])=
;
> +               vmf->pte =3D pte + pte_index(addr);
> +               if (!vmf_pte_range_changed(vmf, 1 << orders[i]))
> +                       break;
> +       }
> +
> +       vmf->pte =3D NULL;
> +       pte_unmap(pte);
> +
> +       gfp =3D vma_thp_gfp_mask(vma);
> +
> +       for (; orders[i]; i++) {
> +               addr =3D ALIGN_DOWN(vmf->address, PAGE_SIZE << orders[i])=
;
> +               *folio =3D vma_alloc_folio(gfp, orders[i], vma, addr, tru=
e);
> +               if (*folio) {
> +                       clear_huge_page(&(*folio)->page, addr, 1 << order=
s[i]);
> +                       return 0;
> +               }
> +       }
> +
> +fallback:
> +       *folio =3D vma_alloc_zeroed_movable_folio(vma, vmf->address);
> +       return *folio ? 0 : -ENOMEM;
> +}
> +#else
> +static inline int alloc_anon_folio(struct vm_fault *vmf, struct folio **=
folio)

Drop "inline" (it doesn't do anything in .c).

The rest looks good to me.
