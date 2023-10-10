Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A32E77BFF72
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjJJOkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbjJJOkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:40:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7099AF;
        Tue, 10 Oct 2023 07:40:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AA72C433C8;
        Tue, 10 Oct 2023 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948830;
        bh=SZNL5ipjz03UC6M5xobnjz++6ytKfOWeF3h0jnFiasw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qvb72v1KwaPV6lhUBCnWjTPdWQFWjMAsrdcuCea7BPaHEvp98IoGTwS998Gfv7bwm
         cXy+pHMz398PjWmFf9UxdQ7rqGsjrPy3pl2MnG3X/X4Nn1EZQcv/iaUd91UZpm8DJ5
         1H89dsnas4BAxGXPYynhCP5e6npn6U2YVt/+o0QAcmv4kPbESX/AwmNJTlT3wJb5nF
         WvNAPOE5UyVY9SG9Q5g6VS4z0tOAWmRlBY4wQTdqMOOiyPvJrrjDKb807iBJWsRlvl
         p+7uqVs/BG6vQUnLxF23bSga6KgoRMYA2vY+oIowLwkiSMyFGBLmJsDmdOEtRRWRJD
         seMWou74vPx1w==
Date:   Tue, 10 Oct 2023 15:40:42 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: adc: provide max34408/9 device tree
 binding document
Message-ID: <20231010154042.2ef667b2@jic23-huawei>
In-Reply-To: <20231007234838.8748-2-fr0st61te@gmail.com>
References: <20231007234838.8748-1-fr0st61te@gmail.com>
        <20231007234838.8748-2-fr0st61te@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  8 Oct 2023 02:48:37 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

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

I guess the review crossed with you sending v5.  There is some feedback on v4 you need
to address here.

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
> +              maximum: 1
> +    else:
> +      patternProperties:
> +        "^channel@[0-3]$":
> +          properties:
> +            reg:
> +              minimum: 0
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

