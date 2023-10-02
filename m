Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6757B5762
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 18:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238381AbjJBQBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 12:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238350AbjJBQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 12:01:43 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C258B8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 09:01:40 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3231d67aff2so13236385f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 09:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696262498; x=1696867298; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJAfxKKIDOmNQ6NAPWDPTRLLaIM+b+cKty2EQafbHM8=;
        b=hPjtMehO/f1RvGT0ZqMSgIN6v9zpED8cVW6ReBE6U1MWLUlG2M594f55fEb0tiZVJF
         V8hTLD1ldbrPMwf25Gsa/bpQRf7l+hjFZ9RTDxMpFgV4NBkUVaUuxBBqKeTSUNOi+7gv
         k7XU0gdiycEx6DcG4h/BP8CDt/gCirVk7wufVOdybLQUhY/ekA+YOemUSOeF6pF6IukC
         IO8BXwmc0fBrkreBK8tG3c3zQmSAV5NKtXsx5gfJlAlypnjsGEtQYG2B2WY4QUsi0E4u
         VQFykO4+HH1tCQDRWXR1LN1DNryDDQgIYV7L594V1w9Wc9BsXN6Dgtks/qmOOWOup5zR
         Fkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696262498; x=1696867298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJAfxKKIDOmNQ6NAPWDPTRLLaIM+b+cKty2EQafbHM8=;
        b=BDyJnmjV4PH1pZaNPQvI5B0iOsyRT1B3sP9up34eruuo8+Ox4rzrxhGy5zKawqM+ok
         Ahei97EFjPNgC4Dm2PnK6imSOBEU7Rsoh4woASjLnbCiKJRSYg3ZRzulWkP+nOfJGrrT
         YYfeW06IgciLmSkV8jbWwpVu4StYeRUDE4n1ii8eZGjYfRIKSa/GdEMBnh81BsfYydQw
         EZwSLBxdkZ7U+vY2QUl1oAyLx9bbZtGH/DEiR6ynOhio3mtGqCBf1lrt4pJpredcDG8L
         XMPMgiXeHZ4PH74H7biW2oBgW3IpP7jwsGw7/LM12md//p05gY8si8DhSA+IzIO6cTmf
         +akg==
X-Gm-Message-State: AOJu0YwjASYAC3YRX7M29mNGv7QwLzjt7mNc6EwvS+tNc9ANigsilt7A
        QUM5qCAt2M1t3czshc4bFfX7upImvzAQdyZwqvLqOQ==
X-Google-Smtp-Source: AGHT+IF0MKq8zjm7nEkLpSEZkTwv4am93fXUVvTJEiuy0/9vuHRcYymFNLwbX38U5gcNPeG59alk7KP1CtIwCy/wdUk=
X-Received: by 2002:a5d:674a:0:b0:324:7a6b:d4fe with SMTP id
 l10-20020a5d674a000000b003247a6bd4femr11097545wrw.9.1696262498408; Mon, 02
 Oct 2023 09:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231001054736.1586001-1-masahiroy@kernel.org> <20231001054736.1586001-2-masahiroy@kernel.org>
In-Reply-To: <20231001054736.1586001-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 2 Oct 2023 09:01:27 -0700
Message-ID: <CAKwvOdk=dpEzqzyNvKuUaev+qJ4gyhXnhuFDgF+dxSqMkVfpcw@mail.gmail.com>
Subject: Re: [PATCH 2/2] modpost: factor out the common boilerplate of section_rel(a)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
> The first few lines of section_rel() and section_rela() are the same.
> They both retrieve the index of the section to which the relocaton

s/relocaton/relocation/

> applies, and skip known-good sections. This common code should be moved
> to check_sec_ref().
>
> Avoid ugly casts when computing 'start' and 'stop', and also make the
> Elf_Rel and Elf_Rela pointers const.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 50 ++++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 24 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 15d78fe152ac..0e18fe617ed1 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1425,17 +1425,10 @@ static void get_rel_type_and_sym(struct elf_info =
*elf, uint64_t r_info,
>  }
>
>  static void section_rela(struct module *mod, struct elf_info *elf,
> -                        Elf_Shdr *sechdr)
> +                        unsigned int fsecndx, const char *fromsec,
> +                        const Elf_Rela *start, const Elf_Rela *stop)
>  {
> -       Elf_Rela *rela;
> -       unsigned int fsecndx =3D sechdr->sh_info;
> -       const char *fromsec =3D sec_name(elf, fsecndx);
> -       Elf_Rela *start =3D (void *)elf->hdr + sechdr->sh_offset;
> -       Elf_Rela *stop  =3D (void *)start + sechdr->sh_size;
> -
> -       /* if from section (name) is know good then skip it */
> -       if (match(fromsec, section_white_list))
> -               return;
> +       const Elf_Rela *rela;
>
>         for (rela =3D start; rela < stop; rela++) {
>                 Elf_Addr taddr, r_offset;
> @@ -1465,17 +1458,10 @@ static void section_rela(struct module *mod, stru=
ct elf_info *elf,
>  }
>
>  static void section_rel(struct module *mod, struct elf_info *elf,
> -                       Elf_Shdr *sechdr)
> +                       unsigned int fsecndx, const char *fromsec,
> +                       const Elf_Rel *start, const Elf_Rel *stop)
>  {
> -       Elf_Rel *rel;
> -       unsigned int fsecndx =3D sechdr->sh_info;
> -       const char *fromsec =3D sec_name(elf, fsecndx);
> -       Elf_Rel *start =3D (void *)elf->hdr + sechdr->sh_offset;
> -       Elf_Rel *stop  =3D (void *)start + sechdr->sh_size;
> -
> -       /* if from section (name) is know good then skip it */
> -       if (match(fromsec, section_white_list))
> -               return;
> +       const Elf_Rel *rel;
>
>         for (rel =3D start; rel < stop; rel++) {
>                 Elf_Sym *tsym;
> @@ -1530,10 +1516,26 @@ static void check_sec_ref(struct module *mod, str=
uct elf_info *elf)
>
>                 check_section(mod->name, elf, sechdr);
>                 /* We want to process only relocation sections and not .i=
nit */
> -               if (sechdr->sh_type =3D=3D SHT_RELA)
> -                       section_rela(mod, elf, sechdr);
> -               else if (sechdr->sh_type =3D=3D SHT_REL)
> -                       section_rel(mod, elf, sechdr);
> +               if (sechdr->sh_type =3D=3D SHT_REL || sechdr->sh_type =3D=
=3D SHT_RELA) {
> +                       /* section to which the relocation applies */
> +                       unsigned int secndx =3D sechdr->sh_info;
> +                       const char *secname =3D sec_name(elf, secndx);
> +                       const void *start, *stop;
> +
> +                       /* If the section is known good, skip it */
> +                       if (match(secname, section_white_list))
> +                               continue;
> +
> +                       start =3D sym_get_data_by_offset(elf, i, 0);
> +                       stop =3D start + sechdr->sh_size;
> +
> +                       if (sechdr->sh_type =3D=3D SHT_RELA)
> +                               section_rela(mod, elf, secndx, secname,
> +                                            start, stop);
> +                       else
> +                               section_rel(mod, elf, secndx, secname,
> +                                           start, stop);
> +               }
>         }
>  }
>
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
