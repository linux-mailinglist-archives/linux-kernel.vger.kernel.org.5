Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A6976EB71
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbjHCOAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbjHCOAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:00:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B4501728
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDE6961DAB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DB7C43391
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691071203;
        bh=nYs7lJDt7N61GA4YVSraqiVO9A9w8LhWnKN4CHuE+Ks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=T4EhrlVo+8cpRGwPSS4i+pUgUucpreAjy7swOw4/ups59uRxIc2flaF/II102qtHy
         b02dHM0JxYHldVSVILDkbwCy4D4j2sTxFevOA3nRuXEe3Y/9SneqnHBdttLga4oXZM
         tQJ1/T72c2yqqf7VMCvrLQJRA75DPEQnnQYN0kd+uG80OoPtchwfd1zE4/cOkiDWmr
         W2GxmjLRL4SvuugsAgSeEnOBg5KQ/Rzt8W5105ZNx9RE/O8VFvnWk5AAIlDpQQV8DL
         EzlMiyTo9jhtbTT89Vwk7v0eYBmcB75phhCodRmXrYI+3xk0B2ut2hahA/0rxc7+Mu
         o/+N1IzfxXdOg==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fe216edaf7so2660929e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:03 -0700 (PDT)
X-Gm-Message-State: ABy/qLZlvhqa1rX/mbAYF9SZN61Tc/sqmDWMgdIxoKZ5kJyAfw7KRj41
        bbWEXsRDFjztpHDX1albeCaHPtp453CcCGf/54k=
X-Google-Smtp-Source: APBJJlGs2QB5Uv2hLdIBNTETiYbyzhxPeE9iZ3O4a7kIN8FdzlCGkuTp0mMyom8Mh9wlYOzk5mWhopg9NSM8tYZ4Di0=
X-Received: by 2002:a05:6512:2085:b0:4fb:fb4e:7580 with SMTP id
 t5-20020a056512208500b004fbfb4e7580mr2826897lfr.8.1691071201190; Thu, 03 Aug
 2023 07:00:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230517181353.381073-1-kursad.oney@broadcom.com>
In-Reply-To: <20230517181353.381073-1-kursad.oney@broadcom.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 3 Aug 2023 15:59:50 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH0HJg2g_6TspGhMVkWLo4wGCmXXnno2ty-sbDwu9ft_A@mail.gmail.com>
Message-ID: <CAMj1kXH0HJg2g_6TspGhMVkWLo4wGCmXXnno2ty-sbDwu9ft_A@mail.gmail.com>
Subject: Re: [PATCH] ARM: memset: cast the constant byte to unsigned char
To:     Kursad Oney <kursad.oney@broadcom.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 May 2023 at 20:14, Kursad Oney <kursad.oney@broadcom.com> wrote:
>
> memset() description in ISO/IEC 9899:1999 (and elsewhere) says:
>
>         The memset function copies the value of c (converted to an
>         unsigned char) into each of the first n characters of the
>         object pointed to by s.
>
> The kernel's arm32 memset does not cast c to unsigned char. This results
> in the following code to produce erroneous output:
>
>         char a[128];
>         memset(a, -128, sizeof(a));
>
> This is because gcc will generally emit the following code before
> it calls memset() :
>
>         mov   r0, r7
>         mvn   r1, #127        ; 0x7f
>         bl    00000000 <memset>
>
> r1 ends up with 0xffffff80 before being used by memset() and the
> 'a' array will have -128 once in every four bytes while the other
> bytes will be set incorrectly to -1 like this (printing the first
> 8 bytes) :
>
>         test_module: -128 -1 -1 -1
>         test_module: -1 -1 -1 -128
>
> The change here is to 'and' r1 with 255 before it is used.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Kursad Oney <kursad.oney@broadcom.com>
>
> ---
>
>  arch/arm/lib/memset.S | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
> index d71ab61430b2..de75ae4d5ab4 100644
> --- a/arch/arm/lib/memset.S
> +++ b/arch/arm/lib/memset.S
> @@ -17,6 +17,7 @@ ENTRY(__memset)
>  ENTRY(mmioset)
>  WEAK(memset)
>  UNWIND( .fnstart         )
> +       and     r1, r1, #255            @ cast to unsigned char
>         ands    r3, r0, #3              @ 1 unaligned?
>         mov     ip, r0                  @ preserve r0 as return value
>         bne     6f                      @ 1

Yes, this is clearly a bug. The value in R1 is expanded to 32 bits like this

1:      orr     r1, r1, r1, lsl #8
        orr     r1, r1, r1, lsl #16

which assumes that the upper bytes are 0x0, which they are not in this case.



Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
