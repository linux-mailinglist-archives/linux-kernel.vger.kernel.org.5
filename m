Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC9180FB17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 00:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjLLXNb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 18:13:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232438AbjLLXN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 18:13:29 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA78AF
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:13:35 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7b712c0fddeso211403439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 15:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702422815; x=1703027615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2yKkUH4ttv5kn1OVlzPtWcAYwRMyQOcULtuLd7pN7WM=;
        b=RiEagFwUfcstv9Rxzvrv7iajmmZpvaN3vwmMKF82QUWAQMEvZhAdDkH7Q6MrIr7mr8
         gMJtrFl2ZMDX7t/2DDXlezwJxLuX/u6hFuSGwlolEAWcwkrE0NTrqsNYgXOHp072rUrH
         brNR0hYdmZws2GAF3H6FvfdEUS738c7XwZ/fgaMTM8lJ7KpfpfBd0jLXNLqi+t3U9L1f
         +IUvBNgDnfVv/RCJYmLUqP+DQc1lDM5H7dwSu2Ak9vO3umJq638I1M5hs6f0aUhd7iWI
         aZyjzEKRdwWRoc5sa32NmcaqnMESDGtwPtswqXBYvGOw6d2KB7bQe7GwSFnAyIoHcQmY
         khEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702422815; x=1703027615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2yKkUH4ttv5kn1OVlzPtWcAYwRMyQOcULtuLd7pN7WM=;
        b=hDFgpDVioPH3Ie8HNZOmg+vbGVjm6P8KZzX5eN43s0+cgkn8/1ZzvsDGqxJ/kO6G0W
         fauSxHl2uwRSGyxJPNxo1jl92QYtum/XOpgPj9/0odGAXpha55LGNiWn9XBPTa1eSWwM
         oJDf+1DPLAL4kW5YlS9XmjSFOULPevpg8kCcSK2k+bSYcrLOnGAOfHa+QYqls2p9wi+k
         ITyMRKU4FWSSd1pfW7C9ahUFSJgTjGKh2JvpYcBQNxvAHjXP7iSU/qzWK9Mt1f5wfmGg
         w5yTTCcrIWzB0Y+5PqwBrI0m2cGhCdylCTaeI9Zb7SJu+wSF+Qf+Ug3AhkasUSI/dfSC
         wrAg==
X-Gm-Message-State: AOJu0Yyywz0z4TsCmYhkan3V659V7UQ8rjv14HEaCX1oJb3QylN/dltB
        NTDx0O9pAt54Ti6bpdDnn3Q/MuqahcD6UEV/z7Q=
X-Google-Smtp-Source: AGHT+IE+lbniKpziMlK5GHQNqCuorEoY2h0xLtALVCgmnIk7X5wKZ5sLaPC3AQib1iX8zJ6jE6syU/oonRX4DC+zSUM=
X-Received: by 2002:a6b:5015:0:b0:7b7:ae3:43c with SMTP id e21-20020a6b5015000000b007b70ae3043cmr7456801iob.42.1702422814772;
 Tue, 12 Dec 2023 15:13:34 -0800 (PST)
MIME-Version: 1.0
References: <20231206-zswap-lock-optimize-v1-0-e25b059f9c3a@bytedance.com> <20231206-zswap-lock-optimize-v1-5-e25b059f9c3a@bytedance.com>
In-Reply-To: <20231206-zswap-lock-optimize-v1-5-e25b059f9c3a@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 12 Dec 2023 15:13:23 -0800
Message-ID: <CAKEwX=Pj4ALja09PE0gsb_GL+XGv8GaV7bwSBw9Hb5fEDBRQxg@mail.gmail.com>
Subject: Re: [PATCH 5/7] mm/zswap: refactor out __zswap_load()
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Vitaly Wool <vitaly.wool@konsulko.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 1:46=E2=80=AFAM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> The zswap_load() and zswap_writeback_entry() have the same part that
> decompress the data from zswap_entry to page, so refactor out the
> common part as __zswap_load(entry, page).

