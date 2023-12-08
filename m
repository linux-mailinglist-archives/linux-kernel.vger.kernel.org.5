Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B7F809736
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 01:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232754AbjLHA2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 19:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235722AbjLHAZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 19:25:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA94171C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 16:25:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D93C43395
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701995127;
        bh=YQ43gqFi340wtHS4UTT/96YjcDawsBIO7bwc4RETQ5M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sxF/mK0kIuq+FAFL3vXGu4VJXAWDLpJkunN6On2kVqmQHlw4qXsW6rmigTA7cQ+UZ
         zqtk1mxrDfWgCMXn/lw38JDyQTCxm21NVKYpDy5QUh+1x145qkOe7IwGSSmMqTjVdZ
         U1u+TSwhjarzBonjPeNCY+Gs6W1VUmgff2/uF4IXLy1zKAKc9LQJEggzcMFaiPmwh6
         NyyQvSldM2gr6c35yByvAVa3QGn9s3Moa+qzOPNT7FNrxND3uVVKLLu0o06TK4yvqN
         lzHSb2BgM11lLLsskq10Md4pyVlK74hlB6jUOvFq5a1mCpdPL4cfF2z+0menBvxS70
         HPnwgdxeUcHaA==
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c6ce4dffb5so1163537a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 16:25:27 -0800 (PST)
X-Gm-Message-State: AOJu0YywKYCkJs8UsUHBM80phGNPvoBQ9g/7I2b01wMKmmAgXFsIE4IQ
        5nwA7RX8c/0zkTqKq/BfbcaV4NBdrUKiA5CbHCkBcw==
X-Google-Smtp-Source: AGHT+IEpsq1zGY0OfKQxvKp1EvVbsLwVD6nMl1S5J/UVuBu11zU3BbaxP90u+Kn0UjEV195rA6g1hCojqNHtHKljjg4=
X-Received: by 2002:a05:6a20:1604:b0:18f:a271:31a9 with SMTP id
 l4-20020a056a20160400b0018fa27131a9mr3577935pzj.74.1701995127255; Thu, 07 Dec
 2023 16:25:27 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-5-nphamcs@gmail.com> <20231205193307.2432803-1-nphamcs@gmail.com>
In-Reply-To: <20231205193307.2432803-1-nphamcs@gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 7 Dec 2023 16:25:16 -0800
X-Gmail-Original-Message-ID: <CAF8kJuM9hRx48uG5vqp1E26gtaHMQG-B+AAQUoZKNdkD0YeaPw@mail.gmail.com>
Message-ID: <CAF8kJuM9hRx48uG5vqp1E26gtaHMQG-B+AAQUoZKNdkD0YeaPw@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat (fix)
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org
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

Acked-by: Chris Li <chrisl@kernel.org> (Google)

Chris

On Tue, Dec 5, 2023 at 11:33=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> Rename ZSWP_WB to ZSWPWB to better match the existing counters naming
> scheme.
>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/vm_event_item.h | 2 +-
>  mm/memcontrol.c               | 2 +-
>  mm/vmstat.c                   | 2 +-
>  mm/zswap.c                    | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index f4569ad98edf..747943bc8cc2 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -142,7 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT=
,
>  #ifdef CONFIG_ZSWAP
>                 ZSWPIN,
>                 ZSWPOUT,
> -               ZSWP_WB,
> +               ZSWPWB,
>  #endif
>  #ifdef CONFIG_X86
>                 DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 21d79249c8b4..0286b7d38832 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -703,7 +703,7 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         ZSWPIN,
>         ZSWPOUT,
> -       ZSWP_WB,
> +       ZSWPWB,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 2249f85e4a87..cfd8d8256f8e 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1401,7 +1401,7 @@ const char * const vmstat_text[] =3D {
>  #ifdef CONFIG_ZSWAP
>         "zswpin",
>         "zswpout",
> -       "zswp_wb",
> +       "zswpwb",
>  #endif
>  #ifdef CONFIG_X86
>         "direct_map_level2_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index c65b8ccc6b72..0fb0945c0031 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -761,9 +761,9 @@ static enum lru_status shrink_memcg_cb(struct list_he=
ad *item, struct list_lru_o
>         zswap_written_back_pages++;
>
>         if (entry->objcg)
> -               count_objcg_event(entry->objcg, ZSWP_WB);
> +               count_objcg_event(entry->objcg, ZSWPWB);
>
> -       count_vm_event(ZSWP_WB);
> +       count_vm_event(ZSWPWB);
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
> --
> 2.34.1
>
