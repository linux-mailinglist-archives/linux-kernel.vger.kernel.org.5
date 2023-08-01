Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2497576B2A9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234306AbjHALGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbjHALGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07B7ABB;
        Tue,  1 Aug 2023 03:59:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA38061531;
        Tue,  1 Aug 2023 10:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC84C433C9;
        Tue,  1 Aug 2023 10:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690887598;
        bh=cJ6HxF/ThVR/+zvBOoBquVMaIQzGoP/7I5cRuZVbKXk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GrZtGmBdeIoyU2JiaGKKDBn3Nl8VLA+7Vojpmhlw3zVvHa48VBG3ieI9OytShJwi2
         U2nN8BFFtw+YOUkkOoSm1BkUwCfjaU2my6TFQ2yTJkdke+21jEZKYk0QTF9wM6KzNc
         5poC1oTNbMl9oaOWm3lKK7riTCj2rQXfkSzRt4QJTXF1lfTD1lxGZn56rkMo0rGOlT
         S9c1jBV8AaqiEhfz23ekmGVZ9nTJQ4J6uuNekicEPyjWP0fs2JULp2a20aoICXYuuM
         bkn6+6+p6T/jRgJ7cw+db3NlG1hEBvbxVnffE0in0mjLKh1n+vYlDqELzaIMGSVrrD
         781oZ0oHW02Nw==
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-522c9d388d2so2553573a12.3;
        Tue, 01 Aug 2023 03:59:58 -0700 (PDT)
X-Gm-Message-State: ABy/qLYN8K64K6yFDRrUoPrpgvWop9Zd080I37kbNLkt7lroXplMkD/o
        o/AItp22Ys/E/r441EYGD/orQOaxv9hAXnGyusU=
X-Google-Smtp-Source: APBJJlGsjvVUdm0WV1N6LPXXmNwny1y2pnBM4pxtv3fQG12+7vk1ulLoruprtA24W9EggBNpBOOK4g/odFc4GuJfPZk=
X-Received: by 2002:a50:ec92:0:b0:522:2d1b:5a2e with SMTP id
 e18-20020a50ec92000000b005222d1b5a2emr2092080edr.12.1690887596515; Tue, 01
 Aug 2023 03:59:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230731095534.22842-1-xingmingzheng@iscas.ac.cn> <20230731150511.38140-1-xingmingzheng@iscas.ac.cn>
