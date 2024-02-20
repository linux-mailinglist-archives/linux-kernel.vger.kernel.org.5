Return-Path: <linux-kernel+bounces-73548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8452E85C3FD
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6C091C22ADB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F5912FB38;
	Tue, 20 Feb 2024 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeNPi9sX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD867867A;
	Tue, 20 Feb 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455164; cv=none; b=LNPevMSDbVAgGQqKW0xMjKKKVxRFFUer5sh+gUWqAuH32flEboYSRNj1/Dxn0pSfbTnyvOQHiVqZnSh5wreWZb8z/hHIrqC4XL2diCLdBNcPLfeYXT5KSMY9QMWW6AKxvaKoa5gL/f4zK5P2Zd+ShQClkKRO6NyjYz8H8FgYN/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455164; c=relaxed/simple;
	bh=hIyvGKECNml8BOk3Zh1T6U7K5fqanwk9IvN5YMXzbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp0B9SV3tGioXM+TGBXC2qLv5btI/TlXhEcdQb4GsSK7TNJ9y4v9gchrwhwAozUZAJw9yGwN2YiZ0fF/p0TrinwlPkMckeObmtS7CqvlYdvzJ4hJXhL3YAkU8r6OSJJ4F+Vz0ThrChYjzXoQZVxBDv8ZXQJd10dz6YjCE0kfdOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeNPi9sX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FBEC433C7;
	Tue, 20 Feb 2024 18:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708455164;
	bh=hIyvGKECNml8BOk3Zh1T6U7K5fqanwk9IvN5YMXzbIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OeNPi9sXybX+V1U26X7t5BRpgQ6ca6bckj/2dKyfdOYKyEBOjZWRIevkTFQZWrFTe
	 FlaefYoUwRCw9A4+vyKiRL6NzRMVO0ZVE800T/M2q24cFVsYtULdz/UYozjVGxEcVH
	 /a8AVPi/OVA91z8z2GLMvzuF2Ug++UFHTn2YavxgF4PQgrK0w/OPyFoyRaqFVboJ31
	 d8kYUP2SlgMU+MzKpYhJ2fYfUm6eFGJ0N++kFliphJsPGpXI7jsD7XzIAwC2EPmkMX
	 h84J9NmoGUJcqdTJUVFtj9cPBhZAdei9RLxnWZXpbIYUwuAXmiOCYzlXlSXbrFt5JZ
	 UiMM3itax2/xA==
Date: Tue, 20 Feb 2024 18:52:37 +0000
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
Subject: Re: [PATCH v13 1/3] dt-bindings: adc: add AD7173
Message-ID: <20240220-outmost-flavoring-b2593160de91@spud>
References: <20240220094344.17556-1-mitrutzceclan@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vLHcLCfBcKKsyixC"
Content-Disposition: inline
In-Reply-To: <20240220094344.17556-1-mitrutzceclan@gmail.com>


--vLHcLCfBcKKsyixC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 20, 2024 at 11:43:38AM +0200, Dumitru Ceclan wrote:

> +  interrupts:
> +    minItems: 1
> +    description: |

> +
> +  interrupt-names:
> +    minItems: 1
> +    items:
> +      - const: rdy
> +      - const: err

I noticed that for minItems == 1, the rdy interrupt is required and err
is the optional one.

With that in mind, you can simplify the interrupts description so that
it describes the interrupts separately:

  interrupts:
    minItems:
    items:
      - description:
          Ready: multiplexed with SPI data out. While SPI CS is low,
          can be used to indicate the completion of a conversion.

      - description:
          Error: The three error bits in the status register (ADC_ERROR, CRC_ERROR,
          and REG_ERROR) are OR'ed, inverted, and mapped to the ERROR pin. Therefore,
          the ERROR pin indicates that an error has occurred.

Otherwise, I think everything has been sorted out?

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--vLHcLCfBcKKsyixC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT09QAKCRB4tDGHoIJi
0pbnAPwOogZk7FYWbEiQymCF9QbGN2aePmxNXySm/bbh5Ae6MwD7BBgqXRFfmPWm
pUBnH3bEbmLCIOA+mYKHA5Nq/zsZ5gw=
=b/7e
-----END PGP SIGNATURE-----

--vLHcLCfBcKKsyixC--

