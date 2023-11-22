Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACFD7F3D14
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjKVFBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:01:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A6B112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:01:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA246C43395
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700629272;
        bh=u7DV6cTNrN7b/2qEFKGmtHVpBCHzyuXO2gggNSplrUQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ng9pOFQIoS9qLahi/YyX4F1ALlWYEaZSKiVnr76zOlIUH0LLDn9SdL3CC73JSDNJm
         6nsiQVVKrwxTFvnJIh8tq764heth0p/uI79/dam0utu9sLMgNjnpimFmFagw+bEYmq
         NH8xHvK45gocepA4LA3ffJM5cdcAOkQKm0l4DUK86YG1l8sa/OJBaqXcj1YOMT0bYR
         bZ9WmvPC5aU1CP/RC1M5DQlQfIXg/gHL1u3dQOKqCpFq0G42SYUg1U6lRtSdKlbPXR
         WlxAcPz78z1bQFeOxu0Illo6EtH89q9GRcA4ZUQmzBZojVoZhb9/cmUN03cLEQXhly
         NpfZbP2jSHdCA==
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6b2018a11efso6444834b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:01:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yzl3eUI2FtjI85hKC5hwDupkHAOLDq/ltpYRoQ2+3UEh04f2CGM
        A66cGQ8e/nI1ul8fty3EoFp4ZB3YA1APO7G8H2Oa3w==
X-Google-Smtp-Source: AGHT+IGoRK+sboEREpkiBypgMYjiELBK54an0rQxLOfAqvAoQMfcTAdIFcAsYrHHd8GU3ztDP3IXsQyG8s4djLcZCVw=
X-Received: by 2002:a05:6a20:918f:b0:184:3233:679c with SMTP id
 v15-20020a056a20918f00b001843233679cmr1356784pzd.12.1700629271360; Tue, 21
 Nov 2023 21:01:11 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-21-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-21-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 21:01:00 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPu9+tgUn4rMLZ7j5+G457OEb7mty5Hy_gjjmRjkR51=Q@mail.gmail.com>
Message-ID: <CAF8kJuPu9+tgUn4rMLZ7j5+G457OEb7mty5Hy_gjjmRjkR51=Q@mail.gmail.com>
Subject: Re: [PATCH 20/24] swap: simplify and make swap_find_cache static
To:     Kairui Song <kasong@tencent.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> There are only two callers within the same file now, make it static and
> drop the redundant if check on the shadow variable.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h       | 2 --
>  mm/swap_state.c | 5 ++---
>  2 files changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index b073c29c9790..4402970547e7 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -46,8 +46,6 @@ void __delete_from_swap_cache(struct folio *folio,
>  void delete_from_swap_cache(struct folio *folio);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> -struct folio *swap_cache_get_folio(swp_entry_t entry,
> -                                  struct vm_fault *vmf, void **shadowp);
>  struct folio *filemap_get_incore_folio(struct address_space *mapping,
>                 pgoff_t index);
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index eef66757c615..6f39aa8394f1 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -334,15 +334,14 @@ static inline bool swap_use_vma_readahead(struct sw=
ap_info_struct *si)
>   *
>   * Caller must lock the swap device or hold a reference to keep it valid=
.
>   */
> -struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_fault *v=
mf, void **shadowp)
> +static struct folio *swap_cache_get_folio(swp_entry_t entry, struct vm_f=
ault *vmf, void **shadowp)
>  {
>         bool vma_ra, readahead;
>         struct folio *folio;
>
>         folio =3D filemap_get_entry(swap_address_space(entry), swp_offset=
(entry));
>         if (xa_is_value(folio)) {
> -               if (shadowp)
> -                       *shadowp =3D folio;
> +               *shadowp =3D folio;

I prefer to keep the original code to perform the check before
assigning it. The caller usage situation might change.
It is more defensive.

Does not seem to justify it as a standalone patch.

Chris
