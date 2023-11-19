Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837CF7F060D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjKSL7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKSL73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:59:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20F9D8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 03:59:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E990C433C9;
        Sun, 19 Nov 2023 11:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700395165;
        bh=mgjBe9NyXgnGxQbQgYIlmqSGb5CeQDsjaIIrZhyneCw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tNFulk5iOsBbkFYne6Kojs1mmSNu569//aRQSIzuF+M3mgugaM/aTwyHMoLFWS7M8
         9yttTyEgVqKYN8RewwjlKLcrjaqsuIhUdXJgNvjH1jnbQ8+apTh1ClYl0i2iJFR0WB
         IVEdVXt8Fafalt918MqPCO90K0WqZ7fCOEmeGvQcURoWjRK/78XQsI9ZMdG1c0tQhG
         nxGIJUF9Ui8uKxj3hRDcDv9A50JFJaY4C0cyHtFSC8z77qpqa1DPEHw1NS4q3iElkS
         uokZM/CP6Flfdj3AgZTPOiTOp0qlp0tl67yCHZRP0keh/c+7kuiUR35fSBk1nqlqE6
         I6fjSUXYu3gAQ==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-53e70b0a218so4943056a12.2;
        Sun, 19 Nov 2023 03:59:25 -0800 (PST)
X-Gm-Message-State: AOJu0YyrF3uHg/GAnaB118EsrMzpJy1XfiK63rnt020wttxki0LPOZm0
        hp5L0wFNirLBH/iOTqy8PrKv8xo6euSm2WLxJtc=
X-Google-Smtp-Source: AGHT+IEOV0Yphn3EZlTrLENL+ZMt4WbgvODyjNv1KG8aL25BNcVStxecpKUo7uDy0Wrni/U59QS+B0+V5d8IPu8T/Ks=
X-Received: by 2002:aa7:d454:0:b0:548:4f58:4c98 with SMTP id
 q20-20020aa7d454000000b005484f584c98mr3457877edr.29.1700395163796; Sun, 19
 Nov 2023 03:59:23 -0800 (PST)
MIME-Version: 1.0
References: <20231119053448.2367725-1-masahiroy@kernel.org>
In-Reply-To: <20231119053448.2367725-1-masahiroy@kernel.org>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 19 Nov 2023 19:59:11 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
Message-ID: <CAAhV-H6Y4vqc45eaMs+wCN7Quf4e9ogp8aDA8V0sA=TUnMWd-Q@mail.gmail.com>
Subject: Re: [PATCH] loongarch: add dependency between vmlinuz.efi and vmlinux.efi
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Masahiro,

On Sun, Nov 19, 2023 at 1:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> A common issue in Makefile is a race in parallel building.
>
> You need to be careful to prevent multiple threads from writing to the
> same file simultaneously.
>
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") addressed such a bad scenario.
>
> A similar symptom occurs with the following command:
>
>   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/loongarch/boot/vmlinux.efi
>     OBJCOPY arch/loongarch/boot/vmlinux.efi
>     PAD     arch/loongarch/boot/vmlinux.bin
>     GZIP    arch/loongarch/boot/vmlinuz
>     OBJCOPY arch/loongarch/boot/vmlinuz.o
>     LD      arch/loongarch/boot/vmlinuz.efi.elf
>     OBJCOPY arch/loongarch/boot/vmlinuz.efi
>
> The log "OBJCOPY arch/loongarch/boot/vmlinux.efi" is displayed twice.
>
> It indicates that two threads simultaneously enter arch/loongarch/boot/
> and write to arch/loongarch/boot/vmlinux.efi.
>
> It occasionally leads to a build failure:
>
>   $ make -j$(nproc) ARCH=3Dloongarch vmlinux.efi vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/loongarch/boot/vmlinux.efi
>     PAD     arch/loongarch/boot/vmlinux.bin
>   truncate: Invalid number: =E2=80=98arch/loongarch/boot/vmlinux.bin=E2=
=80=99
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
>   arch/loongarch/boot/vmlinux.bin] Error 1
>   make[2]: *** Deleting file 'arch/loongarch/boot/vmlinux.bin'
>   make[1]: *** [arch/loongarch/Makefile:146: vmlinuz.efi] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>   make: *** [Makefile:234: __sub-make] Error 2
>
> vmlinuz.efi depends on vmlinux.efi, but such a dependency is not
> specified in arch/loongarch/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/loongarch/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
> index 9eeb0c05f3f4..6022bf3d30c9 100644
> --- a/arch/loongarch/Makefile
> +++ b/arch/loongarch/Makefile
> @@ -142,6 +142,7 @@ vdso-install-y +=3D arch/loongarch/vdso/vdso.so.dbg
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> +vmlinuz.efi: vmlinux.efi
>  vmlinux.elf vmlinux.efi vmlinuz.efi: vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(bootvars-y) $(boot)/$@
It is a little strange, because

in drivers/firmware/efi/libstub/Makefile.zboot:
vmlinuz.efi depends on vmlinuz.efi.elf, vmlinuz.efi.elf depends on
vmlinuz.o, vmlinuz.o depends on vmlinuz, vmlinuz depends on
vmlinux.bin, vmlinux.bin depends on $(EFI_ZBOOT_PAYLOAD).

in arch/loongarch/boot/Makefile,
EFI_ZBOOT_PAYLOAD :=3D vmlinux.efi

So I think vmlinuz.efi has already depend on vmlinux.efi.

Huacai

>
> --
> 2.40.1
>
>
