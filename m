Return-Path: <linux-kernel+bounces-22824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F2D82A367
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9190728962D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38E74F88C;
	Wed, 10 Jan 2024 21:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sW4/HLmX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA834F613;
	Wed, 10 Jan 2024 21:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46F5AC433C7;
	Wed, 10 Jan 2024 21:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704922576;
	bh=Y0OQKaBLQ5JiJzfQdy5F3X5JCw4QVAiGUSHR+1u5zag=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sW4/HLmXJOgLRgPQTDDSiY/2dNjsx4RaGetmX+BsqxMwWqpQMjO0QZyr0gmDlW+XF
	 BdSN3fJpX24YpLSGIXGnpchWqDcRij6WHPvxUl4LFnHPUq2sCeBk//oJGiRbB9Ply9
	 xq/UivSK4idXbtcO7gDcWyzGLlx4l2lzEdLwZ8TYLHr3QeV+Qv1GylGwfLUI9HKQT9
	 ZQqrBBBjvBowPeVEJYOE/CHqs87QeOdQaap+0qh/5Qo9Tl0PXswDGHRkpYRuTVpSLn
	 gsZNRcHyusx1jiZJiKWUQd8WpXsG7edL9SyF0e4kNDY1K9luuVejSDGFiBQiLkhTN8
	 Kxim1LkRindJA==
Date: Wed, 10 Jan 2024 21:36:08 +0000
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
Message-ID: <2c74aad9-3cb9-4222-8072-e72120c2658e@sirena.org.uk>
References: <20240109-axi-spi-engine-series-3-v1-0-e42c6a986580@baylibre.com>
 <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VZjYvgJBlQR3S4Lq"
Content-Disposition: inline
In-Reply-To: <20240109-axi-spi-engine-series-3-v1-1-e42c6a986580@baylibre.com>
X-Cookie: Do you have lysdexia?


--VZjYvgJBlQR3S4Lq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 01:49:42PM -0600, David Lechner wrote:
> This adds a feature for specialized SPI controllers that can record
> a series of SPI transfers, including tx data, cs assertions, delays,
> etc. and then play them back using a hardware trigger without CPU
> intervention.

> The intended use case for this is with the AXI SPI Engine to capture
> data from ADCs at high rates (MSPS) with a stable sample period.

> Most of the implementation is controller-specific and will be handled by
> drivers that implement the offload_ops callbacks. The API follows a
> prepare/enable pattern that should be familiar to users of the clk
> subsystem.

This is a lot to do in one go, and I think it's a bit too off on the
side and unintegrated with the core.  There's two very high level bits
here, there's the pre-cooking a message for offloading to be executed by
a hardware engine and there's the bit where that's triggered by some
hardwar event rather than by software. =20

There was a bunch of discussion of the former case with David Jander
(CCed) a while back when he was doing all the work he did on optimising
the core for uncontended uses, the thinking there was to have a
spi_prepare_message() (or similar) API that drivers could call and then
reuse the same transfer repeatedly, and even without any interface for
client drivers it's likely that we'd be able to take advantage of it in
the core for multi-transfer messages.  I'd be surprised if there weren't
wins when the message goes over the DMA copybreak size.  A much wider
range of hardware would be able to do this bit, for example David's case
was a Raspberry Pi using the DMA controller to write into the SPI
controller control registers in order to program it for multiple
transfers, bounce chip select and so on.  You could also use the
microcontroller cores that many embedded SoCs have, and even with zero
hardware support for offloading anything there's savings in the message
validation and DMA mapping.

The bit where messages are initiated by hardware is a step beyond that,
I think we need a bit more API for connecting up the triggers and we
also need to have something handling what happens with normal operation
of the device while these triggers are enabled.  I think it could be
useful to split this bit out since there's a lot more to work out there
in terms of interfaces.

> +/**
> + * SPI_OFFLOAD_RX - placeholder for indicating read transfers for offloa=
ds
> + *
> + * Assign xfer->rx_buf to this value for any read transfer passed to
> + * spi_offload_prepare(). This will act as a flag to indicate to the off=
load
> + * that it should do something with the data read during this transfer. =
What
> + * that something can be is determined by the specific hardware, e.g. it=
 could
> + * be piped to DMA or a DSP, etc.
> + */
> +#define SPI_OFFLOAD_RX_SENTINEL ((void *)1)

This feels like something where there are likely to be multiple options
and we need configurability.  I'd also expect to see a similar transmit
option.

> +int spi_offload_prepare(struct spi_offload *offload, struct spi_device *=
spi,
> +                       struct spi_transfer *xfers, unsigned int num_xfer=
s)

I would expect us to just generically prepare a message, then pass a
prepared message into the API that enables a trigger.  We would need
something that handles the difference between potentially offloading for
better performance and having a hardware trigger, I think that might be
a case of just not exposing the engine's prepare to client drivers and
then having the core track if it needs to do that when enabling a
hardware trigger.

> +	/**
> +	 * @enable: Callback to enable the offload.
> +	 */
> +	int (*enable)(struct spi_offload *offload);
> +	/**
> +	 * @disable: Callback to disable the offload.
> +	 */
> +	void (*disable)(struct spi_offload *offload);

I'm not seeing anything in this API that provides a mechanism for
configuring what triggers things to start, even in the case where things
are triggered by hardware rather than initiated by software I'd expect
to see hardware with runtime configurability.  The binding is a bit
unclear but it seems to be expecting this to be statically configured in
hardware and that there will be a 1:1 mapping between triggers and
scripts that can be configured, if nothing else I would expect that
there will be hardware with more possible triggers than scripts.

I'd also expect some treatement of what happens with the standard SPI
API while something is enabled.

--VZjYvgJBlQR3S4Lq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWfDcgACgkQJNaLcl1U
h9Dvdwf/T6QZ4Ju9SbZ0s73Zn4apG8lq8f/3vNIr//gMK094lGks0zSlD+EazE6K
H40376W3GknxOpAzIYrH28BRHtRiqcD2yiQVYf4eyh7ZBqAiRXI5dztRybzRITNh
MtkXyi6wXidGgVtSqxRMSfH8Y4cir4rYtxa2tVKpddtD5oGonoVZrkmZt5h1jqBi
ibVUjtmu60LOORqohZ3H/iVJjoywvn6guVMwmUF6MO+ptsl8BzUS8dtsDVVh1SvN
Dk0hTxX+BxavjR/8m01PGGPqVYKijrZWO34M7nqw2+hi0qKNYyVaVwoam4uZuoAN
BnYsA7FpUlwlm/2LjdiqJzquNsf0kg==
=hEUi
-----END PGP SIGNATURE-----

--VZjYvgJBlQR3S4Lq--

