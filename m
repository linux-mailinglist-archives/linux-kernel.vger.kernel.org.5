Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A0376D83F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 21:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjHBTzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 15:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjHBTzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 15:55:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB47268D;
        Wed,  2 Aug 2023 12:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC14C61ACF;
        Wed,  2 Aug 2023 19:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E365C433CA;
        Wed,  2 Aug 2023 19:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691006115;
        bh=904gM4T11OOi6O099vyBbHZDWZV8LGK6IFJewceXYAQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oIlBv0+zpzX9kmDjs1mCPZK4rhN0NVeaX/Jl2JQLm+aO+xDWHqh7/hr8VvMkw5goy
         6P9a3PHO6crcXRFp06D/USBMh8OJFw6g68ZITb1KOOHo8zJlKGZzD/sU6JQZT7hT7Y
         bNZ6NVy2xqj9NkYIbwx+w0jAzj/8d6HCgwUtsmP6ascS8zC1ib9o1nrlVKZo18EryU
         bP99VpwH0vQeL7K9r7GeLYZNTwT3sIYVPCAiTdMnchR361j/v1RuMeMPrIZkZUvpvs
         YH7yJVZt4G4NBHqVaWr98TAVVUx4Px6yLfnPbveZLV2HFoyFmj1otZHia6gAlx+mio
         SPV8XnuIkcBXg==
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3a5a7e7cd61so179509b6e.0;
        Wed, 02 Aug 2023 12:55:15 -0700 (PDT)
X-Gm-Message-State: ABy/qLZYBPczGLox9qCO8c79Lj6lMODdgzSC41hMS0MjlKKihKMrJAPN
        72VEOcEkoW+GP1DQbxkFWqWQNoVEtA+urWw8QdA=
X-Google-Smtp-Source: APBJJlF2Oy3mIBkYDgknSfPr1iqiO7yW0o6xZaST1qF+3uA4Bzwqjm6gwD0V30don6ksJ2Lxnw0vJWv3yPtu516k7DQ=
X-Received: by 2002:a05:6808:2223:b0:3a7:2efb:cb7a with SMTP id
 bd35-20020a056808222300b003a72efbcb7amr8732656oib.24.1691006114528; Wed, 02
 Aug 2023 12:55:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230728113415.21067-1-will@kernel.org> <20230728113415.21067-4-will@kernel.org>
In-Reply-To: <20230728113415.21067-4-will@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Aug 2023 04:54:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNARnOUbySnnqOpP-3KBQTT-WvUHfnjV_sVTKe+faB8=86g@mail.gmail.com>
Message-ID: <CAK7LNARnOUbySnnqOpP-3KBQTT-WvUHfnjV_sVTKe+faB8=86g@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] scripts/faddr2line: Constrain readelf output to
 symbols from System.map
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 8:34=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> Some symbols emitted in the readelf output but filtered from System.map
> can confuse the 'faddr2line' symbol size calculation, resulting in the
> erroneous rejection of valid offsets. This is especially prevalent when
> building an arm64 kernel with CONFIG_CFI_CLANG=3Dy, where most functions
> are prefixed with a 32-bit data value in a '$d.n' section. For example:
>
> 447538: ffff800080014b80   548 FUNC    GLOBAL DEFAULT    2 do_one_initcal=
l
>    104: ffff800080014c74     0 NOTYPE  LOCAL  DEFAULT    2 $x.73
>    106: ffff800080014d30     0 NOTYPE  LOCAL  DEFAULT    2 $x.75
>    111: ffff800080014da4     0 NOTYPE  LOCAL  DEFAULT    2 $d.78
>    112: ffff800080014da8     0 NOTYPE  LOCAL  DEFAULT    2 $x.79
>     36: ffff800080014de0   200 FUNC    LOCAL  DEFAULT    2 run_init_proce=
ss
>
> Adding a warning to do_one_initcall() results in:
>
>   | WARNING: CPU: 0 PID: 1 at init/main.c:1236 do_one_initcall+0xf4/0x260
>
> Which 'faddr2line' refuses to accept:
>
> $ ./scripts/faddr2line vmlinux do_one_initcall+0xf4/0x260
> skipping do_one_initcall address at 0xffff800080014c74 due to size mismat=
ch (0x260 !=3D 0x224)
> no match for do_one_initcall+0xf4/0x260
>
> Filter out entries from readelf using the 'sysmap-ignored-syms.sed'
> script used to construct System.map, so that the size of a symbol is
> calculated as a delta to the next symbol present in ksymtab.


I do not think this patch set is the right approach.

I assume faddr2line is meant to work with both vmlinux
and modules.

A problem is that we have different filtering policies wrt kallsyms.

scripts/mksysmap filters symbols in vmlinux,
while kernel/module/kallsyms.c filters ones in modules.

This patch tries to get aligned with the stacktrace of vmlinux,
but that does not seem optimal to the stacktrace of modules.


I have not checked the details, but I guess
the module kallsyms filters less symbols.

https://github.com/torvalds/linux/blob/v6.5-rc4/kernel/module/kallsyms.c#L2=
88


I prefer filtering symbols in the intersection of vmlinux and modules.

is_mapping_symbol() filters symbols you are addressing.







> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  scripts/faddr2line | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 62a3fa6f6f59..da734af90036 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -64,6 +64,7 @@ else
>         UTIL_PREFIX=3D${CROSS_COMPILE:-}
>  fi
>
> +IGNORED_SYMS=3D$(dirname $0)/sysmap-ignored-syms.sed
>  READELF=3D"${UTIL_PREFIX}readelf"
>  ADDR2LINE=3D"${UTIL_PREFIX}addr2line"
>  AWK=3D"awk"
> @@ -185,7 +186,7 @@ __faddr2line() {
>                                 found=3D2
>                                 break
>                         fi
> -               done < <(${READELF} --symbols --wide $objfile | sed 's/\[=
.*\]//' | ${AWK} -v sec=3D$sym_sec '$7 =3D=3D sec' | sort --key=3D2)
> +               done < <(${READELF} --symbols --wide $objfile | sed -f ${=
IGNORED_SYMS} -e 's/\[.*\]//' | ${AWK} -v sec=3D$sym_sec '$7 =3D=3D sec' | =
sort --key=3D2)
>
>                 if [[ $found =3D 0 ]]; then
>                         warn "can't find symbol: sym_name: $sym_name sym_=
sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"
> --
> 2.41.0.487.g6d72f3e995-goog
>


--
Best Regards
Masahiro Yamada
