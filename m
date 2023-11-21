Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39087F33DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbjKUQfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233066AbjKUQfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:35:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4EBE191
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:35:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ABB6C433D9;
        Tue, 21 Nov 2023 16:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700584542;
        bh=jwL03/K8YeD2jnmP6ZZpSn8RsDsIl0wx5YcIiq9/kBQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=o/cCR2Wv6DY8Q+Bq6b9PspN6JJ6/f7prp3yUBZOtiHiXJwBMlDEuzSHhKtYDyBqKR
         B6lI7NvWbuGrp9IkvZyyxBhUPSFiBBMmB/DP+USJlYXzgttwAT79LmGoRkQOV4x+TN
         f+1xE+VybJXRn5emR0dxJ/Sd+/IIbtGkkpHl70ZqyG1phOpYpc4+cPPArKAcf4yXd2
         /RDjpY2RTiB43vFpasMZTahEeO+kRCRFASFkLnk3KQbAjWxrZhhXDjpJgvrO2IShAs
         bD/14zR8yPcHnRQvqswOlMWhBznjFkkwpe2IaCNHAa9gl/Yjzx6ifbi4+HQlIQS/FP
         JYV33mT6VfSsw==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2c876e44157so38606381fa.2;
        Tue, 21 Nov 2023 08:35:42 -0800 (PST)
X-Gm-Message-State: AOJu0YwdkBYuNEbCdUYddPiYJkdD1KbeC1d8+KBhV+AGPnQPUk0ewKJW
        5wOOxS/IptSCSa+sMCQJ/a3iW8+g91WyoW4D8dY=
X-Google-Smtp-Source: AGHT+IGlrwEyOO6nOCeESzD8uRFWLsAZRGejsSPc/DqM8lP/LYqFtG8+7YSFZL0NSNOGK3Kg+q1rURqiPZoakdR47M0=
X-Received: by 2002:a2e:9101:0:b0:2c5:32b:28fa with SMTP id
 m1-20020a2e9101000000b002c5032b28famr9662302ljg.30.1700584540586; Tue, 21 Nov
 2023 08:35:40 -0800 (PST)
MIME-Version: 1.0
References: <20231119053234.2367621-1-masahiroy@kernel.org>
In-Reply-To: <20231119053234.2367621-1-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 21 Nov 2023 11:35:29 -0500
X-Gmail-Original-Message-ID: <CAMj1kXH4pWRXWpqUCgWrbBQ9JEQX0MXb5s6+DjL5+_jw0YyLVA@mail.gmail.com>
Message-ID: <CAMj1kXH4pWRXWpqUCgWrbBQ9JEQX0MXb5s6+DjL5+_jw0YyLVA@mail.gmail.com>
Subject: Re: [PATCH] arm64: add dependency between vmlinuz.efi and Image
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
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

On Sun, 19 Nov 2023 at 00:32, Masahiro Yamada <masahiroy@kernel.org> wrote:
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
>   $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/arm64/boot/Image
>     OBJCOPY arch/arm64/boot/Image
>     AS      arch/arm64/boot/zboot-header.o
>     PAD     arch/arm64/boot/vmlinux.bin
>     GZIP    arch/arm64/boot/vmlinuz
>     OBJCOPY arch/arm64/boot/vmlinuz.o
>     LD      arch/arm64/boot/vmlinuz.efi.elf
>     OBJCOPY arch/arm64/boot/vmlinuz.efi
>
> The log "OBJCOPY arch/arm64/boot/Image" is displayed twice.
>
> It indicates that two threads simultaneously enter arch/arm64/boot/
> and write to arch/arm64/boot/Image.
>
> It occasionally leads to a build failure:
>
>   $ make -j$(nproc) ARCH=arm64 Image vmlinuz.efi
>     [ snip ]
>     SORTTAB vmlinux
>     OBJCOPY arch/arm64/boot/Image
>     PAD     arch/arm64/boot/vmlinux.bin
>   truncate: Invalid number: 'arch/arm64/boot/vmlinux.bin'
>   make[2]: *** [drivers/firmware/efi/libstub/Makefile.zboot:13:
>   arch/arm64/boot/vmlinux.bin] Error 1
>   make[2]: *** Deleting file 'arch/arm64/boot/vmlinux.bin'
>   make[1]: *** [arch/arm64/Makefile:163: vmlinuz.efi] Error 2
>   make[1]: *** Waiting for unfinished jobs....
>   make: *** [Makefile:234: __sub-make] Error 2
>
> vmlinuz.efi depends on Image, but such a dependency is not specified
> in arch/arm64/Makefile.
>

To clarify, this dependency /is/ specified in
arch/arm64/boot/Makefile, which is consumed by explicit make
invocations from arch/arm64/Makefile, and these may end up racing with
each other.


> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Acked-by: Ard Biesheuvel <ardb@kernel.org>

> ---
>
>  arch/arm64/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4a1ad3248c2d..47ecc4cff9d2 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -158,7 +158,7 @@ endif
>
>  all:   $(notdir $(KBUILD_IMAGE))
>
> -
> +vmlinuz.efi: Image
>  Image vmlinuz.efi: vmlinux
>         $(Q)$(MAKE) $(build)=$(boot) $(boot)/$@
>
> --
> 2.40.1
>
