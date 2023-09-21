Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826867A9EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbjIUUOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjIUUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:14:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC4CDBFD;
        Thu, 21 Sep 2023 11:20:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5E5C433C7;
        Thu, 21 Sep 2023 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695320410;
        bh=F7FOmZJGIZea3PDFeMXSNL3wD06ectqhotbY/CYvQks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcrZlu1OoqwfasuSssDAxLOCRvqJmyVmQChzusvlYR8QPU7Zzl9UKSTMk3D9DZ7it
         MwoxrJ+pSxuduTRLsqGaciU8U/7IwTkj/okC+SktMnxUm6pBDNdXoBpRN9UbS2LYwx
         GUaJF0XjITZrbG8fDh0+gxRYAqerHh9UYlA6BIVoL0iteOZXgotzm9WR2oWUNanZqT
         JW2mryDuv01/LdooWc4APsPKALCXkNxADgfc7Hx/I2LnNXy18SJymxQCnsUeelAyx9
         32s3745804OphWhgnApJhk3blLfh4/BwkShCyTU1poJzkvUDWpnFBmYWMMhzvBiyDs
         FcoEr4BDF895A==
Received: (nullmailer pid 762555 invoked by uid 1000);
        Thu, 21 Sep 2023 18:20:07 -0000
Date:   Thu, 21 Sep 2023 13:20:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alvin =?utf-8?Q?=C5=A0ipraga?= <alvin@pqrs.dk>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?B?77+9aXByYWdh?= <alsi@bang-olufsen.dk>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rabeeh Khoury <rabeeh@solid-run.com>,
        Jacob Siverskog <jacob@teenage.engineering>,
        Sergej Sawazki <sergej@taudac.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: clock: si5351: add PLL reset mode
 property
Message-ID: <20230921182007.GA761604-robh@kernel.org>
References: <20230920140343.2329225-1-alvin@pqrs.dk>
 <20230920140343.2329225-3-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230920140343.2329225-3-alvin@pqrs.dk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:09:54PM +0200, Alvin Šipraga wrote:
> From: Alvin Šipraga <alsi@bang-olufsen.dk>
> 
> For applications where the PLL must be adjusted without glitches in the
> clock output(s), a new silabs,pll-reset-mode property is added. It
> can be used to specify whether or not the PLL should be reset after
> adjustment. Resetting is known to cause glitches.
> 
> For compatibility with older device trees, it must be assumed that the
> default PLL reset mode is to unconditionally reset after adjustment.
> 
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Rabeeh Khoury <rabeeh@solid-run.com>
> Cc: Jacob Siverskog <jacob@teenage.engineering>
> Cc: Sergej Sawazki <sergej@taudac.com>
> Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
> ---
>  .../bindings/clock/silabs,si5351.yaml         | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> index 3ca8d998c48c..b6692b323a66 100644
> --- a/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> +++ b/Documentation/devicetree/bindings/clock/silabs,si5351.yaml
> @@ -50,6 +50,22 @@ properties:
>        Pair of <number source> for each PLL. Allows to overwrite clock source of
>        PLL A (number=0) or PLL B (number=1).
>  
> +  silabs,pll-reset-mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> +    minItems: 1
> +    maxItems: 2
> +    description: |
> +      Pair of <number mode> for each PLL. Configures the reset mode for PLL A
> +      (number=0) and/or PLL B (number=1). Mode can be one of:
> +
> +      0 - reset whenever PLL rate is adjusted (default mode)
> +      1 - do not reset when PLL rate is adjusted
> +
> +      In mode 1, the PLL is only reset if the silabs,pll-reset is specified in
> +      one of the clock output child nodes that also sources the PLL. This mode
> +      may be preferable if output clocks are expected to be adjusted without
> +      glitches.

Same comments as the other matrix property.

> +
>  patternProperties:
>    "^clkout@?[0-8]$":
>      type: object
> @@ -205,6 +221,9 @@ examples:
>          /* Use XTAL input as source of PLL0 and PLL1 */
>          silabs,pll-source = <0 0>, <1 0>;
>  
> +        /* Don't reset PLL1 on rate adjustment */
> +        silabs,pll-reset-mode = <1 1>;
> +
>          /*
>           * Overwrite CLK0 configuration with:
>           * - 8 mA output drive strength
> -- 
> 2.41.0
> 
