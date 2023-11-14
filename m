Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 884567EAB0A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 08:46:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjKNHqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 02:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjKNHqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 02:46:46 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1DC9CC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:46:41 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id a1e0cc1a2514c-7bb3e55c120so2119366241.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 23:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699948001; x=1700552801; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sX2ZDi+R3Ev6T5LlvMfvdN7qFs7PkFHPelflvttGDD4=;
        b=saCOkZviF7qV44inxihxL/LyQ8WpG4Ax9CQwREQIlchvqKCKVg+I7eBXPkjJ7mlme6
         rGzC0LJ7yFQ+anMCwRbaQhmlYRb0xilb6AsiD7qE3MDwna6aDhYJQ7icc/BDeOqMgtzH
         0FL8uhOBtorhv6g6aSlzGNI3/JPPVTc1AnYNpNLuhJSiqKszlRF3JwBqLbA1lI5w7MG7
         XnErTCY8jdWXxQenTzD6/npOyRzn6SzIksztlFiAxyrCoX7JAPJ9NnRelami6DBgLwiP
         yMjsWczq9yz2TSlwejV8CJ4qlRiFHT6RfL2F+zvGykBrrVMQehI5eoV1WHT7Fu6JeVJO
         +JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699948001; x=1700552801;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sX2ZDi+R3Ev6T5LlvMfvdN7qFs7PkFHPelflvttGDD4=;
        b=f61MTE9ypGMgP7nLOPtgsglr3r2j/Jj0hqRAxCU4of+Fs5uQN9UuLWi+g8aK+LPQEJ
         wZT8p7LcDBJFIJzvsjV19cFKCd+NNAkQ94ieB/IyUgb0GYy2XAzFcvA1n4sJRuZWWxM5
         k8ioPr38sn+9+YTSEGVBP2XkuouWYZHCiT3S9O6O44+080ofAd2a02Fyp04lnUWtwomI
         yWKxbeEiCeNtWzim69aSn9ifqqL8hbPn7Fjv1FXiQDP3pZTQ+lQ9/UMdxOkHxdWtKK2S
         0H/FLESs5bQKAVoE/D2PuozegFCN67eg1Rya1LEcQhpIT5E1ramJyQoCDrwApTVRa9zE
         LrfQ==
X-Gm-Message-State: AOJu0YxqQAuKcNtIe3OZFfXQFJTv+HTWARFG5U1RxR3692DEsF1hRrTF
        G0BgZ10mPf9+LOBfmKjSIYAug46g0tiwNp2toJnCFg==
X-Google-Smtp-Source: AGHT+IEkx9qpi9PxginlouXMsLXjDm4AhflR5GKJMwuObn7dBWpabAiTtV5tdjgAPRBqG6d0RnyHF3wv2N9uz3bxx2o=
X-Received: by 2002:a05:6102:2908:b0:460:621c:d14b with SMTP id
 cz8-20020a056102290800b00460621cd14bmr9815342vsb.20.1699948000802; Mon, 13
 Nov 2023 23:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20231113191340.17482-22-vbabka@suse.cz> <20231113191340.17482-25-vbabka@suse.cz>
In-Reply-To: <20231113191340.17482-25-vbabka@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Tue, 14 Nov 2023 08:46:04 +0100
Message-ID: <CANpmjNOrA_nfMsu1eaTqauVfc53p5xHxO7TZAueVXyi5Qf9wAg@mail.gmail.com>
Subject: Re: [PATCH 03/20] KFENCE: cleanup kfence_guarded_alloc() after
 CONFIG_SLAB removal
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 at 20:14, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> Some struct slab fields are initialized differently for SLAB and SLUB so
> we can simplify with SLUB being the only remaining allocator.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 3872528d0963..8350f5c06f2e 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -463,11 +463,7 @@ static void *kfence_guarded_alloc(struct kmem_cache *cache, size_t size, gfp_t g
>         /* Set required slab fields. */
>         slab = virt_to_slab((void *)meta->addr);
>         slab->slab_cache = cache;
> -#if defined(CONFIG_SLUB)
>         slab->objects = 1;
> -#elif defined(CONFIG_SLAB)
> -       slab->s_mem = addr;
> -#endif
>
>         /* Memory initialization. */
>         set_canary(meta);
> --
> 2.42.1
>
