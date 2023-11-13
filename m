Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1697E9FA8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbjKMPMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjKMPMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:12:13 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A0C10FB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:12:10 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-35aa43c92daso7147715ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699888329; x=1700493129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VOhXq0ReQvgC7nwSQo9GnYYnCnNRcspqiKABN5rr6I=;
        b=a81nDYqp7nxXBCaMpMlU5OcOljJzWIk4dAAmbyoVJBAgZjtjp/a/T0YhXV989qCzEg
         k7FnPXQJsDXsCOafPd5/aor7D99p43Ap/C4ryZjhZOmw2P6y6zQaVn0l6vWjA+ZIayG+
         yxqQX9ik54xsNzox0EdxajEk6cNNaAzrQGgX13ShbOgvoCgA8Pt7HwNcq7yuBX5xAwhw
         4Y4B7nvGciIiBVB0Toy9AhIyNAYxtq6YK7H8peUPE90vp01EFhFdiqndte+dztzXfpwH
         rx4dMeDI/O+p2gzPdQbw5m/7PKL1MLJNlwWJiAhECuPcLLG66gKNktAF2BCEKF4hng1i
         YwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699888329; x=1700493129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5VOhXq0ReQvgC7nwSQo9GnYYnCnNRcspqiKABN5rr6I=;
        b=doaVHt3XKM6dEt8Y6YWzffi5VPIqoz3btcJctP//xrkpME/eddMRcinnfWddhPN1CY
         stULbPdpLoMOWhI8IkdHuGdKuByyOOpxXYwOxeKwx+MU9bEpM/7gD3qThDSSIFTS0/v3
         jVHqxposuWJIyAz/CyZAGmMc9LgfCctJsirRTUnyid5sSHUjVXbAGJ+JIL9wW5NduSli
         LSO78Iov3MCde6Nc4BIPqs3Nd5ZlG+8eIvyZJpV/D1xAL/HjYumNKXCU94cHjpt57AOK
         vuVFXHqfYJxS5sVPd1nLAbo5cNeFZmnFBm9lMDyIiEQ4XIY1ybGqgAwDkpcRT2gJjFmt
         hrvA==
X-Gm-Message-State: AOJu0Yxt+SeEX5PK4/v9n1qKYsf2eb4RS/bvoxGb61Y5Bm4HwQrQSiLF
        6WhGcpkIaSt4UVLUrooahfNcSGnUJ10ZdOUk6oQ=
X-Google-Smtp-Source: AGHT+IF+/SKc67vBQ3OpVYsnnkI9yBZxnoAtrYD46UcMZ9psHUspIiI4gea9lgdyl/HeSdMNrk4Wz4eVqT1dOSVeeM0=
X-Received: by 2002:a05:6e02:3b02:b0:359:3491:9042 with SMTP id
 ct2-20020a056e023b0200b0035934919042mr8100129ilb.9.1699888329330; Mon, 13 Nov
 2023 07:12:09 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
In-Reply-To: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Mon, 13 Nov 2023 10:11:58 -0500
Message-ID: <CAKEwX=NhiGyoqR3HaDCuarqGmM5CCMYDatvVEEtVKzrL8DdDbw@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org,
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

On Mon, Nov 13, 2023 at 8:06=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
>
> I recently found two scenarios where zswap entry could not be
> released, which will cause shrink_worker and active recycling
> to fail.
> 1)The swap entry has been freed, but cached in swap_slots_cache,
> no swap cache and swapcount=3D0.
> 2)When the option zswap_exclusive_loads_enabled disabled and
> zswap_load completed(page in swap_cache and swapcount =3D 0).
>
> The above two cases need to be determined by swapcount=3D0,
> fix it.
>
> Signed-off-by: Zhongkun He <hezhongkun.hzk@bytedance.com>
> ---
>  mm/zswap.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 74411dfdad92..db95491bcdd5 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1063,11 +1063,12 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         struct mempolicy *mpol;
>         struct scatterlist input, output;
>         struct crypto_acomp_ctx *acomp_ctx;
> +       struct swap_info_struct *si;
>         struct zpool *pool =3D zswap_find_zpool(entry);
>         bool page_was_allocated;
>         u8 *src, *tmp =3D NULL;
>         unsigned int dlen;
> -       int ret;
> +       int ret =3D 0;
>         struct writeback_control wbc =3D {
>                 .sync_mode =3D WB_SYNC_NONE,
>         };
> @@ -1082,16 +1083,30 @@ static int zswap_writeback_entry(struct zswap_ent=
ry *entry,
>         mpol =3D get_task_policy(current);
>         page =3D __read_swap_cache_async(swpentry, GFP_KERNEL, mpol,
>                                 NO_INTERLEAVE_INDEX, &page_was_allocated)=
;
> -       if (!page) {
> +       if (!page)
>                 ret =3D -ENOMEM;
> -               goto fail;
> -       }
> -
> -       /* Found an existing page, we raced with load/swapin */
> -       if (!page_was_allocated) {
> +       else if (!page_was_allocated) {
> +               /* Found an existing page, we raced with load/swapin */
>                 put_page(page);
>                 ret =3D -EEXIST;
> -               goto fail;
> +       }
> +
> +       if (ret) {
> +               si =3D get_swap_device(swpentry);
> +               if (!si)
> +                       goto out;
> +
> +               /* Two cases to directly release zswap_entry.
> +                * 1) -ENOMEM,if the swpentry has been freed, but cached =
in
> +                * swap_slots_cache(no page and swapcount =3D 0).
> +                * 2) -EEXIST, option zswap_exclusive_loads_enabled disab=
led and
> +                * zswap_load completed(page in swap_cache and swapcount =
=3D 0).
> +                */

These two cases should not count as "successful writeback" right?

I'm slightly biased of course, since my zswap shrinker depends on this
as one of the potential signals for over-shrinking - but that aside, I thin=
k
that this constitutes a failed writeback (i.e should not increment writebac=
k
counter, and the limit-based reclaim should try again etc.). If anything,
it will make it incredibly confusing for users.

For instance, we were trying to estimate the number of zswap store
fails by subtracting the writeback count from the overall pswpout, and
this could throw us off by inflating the writeback count, and deflating
the zswap store failure count as a result.

Regarding the second case specifically, I thought that was the point of
having zswap_exclusive_loads_enabled disabled - i.e still keeps a copy
around in the zswap pool even after a completed zswap_load? Based
on the Kconfig documentation:

"This avoids having two copies of the same page in memory
(compressed and uncompressed) after faulting in a page from zswap.
The cost is that if the page was never dirtied and needs to be
swapped out again, it will be re-compressed."

> +               if (!swap_swapcount(si, swpentry))
> +                       ret =3D 0;
> +
> +               put_swap_device(si);
> +               goto out;
>         }
>
>         /*
> @@ -1106,7 +1121,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>                 spin_unlock(&tree->lock);
>                 delete_from_swap_cache(page_folio(page));
>                 ret =3D -ENOMEM;
> -               goto fail;
> +               goto out;
>         }
>         spin_unlock(&tree->lock);
>
> @@ -1151,7 +1166,7 @@ static int zswap_writeback_entry(struct zswap_entry=
 *entry,
>
>         return ret;
>
> -fail:
> +out:
>         if (!zpool_can_sleep_mapped(pool))
>                 kfree(tmp);
>
> --
> 2.25.1
>
