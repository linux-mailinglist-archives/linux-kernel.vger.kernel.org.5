Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7675D4C2
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 21:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbjGUTYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 15:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232221AbjGUTYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 15:24:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199EF189;
        Fri, 21 Jul 2023 12:24:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A974361D7F;
        Fri, 21 Jul 2023 19:24:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DF55C433CD;
        Fri, 21 Jul 2023 19:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689967474;
        bh=ZMDz7Ao/mXqDoOt9YqdyFYlyKXkJ8dwXgYd8bgtxMgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dIfxhb+OVuk0F9idwdU1Nqp2ZJSc3V7WLb+EHXnU6XQPkYG9q40hu0yDpXbB2TsuU
         bdAuA9f2LNjpYwymZvN1pi/xM0mGLO2l5qF7FzHBiKEoMDfz+64mgsjFj4fsE3RFxK
         bSj+so11TE5+uDa40Yva/x1RPFStJ/BmxZ1Kzsz3dB9bLjk2pdPL4vI0TbKCaORAdF
         5a30QkKOfedXkVA/oKRqnWcH9JNt+z7HNVVjIqvXNyAfphZ9VyW5zn5wzb0K7Fw823
         vvgJj2UW829OlZxlD0DxCyuSDioG2kgNQRryeccV/INrjA5QkKEQgskCeGevIZ7XZ2
         2fGurbgnWu8+g==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b6f943383eso33941701fa.2;
        Fri, 21 Jul 2023 12:24:34 -0700 (PDT)
X-Gm-Message-State: ABy/qLYtvXbsYWWSxH4hny9KFMyDYXp9+lJwinVvzmaWvq79AWZqbeRO
        CdlnfmajUAEhZ15HD1is5iX3E77nPewMz8byuQ==
X-Google-Smtp-Source: APBJJlHWu7RNKa6G4OWcajuKR+v/9mO3Q4f3e14g7ypnqu1POSVv0p6PFkMlKa+yzKC3DRRdjku8L6M8Rt1M6Sw9RSQ=
X-Received: by 2002:a2e:b70e:0:b0:2b4:45bc:7bd with SMTP id
 j14-20020a2eb70e000000b002b445bc07bdmr2350137ljo.4.1689967472029; Fri, 21 Jul
 2023 12:24:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161840.1393996-1-hugo@hugovil.com> <20230721161840.1393996-7-hugo@hugovil.com>
In-Reply-To: <20230721161840.1393996-7-hugo@hugovil.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 21 Jul 2023 13:24:19 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
Message-ID: <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:19=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
>
> Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control lines"=
)
> and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> changed the function of the GPIOs pins to act as modem control
> lines without any possibility of selecting GPIO function.

Requiring a new DT property is not fixing a kernel regression. You
should be returning the kernel to original behavior and then have a
new DT property for new behavior.

> As a consequence, applications that depends on GPIO lines configured
> by default as GPIO pins no longer work as expected.
>
> Also, the change to select modem control lines function was done only
> for channel A of dual UART variants (752/762). This was not documented
> in the log message.
>
> Allow to specify GPIO or modem control line function in the device
> tree, and for each of the ports (A or B).
>
> Do so by using the new device-tree property named
> "modem-control-line-ports" (property added in separate patch).

That's not the name in the patch.

> When registering GPIO chip controller, mask-out GPIO pins declared as
> modem control lines according to this new "modem-control-line-ports"
> DT property.
>
> Boards that need to have GPIOS configured as modem control lines
> should add that property to their device tree. Here is a list of
> boards using the sc16is7xx driver in their device tree and that may
> need to be modified:
>     arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
>     mips/boot/dts/ingenic/cu1830-neo.dts
>     mips/boot/dts/ingenic/cu1000-neo.dts

Then again, if no one cares about those boards needing a change then
it can be okay.


Rob
