Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BDD765B60
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjG0SaW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:30:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjG0SaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:30:18 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6318D3580
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:30:02 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-986d8332f50so172379466b.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 11:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690482601; x=1691087401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gQuUTbCVCGcnG+7JdbJB28lXA8NxfAQJ6tDUsY15cRw=;
        b=lxY8OpuxyOl+aLXedM/7YSYB5xsPDvxBBgSCoal9QVpCqjXJu0vDvSLXSlAkgQ+knH
         vp6JJeN6C6tHemFkC2E5R86qmswabSEG8Tw/xKlntiEZVwCUUX3CcnTJ95DcIzJ5jZDH
         h1nNDfdKoVAAvKzXmkwd/6LwvJCYVoBY4jotE27is864RugaIoNNdjKLfnH4PHrncbro
         8hxAQT+Qrh3de9u7hE/YK28Tp8qpRU+ncMIx6on8qjsyZtRPZdZTwiWIN9Jyce+YQsOb
         +xdlsW9DUxE002/zAPopJ+x63wqQIyuENJhWj7MU2Pdbjl4U1Dvbb3wgfOrIhMgEIbPP
         y91Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690482601; x=1691087401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gQuUTbCVCGcnG+7JdbJB28lXA8NxfAQJ6tDUsY15cRw=;
        b=W8rw/0uOmuRLfDi9wxkeTysVrRCFPTcSngoN2qF7yF71Nmuo8Zjgb8+TzNdFTImmJv
         o/vsdjLmJ1P68zJH6GhlGlo8uY/IUxrqboBFDFUAM3GCxrrAEBRDVty/EI8Ghsme9g7q
         c9Hvi3+A8wh5S1VBLLoCI2yWcNi7jraV+Wt/pBwqViUs6zJBDqjsJc1H3dLiu8yj1za+
         uHKcQE2Xeb/IeqquvBZFRjsVrNZR3gjWs2jFSqf7lwhnSZHatD2vtbChFzwiRJyew19d
         cQ5Cx4Je1wNSJ9Scoud+A6nJpn3hzoNgcI69bZVYLi5p2xtANG1mRJlhWaNCGztF7xbC
         C9gQ==
X-Gm-Message-State: ABy/qLYpxHKPpxOvwjpzcRAvHl729fc7yJzGWljhLS9KjH6MbKfvfYn0
        6DzqLLb73a1AoQJeUgOsw9euSY0Ng7JhfJeA/zN//A==
X-Google-Smtp-Source: APBJJlFPEsT8C6iMwpUThAHnHk70lIkWwoq2M5crzE+bNa7W/QtZewT74DMVt0WzVSWjfhDht/ItI/D+MJbQON76Phw=
X-Received: by 2002:a17:906:3f0c:b0:99b:44aa:fae0 with SMTP id
 c12-20020a1709063f0c00b0099b44aafae0mr19137ejj.21.1690482600566; Thu, 27 Jul
 2023 11:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230727162343.1415598-1-hannes@cmpxchg.org> <20230727162343.1415598-4-hannes@cmpxchg.org>
In-Reply-To: <20230727162343.1415598-4-hannes@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Jul 2023 11:29:24 -0700
Message-ID: <CAJD7tkZqAfJ9uR8B0=nq_ZhTfFQWG=Tns4_tcm9YoA7PURx63Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: zswap: kill zswap_get_swap_cache_page()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
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

On Thu, Jul 27, 2023 at 9:23=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> The __read_swap_cache_async() interface isn't more difficult to
> understand than what the helper abstracts. Save the indirection and a
> level of indentation for the primary work of the writeback func.
>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Arguably any abstraction to the swap code is better than dealing with
the swap code, but I am not against this :P

The diffstat looks nice and the code looks correct to me.

Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

