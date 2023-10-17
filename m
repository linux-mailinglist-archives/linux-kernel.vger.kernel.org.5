Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3957CC733
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 17:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344276AbjJQPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 11:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjJQPOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 11:14:39 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B97E8;
        Tue, 17 Oct 2023 08:14:26 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso49716511fa.0;
        Tue, 17 Oct 2023 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697555665; x=1698160465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LAQIUSSFEkh8UCmi8THqE2sWEJcCZDabuYYz4V23TW8=;
        b=gh49EVzjJAMOiA15cn3qHH81WJn2Q9tYEiZPVMrP8RpyAAzuZ0VIt3OZhmuO8YrADr
         TGcHEbmzI8QlA4BQyDgHtfN94tQSKCYr2tn87XflaQQ433UayXgNAiuFq26fshxgtMJt
         ZAQ5xpyMLLqmaaZAJu37abtdpk6XI7HHvgDWbOKrOXHSmACSb3hJKCHFdq356MK361aJ
         xgzaVlSU4dGsyYbGyQIVg463sFjthNsbFUEVQkqWCtc3rasZb39a3IiX7+gmKDQpvX8L
         ZtR/tx6O8I0J+7KJfdwIrnynqwIZbTN2nXqlKPeyyeG0GveWmtA6Sl3b9QFj7NVD83Hx
         NR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697555665; x=1698160465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LAQIUSSFEkh8UCmi8THqE2sWEJcCZDabuYYz4V23TW8=;
        b=J8SgQ/+pUJaPeAs80gnMIyX8bhuvAGWDN3XLiOtLvlTZ5XyPqp6E7E23mQjSP+3P5Q
         OjIGwIBNj60mN3H6OCd+Y1R03HJZ32ei1dh26xKCrk7Ym76qRcwOm/X1o5XjYzxo1m3K
         E+9xJyz66fWKtqsaJ+rJoYMWY+3H+mH/9G2GG5M/3rVeH4X9Vt4j85lUe06+gMZjtasn
         1Pncufe3LIY7EuJuVN0ItN5ejAYKJxrDdFm7BgYY31mmaCzBJgBatgo6+OEeorTy+xFE
         yT2k0f26gksp1aqAQeD8NrxX/GKergwt3Adxgj/6GaVV9wThTq3hHZ5fVVmoGlFHSH2g
         cyaw==
X-Gm-Message-State: AOJu0YwxWqmsxdL1146EkmppD/m1vw3yMx9VkEbfLurKFoHwYXvmOhta
        bKD9gtlFYFi2qj4J9ZTAEDQ=
X-Google-Smtp-Source: AGHT+IGGk9+XOX5f1XNqFWNen/mWjFSeo+yOGyG3yMMSOnh8F9Yx0HDcS+QgLDHdukQU3wtBx5MZag==
X-Received: by 2002:a2e:aa22:0:b0:2c5:31e6:e8e2 with SMTP id bf34-20020a2eaa22000000b002c531e6e8e2mr1904703ljb.25.1697555664440;
        Tue, 17 Oct 2023 08:14:24 -0700 (PDT)
Received: from jernej-laptop.localnet (82-149-12-148.dynamic.telemach.net. [82.149.12.148])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c15d200b00406447b798bsm1907790wmf.37.2023.10.17.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 08:14:23 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>,
        =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?ISO-8859-1?Q?n=E7_=DCNAL?= <arinc.unal@arinc9.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh@kernel.org>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: Add missing
 (unevaluated|additional)Properties on child node schemas
Date:   Tue, 17 Oct 2023 17:14:21 +0200
Message-ID: <2720928.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
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

Dne ponedeljek, 16. oktober 2023 ob 23:44:20 CEST je Rob Herring napisal(a):
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Add unevaluatedProperties or additionalProperties as appropriate.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml     |  2 ++

For Allwinner:
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

>  Documentation/devicetree/bindings/net/dsa/brcm,sf2.yaml        |  1 +
>  Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml |  2 ++
>  .../devicetree/bindings/net/dsa/microchip,lan937x.yaml         |  1 +
>  Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml     |  2 ++
>  Documentation/devicetree/bindings/net/dsa/qca8k.yaml           |  1 +
>  Documentation/devicetree/bindings/net/dsa/realtek.yaml         |  2 ++
>  .../devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml        | 10 ++--------
>  Documentation/devicetree/bindings/net/engleder,tsnep.yaml      |  1 +
>  Documentation/devicetree/bindings/net/nxp,tja11xx.yaml         |  1 +
>  10 files changed, 15 insertions(+), 8 deletions(-)



