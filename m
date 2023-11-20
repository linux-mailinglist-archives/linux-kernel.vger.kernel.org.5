Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7114D7F0B55
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 05:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230033AbjKTESS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 23:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTESQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 23:18:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA3313E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:18:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FD15C433CC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700453891;
        bh=BluD7GIVPO8PrPVuaW0518p8IU0xm5lBhxJYVGvOByo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=osZUrbBoau/5wiylWuf727gI2yFiwS42NUycYdcMhSsIPZ6zg8UN0qIUwemah4AjV
         26IplfITNMI4E3CbRY6Pmd2EP75Aiids9S6m+hmJ1wadnTw7EL3Rq1fOY80lcw+RSJ
         HU8IhCH9TnHssqjPaut1ZbRrsn2mVa33F49gTbLor+J9T6qRcr0j1onTEBgBNOWGl7
         BqsVWiMa81+EFH7w+u9p90safr3xQgBMRRk3Qo62wq4dlB1fdUP84xMKwaYD1A0DDd
         V4FXDgwDZh06Q4pC+W2ikhufkdaLlZIki6A9CWw9sMPNnbQWMj//ZEHRu8m5MRbywl
         u2HaHaXK5CGBQ==
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2851b271e51so536168a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 20:18:11 -0800 (PST)
X-Gm-Message-State: AOJu0Yxjc8z5pFr/WrwqoobRtfKWwFmY1MA8U4rStJ9zaO8/hEda4LMB
        7V8GXEWRi7sCSWjcp3/NL/kBpMmkJkwkrihgwR4Obw==
X-Google-Smtp-Source: AGHT+IEJodpCm5QEZgAh344L09AH+Jfnh6wGRkUZQu4v/ot9+4ois/EpwLm/GZKydBJyx86vspgRmVNepQfLaKfeRdE=
X-Received: by 2002:a17:90b:3e85:b0:283:2652:3d20 with SMTP id
 rj5-20020a17090b3e8500b0028326523d20mr9197638pjb.9.1700453890466; Sun, 19 Nov
 2023 20:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-5-ryncsn@gmail.com>
In-Reply-To: <20231119194740.94101-5-ryncsn@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Sun, 19 Nov 2023 20:17:59 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
Message-ID: <CAF8kJuNbcvwmojMB2Vp2LjTBxZtKFO_Zng4TODqADxmNPn2kCg@mail.gmail.com>
Subject: Re: [PATCH 04/24] mm/swap: avoid setting page lock bit and doing
 extra unlock check
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
>
> From: Kairui Song <kasong@tencent.com>
>
> When swapping in a page, mem_cgroup_swapin_charge_folio is called for new
> allocated folio, nothing else is referencing the folio so no need to set
> the lock bit. This avoided doing unlock check on error path.
>
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  mm/swap_state.c | 20 +++++++++-----------
>  1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/mm/swap_state.c b/mm/swap_state.c
> index ac4fa404eaa7..45dd8b7c195d 100644
> --- a/mm/swap_state.c
> +++ b/mm/swap_state.c
> @@ -458,6 +458,8 @@ struct page *__read_swap_cache_async(swp_entry_t entr=
y, gfp_t gfp_mask,

You move the mem_cgroup_swapin_charge_folio() inside the for loop:


        for (;;) {
                int err;
                /*
                 * First check the swap cache.  Since this is normally
                 * called after swap_cache_get_folio() failed, re-calling
                 * that would confuse statistics.
                 */
                folio =3D filemap_get_folio(swap_address_space(entry),
                                                swp_offset(entry));


>                                                 mpol, ilx, numa_node_id()=
);
>                 if (!folio)
>                          goto fail_put_swap;
> +               if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask,=
 entry))
> +                       goto fail_put_folio;

Wouldn't it cause repeat charging of the folio when it is racing
against others in the for loop?

>
>                 /*
>                  * Swap entry may have been freed since our caller observ=
ed it.
> @@ -483,13 +485,9 @@ struct page *__read_swap_cache_async(swp_entry_t ent=
ry, gfp_t gfp_mask,
>         /*
>          * The swap entry is ours to swap in. Prepare the new page.
>          */
> -
>         __folio_set_locked(folio);
>         __folio_set_swapbacked(folio);
>
> -       if (mem_cgroup_swapin_charge_folio(folio, NULL, gfp_mask, entry))
> -               goto fail_unlock;
> -

The original code makes the charge outside of the for loop. Only the
winner can charge once.

Chris
