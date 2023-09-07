Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F979783E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238675AbjIGQoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242183AbjIGQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:44:13 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8A7CE7;
        Thu,  7 Sep 2023 09:43:46 -0700 (PDT)
Received: from pyrite.rasen.tech (h175-177-042-159.catv02.itscom.jp [175.177.42.159])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 43F531ADE;
        Thu,  7 Sep 2023 16:51:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694098313;
        bh=+8I162w2nEOkL5N3DXTubzTuwiWJ25oKxq6jy5tywCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NweUCK+cvDtmpu/mITNwfNnJyvH9J8d8nzBgdEEwO60YM10b7TP0aWwIwxQsfGFni
         kwavcmAmrjIdQc7F307l9nVIhl0K+ekn36iV55+EhtY6DIYk2WiYc4mKz2yQv/xNAO
         2+acyWrrGOf9kLGmG+wWbL1DB6qWEPogWONspijY=
Date:   Thu, 7 Sep 2023 23:53:12 +0900
From:   Paul Elder <paul.elder@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: media: Add THine THP7312 ISP
Message-ID: <ZPnj2OyHEUuTrH53@pyrite.rasen.tech>
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-2-paul.elder@ideasonboard.com>
 <f023767c-aa74-87ca-d333-3dba8a481cb6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f023767c-aa74-87ca-d333-3dba8a481cb6@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:18:30AM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2023 01:31, Paul Elder wrote:
> > Add bindings for the THine THP7312 ISP.
> > 
> > Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> > ---
> > Since the THP7312 supports multiple sensors, thine,rx-data-lanes alone
> > might not be enough. I was consdering using sensor nodes like what the
> > AP1302 does [1]. This way we can also move the power supplies that only
> > concern the sensor in there as well. I was wondering what to do about
> > the model name, though, as the thp7312 completely isolates that from the 
> > rest of the system.
> > 
> > I'm planning to add sensor nodes in somehow in a v2.
> > 
> > [1] https://lore.kernel.org/linux-media/20211006113254.3470-2-anil.mamidala@xilinx.com/
> > 
> >  .../bindings/media/thine,thp7312.yaml         | 170 ++++++++++++++++++
> >  1 file changed, 170 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/media/thine,thp7312.yaml b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > new file mode 100644
> > index 000000000000..e8d203dcda81
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/thine,thp7312.yaml
> > @@ -0,0 +1,170 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2023 Ideas on Board
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/thine,thp7312.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: THine THP7312
> > +
> > +maintainers:
> > +  - Paul Elder <paul.elder@@ideasonboard.com>
> > +
> > +description:
> > +  The THP7312 is a standalone ISP controlled over i2c, and is capable of
> > +  various image processing and correction functions, including 3A control. It
> > +  can be connected to CMOS image sensors from various vendors, supporting both
> > +  MIPI CSI-2 and parallel interfaces. It can also output on either MIPI CSI-2
> > +  or parallel. The hardware is capable of transmitting and receiving MIPI
> > +  interlaved data strams with data types or multiple virtual channel
> > +  identifiers.
> > +
> > +allOf:
> > +  - $ref: ../video-interface-devices.yaml#
> > +
> > +properties:
> > +  compatible:
> > +    const: thine,thp7312
> > +
> > +  reg:
> > +    description: I2C device address
> 
> You can skip description. It is obvious.

ack

> 
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    maxItems: 1
> > +      - description: CLKI clock input
> 
> This was absolutely never tested.

I'll admit, yes, I forgot to run the checks. But I did test it on
hardware; it's just that this camera module is always powered and the
clock is always connected so it wouldn't have been caught :/

