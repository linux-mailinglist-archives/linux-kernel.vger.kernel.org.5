Return-Path: <linux-kernel+bounces-119678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D2488CBE7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 517A21C63132
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B98627A;
	Tue, 26 Mar 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGPxhg/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3611CD30;
	Tue, 26 Mar 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711477313; cv=none; b=R4otSdMt6JlAYhtnH79il+FWCrWGE+OfYXUJlqGM2/uwSvBXJ7XUzmZea09wH8+xtNhyGoQr7J8lvUzxEpHgz8V8haHsrQWprY2a1B1Lbd4lX1vRM+AvUSXJ4Vh7wYVPjqZSTa8nUi+xCFPblSvo6uH7UsEIT6urjoEtZQAuA04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711477313; c=relaxed/simple;
	bh=lJ+IUfOwn4NhdHDBYv9nWOsVPrGCCpK7ME9YFAC1r5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MQuY8zrMwPBk1qf1a37zYtD8PWjvIOGd0KY2hkZ7FbJvatbbKrCa30mwu9EeUX2Kurh0BkGGp/FwHm5u6NhyR8x6GcNjzSmBiHnMNvIg9S8tGllTi/xIg13cdZokLKgw4zqZLTCz9rAO1zWemq3ZPn8ei8Ka3qMWyU4Mv8ziHjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGPxhg/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CD3C433F1;
	Tue, 26 Mar 2024 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711477313;
	bh=lJ+IUfOwn4NhdHDBYv9nWOsVPrGCCpK7ME9YFAC1r5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JGPxhg/7JE7oQ9dRozL1UCTuaF3J+DNSoOKCYwW9IYmXYGPw7Q/EF1dW6R6Z/GaP7
	 RYIpW8+qcnE1VL1jCZXLWlOAyU5HjCn4F+7hZD15h465FGH+Lq9K5CnzqVcsZmf4pe
	 O1++/iuyBhdbyMPzn6Oyt1OusPw0U9v7sZ/98EIAQU+MXsAEsYtUC61LnUu3zA4Ogs
	 EsioUBj1rbbn4GviACdJ7DvSy8Q9rvbmkKMg2R6uEBbYaC2wM6csVf4kDEtt7cKFSj
	 aKlIvoggcW7/jtEoGUTpNUoBK9y1U9X9Ri8xattbOtegUocoVOq6BC5mN9dGw0BUJx
	 0IS1TIxiy1Q5w==
Date: Tue, 26 Mar 2024 18:21:48 +0000
From: Mark Brown <broonie@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v1 07/10] spi: pxa2xx: Provide num-cs for Sharp PDAs via
 device properties
Message-ID: <dcdf8c46-acdc-466d-afc6-caf0e0fa39e8@sirena.org.uk>
References: <20240326181027.1418989-1-andriy.shevchenko@linux.intel.com>
 <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dT3ocvKbX4se54Pa"
Content-Disposition: inline
In-Reply-To: <20240326181027.1418989-8-andriy.shevchenko@linux.intel.com>
X-Cookie: Equal bytes for women.


--dT3ocvKbX4se54Pa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 26, 2024 at 08:07:57PM +0200, Andy Shevchenko wrote:

> Since driver can parse num-cs device property, replace platform data
> with this new approach.

But why?

> -static struct pxa2xx_spi_controller spitz_spi_info = {
> -	.num_chipselect	= 3,
> -};

> +static const struct property_entry spitz_spi_properties[] = {
> +	PROPERTY_ENTRY_U32("num-cs", 3),
> +	{ }
> +};

This is just platform data with less validation AFAICT.

--dT3ocvKbX4se54Pa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYDEjwACgkQJNaLcl1U
h9CaWwgAg5f0rv0N9O0lAWqwNTH9DWejVFHVW/PB4VGt7qBhGQvKiUMAl01Ew2yS
0a66qPvipQrZ1vIVzO/hc2xR32F9fwfk5caN9xdEow53lBEHJbOlxfzpqYlqzvnd
2kGSfghq+l510+vIrUyl0wmkWavQpsdrBKbM7LuB4mQQZtTCTqczpjBJOP+oLaBh
00df2gQgdqYbWi/SoFY1CEDgRqtF7Ya1maWPpe+9R6uHj3ng4ALxSFJK9mY10kUs
JEtDg4xUifej9VrdzJ/mwapqjVl+DhprAnq5XYnoHsTGp91neGtB60UZw1aGD3YO
5OEWtalDQfPJhH3ah8eNR9EY2hiuvg==
=Wz9n
-----END PGP SIGNATURE-----

--dT3ocvKbX4se54Pa--

