Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057607F050E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjKSJsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKSJsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:48:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C08DF9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:48:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D681CC433CA;
        Sun, 19 Nov 2023 09:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700387317;
        bh=NjMYq6MXExBDl+vrWIECnV0UHI7pr37FEC8+gej0u7Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qwFZRBx3aGzsQHXpkNY9FSJTOkNMeUA9qJ51SEgGqqxx6gqWQEjzrpsbqlX3dCPZ3
         SZ/XoypuTa1u293pvnms/mnlm0OXRD1yQWHaAW3uuP0aIblYwJ/BLsiAmUgMY4g3B9
         +mNmvaRNv6TO2Ag2Xt/Q4K106fAQ81+ev03Zt0bPWPuK+7IW2Zu2aWXD/h7tS4VVgL
         4EFb9TPJX8qbKLtnLO/08SZfNBw3uKnyMMjJkBmfPAx5ZAzuFgtmSjSjL4y8XjQcuG
         2MXSxNARFs+Om8pTzWSe5DJ1cPKVPmGZ+Nt/4k/JF5sxmGmx+wWx1xN7t1CajfCq5B
         wr+q4VBI6fGYg==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5845a94dae1so1736882eaf.0;
        Sun, 19 Nov 2023 01:48:37 -0800 (PST)
X-Gm-Message-State: AOJu0Yy3J/fvaGuLdYhP1KebJUTi8eXBA+8oAWls4Gq+tfIM78vXqJb8
        cin/zmAmTu7PxDFY4oXCqjU4JQltNigMcNcllBA=
X-Google-Smtp-Source: AGHT+IE6z+tvXHg886wAuoJeQkv9GmDqBKixE2HKcHXdclxIDcR3F1pTaGC/sbGwRWTxFE+xaf9fwKPDcuprbmIbL+4=
X-Received: by 2002:a05:6808:7:b0:3b2:f335:63dc with SMTP id
 u7-20020a056808000700b003b2f33563dcmr4153063oic.23.1700387317182; Sun, 19 Nov
 2023 01:48:37 -0800 (PST)
MIME-Version: 1.0
References: <20231119053737.2367955-1-masahiroy@kernel.org>
In-Reply-To: <20231119053737.2367955-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 19 Nov 2023 18:48:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARb=gBLRuWiaviryMvVYWL0yF_OxdSKnMr7Gjt2s3J2hw@mail.gmail.com>
Message-ID: <CAK7LNARb=gBLRuWiaviryMvVYWL0yF_OxdSKnMr7Gjt2s3J2hw@mail.gmail.com>
Subject: Re: [PATCH] riscv: add dependency among Image(.gz), loader(.bin), and vmlinuz.efi
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
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

On Sun, Nov 19, 2023 at 2:37=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
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
>   $ make -j$(nproc) ARCH=3Driscv Image Image.gz loader loader.bin vmlinuz=
.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     GZIP    arch/riscv/boot/Image.gz
>     AS      arch/riscv/boot/loader.o
>     AS      arch/riscv/boot/loader.o
>     Kernel: arch/riscv/boot/Image is ready
>     PAD     arch/riscv/boot/vmlinux.bin
>     GZIP    arch/riscv/boot/vmlinuz
>     Kernel: arch/riscv/boot/loader is ready
>     OBJCOPY arch/riscv/boot/loader.bin
>     Kernel: arch/riscv/boot/loader.bin is ready
>     Kernel: arch/riscv/boot/Image.gz is ready
>     OBJCOPY arch/riscv/boot/vmlinuz.o
>     LD      arch/riscv/boot/vmlinuz.efi.elf
>     OBJCOPY arch/riscv/boot/vmlinuz.efi
>     Kernel: arch/riscv/boot/vmlinuz.efi is ready
>
> The log "OBJCOPY arch/arm64/boot/Image" is displayed 5 times.



This should be "OBJCOPY arch/riscv/boot/Image".


I submitted a similar patch for arm64.

I copy-pasted some parts of the commit description,
then missed to adjust it.









> (also "AS      arch/riscv/boot/loader.o" twice.)
>
> It indicates that 5 threads simultaneously enter arch/riscv/boot/
> and write to arch/riscv/boot/Image.
>
> It occasionally leads to a build failure:
>
>   $ make -j$(nproc) ARCH=3Driscv Image Image.gz loader loader.bin vmlinuz=
.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     PAD     arch/riscv/boot/vmlinux.bin
>   truncate: Invalid number: 'arch/riscv/boot/vmlinux.bin'
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13: arch/risc=
v/boot/vmlinux.bin] Error 1
>   make[2]: *** Deleting file 'arch/riscv/boot/vmlinux.bin'
>   make[1]: *** [arch/riscv/Makefile:167: vmlinuz.efi] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>     Kernel: arch/riscv/boot/Image is ready
>     GZIP    arch/riscv/boot/Image.gz
>     AS      arch/riscv/boot/loader.o
>     AS      arch/riscv/boot/loader.o
>     Kernel: arch/riscv/boot/loader is ready
>     OBJCOPY arch/riscv/boot/loader.bin
>     Kernel: arch/riscv/boot/loader.bin is ready
>     Kernel: arch/riscv/boot/Image.gz is ready
>   make: *** [Makefile:234: __sub-make] Error 2
>
> Image.gz, loader, vmlinuz.efi depend on Image. loader.bin depends
> on loader. Such dependencies are not specified in arch/riscv/Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 5cbe596345c1..1d6ed27e0a2a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -163,6 +163,8 @@ BOOT_TARGETS :=3D Image Image.gz loader loader.bin xi=
pImage vmlinuz.efi
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> +loader.bin: loader
> +Image.gz loader vmlinuz.efi: Image
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>         @$(kecho) '  Kernel: $(boot)/$@ is ready'
> --
> 2.40.1
>


--=20
Best Regards
Masahiro Yamada
