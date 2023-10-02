Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8567B55F9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237816AbjJBOmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237833AbjJBOmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:42:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E008291;
        Mon,  2 Oct 2023 07:41:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8579DC433CA;
        Mon,  2 Oct 2023 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696257717;
        bh=GQnhUpmMgw8sX1nuRCzsnvWq4YgyhgyCIT55QkUE9Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QRm6xAGE2epBNfQ+962kJul1GehdZN0MR6MN7xQcSe17NO4t4ovKRMRlV6f7mlzoG
         dopNTSrT2dzXQ/Zre0z4yWGuLzBeH2/cTAXylzH2wRmvm2FDLK6y51XGyPIJezTCff
         cuA3ZPSkUGvY6kLB/qnXNu1Sdv5HEcRUXNFx4kwiVZxDhCW9a3p7dHd5YztKVDLFnA
         DI46SEv3YddU1BOloIHOzb5J3YqVONBl3w7vhrCnMGs/1JnYST0+1Fhb8CfP4E4YqS
         HgxnniEZ4t8o8rCKZq/lXGFgcloNfhaGSE53KRtfXWQV0rbbaknTmUEpVVgKvY2CcZ
         OdfY7ha9Ix5IQ==
Received: (nullmailer pid 1680786 invoked by uid 1000);
        Mon, 02 Oct 2023 14:41:55 -0000
Date:   Mon, 2 Oct 2023 09:41:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>
Cc:     sudeep.holla@arm.com, cristian.marussi@arm.com,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linus.walleij@linaro.org, Oleksii_Moisieiev@epam.com,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [RFC 4/4] dt-bindings: gpio: Add bindings for SCMI pinctrl based
 gpio
Message-ID: <20231002144155.GA1675188-robh@kernel.org>
References: <20231002021602.260100-1-takahiro.akashi@linaro.org>
 <20231002021602.260100-5-takahiro.akashi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002021602.260100-5-takahiro.akashi@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:16:02AM +0900, AKASHI Takahiro wrote:
> A dt binding for SCMI pinctrl based gpio driver is defined in this
> commit. It basically conforms to generic pinctrl-gpio mapping framework.

What is "generic pinctrl-gpio mapping framework"? DT doesn't have 
frameworks.

> 
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  .../bindings/gpio/arm,scmi-gpio.yaml          | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> new file mode 100644
> index 000000000000..2601c5594567
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/arm,scmi-gpio.yaml
> @@ -0,0 +1,71 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/arm,scmi-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SCMI pinctrl based generic GPIO controller
> +
> +maintainers:
> +  - AKASHI Takahiro <akashi.takahiro@linaro.org>
> +
> +properties:
> +  $nodename:
> +    pattern: "^scmi_gpio(@[0-9a-f]+)$"

Not the correct name.

> +
> +  compatible:
> +    const: arm,scmi-gpio-generic

What makes it generic? No such thing. Just drop '-generic'.

> +
> +  gpio-controller: true
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-ranges: true
> +
> +  gpio-ranges-group-names: true
> +
> +patternProperties:
> +  "^.+-hog(-[0-9]+)?$":
> +    type: object
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios

You don't need all this just 'required: [ gpio-hog ]'. Then the hog 
schema will check the rest.

> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - gpio-controller
> +  - "#gpio-cells"
> +  - gpio-ranges
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    scmi_gpio_0: scmi_gpio@0 {

gpio {

But doesn't SCMI have protocol numbers?

> +        compatible = "arm,scmi-gpio";
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        gpio-ranges = <&scmi_pinctrl 0 10 5>,
> +                      <&scmi_pinctrl 5 0 0>;
> +        gpio-ranges-group-names = "",
> +                                  "pinmux_gpio";
> +    };
> +
> +    // Consumer:

Outside the scope of this binding. Drop this node.

> +    sdhci0_pwrseq {
> +        compatible = "mmc-pwrseq-emmc";
> +        reset-gpios = <&scmi_gpio_0 0 GPIO_ACTIVE_LOW>;
> +    };
> -- 
> 2.34.1
> 
