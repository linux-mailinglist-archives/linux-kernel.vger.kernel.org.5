Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7073F7EB8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 22:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjKNVzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 16:55:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjKNVzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 16:55:21 -0500
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E9FD5;
        Tue, 14 Nov 2023 13:55:16 -0800 (PST)
Received: from i53875a73.versanet.de ([83.135.90.115] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1r31N6-0006uH-5s; Tue, 14 Nov 2023 22:55:00 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Andy Yan <andyshrk@163.com>
Cc:     hjc@rock-chips.com, dri-devel@lists.freedesktop.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, sebastian.reichel@collabora.com,
        kever.yang@rock-chips.com, chris.obbard@collabora.com,
        s.hauer@pengutronix.de, Andy Yan <andy.yan@rock-chips.com>
Subject: Re: [PATCH 08/11] dt-bindings: display: vop2: Add rk3588 support
Date:   Tue, 14 Nov 2023 22:54:59 +0100
Message-ID: <11331566.rMLUfLXkoz@diego>
In-Reply-To: <20231114112841.1771312-1-andyshrk@163.com>
References: <20231114112534.1770731-1-andyshrk@163.com>
 <20231114112841.1771312-1-andyshrk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 14. November 2023, 12:28:41 CET schrieb Andy Yan:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> The vop2 on rk3588 is similar to which on rk356x
> but with 4 video outputs and need to reference
> more grf modules.
> 
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
> ---
> 
>  .../display/rockchip/rockchip-vop2.yaml       | 25 +++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> index b60b90472d42..c333c651da1a 100644
> --- a/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> +++ b/Documentation/devicetree/bindings/display/rockchip/rockchip-vop2.yaml
> @@ -20,6 +20,7 @@ properties:
>      enum:
>        - rockchip,rk3566-vop
>        - rockchip,rk3568-vop
> +      - rockchip,rk3588-vop
>  
>    reg:
>      items:
> @@ -48,6 +49,8 @@ properties:
>        - description: Pixel clock for video port 0.
>        - description: Pixel clock for video port 1.
>        - description: Pixel clock for video port 2.
> +      - description: Pixel clock for video port 4.
> +      - description: Peripheral clock for vop on rk3588.
>  
>    clock-names:
>      items:
> @@ -56,12 +59,29 @@ properties:
>        - const: dclk_vp0
>        - const: dclk_vp1
>        - const: dclk_vp2
> +      - const: dclk_vp3
> +      - const: pclk_vop

with the error Rob's bot reported, I guess both clocks and clock-names
need a minItems element to mark these new clocks essentially as optional?


>    rockchip,grf:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description:
>        Phandle to GRF regs used for misc control
>  
> +  rockchip,vo-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to VO GRF regs used for misc control, required for rk3588
> +
> +  rockchip,vop-grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to VOP GRF regs used for misc control, required for rk3588
> +
> +  rockchip,pmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to PMU regs used for misc control, required for rk3588
> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>  
> @@ -81,6 +101,11 @@ properties:
>          description:
>            Output endpoint of VP2
>  
> +      port@3:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description:
> +          Output endpoint of VP3
> +
>    iommus:
>      maxItems: 1
>  
> 




