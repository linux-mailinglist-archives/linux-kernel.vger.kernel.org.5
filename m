Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162BE7BE889
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377499AbjJIRoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjJIRoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:44:17 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE22E9D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:44:15 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4064867903cso48622855e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 10:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696873454; x=1697478254; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=STStuPO/b+1eXhTjhf6QGffrCRQ+SU82tm0zQBraBwI=;
        b=Lq/GzIn+6AwVnkUmcMRjcvRKYuaLneqf9h8eBuiJbjgDtD+0MmOtQqlnVvnie5A7FN
         N1cvVjHy199GA1RMfjdBCODs349QQzK3e2TGyOwIe+ux+yurk0bEUloOgLdxI5iEt5G3
         q+4cRuEa+MAELnFbOWt36BbJH42y1w6fY99gQZucRxmkPcZsvyXYq/2PMB3TngttzbHs
         spAzw2aYkBcf3HrnMrcKfLNYc8mQKwk83RI2HteJ8mWBGSY9MRrt/H1mANYkeIRnpMSi
         5EW5hPwX1qEuv41yypgzJ6fHNHgP5DK1LqKGYNQ9JGrDWQKpKVlh765eL3KFZ7/xCNoR
         WALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873454; x=1697478254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=STStuPO/b+1eXhTjhf6QGffrCRQ+SU82tm0zQBraBwI=;
        b=tq4iwX7SZUvDtvwUViJzhHJG6PFkUfJdwF1nBtDRn1OPcfa3p7d4wG773trPKWSsIP
         2fvnqdx8Iun0P3bc0eZDS8BDmlTCmWxU8rn50DlcQ/qPEezPlQ7+a3cPy/2DbvX/aWS0
         Heb+c7N4Agiymf9P3IQsruiCQQg5mGkHRpEOemdaBIor3yQyjyxK29cGc+3I4pfFHNfY
         cJfsjQEo1X9bE91BRVyI6njFOQF5smF/WHOIJhRkD8TZFP+J5nic91j9mSFYWJ8j2DeK
         KjD81lfaP5hXbV0uXbjkgy30CfZQp1gLMi00FsKsY4oPRrT1+inN0AEWawBCLQPaIZtQ
         fMbg==
X-Gm-Message-State: AOJu0Ywux/ItlpJ2SvpboMALFaKxJIyZ45c1TbREoI/Sv4nEPy7dCFFE
        ddSNmia7/+twAZBBz1uCHiime/F7mPThVjEQUQSm2A==
X-Google-Smtp-Source: AGHT+IE5oG/4dHDjcFOdclPDQpiBN2b/xlhPzhtW2vhtlr7qTel6GyJ3xa3Fhqt4F0hvEkmg77ljb16nzFS+7kNb6uo=
X-Received: by 2002:adf:e6cd:0:b0:31f:a4fa:130a with SMTP id
 y13-20020adfe6cd000000b0031fa4fa130amr14430019wrm.14.1696873453889; Mon, 09
 Oct 2023 10:44:13 -0700 (PDT)
MIME-Version: 1.0
References: <20231007170448.505487-1-masahiroy@kernel.org> <20231007170448.505487-3-masahiroy@kernel.org>
In-Reply-To: <20231007170448.505487-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Oct 2023 10:43:59 -0700
Message-ID: <CAKwvOdkP-28Z51UZcDL4434Uns9pb0kYYFwzHmQCg7x2V0E_TQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] modpost: define TO_NATIVE() using bswap_* functions
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 7, 2023 at 10:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The current TO_NATIVE() has some limitations:
>
>  1) You cannot cast the argument.
>
>  2) You cannot pass a variable marked as 'const'.
>
>  3) Passing an array is a bug, but it is not detected.
>
> Impelement TO_NATIVE() using bswap_*() functions. These are GNU
> extensions. If we face portability issues, we can port the code from
> include/uapi/linux/swab.h.
>
> With this change, get_rel_type_and_sym() can be simplified by casting
> the arguments directly.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 13 ++++---------
>  scripts/mod/modpost.h | 25 ++++++++++++-------------
>  2 files changed, 16 insertions(+), 22 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2f3b0fe6f68d..99476a9695c5 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1410,15 +1410,10 @@ static void get_rel_type_and_sym(struct elf_info =
*elf, uint64_t r_info,
>                 return;
>         }
>
> -       if (is_64bit) {
> -               Elf64_Xword r_info64 =3D r_info;
> -
> -               r_info =3D TO_NATIVE(r_info64);
> -       } else {
> -               Elf32_Word r_info32 =3D r_info;
> -
> -               r_info =3D TO_NATIVE(r_info32);
> -       }
> +       if (is_64bit)
> +               r_info =3D TO_NATIVE((Elf64_Xword)r_info);
> +       else
> +               r_info =3D TO_NATIVE((Elf32_Word)r_info);
>
>         *r_type =3D ELF_R_TYPE(r_info);
>         *r_sym =3D ELF_R_SYM(r_info);
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 6413f26fcb6b..1392afec118c 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -1,4 +1,5 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> +#include <byteswap.h>
>  #include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -51,21 +52,19 @@
>  #define ELF_R_TYPE  ELF64_R_TYPE
>  #endif
>
> +#define bswap(x) \
> +({ \
> +       _Static_assert(sizeof(x) =3D=3D 1 || sizeof(x) =3D=3D 2 || \

Seems fine, but do we need to support folks trying to swap 1B values?
i.e. is someone calling TO_NATIVE with 1B values?  Seems silly unless
one of these types is variable length dependent on the target machine
type?

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> +                      sizeof(x) =3D=3D 4 || sizeof(x) =3D=3D 8, "bug"); =
\
> +       (typeof(x))(sizeof(x) =3D=3D 2 ? bswap_16(x) : \
> +                   sizeof(x) =3D=3D 4 ? bswap_32(x) : \
> +                   sizeof(x) =3D=3D 8 ? bswap_64(x) : \
> +                   x); \
> +})
> +
>  #if KERNEL_ELFDATA !=3D HOST_ELFDATA
>
> -static inline void __endian(const void *src, void *dest, unsigned int si=
ze)
> -{
> -       unsigned int i;
> -       for (i =3D 0; i < size; i++)
> -               ((unsigned char*)dest)[i] =3D ((unsigned char*)src)[size =
- i-1];
> -}
> -
> -#define TO_NATIVE(x)                                           \
> -({                                                             \
> -       typeof(x) __x;                                          \
> -       __endian(&(x), &(__x), sizeof(__x));                    \
> -       __x;                                                    \
> -})
> +#define TO_NATIVE(x) (bswap(x))
>
>  #else /* endianness matches */
>
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
