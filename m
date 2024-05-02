Return-Path: <linux-kernel+bounces-166662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2838B9DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1172E1F22603
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3387715B963;
	Thu,  2 May 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lX+LA9Qh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705335103D;
	Thu,  2 May 2024 15:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714664857; cv=none; b=i1mwvcjC+He72g9GmIEESrMr4DScPM021HTVQ7JzaRY9ndX1LW0dqEIwOXTL2Y6aoU75vumpzEHXzR35edv2Z2fQ52sdX0J0bOhoyo14v5gw13PFxVpvmUpWHxw24H6MzsV5/V3hzfEQ+ocoedHurJoLbIObnpmh7cZtjuiX2EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714664857; c=relaxed/simple;
	bh=K38Qzg9vtdLwa/E8SOuIfqtUwx3/9xbQ0FyRceQT94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SqtVJ8UbeQ/Qn6BJ4YVuk2xzH7k26Ix36JL77uuhAN0/rGtEfQtdtNvOj4U5FRDtnWkV9tUuSczx+frlHHGA8k0BrN8tzm2AVFt8+ge0Ftr+Q+VW2nGa/bHfsstLKW198kopZbrHsR8bNS5rgagTGPDV4QwDfcSbMLY+qpjAgDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lX+LA9Qh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94BCC113CC;
	Thu,  2 May 2024 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714664857;
	bh=K38Qzg9vtdLwa/E8SOuIfqtUwx3/9xbQ0FyRceQT94o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lX+LA9QhBEtnMLXf2qQMCTVnD4XVeZVZ9v9aUlLh54ui8c/E4+CnZ+q8deL0RkaIC
	 yPtQNnWCD//ihfW3Y/3JaFk/F9yc1qQMEq3rWDUxcVpKWn5G1jXBOm1U1H93zB5yaG
	 RLCyhRX9xJ52t5U9JW1OYrsyf7Yeu879vqtN77pYXnVFNwnOS9xZgWoGRijCpSIoUC
	 1v/hNV/QT/s+QIje6nu5D1RWsm37W24D0gEP/g4PtsXclXzAi85tPsrRlc9FJPbMhc
	 nlJjgFeKoq0PyQTkBTvLY/s+yulFYvkfMnPtNB9JtrmJerPxlr8O9xnPVK4gsaxc1q
	 NcSGe0PCpDUTg==
Date: Thu, 2 May 2024 16:47:32 +0100
From: Conor Dooley <conor@kernel.org>
To: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-riscv@lists.infradead.org, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	valentina.fernandezalanis@microchip.com
Subject: Re: [PATCH 3/3] spi: spi-microchip-core: Fix the number of chip
 selects supported
Message-ID: <20240502-jailhouse-porridge-3e3cf7fe5bff@spud>
References: <20240502143410.12629-1-prajna.rajendrakumar@microchip.com>
 <20240502143410.12629-4-prajna.rajendrakumar@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OBnlOd1dmj9M7N71"
Content-Disposition: inline
In-Reply-To: <20240502143410.12629-4-prajna.rajendrakumar@microchip.com>


--OBnlOd1dmj9M7N71
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 02, 2024 at 03:34:10PM +0100, Prajna Rajendra Kumar wrote:
> The SPI controller in PolarFire SoC has multiple chip selects, but only
> one is wired up in the MSS. Therefore, fix the driver to chose one
> chip select.

Given Krzysztof's comments on the binding "only one is wired up in the
MSS" probably means nothing to anyone other than us, and we should
rephrase this so that we explain what this actually means.
The actual change is fine to me though, since I do understand what's
being said here. With a revised commit message:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

>=20
> Fixes: 9ac8d17694b6 ("spi: add support for microchip fpga spi controllers=
")
> Signed-off-by: Prajna Rajendra Kumar <prajna.rajendrakumar@microchip.com>
> ---
>  drivers/spi/spi-microchip-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-microchip-core.c b/drivers/spi/spi-microchip=
-core.c
> index 71886c27bca3..4289dfba9af5 100644
> --- a/drivers/spi/spi-microchip-core.c
> +++ b/drivers/spi/spi-microchip-core.c
> @@ -21,7 +21,7 @@
>  #include <linux/spi/spi.h>
> =20
>  #define MAX_LEN				(0xffff)
> -#define MAX_CS				(8)
> +#define MAX_CS				(1)
>  #define DEFAULT_FRAMESIZE		(8)
>  #define FIFO_DEPTH			(32)
>  #define CLK_GEN_MODE1_MAX		(255)
> --=20
> 2.25.1
>=20
>=20

--OBnlOd1dmj9M7N71
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZjO1lAAKCRB4tDGHoIJi
0vsQAP9/OdCw/6S0RNS/dhjNw9pFJq2YFuMdXEaLFb7dPziZSAD+IkzFjvRoOFQc
Y8+KyytsVQfkrajM+tEM3gpq7XvxDw4=
=DudQ
-----END PGP SIGNATURE-----

--OBnlOd1dmj9M7N71--

