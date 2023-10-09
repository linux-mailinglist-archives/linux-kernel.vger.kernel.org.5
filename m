Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07857BD1E7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 04:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344994AbjJICSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 22:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbjJICSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 22:18:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F9FA6;
        Sun,  8 Oct 2023 19:18:34 -0700 (PDT)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 934C67E2;
        Mon,  9 Oct 2023 04:18:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1696817910;
        bh=8+fT+A+W5pFEzCWpa2x917y4zdBVrVYbRFOBAvj5acc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jSIdZb4/XkhWnNS005sJ7m5fqcpg+79e3zTpi+RyPrHy7RZ0EGFE05nREElqZhnlL
         +7h4O9G2QtUVKBWi19ACL2bXZ1C5O/8udD6kPjPhKcEAO3s1oRYu8DgRb+SNY6xzgP
         YipZVFhVJnDlTGmj3ve5vzxI4msMCKO5xre6SYBM=
Date:   Mon, 9 Oct 2023 05:18:38 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     mchehab@kernel.org, heiko@sntech.de, hverkuil-cisco@xs4all.nl,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        conor+dt@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        maxime.chevallier@bootlin.com, paul.kocialkowski@bootlin.com
Subject: Re: [PATCH v6 2/3] media: dt-bindings: media: i2c: Add bindings for
 TW9900
Message-ID: <20231009021838.GG5121@pendragon.ideasonboard.com>
References: <cover.1696608809.git.mehdi.djait@bootlin.com>
 <6ad44a04366e65d5baec08dd966f5c81995d626d.1696608809.git.mehdi.djait@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6ad44a04366e65d5baec08dd966f5c81995d626d.1696608809.git.mehdi.djait@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mehdi,

Thank you for the patch.

On Fri, Oct 06, 2023 at 06:25:29PM +0200, Mehdi Djait wrote:
> The Techwell TW9900 is a video decoder supporting multiple input
> standards, such as PAL and NTSC, and outputs a BT.656 video
> signal.
> 
> It's designed to be low-power, posesses some features such as a
> programmable comb-filter, and automatic input standard detection
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
> V5->V6: 
> - This commit had a "Reviewed-by: Rob Herring <robh@kernel.org>" Tag but
>   decided not to collect it because the last Iteration was more than 2
>   years ago
> - removed SECAM from the mentioned standards
> - changed maintainer
> 
> V4->V5: 
> - renamed the file to match the compatible string, and referenced
>   the graph.yaml schema
> 
> V3->V4: 
> - add the missing reset-gpios node to the binding
> 
> V2->V3: 
> - fix the example not compiling due to a typo in the reset-gpios
>   node.
> 
>  .../bindings/media/i2c/techwell,tw9900.yaml   | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> new file mode 100644
> index 000000000000..24bbbff5cc01
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/media/i2c/techwell,tw9900.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/media/i2c/techwell,tw9900.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Techwell TW9900 NTSC/PAL video decoder
> +
> +maintainers:
> +  - Mehdi Djait <mehdi.djait@bootlin.com>
> +
> +description:
> +  The tw9900 is a multi-standard video decoder, supporting NTSC, PAL standards
> +  with auto-detection features.
> +
> +properties:
> +  compatible:
> +    const: techwell,tw9900
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: VDD power supply
> +
> +  reset-gpios:
> +    description: GPIO descriptor for the RESET input pin
> +    maxItems: 1

How about the power down GPIO ?

The chip requires a clock, which is provided by a crystal oscillator in
the block diagram I found. Does it also support an external clock ? If
so the bindings should support it, although this could be added later.

> +
> +  port:
> +    $ref: /schemas/graph.yaml#/properties/port
> +    description:
> +      Video port for the decoder output.

How about input ports, connected to nodes that model the connector(s) ?

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    i2c {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            tw9900: tw9900@44 {
> +                    compatible = "techwell,tw9900";
> +                    reg = <0x44>;
> +
> +                    vdd-supply = <&tw9900_supply>;
> +                    reset-gpios = <&gpio2 5 GPIO_ACTIVE_LOW>;
> +
> +                    port {
> +                            tw9900_out: endpoint {
> +                                    remote-endpoint = <&vip_in>;
> +                            };
> +                    };
> +            };
> +    };

-- 
Regards,

Laurent Pinchart
