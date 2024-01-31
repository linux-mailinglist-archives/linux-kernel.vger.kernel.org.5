Return-Path: <linux-kernel+bounces-46878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C00B8445B5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40DA31F2235B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3B6137C3E;
	Wed, 31 Jan 2024 17:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcl8GR9Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5513B12CDAD;
	Wed, 31 Jan 2024 17:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720970; cv=none; b=ks0SGBN6N5fm9ybeX8a2bK0VeWHbGaFCQpMXw7TW5L1xIaeUMZIXrXRjohKATwkDKiabwQbfvWi86kURguIF3QOpRHMG3v/a1L+VCRuafTxCh0SIJ33wYLt8BX7VGLeumQ3tJNUcsVKo9EB/AhroQ9R3970C4qImbA4hbQnx4hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720970; c=relaxed/simple;
	bh=dVvlpOFPokj2vNw6vrhxASEx0Sn+K4PJzSQgQWHwgBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=molVg8JFcwlbny7r1c9+KfNU+cua2gFXyURVbqyIrEMeh3zYbW8rcEYc3o7mqMb8FjnCZwuMq3qhFoEQGNDZSEwlcFBIjX69yGbMCnqhgizyl14UPtsoSzXcgCRzeq7U5M+E+9iWxXDPB42GM+pzLPZYFbTqfQO6fMrfsQqy0Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcl8GR9Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD5D7C433C7;
	Wed, 31 Jan 2024 17:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706720969;
	bh=dVvlpOFPokj2vNw6vrhxASEx0Sn+K4PJzSQgQWHwgBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kcl8GR9ZaWoc7zLRPbldy0pSjmZ9EnduzFdn9dLAtG2imtPNJwDJYp3c2HTe6z2fX
	 iZe8pSm20ECL8q0hLq4qOUp4QLeI0Q0t8ittmTizk7QZpjTnC0nnhU96Ese3uWt1uz
	 jN4RgblEZePFCUIp7ImZMqlUt63qwpLDM48neQKXK/57NTgTIM9plC6g4v1c9TT9an
	 OwPDXXZLMc5wK2QY7z5Tyq+3l5Q+TWzVVnPJLfqIQhQocQ42vR3r9tfF30G5fKTg9t
	 bThiX20tNj0oAoU84ZqhuKH4UQKdkIM/6pOzQ/7R9qaUOofI8N2VqCQUggCltKSoeO
	 Y/IlEgELsQ1og==
Date: Wed, 31 Jan 2024 17:09:22 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org,
	hari.prasathge@microchip.com, manikandan.m@microchip.com,
	Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [linux][PATCH v5 2/3] dt-bindings: atmel,hlcdc: convert pwm
 bindings to json-schema
Message-ID: <20240131-ravioli-unseeing-401d093f3d7b@spud>
References: <20240131033523.577450-1-dharma.b@microchip.com>
 <20240131033523.577450-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aXzkUnbG7Mn0Gz+m"
Content-Disposition: inline
In-Reply-To: <20240131033523.577450-3-dharma.b@microchip.com>


--aXzkUnbG7Mn0Gz+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 09:05:22AM +0530, Dharma Balasubiramani wrote:
> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> format.
>=20
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Same comment about the examples here FWIW.

> +examples:
> +  - |
> +    pwm {
> +      compatible =3D "atmel,hlcdc-pwm";
> +      pinctrl-names =3D "default";
> +      pinctrl-0 =3D <&pinctrl_lcd_pwm>;
> +      #pwm-cells =3D <3>;
> +    };


--aXzkUnbG7Mn0Gz+m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbp+wgAKCRB4tDGHoIJi
0uHdAQDRIWCACxF57XH7d6WwYm9HlJkxtUJkLkZJC1tH6V9gxgD/QeCytDHnwOcI
MHTiSXTTdJqrntCh1r9H2nbFvbD2ngg=
=Eynb
-----END PGP SIGNATURE-----

--aXzkUnbG7Mn0Gz+m--

