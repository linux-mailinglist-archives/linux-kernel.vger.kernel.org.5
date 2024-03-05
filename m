Return-Path: <linux-kernel+bounces-92852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D278726EF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A309280DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCAB241E3;
	Tue,  5 Mar 2024 18:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzEPdCR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76941B941;
	Tue,  5 Mar 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709664612; cv=none; b=EaDg43LeESgqRWcUfGyfV4yey0+ikN+pggcFOpWEy11LvoSOUUJArWMqnMXB1pBLTiQzAt3L3GEww33uUFNDfeH1K5aALeaRjcOWvNpsV8eLCf9nVspmzhUQpR0z5pILx6ZWdtUMz43khsJkB0IzLx8b5Rk4qru9e4tYX6MhsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709664612; c=relaxed/simple;
	bh=XL5H6KmpvDKvfts2T0NXkQAv47JL4s7T4aIStdM12X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gx6pE0dvFzikdSVZnMgJfbI83j6tEfyTaAZa2lAljjWmNR9mBGUovbp7hwEnLGkJ/sZc/yUFHQwlCF3AIbpQhOKYYKEf4bBrYxQIOTO3lfS8yAV1pkUCU72ob7Rvn8qlb6Rqq4VakpK0DnRyd3kXKLo+5wVfoJiss3Aib1xvSnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CzEPdCR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA236C433F1;
	Tue,  5 Mar 2024 18:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709664611;
	bh=XL5H6KmpvDKvfts2T0NXkQAv47JL4s7T4aIStdM12X4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CzEPdCR/2ZColCwlH9ot/gHtgJJYgLPLTXvoBxwcLk3s39JE/SBZ4WeSoeL1+T2Dm
	 mSTxIXeB81vAOUvOcyI5eOzf1vji9OtaE8yHmI4qH4rX+9klsjtJVtc4GOPrtxgTma
	 tT1QCnf1ArnEnjzgXr/M6PLTQK9AFOZo4eN6O18SHpZfndCgR2hRZ7VMTdJj2QFTli
	 qusJjJBM5/q6A401QwhMo/3jcmBt5lNQ1u6hWyt2YEJ+LJeNWrwtJ3ozF0eKP1ggph
	 aNLE9OThrlwCFa19P6W7hKr416ZGDDkVL+rbhwCDct1HNS9Yn6xeoMLJkTCE3dnzH2
	 ZoCPzPEvbGX2A==
Date: Tue, 5 Mar 2024 18:50:04 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Frank Rowand <frowand.list@gmail.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>, linux-spi@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Jander <david@protonic.nl>
Subject: Re: [PATCH 01/13] spi: add core support for controllers with offload
 capabilities
Message-ID: <4e59b95c-42c9-4eaa-bbf0-7e8f4b389838@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
 <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
 <CAMknhBHP+x4e0kTmNTn6JNKv=VCosZhBWce1MjjFW4MZ+K2Hcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GnTxEOMUVi8UqiSw"
Content-Disposition: inline
In-Reply-To: <CAMknhBHP+x4e0kTmNTn6JNKv=VCosZhBWce1MjjFW4MZ+K2Hcg@mail.gmail.com>
X-Cookie: Ahead warp factor one, Mr. Sulu.


--GnTxEOMUVi8UqiSw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 05:21:21PM -0600, David Lechner wrote:
> On Wed, Jan 10, 2024 at 3:36=E2=80=AFPM Mark Brown <broonie@kernel.org> w=
rote:

> > The bit where messages are initiated by hardware is a step beyond that,
> > I think we need a bit more API for connecting up the triggers and we
> > also need to have something handling what happens with normal operation
> > of the device while these triggers are enabled.  I think it could be
> > useful to split this bit out since there's a lot more to work out there
> > in terms of interfaces.

