Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B705475D04D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 19:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjGURDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 13:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjGURDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 13:03:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72B72D58;
        Fri, 21 Jul 2023 10:03:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6458461D62;
        Fri, 21 Jul 2023 17:03:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0AF7C433CD;
        Fri, 21 Jul 2023 17:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689959013;
        bh=5JLpzCIcP8GrNwfhf6Q72RzlXws33EqGiwwug49sJZY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LNfbQodAtZzeDkyOfQdMDBi50Gyas+DIpOQ7sDqTE9htpf+PdR+tg8C5psq8brz2Q
         ZuE5TLeIX5LqqVmKYiW5E15BKgUXKzMKtGnrN1vm0dhwDIDEOzo4MskCU1OIQ1u1c6
         pjQFiz8VBbChK6sZR+/VOjLmX9+0w0zGSwW7VhJ0iS9URHUB+ePLikv4AhAhvvMfQs
         mtA0o2O+S2/xYsqzqk1xXSnHMuX/4/1b12Q04/g2C0DhxlNesWeEMYniTspe+4c4kU
         epDK9hUG7br2gkaesFngSq0KFEyhuUbAFfqKcMY+dKSURwZ50Z3psEMlry4k/dVlsB
         KvgFHNUFAACOw==
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-56347da4a50so1361597eaf.2;
        Fri, 21 Jul 2023 10:03:33 -0700 (PDT)
X-Gm-Message-State: ABy/qLZMH+RCyZU4J+EpI3zOC2+EJbAQUpOxPRUj8AJ4Cy4+UEOPDt0S
        Lozv1AVjlM4xNpDFvqW+1cCAAK8hNjU8/0j1H6c=
X-Google-Smtp-Source: APBJJlHkxE2hRMjRtwdE1wEe7yvoUrAsmGMiIkRnfMseS4U8D4zRxUXkhZI4fB5CzBs8Cs+kWawoSCgf4omuzIkWWv4=
X-Received: by 2002:a4a:7544:0:b0:563:625b:e02e with SMTP id
 g4-20020a4a7544000000b00563625be02emr1873643oof.9.1689959013011; Fri, 21 Jul
 2023 10:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230721150147.11720-2-palmer@rivosinc.com>
In-Reply-To: <20230721150147.11720-2-palmer@rivosinc.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 22 Jul 2023 02:02:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNATF9pxJc0nU3NPnX_PFJr7gF6Baras548ULkO8XE98_VQ@mail.gmail.com>
Message-ID: <CAK7LNATF9pxJc0nU3NPnX_PFJr7gF6Baras548ULkO8XE98_VQ@mail.gmail.com>
Subject: Re: [PATCH] modpost, kallsyms: Treat add '$'-prefixed symbols as
 mapping symbols
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     wangkefeng.wang@huawei.com, mcgrof@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, nicolas@fjasle.eu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

On Sat, Jul 22, 2023 at 12:20=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.co=
m> wrote:
>
> Trying to restrict the '$'-prefix change to RISC-V caused some fallout,
> so let's just treat all those symbols as special.
>
> Fixes: c05780ef3c1 ("module: Ignore RISC-V mapping symbols too")
> Link: https://lore.kernel.org/all/20230712015747.77263-1-wangkefeng.wang@=
huawei.com/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


> ---
> It wasn't clear if we should just revert the original patch and spin a
> new one, but looks like this is in at least some trees so I sent a
> follow-on patch -- at least this way I can make coffee before forgetting
> to send it ;)
> ---
>  include/linux/module_symbol.h | 16 ++--------------
>  kernel/module/kallsyms.c      |  2 +-
>  scripts/mod/modpost.c         |  2 +-
>  3 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/include/linux/module_symbol.h b/include/linux/module_symbol.=
h
> index 5b799942b243..1269543d0634 100644
> --- a/include/linux/module_symbol.h
> +++ b/include/linux/module_symbol.h
> @@ -3,25 +3,13 @@
>  #define _LINUX_MODULE_SYMBOL_H
>
>  /* This ignores the intensely annoying "mapping symbols" found in ELF fi=
les. */
> -static inline int is_mapping_symbol(const char *str, int is_riscv)
> +static inline int is_mapping_symbol(const char *str)
>  {
>         if (str[0] =3D=3D '.' && str[1] =3D=3D 'L')
>                 return true;
>         if (str[0] =3D=3D 'L' && str[1] =3D=3D '0')
>                 return true;
> -       /*
> -        * RISC-V defines various special symbols that start with "$".  T=
he
> -        * mapping symbols, which exist to differentiate between incompat=
ible
> -        * instruction encodings when disassembling, show up all over the=
 place
> -        * and are generally not meant to be treated like other symbols. =
 So
> -        * just ignore any of the special symbols.
> -        */
> -       if (is_riscv)
> -               return str[0] =3D=3D '$';
> -
> -       return str[0] =3D=3D '$' &&
> -              (str[1] =3D=3D 'a' || str[1] =3D=3D 'd' || str[1] =3D=3D '=
t' || str[1] =3D=3D 'x')
> -              && (str[2] =3D=3D '\0' || str[2] =3D=3D '.');
> +       return str[0] =3D=3D '$';
>  }
>
>  #endif /* _LINUX_MODULE_SYMBOL_H */
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 78a1ffc399d9..ef73ae7c8909 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -289,7 +289,7 @@ static const char *find_kallsyms_symbol(struct module=
 *mod,
>                  * and inserted at a whim.
>                  */
>                 if (*kallsyms_symbol_name(kallsyms, i) =3D=3D '\0' ||
> -                   is_mapping_symbol(kallsyms_symbol_name(kallsyms, i), =
IS_ENABLED(CONFIG_RISCV)))
> +                   is_mapping_symbol(kallsyms_symbol_name(kallsyms, i)))
>                         continue;
>
>                 if (thisval <=3D addr && thisval > bestval) {
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7c71429d6502..b29b29707f10 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1052,7 +1052,7 @@ static inline int is_valid_name(struct elf_info *el=
f, Elf_Sym *sym)
>
>         if (!name || !strlen(name))
>                 return 0;
> -       return !is_mapping_symbol(name, elf->hdr->e_machine =3D=3D EM_RIS=
CV);
> +       return !is_mapping_symbol(name);
>  }
>
>  /* Look up the nearest symbol based on the section and the address */
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
