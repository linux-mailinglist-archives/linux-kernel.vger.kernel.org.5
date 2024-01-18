Return-Path: <linux-kernel+bounces-30271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C4B831C72
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 16:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BF981F2A69A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 15:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6384D28DC7;
	Thu, 18 Jan 2024 15:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbZCw9yz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7443C28E02;
	Thu, 18 Jan 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705591428; cv=none; b=EIzs4qqwDtGDl4htCKIPL/A+NEnr44+a0Xi+g6GpMHCuncaCmQz8KCFj2508CxwvZ5SUadBg0wugTJ5L2cPcM17ZgxDtbWcc3rQLgqaT2FV3r9JQTl7A/8QOwLjDG/lE/PQC51k7hs0qDLbkeQuFydxxfuA75Q30umI2zSeEovA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705591428; c=relaxed/simple;
	bh=KASNTV/73GzaB0PKuboKWVlAogExlMDgY90JHnOzYrM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=SLeAgGP3P1aeM0ZKoark+gsGKoFQKxKoo+D+IMm31Hq4bb6HlOrXgvmy690yhfPHzuUKWcJViJg1Dp67j5MmcbeodVujRlx600fv+fRszZOXAUaOokWSfssdjntIexpxz3vcHCCofxOUaCeR7k8VSeYSaEABmKrKZrGAEUM+vGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbZCw9yz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F10FC4AF4F;
	Thu, 18 Jan 2024 15:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705591427;
	bh=KASNTV/73GzaB0PKuboKWVlAogExlMDgY90JHnOzYrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbZCw9yzH4nZbzJavYpRd8uRU3LjmAhpkMZeZiSbV+7N4D4P3L5D+LTwOINvAVsqY
	 xzS1elzzeonKtBbsSfpOcpm2A2BHP73aq4ZhJuzQG/G67TQBCPoJ0awGd4v+xHk6GN
	 SDMoGvp8mhafsCLt3ICcyiW8sn0GsEfzNfvzAgPkx4+ZnjMNxPzQb+Q+64RmQVatRl
	 04KR0B2W2r+njzgHXfmh6D7ZOL0WdlNf+eDFnlkHksyVN1jS72QY3nRQo8KLLF4Q2L
	 /UBkyxHxE1K9hgRmgSqV0rPtEHc4R0OiN25iMqY3RQE29c2gKYSAmqIq+Hoq7yzHhb
	 AhscvGuJp+i1w==
Date: Thu, 18 Jan 2024 15:23:40 +0000
From: Conor Dooley <conor@kernel.org>
To: Dumitru Ceclan <mitrutzceclan@gmail.com>
Cc: linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
	linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Walle <michael@walle.cc>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>, ChiaEn Wu <chiaen_wu@richtek.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Haibo Chen <haibo.chen@nxp.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	David Lechner <dlechner@baylibre.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 1/2] dt-bindings: adc: add AD7173
Message-ID: <20240118-lunar-anthem-31bf3b9b351d@spud>
References: <20240118125001.12809-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yMMWItM1KHJdpK4s"
Content-Disposition: inline
In-Reply-To: <20240118125001.12809-1-mitrutzceclan@gmail.com>


