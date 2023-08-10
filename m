Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6215777C51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236161AbjHJPhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjHJPhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:37:34 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018FC26B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:37:33 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34984bff431so3609305ab.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691681852; x=1692286652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwkogVir+aH9lwGglDFwEcp1cybyKG7KluQCWJj8CDk=;
        b=ooGCXLyctROezjPLyOuJ9wcLTxpSVm11cpq1ZV7QNPqLOC4D+7Lb0N2iKFTTVru3V5
         JaNFZAI5Wot6a+ZnQLVc5AvMFagexbeCK0Ine/+siTUjfltUxCrYM2NhWfVfOnU6nnxL
         xfS5qxGV+eF7DV+DI+5jd8OsiRkSBOfnbeCEynWsMXTG4DE+zizMuqilMSxVYp66D22G
         cAB46IjI33e+HorPCMIMKR3LKVsYAQjGYpH0j5Vy3djYi9BMwyEod8YESFa9+l9N+BXR
         mJleXwuQUW3S990avKjBJyeMrQ4TU3KXgPl86sbPFkr2C1/fL1BirxHM3NbZF0V14t1/
         mCvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691681852; x=1692286652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwkogVir+aH9lwGglDFwEcp1cybyKG7KluQCWJj8CDk=;
        b=FDltclpgquZI5YBSb7yvI2Le3crlSkXrPuZ1Sohu3gPKNWdEsVQaDgGT0epdkSPyb7
         XyA/ldMoXGndZnk07gZ6qwqh8UOFaSbcJlP02nj/pccHewetEBMYKn7iSNCFrShaO/Ps
         RpMkxux+/02bWDojMZI1owAYgLCH57EcIb4uUlL0JP+Bv8evmaoaW8GlKTzx2FVloqZ6
         8Oaj+M1r9u8wlA8AQiA7MNma3820n4LHGfBB8A6tOFQit6ttvYInViO2JKNGrscHbCgG
         fTgaPjskf+RyaZQ9897HmtAJ6bc2V2642miSQCzwl3X1yBcJ0Cs72lm7CRf60vWEXz7Q
         Aszg==
X-Gm-Message-State: AOJu0YwQYwSrc0oVcb23v93grPghn/f1OhpHT/ahQyeDGi50oyfjLvQq
        HA+Lfis18KqeJnMYxbF93UftuRJZqtxzZrZhYK4=
X-Google-Smtp-Source: AGHT+IFqi190O7n12MG3quvwqfaIFbJEYNG7nlvkmhMSXaWfeUkgnh1Rjqr939fiAUMz04LXyM6Zls66OTw1KFO80sQ=
X-Received: by 2002:a92:c544:0:b0:346:fe2:125a with SMTP id
 a4-20020a92c544000000b003460fe2125amr4155929ilj.26.1691681852295; Thu, 10 Aug
 2023 08:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230727062910.6337-1-andrew.yang@mediatek.com>
In-Reply-To: <20230727062910.6337-1-andrew.yang@mediatek.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Thu, 10 Aug 2023 08:37:21 -0700
Message-ID: <CAKEwX=ObJO8R6ybwXS0iDd0Vrb_pUqJpAV9oV68hsJr2aMsRoA@mail.gmail.com>
Subject: Re: [PATCH v2] zsmalloc: Fix races between modifications of fullness
 and isolated
To:     Andrew Yang <andrew.yang@mediatek.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        wsd_upstream@mediatek.com, casper.li@mediatek.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 11:30=E2=80=AFPM Andrew Yang <andrew.yang@mediatek.=
com> wrote:
>
> Since fullness and isolated share the same unsigned int,
> modifications of them should be protected by the same lock.
>
> Signed-off-by: Andrew Yang <andrew.yang@mediatek.com>
> Fixes: c4549b871102 ("zsmalloc: remove zspage isolation for migration")
> ---
> v2: Moving comment too
> ---
>  mm/zsmalloc.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 32f5bc4074df..b58f957429f0 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c
> @@ -1777,6 +1777,7 @@ static void replace_sub_page(struct size_class *cla=
ss, struct zspage *zspage,
>
>  static bool zs_page_isolate(struct page *page, isolate_mode_t mode)
>  {
> +       struct zs_pool *pool;
>         struct zspage *zspage;
>
>         /*
> @@ -1786,9 +1787,10 @@ static bool zs_page_isolate(struct page *page, iso=
late_mode_t mode)
>         VM_BUG_ON_PAGE(PageIsolated(page), page);
>
>         zspage =3D get_zspage(page);
> -       migrate_write_lock(zspage);
> +       pool =3D zspage->pool;
> +       spin_lock(&pool->lock);
>         inc_zspage_isolation(zspage);
> -       migrate_write_unlock(zspage);
> +       spin_unlock(&pool->lock);
>
>         return true;
>  }
> @@ -1854,12 +1856,12 @@ static int zs_page_migrate(struct page *newpage, =
struct page *page,
>         kunmap_atomic(s_addr);
>
>         replace_sub_page(class, zspage, newpage, page);
> +       dec_zspage_isolation(zspage);
>         /*
>          * Since we complete the data copy and set up new zspage structur=
e,
>          * it's okay to release the pool's lock.
>          */
>         spin_unlock(&pool->lock);
> -       dec_zspage_isolation(zspage);
>         migrate_write_unlock(zspage);
>
>         get_page(newpage);
> @@ -1876,14 +1878,16 @@ static int zs_page_migrate(struct page *newpage, =
struct page *page,
>
>  static void zs_page_putback(struct page *page)
>  {
> +       struct zs_pool *pool;
>         struct zspage *zspage;
>
>         VM_BUG_ON_PAGE(!PageIsolated(page), page);
>
>         zspage =3D get_zspage(page);
> -       migrate_write_lock(zspage);
> +       pool =3D zspage->pool;
> +       spin_lock(&pool->lock);
>         dec_zspage_isolation(zspage);
> -       migrate_write_unlock(zspage);
> +       spin_unlock(&pool->lock);
>  }
>
>  static const struct movable_operations zsmalloc_mops =3D {
> --
> 2.18.0
>
>

I think this fixes an issue of mine that has been bugging me for
the past couple of weeks :) Thanks a lot, Andrew!

This should be added to other Linux stable versions too, right?
(with the caveat that before 6.2, use class's lock instead of
pool's lock).

Reviewed-by: Nhat Pham <nphamcs@gmail.com>
