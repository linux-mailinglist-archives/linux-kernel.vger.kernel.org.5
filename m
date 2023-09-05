Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD64792978
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352306AbjIEQ0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353993AbjIEJDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 05:03:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A7742CE;
        Tue,  5 Sep 2023 02:03:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 573A011FB;
        Tue,  5 Sep 2023 02:04:05 -0700 (PDT)
Received: from [10.57.5.181] (unknown [10.57.5.181])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 578893F7F4;
        Tue,  5 Sep 2023 02:03:25 -0700 (PDT)
Message-ID: <b4017947-9e16-7d97-a7b1-3e6964a1f7a9@arm.com>
Date:   Tue, 5 Sep 2023 10:03:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] dt-bindings: pinctrl: rockchip: Add io domain
 properties
Content-Language: en-GB
To:     Sascha Hauer <s.hauer@pengutronix.de>,
        linux-rockchip@lists.infradead.org
Cc:     Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel@pengutronix.de,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230904115816.1237684-1-s.hauer@pengutronix.de>
 <20230904115816.1237684-3-s.hauer@pengutronix.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230904115816.1237684-3-s.hauer@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-04 12:58, Sascha Hauer wrote:
> Add rockchip,io-domains property to the Rockchip pinctrl driver. This
> list of phandles points to the IO domain device(s) the pins of the
> pinctrl driver are supplied from.
> 
> Also a rockchip,io-domain-boot-on property is added to pin groups
> which can be used for pin groups which themselves are needed to access
> the regulators an IO domain is driven from.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>   .../bindings/pinctrl/rockchip,pinctrl.yaml          | 13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> index 10c335efe619e..92075419d29cf 100644
> --- a/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/rockchip,pinctrl.yaml
> @@ -62,6 +62,11 @@ properties:
>         Required for at least rk3188 and rk3288. On the rk3368 this should
>         point to the PMUGRF syscon.
>   
> +  rockchip,io-domains:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      Phandles to io domains
> +
>     "#address-cells":
>       enum: [1, 2]
>   
> @@ -137,7 +142,13 @@ additionalProperties:
>               - description:
>                   The phandle of a node contains the generic pinconfig options
>                   to use as described in pinctrl-bindings.txt.
> -
> +      rockchip,io-domain-boot-on:

I don't think "on" is a particularly descriptive or useful property name 
for something that has no "off" state. Furthermore it's no help at all 
if the DT consumer *is* the bootloader that's expected to configure this 
in the first place. IMO it would seem a lot more sensible to have an 
integer (or enum) property which describes the actual value for the 
initial I/O domain setting. Then Linux can choose to assume the presence 
of the property at all implies that the bootloader should have set it up 
already, but also has the option of actively enforcing it as well if we 
want to.

> +        type: boolean
> +        description:
> +          If true assume that the io domain needed for this pin group has been
> +          configured correctly by the bootloader. This is needed to break cyclic
> +          dependencies introduced when a io domain needs a regulator that can be
> +          accessed through pins configured here.

This is describing a Linux implementation detail, not the binding 
itself. There's no technical reason a DT consumer couldn't already 
figure this much out from the existing topology (by observing that the 
pinctrl consumer is a grandparent of the I/O domain's supply).

Thanks,
Robin.

>   examples:
>     - |
>       #include <dt-bindings/interrupt-controller/arm-gic.h>
