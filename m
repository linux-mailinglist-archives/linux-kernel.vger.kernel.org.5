Return-Path: <linux-kernel+bounces-123579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 381E9890B4D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24DA1F283FB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8995113A3ED;
	Thu, 28 Mar 2024 20:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4o2OmxM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FD7131753;
	Thu, 28 Mar 2024 20:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657538; cv=none; b=saKR8OaYPInnj1sJ9UPLDcBlK8O0z0gGtNV3wFc1QhDR95u5K/Ev76XHeBjhIRDWseFWsT/3pj11aHuwHEmLf/qDcgsQL6TbgIkLNkyjmC+5DE6avzaLPCTdWSHbh8N+ZvWUTmNwPI9ehUwGRjQY3TtT0+N+jKScya5BR9wacQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657538; c=relaxed/simple;
	bh=uLKGKHPYrINSKa7Ua6spfB0BXJ6X0qB7dFs0VLn6mow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4iS6f6Kjldz3b+i1lu8OAa5SlOX5rW5lmyxGV3yCIH0D+v93AtY6HnRNONgozS0beXM3QK4Nooy+1Ih7LXMUS273CTdRFodAfgvdOi/HVsnR6B13t4y6gWM2r7Eu0a5ZASX7nrXPCsXS47HxPkONpoZ5eC6kVhKXhnEOvHVNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4o2OmxM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9170DC433C7;
	Thu, 28 Mar 2024 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711657538;
	bh=uLKGKHPYrINSKa7Ua6spfB0BXJ6X0qB7dFs0VLn6mow=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t4o2OmxM8QuDeLAfom5BUyuBUVPZQG+XUENdNqCrWf07mov+v/xlV3wpyjbONMYDd
	 sGoVZ38a/ieAYoupou2K+k5BRDOnBTQ+SPIpR/ppuYHARZZ6Audan+8E4Lf4FZyBf0
	 PgWKq7ZjWxvvyF+capA8hj21Hr98wmYkppg+SnWoNOZAtpli/EcTWznfsfGLimjwqJ
	 m7xsdVlS8Tb/Hfu2/3row7LEvRsal45iPQt0+WATTwhQmRJcLwSkh2hYLAcIcjKDhc
	 tYv1DOIpwVq1E6uwFjmWifRtZeHDyw44mCmSDDehBV/XienNpptDe2MeKJfBOfFR3O
	 P2FVvkRBPDE9A==
Date: Thu, 28 Mar 2024 20:25:31 +0000
From: Mark Brown <broonie@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 1/7] regulator: devres: add APIs for reference
 supplies
Message-ID: <8d98fab7-d73b-45c5-a46a-ace57907d25b@sirena.org.uk>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
 <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
 <ZgWw66OpLnLPdCn-@google.com>
 <043b347b-2652-4ffb-a8e0-954a89899ade@sirena.org.uk>
 <ZgXQcGlMiewRzki5@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5fDUEvDFvOkj++3z"
Content-Disposition: inline
In-Reply-To: <ZgXQcGlMiewRzki5@google.com>
X-Cookie: Yes, but which self do you want to be?


--5fDUEvDFvOkj++3z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2024 at 01:17:52PM -0700, Dmitry Torokhov wrote:
> On Thu, Mar 28, 2024 at 06:18:32PM +0000, Mark Brown wrote:

> > I don't follow what you're saying here?  What normal APIs are not
> > available?  AFAICT this has nothing to do with a devm enable, it's a
> > combined operation which reports the voltage for the regulator if one is
> > available which would still be being added even if it used a devm
> > enable.

> You can not do devm_regulator_get_enable() and then call
> regulator_get_voltage(), you need a new combined API.

I think the theory here is that there are so many instances of this
reference voltage pattern that it's useful to have a helper for that
reason alone.

--5fDUEvDFvOkj++3z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYF0jsACgkQJNaLcl1U
h9CUrgf/XPKWYWqhNVXtXDECIbF2IgErrGFkL54cu8EWxC/OrJPMdGnZV8lQmK0D
+pOV7o7CYYYtYG5K4brvdgqgAyK0COk55E0N4Y8PCtLIhnLmCNr+WsWP2RXlmwB+
m/K9zfyav3r6ZyKE0xZOeBderEAOixJCFQkJN/ssppyjeC2RAbOVmIcA3kpni8Vp
ONJFpdvniqYsk7lhetuSbn3NcfQefcWn0KKq2B0ZsgS1fWN70/ccR3cKhlZVfN1u
oG3zp4KlquAT/eTI+FGiqc3N2zVTON/tjEZEZMEldMsuZ3Oegyr75QIulXVqPtQq
G1AjkHGXsSDsNt5PERnu3xYz6F/XHQ==
=GRYZ
-----END PGP SIGNATURE-----

--5fDUEvDFvOkj++3z--

