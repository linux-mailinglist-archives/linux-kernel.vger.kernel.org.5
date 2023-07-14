Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6296753040
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234919AbjGND6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGND6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:58:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71DB1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:58:09 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so7377a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689307088; x=1691899088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=df1bb1jAvs2jRSd0UV5vKM8Tkxi1X2alJm5noRhbC9U=;
        b=fKweP6JlCmBRRQlBVKEkzMhU187HIhLaIWvEPumx6/X/MkiwIpNifZpuIqq0CNmVyf
         cvorRJzo0OEqgF0ya+Lq4smI04/pV43nP5JSzfBcA0YeFu/AeP7F5N3Xh95QX4On81oD
         e1+4prrRYiCmTQRc29M7v7aLUYukZ/fmVOCaIHap9Mc5cIr6jMsWeaTH/p+UnRq/3D1I
         curzSZBZWkTuRxCO6gX8c3fpWLFby5gy/vF/CjkIeTOVEakW/Ij0RfPMU+oWlAWBHkx4
         /lvBTprMY2ygmsu3yPpSlIBU5Jasujfa47E6o353Q+q4L8mK4vqC/ropZ4x3IQxr0sRh
         MLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307088; x=1691899088;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=df1bb1jAvs2jRSd0UV5vKM8Tkxi1X2alJm5noRhbC9U=;
        b=e4wyP16PPEuS9t2H05tP4avCQ9HKy97lWVybHomkxDo8CL1v7he7ohtzEjvnsWf0T8
         cmIZV4mAn6fwe16HkPprZpSUAYPFMbsZh1Da0p/HEwXeHyDTuyYHTyL/dDTUIxAoyOxq
         I0r21ftQSVI2jGBqRLYZ6SHSWrQOaEDn/BbRuu6nuGb04NdCR7RMDLR90S5oWl96gilm
         JbHpUzMYlmYAlRGd6SRJPV0koiaC/7XLBcmZLfB4clMhhHLEAfh1BqENWe+KLx5iLAHf
         jDhqHOVRHg9qcXiyPr1NNZobqt2LFOq88ZlxxlPeop+P7XsGTsjNXzf7FRRmTEZcI1Rx
         ySJw==
X-Gm-Message-State: ABy/qLbP0AOGYyAg9F2qE5VWc31p0VpLu6rv7GoMSAqDz1Ont1Vawexo
        yk8ulnphecMbAvpGMozT0JfCJPK0oM8d/WTHiMcjqQ==
X-Google-Smtp-Source: APBJJlG9165PCDdodTrBV39p3BgvpNMQjUYPYsowWCQAF1lsWkwBo1vNccxUchLd6a8G6ff2AmUCzGPmpz/Py83+w6Q=
X-Received: by 2002:a50:935d:0:b0:519:7d2:e256 with SMTP id
 n29-20020a50935d000000b0051907d2e256mr348835eda.0.1689307088289; Thu, 13 Jul
 2023 20:58:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230713150558.200545-1-fengwei.yin@intel.com>
In-Reply-To: <20230713150558.200545-1-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Thu, 13 Jul 2023 21:57:29 -0600
Message-ID: <CAOUHufZBoV-ujMF3v60Sj4bARb5vRg7cpcRsqTiKHB4CKZc_fw@mail.gmail.com>
Subject: Re: [RFC PATCH] madvise: make madvise_cold_or_pageout_pte_range()
 support large folio
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        ryan.roberts@arm.com, shy828301@gmail.com
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

