Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD727A3164
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231585AbjIPQXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjIPQXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:23:30 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215D3CC6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 09:23:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68fb5bd8f02so2999144b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694881404; x=1695486204; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnbqp2QICXtxCRvhqirbkk4LQUQEjriYEsYOyafJQnA=;
        b=OpyDQZKzEPj1+dTmI5hdvM4Jsv5aRxF0JHsSh1e2adlB7UFn2H6046G8CXLtbd51sQ
         aeuKbcpWZ6c/4Y5axZlacMqKmDcIu7zmLwOkWzP3oCW2fylfg4p1RbNt/pceTMdAG5Md
         sQaZDUUTBRZ3DgMHZsnMZISd3XTzln0xgRJCKivhGuT97WEMgz166/Yo1/hmxJS9/VRO
         scal827iE8tWKri//qjIwXnEiGARbmiY3EG80MVV178x+aIqxAg1tEDHGzm0t+AopolU
         18XYH+wyk7wDhWfBr8W4Hd+q64vEkhzpq/xKVx1yS1IM2Z6LVG5td0zB5AfpeL2kLzeJ
         GZqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694881404; x=1695486204;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vnbqp2QICXtxCRvhqirbkk4LQUQEjriYEsYOyafJQnA=;
        b=TXBbnmQacnJGseYPUmQhU88O6ykpTg8eKRkv9fvUK40iHKlb4BZYlY6SX9Jp6Y5RHf
         5v2Ygrt2jexGOvxv+c/l2JWOb5o5hQF5VH6UGrk/Wel92Lu87oqj2ygzuAsRsV9nHuzU
         hZ1gJwY9aq6qV5BGiAji3hucrJwAVYn5yi4HhMP+JJkmH04zaDvOm6Ge6gHZdXJuovnY
         wKxLrRd3p+DlDSLZjbi82YMZCU5I+4vsXUmISq3hD6KoEWRVazJvINP/yf6P1UmVSPZJ
         684JBLq980FMnKsMNS9IL2hAf2mpDQqHv2VUl5XjEg4ZUa10FiG9kxRfrpvzrhen3+4o
         yBlg==
X-Gm-Message-State: AOJu0Yy8XXYpx/BptYy8sRBSpuTExEYIvM9Mex779Qm0w4xI65mK9UO1
        btRNE3XYOh9WFl4e0qdo99CmzVn3HHFI/Y6+FG4=
X-Google-Smtp-Source: AGHT+IEfXOCC/sICfnIRMCLDsK6b3IEs/xbd1z457jQO3JvhocT+ttSvPY+qyY1L2eoGhwW9HnpvD/EI34DzlGuujic=
X-Received: by 2002:a05:6a20:e11a:b0:14c:76bd:10c1 with SMTP id
 kr26-20020a056a20e11a00b0014c76bd10c1mr5776753pzb.21.1694881404475; Sat, 16
 Sep 2023 09:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230912031750.3319584-1-chenhuacai@loongson.cn>
In-Reply-To: <20230912031750.3319584-1-chenhuacai@loongson.cn>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 16 Sep 2023 18:23:13 +0200
Message-ID: <CA+fCnZcSZi5nPPnbC3Ce7qChUFMwwSkP13fGSG4VXpDqOUimOg@mail.gmail.com>
Subject: Re: [PATCH V2] kasan: Cleanup the __HAVE_ARCH_SHADOW_MAP usage
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        loongarch@lists.linux.dev, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn,
        Linus Torvalds <torvalds@linux-foundation.org>,
        WANG Xuerui <git@xen0n.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 5:18=E2=80=AFAM Huacai Chen <chenhuacai@loongson.cn=
> wrote:
>
> As Linus suggested, __HAVE_ARCH_XYZ is "stupid" and "having historical
> uses of it doesn't make it good". So migrate __HAVE_ARCH_SHADOW_MAP to
> separate macros named after the respective functions.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> ---
> V2: Update commit messages.
>
>  arch/loongarch/include/asm/kasan.h | 10 ++++++++--
>  include/linux/kasan.h              |  2 +-
>  mm/kasan/kasan.h                   |  8 +++-----
>  3 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/=
asm/kasan.h
> index deeff8158f45..a12ecab37da7 100644
> --- a/arch/loongarch/include/asm/kasan.h
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -10,8 +10,6 @@
>  #include <asm/io.h>
>  #include <asm/pgtable.h>
>
> -#define __HAVE_ARCH_SHADOW_MAP
> -
>  #define KASAN_SHADOW_SCALE_SHIFT 3
>  #define KASAN_SHADOW_OFFSET    _AC(CONFIG_KASAN_SHADOW_OFFSET, UL)
>
> @@ -68,6 +66,7 @@ static __always_inline bool kasan_arch_is_ready(void)
>         return !kasan_early_stage;
>  }
>
> +#define kasan_mem_to_shadow kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>         if (!kasan_arch_is_ready()) {
> @@ -97,6 +96,7 @@ static inline void *kasan_mem_to_shadow(const void *add=
r)
>         }
>  }
>
> +#define kasan_shadow_to_mem kasan_shadow_to_mem
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         unsigned long addr =3D (unsigned long)shadow_addr;
> @@ -119,6 +119,12 @@ static inline const void *kasan_shadow_to_mem(const =
void *shadow_addr)
>         }
>  }
>
> +#define addr_has_metadata addr_has_metadata
> +static __always_inline bool addr_has_metadata(const void *addr)
> +{
> +       return (kasan_mem_to_shadow((void *)addr) !=3D NULL);
> +}
> +
>  void kasan_init(void);
>  asmlinkage void kasan_early_init(void);
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 3df5499f7936..842623d708c2 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -54,7 +54,7 @@ extern p4d_t kasan_early_shadow_p4d[MAX_PTRS_PER_P4D];
>  int kasan_populate_early_shadow(const void *shadow_start,
>                                 const void *shadow_end);
>
> -#ifndef __HAVE_ARCH_SHADOW_MAP
> +#ifndef kasan_mem_to_shadow
>  static inline void *kasan_mem_to_shadow(const void *addr)
>  {
>         return (void *)((unsigned long)addr >> KASAN_SHADOW_SCALE_SHIFT)
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index f70e3d7a602e..d37831b8511c 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -291,7 +291,7 @@ struct kasan_stack_ring {
>
>  #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
>
> -#ifndef __HAVE_ARCH_SHADOW_MAP
> +#ifndef kasan_shadow_to_mem
>  static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>  {
>         return (void *)(((unsigned long)shadow_addr - KASAN_SHADOW_OFFSET=
)
> @@ -299,15 +299,13 @@ static inline const void *kasan_shadow_to_mem(const=
 void *shadow_addr)
>  }
>  #endif
>
> +#ifndef addr_has_metadata
>  static __always_inline bool addr_has_metadata(const void *addr)
>  {
> -#ifdef __HAVE_ARCH_SHADOW_MAP
> -       return (kasan_mem_to_shadow((void *)addr) !=3D NULL);
> -#else
>         return (kasan_reset_tag(addr) >=3D
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> -#endif
>  }
> +#endif
>
>  /**
>   * kasan_check_range - Check memory region, and report if invalid access=
.
> --
> 2.39.3
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
