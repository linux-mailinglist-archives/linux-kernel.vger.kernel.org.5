Return-Path: <linux-kernel+bounces-153632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580388AD0A7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13A0C286BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7405D153BC6;
	Mon, 22 Apr 2024 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvvF3hkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A598B153833;
	Mon, 22 Apr 2024 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799687; cv=none; b=aBtLQLhcmqLT1UrX3PW5FiTq2oNpYoY11GAuyYmb+MgCEJs4jWswloUlR+rzOi8fiNbnaIJNRUtToazIV7o8dwp2/7AZ5ga4rc5lbO5eZ4LIa/wX8Z2H2+8VP7YMMRGMaRyLlZX3KBkejlYWrCzoLBE+DI1SVjdcA1ktZa8SN6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799687; c=relaxed/simple;
	bh=xU07OpbSq5sBF7I9UKLveBB+3+MGri17jbugWRX1SbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWrNrtQPowoiww8weRVtdGwtWC6Bpkz6CsYEq4uAXwLDuz2lInyszYwbZTQRQ3TPoe/je4nLgV31ypoKNqB4s/h1HjCupc1w9zEflT5XwWcBDYdZMttLn1ZRCY1zv//6cWcfwm6dZWhJimHqj3Li3FyifUztAPIEszk3qaq4r+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvvF3hkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C769DC113CC;
	Mon, 22 Apr 2024 15:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713799687;
	bh=xU07OpbSq5sBF7I9UKLveBB+3+MGri17jbugWRX1SbE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvvF3hkQPdsUISwIYc/f5YjULbbaEnNKJ5ZtEaUxWcBuF7OWkY1leSN4Q7Fm0R5Mk
	 pic1Fzy7wQYYUdWlSEsp4/zqP0Vq+RFETX3gPVzdjPJE/J7qAvBN4ek0Qan/fX9VYS
	 9ttGl89QmQxG8G4nfAQFXLiOZAwyzOt41M839Cxf66RRvxHbuaxJGBaDYrwFg6FXQO
	 fph32jpQIU9eJBh5dOwRnWZxCUlyR1TLVrYcelkZf4iHEegO+7XVyZ6Tnv+7YuPZHP
	 kvUsVvgPYzpH6POcHtMyFAjGxVczXVrtnqBzyWhhmhz98bazDe/vMwz+6nQlA+9Zo8
	 BqMPu+7kePQeg==
Date: Mon, 22 Apr 2024 16:28:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Konstantin Pugin <ria.freelander@gmail.com>
Cc: krzk@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org,
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com,
	manikanta.guntupalli@amd.com, corbet@lwn.net, ychuang3@nuvoton.com,
	u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 2/3] dt-bindings: sc16is7xx: Add compatible line for
 XR20M1172 UART
Message-ID: <20240422-repackage-popper-8a062acf2610@spud>
References: <20240422133219.2710061-1-ria.freelander@gmail.com>
 <20240422133219.2710061-3-ria.freelander@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3a3xIlGiZnWRdFvn"
Content-Disposition: inline
In-Reply-To: <20240422133219.2710061-3-ria.freelander@gmail.com>


--3a3xIlGiZnWRdFvn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 04:32:14PM +0300, Konstantin Pugin wrote:
> Add EXAR XR20M1172 UART compatible line into devicetree documentation.

I thought I had already pointed out a need for the commit message to
explain why this exar device belongs in this file. IIRC you said it was
in the driver commit and cover letter, but it needs to go here too.

Thanks,
Conor.

>=20
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Vladimir Zapolskiy <vz@mleia.com>
> Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> ---
>  Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml =
b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> index 5dec15b7e7c3..c4bedf23368b 100644
> --- a/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> +++ b/Documentation/devicetree/bindings/serial/nxp,sc16is7xx.yaml
> @@ -12,6 +12,7 @@ maintainers:
>  properties:
>    compatible:
>      enum:
> +      - exar,xr20m1172
>        - nxp,sc16is740
>        - nxp,sc16is741
>        - nxp,sc16is750
> --=20
> 2.34.1
>=20

--3a3xIlGiZnWRdFvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZiaCAAAKCRB4tDGHoIJi
0phQAQC/0W99wp/ktlJOwwYlunbk0+RgoEpY72PHGNoxO1fm9wD/bODCDwYsKvK+
lqJLoLK7IVrRzP5m1WAtyNoU3JWfNQs=
=AOjT
-----END PGP SIGNATURE-----

--3a3xIlGiZnWRdFvn--

