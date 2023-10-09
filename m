Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDECD7BD1C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 03:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344901AbjJIBSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 21:18:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjJIBSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 21:18:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DA08F
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 18:18:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E7DC433C7
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 01:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696814300;
        bh=5VgzET7sJk5vcsYLGL8Xr+lPdhFjwFeZymvPVsirkWE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jhS9JWtcoxA4Qw8+U5wmBbePk/uTst2DEAcdYTVWwgfr8dX0F3rmZrEZvYqy7w4pv
         0PgSR9L8fYoZNOW6Xwgws5sxaEYn7HbvGTfM3DyT3X5npdsAl0xk+yyvWSejJcHd5+
         hzFOTcfDzmDDMYRdJAL8IzQFk8N7GSHC/fdcVij2u6LKSPkcZVoEMFml/lClC5RCNS
         J/eAMM/vB5VAmZKY4IBLLU8HK4E48GCsNUm5W3NlB7QRQ21VOQfCYxFfeiC+ndUuXe
         3B0uNKlfgQ1wjTtehozsl3FwWtYa/ENub89ZzoENt9kajtVuSq/YXSSOgBX/+5zm68
         J1g9BtDjrQ/6A==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-536071e79deso8784506a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 18:18:20 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXXG3QkaMcIhf9R9n6sMzdTQ9KH3u1/7E7WVkOzjzx9BLg8Pg0
        cG7T0pVwl0STtitZYqtXTgCb7xJ65mbVD+Qjy4o=
X-Google-Smtp-Source: AGHT+IEDE+4c3WWbE+3Z86yBK3ncvcQPW2esCqMTs3GGr0N/mFlnxLSfADY9PQdHT/R4v7Y2XcyyEnm0MGCz4LoBJFg=
X-Received: by 2002:a05:6402:40c1:b0:527:1855:be59 with SMTP id
 z1-20020a05640240c100b005271855be59mr8542915edb.3.1696814298622; Sun, 08 Oct
 2023 18:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20231008130204.489081-1-uwu@icenowy.me>
In-Reply-To: <20231008130204.489081-1-uwu@icenowy.me>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 9 Oct 2023 09:18:06 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4G+vsJYTyP9Txpke=YiuGcTr-6L7ZrOdt8=b8dWdHD9A@mail.gmail.com>
Message-ID: <CAAhV-H4G+vsJYTyP9Txpke=YiuGcTr-6L7ZrOdt8=b8dWdHD9A@mail.gmail.com>
Subject: Re: [PATCH] loongarch/mm: disable WUC for pgprot_writecombine() too
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     WANG Xuerui <kernel@xen0n.name>, Jun Yi <yijun@loongson.cn>,
        Baoquan He <bhe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Hongchen Zhang <zhanghongchen@loongson.cn>,
        Binbin Zhou <zhoubinbin@loongson.cn>,
        Youling Tang <tangyouling@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Zhihong Dong <donmor3000@hotmail.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Zheng,

The title can be "LoongArch: Disable WUC for pgprot_writecombine() as
same as ioremap()"

On Sun, Oct 8, 2023 at 9:03=E2=80=AFPM Icenowy Zheng <uwu@icenowy.me> wrote=
:
>
> Currently the code disables WUC only disables it for ioremap_wc(), which
> is only used when mapping writecombine pages like ioremap() (mapped to
> the kernel space). For VRAM mapped in TTM/GEM, it's mapped with a
> crafted pgprot with pgprot_writecombine() function, which isn't
> corrently disabled now.
>
> Disable WUC for pgprot_writecombine() (fallback to SUC) too.
>
> This improves AMDGPU driver stability on Loongson 3A5000 machines.
>
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  arch/loongarch/include/asm/io.h           |  4 +---
>  arch/loongarch/include/asm/pgtable-bits.h |  9 ++++++++-
>  arch/loongarch/kernel/setup.c             | 10 +++++-----
>  3 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/arch/loongarch/include/asm/io.h b/arch/loongarch/include/asm=
/io.h
> index 0dcb36b32cb25..5477d9e3ab072 100644
> --- a/arch/loongarch/include/asm/io.h
> +++ b/arch/loongarch/include/asm/io.h
> @@ -52,10 +52,8 @@ static inline void __iomem *ioremap_prot(phys_addr_t o=
ffset, unsigned long size,
>   * @offset:    bus address of the memory
>   * @size:      size of the resource to map
>   */
> -extern pgprot_t pgprot_wc;
> -
>  #define ioremap_wc(offset, size)       \
> -       ioremap_prot((offset), (size), pgprot_val(pgprot_wc))
> +       ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL_WC))
>
>  #define ioremap_cache(offset, size)    \
>         ioremap_prot((offset), (size), pgprot_val(PAGE_KERNEL))
> diff --git a/arch/loongarch/include/asm/pgtable-bits.h b/arch/loongarch/i=
nclude/asm/pgtable-bits.h
> index 35348d4c4209a..c9e3ed330fb97 100644
> --- a/arch/loongarch/include/asm/pgtable-bits.h
> +++ b/arch/loongarch/include/asm/pgtable-bits.h
> @@ -92,6 +92,13 @@
>
>  #ifndef __ASSEMBLY__
>
> +extern bool wc_enabled;
> +
> +#define _CACHE_WC      (wc_enabled ? _CACHE_WUC : _CACHE_SUC)
> +
> +#define PAGE_KERNEL_WC __pgprot(_PAGE_PRESENT | __READABLE | __WRITEABLE=
 | \
> +                                _PAGE_GLOBAL | _PAGE_KERN |  _CACHE_WC)
If these macros cannot be put close to their friends, I prefer to open code=
.

Huacai
> +
>  #define _PAGE_IOREMAP          pgprot_val(PAGE_KERNEL_SUC)
>
>  #define pgprot_noncached pgprot_noncached
> @@ -111,7 +118,7 @@ static inline pgprot_t pgprot_writecombine(pgprot_t _=
prot)
>  {
>         unsigned long prot =3D pgprot_val(_prot);
>
> -       prot =3D (prot & ~_CACHE_MASK) | _CACHE_WUC;
> +       prot =3D (prot & ~_CACHE_MASK) | _CACHE_WC;
>
>         return __pgprot(prot);
>  }
> diff --git a/arch/loongarch/kernel/setup.c b/arch/loongarch/kernel/setup.=
c
> index 4de32b07c0dcd..b35186f7b2547 100644
> --- a/arch/loongarch/kernel/setup.c
> +++ b/arch/loongarch/kernel/setup.c
> @@ -161,19 +161,19 @@ static void __init smbios_parse(void)
>  }
>
>  #ifdef CONFIG_ARCH_WRITECOMBINE
> -pgprot_t pgprot_wc =3D PAGE_KERNEL_WUC;
> +bool wc_enabled =3D true;
>  #else
> -pgprot_t pgprot_wc =3D PAGE_KERNEL_SUC;
> +bool wc_enabled;
>  #endif
>
> -EXPORT_SYMBOL(pgprot_wc);
> +EXPORT_SYMBOL(wc_enabled);
>
>  static int __init setup_writecombine(char *p)
>  {
>         if (!strcmp(p, "on"))
> -               pgprot_wc =3D PAGE_KERNEL_WUC;
> +               wc_enabled =3D true;
>         else if (!strcmp(p, "off"))
> -               pgprot_wc =3D PAGE_KERNEL_SUC;
> +               wc_enabled =3D false;
>         else
>                 pr_warn("Unknown writecombine setting \"%s\".\n", p);
>
> --
> 2.39.1
>
>
