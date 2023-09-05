Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57365792F92
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 22:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbjIEUIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 16:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbjIEUIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 16:08:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE7FCE;
        Tue,  5 Sep 2023 13:08:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8772EC433A9;
        Tue,  5 Sep 2023 18:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693937644;
        bh=EukprGs63gcH1dkK4J6/kt9pRzUKb0FoRiSL62w+Z4Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQBHuJ/0XILzBQfiFc0erYNxhwXt0bRPrbRayhVpe9tFS5jPAHw6euTjUapt1QZr0
         s+lbPe1OqLlGHh+oDRtNNmhkmppsvJCiT80SiIrhUF3IQ455OtcTcXaCLJNUT8y9HS
         a2m4JQpE4+f+y7XieUiHU33xO295Wtj957ahgX4xbViGCRA9rP5G/9POuQXyggElFy
         OjyN9lC38dv1QP4EX/LNx7Q3AgIwusoXpjQgauCiop4Gb4l+lyJvh5ipkOhA77gi5E
         kcWa2Q2zacJTRY4HxA2MPOhmU97AOBwaujrR8ZDzwD/o1n70tLmGSmYtHhbZFsnkWd
         Gd+sQMphnu1Ww==
Received: (nullmailer pid 3741008 invoked by uid 1000);
        Tue, 05 Sep 2023 18:14:02 -0000
Date:   Tue, 5 Sep 2023 13:14:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Message-ID: <20230905181402.GA3673113-robh@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230904115816.1237684-3-s.hauer@pengutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 04, 2023 at 01:58:15PM +0200, Sascha Hauer wrote:
> Add rockchip,io-domains property to the Rockchip pinctrl driver. This
> list of phandles points to the IO domain device(s) the pins of the
> pinctrl driver are supplied from.

Is there an actual need for multiple IO devices with multiple pinctrl 
blocks? If not, you don't need a property, just lookup the IO domain 
node by compatible.

> 
> Also a rockchip,io-domain-boot-on property is added to pin groups
> which can be used for pin groups which themselves are needed to access
> the regulators an IO domain is driven from.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  .../bindings/pinctrl/rockchip,pinctrl.yaml          | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> index 10c335efe619e..92075419d29cf 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> @@ -62,6 +62,11 @@ properties:
>        Required for at least rk3188 and rk3288. On the rk3368 this should
>        point to the PMUGRF syscon.
>  
> +  rockchip,io-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandles to io domains
> +
>    "#address-cells":
>      enum: [1, 2]
>  
> @@ -137,7 +142,13 @@ additionalProperties:
>              - description:
>                  The phandle of a node contains the generic pinconfig options
>                  to use as described in pinctrl-bindings.txt.
> -
> +      rockchip,io-domain-boot-on:
> +        type: boolean
> +        description:
> +          If true assume that the io domain needed for this pin group has been
> +          configured correctly by the bootloader. This is needed to break cyclic
> +          dependencies introduced when a io domain needs a regulator that can be
> +          accessed through pins configured here.
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
> -- 
> 2.39.2
> 
