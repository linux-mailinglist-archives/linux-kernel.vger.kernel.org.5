Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C390D7C0195
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232417AbjJJQ12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:27:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJJQ10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:27:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ADC93
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26365C433C7;
        Tue, 10 Oct 2023 16:27:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696955245;
        bh=t4PzobXZJtCe2x1U9eIGmA6015uE27joZNtgWmnO0IA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rw30bMW6+kCwj0bQ0XJCl02xwmXUjxDC3O97DswIyyA5f79Vz1CsAoyiwlnwI1u5D
         +E4uzeAwjpbuocOd1mekTSSqSmo/qW443P2zp4DFE/vurKgdny9URSly2jBIy2YwZN
         2FBZcAHRRhuq8sYAlSSlXMxoMfoia7kDd7qdXt1x9THtFTpMFcCUwT5IAvA25RB7Hw
         dzjMC9ayTvTgtRq9oYdYq5GhIYCf/b7Q2a3nXRQYFhEIhfwxQ90pwuSUMh/SxuO2Gf
         cNpIMmJ9ZYcwHQqWIhJ0b3ZWZYMyTAYXqmkUOmjlCeul5j8qNGFunRkAqquAKw4inC
         ncO72LLPNRVSQ==
Received: (nullmailer pid 1012386 invoked by uid 1000);
        Tue, 10 Oct 2023 16:27:22 -0000
Date:   Tue, 10 Oct 2023 11:27:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rockchip@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: add rk3588 compatible to
 rockchip,dwc3
Message-ID: <20231010162722.GA1006254-robh@kernel.org>
References: <20231009172129.43568-1-sebastian.reichel@collabora.com>
 <20231009172129.43568-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009172129.43568-2-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 07:20:09PM +0200, Sebastian Reichel wrote:
> RK3588 has three DWC3 controllers. Two of them are fully functional in
> host, device and OTG mode including USB2 support. They are connected to
> dedicated PHYs, that also support USB-C's DisplayPort alternate mode.
> 
> The third controller is connected to one of the combphy's shared
> with PCIe and SATA. It can only be used in host mode and does not
> support USB2. Compared to the other controllers this one needs
> some extra clocks.
> 
> While adding the extra clocks required by RK3588, I noticed grf_clk
> is not available on RK3568, so I disallowed it for that platform.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/usb/rockchip,dwc3.yaml           | 66 +++++++++++++++++--
>  1 file changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index 291844c8f3e1..517879290099 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -20,9 +20,6 @@ description:
>    Type-C PHY
>    Documentation/devicetree/bindings/phy/phy-rockchip-typec.txt
>  
> -allOf:
> -  - $ref: snps,dwc3.yaml#
> -
>  select:
>    properties:
>      compatible:
> @@ -30,6 +27,7 @@ select:
>          enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>    required:
>      - compatible
>  
> @@ -39,6 +37,7 @@ properties:
>        - enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3568-dwc3
> +          - rockchip,rk3588-dwc3
>        - const: snps,dwc3
>  
>    reg:
> @@ -58,7 +57,9 @@ properties:
>            Master/Core clock, must to be >= 62.5 MHz for SS
>            operation and >= 30MHz for HS operation
>        - description:
> -          Controller grf clock
> +          Controller grf clock OR UTMI clock
> +      - description:
> +          PIPE clock
>  
>    clock-names:
>      minItems: 3
> @@ -66,7 +67,10 @@ properties:
>        - const: ref_clk
>        - const: suspend_clk
>        - const: bus_clk
> -      - const: grf_clk
> +      - enum:
> +          - grf_clk
> +          - utmi
> +      - const: pipe
>  
>    power-domains:
>      maxItems: 1
> @@ -86,6 +90,58 @@ required:
>    - clocks
>    - clock-names
>  
> +allOf:
> +  - $ref: snps,dwc3.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3328-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3
> +          maxItems: 4
> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk
> +            - const: grf_clk

No need to list everything again. Just:

contains:
  const: grf_clk

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3568-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          maxItems: 3
> +        clock-names:
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk

Just 'maxItems: 3' is sufficient here.

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: rockchip,rk3588-dwc3
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 3

3 is already the min.

> +          maxItems: 5

And 5 is already the max.

> +        clock-names:
> +          minItems: 3
> +          items:
> +            - const: ref_clk
> +            - const: suspend_clk
> +            - const: bus_clk
> +            - const: utmi
> +            - const: pipe

Again, can use 'contains' here. Where 'utmi' is in the list is already 
defined by the top-level schema.

Rob
