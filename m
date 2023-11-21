Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5E27F33E7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjKUQhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjKUQhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:37:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D03FE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BE0C433C9;
        Tue, 21 Nov 2023 16:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584620;
        bh=90jfxCqzjOBfBN+wpF26ZcGIh+zvRIz7KOwb6AcEbkk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iVzqhREwZPIcasf4XWCszbWXVJDs8LY4hHhilR3fXsLsLZ0fWJO8k79KzCMyvIAHc
         cI9iZJ6+O3USDAdAEySFLBOIGlPKhLyEfs5kcbxlI+q3rqwyMe5Lb8+o/PlXDLIxl6
         hNSiRmvHgkf0kF/IEkDRbd75UxggTeohYIWmVIRZgWBIwn93RbxYyF2z1XWnpRCXLT
         tonxPq2JKNQXTjqwMNjeM5WStrTT5BBRHWQbTnksnXwHo0RY3qzYRKwZAIaSfz3VQt
         TWoT+JXq214C2oceKyGPUdwHTttVbpymo6shPUg7QEi8xgsTchxPjIdGyjndD6S3sP
         BXoT63PqgDZKA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c87903d314so37198141fa.1;
        Tue, 21 Nov 2023 08:37:00 -0800 (PST)
X-Gm-Message-State: AOJu0YwL/e42V4jat+s3ntVFguTqGks3+xN+D3VTPnef2YvgQ5cw40Ut
        W252xORdcIIhjarZZckwjFiSZmgkf/KXFoYGN7Y=
X-Google-Smtp-Source: AGHT+IHNYCwF3uqqI4dsPxCI3mpJ+DNt7kg6IHqCmH3GN1kM9w/qG4RkuMgpCd8A0ebUCzePmaiJMAeizaskFjJhi3Q=
X-Received: by 2002:a2e:b4b4:0:b0:2c5:6e01:58b8 with SMTP id
 q20-20020a2eb4b4000000b002c56e0158b8mr6668049ljm.37.1700584619083; Tue, 21
 Nov 2023 08:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20231119100024.2370992-1-masahiroy@kernel.org>
In-Reply-To: <20231119100024.2370992-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Nov 2023 11:36:48 -0500
X-Gmail-Original-Message-ID: <CAMj1kXF5Vm+Br68qk3rxgtsUxTknz2stfBTpruwQ3diVQrAc3Q@mail.gmail.com>
Message-ID: <CAMj1kXF5Vm+Br68qk3rxgtsUxTknz2stfBTpruwQ3diVQrAc3Q@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: add dependency among Image(.gz), loader(.bin),
 and vmlinuz.efi
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Simon Glass <sjg@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Nov 2023 at 05:00, Masahiro Yamada <masahiroy@kernel.org> wrote:
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
>   $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
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
> The log "OBJCOPY arch/riscv/boot/Image" is displayed 5 times.
> (also "AS      arch/riscv/boot/loader.o" twice.)
>
> It indicates that 5 threads simultaneously enter arch/riscv/boot/
> and write to arch/riscv/boot/Image.
>
> It occasionally leads to a build failure:
>
>   $ make -j$(nproc) ARCH=riscv Image Image.gz loader loader.bin vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     OBJCOPY arch/riscv/boot/Image
>     PAD     arch/riscv/boot/vmlinux.bin
>   truncate: Invalid number: 'arch/riscv/boot/vmlinux.bin'
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13: arch/riscv/boot/vmlinux.bin] Error 1
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
> Changes in v2:
>   - Fix commit log
>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

>  arch/riscv/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
> index 5cbe596345c1..1d6ed27e0a2a 100644
> --- a/arch/riscv/Makefile
> +++ b/arch/riscv/Makefile
> @@ -163,6 +163,8 @@ BOOT_TARGETS := Image Image.gz loader loader.bin xipImage vmlinuz.efi
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> +loader.bin: loader
> +Image.gz loader vmlinuz.efi: Image
>  $(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>         @$(kecho) '  Kernel: $(boot)/$@ is ready'
> --
> 2.40.1
>
