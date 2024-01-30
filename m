Return-Path: <linux-kernel+bounces-45002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68460842A35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48B2282711
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB36E128386;
	Tue, 30 Jan 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu7noY8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284D986AD3;
	Tue, 30 Jan 2024 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633845; cv=none; b=fme9tS67ZyZBoNVwbRn6MN92krNx6aWOUjAwhyU/3bebaX2UImvhOFoYZJun3lINmy1ms1bSDmxaCAVrinPXe2Pz7MZ0k27/087O2gU/8VNWI0vi/DEpYYtRTF7himoAX8yWfktnP0C4OT4hprRpuJZIaMRlyZLDlDxWexkjwO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633845; c=relaxed/simple;
	bh=v6l/aG3NuOvMx+KE2ZGqqEitQ+bqDRcCIoxDPA17aW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lm6Frzs8EoTRewxGoWS+zkMNMz4cjXZC7PRLWQ1juwvxsRLcKoXmyK5th9uN/+InlV4XWu/r5eFCyes/4J3WhH3ExAe4geMahKFS5gmgKo4OJ30Oxse5GOj6uZGbd5kKAZM8iOCJi75B+5fxrxPYRaNPAwHOZ65E6WJhKPD19qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu7noY8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6336DC433F1;
	Tue, 30 Jan 2024 16:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706633844;
	bh=v6l/aG3NuOvMx+KE2ZGqqEitQ+bqDRcCIoxDPA17aW8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tu7noY8c+IFPsiF36V5S+RIPZAWazbwU+INC8AF6IRytGfbOaRgdP7eV7fEuOiSEz
	 16MCGGFAXqNUO9HGsKY+D3Xjn5Rj8hjT43PcxjWPI0+Xbe+ZOw+L4hT0Ph8wCiD9nL
	 UAwtfzv5hcEZ70A90MokXgfH+U+XfE3nQ2VxJK3DHTa9BXvsgpgJ14atFYZJ9uiOEk
	 PVLrjq6oPoc9MXFJmsCJDiDA7UbWdp//B9cFJAUXiP3tfZJV0E8ApKOgcbzDyTkqDv
	 bUX05ju+IfdeI1r7ZTkSjzxpx/T8ZfwwXvNXxoPT0n5LXBg6arFB5zsbFSgjF43AEN
	 30moqVI0S1kNw==
Date: Tue, 30 Jan 2024 16:57:18 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	alexandre.belloni@bootlin.com, claudiu.beznea@tuxon.dev,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	lee@kernel.org, thierry.reding@gmail.com,
	u.kleine-koenig@pengutronix.de, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 0/3] Convert Microchip's HLCDC Text based DT bindings
 to JSON schema
Message-ID: <20240130-unveiling-subplot-c4ccf0488439@spud>
References: <20240124100019.290120-1-dharma.b@microchip.com>
 <20240124-portal-sputter-f5207ac206ee@spud>
 <6eb0a63e-8619-40d0-b76e-4bcf7094a9ab@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="g66pnY2bvE7LgXvi"
Content-Disposition: inline
In-Reply-To: <6eb0a63e-8619-40d0-b76e-4bcf7094a9ab@microchip.com>


--g66pnY2bvE7LgXvi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:42:04AM +0000, Dharma.B@microchip.com wrote:
> Hi Conor,
>=20
> On 24/01/24 10:10 pm, Conor Dooley wrote:
> > On Wed, Jan 24, 2024 at 03:30:16PM +0530, Dharma Balasubiramani wrote:
> >> Converted the text bindings to YAML and validated them individually us=
ing following commands
> >>
> >> $ make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bin=
dings/
> >> $ make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/
> >>
> >> changelogs are available in respective patches.
> >>
> >> As Sam suggested I'm sending the PWM binding as it is in this patch se=
ries, clean up patch
> >> will be sent as separate patch.
> > Please give discussion on the previous version some time to complete
> > before sending a new one. I've still got questions about the clocks
> > there.
>=20
> Could you please give a green signal to proceed with the v5 patch series=
=20
> with the following changes only in PATCH 3/3?

Didn't we just decide on what to do on the v3 thread yesterday?
Go with that.

> +  clocks:
> +    minItems: 3
> +
> +  clock-names:
> +    items:
> +      - const: periph_clk
> +      - const: sys_clk
> +      - const: slow_clk
> +      - const: lvds_pll_clk
>=20
> >=20
> > Thanks,
> > Conor.
>=20
> --=20
> With Best Regards,
> Dharma B.
>=20

--g66pnY2bvE7LgXvi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbkqbgAKCRB4tDGHoIJi
0oiGAQCmzQ3c9h8KMcrP86fszRphmHgkRDFrSIntbabTD/m2HgD/Q3abC7mhzZpR
S4WKR6QUxtxsR7PdbFJQPRjftcEnlwY=
=EK8F
-----END PGP SIGNATURE-----

--g66pnY2bvE7LgXvi--