On Thu, Jul 13, 2023 at 9:06=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Current madvise_cold_or_pageout_pte_range() has two problems for
> large folio support:
>   - Using folio_mapcount() with large folio prevent large folio from
>     picking up.
>   - If large folio is in the range requested, shouldn't split it
>     in madvise_cold_or_pageout_pte_range().
>
> Fix them by:
>   - Use folio_estimated_sharers() with large folio
>   - If large folio is in the range requested, don't split it. Leave
>     to page reclaim phase.
>
> For large folio cross boundaries of requested range, skip it if it's
> page cache. Try to split it if it's anonymous folio. If splitting
> fails, skip it.
>
> The main reason to call folio_referenced() is to clear the yong of
> conresponding PTEs. So in page reclaim phase, there is good chance
> the folio can be reclaimed.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
> This patch is based on mlock large folio support rfc2 as it depends
> on the folio_in_range() added by that patchset
>
> Also folio_op_size() can be unitfied with get_folio_mlock_step().
>
> Testing done:
>   - kselftest: No new regression introduced.
>
>  mm/madvise.c | 133 ++++++++++++++++++++++++++++++++-------------------
>  1 file changed, 84 insertions(+), 49 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 38382a5d1e393..5748cf098235d 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -31,6 +31,7 @@
>  #include <linux/swapops.h>
>  #include <linux/shmem_fs.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/kernel.h>
>
>  #include <asm/tlb.h>
>
> @@ -339,6 +340,35 @@ static inline bool can_do_file_pageout(struct vm_are=
a_struct *vma)
>                file_permission(vma->vm_file, MAY_WRITE) =3D=3D 0;
>  }
>
> +static inline bool skip_current_entry(struct folio *folio, bool pageout_=
anon)
> +{
> +       if (!folio)
> +               return true;
> +
> +       if (folio_is_zone_device(folio))
> +               return true;
> +
> +       if (!folio_test_lru(folio))
> +               return true;
> +
> +       if (pageout_anon && !folio_test_anon(folio))
> +               return true;
> +
> +       if (folio_test_unevictable(folio))
> +               return true;
> +
> +       return false;
> +}
> +
> +static inline unsigned int folio_op_size(struct folio *folio, pte_t pte,
> +               unsigned long addr, unsigned long end)
> +{
> +       unsigned int nr;
> +
> +       nr =3D folio_pfn(folio) + folio_nr_pages(folio) - pte_pfn(pte);
> +       return min_t(unsigned int, nr, (end - addr) >> PAGE_SHIFT);
> +}
> +
>  static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>                                 unsigned long addr, unsigned long end,
>                                 struct mm_walk *walk)
> @@ -353,6 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>         struct folio *folio =3D NULL;
>         LIST_HEAD(folio_list);
>         bool pageout_anon_only_filter;
> +       unsigned long start =3D addr;
>
>         if (fatal_signal_pending(current))
>                 return -EINTR;
> @@ -383,7 +414,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 folio =3D pfn_folio(pmd_pfn(orig_pmd));
>
>                 /* Do not interfere with other mappings of this folio */
> -               if (folio_mapcount(folio) !=3D 1)
> +               if (folio_estimated_sharers(folio) !=3D 1)
>                         goto huge_unlock;
>
>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
> @@ -442,78 +473,60 @@ static int madvise_cold_or_pageout_pte_range(pmd_t =
*pmd,
>         for (; addr < end; pte++, addr +=3D PAGE_SIZE) {
>                 ptent =3D ptep_get(pte);
>
> -               if (pte_none(ptent))
> -                       continue;
> -
> -               if (!pte_present(ptent))
> +               if (pte_none(ptent) || !pte_present(ptent))
>                         continue;
>
>                 folio =3D vm_normal_folio(vma, addr, ptent);
> -               if (!folio || folio_is_zone_device(folio))
> +               if (skip_current_entry(folio, pageout_anon_only_filter))
>                         continue;
>
>                 /*
> -                * Creating a THP page is expensive so split it only if w=
e
> -                * are sure it's worth. Split it if we are only owner.
> +                * Split large folio if it's anonymous and cross the
> +                * boundaries of request range.
>                  */
>                 if (folio_test_large(folio)) {
> -                       int err;
> +                       int err, step;
> +
> +                       if (folio_estimated_sharers(folio) !=3D 1)
> +                               continue;
> +
> +                       if (folio_in_range(folio, vma, start, end))
> +                               goto pageout_cold_folio;
>
> -                       if (folio_mapcount(folio) !=3D 1)
> -                               break;
> -                       if (pageout_anon_only_filter && !folio_test_anon(=
folio))
> -                               break;
> -                       if (!folio_trylock(folio))
> -                               break;
>                         folio_get(folio);
> +                       step =3D folio_op_size(folio, ptent, addr, end);
> +                       if (!folio_test_anon(folio) || !folio_trylock(fol=
io)) {
> +                               folio_put(folio);
> +                               goto next_folio;
> +                       }
> +
>                         arch_leave_lazy_mmu_mode();
>                         pte_unmap_unlock(start_pte, ptl);
>                         start_pte =3D NULL;
>                         err =3D split_folio(folio);
>                         folio_unlock(folio);
>                         folio_put(folio);
> -                       if (err)
> -                               break;
> +
>                         start_pte =3D pte =3D
>                                 pte_offset_map_lock(mm, pmd, addr, &ptl);
>                         if (!start_pte)
>                                 break;
>                         arch_enter_lazy_mmu_mode();
> -                       pte--;
> -                       addr -=3D PAGE_SIZE;
> -                       continue;
> -               }
>
> -               /*
> -                * Do not interfere with other mappings of this folio and
> -                * non-LRU folio.
> -                */
> -               if (!folio_test_lru(folio) || folio_mapcount(folio) !=3D =
1)
> +                       /* Skip the folio if split fails */
> +                       if (!err)
> +                               step =3D 0;
> +next_folio:
> +                       pte +=3D step - 1;
> +                       addr +=3D (step - 1) << PAGE_SHIFT;
>                         continue;
> +               }
>
> -               if (pageout_anon_only_filter && !folio_test_anon(folio))
> +               /* Do not interfere with other mappings of this folio */
> +               if (folio_mapcount(folio) !=3D 1)
>                         continue;
>
> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> -
> -               if (pte_young(ptent)) {
> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> -                                                       tlb->fullmm);
> -                       ptent =3D pte_mkold(ptent);
> -                       set_pte_at(mm, addr, pte, ptent);
> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> -               }
> -
> -               /*
> -                * We are deactivating a folio for accelerating reclaimin=
g.
> -                * VM couldn't reclaim the folio unless we clear PG_young=
.
> -                * As a side effect, it makes confuse idle-page tracking
> -                * because they will miss recent referenced history.
> -                */
> -               folio_clear_referenced(folio);
> -               folio_test_clear_young(folio);
> -               if (folio_test_active(folio))
> -                       folio_set_workingset(folio);
> +pageout_cold_folio:
>                 if (pageout) {
>                         if (folio_isolate_lru(folio)) {
>                                 if (folio_test_unevictable(folio))
> @@ -529,8 +542,30 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *=
pmd,
>                 arch_leave_lazy_mmu_mode();
>                 pte_unmap_unlock(start_pte, ptl);
>         }
> -       if (pageout)
> -               reclaim_pages(&folio_list);
> +
> +       if (pageout) {
> +               LIST_HEAD(reclaim_list);
> +
> +               while (!list_empty(&folio_list)) {
> +                       int refs;
> +                       unsigned long flags;
> +                       struct mem_cgroup *memcg =3D folio_memcg(folio);
> +
> +                       folio =3D lru_to_folio(&folio_list);
> +                       list_del(&folio->lru);
> +
> +                       refs =3D folio_referenced(folio, 0, memcg, &flags=
);
> +
> +                       if ((flags & VM_LOCKED) || (refs =3D=3D -1)) {
> +                               folio_putback_lru(folio);
> +                               continue;
> +                       }
> +
> +                       folio_test_clear_referenced(folio);
> +                       list_add(&folio->lru, &reclaim_list);
> +               }
> +               reclaim_pages(&reclaim_list);
> +       }

i overlooked the chunk above -- it's unnecessary: after we split the
large folio (and splice the base folios onto the same LRU list), we
continue at the position of the first base folio because of:

  pte--;
  addr -=3D PAGE_SIZE;
  continue;

And then we do pte_mkold(), which takes care of the A-bit.