> > > +/**
> > > + * SPI_OFFLOAD_RX - placeholder for indicating read transfers for of=
floads
> > > + *
> > > + * Assign xfer->rx_buf to this value for any read transfer passed to
> > > + * spi_offload_prepare(). This will act as a flag to indicate to the=
 offload
> > > + * that it should do something with the data read during this transf=
er. What
> > > + * that something can be is determined by the specific hardware, e.g=
=2E it could
> > > + * be piped to DMA or a DSP, etc.
> > > + */
> > > +#define SPI_OFFLOAD_RX_SENTINEL ((void *)1)

> > This feels like something where there are likely to be multiple options
> > and we need configurability.  I'd also expect to see a similar transmit
> > option.

> Having something similar for TX makes sense. What other sorts of
> options are you envisioning here?

You list two options for something that could be done with the data
above - sending it to DMA or a DSP.  My concern here is that a given
piece of hardware might support more than one option and need to choose
between them.

> > > +int spi_offload_prepare(struct spi_offload *offload, struct spi_devi=
ce *spi,
> > > +                       struct spi_transfer *xfers, unsigned int num_=
xfers)

> > I would expect us to just generically prepare a message, then pass a
> > prepared message into the API that enables a trigger.  We would need
> > something that handles the difference between potentially offloading for
> > better performance and having a hardware trigger, I think that might be
> > a case of just not exposing the engine's prepare to client drivers and
> > then having the core track if it needs to do that when enabling a
> > hardware trigger.

> Not exposing the offload prepare to client drivers sounds reasonable.
> I'm not sure I understand the potential need for an offload without a
> hardware trigger though.

Something like pre-cooking the commands to read the interrupt status
registers from a device, send a network transfer, or to download
firmware and settings if you power the device off frequently.  Basically
anything with more than one operation that you might want to run
repeatedly and care about the performance of.

> > I'm not seeing anything in this API that provides a mechanism for
> > configuring what triggers things to start, even in the case where things
> > are triggered by hardware rather than initiated by software I'd expect
> > to see hardware with runtime configurability.  The binding is a bit
> > unclear but it seems to be expecting this to be statically configured in
> > hardware and that there will be a 1:1 mapping between triggers and
> > scripts that can be configured, if nothing else I would expect that
> > there will be hardware with more possible triggers than scripts.

> For the use case of ADCs/DACs we would want a periodic trigger where
> the period of the trigger is runtime configurable (via sysfs). Is this
> the sort of thing you had in mind here? What other sorts of triggers
> do you have in mind?

Well, it could be pretty much any signal - I'd imagine there will be
things that can trigger off GPIOs for example.  Some sort of timer like
you mention does sound plausible too.  I think the API needs to be
general enough to just cope with a very broad range of things in a
possibly system/device specified manner and not have a short,
prescriptive list.

> > I'd also expect some treatement of what happens with the standard SPI
> > API while something is enabled.

> I suppose it makes sense to return -EBUSY from
> spi_sync()/spi_async()/spi_bus_lock() when a hardware trigger is
> enabled.

That sounds reasonable.  If something is software triggered then I'd
expect to integrate with the current queuing mechanism.

--GnTxEOMUVi8UqiSw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXnaVwACgkQJNaLcl1U
h9CgRAf/XZpBOT1fPXVIMGKoXEqg7MIZ98UQNFClW/aptrHDCFDaASJFmbxDXVko
oyIVtoaDAGccge+mohtrwd3BEvSuHjMwixWV3knqKsLI9l7rvpttH9FIUa8oI4KV
mI1dL9CmcpXGMffBu11rx4URnJsabfX/yVV3gPIjJJi8Hd8C25mChVIKEFgCRcFR
cZf1kAlY6n34kL3WG52o2NHllvyEPczLJ/f6B6C8YcBiGjI//JDWdtk8VV4d/gJ8
0TG0JlJ6YqVrvILKHbCL4KDG24/ai10eT09wuSNMAbyOmrhkrstNLEq7qVuXaUgb
lV7D2ruJv9CsRxZJox9v0CC8pyTkIQ==
=ls36
-----END PGP SIGNATURE-----

--GnTxEOMUVi8UqiSw--

