Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252207F3D3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234351AbjKVFUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVFUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:20:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B01110
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:20:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C99C43395
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700630426;
        bh=TBbRhfDoqJI+ymRHmhoyHUYl0HTJGIfk3dxv/NU20Ms=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IK3LtsikP1BRvwrCEda6kuTq9O8soo75WIIUOk2Fz9xXUoexs5vP6NjzjW+PhPPvA
         DNmXbdqCUFHGfiVSS+c0O/cu3DrW8VyOei0MpCAf8J98XFpQPrfk2yx5OohGJd7oRr
         z7CqSaIUtco5hW6OHfK5ZnuHK+u2k8c44bFPucZGl1SEklO4VqRy3aVcrGy5JfSqMk
         7SD4fkIzzNynOylUShKy5l5/7WHJCnMqoKGISmy8qec2U5lpHQcI2IJT5hoTdmxBSV
         FthKfY3MFdfmRyBYFd9hbwkQuXC25YW8BmnECgbRdvV9bw8sUEzuWj991pq0CKueCH
         D8dCqUJqWVRVA==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2851c0569acso2775351a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:20:26 -0800 (PST)
X-Gm-Message-State: AOJu0YyOv0weoG5bDOoBoKj3vH8eCiCH5uUYAE0tA7lx9tQUNdxPY7Ts
        /5v4MvibeZDlhHXEK3qyjMp1mdH4VzaApndvJ4wbPw==
X-Google-Smtp-Source: AGHT+IFcrF1HMAPcEcdg3CE9b/rONhKC5c1o9etFhSEOQC2ujUcKF7+jI+/KXApiAMAt48bunhDMoHWEhQ9XY7eC6QM=
X-Received: by 2002:a17:90a:6349:b0:280:65ed:df9 with SMTP id
 v9-20020a17090a634900b0028065ed0df9mr1378521pjs.31.1700630426038; Tue, 21 Nov
 2023 21:20:26 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-23-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-23-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 21:20:14 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPssXch+t5Rn0-dBzLPUCg-fid6PRaiTObc36L9Wqrzcg@mail.gmail.com>
Message-ID: <CAF8kJuPssXch+t5Rn0-dBzLPUCg-fid6PRaiTObc36L9Wqrzcg@mail.gmail.com>
Subject: Re: [PATCH 22/24] swap: make swap_cluster_readahead static
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

Hi Kairui,

On Sun, Nov 19, 2023 at 11:49=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> Now there is no caller outside the same file, make it static.

Seems to me too trivial/low value to justify as a standalone patch.

Chris

>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap.h       | 8 --------
>  mm/swap_state.c | 4 ++--
>  2 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 4402970547e7..795a25df87da 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -56,8 +56,6 @@ struct page *read_swap_cache_async(swp_entry_t entry, g=
fp_t gfp_mask,
>  struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
>                                      struct mempolicy *mpol, pgoff_t ilx,
>                                      bool *new_page_allocated);
> -struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t flag,
> -                                   struct mempolicy *mpol, pgoff_t ilx);
>  struct page *swapin_readahead(swp_entry_t entry, gfp_t flag,
>                               struct vm_fault *vmf, enum swap_cache_resul=
t *result);
>  struct page *swapin_page_non_fault(swp_entry_t entry, gfp_t gfp_mask,
> @@ -93,12 +91,6 @@ static inline void show_swap_cache_info(void)
>  {
>  }
>
> -static inline struct page *swap_cluster_readahead(swp_entry_t entry,
> -                       gfp_t gfp_mask, struct mempolicy *mpol, pgoff_t i=
lx)
> -{
> -       return NULL;
> -}
> -
>  static inline struct page *swapin_readahead(swp_entry_t swp, gfp_t gfp_m=
ask,
>                         struct vm_fault *vmf, enum swap_cache_result *res=
ult)
>  {
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index 0433a2586c6d..b377e55cb850 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -627,8 +627,8 @@ static unsigned long swapin_nr_pages(unsigned long of=
fset)
>   * are used for every page of the readahead: neighbouring pages on swap
>   * are fairly likely to have been swapped out from the same node.
>   */
> -struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
> -                                   struct mempolicy *mpol, pgoff_t ilx)
> +static struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_=
mask,
> +                                          struct mempolicy *mpol, pgoff_=
t ilx)
>  {
>         struct page *page;
>         unsigned long entry_offset =3D swp_offset(entry);
> --
> 2.42.0
>
>
