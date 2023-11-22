Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604E67F3D50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbjKVFbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:31:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjKVFbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:31:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7854185
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:30:59 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664B6C433CD
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700631059;
        bh=LxgqrVsExp18X41sj9jZd0qVqv8p2H0pjBZVzDy55KE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jxUkwYdg3kdZ5KXh4SvcysIoWYZYZJLWSjXFQj4xu5Kiu/SAIXuW5QvGasMaC3ME0
         w1nefyg+krajFl9lPlTJCVjVSIxuIMGt4hIHEUeqhtFJyG61lvzBAEPwXg/ep5Uf1w
         FVXJVrhUlyLRoTP9KoTiIUrnFO/F/pTkq/m1I5XplwuTwzQwWHe8XNgaEpJCqFyUnx
         WSLJToOep18aMJi4WVDUVgIeHuWLwGA1wO96rrpgyeFmmSCcfnYS4Zk9UKXoFFZQ7e
         e0nJrHa51p0go92sCMWIJG8YGfxvNiDzqSzaCdP2iA1AsdBu1EPnGYwQXgBcL8/Eu+
         j2rdQAvpKZllw==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f937a7b8aaso1638455fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:30:59 -0800 (PST)
X-Gm-Message-State: AOJu0Yyz31aoS8qJwneXX6joAdhSbAMGbG/mvhBC0bq5PrucHcjS15Hb
        34ob0yFKmHUxHuyA/LZlSedTUSf46KEJTcer1nA=
X-Google-Smtp-Source: AGHT+IHWrSTNFAHs6ffKq7KsequdWmSrsTRwhnDAtkAsnz08m90bcY6ZGzSd6zqLwWU4eDcbsP0u4twzBdviXy0n29Y=
X-Received: by 2002:a05:6870:3d86:b0:1f9:5ef5:44df with SMTP id
 lm6-20020a0568703d8600b001f95ef544dfmr1889861oab.14.1700631058773; Tue, 21
 Nov 2023 21:30:58 -0800 (PST)
MIME-Version: 1.0
References: <20231119150229.634424-1-sjg@chromium.org> <20231119150229.634424-2-sjg@chromium.org>
In-Reply-To: <20231119150229.634424-2-sjg@chromium.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 22 Nov 2023 14:30:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR-4LbTWQ+V4Kq1FOevxxw=wfJ1OxHpqLyc1d+e54qjMw@mail.gmail.com>
Message-ID: <CAK7LNAR-4LbTWQ+V4Kq1FOevxxw=wfJ1OxHpqLyc1d+e54qjMw@mail.gmail.com>
Subject: Re: [PATCH v6 1/2] kbuild: arm64: Add BOOT_TARGETS variable
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Tom Rini <trini@konsulko.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
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

On Mon, Nov 20, 2023 at 12:02=E2=80=AFAM Simon Glass <sjg@chromium.org> wro=
te:
>
> Add a new variable containing a list of possible targets. Mark them as
> phony. This matches the approach taken for arch/arm
>
> Signed-off-by: Simon Glass <sjg@chromium.org>



I encounter difficulty in understanding your subject prefix policy.


You used the "arm:" prefix for a patch irrelevant to arm:
https://lore.kernel.org/linux-kbuild/CAK7LNAQN_qGYztWGDmQyfg+eZ5P7RkM47mpgp=
0dQn_iuhvTSWg@mail.gmail.com/




And, the one for this patch.

"kbuild: arm64: Add BOOT_TARGETS variable"

Please do not add "kbuild:" for a patch
that modifies arch/arm64, and that was not even
submitted to kbuild ML.




> ---
>
> Changes in v6:
> - Drop the unwanted .gz suffix
>
>  arch/arm64/Makefile | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 4bd85cc0d32b..ae0c5ee8c78b 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -150,6 +150,10 @@ libs-$(CONFIG_EFI_STUB) +=3D $(objtree)/drivers/firm=
ware/efi/libstub/lib.a
>  # Default target when executing plain make
>  boot           :=3D arch/arm64/boot
>
> +BOOT_TARGETS   :=3D Image vmlinuz.efi
> +
> +PHONY +=3D $(BOOT_TARGETS)
> +
>  ifeq ($(CONFIG_EFI_ZBOOT),)
>  KBUILD_IMAGE   :=3D $(boot)/Image.gz
>  else
> @@ -159,7 +163,7 @@ endif
>  all:   $(notdir $(KBUILD_IMAGE))
>
>
> -Image vmlinuz.efi: vmlinux
> +$(BOOT_TARGETS): vmlinux
>         $(Q)$(MAKE) $(build)=3D$(boot) $(boot)/$@
>
>  Image.%: Image
> --
> 2.43.0.rc0.421.g78406f8d94-goog
>


--
Best Regards
Masahiro Yamada
