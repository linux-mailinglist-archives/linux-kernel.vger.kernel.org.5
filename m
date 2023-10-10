Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BB77BFF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjJJOdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232147AbjJJOdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:33:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A7A4;
        Tue, 10 Oct 2023 07:33:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB943C433C7;
        Tue, 10 Oct 2023 14:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948399;
        bh=pcUljfDqBz+5zaYl7PUC11MbDiE8H1prd/gX1DsPBjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LsidtITI0+z28z1dZ4UqR042n9o4GknAiiVcgcwnAicoS7LVHwe5n30W/Gwb1CjZ2
         TfzyUvxbg6ExIsBJRh3wrXmYJLcvs0eakt64mib+U3MewVW4IUrRz67tcNScghLGlF
         Kz5ue3fqSbUAOXcp7Cq5WFttNSEuzEujSViD14RxxZaDzCDWt2HmMNpfH6d4AtQu8q
         0fqj/nO67IW3ludGrSbS5qYa3Vq9VXZXv/S8F1CXDkks3AH6FbzhuK7T/RByJhgBwT
         VFI1PpLyTlzQPOHPix0XAugZHSoc5nVdoXiHuf1frmzIyr+Y5T/SjVjP/yACSQsfLg
         PV8WrNrS4a+Dg==
Received: (nullmailer pid 847247 invoked by uid 1000);
        Tue, 10 Oct 2023 14:33:17 -0000
Date:   Tue, 10 Oct 2023 09:33:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231010143317.GA841985-robh@kernel.org>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
 <20231007234838.8748-2-fr0st61te@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007234838.8748-2-fr0st61te@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 08, 2023 at 02:48:37AM +0300, Ivan Mikhaylov wrote:
> The hardware binding for i2c current monitoring device with overcurrent
> control.
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>
> ---
>  .../bindings/iio/adc/maxim,max34408.yaml      | 141 ++++++++++++++++++
>  1 file changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> 
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> new file mode 100644
> index 000000000000..9749f1fd1802
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34408.yaml
> @@ -0,0 +1,141 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34408.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Two- and four-channel current monitors with overcurrent control

Maxim MAX34408/MAX34409 current monitors with overcurrent control

> +
> +maintainers:
> +  - Ivan Mikhaylov <fr0st61te@gmail.com>
> +
> +description: |
> +  The MAX34408/MAX34409 are two- and four-channel current monitors that are
> +  configured and monitored with a standard I2C/SMBus serial interface. Each
> +  unidirectional current sensor offers precision high-side operation with a
> +  low full-scale sense voltage. The devices automatically sequence through
> +  two or four channels and collect the current-sense samples and average them
> +  to reduce the effect of impulse noise. The raw ADC samples are compared to
> +  user-programmable digital thresholds to indicate overcurrent conditions.
> +  Overcurrent conditions trigger a hardware output to provide an immediate
> +  indication to shut down any necessary external circuitry.
> +
> +  Specifications about the devices can be found at:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - maxim,max34408
> +      - maxim,max34409
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  powerdown-gpios:
> +    description:
> +      Shutdown Output. Open-drain output. This output transitions to high impedance
> +      when any of the digital comparator thresholds are exceeded as long as the ENA
> +      pin is high.
> +    maxItems: 1
> +
> +  shtdn-enable-gpios:
> +    description:
> +      SHTDN Enable Input. CMOS digital input. Connect to GND to clear the latch and
> +      unconditionally deassert (force low) the SHTDN output and reset the shutdown
> +      delay. Connect to VDD to enable normal latch operation of the SHTDN output.
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    $ref: adc.yaml
> +    type: object
> +    description:
> +      Represents the internal channels of the ADC.
> +
> +    properties:
> +      reg:
> +        items:
> +          minimum: 0
> +          maximum: 3

This allows any number of 'reg' entries. You need this instead:

items:
  - minimum: 0
    maximum: 3


> +
> +      maxim,rsense-val-micro-ohms:
> +        description:
> +          Adjust the Rsense value to monitor higher or lower current levels for
> +          input.
> +        enum: [250, 500, 1000, 5000, 10000, 50000, 100000, 200000, 500000]
> +        default: 1000
> +
> +    required:
> +      - reg
> +      - maxim,rsense-val-micro-ohms
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: maxim,max34408
> +    then:
> +      patternProperties:
> +        "^channel@[2-3]$": false
> +        "^channel@[0-1]$":
> +          properties:
> +            reg:
> +              minimum: 0

0 is already the minimum

> +              maximum: 1
> +    else:
> +      patternProperties:
> +        "^channel@[0-3]$":
> +          properties:
> +            reg:
> +              minimum: 0

ditto

> +              maximum: 3
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        adc@1e {
> +              compatible = "maxim,max34409";
> +              reg = <0x1e>;
> +              powerdown-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
> +              shtdn-enable-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              channel@0 {
> +                  reg = <0x0>;
> +                  maxim,rsense-val-micro-ohms = <5000>;
> +              };
> +
> +              channel@1 {
> +                  reg = <0x1>;
> +                  maxim,rsense-val-micro-ohms = <10000>;
> +             };
> +        };
> +    };
> -- 
> 2.42.0
> 
