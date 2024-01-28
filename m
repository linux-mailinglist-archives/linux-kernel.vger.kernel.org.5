Return-Path: <linux-kernel+bounces-41845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0442A83F891
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A94231F22197
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C32D044;
	Sun, 28 Jan 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PC3NU5LA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1702B2D04F;
	Sun, 28 Jan 2024 17:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706463538; cv=none; b=PE585S+hFzjpS3i5MdJV62L5Bq2hUUgh4SCfR4OfYRkhou4IM123ZWWpVfcBHvlGOyLByUjpVS9mjTA1KEiJCCIkDcPqEM2KVejl59Q/RcGjbG3nFZEJH0zjA0JqsX37TPp61tct7Xg+47RdbVlY+4rTr0q06TPXJPg5KZztiUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706463538; c=relaxed/simple;
	bh=IjQ/1TqkmYZebuFP5yVrH0wPzR/hJ4PTWRo5b1Q6T2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4/u15/DD5RbdjXE95ES8QrGcGJb7csQKU7j/sp3gKLirl47jl9z1nbi36avFWR3UWVsOsVi01YElXKpIsxxU5VBy5Ep+UK2O8cXiY1Y/GuZBf6ChS+fyNWZ68lfX3ytLrwt0PLhGxXAJTMlgl5Mld9FacJS6vx+XuTTkYz6gm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PC3NU5LA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0482C433F1;
	Sun, 28 Jan 2024 17:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706463537;
	bh=IjQ/1TqkmYZebuFP5yVrH0wPzR/hJ4PTWRo5b1Q6T2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PC3NU5LACNJBxfpFA7Iuka8V4DlexS01lk6nHfhY4crAXEFKzph7Ea3BMTKdDD8OU
	 mN0nDgRh9teIeu//jlOYOwekqTTDbwKc3xEPVqrDR9n0vT1AYEcmtwEOIUqMBC7Z4d
	 vQwisJJsADIkEZVg94tY4Dec1c+vNcjVl7nZNr+Q5hogO/oqt/bTOOY395ZZSjdXNj
	 5passx4f1Up7lxWhDBEbH013lW88itoR4B+GYlKvw6yxZoLsuR4VJ+vL2B4wFoAu14
	 be8baMLhrfXYunbzdQ9OVGbzNRubG7bUhP7r91SSXDkuPG9Z2uk6lFmMSA9WlQ9DpM
	 2hRy93oGsUtUw==
Date: Sun, 28 Jan 2024 17:38:52 +0000
From: Conor Dooley <conor@kernel.org>
To: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh@kernel.org>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	quentin.schulz@theobroma-systems.com
Subject: Re: [PATCH v4 3/6] dt-bindings: serial: add binding for rs485
 rx-enable state when rs485 is disabled
Message-ID: <20240128-vagabond-mutilator-cf8dc6ac8a41@spud>
References: <20240126-dev-rx-enable-v4-0-45aaf4d96328@theobroma-systems.com>
 <20240126-dev-rx-enable-v4-3-45aaf4d96328@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DzRBhgrdidHhTC1B"
Content-Disposition: inline
In-Reply-To: <20240126-dev-rx-enable-v4-3-45aaf4d96328@theobroma-systems.com>


--DzRBhgrdidHhTC1B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 03:55:12PM +0100, Farouk Bouabid wrote:
> RS485 can have a receiver-enable gpio (rx-enable-gpios). When rs485 is
> enabled, this gpio, if provided, must be driven active while receiving.
> However when RS485 is disabled this gpio should not have an undefined
> state. In that case, as DE and RE pins can be connected both to this gpio,
> if its state is not properly defined, can cause unexpected transceiver
> behavior.
> This binding depend on rx-enable-gpios to be implemented.

Why do you need a dedicated property for this when there exists a device
specific compatible for the uart on both of the affected rockchip
systems?

Thanks,
Conor.

>=20
> Signed-off-by: Farouk Bouabid <farouk.bouabid@theobroma-systems.com>
> ---
>  Documentation/devicetree/bindings/serial/rs485.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/serial/rs485.yaml b/Docume=
ntation/devicetree/bindings/serial/rs485.yaml
> index b64577036b5c..4c79dfaaf460 100644
> --- a/Documentation/devicetree/bindings/serial/rs485.yaml
> +++ b/Documentation/devicetree/bindings/serial/rs485.yaml
> @@ -55,6 +55,11 @@ properties:
>      description: GPIO to handle a separate RS485 receive enable signal
>      maxItems: 1
> =20
> +  rs485-rx-enable-inactive-when-rs485-disabled:
> +    description: rx-enable GPIO is not active when RS485 is disabled. If=
 missing, active-state
> +      is assumed.
> +    $ref: /schemas/types.yaml#/definitions/flag
> +
>    rs485-term-gpios:
>      description: GPIO pin to enable RS485 bus termination.
>      maxItems: 1
>=20
> --=20
> 2.34.1
>=20

--DzRBhgrdidHhTC1B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbaRLAAKCRB4tDGHoIJi
0lVcAP9p7fg8n4e6rLO8EL2Eb1sSnS3GQtn1fONEOpidqgF31AEAvoJXIDhzhnRF
r/P/IvBUvRkQTjXM4O4aoPKsdLrOQwM=
=9qkJ
-----END PGP SIGNATURE-----

--DzRBhgrdidHhTC1B--

