Return-Path: <linux-kernel+bounces-30871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1D6832551
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:57:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 425E3282B7D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE67DDA1;
	Fri, 19 Jan 2024 07:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4XFtBMa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280CFD51D;
	Fri, 19 Jan 2024 07:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651053; cv=none; b=Q4AUjIIxorYNYyDzCkaPE+f46adMnzbKzaWM1DutSoYozlF6G9tWraampJR3Uk0+zK5Ggab+snaYPmeZh6QeZR0caX9toXYruLbjdl+vVUjigjh7XJ69FhGEwOSoSAPQaQ+0LlPvU058QhUrhZ1M2aFsNudLCPOucp4hD8w6hpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651053; c=relaxed/simple;
	bh=9UoP3WAV0HOIOYzSjVcxPb/Advh/Go4bggp68Bk23so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYwks1/P+TYR1MJxqDltOArHRQaLBX8TS/8vVFRItBeBdjfx5MQr0Jcxx+QJvM1Wj5d8vmLZrFytwu6nYVCVduWC/QE+VH9+sR4W8yFdUKbLI7KvVKUNeUvi/3fFL4RmXRI0+Z1nw/Luby8TKrV7HWlWvpdLCUtvupDZIFwXpNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4XFtBMa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0767C433F1;
	Fri, 19 Jan 2024 07:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705651052;
	bh=9UoP3WAV0HOIOYzSjVcxPb/Advh/Go4bggp68Bk23so=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4XFtBMaHE6f0ojR/EtSUrDoEmsE4c9t8vWfDtecKnlVSt0TKUCXU+0jNEnTX8DZr
	 bRNIvsEOmUoXZPwvFGL2wXG3y052GuIIOYhdgg5fzrMoHvAw598rUULJSoAd30CZTd
	 i6Lkg5fu5Sk9EwQgqoqYsmnGsqXX1J2isQAOT8Zh9igJDdZm9wPxNOb+bQqDWXNXjq
	 LmAx0LBLrodnSGnoDHWevTt3sohZlCLHjGik5FRLtlB/t5nhF137S7LOrf/bJdlDHK
	 wmczgEOS5WUYCMtWcH4CIjBV+hlvGmMAEUrn8BaAbC/sBs/sdbXUHD8p8TXZ0m9jxc
	 xZoSzVFAcMxaQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjkz-0004Xz-1Z;
	Fri, 19 Jan 2024 08:57:41 +0100
Date: Fri, 19 Jan 2024 08:57:41 +0100
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Message-ID: <Zaordb030PebNR8h@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-3-johan+linaro@kernel.org>
 <dc33e198-e202-4287-960b-7826fb0b455c@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RhFKLX4iJBkji7y1"
Content-Disposition: inline
In-Reply-To: <dc33e198-e202-4287-960b-7826fb0b455c@sirena.org.uk>


--RhFKLX4iJBkji7y1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:21:48PM +0000, Mark Brown wrote:
> On Thu, Jan 18, 2024 at 05:58:08PM +0100, Johan Hovold wrote:
> > The default PA gain is set to a pretty high level of 15 dB. Initialise
> > the register to the minimum -3 dB level instead.
> >=20
> > This is specifically needed to allow machine drivers to use the lowest
> > level as a volume limit.
>=20
> > @@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] =3D {
> >  	{ WSA883X_WAVG_PER_6_7, 0x88 },
> >  	{ WSA883X_WAVG_STA, 0x00 },
> >  	{ WSA883X_DRE_CTL_0, 0x70 },
> > -	{ WSA883X_DRE_CTL_1, 0x08 },
> > +	{ WSA883X_DRE_CTL_1, 0x1e },
>=20
> This is broken, the register defaults provided to regmap need to
> correspond to whatever the hardware default is since for example a
> register cache sync will not write back any default values (as they
> should already be there in the hardware).  Anything like this would need
> to be done by writes during init.

Bah, thanks for catching that. For some reason this was enough to have
the driver initialise the register at boot at least. I'll set it
explicitly at probe instead.

Johan

--RhFKLX4iJBkji7y1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQQHbPq+cpGvN/peuzMLxc3C7H1lCAUCZaorcQAKCRALxc3C7H1l
CCbxAQC8arUlAl4+X7yMII2POu5dbvbL0CDcGhl8McRSrvN5rwEAhetPqtxYPMgE
WbDj4UoXmv5R/OuECqddhpj0oTehDQM=
=dVhB
-----END PGP SIGNATURE-----

--RhFKLX4iJBkji7y1--