I love this refactoring a lot :) No reason why we should duplicate the
decompression logic shared between load and writeback.

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> ---
>  mm/zswap.c | 108 ++++++++++++++++++++++---------------------------------=
------
>  1 file changed, 39 insertions(+), 69 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 999671dcb469..667b66a3911b 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1380,6 +1380,42 @@ static int zswap_enabled_param_set(const char *val=
,
>         return ret;
>  }
>
> +static void __zswap_load(struct zswap_entry *entry, struct page *page)
> +{
> +       struct scatterlist input, output;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       struct crypto_acomp_ctx *acomp_ctx;
> +       struct zpool *zpool;
> +       u8 *src;
> +       int ret;
> +
> +       /* decompress */

nit: I guess all this function does is decompression right? Doesn't
seem like this comment is necessary anymore... But this is just
nitpicking.

> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
> +
> +       zpool =3D zswap_find_zpool(entry);
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
length, dlen);
> +       ret =3D crypto_wait_req(crypto_acomp_decompress(acomp_ctx->req), =
&acomp_ctx->wait);
> +       dlen =3D acomp_ctx->req->dlen;
> +       mutex_unlock(acomp_ctx->mutex);
> +
> +       if (zpool_can_sleep_mapped(zpool))
> +               zpool_unmap_handle(zpool, entry->handle);
> +
> +       BUG_ON(ret);
> +       BUG_ON(dlen !=3D PAGE_SIZE);
> +}
> +
>  /*********************************
>  * writeback code
>  **********************************/
> @@ -1401,23 +1437,12 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         swp_entry_t swpentry =3D entry->swpentry;
>         struct page *page;
>         struct mempolicy *mpol;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
> -       struct zpool *pool =3D zswap_find_zpool(entry);
>         bool page_was_allocated;
> -       u8 *src, *tmp =3D NULL;
> -       unsigned int dlen;
>         int ret;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
>
> -       if (!zpool_can_sleep_mapped(pool)) {
> -               tmp =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
> -               if (!tmp)
> -                       return -ENOMEM;
> -       }
> -

Sweet. Less allocation =3D=3D more efficient + less failure case :)

>         /* try to allocate swap cache page */
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
> @@ -1450,33 +1475,7 @@ static int zswap_writeback_entry(struct zswap_entr=
y *entry,
>         }
>         spin_unlock(&tree->lock);
>
> -       /* decompress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       dlen =3D PAGE_SIZE;
> -
> -       src =3D zpool_map_handle(pool, entry->handle, ZPOOL_MM_RO);
> -       if (!zpool_can_sleep_mapped(pool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> -               zpool_unmap_handle(pool, entry->handle);
> -       }
> -
> -       mutex_lock(acomp_ctx->mutex);
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
> -       if (!zpool_can_sleep_mapped(pool))
> -               kfree(tmp);
> -       else
> -               zpool_unmap_handle(pool, entry->handle);
> -
> -       BUG_ON(ret);
> -       BUG_ON(dlen !=3D PAGE_SIZE);
> +       __zswap_load(entry, page);
>
>         /* page is up to date */
>         SetPageUptodate(page);
> @@ -1496,9 +1495,6 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>         return ret;
>
>  fail:
> -       if (!zpool_can_sleep_mapped(pool))
> -               kfree(tmp);
> -
>         /*
>          * If we get here because the page is already in swapcache, a
>          * load may be happening concurrently. It is safe and okay to
> @@ -1755,11 +1751,7 @@ bool zswap_load(struct folio *folio)
>         struct page *page =3D &folio->page;
>         struct zswap_tree *tree =3D swap_zswap_tree(swp);
>         struct zswap_entry *entry;
> -       struct scatterlist input, output;
> -       struct crypto_acomp_ctx *acomp_ctx;
> -       unsigned int dlen =3D PAGE_SIZE;
> -       u8 *src, *dst;
> -       struct zpool *zpool;
> +       u8 *dst;
>         bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1781,29 +1773,7 @@ bool zswap_load(struct folio *folio)
>                 goto stats;
>         }
>
> -       /* decompress */
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
> -
> -       zpool =3D zswap_find_zpool(entry);
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

Can't find anything wrong with this patch, so:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
