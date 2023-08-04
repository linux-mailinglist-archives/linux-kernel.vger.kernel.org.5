Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2F4770876
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjHDTDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjHDTDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:03:18 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BE04EC4;
        Fri,  4 Aug 2023 12:03:15 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3110ab7110aso2182082f8f.3;
        Fri, 04 Aug 2023 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691175794; x=1691780594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBQznZc6KngA0qSX8JhcbfCzyQcmohoYG9cU4rXPPQk=;
        b=LDEC7ag2o3gTORvOstYA3ZrCBzX0wu0RuaKKvZAF47hjYUMgw4IqJUc7PzopJeWR0R
         Fw5VHUHA9kqKRFSA9R4+weld8Bj8zp6APiKfBF163vBnEWZDZxENPtxDDqSy2DRA6aV+
         dYRuKm5BQ1Yw34VU8K45IbOgSxgxbQatxm7M57nSXjUCg7u+aVZD06rUHj91zb9b7t9I
         7Eup6AlYYAYuh56/fPiOMsfwORkkGf9cfBXK2D8PKERDbmVxY7vurxbqDyhLHF2oK6Xc
         MMq3lOfAOGciv2IGZIdsb2CGn0r2MhbvoP3rTxHAnhdZDROCpWyI2/P8PNvMzgbHR/72
         2eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691175794; x=1691780594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBQznZc6KngA0qSX8JhcbfCzyQcmohoYG9cU4rXPPQk=;
        b=Pf0jbSpX+iukyNNpIexc5nvFJLhXaAi5EOcoCOn6Bb1AnqHDJX8VPZ0GD7fmJ/gFRk
         vQCKrakuzKxbAbNIMNRqW4GhU9XThC1s6GNk4Aye6YqeZZ4fje8+JL3s0r18HeIYE3nJ
         gQK83SzKw6Adzz2UpB53WY8eJx4gPJQsZB5AM6fB05EVBDyv+njKUls6mBrOKWpETJFk
         xvjVs4wIDGxMSRPo6u7uqhzEKWQsxCRxEvGkH8UOU4vHz4DDPcZdJCIchw2u0i7jyAh0
         g0rDYXDX2D1Ok2G+GjOlmcQohSaBXVNtGsqOPGyWCpT/w0d8HuwCIeyCv4953usEcVRu
         IPLQ==
X-Gm-Message-State: AOJu0YyAKZkI5d04Aud/wzwqggZcZuXrBt3j3umkelZd/7JfBXBVSfog
        l7f40fSnRIxNgr4fZY5Emoo=
X-Google-Smtp-Source: AGHT+IEYJGHc532Wwdt2wL64d5EBMgXcif26NnW434MUKhvoFJEJh0b+cNfvs8etfBAolMfVUJK18A==
X-Received: by 2002:adf:ed0f:0:b0:314:1aed:8f5f with SMTP id a15-20020adfed0f000000b003141aed8f5fmr1593821wro.34.1691175794130;
        Fri, 04 Aug 2023 12:03:14 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id g6-20020a056000118600b00314398e4dd4sm3137260wrx.54.2023.08.04.12.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 12:03:13 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <uwu@icenowy.me>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] dt-bindings: arm: sunxi: document Orange Pi Zero 3 board
 name
Date:   Fri, 04 Aug 2023 21:03:12 +0200
Message-ID: <5696551.DvuYhMxLoT@jernej-laptop>
In-Reply-To: <20230804170856.1237202-3-andre.przywara@arm.com>
References: <20230804170856.1237202-1-andre.przywara@arm.com>
 <20230804170856.1237202-3-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 04. avgust 2023 ob 19:08:55 CEST je Andre Przywara napisal(a):
> The Orange Pi Zero 3 board is an updated version of the Zero 2 board.
> It uses a SoC called H618, which just seems to be an H616 with more L2
> cache.
> 
> Add the board/SoC compatible string pair to the list of known boards.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml
> b/Documentation/devicetree/bindings/arm/sunxi.yaml index
> ee8fdd2da869a..58f322b9585f2 100644
> --- a/Documentation/devicetree/bindings/arm/sunxi.yaml
> +++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
> @@ -997,4 +997,9 @@ properties:
>            - const: xunlong,orangepi-zero2
>            - const: allwinner,sun50i-h616
> 
> +      - description: Xunlong OrangePi Zero 3
> +        items:
> +          - const: xunlong,orangepi-zero3
> +          - const: allwinner,sun50i-h618
> +
>  additionalProperties: true




