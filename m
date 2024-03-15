Return-Path: <linux-kernel+bounces-104522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA387CF24
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84814283F3C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A4A39FF0;
	Fri, 15 Mar 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xh9YWr5X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7018E06;
	Fri, 15 Mar 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710513629; cv=none; b=RBn/ELVyAP8mV9nuc4TCoic07Ltq2zAPsIGD3KRqEHOYRqICobxtgsjECGJLxDO5RxmiS3/4jvECjwlSZUCZM8KH15dSH5QdcPa3nSWYHBTAwWYfcNiwEFGcyUr4D1RDZpaXCiaQ/3uj535f2LYZUunggpjuiNTz1qMKvdp/b1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710513629; c=relaxed/simple;
	bh=/q5YpMd9flHlseDCFPbg8au4ag1109m5lTjQTwS5gjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYfbMbKECd3DdK4Lml0NVF3GuEPKLHQL7I9A+iwyC00mghyV8eEZf8QR0Wod5QqPufgtPRENyXXOEVXgTprH7PVG4sADZzMvOCA/pZqlqTZ+JQ3A5W2XWiD8+rNz7r5cUXnt9OdwrVi3MqzccaxumPTKtzMfIA54G/+POxaBUck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xh9YWr5X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A7C43394;
	Fri, 15 Mar 2024 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710513629;
	bh=/q5YpMd9flHlseDCFPbg8au4ag1109m5lTjQTwS5gjw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xh9YWr5X8ZC2LB5aTOiLwQb+ka5kfR3Rq3WSR2N14VU3k+/gBkTescbM5r8gxPImq
	 PYMXqiXv+1R5zvYmVQRbOj6ISyIIs0Jg8SW9cu6tBsgV/NDNrsaCAXlUSFYZxqToWn
	 l4Q6LURoBzapyHnLXCTKsDJVE8U0/mXF0vJu3TgISaWVou228FJcyNcrrXVWgFf61b
	 /wkXznU5VRw4R7GUKnxZMu75XOzGg7FqW58iVcnSpE65Z/LJnJSZZlhEc0IwZgcdU4
	 AXBntKqJoom6SKD0SvFQTZtZ0ljv+F6gieBnDhx3uW4Kl499/3lbwubH7ebT/R2iuF
	 LFfM0sXO6WpOA==
Date: Fri, 15 Mar 2024 14:40:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	christophercordahi@nanometrics.ca
Subject: Re: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
Message-ID: <2f58922d-8964-4693-ab8a-612eb2f427e1@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-5-bastien.curutchet@bootlin.com>
 <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
 <20240315152332.57c8fdc4@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="15hPqMQpuEKqXq2/"
Content-Disposition: inline
In-Reply-To: <20240315152332.57c8fdc4@bootlin.com>
X-Cookie: A well-known friend is a treasure.


--15hPqMQpuEKqXq2/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 03:23:32PM +0100, Herve Codina wrote:
> Mark Brown <broonie@kernel.org> wrote:

> > dev_err_probe() with a fixed error code doesn't seem to make much sense,
> > the whole point is to handle deferral but for a straight lookup like
> > this that can't happen.

> The error code is uniformly formatted and the error path is more compact.
>   https://elixir.bootlin.com/linux/latest/source/drivers/base/core.c#L4963

> IMHO, to benefit of these feature, it makes sense to use it even with a fixed
> error code.

I'm not convinced TBH, the fixed error code smells pretty bad.

--15hPqMQpuEKqXq2/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0XdYACgkQJNaLcl1U
h9BL+Qf/e/mT3mvVoCNVK90XX2T3vJXR/x4cDU6LIbiYli44yw2LIvQ6NEJdy1s2
h2NuvcMj4KFqXuOmTHZFkLVj3bteWZpfEBCd9Yyp3k0S2v3lz6vKMo6WeI2JTMnZ
Or+DSkLgGs8Rgn7aVqilsMBQRKQjnZ9JrYK0v02oMMWjm4Lg5Gk9AXwOOPvHAbWt
m/SrXOnPfFeWn0XXywm3AjF1vWnFu1g+qbPq/MniiwA7kYF7CG2fZCm/p1itXQIc
C+Phc9DjmvnJQwC+pSgTSoWx8nwKW6cDiV0ndVaJkudn90o4yxWj4DGJSxzCz8U+
ytZAz8Q0eZ+iH6t2K2R+Mt/5eNGvrg==
=GIiK
-----END PGP SIGNATURE-----

--15hPqMQpuEKqXq2/--

