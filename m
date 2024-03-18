Return-Path: <linux-kernel+bounces-106165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F17387EA14
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:29:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4053B1C211C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199B347F69;
	Mon, 18 Mar 2024 13:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPwx81na"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5726547F50;
	Mon, 18 Mar 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768533; cv=none; b=AFL/XfWCmI/o6+DjxtA/9hx+nYqN1D0MhXd4IHVTm+Vg2PLgOdIPNCVJizwLE+YMTCORykEkFHuXacEmOvhg0qiIkijmRGxdLdUfD2DA4XLugl+RI88msoyqKiOJutWkY8O5F/TTYD2JxCxXfQE7NnkSqiSgQHBWam/2rrEj67g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768533; c=relaxed/simple;
	bh=H4T7GRxUc7yBWQ/u7+eX/MPNWtS9olwvn5w3951JJzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTSlN6IwMW/ovnS5iKPhMUAyqqSXJRlYWdzfHR46b4m9RH/8XV+xN3mKAZNQxQ2AZ5nen9YjVqaYTbrZqTDTZDATVUia99aYK8in2NVT3FPHVLaa4XX8afVYYxuLk/olykt7c0xo7CcxE1u3JP/P3mvllZtzo+FtAr2UtQ0/H6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KPwx81na; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FDDAC433F1;
	Mon, 18 Mar 2024 13:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710768532;
	bh=H4T7GRxUc7yBWQ/u7+eX/MPNWtS9olwvn5w3951JJzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KPwx81naHa13NzOUadChg3ZXXlM4Sfuiu0hyjqME8CSu7bbn6dPXX9fM3Av51MWwp
	 lC6BjSjjKXisOf6Kvo0k30BSGCQfHKEVSPAMVo8LAwdYWGTUZUMS5aHHFpJ390HQE+
	 KystrWwhb03wJgV+GuBOFmbQN4WUyAEUbeJhFnSroQKxi7YHBnKb5X335rck3OiuZ9
	 ORW1KLzz9YcbC7cPhtj5UZHvZ5wZYTZeVlMIjuTMINnEH3fjFVqS6Fc1MYzCQHwGpv
	 wfrxRv5tLvclqRosigeSDxi4ltoMjD44u15AGBfr1C1z9WAHE4aRdcLrAEkwvokDGa
	 apDTwQGa95aFg==
Date: Mon, 18 Mar 2024 13:28:44 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Herve Codina <herve.codina@bootlin.com>,
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
Message-ID: <0ee075c8-7c74-444b-9024-ad5440c36789@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-5-bastien.curutchet@bootlin.com>
 <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
 <20240315152332.57c8fdc4@bootlin.com>
 <2f58922d-8964-4693-ab8a-612eb2f427e1@sirena.org.uk>
 <622b8b7e-7bd1-4e88-b705-79f7077b754a@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sdrGDqd8KEdxafwD"
Content-Disposition: inline
In-Reply-To: <622b8b7e-7bd1-4e88-b705-79f7077b754a@bootlin.com>
X-Cookie: Alaska:


--sdrGDqd8KEdxafwD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2024 at 08:40:24AM +0100, Bastien Curutchet wrote:
> On 3/15/24 15:40, Mark Brown wrote:

> > I'm not convinced TBH, the fixed error code smells pretty bad.

> Ok. I'll keep the dev_err() for the fixed errors then, and use the
> dev_err_probe() for the others, would that be ok ?

Yes, when we can get a deferral it's the right thing.

--sdrGDqd8KEdxafwD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX4QYsACgkQJNaLcl1U
h9DEsgf+Ny9qlyRP+/by6BPfHGXB+skGcS3TPXz/GIAnirpIiVrZg4hPTC/uSxWF
kuUx+m7UnPWUrUm7rBjDOhBNBpF16YY06MguCTLpBoOJ1f79tVB6Pn/8afzpGWS5
GjmCKVR8riUNwbh+/WvWF6t9FPMnjRWYPqudsy8w/Bw2zgkDzFCYUhKzdfhii7bp
TxBsaLFP8c+OT4plH/ofuW/RJNidJwn/f2cC2PWF5pv3uv2s3Jy4IAl/KvKRaYzl
Q+H3bGkfGslxduSxefjqGmB5WW0eFmOfefTZ0OVckvp5GdORBWPp8uGLq+Ge+sh0
poWhOCiuHaeY5JEeyFx2YXhxaFrCLw==
=wK3n
-----END PGP SIGNATURE-----

--sdrGDqd8KEdxafwD--