> 
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +    description: |-
> > +      Reference to the GPIO connected to the RESET_N pin, if any.
> > +      Must be released (set high) after all supplies are applied.
> > +
> > +  vddcore-supply:
> > +    description:
> > +      1.2V supply for core, PLL, MIPI rx and MIPI tx.
> > +
> > +  vhtermnx-supply:
> > +    description:
> > +      Supply for input (rx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> > +
> > +  vddtx-supply:
> > +    description:
> > +      Supply for output (tx). 1.8V for MIPI, or 1.8/2.8/3.3V for parallel.
> > +
> > +  vddhost-supply:
> > +    description:
> > +      Supply for host interface. 1.8V, 2.8V, or 3.3V.
> > +
> > +  vddcmos-supply:
> > +    description:
> > +      Supply for sensor interface. 1.8V, 2.8V, or 3.3V.
> > +
> > +  vddgpio_0-supply:
> 
> No, underscores are not allowed in names.
> 
> > +    description:
> > +      Supply for GPIO_0. 1.8V, 2.8V, or 3.3V.
> > +
> > +  vddgpio_1-supply:
> > +    description:
> > +      Supply for GPIO_1. 1.8V, 2.8V, or 3.3V.
> > +
> > +  DOVDD-supply:
> 
> lowercase. Look at your other supplies. VDD is spelled there "vdd", so
> do not introduce random style.
> 
> 
> > +    description:
> > +      Digital I/O (1.8V) supply for image sensor.
> > +
> > +  AVDD-supply:
> 
> lowercase
> 
> > +    description:
> > +      Analog (2.8V) supply for image sensor.
> > +
> > +  DVDD-supply:
> 
> lowercase
> 
> > +    description:
> > +      Digital Core (1.2V) supply for image sensor.
> > +
> > +  orientation: true
> > +  rotation: true
> > +
> > +  thine,rx,data-lanes:
> 
> Why are you duplicating properties? With wrong name? No, that's not a
> property of a device node, but endpoint.

As mentioned elsewhere, it is not duplicated; it's for the input to the
ISP. The data-lanes below is for the output of the ISP. And since the
input to the ISP is completely isolated from the rest of the system
(besides power, I suppose), it's kind of overkill to make an entire
endpoint for it. I suppose the description that I wrote for this
property was slightly too concise to convey that.

I quite like the sensors node introduced in the AP1302; I hope that's a
more acceptable solution?


Paul

> 
> > +    minItems: 4
> > +    maxItems: 4
> > +    $ref: /schemas/media/video-interfaces.yaml#data-lanes
> > +    description: |-
> 
> Drop |- where not needed.
> 
> > +      This property is for lane reordering between the THP7312 and the imaging
> > +      sensor that it is connected to.
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/media/video-interfaces.yaml#
> > +        unevaluatedProperties: false
> > +
> > +        properties:
> > +          data-lanes:
> > +            description: |-
> > +              The sensor supports either two-lane, or four-lane operation.
> > +              This property is for lane reordering between the THP7312 and
> > +              the SoC. If this property is omitted four-lane operation is
> > +              assumed. For two-lane operation the property must be set to <1 2>.
> > +            minItems: 2
> > +            maxItems: 4
> > +            items:
> > +              maximum: 4
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - reset-gpios
> > +  - clocks
> > +  - vddcore-supply
> > +  - vhtermrx-supply
> > +  - vddtx-supply
> > +  - vddhost-supply
> > +  - vddcmos-supply
> > +  - vddgpio_0-supply
> > +  - vddgpio_1-supply
> > +  - DOVDD-supply
> > +  - AVDD-supply
> > +  - DVDD-supply
> > +  - thine,rx,data-lanes
> > +  - port
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/gpio/gpio.h>
> > +
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        camera@61 {
> > +            compatible = "thine,thp7312";
> > +            reg = <0x61>;
> > +
> > +            pinctrl-names = "default";
> > +            pinctrl-0 = <&cam1_pins_default>;
> > +
> > +            reset-gpios = <&pio 119 GPIO_ACTIVE_LOW>;
> > +            clocks = <&camera61_clk>;
> > +
> > +            vddcore-supply = <&vsys_v4p2>;
> > +            AVDD-supply = <&vsys_v4p2>;
> > +            DVDD-supply = <&vsys_v4p2>;
> 
> Srlsy, test it before sending. Look how many supplies you require and
> what is provided here. How any of this could possibly work?
> 
> 
> 
> Best regards,
> Krzysztof
> 
