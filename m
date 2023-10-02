Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A344E7B5793
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbjJBPze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 11:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbjJBPzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 11:55:33 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCD8C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 08:55:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-406618d0991so28852295e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696262128; x=1696866928; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DYqu+Z03Xs4vwbPIqLMKJ2TemUcRXbZ6I5tCtedOo4s=;
        b=FWtggO99PQSK2nGMN3C5JHznPWC7lUUrN/x0Qe3/bqyLbnp4b7WViuxpaR7tApjNJj
         WjWuVtBg00l0e4vJQ/ADSARhOglIWpJiyK/oBEm+DmRMJVhXTveK8tAKONrP+/2sZlbP
         dO7T1MbZc8nXrout82zE9gxoB8E3y7+i5Pha/EgNjF+p43PRyk25hAdVVxYk0nO+fDeQ
         8Z95jZRHeAJgnLDGAl3AwSuJ8uQlaQzazyq8C7+t7+xV5ssIXdbXm5zC4VV68fRpgBte
         0flM+CF6tA/pmYxVoRxiYoFIJd6Dsea0uXMWi5tpBnKK/MhXm0JgM9kKk2zT7V1e/ZuP
         FAXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262128; x=1696866928;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYqu+Z03Xs4vwbPIqLMKJ2TemUcRXbZ6I5tCtedOo4s=;
        b=RSFMq8WB7SHd4qMX5T4wbQiIg6gfjddlCpiyw+hMP0EWGOT5GzlvtnV0xXuqd0JWro
         +uz42QlZV2yPfRH9BOEx9BETSgh/SBtcGmdDlPRbxDKckvc3+v8JJo1xKkrHceuEzqa2
         eu+0HNXVFrVvgqf5fc2rSGPla9koH4887kwIvoR7Zc16M9q72vgV8AUM1IEsf87GYXrB
         NltxIShfZjN/dTbQ25TH1I2iuiJ9S1rS8O3E3xKIKweRUr0hC028CnDE/yVgP4G/ry+h
         XeQoeOg58bT4coLPh1aBwJ1AXN7BG5UF6CwOaIkes2cczrVBfXbQ0NPuJTrASGuqiuGr
         6y4A==
X-Gm-Message-State: AOJu0YwgdoOIbxGZ5CRz4skNdPdG07gSH4bhofPLiqNfKcwt9mKUZnUQ
        nnJiucExqwUvIvbhvLxJo1mRfGizkf+t14SG1of7SQ==
X-Google-Smtp-Source: AGHT+IFVXU7IFndvdZU7z42hZeKuGZo++DuxGIRlYbMuWWtegb7plk58/lpwS7uOgelf+I2qCurYgUPaHDWOngFOhBs=
X-Received: by 2002:a05:600c:2146:b0:405:458d:d54 with SMTP id
 v6-20020a05600c214600b00405458d0d54mr10914294wml.33.1696262127926; Mon, 02
 Oct 2023 08:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20231001054736.1586001-1-masahiroy@kernel.org>
In-Reply-To: <20231001054736.1586001-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Oct 2023 08:55:13 -0700
Message-ID: <CAKwvOd=9vxXWwtDxuAmhBO_-c9vhF1rwYyOo8e9EY2x2B1m-iQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] modpost: refactor check_sec_ref()
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 10:47=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.=
org> wrote:
>
> We can replace &elf->sechdrs[i] with &sechdrs[i] to slightly shorten
> the code because we already have the local variable 'sechdrs'.
>
> However, defining 'sechdr' instead shortens the code further.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2f3b0fe6f68d..15d78fe152ac 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1523,16 +1523,17 @@ static void section_rel(struct module *mod, struc=
t elf_info *elf,
>  static void check_sec_ref(struct module *mod, struct elf_info *elf)
>  {
>         int i;
> -       Elf_Shdr *sechdrs =3D elf->sechdrs;
>
>         /* Walk through all sections */
>         for (i =3D 0; i < elf->num_sections; i++) {
> -               check_section(mod->name, elf, &elf->sechdrs[i]);
> +               Elf_Shdr *sechdr =3D &elf->sechdrs[i];
> +
> +               check_section(mod->name, elf, sechdr);
>                 /* We want to process only relocation sections and not .i=
nit */
> -               if (sechdrs[i].sh_type =3D=3D SHT_RELA)
> -                       section_rela(mod, elf, &elf->sechdrs[i]);
> -               else if (sechdrs[i].sh_type =3D=3D SHT_REL)
> -                       section_rel(mod, elf, &elf->sechdrs[i]);
> +               if (sechdr->sh_type =3D=3D SHT_RELA)
> +                       section_rela(mod, elf, sechdr);
> +               else if (sechdr->sh_type =3D=3D SHT_REL)
> +                       section_rel(mod, elf, sechdr);
>         }
>  }
>
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
