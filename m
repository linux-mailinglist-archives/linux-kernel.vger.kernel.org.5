Return-Path: <linux-kernel+bounces-22865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 423AD82A457
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666831C22759
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A23154F8A9;
	Wed, 10 Jan 2024 22:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axhinZBK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA494F886;
	Wed, 10 Jan 2024 22:56:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DB5C433F1;
	Wed, 10 Jan 2024 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704927383;
	bh=Zyd//6KwNDpLrLV+GuG4nAjU0pYfBNI8SX3KOq9P4J4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=axhinZBK6yzEcNMYnkUu3vO9vUUs2YATjWk7DgANXEsmi8H9Fah5CkS1gDExMeTn4
	 ldcUtSJKnRYZssRqluLG0PGvCoBMNnZkcdDXxIrv2ptRX94SYN473GTaM0stHt8zOQ
	 eZI87OsofjSdDy9VwRKhSplkpTOM0zFTWUnflQMk6eiysiaXh8FkOilA0uit5acbQT
	 w7uPmNWphcnTWkYv64hbzwWnvvhBsEv/MVQHH9NdOWH9fftMsENxNzwN9LpRho6h1w
	 PIKaWCFcbav0PHCbevEJig03BKVyWKLHNwA7mHaXyLnxq/j7f1wQSN8QUkoKp8AOb2
	 B+/z5suK0/DNw==
Received: (nullmailer pid 2864456 invoked by uid 1000);
	Wed, 10 Jan 2024 22:56:20 -0000
Date: Wed, 10 Jan 2024 16:56:20 -0600
From: Rob Herring <robh@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Frank Rowand <frowand.list@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] dt-bindings: iio: offload: add binding for PWM/DMA
 triggered buffer
Message-ID: <20240110225620.GA2854345-robh@kernel.org>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-11-e42c6a986580@baylibre.com>

On Wed, Jan 10, 2024 at 01:49:52PM -0600, David Lechner wrote:
> This adds a new binding for a PWM trigger and DMA data output connected
> to an SPI controller offload instance.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  .../adi,spi-offload-pwm-trigger-dma-buffer.yaml    | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml b/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml
> new file mode 100644
> index 000000000000..748cfab19eff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/offload/adi,spi-offload-pwm-trigger-dma-buffer.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SPI Offload with PWM Trigger and DMA Buffer Data Output
> +
> +maintainers:
> +  - Michael Hennerich <Michael.Hennerich@analog.com>
> +  - Nuno Sá <nuno.sa@analog.com>
> +
> +description: |
> +  This binding describes the connection of a PWM device to the trigger input
> +  and a DMA channel to the output data stream of a SPI Offload instance.
> +
> +  https://wiki.analog.com/resources/fpga/peripherals/spi_engine/offload
> +  https://wiki.analog.com/resources/fpga/peripherals/spi_engine/tutorial
> +
> +$ref: /schemas/spi/adi,axi-spi-engine.yaml#/$defs/offload

Not really worth the complexity just for 'reg'. Generally, the bus 
schema would define general constraints on reg like range of address 
values and the device schema (this one) is just how many entries.

> +
> +properties:
> +  compatible:
> +    const: adi,spi-offload-pwm-trigger-dma-buffer
> +
> +  reg:
> +    maxItems: 1
> +
> +  pwms:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - pwms
> +  - dmas
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    spi {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        offloads {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            offload@0 {
> +                compatible = "adi,spi-offload-pwm-trigger-dma-buffer";
> +                reg = <0>;
> +                pwms = <&pwm 0>;
> +                dmas = <&dma 0>;
> +            };
> +        };

Just make one complete example for the device.

> +    };
> 
> -- 
> 2.43.0
> 

