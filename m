Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5597D786072
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238153AbjHWTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238031AbjHWTOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:14:05 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5EE10C3;
        Wed, 23 Aug 2023 12:14:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99df431d4bfso777344366b.1;
        Wed, 23 Aug 2023 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692818042; x=1693422842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OCIrAxFDF25mzcKHeRcgDzkO8YOJQLUfVKMU+Ywn+CI=;
        b=F0m1dC0r1D9CfIev6pc24EaKzGxk0UuGNnqavKUqIieO1QM7EZ7130J/Dl71vD6cck
         b4tEURRXTFB8K8kYrJunVHW9jBttCV6oOn8MVoJC79gH1IKNI19yDUYtMafAbmCqjXGD
         jVl603iPiqILuA4/TICEL/jjU1Zfbn8GRo7IvKdaiiAVALYvHyo8QXpiqsHXR3TLXa0H
         BMTTH8pb0RyPS7pzI0xuKr4OWTzNw+a/EX5nYDengR5UprSeu/PNWdOWKKpalqT87OfD
         yS2EFWh9G3CbcUle03vyDcSzD2TgQgsnuyYnmsRhV0Z/we7N8WB/AHWK+LsXaMGpdm0x
         eX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692818042; x=1693422842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OCIrAxFDF25mzcKHeRcgDzkO8YOJQLUfVKMU+Ywn+CI=;
        b=KhIrxkTnYyrlKngpOd4Q5IBFFSoXyxCjJOVNPbmjTdB3kxxiaGo75LkdE3Li7djVrx
         U1LkRO8JFwnliNkc0wAxQlRPDGXMvQgL+TNC5hNVkzj2ST00hFj6vddYlYn64RgeXqkh
         IO+0i6xTTLitwIxmCtY+PAdV7Tj+UDS0apaDL4JwJqwOejn4wWt+FSlZpmzUs5l1ei/p
         LNWQdnJy4sBagE6uSqjIh0RvhvyvXVItQzW0SUavE8DkGQL/vx+2OGqv/l2JVvZtpB40
         lb+kCexnyUOqN8IemcuomW1gZQiiNols2+or5U3ZqHNuen55epjqWF3YDHlaJRL0kUSS
         tBWA==
X-Gm-Message-State: AOJu0Yyhz9YDGwp14B0CiaXXM2zL/WPBocln+fg0WrHvbtldVAw0mGDS
        j/qVVKCGXj2cR1KEdmnFyug=
X-Google-Smtp-Source: AGHT+IFbojcSnWWb57HEiIyw8RL+IR9XS37Wm62sPrbcTpWpKP2WmF6c9EcbiBXGI99RpkWM2z7iJQ==
X-Received: by 2002:a17:906:cc2:b0:99d:f560:5d3c with SMTP id l2-20020a1709060cc200b0099df5605d3cmr11357511ejh.23.1692818042131;
        Wed, 23 Aug 2023 12:14:02 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id f15-20020a170906084f00b0099cf9bf4c98sm10059758ejd.8.2023.08.23.12.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 12:14:01 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-renesas-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ARM: dts: use capital "OR" for multiple licenses in SPDX
Date:   Wed, 23 Aug 2023 21:13:59 +0200
Message-ID: <4504114.LvFx2qVVIh@jernej-laptop>
In-Reply-To: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
References: <20230823085146.113562-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 23. avgust 2023 ob 10:51:45 CEST je Krzysztof Kozlowski napisal(a):
> Documentation/process/license-rules.rst and checkpatch expect the SPDX
> identifier syntax for multiple licenses to use capital "OR".  Correct it
> to keep consistent format and avoid copy-paste issues.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Rebased on next-20230822, so might not apply cleanly.  What does not
> apply, can be skipped and I will fix it after next RC.
> ---
>  arch/arm/boot/dts/allwinner/sun8i-t113s-mangopi-mq-r-t113.dts | 2 +-
>  arch/arm/boot/dts/allwinner/sun8i-t113s.dtsi                  | 2 +-
>  arch/arm/boot/dts/allwinner/sunxi-d1s-t113-mangopi-mq-r.dtsi  | 2 +-

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  arch/arm/boot/dts/nxp/imx/imx6dl-b105pv2.dts                  | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b105v2.dts                   | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b125pv2.dts                  | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b125v2.dts                   | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b155v2.dts                   | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b1x5pv2.dtsi                 | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-b1x5v2.dtsi                  | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-emcon-avari.dts              | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6dl-qmx6.dtsi                    | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6q-emcon-avari.dts               | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6qdl-emcon-avari.dtsi            | 2 +-
>  arch/arm/boot/dts/nxp/imx/imx6qdl-emcon.dtsi                  | 2 +-
>  arch/arm/boot/dts/st/stm32mp157c-emsbc-argon.dts              | 2 +-
>  arch/arm/boot/dts/st/stm32mp157c-emstamp-argon.dtsi           | 2 +-



