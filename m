Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522B7BC162
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233641AbjJFVlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233710AbjJFVlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:41:01 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C563BD;
        Fri,  6 Oct 2023 14:41:00 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-35164833a21so11146215ab.0;
        Fri, 06 Oct 2023 14:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696628459; x=1697233259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4EmFZA6ZudbHCtkJzwnbsAak5FQyVkG6XojscroYQT8=;
        b=ZU6Q/6F8366DRFjnozMnQTOnZby3B4xsOyyx6bTH8VpC28IQCjXG9E4oBLOlug0DtN
         m0PjIHaggoTzIFg+mryuBvtMmlfdp9pdA1rQ0FWeprBHST2zDTyjca1rKdHDYyhiupum
         4WEv9yNmNxQAq/JIUsE9gg5DVLpgGysWwLxOyuvoDXTyZ7fUGGb9HFTZR2UnM9etsv4q
         mSnoML3MA/0HnX7x6GPPU5TNeKwm9ebcb0a2NJhMPbixxRZ50C/H1xNUhtqBaiYqAkY4
         chlm4rcQ+6bRWMMSKZNVJkfZwJkiCyeU93r2apoyqr97n8JFrCVt3s8WIO1PMO96Srby
         +3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696628459; x=1697233259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4EmFZA6ZudbHCtkJzwnbsAak5FQyVkG6XojscroYQT8=;
        b=NHAdrCIOePTjtTVK1RhHXLoRyIASd7gHd2Wv7+YnSH48fY767i8w2+4NoOVxLRh9nh
         on/lCd7xLEbZkIDZJr7pnmZwylwU+kN5I7n3k7QSms5b/dtgtzTr5fS5ANJKgF+V9nyd
         fsjl3yMTVEhoDcFkhx2C5pA8TEaQ/bw+T7kP8uKoBWe+4pFgQDSYpWLctXwWlnFlrG1Z
         eh4yGBExH+o2ebdZ83+HcC+pLva2Dg+D+pflcAH/+CtKtszJ5nhl2kr6Fmk1erIvD73r
         eg/sZhii1WgbckMAsNX7177XffRE1rj7yGmYTki/BNM42zg/5Y7H3tyWjBnxFEtcOcQC
         alLA==
X-Gm-Message-State: AOJu0Yyd8UG2GTz+Ldge5BwuREzOEtB/Rpj7XrPCz+UbZLeKROM08J4L
        MWf199jIzlye4zgfpLeNn0ycPC1XOJ5PVbjK98M=
X-Google-Smtp-Source: AGHT+IHodFA/ilXdPb/jzYomsHaHDtUIqyVnsR3U1Hj6jGv1nlXbDmO4JKj7h6sUHGLzXf1HFmiNp54Div/A6N5nzo0=
X-Received: by 2002:a05:6e02:1a05:b0:351:375f:2a31 with SMTP id
 s5-20020a056e021a0500b00351375f2a31mr4529823ild.6.1696628459466; Fri, 06 Oct
 2023 14:40:59 -0700 (PDT)
MIME-Version: 1.0
References: <20231006160024.170748-1-hannes@cmpxchg.org>
In-Reply-To: <20231006160024.170748-1-hannes@cmpxchg.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Fri, 6 Oct 2023 14:40:48 -0700
Message-ID: <CAKEwX=N_8ZORaiUDrGQON7RFgC0mXCyyHhR9s9Zki1qONEHnKw@mail.gmail.com>
Subject: Re: [PATCH] mm: zswap: fix pool refcount bug around shrink_worker()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>,
        stable@vger.kernel.org, Vitaly Wool <vitaly.wool@konsulko.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>
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

On Fri, Oct 6, 2023 at 9:00=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> When a zswap store fails due to the limit, it acquires a pool
> reference and queues the shrinker. When the shrinker runs, it drops
> the reference. However, there can be multiple store attempts before
> the shrinker wakes up and runs once. This results in reference leaks
> and eventual saturation warnings for the pool refcount.
>
> Fix this by dropping the reference again when the shrinker is already
> queued. This ensures one reference per shrinker run.
>
> Reported-by: Chris Mason <clm@fb.com>
> Fixes: 45190f01dd40 ("mm/zswap.c: add allocation hysteresis if pool limit=
 is hit")
> Cc: stable@vger.kernel.org      [5.6+]
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Cc: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Cc: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  mm/zswap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/zswap.c b/mm/zswap.c
> index 083c693602b8..37d2b1cb2ecb 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -1383,8 +1383,8 @@ bool zswap_store(struct folio *folio)
>
>  shrink:
>         pool =3D zswap_pool_last_get();
> -       if (pool)
> -               queue_work(shrink_wq, &pool->shrink_work);
> +       if (pool && !queue_work(shrink_wq, &pool->shrink_work))
> +               zswap_pool_put(pool);
>         goto reject;
>  }
>
> --
> 2.42.0
>

Acked-by: Nhat Pham <nphamcs@gmail.com>

Random tangent: this asynchronous writeback mechanism
is always kinda weird to me. We could have quite a bit of memory
inversion before the shrinker finally kicks in and frees up zswap
pool space. But I guess if it doesn't break then don't fix it.

Maybe a shrinker that proactively writes pages back as memory
pressure builds up could help ;)
