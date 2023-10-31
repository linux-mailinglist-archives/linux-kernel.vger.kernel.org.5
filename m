Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08A57DD605
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 19:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbjJaS1P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 14:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbjJaS1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 14:27:13 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3398DDF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:27:10 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-5aa7172bafdso4041844a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 11:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698776829; x=1699381629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U69Eg1i5YMr1sJwmANMppaJJXceNvx8HFkukPz27Hbo=;
        b=Z8ZdEnprzoZ9ZHKQ71hGWPUMuTIvGarzb/CAeCrkHkDC3y5KtLuHJzXgEPHB44SrH2
         PSgkB/tb4fHWsnijVjiWaQwmi08odPIzImzuZnLAnZR5zMli3Af3m3RZeIpPhNeaWqI1
         FQ1Dmj+AmgDQIzMbuDoUvKjq9yhD6fogYJZedNiEMYtTrW0x3iS75hfPMrdpw5StERpu
         fT5ie9B4XBdRaEvdgjpyxjDNKg+XgX9vfS10IDn7YQYIhpsLYsOwLDYzaK/sw9Guy2x+
         PoJsfA5MCBTZhw6LID/RtUhm2LONSKCPQQff5RjAYIL0LWunN9Py2C+lKxCri7QK6yK2
         cgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698776829; x=1699381629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U69Eg1i5YMr1sJwmANMppaJJXceNvx8HFkukPz27Hbo=;
        b=fqE7nSc3hhTSD1pvqz34EFInSlvLV06rwy+WeRdjB0ocjgrupH59D7BBMAmnoHza5u
         XLq2zw2PVZHLqBlMCmoYFXyAJYmlsKCZ91tqXe1wb4wc9AUznfjyVCa3RsTZ+CS/B9Tv
         tHoB0sEeQZSJ4MjdkufdW7FuhJK56yfV870oiWd4lpkcGNDZXROW96aESwdfH2UJtzVf
         mWfjJr6ce0OrZuA2gog4063zrrE5fCVE9BqO4ZP2epnQNGJxC9XST2U7bRNSKJNa14q2
         mdnVZnxNl1HxRnb1DTR4sgJo1exIYAYFGAvZ2gL3BbCLG8D5lb6keHMsFe5wtYwS2bkV
         wZIw==
X-Gm-Message-State: AOJu0YyOQRv+eKp2GrUHcZRWGhBCXXEpLLyinpIgDP0kNYPowdOxf3h0
        kPIKyCpsRzDTymJlux6Zx3jG+8HI0LRIUU/fXS0=
X-Google-Smtp-Source: AGHT+IFkKwl6RxjQ7PqjHXLWiBJqz4KC39TuYkrflzvEHUC0SdM4frt8XxboY7J8UTrC1rh8ZpnM3YCub5G/WKOmOqQ=
X-Received: by 2002:a17:90a:31ca:b0:27d:c36:e12c with SMTP id
 j10-20020a17090a31ca00b0027d0c36e12cmr10811012pjf.9.1698776829643; Tue, 31
 Oct 2023 11:27:09 -0700 (PDT)
MIME-Version: 1.0
References: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <431d9fb6823036369dcb1d3b2f63732f01df21a7.1698488264.git.baolin.wang@linux.alibaba.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Tue, 31 Oct 2023 11:26:58 -0700
Message-ID: <CAHbLzkoaAZipjcCLcC41kjm4rE8DSfqdDBFrG6LJJvFwgmcHLg@mail.gmail.com>
Subject: Re: [PATCH] mm: huge_memory: batch tlb flush when splitting a
 pte-mapped THP
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 6:12=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> I can observe an obvious tlb flush hotpot when splitting a pte-mapped THP=
 on
> my ARM64 server, and the distribution of this hotspot is as follows:
>
>    - 16.85% split_huge_page_to_list
>       + 7.80% down_write
>       - 7.49% try_to_migrate
>          - 7.48% rmap_walk_anon
>               7.23% ptep_clear_flush
>       + 1.52% __split_huge_page
>
> The reason is that the split_huge_page_to_list() will build migration ent=
ries
> for each subpage of a pte-mapped Anon THP by try_to_migrate(), or unmap f=
or
> file THP, and it will clear and tlb flush for each subpage's pte. Moreove=
r,
> the split_huge_page_to_list() will set TTU_SPLIT_HUGE_PMD flag to ensure
> the THP is already a pte-mapped THP before splitting it to some normal pa=
ges.
>
> Actually, there is no need to flush tlb for each subpage immediately, ins=
tead
> we can batch tlb flush for the pte-mapped THP to improve the performance.
>
> After this patch, we can see the batch tlb flush can improve the latency
> obviously when running thpscale.
>                              k6.5-base                   patched
> Amean     fault-both-1      1071.17 (   0.00%)      901.83 *  15.81%*
> Amean     fault-both-3      2386.08 (   0.00%)     1865.32 *  21.82%*
> Amean     fault-both-5      2851.10 (   0.00%)     2273.84 *  20.25%*
> Amean     fault-both-7      3679.91 (   0.00%)     2881.66 *  21.69%*
> Amean     fault-both-12     5916.66 (   0.00%)     4369.55 *  26.15%*
> Amean     fault-both-18     7981.36 (   0.00%)     6303.57 *  21.02%*
> Amean     fault-both-24    10950.79 (   0.00%)     8752.56 *  20.07%*
> Amean     fault-both-30    14077.35 (   0.00%)    10170.01 *  27.76%*
> Amean     fault-both-32    13061.57 (   0.00%)    11630.08 *  10.96%*
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f31f02472396..0e4c14bf6872 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2379,7 +2379,7 @@ void vma_adjust_trans_huge(struct vm_area_struct *v=
ma,
>  static void unmap_folio(struct folio *folio)
>  {
>         enum ttu_flags ttu_flags =3D TTU_RMAP_LOCKED | TTU_SPLIT_HUGE_PMD=
 |
> -               TTU_SYNC;
> +               TTU_SYNC | TTU_BATCH_FLUSH;
>
>         VM_BUG_ON_FOLIO(!folio_test_large(folio), folio);
>
> @@ -2392,6 +2392,8 @@ static void unmap_folio(struct folio *folio)
>                 try_to_migrate(folio, ttu_flags);
>         else
>                 try_to_unmap(folio, ttu_flags | TTU_IGNORE_MLOCK);
> +
> +       try_to_unmap_flush();
>  }
>
>  static void remap_page(struct folio *folio, unsigned long nr)
> --
> 2.39.3
>
