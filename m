Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E157BFED2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjJJONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232377AbjJJONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:13:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E46A99;
        Tue, 10 Oct 2023 07:13:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7137C433C8;
        Tue, 10 Oct 2023 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696947214;
        bh=KIqXX4dScRrMHwDEzF9HKKvrsZlOHXBbgzmnWEUCjS8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XEHObZT75+L1jmoh5G9m7XnfTcOOAxhRfyMvP8nP2AhwGLM2Z3nWi+bqPqyXYDZIF
         MOMAaN4RmzkhT5Mo20ctRVu2rFHPLt82ZTsWdCPfCQVpXEJyZW0+SsjZx5nlj54fM5
         tLM6psgJmcYdHFtKo4s5xqFHB4vj172dtJVNp9Oe3zMqmEXd7yKBqNn3XzsoJ2saSS
         WuiP+dWTz2DdKnYD4uLzfAKqXcYSIiLZugwFURwEPedTAfB9RnHluNTOEJmsOIQdub
         /In7pR8xpziE4b+EKSX7EhdurOLxkXEZULdYhUQVZSynXEhp4WJu72kmXXRuWZZBnI
         k1D9a2w45nFwg==
Received: (nullmailer pid 762988 invoked by uid 1000);
        Tue, 10 Oct 2023 14:13:32 -0000
Date:   Tue, 10 Oct 2023 09:13:32 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     lee@kernel.org, pavel@ucw.cz, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, andy.shevchenko@gmail.com,
        kernel@sberdevices.ru, rockosov@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v1 04/11] dt-bindings: leds: aw200xx: introduce optional
 hwen-gpio property
Message-ID: <20231010141332.GA756597-robh@kernel.org>
References: <20231006160437.15627-1-ddrokosov@salutedevices.com>
 <20231006160437.15627-5-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006160437.15627-5-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 07:04:30PM +0300, Dmitry Rokosov wrote:
> Property 'awinic,hwen-gpio' is optional, it can be used by the board
> developer to connect AW200XX LED controller with appropriate poweron
> GPIO pad.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> index 73b81f7a7258..e3ad11fc7a84 100644
> --- a/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
> @@ -41,6 +41,9 @@ properties:
>      description:
>        Leds matrix size
>  
> +  awinic,hwen-gpio:
> +    maxItems: 1

We have standard 'enable-gpios' or 'powerdown-gpios'. Those don't work 
here?

Note that *-gpio is deprecated in favor of *-gpios.


> +
>  patternProperties:
>    "^led@[0-9a-f]+$":
>      type: object
> @@ -90,12 +93,15 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/gpio/gpio.h>
>      #include <dt-bindings/leds/common.h>
>  
>      i2c {
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> +        awinic,hwen-gpio = <&gpio 3 GPIO_ACTIVE_HIGH>;
> +
>          led-controller@3a {
>              compatible = "awinic,aw20036";
>              reg = <0x3a>;
> -- 
> 2.36.0
> 
