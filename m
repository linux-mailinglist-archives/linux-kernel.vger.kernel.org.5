Return-Path: <linux-kernel+bounces-22887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFED582A4E7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11DD31C226A1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD24F8B2;
	Wed, 10 Jan 2024 23:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtQg7j3p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D057313;
	Wed, 10 Jan 2024 23:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA1EBC433C7;
	Wed, 10 Jan 2024 23:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704928499;
	bh=fW8f1kPNQnVkNZGs8Z1MR+JZ9aRPSsMtuYxNiBUsgdQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RtQg7j3pFlz65bHoDwiRmQL1CVaCVpugasl6HJIxrq7rS3umMsaR6VnT1f5pA033f
	 iDg6fCu8pJuZwF/aDYxLKdx99YdJnk3pugsMPK48efhkovNv8t298I5OMNFEmJHg1T
	 3JYQb+FyLJgJI/U7sOeNlnDElDvvxnHKOFkvJLyUW0TjHaoVap1u5kswi2RU5sl20o
	 nLuESbnjLptBVIIeWdCrCSYtm/lH/LEFnqnvAjfC1NBlQqlENeDT60SfA6NxPDhzaU
	 Bxm311DHHd4K/+kHPQ6iBUQ+zKsFi4pMQCTS+VE8+xTc/xvK4AxseVg3ezNbGkvLnR
	 riBrTl//mUXXQ==
Received: (nullmailer pid 2980300 invoked by uid 1000);
	Wed, 10 Jan 2024 23:14:56 -0000
Date: Wed, 10 Jan 2024 17:14:56 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/13] spi: dt-bindings: adi,axi-spi-engine: add offload
 bindings
Message-ID: <20240110231456.GB2854345-robh@kernel.org>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-4-e42c6a986580@baylibre.com>

On Wed, Jan 10, 2024 at 01:49:45PM -0600, David Lechner wrote:
> The ADI AXI SPI Engine driver supports offloading SPI transfers to
> hardware. This is essentially a feature that allows recording an
> arbitrary sequence of SPI transfers and then playing them back with
> no CPU intervention via a hardware trigger.
> 
> This adds the bindings for this feature. Each SPI Engine instance
> can have from 0 to 32 offload instances. Each offload instance has a
> trigger input and a data stream output. As an example, this could be
> used with an ADC SPI peripheral. In this case the trigger is connected
> to a PWM/clock to determine the sampling rate for the ADC and the output
> stream is connected to a DMA channel to pipe the sample data to memory.
> 
> SPI peripherals act as consumers of the offload instances. Typically,
> one SPI peripheral will be connected to one offload instance. But to
> make the bindings future-proof, the property is an array.

Is there some sort of arbitration between multiple offload engines on 
the same chip select? If not, I don't see how it would work.

I think this whole thing could be simplified down to just 3 
SPI controller properties: pwms, dmas, and adi,offload-cs-map. Each 
property is has entries equal the number of offload engines. The last 
one maps an offload engine to a SPI chip-select.

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../spi/adi,axi-spi-engine-peripheral-props.yaml   | 24 +++++++++++
>  .../bindings/spi/adi,axi-spi-engine.yaml           | 49 +++++++++++++++++++++-
>  .../bindings/spi/spi-peripheral-props.yaml         |  1 +
>  3 files changed, 73 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml
> new file mode 100644
> index 000000000000..19b685fc3b39
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine-peripheral-props.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/adi,axi-spi-engine-peripheral-props.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Peripheral properties for Analog Devices AXI SPI Engine Controller
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +properties:
> +  adi,offloads:
> +    description:
> +      List of AXI SPI Engine offload instances assigned to this peripheral.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 32
> +    items:
> +      items:
> +        - minimum: 0
> +          maximum: 31

This defines a matrix. You want:

minItems: 1
maxItems: 32
items:
  maximum: 31

(0 is already the min).

> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> index d48faa42d025..69f3261bab47 100644
> --- a/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> +++ b/Documentation/devicetree/bindings/spi/adi,axi-spi-engine.yaml
> @@ -21,6 +21,23 @@ maintainers:
>  allOf:
>    - $ref: /schemas/spi/spi-controller.yaml#
>  
> +$defs:
> +  offload:
> +    description:
> +      Describes the connections of the trigger input and the data output stream
> +      of one or more offload instances.
> +
> +    properties:
> +      reg:
> +        description:
> +          Index of the offload instance.
> +        items:
> +          - minimum: 0
> +            maximum: 31
> +
> +    required:
> +      - reg
> +
>  properties:
>    compatible:
>      const: adi,axi-spi-engine-1.00.a
> @@ -41,6 +58,22 @@ properties:
>        - const: s_axi_aclk
>        - const: spi_clk
>  
> +  offloads:
> +    type: object
> +    description: Zero or more offloads supported by the controller.
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^offload@[0-8a-f]+$":
> +        type: object
> +        $ref: '#/$defs/offload'
> +
>  required:
>    - compatible
>    - reg
> @@ -62,5 +95,19 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>  
> -        /* SPI devices */
> +        offloads {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            offload@0 {
> +                compatible = "adi,example-offload";

No fake examples please. This should give you a warning.

> +                reg = <0>;
> +            };
> +        };
> +
> +        adc@0 {
> +            compatible = "adi,example-adc";
> +            reg = <0>;
> +            adi,offloads = <0>;
> +        };
>      };
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 1c8e71c18234..7beb5a3798a5 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -132,6 +132,7 @@ properties:
>  
>  # The controller specific properties go here.
>  allOf:
> +  - $ref: adi,axi-spi-engine-peripheral-props.yaml#
>    - $ref: arm,pl022-peripheral-props.yaml#
>    - $ref: cdns,qspi-nor-peripheral-props.yaml#
>    - $ref: samsung,spi-peripheral-props.yaml#
> 
> -- 
> 2.43.0
> 

