Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB0967858E4
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235731AbjHWNR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbjHWNRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:17:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB2810DF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CDB666167
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:16:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52929C433CB
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 13:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692796586;
        bh=LY55oZNdP7mKklt0DeiFkFhtYAWE0Vjdl+Ou8X0WOPA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LtCohTGfoeV0O3p0dOlO4XVzoIt3Un0e5PJt4U0FFXiVkGfzBRSBOlWQ21ra2YBtj
         VgL2/eQr71IPf1S0IC91E8SctoeE5AKUlzXuiszZz3xV7ARh2FrtAmG4JPRZD+hlpg
         BcC71+j5U8vCJ2bASmGD2dUX2Mf5WgpKb/ze+nk+ys6bT2mrcSHk+pw06nXShjMU/o
         Tezc4tJLi+8Aq/STlgdTjtYPESxBpOSEmc7XF3WpQTpN8dmq2cNoU2LQN8yG4l1fVV
         ETJRlNEgff0g8bJCy6C4X3IXASPpVZUTkjThHpN5aW33n3zs9pkTLyIMePPwMnU9U1
         jx307/Ug6gLOw==
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-1c4c6717e61so4081597fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 06:16:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YzA75rcbFsHGOQAqfTIjQQ3nVKzVlwbaDHO0J9IFUFEaM93SanT
        E+eNmnRkOlTGCP05PBQLlNjzorCMbpsPZjXxuNHwIg==
X-Google-Smtp-Source: AGHT+IEH/MFDGTdjzCp5cToFtz0nvm+wCENTVIj4wS3D2DqrHyjrwPwLxx76itDUydqBYI/tgpZ2989odg49RKFYrNk=
X-Received: by 2002:a05:6870:c154:b0:1bf:1346:63e with SMTP id
 g20-20020a056870c15400b001bf1346063emr16151624oad.49.1692796585421; Wed, 23
 Aug 2023 06:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230821160849.531668-1-david@redhat.com> <20230821160849.531668-5-david@redhat.com>
In-Reply-To: <20230821160849.531668-5-david@redhat.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Wed, 23 Aug 2023 06:16:13 -0700
X-Gmail-Original-Message-ID: <CAF8kJuNsSeVEhcGz9idUahzR761w_OZV+dNY73ocMfQW=a1iOw@mail.gmail.com>
Message-ID: <CAF8kJuNsSeVEhcGz9idUahzR761w_OZV+dNY73ocMfQW=a1iOw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 4/4] mm/huge_memory: work on folio->swap
 instead of page->private when splitting folio
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Xu <peterx@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Hugh Dickins <hughd@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

Reviewed-by: Chris Li <chrisl@kernel.org>

Chris


Chris

On Mon, Aug 21, 2023 at 9:09=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Let's work on folio->swap instead. While at it, use folio_test_anon() and
> folio_test_swapcache() -- the original folio remains valid even after
> splitting (but is then an order-0 folio).
>
> We can probably convert a lot more to folios in that code, let's focus
> on folio->swap handling only for now.
>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/huge_memory.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
>
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index c04702ae71d2..4465915711c3 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2401,10 +2401,16 @@ static void lru_add_page_tail(struct page *head, =
struct page *tail,
>         }
>  }
>
> -static void __split_huge_page_tail(struct page *head, int tail,
> +static void __split_huge_page_tail(struct folio *folio, int tail,
>                 struct lruvec *lruvec, struct list_head *list)
>  {
> +       struct page *head =3D &folio->page;
>         struct page *page_tail =3D head + tail;
> +       /*
> +        * Careful: new_folio is not a "real" folio before we cleared Pag=
eTail.
> +        * Don't pass it around before clear_compound_head().
> +        */
> +       struct folio *new_folio =3D (struct folio *)page_tail;
>
>         VM_BUG_ON_PAGE(atomic_read(&page_tail->_mapcount) !=3D -1, page_t=
ail);
>
> @@ -2453,8 +2459,8 @@ static void __split_huge_page_tail(struct page *hea=
d, int tail,
>                 VM_WARN_ON_ONCE_PAGE(true, page_tail);
>                 page_tail->private =3D 0;
>         }
> -       if (PageSwapCache(head))
> -               set_page_private(page_tail, (unsigned long)head->private =
+ tail);
> +       if (folio_test_swapcache(folio))
> +               new_folio->swap.val =3D folio->swap.val + tail;
>
>         /* Page flags must be visible before we make the page non-compoun=
d. */
>         smp_wmb();
> @@ -2500,11 +2506,9 @@ static void __split_huge_page(struct page *page, s=
truct list_head *list,
>         /* complete memcg works before add pages to LRU */
>         split_page_memcg(head, nr);
>
> -       if (PageAnon(head) && PageSwapCache(head)) {
> -               swp_entry_t entry =3D { .val =3D page_private(head) };
> -
> -               offset =3D swp_offset(entry);
> -               swap_cache =3D swap_address_space(entry);
> +       if (folio_test_anon(folio) && folio_test_swapcache(folio)) {
> +               offset =3D swp_offset(folio->swap);
> +               swap_cache =3D swap_address_space(folio->swap);
>                 xa_lock(&swap_cache->i_pages);
>         }
>
> @@ -2514,7 +2518,7 @@ static void __split_huge_page(struct page *page, st=
ruct list_head *list,
>         ClearPageHasHWPoisoned(head);
>
>         for (i =3D nr - 1; i >=3D 1; i--) {
> -               __split_huge_page_tail(head, i, lruvec, list);
> +               __split_huge_page_tail(folio, i, lruvec, list);
>                 /* Some pages can be beyond EOF: drop them from page cach=
e */
>                 if (head[i].index >=3D end) {
>                         struct folio *tail =3D page_folio(head + i);
> @@ -2559,11 +2563,8 @@ static void __split_huge_page(struct page *page, s=
truct list_head *list,
>
>         remap_page(folio, nr);
>
> -       if (PageSwapCache(head)) {
> -               swp_entry_t entry =3D { .val =3D page_private(head) };
> -
> -               split_swap_cluster(entry);
> -       }
> +       if (folio_test_swapcache(folio))
> +               split_swap_cluster(folio->swap);
>
>         for (i =3D 0; i < nr; i++) {
>                 struct page *subpage =3D head + i;
> --
> 2.41.0
>
>
