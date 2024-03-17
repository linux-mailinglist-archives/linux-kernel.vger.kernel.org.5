Return-Path: <linux-kernel+bounces-105554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B60AC87E01A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 21:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FA01F216B6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CBE208B0;
	Sun, 17 Mar 2024 20:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khmLg6EX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411941BC4F;
	Sun, 17 Mar 2024 20:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710709171; cv=none; b=WFJ061+Mai9xr4ZMwJ7I8FNyVS70JSEC9Of2k+7Av7w6auADkeEST1rBMDTt6Mo9x4zZDUN8Iak9ZDTVCkP4vx95H9vPh7UsQBLaApdgGBVTAfkXtMH03yHPYNsXola5uGtMBbrKXBzqTc93P1gqnckY2TWXm5ZYfxk3xiqshtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710709171; c=relaxed/simple;
	bh=u5AM0tXfGwYt7QptvrkXGaQ3PKhWBDeloDakIA0dB1g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+ZSQ+83MOt97XA34VFjozPb0dxfK9YMn8jWgYbJuSnTEfl3dO4L5EvxGcKe4i/vgTTxwF0lTceNdgE0nxkdsVejj4Tyd9eEhZ8ljL+QHleBUQF/75P4RhQS7c6+FzlRoV0kg/zxwnXLX7Ji6sYVXwPSoUyUqtNah74iLYzBNeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khmLg6EX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC39C433C7;
	Sun, 17 Mar 2024 20:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710709170;
	bh=u5AM0tXfGwYt7QptvrkXGaQ3PKhWBDeloDakIA0dB1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khmLg6EX70IsxSd7GjqlH8RLrAurC4N6oUpxRswKfPSlB6yA0ny4GJ0gaLlUBrLcT
	 VDPZ7jhLdmrqCpqBC8qRisKIaIomrCiy/cZDoFM6MEf/SEfin1vtJ+AdsTuJ5UBNxZ
	 eeV9bMkSW8RMRyp5EmiA2IkGJ7fbJ0X411OOqMhlE+ZT/NU3EEU1M4KW7kMLi+Sh8q
	 vio6+TE+cY/6Kct5OKohTDMwou9xub+vg1mTFousiehkcZTPm0WW8e1zDe1EXpKnMB
	 phaC7fUxcjBDSZHzdXyb8pZZREgVeo2FGWRgs/Kbn8ueUNB6HW0P08Dl0Yiw4sZDTh
	 nj4jGlCsjKBhw==
Date: Sun, 17 Mar 2024 15:59:27 -0500
From: Rob Herring <robh@kernel.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: linux-kernel@vger.kernel.org, jkridner@beagleboard.org,
	robertcnelson@beagleboard.org,
	Vaishnav M A <vaishnav@beagleboard.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-serial@vger.kernel.org,
	greybus-dev@lists.linaro.org
Subject: Re: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
Message-ID: <20240317205927.GA2178147-robh@kernel.org>
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-2-ayushdevel1325@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184908.500352-2-ayushdevel1325@gmail.com>

On Sat, Mar 16, 2024 at 12:18:59AM +0530, Ayush Singh wrote:
> Add DT bindings for mikroBUS interface. MikroBUS is an open standard
> developed by MikroElektronika for connecting add-on boards to
> microcontrollers or microprocessors.
> 
> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> ---
>  .../bindings/misc/mikrobus-connector.yaml     | 110 ++++++++++++++++++
>  MAINTAINERS                                   |   6 +
>  2 files changed, 116 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> new file mode 100644
> index 000000000000..6eace2c0dddc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/mikrobus-connector.yaml
> @@ -0,0 +1,110 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/mikrobus-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: mikroBUS add-on board socket
> +
> +maintainers:
> +  - Ayush Singh <ayushdevel1325@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: mikrobus-connector
> +
> +  pinctrl-0: true
> +  pinctrl-1: true
> +  pinctrl-2: true
> +  pinctrl-3: true
> +  pinctrl-4: true
> +  pinctrl-5: true
> +  pinctrl-6: true
> +  pinctrl-7: true
> +  pinctrl-8: true
> +
> +  pinctrl-names:
> +    items:
> +      - const: default
> +      - const: pwm_default
> +      - const: pwm_gpio
> +      - const: uart_default
> +      - const: uart_gpio
> +      - const: i2c_default
> +      - const: i2c_gpio
> +      - const: spi_default
> +      - const: spi_gpio
> +
> +  mikrobus-gpios:
> +    minItems: 11
> +    maxItems: 12

What is each GPIO entry?

> +
> +  i2c-adapter:

We already have i2c-bus and i2c-parent properties. Neither of those work 
for you?

> +    description: i2c adapter attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  spi-controller:
> +    description: spi bus number of the spi-master attached to the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  uart:

Nice and consistent. In 3 properties, we have 'adapter', 'controller' 
and <null>...

Also, DT generally uses 'serial' rather than 'uart'.

> +    description: uart port attached to the mikrobus socket
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +  pwms:
> +    description: the pwm-controller corresponding to the mikroBUS PWM pin.
> +    maxItems: 1
> +
> +  spi-cs:
> +    description: spi chip-select numbers corresponding to the chip-selects on the mikrobus socket.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    items:
> +      - description: chip select corresponding to CS pin
> +      - description: chip select corresponding to RST pin

How would someone handle any of the properties defined in 
spi-peripheral-props.yaml?


Rob

