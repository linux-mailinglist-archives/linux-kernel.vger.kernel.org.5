Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6790E805D93
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbjLESWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:22:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235650AbjLESW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:22:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0791736
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:22:30 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54bfa9b3ffaso7701386a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701800549; x=1702405349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmg48ucaNtz1eYQ0lcHiyMSvr8VMzgFNPLFgYJsB9ug=;
        b=EkrgHiuEMA77/SeoJWOAxYB1N+afZ+15akiee+8nSXBz/ucfjMRvjQJr83dxbITaqC
         4i9N0Ex4nqfQ3zgJQzu9/k31MlcdVPP0v9Df3rku4g3iQ6qX+C+HajyddKJvkeBhCC4u
         2RIs6ue7iQi161nt6NSldsuNVDXQh/r+t7JBdmyN5XdpLtV87xkKIeyZSkvI2h3X2nS9
         TvVB5s5xysIaumHqgHnlSLZCDhlLBkLUS7vV70Ycj7QTS/1XYGCdn3Xu2VbGpSF65hKp
         r8yefL4USBrBtmjSAt978SKf5766GLc1beI7b99agTlJ++qzMYKy8sirIDEvDHSHPTkV
         KWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701800549; x=1702405349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zmg48ucaNtz1eYQ0lcHiyMSvr8VMzgFNPLFgYJsB9ug=;
        b=VnoAAq8TE9MQBQkLfWsyVgWwSdD/eHdS0oakzkSFcYLByOcWZF4ylcr2w70/TmQuLo
         Ik3XzLreiAhdPvkQ4x1qAGUt2RBrmDPS2FHDH3QcfcNADhM8+6D6FbjvRtYnCJU360s7
         5+wyWJ4y8dMNYPZQWuFznXjga8Fbw70nnr3hzHAEgwMKhmqxeO6YAhSiMgVXnyZU7r+0
         zmIDagAy6iR+Db63IUg3Pe55+lBBpenqRgt2336aOSKd9WyGGOLXFOsFot8ODLC6ue04
         wav5icIOV160rjJ5SxxcE2RjEEdeiKS4QTWb4aKzWGx2RdE2NHB30ZdMazky3FpC8hiq
         SkxA==
X-Gm-Message-State: AOJu0Yz3UPwmH/Tq0WMsELUK63IyZyV2OKXz/jBki6LC1u1HEqWnOKny
        XKBceV1tGxffzDyu4RefX8J/bZtOLlPrZXpnMpGaTw==
X-Google-Smtp-Source: AGHT+IFxluMz9sMmuxSFOhQkmwPCAcZ5/u8Ab6p6UNrzKjlnMibiuPAGPqvvqV6rtEaQ2cNgW+y+zDH5NzMnbiRMc44=
X-Received: by 2002:a17:906:7:b0:a1a:c8fc:2e2b with SMTP id
 7-20020a170906000700b00a1ac8fc2e2bmr2763817eja.132.1701800548623; Tue, 05 Dec
 2023 10:22:28 -0800 (PST)
MIME-Version: 1.0
References: <20231130194023.4102148-1-nphamcs@gmail.com> <20231130194023.4102148-5-nphamcs@gmail.com>
In-Reply-To: <20231130194023.4102148-5-nphamcs@gmail.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 5 Dec 2023 10:21:52 -0800
Message-ID: <CAJD7tkZeXY0HbBQu_pZr+kDgoPoDR+kQZq4XxYo6ZXfrO2=BKQ@mail.gmail.com>
Subject: Re: [PATCH v8 4/6] mm: memcg: add per-memcg zswap writeback stat
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org
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

On Thu, Nov 30, 2023 at 11:40=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrot=
e:
>
> From: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
>
> Since zswap now writes back pages from memcg-specific LRUs, we now need a
> new stat to show writebacks count for each memcg.
>
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Signed-off-by: Domenico Cerasuolo <cerasuolodomenico@gmail.com>
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> ---
>  include/linux/vm_event_item.h | 1 +
>  mm/memcontrol.c               | 1 +
>  mm/vmstat.c                   | 1 +
>  mm/zswap.c                    | 4 ++++
>  4 files changed, 7 insertions(+)
>
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.=
h
> index d1b847502f09..f4569ad98edf 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -142,6 +142,7 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT=
,
>  #ifdef CONFIG_ZSWAP
>                 ZSWPIN,
>                 ZSWPOUT,
> +               ZSWP_WB,

I think you dismissed Johannes's comment from v7 about ZSWPWB and
"zswpwb" being more consistent with the existing events.

>  #endif
>  #ifdef CONFIG_X86
>                 DIRECT_MAP_LEVEL2_SPLIT,
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 792ca21c5815..21d79249c8b4 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -703,6 +703,7 @@ static const unsigned int memcg_vm_event_stat[] =3D {
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>         ZSWPIN,
>         ZSWPOUT,
> +       ZSWP_WB,
>  #endif
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         THP_FAULT_ALLOC,
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index afa5a38fcc9c..2249f85e4a87 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1401,6 +1401,7 @@ const char * const vmstat_text[] =3D {
>  #ifdef CONFIG_ZSWAP
>         "zswpin",
>         "zswpout",
> +       "zswp_wb",
>  #endif
>  #ifdef CONFIG_X86
>         "direct_map_level2_splits",
> diff --git a/mm/zswap.c b/mm/zswap.c
> index f323e45cbdc7..49b79393e472 100644
> --- a/mm/zswap.c
> +++ b/mm/zswap.c
> @@ -760,6 +760,10 @@ static enum lru_status shrink_memcg_cb(struct list_h=
ead *item, struct list_lru_o
>         }
>         zswap_written_back_pages++;
>
> +       if (entry->objcg)
> +               count_objcg_event(entry->objcg, ZSWP_WB);
> +
> +       count_vm_event(ZSWP_WB);
>         /*
>          * Writeback started successfully, the page now belongs to the
>          * swapcache. Drop the entry from zswap - unless invalidate alrea=
dy
> --
> 2.34.1
