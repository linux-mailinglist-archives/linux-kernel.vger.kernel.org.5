Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9A2481393E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjLNR72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjLNR70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:59:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088C2AF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC60C433CC
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 17:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702576772;
        bh=uqBnNJDLNbYm6pyh21nyjtNJssu0wb0DQLI/0nBbEYM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Egxc0hmdtjS1VLxrw5xpoHYoVRRHFSWiVpf95NRcSlM82ZnZa98Puor5DJi2SrD8b
         HWW6Qg1TEqF3OS1gRiwQTqhDe/Vn+OSRTpc9gCvzwefcg+ZPDE4wMqDYsGFUiS9Lf2
         fGVfaM7KUQq0jwGIPw0w3NrvWh88p1w1pU2wxCP7HhBqGv9adNmoTEjPPJKHXeRSQC
         Dk2D0KjHJ+QZnYU2BYr6eCm49pGMlMWyVATqyd0vHboVKH09UWsDQ2KqrzIpodKJAz
         wEtLkZVEjppXDqRKwRIxKTcM1amXHDF5TOkbS4o8dzQsyap1hK/pl/k/nADfm855z7
         Zobfpd1+pNmjQ==
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-28af0b85f58so1132107a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:59:32 -0800 (PST)
X-Gm-Message-State: AOJu0YyicZGlnRmgi/cGd9XEqFSsspoEW2f5d0MymdsjrL5QiUKpaiJp
        G0hyimYJBDHVlm8ayU8VAN16kET8uY9TPnStidQzdA==
X-Google-Smtp-Source: AGHT+IFNWxaSic8oiERsgiihMfNvZhB76oUvs/IXNgurMwl22WlqJP8LNReHsIoSnBTAheGNCnSNkrgbgc2C15Faw6M=
X-Received: by 2002:a17:90b:1d83:b0:28b:f9b:d6db with SMTP id
 pf3-20020a17090b1d8300b0028b0f9bd6dbmr483554pjb.8.1702576771751; Thu, 14 Dec
 2023 09:59:31 -0800 (PST)
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com> <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
In-Reply-To: <20231213-zswap-dstmem-v1-1-896763369d04@bytedance.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 14 Dec 2023 09:59:20 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
Message-ID: <CAF8kJuPCPGdsT9Yxmeu1t9XT9xpsq2mSXcz1agcm5iKb13owPQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm/zswap: reuse dstmem when decompress
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
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

On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
<zhouchengming@bytedance.com> wrote:
>
> In the !zpool_can_sleep_mapped() case such as zsmalloc, we need to first
> copy the entry->handle memory to a temporary memory, which is allocated
> using kmalloc.
>
> Obviously we can reuse the per-compressor dstmem to avoid allocating
> every time, since it's percpu-compressor and protected in mutex.

You are trading more memory for faster speed.
Per-cpu data structure does not come free. It is expensive in terms of
memory on a big server with a lot of CPU. Think more than a few
hundred CPU. On the big servers, we might want to disable this
optimization to save a few MB RAM, depending on the gain of this
optimization.
Do we have any benchmark suggesting how much CPU overhead or latency
this per-CPU page buys us, compared to using kmalloc?

Chris

>
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
> Reviewed-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  mm/zswap.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 7ee54a3d8281..edb8b45ed5a1 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1772,9 +1772,9 @@ bool zswap_load(struct folio *folio)
>         struct zswap_entry *entry;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> -       u8 *src, *dst, *tmp;
> +       unsigned int dlen =3D PAGE_SIZE;
> +       u8 *src, *dst;
>         struct zpool *zpool;
> -       unsigned int dlen;
>         bool ret;
>
>         VM_WARN_ON_ONCE(!folio_test_locked(folio));
> @@ -1796,27 +1796,18 @@ bool zswap_load(struct folio *folio)
>                 goto stats;
>         }
>
> -       zpool =3D zswap_find_zpool(entry);
> -       if (!zpool_can_sleep_mapped(zpool)) {
> -               tmp =3D kmalloc(entry->length, GFP_KERNEL);
> -               if (!tmp) {
> -                       ret =3D false;
> -                       goto freeentry;
> -               }
> -       }
> -
>         /* decompress */
> -       dlen =3D PAGE_SIZE;
> -       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
> +       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> +       mutex_lock(acomp_ctx->mutex);
>
> +       zpool =3D zswap_find_zpool(entry);
> +       src =3D zpool_map_handle(zpool, entry->handle, ZPOOL_MM_RO);
>         if (!zpool_can_sleep_mapped(zpool)) {
> -               memcpy(tmp, src, entry->length);
> -               src =3D tmp;
> +               memcpy(acomp_ctx->dstmem, src, entry->length);
> +               src =3D acomp_ctx->dstmem;
>                 zpool_unmap_handle(zpool, entry->handle);
>         }
>
> -       acomp_ctx =3D raw_cpu_ptr(entry->pool->acomp_ctx);
> -       mutex_lock(acomp_ctx->mutex);
>         sg_init_one(&input, src, entry->length);
>         sg_init_table(&output, 1);
>         sg_set_page(&output, page, PAGE_SIZE, 0);
> @@ -1827,15 +1818,13 @@ bool zswap_load(struct folio *folio)
>
>         if (zpool_can_sleep_mapped(zpool))
>                 zpool_unmap_handle(zpool, entry->handle);
> -       else
> -               kfree(tmp);
>
>         ret =3D true;
>  stats:
>         count_vm_event(ZSWPIN);
>         if (entry->objcg)
>                 count_objcg_event(entry->objcg, ZSWPIN);
> -freeentry:
> +
>         spin_lock(&tree->lock);
>         if (ret && zswap_exclusive_loads_enabled) {
>                 zswap_invalidate_entry(tree, entry);
>
> --
> b4 0.10.1
