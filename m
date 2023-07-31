Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C566769FBA
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjGaRsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjGaRss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:48:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CF3FF;
        Mon, 31 Jul 2023 10:48:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E6366124E;
        Mon, 31 Jul 2023 17:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF793C433C7;
        Mon, 31 Jul 2023 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690825722;
        bh=bjBjEuHwzrQ0NRkWKwnSiTCBP/Pr3EKY5Y64j0FEo9g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nq9/0BpQzmbVVyioTwgnmF+LiVuU1z/Zxsnhla6ZEr7/K/m1zwlzS9BYv1TQS3PFg
         JfYUG7jcK5kozOQMUEW4u8wk2WZAWeBLtzqhFEdix9/9fdIj1x8PGYO/bzOwLLI27D
         TG0PaseP/FOEettXmnORV7R8Ay2QBVkKyeQ12NSZj3LF5l+zZM/34xSmXBLxlqN+Bl
         8qXJbjyYAyIi1yoRPmyduEw++F6HcR0LXab7Tbv0MzWqbtt9Xkvy2ON9exK+zZiqQF
         UvbeMIvofZw1zeowhfkVxm3MjBtnkEwHPlqP0vdmmXMFdbPSL7l6uESnUe6HrEeF91
         2su1VMIaX4GkQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb7dc16ff0so7759930e87.2;
        Mon, 31 Jul 2023 10:48:42 -0700 (PDT)
X-Gm-Message-State: ABy/qLZbuZ60VaPap0c4JT//rBCnJvfwogdGXMW98kmb0tb/pTWMVFVa
        gDyKfactktaq/4yZUT+528qQrXnubhQs2+BCCEM=
X-Google-Smtp-Source: APBJJlFXc1wrvDz29i7VeiPpht1OglzfHyjGeJlwJmh3TSSva2nJkPozZGhfNxwENUt69zUQgI9GN7Jevcz7nwRy3Fc=
X-Received: by 2002:a05:6512:208:b0:4f8:66e1:14e8 with SMTP id
 a8-20020a056512020800b004f866e114e8mr378078lfo.69.1690825720828; Mon, 31 Jul
 2023 10:48:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
In-Reply-To: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 31 Jul 2023 19:48:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGXNbkxdDRNojtZD3NhMGK97LOchqGoM-4-tVLgH5JEiA@mail.gmail.com>
Message-ID: <CAMj1kXGXNbkxdDRNojtZD3NhMGK97LOchqGoM-4-tVLgH5JEiA@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add support for Texas Instruments MCRC64 engine
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Jul 2023 at 20:56, Kamlesh Gurudasani <kamlesh@ti.com> wrote:
>
> Add support for MCRC64 engine to calculate 64-bit CRC in Full-CPU mode
>
> MCRC64 engine calculates 64-bit cyclic redundancy checks (CRC)
> according to the ISO 3309 standard.
>
> Generator polynomial: x^64 + x^4 + x^3 + x + 1
> Polynomial value: 0x000000000000001b
>

How will this code be used? WIthout a user of the crc64-iso crypto API
algorithm, there is no point in having a driver that implements it.

Also, *if* such a user exists, we'd need to have a generic C
implementation as well - we don't add new algorithms unless they can
be enabled on all platforms and architectures.


> Tested with
>
> and tcrypt,
> sudo modprobe tcrypt mode=329 sec=1
>
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
> Kamlesh Gurudasani (5):
>       crypto: crc64 - add crc64-iso test vectors
>       dt-bindings: crypto: Add binding for TI MCRC64 driver
>       crypto: ti - add driver for MCRC64 engine
>       arm64: dts: ti: k3-am62: Add dt node, cbass_main ranges for MCRC64
>       arm64: defconfig: enable MCRC module
>
>  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml |  42 +++++++
>  MAINTAINERS                                             |   7 ++
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi                |   7 ++
>  arch/arm64/boot/dts/ti/k3-am62.dtsi                     |   1 +
>  arch/arm64/configs/defconfig                            |   2 +
>  crypto/tcrypt.c                                         |   5 +
>  crypto/testmgr.c                                        |   7 ++
>  crypto/testmgr.h                                        | 401 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/crypto/Kconfig                                  |   1 +
>  drivers/crypto/Makefile                                 |   1 +
>  drivers/crypto/ti/Kconfig                               |  10 ++
>  drivers/crypto/ti/Makefile                              |   2 +
>  drivers/crypto/ti/mcrc64.c                              | 360 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  13 files changed, 846 insertions(+)
> ---
> base-commit: d7b3af5a77e8d8da28f435f313e069aea5bcf172
> change-id: 20230719-mcrc-upstream-7ae9a75cab37
>
> Best regards,
> --
> Kamlesh Gurudasani <kamlesh@ti.com>
>
