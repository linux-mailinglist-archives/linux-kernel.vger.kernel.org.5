Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C7776C30C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHBCqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjHBCqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261881BFD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:46:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A971161796
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:46:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E5A7C433CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690944368;
        bh=HnyEuLoO+VDuqcAShwayzrYa97t99kvrkI3g8nRH1bE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LMopKQllqF6Rron/qahG6z+UEuJwBxvo5RihH5w3huG2b4uIaKRh1R610l1VHaqLn
         OhRxlj7cU9zvuKincTSSr0Rd3KPk/OsMsJECy2YSJ14wr1RZzGapY0XgwnzaMKd9Jn
         xawTu8ZtgqouoAO3ueUxn2rGB09tQHSbUYKN2Q19k19Gaa4fBIz7kcklHtUjWvn8Lj
         QfkNGXPwe0iBW2uBPG96AttICFGGYh6xBNtoRO4OBKwmen2dZ0K55kuqqbjGiURcRm
         oWqt6KFR+Bjq3QU6Mq+fKfFp9bBjr9Cnsjw/6VZvwH0BCukp1XMj9z8y9JtjGDshlX
         qOml0V3Kmcu/A==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5221c6a2d3dso8954780a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 19:46:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLa7xIe9lRGzRPW8YIgoAg3LwVCwrnj9IGml7YyBNxs3LKxTNL9p
        tj5B8Jt2xRRETiwkNMV5EmsAWlCodkA1mWEFBpY=
X-Google-Smtp-Source: APBJJlFuiC7ZzXS/kRnzvzMpMllUD8gfEnDXCb/hhlZigEgSGAVYYR5o0GTxYcx/i8l0nWh8fGyQova7C3051NeSTcs=
X-Received: by 2002:aa7:cf8e:0:b0:522:219b:ce05 with SMTP id
 z14-20020aa7cf8e000000b00522219bce05mr3687014edx.7.1690944366224; Tue, 01 Aug
 2023 19:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <1690871446-23713-1-git-send-email-yangtiezhu@loongson.cn> <20230801134034.GA3831650@dev-arch.thelio-3990X>
In-Reply-To: <20230801134034.GA3831650@dev-arch.thelio-3990X>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Wed, 2 Aug 2023 10:45:53 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7MeiZpSh28j2TDSwS1ae0L+rGMA7hi+MV2Z3uCiguLkw@mail.gmail.com>
Message-ID: <CAAhV-H7MeiZpSh28j2TDSwS1ae0L+rGMA7hi+MV2Z3uCiguLkw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Error out if clang version is less than 17.0.0
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Nick Desaulniers <ndesaulniers@google.com>,
        loongarch@lists.linux.dev, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org, loongson-kernel@lists.loongnix.cn
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

Hi,

On Tue, Aug 1, 2023 at 9:40=E2=80=AFPM Nathan Chancellor <nathan@kernel.org=
> wrote:
>
> Hi Tiezhu,
>
> On Tue, Aug 01, 2023 at 02:30:46PM +0800, Tiezhu Yang wrote:
> > On my test machine, the clang version is 16.0.4, when build kernel
> > with clang:
> >
> >   make CC=3Dclang loongson3_defconfig
> >   make CC=3Dclang
> >
> > there exist many errors such as:
> >
> >   clang-16: error: argument unused during compilation: '-mabi=3Dlp64s'
> >   error: unknown register name 'a0' in asm
> >   error: unknown register name 't0' in asm
> >
> > the above issues have been fixed in the upstream llvm project recently,
> > it works well when update clang version to 17.0.0:
> >
> >   make CC=3Dclang loongson3_defconfig
> >   make CC=3Dclang menuconfig (set CONFIG_MODULES=3Dn and CONFIG_RELOCAT=
ABLE=3Dn)
> >   make CC=3Dclang
> >
> > thus 17.0.0 is the minimal clang version to build kernel on LoongArch,
> > it is better to error out if clang version is less than 17.0.0, then
> > we can do the right thing to update clang version and avoid wasting
> > time to analysis kernel errors.
> >
> > By the way, the clang 17.0.0 still have some issues to build kernel on
> > LoongArch, you need to unset CONFIG_MODULES and CONFIG_RELOCATABLE to
> > avoid build errors. Additionally, if you want a workable kernel, some
> > modules should be set as y instead of m if CONFIG_MODULES=3Dn.
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/1787
> > Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> > ---
> >  arch/loongarch/Makefile | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> > index b1e5db5..f07f62a 100644
> > --- a/arch/loongarch/Makefile
> > +++ b/arch/loongarch/Makefile
> > @@ -10,6 +10,12 @@ KBUILD_DEFCONFIG :=3D loongson3_defconfig
> >  image-name-y                 :=3D vmlinux
> >  image-name-$(CONFIG_EFI_ZBOOT)       :=3D vmlinuz
> >
> > +ifdef CONFIG_CC_IS_CLANG
> > +  ifneq ($(call clang-min-version, 170000),y)
> > +    $(error Sorry, you need a newer clang version >=3D 17.0.0)
> > +  endif
> > +endif
> > +
>
> Thanks for the patch! I agree that we should restrict LoongArch to LLVM
> 17 and newer. However, there is already existing infrastructure for this
> type of check in Kconfig, so we don't need to add anything to
> arch/loongarch. Just modify scripts/min-tool-version.sh like so then
> there will be a message during configuration time that the compiler is
> too old.
>
> diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
> index 2ade63149466..572c0526ad61 100755
> --- a/scripts/min-tool-version.sh
> +++ b/scripts/min-tool-version.sh
> @@ -26,6 +26,8 @@ gcc)
>  llvm)
>         if [ "$SRCARCH" =3D s390 ]; then
>                 echo 15.0.0
> +       elif [ "$SRCARCH" =3D loongarch ]; then
> +               echo 17.0.0
>         else
>                 echo 11.0.0
>         fi
>
> ***
> *** C compiler is too old.
> ***   Your Clang version:    16.0.6
> ***   Minimum Clang version: 17.0.0
> ***
> scripts/Kconfig.include:44: Sorry, this C compiler is not supported.
This method is better, but since Clang17 cannot build a
full-functional kernel (CONFIG_MODULES, may be solved in Clang18), I
suggest "fix" it in future until all features can be enabled.

Huacai
>
> >  ifndef CONFIG_EFI_STUB
> >  KBUILD_IMAGE :=3D $(boot)/vmlinux.elf
> >  else
> > --
> > 2.1.0
> >
> >
>
> Cheers,
> Nathan