> ---
>  mm/zswap.c | 142 ++++++++++++++++++++---------------------------------
>  1 file changed, 53 insertions(+), 89 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index e34ac89e6098..bba4ead672be 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1016,43 +1016,6 @@ static int zswap_enabled_param_set(const char *val=
,
>  /*********************************
>  * writeback code
>  **********************************/
> -/* return enum for zswap_get_swap_cache_page */
> -enum zswap_get_swap_ret {
> -       ZSWAP_SWAPCACHE_NEW,
> -       ZSWAP_SWAPCACHE_EXIST,
> -       ZSWAP_SWAPCACHE_FAIL,
> -};
> -
> -/*
> - * zswap_get_swap_cache_page
> - *
> - * This is an adaption of read_swap_cache_async()
> - *
> - * This function tries to find a page with the given swap entry
> - * in the swapper_space address space (the swap cache).  If the page
> - * is found, it is returned in retpage.  Otherwise, a page is allocated,
> - * added to the swap cache, and returned in retpage.
> - *
> - * If success, the swap cache page is returned in retpage
> - * Returns ZSWAP_SWAPCACHE_EXIST if page was already in the swap cache
> - * Returns ZSWAP_SWAPCACHE_NEW if the new page needs to be populated,
> - *     the new page is added to swapcache and locked
> - * Returns ZSWAP_SWAPCACHE_FAIL on error
> - */
> -static int zswap_get_swap_cache_page(swp_entry_t entry,
> -                               struct page **retpage)
> -{
> -       bool page_was_allocated;
> -
> -       *retpage =3D __read_swap_cache_async(entry, GFP_KERNEL,
> -                       NULL, 0, &page_was_allocated);
> -       if (page_was_allocated)
> -               return ZSWAP_SWAPCACHE_NEW;
> -       if (!*retpage)
> -               return ZSWAP_SWAPCACHE_FAIL;
> -       return ZSWAP_SWAPCACHE_EXIST;
> -}
> -
>  /*
>   * Attempts to free an entry by adding a page to the swap cache,
>   * decompressing the entry data into the page, and issuing a
> @@ -1073,7 +1036,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
>         struct zpool *pool =3D entry->pool->zpool;
> -
> +       bool page_was_allocated;
>         u8 *src, *tmp =3D NULL;
>         unsigned int dlen;
>         int ret;
> @@ -1088,65 +1051,66 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         }
>
>         /* try to allocate swap cache page */
> -       switch (zswap_get_swap_cache_page(swpentry, &page)) {
> -       case ZSWAP_SWAPCACHE_FAIL: /* no memory or invalidate happened */
> +       page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, NULL, 0,
> +                                      &page_was_allocated);
> +       if (!page) {
>                 ret =3D -ENOMEM;
>                 goto fail;
> +       }
>
> -       case ZSWAP_SWAPCACHE_EXIST:
> -               /* page is already in the swap cache, ignore for now */
> +       /* Found an existing page, we raced with load/swapin */
> +       if (!page_was_allocated) {
>                 put_page(page);
>                 ret =3D -EEXIST;
>                 goto fail;
> +       }
>
> -       case ZSWAP_SWAPCACHE_NEW: /* page is locked */
> -               /*
> -                * Having a local reference to the zswap entry doesn't ex=
clude
> -                * swapping from invalidating and recycling the swap slot=
. Once
> -                * the swapcache is secured against concurrent swapping t=
o and
> -                * from the slot, recheck that the entry is still current=
 before
> -                * writing.
> -                */
> -               spin_lock(&tree->lock);
> -               if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpe=
ntry)) !=3D entry) {
> -                       spin_unlock(&tree->lock);
> -                       delete_from_swap_cache(page_folio(page));
> -                       ret =3D -ENOMEM;
> -                       goto fail;
> -               }
> +       /*
> +        * Page is locked, and the swapcache is now secured against
> +        * concurrent swapping to and from the slot. Verify that the
> +        * swap entry hasn't been invalidated and recycled behind our
> +        * backs (our zswap_entry reference doesn't prevent that), to
> +        * avoid overwriting a new swap page with old compressed data.
> +        */
> +       spin_lock(&tree->lock);
> +       if (zswap_rb_search(&tree->rbroot, swp_offset(entry->swpentry)) !=
=3D entry) {
>                 spin_unlock(&tree->lock);
> +               delete_from_swap_cache(page_folio(page));
> +               ret =3D -ENOMEM;
> +               goto fail;
> +       }
> +       spin_unlock(&tree->lock);
>
> -               /* decompress */
> -               acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -               dlen =3D PAGE_SIZE;
> +       /* decompress */
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       dlen =3D PAGE_SIZE;
>
> -               src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO=
);
> -               if (!zpool_can_sleep_mapped(pool)) {
> -                       memcpy(tmp, src, entry->length);
> -                       src =3D tmp;
> -                       zpool_unmap_handle(pool, entry->handle);
> -               }
> +       src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
> +       if (!zpool_can_sleep_mapped(pool)) {
> +               memcpy(tmp, src, entry->length);
> +               src =3D tmp;
> +               zpool_unmap_handle(pool, entry->handle);
> +       }
>
> -               mutex_lock(acomp_ctx->mutex);
> -               sg_init_one(&input, src, entry->length);
> -               sg_init_table(&output, 1);
> -               sg_set_page(&output, page, PAGE_SIZE, 0);
> -               acomp_request_set_params(acomp_ctx->req, &input, &output,=
 entry->length, dlen);
> -               ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx=
->req), &acomp_ctx->wait);
> -               dlen =3D acomp_ctx->req->dlen;
> -               mutex_unlock(acomp_ctx->mutex);
> -
> -               if (!zpool_can_sleep_mapped(pool))
> -                       kfree(tmp);
> -               else
> -                       zpool_unmap_handle(pool, entry->handle);
> +       mutex_lock(acomp_ctx->mutex);
> +       sg_init_one(&input, src, entry->length);
> +       sg_init_table(&output, 1);
> +       sg_set_page(&output, page, PAGE_SIZE, 0);
> +       acomp_request_set_params(acomp_ctx->req, &input, &output, entry->=
length, dlen);
> +       ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);
> +       dlen =3D acomp_ctx->req->dlen;
> +       mutex_unlock(acomp_ctx->mutex);
> +
> +       if (!zpool_can_sleep_mapped(pool))
> +               kfree(tmp);
> +       else
> +               zpool_unmap_handle(pool, entry->handle);
>
> -               BUG_ON(ret);
> -               BUG_ON(dlen !=3D PAGE_SIZE);
> +       BUG_ON(ret);
> +       BUG_ON(dlen !=3D PAGE_SIZE);
>
> -               /* page is up to date */
> -               SetPageUptodate(page);
> -       }
> +       /* page is up to date */
> +       SetPageUptodate(page);
>
>         /* move it to the tail of the inactive list after end_writeback *=
/
>         SetPageReclaim(page);
> @@ -1157,16 +1121,16 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         zswap_written_back_pages++;
>
>         return ret;
> +
>  fail:
>         if (!zpool_can_sleep_mapped(pool))
>                 kfree(tmp);
>
>         /*
> -       * if we get here due to ZSWAP_SWAPCACHE_EXIST
> -       * a load may be happening concurrently.
> -       * it is safe and okay to not free the entry.
> -       * it is also okay to return !0
> -       */
> +        * If we get here because the page is already in swapcache, a
> +        * load may be happening concurrently. It is safe and okay to
> +        * not free the entry. It is also okay to return !0.
> +        */
>         return ret;
>  }
>
> --
> 2.41.0
>