--yMMWItM1KHJdpK4s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 02:49:22PM +0200, Dumitru Ceclan wrote:
> The AD7173 family offer a complete integrated Sigma-Delta ADC solution
> which can be used in high precision, low noise single channel applications
> or higher speed multiplexed applications. The Sigma-Delta ADC is intended
> primarily for measurement of signals close to DC but also delivers
> outstanding performance with input bandwidths out to ~10kHz.
>=20
> Signed-off-by: Dumitru Ceclan <mitrutzceclan@gmail.com>
> ---
>=20
> V11->V12
>  - Drop "binding", describe hardware in binding description
>  - Rename refin and refin2 to vref and vref2
>  - Add better description to external references to better show that the =
voltage
>     value that needs to be specified is the difference between the positi=
ve and
>     negative reference pins
>  - Add optional clocks properties
>  - Add optional adi,clock-select property
>  - Add option for second interrupt, error
>  - Add description to interrupts
> V10->V11
>  - Fix example warning: '#gpio-cells' is a dependency of 'gpio-controller'
>  - Add description to #gpio-cells property
> V9->V10
>  - Fix dt_binding_check type warning from adi,reference-select
> V8->v9
>  - Add gpio-controller and "#gpio-cells" properties
>  - Add missing avdd2 and iovdd supplies
>  - Add string type to reference-select
> V7->V8
>  - include missing fix from V6
> V6->V7 <no changes>
> V5->V6
>  - Moved global required property to proper placement
> V4 -> V5
>  - Use string enum instead of integers for "adi,reference-select"
>  - Fix conditional checking in regards to compatible
> V3 -> V4
>  - include supply attributes
>  - add channel attribute for selecting conversion reference
> V2 -> V3
>  - remove redundant descriptions
>  - use referenced 'bipolar' property
>  - remove newlines from example
> V1 -> V2 <no changes>
>=20
>  .../bindings/iio/adc/adi,ad7173.yaml          | 242 ++++++++++++++++++
>  1 file changed, 242 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7173.=
yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml b/=
Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> new file mode 100644
> index 000000000000..4d0870cc014c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7173.yaml
> @@ -0,0 +1,242 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2023 Analog Devices Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/adi,ad7173.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD7173 ADC
> +
> +maintainers:
> +  - Ceclan Dumitru <dumitru.ceclan@analog.com>
> +
> +description: |
> +  Analog Devices AD717x ADC's:
> +  The AD717x family offer a complete integrated Sigma-Delta ADC solution=
 which
> +  can be used in high precision, low noise single channel applications
> +  (Life Science measurements) or higher speed multiplexed applications
> +  (Factory Automation PLC Input modules). The Sigma-Delta ADC is intended
> +  primarily for measurement of signals close to DC but also delivers
> +  outstanding performance with input bandwidths out to ~10kHz.
> +
> +  Datasheets for supported chips:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7172-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7173-8.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7175-2.pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
AD7176-2.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad7172-2
> +      - adi,ad7173-8
> +      - adi,ad7175-2
> +      - adi,ad7176-2
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    minItems: 1
> +    description: |
> +      Ready interrupt: multiplexed with SPI data out. While SPI CS is lo=
w,
> +      can be used to indicate the completion of a conversion.
> +
> +      Error: The three error bits in the status register (ADC_ERROR, CRC=
_ERROR,
> +      and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. T=
herefore,
> +      the ERROR pin indicates that an error has occurred.

Instead of having a single description like this, you can create an
items list with two descriptions, one for each interrupt.

> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: rdy
> +      - const: err

> +  clocks:
> +    maxItems: 1
> +    description: |
> +      Optional external clock source. Can include one clock source: exte=
rnal
> +      clock or external crystal.
> +
> +  clock-names:
> +    enum:
> +      - ext-clk
> +      - xtal
> +
> +  adi,clock-select:
> +    description: |
> +      Select the ADC clock source. Valid values are:
> +      int         : Internal oscillator
> +      int-out     : Internal oscillator with output on XTAL2 pin
> +      ext-clk     : External clock input on XTAL2 pin
> +      xtal        : External crystal on XTAL1 and XTAL2 pins
> +
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - int
> +      - int-out
> +      - ext-clk
> +      - xtal
> +    default: int

I am not a fan of properties like this one, that in my view reimplement
things that are supported by the regular clocks properties. I've got
some questions for you so I can understand whether or not this custom
property is required.

Whether or not the ext-clk or xtal is used is known based on
clock-names - why is the custom property required to determine that?
If neither of those clocks are present, then the internal clock would be
used. Choosing to use the internal clock if an external one is provided
sounds to me like a software policy decision made by the operating
system.

Finally, if the ADC has a clock output, why can that not be represented
by making the ADC a clock-controller?

Cheers,
Conor.

--yMMWItM1KHJdpK4s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZalCfAAKCRB4tDGHoIJi
0hhaAQDvo/bgLVu6oS5llw2h3h8XAlAL+bAjiwHrVL59UOfrNgEA/h5vAOs0/5Qe
NRAsWXVr6TqGMTKa//I5pxMUFyi4FwY=
=6PyI
-----END PGP SIGNATURE-----

--yMMWItM1KHJdpK4s--

