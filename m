Return-Path: <linux-kernel+bounces-31350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E7832CF5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0861F244F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB21054F92;
	Fri, 19 Jan 2024 16:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTfpgvYQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2518A55760;
	Fri, 19 Jan 2024 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705680859; cv=none; b=R0CtIgDordARuTfZhz5puCAh5n0yP93eIBpZc2tcU4iXw8lwbK0msauxWxUq13BjYHAvPcOd73i2g3l2cFCO4k5W7wtPhWuJG5uH7XNJU92qeau4VmiBl3L9XxiL5xLDj45yJd9Yz40I9cQYaAohHiBDM2R1YLJ15RP3L8Un9Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705680859; c=relaxed/simple;
	bh=FTiyumdDUu3LG/iF+VkzG7r/ahERdxQdR7At/f8SshE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1Cm6oNayWf2hKdB5CjfDG84id9uTDcfoWS5XDUt0pryWP9fePcp7wyB4KKt9XxiTn2w9j55I13Nl57Zle4zJIQ+nVESq2gIavtSc0ssYzcA74O2swT3VzdNd9h0imi9/grrkYxp0ent5EdzgWPEogLI84Se6Ujiko87RZjfuRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GTfpgvYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930A6C43390;
	Fri, 19 Jan 2024 16:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705680858;
	bh=FTiyumdDUu3LG/iF+VkzG7r/ahERdxQdR7At/f8SshE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GTfpgvYQliKoCICox/GA4UF2qAAxQTCC01Jg+KSo0KX0XdqZoq4jYqxseI7HESkTO
	 4vEuUO1984PbcN8UQaD+CcMp5kYGwNe937aToDNy5E6XRcQvUj2iPKj1WqG6hIeDB6
	 hUwt2sXl37wkfEc7LzkFIxoRM1zrUU74jvIjYtt70gq5M+nubkMjR1ifH38iY/TQ4h
	 d3ViRA6fvtLvQNHzdlzY6NQ38FJZiVHdHAeRaan5oJEr7MLGLkDBC2PhSBEPcbubhb
	 +yA16381Zz+VRROSh0ZHPsHAk7KUUtSocsgI9I7FEH7IlvQLmzzNynMv9QohE//pDj
	 V+4QBJ2XxE56Q==
Date: Fri, 19 Jan 2024 16:14:12 +0000
From: Conor Dooley <conor@kernel.org>
To: "Ghennadi Procopciuc (OSS)" <ghennadi.procopciuc@oss.nxp.com>
Cc: Chester Lin <chester62515@gmail.com>, Andreas Farber <afaerber@suse.de>,
	Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH 1/3] dt-bindings: clock: s32g: add uSDHC clock IDs
Message-ID: <20240119-cattle-antarctic-432fa8e1c0ef@spud>
References: <20240119130231.2854146-1-ghennadi.procopciuc@oss.nxp.com>
 <20240119130231.2854146-2-ghennadi.procopciuc@oss.nxp.com>
 <20240119-magnetic-racing-0adf8e5fbd4a@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qUpbBLVWlyJG4s+w"
Content-Disposition: inline
In-Reply-To: <20240119-magnetic-racing-0adf8e5fbd4a@spud>


--qUpbBLVWlyJG4s+w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 04:11:37PM +0000, Conor Dooley wrote:
> On Fri, Jan 19, 2024 at 03:02:28PM +0200, Ghennadi Procopciuc (OSS) wrote:
> > From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> >=20
> > Add the SCMI clock IDs for the uSDHC controller present on
> > S32G SoCs.
> >=20
> > Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> > Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> > ---
> >  include/dt-bindings/clock/s32g-scmi-clock.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >  create mode 100644 include/dt-bindings/clock/s32g-scmi-clock.h
> >=20
> > diff --git a/include/dt-bindings/clock/s32g-scmi-clock.h b/include/dt-b=
indings/clock/s32g-scmi-clock.h
> > new file mode 100644
> > index 000000000000..739f98a924c3
> > --- /dev/null
> > +++ b/include/dt-bindings/clock/s32g-scmi-clock.h
> > @@ -0,0 +1,14 @@
> > +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
> > +/*
> > + * Copyright 2020-2024 NXP
> > + */
> > +#ifndef _DT_BINDINGS_SCMI_CLK_S32G_H
> > +#define _DT_BINDINGS_SCMI_CLK_S32G_H
> > +
> > +/* uSDHC */
> > +#define S32G_SCMI_CLK_USDHC_AHB		31
> > +#define S32G_SCMI_CLK_USDHC_MODULE	32
> > +#define S32G_SCMI_CLK_USDHC_CORE	33
> > +#define S32G_SCMI_CLK_USDHC_MOD32K	34
>=20
> Why do these numbers not start at 0?

Ah, because these are the SCMI IDs directly. If these are numbers that
are in the TRM, just use the numbers directly - there's no need to
create bindings for that.



--qUpbBLVWlyJG4s+w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqf1AAKCRB4tDGHoIJi
0h34AP9TixDJ6YFjXe+5v6wxO9hgfYPUCpxkmHGGn4w/+waszQD/Wzjy8sz++98r
s+IkN7/DXavVamW4wy7pnsZC9nJwFgI=
=XE+5
-----END PGP SIGNATURE-----

--qUpbBLVWlyJG4s+w--

