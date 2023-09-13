Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E11079E967
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 15:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240974AbjIMNfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbjIMNe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 09:34:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707C1BC2;
        Wed, 13 Sep 2023 06:34:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7736DC433C7;
        Wed, 13 Sep 2023 13:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694612093;
        bh=MFeimr0DIDPO6o9ZoxuaDIxx2Q83zZVFEoaPaVha1Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MAFWhsjGgOaFx6m3fEdBnZ8zllzmp1PsOQ2YRNblZyV5oteDXkCZ3ljKi02ctQQ5L
         ZnaZ5St3rUUbQLTCUtwwuNLNjg9XA/9vqZitiQLIXWIf3Ma71jFt4Pn6PeeOOqdXl5
         6llM1ZKU55Niu6JIk5ciEiOMLjckqIg5V3qyrFIniTFTqyjKFTwEFxmDe8r2a2Ak55
         23sZwasiRTXw/9RY9EPxVxVTzbCIyH6iqyRjloIoQys72KG9PB3yF1Nk5kiEQhAby0
         w8s4YTTJqThLOEtN0WS/79wCJVNbZbc0+vc8KJpNvFvJN17iNqNZRMSQt3vgn+dsSc
         v/9cg5kpFVowg==
Received: (nullmailer pid 2855562 invoked by uid 1000);
        Wed, 13 Sep 2023 13:34:51 -0000
Date:   Wed, 13 Sep 2023 08:34:51 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: Mention GPIO triggers
Message-ID: <20230913133451.GA2841610-robh@kernel.org>
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-gpio-led-trigger-dt-v1-1-1b50e3756dda@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:44:30PM +0200, Linus Walleij wrote:
> We reuse the trigger-sources phandle to just point to
> GPIOs we may want to use as LED triggers.
> 
> Example:
> 
> gpio: gpio@0 {
>     compatible "my-gpio";
>     gpio-controller;
>     #gpio-cells = <2>;
>     interrupt-controller;
>     #interrupt-cells = <2>;
>     #trigger-source-cells = <2>;

BTW, this is not documented for any GPIO binding. If we want to specify 
the cell size, then it has to be added to every GPIO controller binding. 
If not, we then need to reference gpio.yaml in every GPIO controller 
binding (along with unevaluatedProperties). Doesn't have to be done for 
this patch to go in though.

> };
> 
> leds {
>     compatible = "gpio-leds";
>     led-my-gpio {
>         label = "device:blue:myled";
>         gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
>         default-state = "off";
>         linux,default-trigger = "gpio";
>         trigger-sources = <&gpio 1 GPIO_ACTIVE_HIGH>;
>     };
> };
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/common.yaml b/Documentation/devicetree/bindings/leds/common.yaml
> index 5fb7007f3618..b42950643b9d 100644
> --- a/Documentation/devicetree/bindings/leds/common.yaml
> +++ b/Documentation/devicetree/bindings/leds/common.yaml
> @@ -191,6 +191,8 @@ properties:
>        each of them having its own LED assigned (assuming they are not
>        hardwired). In such cases this property should contain phandle(s) of
>        related source device(s).
> +      Another example is a GPIO line that will be monitored and mirror the
> +      state of the line (with or without inversion flags) to the LED.
>        In many cases LED can be related to more than one device (e.g. one USB LED
>        vs. multiple USB ports). Each source should be represented by a node in
>        the device tree and be referenced by a phandle and a set of phandle
> 
> -- 
> 2.34.1
> 