In-Reply-To: <20230731150511.38140-1-xingmingzheng@iscas.ac.cn>
From:   Guo Ren <guoren@kernel.org>
Date:   Tue, 1 Aug 2023 18:59:45 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ75bFm+=dZBV1dijNv5h-kKuAYKHkakgq-seTS5BWOBw@mail.gmail.com>
Message-ID: <CAJF2gTQ75bFm+=dZBV1dijNv5h-kKuAYKHkakgq-seTS5BWOBw@mail.gmail.com>
Subject: Re: [PATCH] riscv: Handle zicsr/zifencei issue between gcc and binutils
To:     Mingzheng Xing <xingmingzheng@iscas.ac.cn>
Cc:     Conor Dooley <conor@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Bin Meng <bmeng@tinylab.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 11:06=E2=80=AFPM Mingzheng Xing
<xingmingzheng@iscas.ac.cn> wrote:
>
> Binutils-2.38 and GCC-12.1.0 bumped[0][1] the default ISA spec to the new=
er
> 20191213 version which moves some instructions from the I extension to th=
e
> Zicsr and Zifencei extensions. So if one of the binutils and GCC exceeds
> that version, we should explicitly specifying Zicsr and Zifencei via -mar=
ch
> to cope with the new changes. but this only occurs when binutils >=3D 2.3=
6
> and GCC >=3D 11.1.0. It's a different story when binutils < 2.36.
>
> binutils-2.36 supports the Zifencei extension[2] and splits Zifencei and
> Zicsr from I[3]. GCC-11.1.0 is particular[4] because it add support Zicsr
> and Zifencei extension for -march. binutils-2.35 does not support the
> Zifencei extension, and does not need to specify Zicsr and Zifencei when
> working with GCC >=3D 12.1.0.
>
> To make our lives easier, let's relax the check to binutils >=3D 2.36 in
> CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. For the other two cases,
> where clang < 17 or GCC < 11.1.0, we will deal with them in
> CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
>
> For more information, please refer to:
> commit 6df2a016c0c8 ("riscv: fix build with binutils 2.38")
> commit e89c2e815e76 ("riscv: Handle zicsr/zifencei issues between clang a=
nd binutils")
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3Daed=
44286efa8ae8717a77d94b51ac3614e2ca6dc [0]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a62579=
d4a7a4a76bab51b5b52fec2cd [1]
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D5a1=
b31e1e1cee6e9f1c92abff59cdcfff0dddf30 [2]
> Link: https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=3D729=
a53530e86972d1143553a415db34e6e01d5d2 [3]
> Link: https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Db03be74bad08c38=
2da47e048007a78fa3fb4ef49 [4]
> Link: https://lore.kernel.org/all/20230308220842.1231003-1-conor@kernel.o=
rg
> Link: https://lore.kernel.org/all/20230223220546.52879-1-conor@kernel.org
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Mingzheng Xing <xingmingzheng@iscas.ac.cn>
> ---
>  arch/riscv/Kconfig                     | 32 +++++++++++++++-----------
>  arch/riscv/kernel/compat_vdso/Makefile |  8 ++++++-
>  2 files changed, 26 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 4c07b9189c86..10e7a7ad175a 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -570,24 +570,30 @@ config TOOLCHAIN_HAS_ZIHINTPAUSE
>  config TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>         def_bool y
>         # https://sourceware.org/git/?p=3Dbinutils-gdb.git;a=3Dcommit;h=
=3Daed44286efa8ae8717a77d94b51ac3614e2ca6dc
> -       depends on AS_IS_GNU && AS_VERSION >=3D 23800
> -       help
> -         Newer binutils versions default to ISA spec version 20191213 wh=
ich
> -         moves some instructions from the I extension to the Zicsr and Z=
ifencei
> -         extensions.
> +       # https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3D98416dbb0a6=
2579d4a7a4a76bab51b5b52fec2cd
> +       depends on AS_IS_GNU && AS_VERSION >=3D 23600
> +       help
> +         Binutils-2.38 and GCC-12.1.0 bumped the default ISA spec to the=
 newer
> +         20191213 version, which moves some instructions from the I exte=
nsion to
> +         the Zicsr and Zifencei extensions. This requires explicitly spe=
cifying
> +         Zicsr and Zifencei when binutils >=3D 2.38 or GCC >=3D 12.1.0. =
Zicsr
> +         and Zifencei are supported in binutils from version 2.36 onward=
s.
> +         To make life easier, and avoid forcing toolchains that default =
to a
> +         newer ISA spec to version 2.2, relax the check to binutils >=3D=
 2.36.
> +         For clang < 17 or GCC < 11.1.0, for which this is not possible,=
 this is
> +         dealt with in CONFIG_TOOLCHAIN_NEEDS_OLD_ISA_SPEC.
>
>  config TOOLCHAIN_NEEDS_OLD_ISA_SPEC
>         def_bool y
>         depends on TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
>         # https://github.com/llvm/llvm-project/commit/22e199e6afb1263c943=
c0c0d4498694e15bf8a16
> -       depends on CC_IS_CLANG && CLANG_VERSION < 170000
> -       help
> -         Certain versions of clang do not support zicsr and zifencei via=
 -march
> -         but newer versions of binutils require it for the reasons noted=
 in the
> -         help text of CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI. Th=
is
> -         option causes an older ISA spec compatible with these older ver=
sions
> -         of clang to be passed to GAS, which has the same result as pass=
ing zicsr
> -         and zifencei to -march.
> +       # https://gcc.gnu.org/git/?p=3Dgcc.git;a=3Dcommit;h=3Db03be74bad0=
8c382da47e048007a78fa3fb4ef49
> +       depends on (CC_IS_CLANG && CLANG_VERSION < 170000) || (CC_IS_GCC =
&& GCC_VERSION < 110100)
> +       help
> +         Certain versions of clang and GCC do not support zicsr and zife=
ncei via
> +         -march. This option causes an older ISA spec compatible with th=
ese older
> +         versions of clang and GCC to be passed to GAS, which has the sa=
me result
> +         as passing zicsr and zifencei to -march.
>
>  config FPU
>         bool "FPU support"
> diff --git a/arch/riscv/kernel/compat_vdso/Makefile b/arch/riscv/kernel/c=
ompat_vdso/Makefile
> index 189345773e7e..b86e5e2c3aea 100644
> --- a/arch/riscv/kernel/compat_vdso/Makefile
> +++ b/arch/riscv/kernel/compat_vdso/Makefile
> @@ -11,7 +11,13 @@ compat_vdso-syms +=3D flush_icache
>  COMPAT_CC :=3D $(CC)
>  COMPAT_LD :=3D $(LD)
>
> -COMPAT_CC_FLAGS :=3D -march=3Drv32g -mabi=3Dilp32
> +# binutils 2.35 does not support the zifencei extension, but in the ISA
> +# spec 20191213, G stands for IMAFD_ZICSR_ZIFENCEI.
> +ifdef CONFIG_TOOLCHAIN_NEEDS_EXPLICIT_ZICSR_ZIFENCEI
Acked-by: Guo Ren <guoren@kernel.org>

> +       COMPAT_CC_FLAGS :=3D -march=3Drv32g -mabi=3Dilp32
> +else
> +       COMPAT_CC_FLAGS :=3D -march=3Drv32imafd -mabi=3Dilp32
> +endif


>  COMPAT_LD_FLAGS :=3D -melf32lriscv
>
>  # Disable attributes, as they're useless and break the build.
> --
> 2.34.1
>


--=20
Best Regards
 Guo Ren
