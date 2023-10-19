Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53E67CFABE
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 15:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345828AbjJSNSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 09:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbjJSNSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 09:18:13 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344EC9F;
        Thu, 19 Oct 2023 06:18:12 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53de0d1dc46so13664191a12.3;
        Thu, 19 Oct 2023 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697721490; x=1698326290; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dOMFQ4KhhgNN9uiVFnKX2Q/Idi24XPkIW6kBXq+OOHE=;
        b=TlmrLvULlTB+gpOGgRWxIu72f6iPqOEm44A4k/wIZMeqBmvifechdif/eT3IPvwdVN
         k2FENZI0u+CzJNFgBHf/ZMMIZ4BaG1hvJjim7kRzAssOV1lV+ELhoc+t4cnLpI8ppKFV
         Dm1MDOlPT2po/Qm2pu4pToKCi9SNeDnWMMuA+Tp/Nc7l0C/rBuul2s0bt4b/MX1PLSRJ
         PYKGKhrMuxb2nafmFdXjDGzHWTf9DsaUcYAEdvv4QQdnu/VmkNSuKO21IR+ItcMh0Sfy
         GjFlHNjoDGtvjHN8oi9leUEBEirJ6Wrf4mMw7VpZWo8V7fKW2w5tgk8YDPaMblyQiiDN
         bi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697721490; x=1698326290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOMFQ4KhhgNN9uiVFnKX2Q/Idi24XPkIW6kBXq+OOHE=;
        b=Oyx5UoFfxKqQbSef7q0y7pQbRPBUqJ0o7KbOI5mdeQNDluNTJhs8iR9KqrvQMQ6g6A
         RrXfeIwbskrkA9V0+s9199lycWSQOp+S3TiWqZU8kmT/rKca8jQG5YT8SIy4+VbpypNu
         kLymyQbtTo6xcR4wL/Grfx6/s9+taY4HOkPA+uq2alntSCqn4jC3HwNFGJsnTSMsQJ5j
         uZh4B/2fYIFzRIw14Kd8NeCV87fEU01ueNds0F6PabVlyRUhMH/Eum/IJCk5j9lN+cOI
         FPneJ2XTMqfqxVYPVMzLDmE3ZNIGucVzH5VqwKftw60iI1CmpIYH5YHJzOjzGCknSoUU
         l2jA==
X-Gm-Message-State: AOJu0YxuiTgzCjWO7F+9xPG6s2nk+cbxTAbuzBtFU2AzfAxBDsVlkj4a
        09vXnKtwMO5wpg+yApsdY+w=
X-Google-Smtp-Source: AGHT+IGeV/PAyeS5ZcSZyKizUQ5u38iNo53UbAIyLr9nNzHgjNSBIjErmYPUXpk3hLMaNF1I+onEEQ==
X-Received: by 2002:a17:907:97d0:b0:9aa:63d:9ede with SMTP id js16-20020a17090797d000b009aa063d9edemr2084080ejc.9.1697721490291;
        Thu, 19 Oct 2023 06:18:10 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id qt16-20020a170906ecf000b0099c53c44083sm3596979ejb.79.2023.10.19.06.18.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:18:09 -0700 (PDT)
Date:   Thu, 19 Oct 2023 16:18:06 +0300
From:   Vladimir Oltean <olteanv@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        =?utf-8?B?bsOnIMOcTkFM?= <arinc.unal@arinc9.com>,
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
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH net-next 1/8] dt-bindings: net: Add missing
 (unevaluated|additional)Properties on child node schemas
Message-ID: <20231019131806.lbzydoplodybvb62@skbuf>
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-1-a525a090b444@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Mon, Oct 16, 2023 at 04:44:20PM -0500, Rob Herring wrote:
> Just as unevaluatedProperties or additionalProperties are required at
> the top level of schemas, they should (and will) also be required for
> child node schemas. That ensures only documented properties are
> present for any node.
> 
> Add unevaluatedProperties or additionalProperties as appropriate.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> index 833d2f68daa1..ea285ef3e64f 100644
> --- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
> @@ -61,17 +61,11 @@ properties:
>  
>    ethernet-ports:
>      type: object
> -    properties:
> -      '#address-cells':
> -        const: 1
> -      '#size-cells':
> -        const: 0
> -
> +    additionalProperties: true
>      patternProperties:
>        "^(ethernet-)?port@[0-4]$":
>          type: object
> -        description: Ethernet switch ports
> -
> +        additionalProperties: true
>          properties:
>            pcs-handle:
>              maxItems: 1

For my edification, this patch removes #address-cells and #size-cells
at the same time, because "additionalProperties: true" (which was also
implied before) doesn't care if they aren't defined in this sub-schema,
and they are defined through $ref: dsa.yaml#/$defs/ethernet-ports,
right?
