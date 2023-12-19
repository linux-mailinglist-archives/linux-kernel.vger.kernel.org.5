Return-Path: <linux-kernel+bounces-5129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAD98186CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4390E1F24308
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B904E1C6AE;
	Tue, 19 Dec 2023 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qBwKpChM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173FA1C697
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:59:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FDA7C433D9
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 11:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702987189;
	bh=oJowcKwzO3QepgxEcm9BX5vQpDDlCxEGWg7g6MAEbeg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qBwKpChMhRyZiuQLlZzAhvwRr4HeFK91FC7wiT+csQz2cf2m0sym9o+A3ypgokE5X
	 lEfGIV5jMF8qFRbQTbNeqZsoGeGOv2ouuABxHjdCwD3X7Pa+CCMGvp/hIrk49pmzvJ
	 8AqmzHYd+7yL9cyGtJbw1QZ5/hy67WrwP7yBdBVhenJxjy6WHMMSZvwL8FK+cokx/c
	 6jW4eQaFEsn+fNdjpeGt+/STzbryb6Rphr5Ir+VQCHEzyfVmdiq1NhF8787V3loYXR
	 ndJJwU8fVRhMsd1CxM4WtR1g/qrgnQdJU/DycYnBf/jwggyuK7gy1+zU2jA+mno0e8
	 nII5WKD2tZKwA==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6da45aa5549so3394385a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 03:59:49 -0800 (PST)
X-Gm-Message-State: AOJu0YxfkK72fxHpoXd6a4wB+ujy98R96jNvzvc4NAUimh/T/sXcE8ub
	YrRHlCd6SJxWypRr/dM9lWUUcnF31hso5OIoLoDyKA==
X-Google-Smtp-Source: AGHT+IFNPPz/4msH9tJhRKEu0t/nFdP+WnaInu0J+JBIwoL7nvfmI8JzSiJEiLX9jvNreoScENqGqAZt7MaeY/sYK/g=
X-Received: by 2002:a05:6358:9490:b0:172:fe14:5876 with SMTP id
 i16-20020a056358949000b00172fe145876mr297921rwb.2.1702987188790; Tue, 19 Dec
 2023 03:59:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v3-0-4eac09b94ece@bytedance.com> <20231213-zswap-dstmem-v3-3-4eac09b94ece@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v3-3-4eac09b94ece@bytedance.com>
From: Chris Li <chrisl@kernel.org>
Date: Tue, 19 Dec 2023 03:59:37 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM=awZfpXqogk=RTazc1FV0gDPpwVyJtnzSO7+=dV3uOQ@mail.gmail.com>
Message-ID: <CAF8kJuM=awZfpXqogk=RTazc1FV0gDPpwVyJtnzSO7+=dV3uOQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] mm/zswap: refactor out __zswap_load()
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Seth Jennings <sjenning@redhat.com>, Yosry Ahmed <yosryahmed@google.com>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, Dan Streetman <ddstreet@ieee.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Nhat Pham <nphamcs@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

On Mon, Dec 18, 2023 at 3:50=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> The zswap_load() and zswap_writeback_entry() have the same part that
> decompress the data from zswap_entry to page, so refactor out the
> common part as __zswap_load(entry, page).
>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 92 ++++++++++++++++++++++----------------------------------=
------
>  1 file changed, 32 insertions(+), 60 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 6b872744e962..3433bd6b3cef 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1392,6 +1392,35 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +static void __zswap_load(struct zswap_entry *entry, struct page *page)
> +{
> +       struct zpool *zpool =3D zswap_find_zpool(entry);
> +       struct scatterlist input, output;
> +       struct crypto_acomp_ctx *acomp_ctx;
> +       u8 *src;
> +
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
> +
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       if (!zpool_can_sleep_mapped(zpool)) {
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;
> +               zpool_unmap_handle(zpool, entry->handle);
> +       }
> +
> +       sg_init_one(&input, src, entry->length);
> +       sg_init_table(&output, 1);
> +       sg_set_page(&output, page, PAGE_SIZE, 0);
> +       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, PAGE_SIZE);
> +       BUG_ON(crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &=
acomp_ctx->wait));
> +       BUG_ON(acomp_ctx->req->dlen !=3D PAGE_SIZE);
> +       mutex_unlock(acomp_ctx->mutex);
> +
> +       if (zpool_can_sleep_mapped(zpool))
> +               zpool_unmap_handle(zpool, entry->handle);
> +}
> +
>  /*********************************
>  * writeback code
>  **********************************/
> @@ -1413,12 +1442,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         swp_entry_t swpentry =3D entry->swpentry;
>         struct page *page;
>         struct mempolicy *mpol;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
> -       struct zpool *pool =3D zswap_find_zpool(entry);
>         bool page_was_allocated;
> -       u8 *src;
> -       unsigned int dlen;
>         int ret;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
> @@ -1456,31 +1480,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         }
>         spin_unlock(&tree->lock);
>
> -       /* decompress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       dlen =3D PAGE_SIZE;
> -       mutex_lock(acomp_ctx->mutex);
> -
> -       src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
> -       if (!zpool_can_sleep_mapped(pool)) {
> -               memcpy(acomp_ctx->dstmem, src, entry->length);
> -               src =3D acomp_ctx->dstmem;
> -               zpool_unmap_handle(pool, entry->handle);
> -       }
> -
> -       sg_init_one(&input, src, entry->length);
> -       sg_init_table(&output, 1);
> -       sg_set_page(&output, page, PAGE_SIZE, 0);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, dlen);
> -       ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);
> -       dlen =3D acomp_ctx->req->dlen;
> -       mutex_unlock(acomp_ctx->mutex);
> -
> -       if (zpool_can_sleep_mapped(pool))
> -               zpool_unmap_handle(pool, entry->handle);
> -
> -       BUG_ON(ret);
> -       BUG_ON(dlen !=3D PAGE_SIZE);
> +       __zswap_load(entry, page);
>
>         /* page is up to date */
>         SetPageUptodate(page);
> @@ -1758,11 +1758,7 @@ bool zswap_load(struct folio *folio)
>         struct page *page =3D &folio->page;
>         struct zswap_tree *tree =3D zswap_trees[type];
>         struct zswap_entry *entry;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst;
> -       struct zpool *zpool;
> -       unsigned int dlen;
> +       u8 *dst;
>         bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1784,31 +1780,7 @@ bool zswap_load(struct folio *folio)
>                 goto stats;
>         }
>
> -       zpool =3D zswap_find_zpool(entry);
> -
> -       /* decompress */
> -       dlen =3D PAGE_SIZE;
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
> -
> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(acomp_ctx->dstmem, src, entry->length);
> -               src =3D acomp_ctx->dstmem;
> -               zpool_unmap_handle(zpool, entry->handle);
> -       }
> -
> -       sg_init_one(&input, src, entry->length);
> -       sg_init_table(&output, 1);
> -       sg_set_page(&output, page, PAGE_SIZE, 0);
> -       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, dlen);
> -       if (crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), &aco=
mp_ctx->wait))
> -               WARN_ON(1);
> -       mutex_unlock(acomp_ctx->mutex);
> -
> -       if (zpool_can_sleep_mapped(zpool))
> -               zpool_unmap_handle(zpool, entry->handle);
> -
> +       __zswap_load(entry, page);
>         ret =3D true;
>  stats:
>         count_vm_event(ZSWPIN);
>
> --
> b4 0.10.1

