Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17FEC7A209C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 16:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235635AbjIOOQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 10:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235554AbjIOOP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 10:15:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E401FC9;
        Fri, 15 Sep 2023 07:15:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B571FC433C8;
        Fri, 15 Sep 2023 14:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694787351;
        bh=my7q6sWI3MWvt71tahat6xPgVNItmOGSgwXOtqEbLN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FM8atK66YrwtjpT6e4y1aWjUIbsW7QcwMS7pm+LJ+lh/kVjGaMsgGFzE+mYQM6hJe
         JAREwNP86xIWJkQfKx5mUg9Rm1J8ux7vW/MjB9VSR27IinDmgr3o6zy0bLiWcqkgvh
         t6yZyfQzbJmxz0fVhkp6clm32eHfFI0AvQaYpQXI/3HKeE7mNlbF1xoCkSUY7QfulV
         jmumv1kU1tZXX3uP2x3NenkiZoZJ8Eb8J50S/81r2DerHhMciDSsC+siN0uL7+6vNy
         Qp0mxkqp1o/SAB9goZ6YaK21v5qC/UXs+JhjPMfcAxpgOGS9SKFkdVLp9ex/hu9LQB
         w+2G2jsvL54Vg==
Received: (nullmailer pid 3664536 invoked by uid 1000);
        Fri, 15 Sep 2023 14:15:49 -0000
Date:   Fri, 15 Sep 2023 09:15:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jan =?iso-8859-1?Q?Kundr=E1t?= <jan.kundrat@cesnet.cz>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] leds: triggers: gpio: Rewrite to use trigger-sources
Message-ID: <20230915141549.GA3658872-robh@kernel.org>
References: <20230912-gpio-led-trigger-dt-v1-0-1b50e3756dda@linaro.org>
 <20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912-gpio-led-trigger-dt-v1-2-1b50e3756dda@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:44:31PM +0200, Linus Walleij wrote:
> By providing a GPIO line as "trigger-sources" in the FWNODE
> (such as from the device tree) and combining with the
> GPIO trigger, we can support a GPIO LED trigger in a natural
> way from the hardware description instead of using the
> custom sysfs and deprecated global GPIO numberspace.
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
> Make this the norm, unmark the driver as broken.
> 
> Delete the sysfs handling of GPIOs.
> 
> Since GPIO descriptors inherently can describe inversion,
> the inversion handling can just be deleted.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

[...]

> @@ -167,16 +78,47 @@ ATTRIBUTE_GROUPS(gpio_trig);
>  static int gpio_trig_activate(struct led_classdev *led)
>  {
>  	struct gpio_trig_data *gpio_data;
> +	struct device *dev = led->dev;
> +	int ret;
>  
>  	gpio_data = kzalloc(sizeof(*gpio_data), GFP_KERNEL);
>  	if (!gpio_data)
>  		return -ENOMEM;
>  
> -	gpio_data->led = led;
> -	gpio_data->gpio = -ENOENT;
> +	/*
> +	 * The generic property "trigger-sources" is followed,
> +	 * and we hope that this is a GPIO.
> +	 */
> +	gpio_data->gpiod = fwnode_gpiod_get_index(dev->fwnode,
> +						  "trigger-sources",
> +						  0, GPIOD_IN,
> +						  "led-trigger");

Isn't this going to look for "trigger-sources-gpio" and 
""trigger-sources-gpios"?

Rob
