Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4E77A642
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 13:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjHMLxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 07:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjHMLxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 07:53:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E9FA7;
        Sun, 13 Aug 2023 04:53:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99cce6f7de2so477739966b.3;
        Sun, 13 Aug 2023 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691927590; x=1692532390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oRPTsvi2xvnA/c1MYOB0hguXkvQfZTWWTzslMYWxYKU=;
        b=ATFt2tpDvrfMsMtWfojgvpZXF1CVomdsotvhq/cgY2o4e9GBSlQghZMgJaDSvevKxs
         j3zR7YB9K03vAEE92dJodLz6waJFp+cGtRmcatrwlEwtC7OFGMFY3gZfk+8EiSx1tJaG
         xU9YrkBFxx6zAjrfZcVEMuN/2bxYTT+np0RANNFfrQ3BaaEnxnKkI/1Ua+mzHyQdTSuk
         eXAVyB2Vulvn6jU2+6TmtvXS+KX4OUzkHNxeg0hYctbNhTH3ohITpCE/JnX6hfoMzh4q
         Rv4x5UsTH49Tfr/TA4VKPGneLzFqOkcL7+VrnBsh1ttn9deIq3LzQWktru+6P85l/6Wq
         IE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691927590; x=1692532390;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oRPTsvi2xvnA/c1MYOB0hguXkvQfZTWWTzslMYWxYKU=;
        b=Venr7E4sY+BalAgnB0dghTQFtwQMUpPwStsXWYthQALxN+pqboTAR1reBWmbT8+yRP
         hysZ4QhOE+MCQYBmtaPh6EsleHd1bghg8O61/UAaBKW1/SMyNQffua3Nbni54k9CSiGj
         heVZuRmcN64y/0Hm3hlJ35KMMgCbcTGrpErKdNfk+14vxp7H6TN46LCHW1i4B5kJYtmZ
         C/XSZyJ4pBPQ20WhuxHzm+TH5Xr0aZlvkagH4IxmW51/i3w5EgLPnab/YU+ythdzkYU4
         1touHfJ93H/06yOE37Z7ibT3kIZZOpgd9iNVSnJuKw6/60P7InGFm2IXmlr1iEUuONt8
         cA6A==
X-Gm-Message-State: AOJu0YwjKvVb5qy2uKWYkA1c026EWI8//VJjrlS4IA2CL5/VRmdNjH1O
        LkvDWBQuQ7VYNfE1+drAXXs=
X-Google-Smtp-Source: AGHT+IFKg5qQEbxbCrnVhjCDPohFCLQymMifmy+mbyfCzfkWgjI3v6iEVwhPJM++NNBZ34XE9gdJgw==
X-Received: by 2002:a17:906:5181:b0:993:f2b4:13c9 with SMTP id y1-20020a170906518100b00993f2b413c9mr6169481ejk.21.1691927589752;
        Sun, 13 Aug 2023 04:53:09 -0700 (PDT)
Received: from skbuf ([188.27.184.148])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b0098e42bef732sm4467015ejb.183.2023.08.13.04.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Aug 2023 04:53:09 -0700 (PDT)
Date:   Sun, 13 Aug 2023 14:53:06 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Message-ID: <20230813112026.ohsx6srbt2staxma@skbuf>
References: <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <20230812091708.34665-1-arinc.unal@arinc9.com>
 <20230812091708.34665-3-arinc.unal@arinc9.com>
 <abc44324-454c-4524-b05e-fe989755ea47@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 12, 2023 at 10:20:43PM +0300, Arınç ÜNAL wrote:
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 4d5f5cc6d031e2..82dda8fae8b16e 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -72,6 +72,10 @@ properties:
>            - compatible
>            - reg
> +  mdio:
> +    $ref: dsa.yaml#/properties/mdio
> +    unevaluatedProperties: false

sja1105 does not support an "mdio" child property. I haven't checked the
others. Don't add properties that aren't supported.

> +
>  patternProperties:
>    "^(ethernet-)?ports$":
>      patternProperties:
> 
> The nxp,sja1105.yaml schema also needed some changes.
> 
> dt-bindings: net: dsa: nxp,sja1105: improve internal MDIO bus bindings
> 
> SJA1110 Ethernet Switch uses the mdios property for its internal MDIO bus.
> Therefore, disallow the mdios property for SJA1105, and the mdio property
> for SJA1110.
> 
> Require the phy-handle property on the non-CPU ports if the mdios property
> is being used.
> 
> Refer to dsa.yaml#/properties/mdio to point the human readers to the
> description on the dsa.yaml schema.
> 
> ---
>  .../bindings/net/dsa/nxp,sja1105.yaml         | 20 ++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> index 82dda8fae8b16e..7d92350f1065b2 100644
> --- a/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml
> @@ -52,7 +52,7 @@ properties:
>      patternProperties:
>        "^mdio@[0-1]$":
> -        $ref: /schemas/net/mdio.yaml#
> +        $ref: dsa.yaml#/properties/mdio
>          unevaluatedProperties: false
>          properties:
> @@ -128,14 +128,32 @@ allOf:
>      then:
>        properties:
>          spi-cpol: false
> +        mdios: false
> +
>        required:
>          - spi-cpha
>      else:
>        properties:
>          spi-cpha: false
> +        mdio: false
> +
>        required:
>          - spi-cpol
> +  - if:
> +      required: [ mdios ]
> +    then:
> +      patternProperties:
> +        "^(ethernet-)?ports$":
> +          patternProperties:
> +            "^(ethernet-)?port@[0-9]+$":
> +              if:
> +                not:
> +                  required: [ ethernet ]
> +              then:
> +                required:
> +                  - phy-handle

For sja1105, phylink-compatible bindings (phy-handle, fixed-link or managed)
are required for all ports (user, dsa or cpu).

Also, sja1105 does not populate the slave_mii_bus, so it never uses the
fallback where ports implicitly connect to an internal PHY if no phylink
bindings are present.

> +
>  unevaluatedProperties: false
>  examples:
> 
> Arınç
