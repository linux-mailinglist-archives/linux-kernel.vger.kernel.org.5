Return-Path: <linux-kernel+bounces-81533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA6D86772F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A23D1F278E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E285812B163;
	Mon, 26 Feb 2024 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rutwcfwO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258C912AAEA;
	Mon, 26 Feb 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955287; cv=none; b=XsyvzOgo56twMHmqqP7UYwT/LGuAKuRUsdG75jH/NXJyjVE3nVIC8GfGLTIjwwXc28K93MgqMyjSagCmIGe3A02AUPz72wt1qYC+DI7ZnWCS7xFduO7o9xgNswUbnVGu67jvNyWi6WOZDSfcW3ZrOOXgBIMQ54I7aoJ5U4M/plg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955287; c=relaxed/simple;
	bh=L67kHgGCs3Cvh/Ei0DU5lrJ2B7SBYL1CCN3r0aBSxi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0ZANzpe/QpX96eXSAgzCOxvhuLLk87qAaMCDAo/qpnRO8F4FEGaqTCNxfWXIRdcSzjgq/rIDQUcyV6Vfovhof2J+OtaIU5JR2Lp+6p5xXKtsj/SaWjDV6Ck0aSl2+ujkqFq0X0oHVR/o9tbZT04oDWdHHElXwCVkQrOlRnqIec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rutwcfwO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5260FC433C7;
	Mon, 26 Feb 2024 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708955286;
	bh=L67kHgGCs3Cvh/Ei0DU5lrJ2B7SBYL1CCN3r0aBSxi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rutwcfwO+1mZuPVh6Ci4AcY7Ya4wOx1sky29F46LrI2lonSlcnrvFy9RjBONyMTwA
	 k9va0k3b3hBTuoGx/ddvBD3XrePARb3WpZ56M+/YCXPxxQarwpfu/UBwfFU/pUj+RN
	 Uc6barYERG9ipNDYsIp1+Fe/9erC3pLShGA+SyQNP88OYU5XtnMBJXcgRRfZY12fzE
	 2P3Nur+CTXqYaRgZkNegjaYduiK59Y/Zqgpup2hnN452xKB2281z8LC2Ko0BmhzNZp
	 vrPjbNjMSuXsKrs1H9/yft788udGXbcCLd3MBBmdMZvONR4Zg9RzBC/CGbCGsH6K59
	 UgHUa1KFYjrDQ==
Date: Mon, 26 Feb 2024 13:48:00 +0000
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
Subject: Re: [PATCH v2 1/5] spi: add spi_optimize_message() APIs
Message-ID: <4a593988-52bb-4013-84fb-d1a51c8005c3@sirena.org.uk>
References: <20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
 <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FPOaDaMVfIrc5CmE"
Content-Disposition: inline
In-Reply-To: <20240219-mainline-spi-precook-message-v2-1-4a762c6701b9@baylibre.com>
X-Cookie: Nobody knows the trouble I've been.


--FPOaDaMVfIrc5CmE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 19, 2024 at 04:33:18PM -0600, David Lechner wrote:
> This adds a new spi_optimize_message() function that can be used to
> optimize SPI messages that are used more than once. Peripheral drivers
> that use the same message multiple times can use this API to perform SPI
> message validation and controller-specific optimizations once and then
> reuse the message while avoiding the overhead of revalidating the
> message on each spi_(a)sync() call.

This doesn't apply against current code, please check and resend.

--FPOaDaMVfIrc5CmE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXclo8ACgkQJNaLcl1U
h9DzSgf+L8IJqP9QTipdvVCKI4xrZNaK+TzwF6i23M+QYOOAK+4hq0fRRSva44uc
kkh1+iGYBYbxuQpN35y3lMkueSvMVPQgUyBSe2q9SOVzykwxfrvIZKwv5I9eULi7
itkQUHeceYVLOoH2nD5dKIA7Jd/p9W5z3tC6yh/xqXwFuldwT9+Y7eqM8SUISwXW
d36mL+h1mj+ZerR70EsYYipUH0J8r/dJ035AeZRkWXV5YGicaHna9WJBT8hN5H5v
73vjAsnxohg1/wS6B7KvfXg6NekWfTWcde7eWkgkaJqgz4eKzNgUgBDUdhfGRXNa
4G15gBS0jIs/UHLyXcbalpTOdzH4Uw==
=5Wju
-----END PGP SIGNATURE-----

--FPOaDaMVfIrc5CmE--

