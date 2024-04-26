Return-Path: <linux-kernel+bounces-160605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0C348B3FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990F8B22725
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853C418026;
	Fri, 26 Apr 2024 19:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WV2aOfp6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B545E1096F;
	Fri, 26 Apr 2024 19:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714159019; cv=none; b=pu++LTDYtwYZrxCNTZg3V4jrjic//2aB6WBjihh354z+6+zKNjhduEGppcZ5SsyWDYp9BRXcZ11i9GP1/yRSzc+wPoZj8Yxpytydt9LDK1joCsUbcNF5D3KrRDS8vCqmPc3uvdg9Zcge7PvA3SYvsef5U0KwDy+ElT8U277zlXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714159019; c=relaxed/simple;
	bh=Bj2AZaQTqYSdg6fkn6Il92fkgt/C3Q4S+clYDV4u+Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oa21AXVohlgFTRMsB6JQHzKQ3o9ISLwh7x7zDIM25wl2v3gpC4dKGldITAVx9GCRS4Sz3XhCDtrr9IjVbCn2AkrzTgOw33We4G4jeQR963lw6XL0RlEo6eGZebDqVHurt0J/EVdK4q1mJ09jNDb3ZWclCXV5I9wgv93JS09NolI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WV2aOfp6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4885C113CD;
	Fri, 26 Apr 2024 19:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714159019;
	bh=Bj2AZaQTqYSdg6fkn6Il92fkgt/C3Q4S+clYDV4u+Ww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WV2aOfp6+5cu/MfFdETRZeOz0ESfZvdTNKnPbuq2lPH+VKfUpsEWIvLAO8tE7HSaq
	 uS8OG4qXZt++P681yhw1OiTP8C7MVrNYmpN2fmckWGKNEdb5xBlB2pO/r0Px+TznNt
	 ZicF4qYOMR0xWBctHvVMfxyxIUnNJ45rknVIvoT0NNkn0nk7sx9vjpOlKHTU6GAzBb
	 ctpAqq+zRqq7Vpo+1jQlnKbqSaOVU7ia4l1zjcHnnsdc5n9F6uvlgUY7tybTI5A38Y
	 8nFS/5ubW7H2NbBlLBeQNSenpEKkwZpRgNxKRNnCFJdrKr+N4Z5mjNs67c5Xc1uwCb
	 +Ke7p3B9mVgVw==
Date: Fri, 26 Apr 2024 14:16:55 -0500
From: Rob Herring <robh@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/11] dt-bindings: net: add STM32MP13 compatible in
 documentation for stm32
Message-ID: <20240426191655.GA2675331-robh@kernel.org>
References: <20240426125707.585269-1-christophe.roullier@foss.st.com>
 <20240426125707.585269-2-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426125707.585269-2-christophe.roullier@foss.st.com>

On Fri, Apr 26, 2024 at 02:56:57PM +0200, Christophe Roullier wrote:
> New STM32 SOC have 2 GMACs instances.
> GMAC IP version is SNPS 4.20.
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  .../devicetree/bindings/net/stm32-dwmac.yaml  | 76 ++++++++++++++++---
>  1 file changed, 67 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> index f2714b5b6cf4..b901a432dfa9 100644
> --- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> @@ -22,18 +22,17 @@ select:
>          enum:
>            - st,stm32-dwmac
>            - st,stm32mp1-dwmac
> +          - st,stm32mp13-dwmac
>    required:
>      - compatible
>  
> -allOf:
> -  - $ref: snps,dwmac.yaml#
> -
>  properties:
>    compatible:
>      oneOf:
>        - items:
>            - enum:
>                - st,stm32mp1-dwmac
> +              - st,stm32mp13-dwmac
>            - const: snps,dwmac-4.20a
>        - items:
>            - enum:
> @@ -74,13 +73,16 @@ properties:
>  
>    st,syscon:
>      $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:

Why do you move the location of 'description'? It just increases the 
diff. My preference is description is either 1st or last and not in the 
middle.

> +      Should be phandle/offset pair. The phandle to the syscon node which
> +      encompases the glue register, the offset of the control register and
> +      the mask to set bitfield in control register
>      items:
> -      - items:
> +      - minItems: 2
> +        items:
>            - description: phandle to the syscon node which encompases the glue register
>            - description: offset of the control register
> -    description:
> -      Should be phandle/offset pair. The phandle to the syscon node which
> -      encompases the glue register, and the offset of the control register
> +          - description: field to set mask in register
>  
>    st,eth-clk-sel:
>      description:
> @@ -105,12 +107,38 @@ required:
>  
>  unevaluatedProperties: false
>  
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp1-dwmac
> +              - st,stm32-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - st,stm32mp13-dwmac
> +    then:
> +      properties:
> +        st,syscon:
> +          items:
> +            minItems: 3
> +            maxItems: 3

Just minItems is needed.

> +
>  examples:
>    - |
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      #include <dt-bindings/clock/stm32mp1-clks.h>
> -    #include <dt-bindings/reset/stm32mp1-resets.h>
> -    #include <dt-bindings/mfd/stm32h7-rcc.h>
>      //Example 1
>       ethernet0: ethernet@5800a000 {
>             compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
> @@ -165,3 +193,33 @@ examples:
>             snps,pbl = <8>;
>             phy-mode = "mii";
>         };
> +
> +  - |
> +     //Example 4

I don't think it is worth a whole new example just for 1 property 
difference.

> +     ethernet3: ethernet@5800a000 {
> +           compatible = "st,stm32mp13-dwmac", "snps,dwmac-4.20a";
> +           reg = <0x5800a000 0x2000>;
> +           reg-names = "stmmaceth";
> +           interrupts-extended = <&intc GIC_SPI 62 IRQ_TYPE_LEVEL_HIGH>,
> +                                 <&exti 68 IRQ_TYPE_LEVEL_HIGH>;
> +           interrupt-names = "macirq",
> +                             "eth_wake_irq";
> +           clock-names = "stmmaceth",
> +                         "mac-clk-tx",
> +                         "mac-clk-rx",
> +                         "eth-ck",
> +                         "ptp_ref",
> +                         "ethstp";
> +           clocks = <&rcc ETHMAC>,
> +                    <&rcc ETHTX>,
> +                    <&rcc ETHRX>,
> +                    <&rcc ETHCK_K>,
> +                    <&rcc ETHPTP_K>,
> +                    <&rcc ETHSTP>;
> +           st,syscon = <&syscfg 0x4 0xff0000>;
> +           snps,mixed-burst;
> +           snps,pbl = <2>;
> +           snps,axi-config = <&stmmac_axi_config_1>;
> +           snps,tso;
> +           phy-mode = "rmii";
> +     };
> -- 
> 2.25.1
> 

