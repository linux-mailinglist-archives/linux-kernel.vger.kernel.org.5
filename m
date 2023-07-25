Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB3D7609E2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjGYFzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbjGYFzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:55:50 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22623E69
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:55:49 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-40550136e54so200371cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690264548; x=1690869348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FwkbAPJqF6SFbvUb4Zwmp30ntoV+taVK4+0a5xpxgs=;
        b=iUQawueitW/YVgpkOCRy37Fh+JmzdrK2RUKnpEO/ip+zsydaSZAoW+RCjcv+qiNvT0
         AGb4ZDfbuXVj8fSXZBdDvKyGLVA+ChZfArMkP/byQeaukaRj0YP1Wgg4BKHb9aLpSI+n
         mveZA3Wj3BL6y6+51mEPuybvxZmp+WD4xFhlh+0eEjZCI3O8a2IWMRoAf7u9Lw6cHc3d
         OoU8uCP0U0M8Q8r3ZBEJTt/X3DRQ0SK/bpIqZ3WvODZLv+4QddlkpbATwAgqLk16KfSd
         omYmRYX0v08zImUIaLEkh1BYzFiRk6D5SsBiYbed6oxnjBvJKAmdUHzgTPHrD96+8cvV
         AquA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264548; x=1690869348;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FwkbAPJqF6SFbvUb4Zwmp30ntoV+taVK4+0a5xpxgs=;
        b=B6chFQLPW4MRyo1/9C/PFEyY5kBt7k3GUlNEYAXCVciVWjA79qbuf1UzHoHRTaDIPZ
         JAdWyzyqv/+yWdUnAJnOQ7vR4vt2m29gwY0gUVHs9sVoSc5TBjdjJAlcuiNzspHkWoc/
         ID7F0E5Eune6SBVqp+g/Q0gNkil9FVpTm64v2M5cf0QxYmX0bCkduihEtqBMtmgnoyte
         exuMRAaoznlzHg3sESdZWhd0UIJoaYlfXviLO4ZsA/kAvgKAqO7SZbewqGfo7/2sAjvE
         YRiI45BE3WUmirs6NRYWZI4qVo4MRAilASM7I5INtCCXhSWLfwCoD4FA7jh9GGAsgf9K
         V/8g==
X-Gm-Message-State: ABy/qLai90JHXnYIa3x42YDMgvDL8z6a9KKnziB4olZ8eK0ixFTmsj8J
        aobhZc5TIiN6rV4j60+yDnGsd2R5TQ+BGkog9k49Bw==
X-Google-Smtp-Source: APBJJlEZTGH3xA02f3Vss4QvD5JdAj+gDyxL3QK6QNTztLVVZaIlOkzGPi6Jk4hdP++MCao8A43eqp/mAzbSF5yNdBA=
X-Received: by 2002:a05:622a:1a81:b0:403:f5b8:2bd2 with SMTP id
 s1-20020a05622a1a8100b00403f5b82bd2mr55188qtc.9.1690264548161; Mon, 24 Jul
 2023 22:55:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com> <20230721094043.2506691-3-fengwei.yin@intel.com>
In-Reply-To: <20230721094043.2506691-3-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 24 Jul 2023 23:55:12 -0600
Message-ID: <CAOUHufY2tdO0JNTiY=RzHitR7CB1cM5kA=7bd6nbCUW6KM_OVA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/4] madvise: Use notify-able API to clear and
 flush page table entries
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, minchan@kernel.org, willy@infradead.org,
        david@redhat.com, ryan.roberts@arm.com, shy828301@gmail.com
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

On Fri, Jul 21, 2023 at 3:41=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> Currently, in function madvise_cold_or_pageout_pte_range(), the
> young bit of pte/pmd is cleared notify subscripter.
>
> Using notify-able API to make sure the subscripter is signaled about
> the young bit clearing.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
> ---
>  mm/madvise.c | 18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index f12933ebcc24..b236e201a738 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -403,14 +403,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *=
pmd,
>                         return 0;
>                 }
>
> -               if (pmd_young(orig_pmd)) {
> -                       pmdp_invalidate(vma, addr, pmd);
> -                       orig_pmd =3D pmd_mkold(orig_pmd);
> -
> -                       set_pmd_at(mm, addr, pmd, orig_pmd);
> -                       tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
> -               }
> -
> +               pmdp_clear_flush_young_notify(vma, addr, pmd);
>                 folio_clear_referenced(folio);
>                 folio_test_clear_young(folio);
>                 if (folio_test_active(folio))
> @@ -496,14 +489,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *=
pmd,
>
>                 VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>
> -               if (pte_young(ptent)) {
> -                       ptent =3D ptep_get_and_clear_full(mm, addr, pte,
> -                                                       tlb->fullmm);
> -                       ptent =3D pte_mkold(ptent);
> -                       set_pte_at(mm, addr, pte, ptent);
> -                       tlb_remove_tlb_entry(tlb, pte, addr);
> -               }
> -
> +               ptep_clear_flush_young_notify(vma, addr, pte);

These two places are tricky.

I agree there is a problem here, i.e., we are not consulting the mmu
notifier. In fact, we do pageout on VMs on ChromeOS, and it's been a
known problem to me for a while (not a high priority one).

tlb_remove_tlb_entry() is batched flush, ptep_clear_flush_young() is
not. But, on x86, we might see a performance improvement since
ptep_clear_flush_young() doesn't flush TLB at all. On ARM, there might
be regressions though.

I'd go with ptep_clear_young_notify(), but IIRC, Minchan mentioned he
prefers flush. So I'll let him chime in.

If we do end up with ptep_clear_young_notify(), please remove
mmu_gather -- it should have been done in this patch.
