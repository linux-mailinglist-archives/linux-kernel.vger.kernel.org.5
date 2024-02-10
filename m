Return-Path: <linux-kernel+bounces-60395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA65850460
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 13:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D84D1F2251D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 12:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AE83E464;
	Sat, 10 Feb 2024 12:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JnloRa8r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8C63DBA8;
	Sat, 10 Feb 2024 12:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707568127; cv=none; b=WaWMNDK2OtsRWn6DiDJzRGeM5buRaHh11Q9ZNDpq60sGeTGVZIPWTi/PTHRx9krOAJ2NTRXAFz3PdiDyhvlA3dHTo0wTlJBSC4nwUaIBoOTRsu2LCHDxQawAdyXd+LdzIg2Baa46zIDKwVb2Qyptlo4iya12KiO+kUTgNetu6Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707568127; c=relaxed/simple;
	bh=n1SXa45OWt5gxS1ZW4uwLNmbdEvh0C1qDEo0Ica0gGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YrbPpVBDrb52YY0ZHbJwXe8iGAspZcFcL4eUA5soC/jitrsn2Fyb8ZtM0z1WAZdXbCZr0FJToyKMLFWnYGV94/plTC+Y+isIPMZ0pPB1XJi1Nzox3nUwKm97IS2JCasiGnUYKvVQcqydGp5qg5hfSegZaLMZ4087ALZtKiN3OGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JnloRa8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A0CC433F1;
	Sat, 10 Feb 2024 12:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707568126;
	bh=n1SXa45OWt5gxS1ZW4uwLNmbdEvh0C1qDEo0Ica0gGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JnloRa8rVltZ3SRL0VcNKn6q1HNRxH1Uh6EKrvDehziH84t35RFqQJVveHHkUrgjd
	 aXZfqAxxKEmibNkMHEBmaqLXtJfhOIyW9b9K/Cfwku0eH16KKlpAc5oLFdqg6tgNgI
	 45w6KRyF4rI3kN+l/8jgERAkmzC10zYkvVp4ch1po4R57zvjNk707thJ5/kHD58Zoq
	 LggCay+NDF9IOFOZ90Yu1IC/fUtLVaB8NJL0DRTWITGlb2mxBAxPIrn/I7pDEwZcjE
	 5Pk4ugcteWCPuQ1leRsGRqte0e4jLyMboOQzz4w6cPCn3htUgGkJGX62bz7M0Vk+nH
	 XZfl0jIQfjbwg==
Date: Sat, 10 Feb 2024 12:28:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 03/14] dt-bindings: sound: fsl,imx-asrc: convert to
 YAML
Message-ID: <Zcdr+fMEpxNiqxQN@finisterre.sirena.org.uk>
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-4-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ipnWyDd7ObTvUGJ5"
Content-Disposition: inline
In-Reply-To: <20240210012114.489102-4-sre@kernel.org>
X-Cookie: You might have mail.


--ipnWyDd7ObTvUGJ5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 10, 2024 at 02:18:07AM +0100, Sebastian Reichel wrote:
> Convert the i.MX ASRC DT binding to YAML.

Please submit patches using subject lines reflecting the style for the
subsystem, this makes it easier for people to identify relevant patches.
Look at what existing commits in the area you're changing are doing and
make sure your subject lines visually resemble what they're doing.
There's no need to resubmit to fix this alone.

--ipnWyDd7ObTvUGJ5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXHa/YACgkQJNaLcl1U
h9AziQf5AY/umton2qczFUuj4rrGHyLDbZpR1VM3gWQ0qWK/C/755uYNgBIRkY3d
ambo5whWDDiGbdcfJA3cPf5LLh2QfmrfRDOnMuDkpXgStOX8NM2dL9yYHVkFc00V
a1EtiIlmF9m7WBS5/j5aWbjVxO5NNcgWzPeEAEB6tZSseolT0pCiU3QyTgy3pBdF
O7ABOYC+EiMjBonkfIfNRtFo1LgtaCMDWUvAR1Zi9xQaK2Vt8kCwTV/ASmlaXEsO
nUYkM/86Lh/nQ2GSBmi30LYspv4fRR4Z1P/lv6rLUaaSKkdMP588CiryVhzT7Rqn
Bc96sxdnBNKPwiw9wnK20W3gsaV04w==
=hDEo
-----END PGP SIGNATURE-----

--ipnWyDd7ObTvUGJ5--

