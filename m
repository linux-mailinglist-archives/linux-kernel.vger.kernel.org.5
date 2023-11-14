Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03067EA856
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 02:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjKNBmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 20:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjKNBmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 20:42:53 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E26D44;
        Mon, 13 Nov 2023 17:42:49 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-280260db156so4596651a91.2;
        Mon, 13 Nov 2023 17:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699926169; x=1700530969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3hmwID4NUoEMNhNLHUF25keYaca4bGqY6IjYsobRAqI=;
        b=DC6sQmEXqN0w1ihMdrckgsS43q1ehrFXSTwmfJySsq51xv4JrG5Gbf8tykuxOWTx+M
         pl3jI9gVZl/Gt4ijgvgX4lgtt2q0oqMr6oWhwAXMlQI9TRzpyS0JsJta67yoaYDrbNQC
         Z9oDa5j6pKfxzcPQJ2eh2IOQTsLSkmbkXz1yBGtPcyugZRmhRnJwtowX3ruVMcbycw5L
         iW6zgGr06vHiNacMuzp7JiDyaahydfAlnTze/8NXbQCZlCnI4Fj+RAbmsiHwbTvrK/tt
         ZHk+hMOSFEE6Rd6uTH27xEvS4405FHNXl7d5sjJqFKj2DfC/PMKKZuwpPJAYbh5+zbr3
         KjDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699926169; x=1700530969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3hmwID4NUoEMNhNLHUF25keYaca4bGqY6IjYsobRAqI=;
        b=PG0rw7FG9kCv5mY4PbMFLsOapSN8zs3bB48cCLIC8ajGNAsJ7DgzO+/VHTBDjATEgf
         BFxhYlcRyQL6QAXkonad17xujgAuzUAHlIOLyQgq2WMRBSMntkNxIlHZFEeRJOXHkg43
         nBcYB8UHBpnRpIDB50lFVnE59JnrWZ6OEyDuzmrkvmyySlm7xDoL+RzmZl7XpQg2WPDR
         rikygRyOZtY5cmY/3SEO/VmJWvnBHWHS0gUpILOHMvI/YwRedlQZy+KH7fy68GuZVqDN
         vpYUTGRHRVy84VNAyNNH1GtitlrQwwJMql8BNBYb5SCaMfiv5Ca5kXfw+91uKdWHALyN
         5oFw==
X-Gm-Message-State: AOJu0YyicbRZe+PcuOGmAVPZvR+soFZsZwjflZrKSQVryPbSGsAiinDS
        eG8vRhwBXXBDLi3KGGav75tcnBiC8PfjOSqRkqY=
X-Google-Smtp-Source: AGHT+IFmSIzM64Ultyohl3cddt8R4PwwVe85tC1PBHmfR8nuPKj4+JgFvHIZba39aYMDlnANYytNFC2LfOv09/LYPS8=
X-Received: by 2002:a17:90a:bb83:b0:280:125:e52e with SMTP id
 v3-20020a17090abb8300b002800125e52emr8679244pjr.35.1699926169047; Mon, 13 Nov
 2023 17:42:49 -0800 (PST)
MIME-Version: 1.0
References: <20231108171517.2436103-1-shr@devkernel.io>
In-Reply-To: <20231108171517.2436103-1-shr@devkernel.io>
From:   Yang Shi <shy828301@gmail.com>
Date:   Mon, 13 Nov 2023 17:42:37 -0800
Message-ID: <CAHbLzkqx9A2XoPJynr4JR-31UstASW-bgym4PM9mok7gUOSM3A@mail.gmail.com>
Subject: Re: [PATCH v3] mm: Fix for negative counter: nr_file_hugepages
To:     Stefan Roesch <shr@devkernel.io>
Cc:     kernel-team@fb.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
        riel@surriel.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, willy@infradead.org
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

On Wed, Nov 8, 2023 at 9:15=E2=80=AFAM Stefan Roesch <shr@devkernel.io> wro=
te:
>
> While qualifiying the 6.4 release, the following warning was detected in
> messages:
>
> vmstat_refresh: nr_file_hugepages -15664
>
> The warning is caused by the incorrect updating of the NR_FILE_THPS
> counter in the function split_huge_page_to_list. The if case is checking
> for folio_test_swapbacked, but the else case is missing the check for
> folio_test_pmd_mappable. The other functions that manipulate the counter
> like __filemap_add_folio and filemap_unaccount_folio have the
> corresponding check.
>
> I have a test case, which reproduces the problem. It can be found here:
>   https://github.com/sroeschus/testcase/blob/main/vmstat_refresh/madv.c
>
> The test case reproduces on an XFS filesystem. Running the same test
> case on a BTRFS filesystem does not reproduce the problem.
>
> AFAIK version 6.1 until 6.6 are affected by this problem.
>
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> Co-debugged-by: Johannes Weiner <hannes@cmpxchg.org>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Cc: stable@vger.kernel.org

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  mm/huge_memory.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 064fbd90822b4..874000f97bfc1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2737,13 +2737,15 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>                         int nr =3D folio_nr_pages(folio);
>
>                         xas_split(&xas, folio, folio_order(folio));
> -                       if (folio_test_swapbacked(folio)) {
> -                               __lruvec_stat_mod_folio(folio, NR_SHMEM_T=
HPS,
> -                                                       -nr);
> -                       } else {
> -                               __lruvec_stat_mod_folio(folio, NR_FILE_TH=
PS,
> -                                                       -nr);
> -                               filemap_nr_thps_dec(mapping);
> +                       if (folio_test_pmd_mappable(folio)) {
> +                               if (folio_test_swapbacked(folio)) {
> +                                       __lruvec_stat_mod_folio(folio,
> +                                                       NR_SHMEM_THPS, -n=
r);
> +                               } else {
> +                                       __lruvec_stat_mod_folio(folio,
> +                                                       NR_FILE_THPS, -nr=
);
> +                                       filemap_nr_thps_dec(mapping);
> +                               }
>                         }
>                 }
>
>
> base-commit: ffc253263a1375a65fa6c9f62a893e9767fbebfa
> --
> 2.39.3
>
>
