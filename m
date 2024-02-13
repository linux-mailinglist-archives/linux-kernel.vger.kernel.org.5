Return-Path: <linux-kernel+bounces-64123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 840C4853A4E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:55:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADE541C22970
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB281119A;
	Tue, 13 Feb 2024 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b79rEpbe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB010A1A;
	Tue, 13 Feb 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707850506; cv=none; b=QIwX63nFdJS2cbQ1gOSXQpOwY/OJHnJNdUTV81kzd5ZOMMHHG/2N1DyLxya14POiKICTlS43HwG/+6sp1RO+M3IJ/7EUC/s+7mihthOL+AKo4nwlXL4GDHzwYRHi2AZVcctu2Yvio0uqb5MKC4d7fCleuuEKbbjdUo35T/HPl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707850506; c=relaxed/simple;
	bh=BB95l+0BhbUBCzSMMBSz+FS9RLul9PCTuuXwE/NiX3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdFpkl6nU43XH8wIzZyaOsbPQK4BJ6KqAbUo9x8cAHM1lqm0v/2wY2+UZNEclMmmcUK5Ji/4oKRcJ6xikcFDn3+3vABf405GtelCbDoiBJyI/MYw81N1ZIrFyHLqVTGhltEnLOvms7HjfS+5tUI8ZhwLzhtHYIjUnigxjGwIMJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b79rEpbe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB2BC43390;
	Tue, 13 Feb 2024 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707850505;
	bh=BB95l+0BhbUBCzSMMBSz+FS9RLul9PCTuuXwE/NiX3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b79rEpbeOnYlLR6qA2l55tXC7SrxWaQWIlUtg/o6nJVbazaXfqA4k2C+Gbm1WjeeX
	 0vxrS83UYCoYt79EDTAawzhwkfHJ1nF5L5pfRAuE3dF5QFYILTet9Zwcn0906ZdMT7
	 c5zojMTKjMdv/mJh3gSooWOKFtQ+nQtcrmNhWCxW0YmhQ7DJ1QLDmEJUkPBtBkqI/b
	 BeAPLjeV2MCb1Sho/JBcPUVBCIczdKbh6Kb2kG9fTtFxtrapLEbRK3gzxmvAzG0OpA
	 lqwuUV4DBh8cTqdDOYoJqeySd4VjzljqPLRd5RWbh/djjJzGk+4U/M4cQJ4xJ8Tsjm
	 /D0jQE0bW29dg==
Date: Tue, 13 Feb 2024 18:55:00 +0000
From: Mark Brown <broonie@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Martin Sperl <kernel@martin.sperl.org>,
	David Jander <david@protonic.nl>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] spi: add spi_optimize_message() APIs
Message-ID: <54623b74-872a-41dc-992f-71a586d145ec@sirena.org.uk>
References: <20240212-mainline-spi-precook-message-v1-0-a2373cd72d36@baylibre.com>
 <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1x94l0akyl18zoOC"
Content-Disposition: inline
In-Reply-To: <20240212-mainline-spi-precook-message-v1-1-a2373cd72d36@baylibre.com>
X-Cookie: Does not include installation.


--1x94l0akyl18zoOC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 12, 2024 at 05:26:41PM -0600, David Lechner wrote:

> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.

This looks basically fine.  Some small comments:

> +/**
> + * __spi_unoptimize_message - shared implementation of spi_unoptimize_message()
> + *                            and spi_maybe_unoptimize_message()
> + * @msg: the message to unoptimize

There's no need for kerneldoc for internal only functions and it can
make the generated documentation a bit confusing for users.  Just skip
the /** for /*.

> +static int __spi_optimize_message(struct spi_device *spi,
> +				  struct spi_message *msg,
> +				  bool pre_optimized)
> +{
> +	struct spi_controller *ctlr = spi->controller;
> +	int ret;
> +
> +	ret = __spi_validate(spi, msg);
> +	if (ret)
> +		return ret;
> +
> +	if (ctlr->optimize_message) {
> +		ret = ctlr->optimize_message(msg);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	msg->pre_optimized = pre_optimized;

It would probably be clearer to name the parameter pre_optimising rather
than pre_optimized, as it is the logic is a bit confusing.  Either that
or some comments.  A similar issue applies on the cleanup path.

--1x94l0akyl18zoOC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXLuwMACgkQJNaLcl1U
h9Bnrgf/WeeHvY6OP79eR9psCOmCmEFE7LyYK3KbHMD6KHn9UrE1fMVqnbazXiT+
/ALDeTCkov7jcu1uUMZZuSVyfv+JpM71kKEZ0L2p/Mbn6qwWfriempoqr7Jh9RiQ
m8IH2XIEfX3/rWvRFdxK4H3i//gqVwEaf3Tf9pyBPosblP5bim2GT3h0ci0h5D+S
zC7VK+2Zbb+S5x1uqH07Cq/ApUwUYXsIDur5pK6r0MkHjJCkq+5v0aRUUdMSx4PC
naHKWpPHFqI4IhzU6UrpGUcOQ6Pfq/WNZ2kdm7+bjKJXDZdxkkGQ5sZbhvlUEkoM
Xxvql0q/x39T42ahhk5bHCFqIhb2HA==
=lAcK
-----END PGP SIGNATURE-----

--1x94l0akyl18zoOC--

