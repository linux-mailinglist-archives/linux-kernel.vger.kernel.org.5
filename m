Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44E975D250
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 20:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjGUS6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 14:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbjGUS6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 14:58:17 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D5AD3A81
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:58:14 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-40540a8a3bbso47231cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 11:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689965893; x=1690570693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5dOmaGEeHKijZzwLUbP8a8yo4nCvMNwfv/FbJP6gONY=;
        b=3SOS/82HiVB6f8Oyz2CCWSAiBYZr03AcYeZbruYPWnvhm2NfbgThFThewmrM7P7YSV
         gOtWDk9+h1eyDHcWN9xh1S5ZbFeOHaWHqWfyS/VqS6HTIL3AxB2hIvWgFaecqapcmNP8
         pfm39wPUHTosAebvJk5kNmeGi9kKwPxg0CdKMnB5/2r1qqUL0a1QKndsefXVagNog3RC
         cM83OA9iw+Cuz+eiAAW68pBUmsRnvizBs4aiDa4nG0WnEIcM5XQ2dJF9IXDdysezxpdq
         0fUYnzniDkxQ3c4nPStUK6iPLpgye7PaI2A8IwpQ7b8jjPj/oGHW2HgaUpUZIh0wUSPd
         fsxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689965893; x=1690570693;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5dOmaGEeHKijZzwLUbP8a8yo4nCvMNwfv/FbJP6gONY=;
        b=bXzr+frRDvVrEF0jR4hCp3L/Ebd73x2qLgfJc+OUPbEMrh/7V8LFlsqGpCyyTe4sMh
         Otr5WOmYC2K7SrdlkrlBPCdurkd21SPek3kZc2AxjyFoAxYEGIIbtzaClbXMGhHFpJYn
         FcVdlQJ0aoeNfoX0jzJlpdcJorjtN9rT1BzFniuOmfR/e3jCAI3vy+rkJTTPQURiaKkV
         gDDYTW8zO+DUzMOn2/WgYBC7WYMy/OueDwuAMkvMKVm7hId9R94U4hJirecXgErXhR7u
         r8dgLJEtaPbSIe7aZgcjQexYiKX/qVz04nPRx0NCH7fwbl5fHqVEb2VW7Fn/MHhmvctE
         x2Vw==
X-Gm-Message-State: ABy/qLbSJ6sP/PPaSDoJNahGmZfbbOwEAvEEAr6uTbbytczmaggLzd1q
        SXoH1VpFEM48DeEYIueK8llz8k2KTFpgQ4yGFbENHA==
X-Google-Smtp-Source: APBJJlHiPrJg9+05iGkCCfSMtDz1gx2BEYpc9k/KsPXYLKI7Fyu18C+uzPJg01RUVSZs0P16CO9+AdlDdy6jtR87fDA=
X-Received: by 2002:a05:622a:48:b0:403:b1e5:bcae with SMTP id
 y8-20020a05622a004800b00403b1e5bcaemr43295qtw.10.1689965893190; Fri, 21 Jul
 2023 11:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230721094043.2506691-1-fengwei.yin@intel.com> <20230721094043.2506691-2-fengwei.yin@intel.com>
In-Reply-To: <20230721094043.2506691-2-fengwei.yin@intel.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 21 Jul 2023 12:57:37 -0600
Message-ID: <CAOUHufY0AX_wyBCZ3dNMfTg7C1ZBOZHpYSgG=uOwbeeemyFX6Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/4] madvise: not use mapcount() against large
 folio for sharing check
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
> The commit
> 07e8c82b5eff ("madvise: convert madvise_cold_or_pageout_pte_range() to
> use folios") replaced the page_mapcount() with folio_mapcount() to
> check whether the folio is shared by other mapping.
>
> But it's not correct for large folio. folio_mapcount() returns the
> total mapcount of large folio which is not suitable to detect whether
> the folio is shared.
>
> Use folio_estimated_sharers() which returns a estimated number of
> shares. That means it's not 100% correct. But it should be OK for
> madvise case here.
>
> Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>

Fixes:
Cc: stable

> @@ -383,7 +383,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 folio =3D pfn_folio(pmd_pfn(orig_pmd));
>
>                 /* Do not interfere with other mappings of this folio */
> -               if (folio_mapcount(folio) !=3D 1)
> +               if (folio_estimated_sharers(folio) !=3D 1)

Strictly speaking, this isn't a bug. But it may be ok to include it in
the same patch.

>                         goto huge_unlock;
>
>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
> @@ -459,7 +459,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *p=
md,
>                 if (folio_test_large(folio)) {
>                         int err;
>
> -                       if (folio_mapcount(folio) !=3D 1)
> +                       if (folio_estimated_sharers(folio) !=3D 1)
>                                 break;
>                         if (pageout_anon_only_filter && !folio_test_anon(=
folio))
>                                 break;
> @@ -682,7 +682,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigne=
d long addr,

What about madvise_free_huge_pmd()? Should it be changed as well so
that it's consistent with the first change? Either change both or neither.

>                 if (folio_test_large(folio)) {
>                         int err;
>
> -                       if (folio_mapcount(folio) !=3D 1)
> +                       if (folio_estimated_sharers(folio) !=3D 1)

This is another bug fix and should be in a separate patch.

>                                 break;
>                         if (!folio_trylock(folio))
>                                 break;

Please send two separate fixes, and then:

Reviewed-by: Yu Zhao <yuzhao@google.com>
