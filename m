Return-Path: <linux-kernel+bounces-123408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80471890825
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A559299A43
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00182136E13;
	Thu, 28 Mar 2024 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IGxdZp5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCB980616;
	Thu, 28 Mar 2024 18:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711649919; cv=none; b=UnubdDozoIBrkcmN0RFWilO7WjES0rWuI0/Ihz4yruMQPtgMLHiyZmyFAZNOiaG8CEGRsHDanhPe+93EEwnK0orGL8bgHVJOWbsTM3KEAFoQBTUuZBWz2DHC3L3E8sGfidtFZoIvwjinWbyenfMY7Lke9+59kxkhFnGf3/SRd9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711649919; c=relaxed/simple;
	bh=dugE1eN9SjKMTZCoMkJW/qGHVXdybbUNuNFGgoJU4bQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CUHxrB/0EkbP5WrE4JTNs7iYj9Ynia0o6FeZYh0JUgcFSlbFR2AKgvMeF1Pd7Ikcv6NhRhh7kWBYOn2MYYm7nJ9XYhgRp5XCAUwwzpYnaLjf674Y2qFH1lCBL8scLkEgL3hBbp/IOUyrVobPkJ2SA87evBYqJabQm9xrOaaKicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IGxdZp5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049E5C433C7;
	Thu, 28 Mar 2024 18:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711649918;
	bh=dugE1eN9SjKMTZCoMkJW/qGHVXdybbUNuNFGgoJU4bQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IGxdZp5hQd8bVeR0C8gY2+N9lAaxmWJmB92LbW2FMeJBOQyDRV9rMHjIkg1DQ9/q2
	 wnBZCeuO+zJh5pKAdf1xxwNAX8EO86qJTzCfwGZ4r/hUq9YCI10gPilJC7dvaRtt4W
	 SlHkzpGIYNgtrxkV4IxR2RAVHUciHqM/dDCEG8nfur8P9zBXpHOKTvM8OO6f8G0Bcr
	 jxwf7MWr9iCKEdh8K7yLc05jfYF7f2bPFBSu4l4OWb/caZlXPvGI1JG11ymC7snLfg
	 NTw3zLzxtzrPzWiF3HorH1LWd1Zeun7z7WD80H6S5nlKvTXu4kwXX2N8Z5Ncyj31Il
	 W+mFoZ9tmdDtw==
Date: Thu, 28 Mar 2024 18:18:32 +0000
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
Message-ID: <043b347b-2652-4ffb-a8e0-954a89899ade@sirena.org.uk>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
 <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
 <ZgWw66OpLnLPdCn-@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cUF0P50pg6+6H6Lf"
Content-Disposition: inline
In-Reply-To: <ZgWw66OpLnLPdCn-@google.com>
X-Cookie: Yes, but which self do you want to be?


--cUF0P50pg6+6H6Lf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 28, 2024 at 11:03:23AM -0700, Dmitry Torokhov wrote:

> So because we decided that we could not have devm_regulator_enable()
> because of (IMO) contrived example of someone totally mixing up the devm
> and non-devm APIs we now have to make more and more devm- variants
> simply because we do not have access to the regulator structure with
> devm_regulator_get_enable() and so all normal APIs are not available.

I don't follow what you're saying here?  What normal APIs are not
available?  AFAICT this has nothing to do with a devm enable, it's a
combined operation which reports the voltage for the regulator if one is
available which would still be being added even if it used a devm
enable.

> This is quite bad honestly. Mark, could we please reverse this
> shortsighted decision and have normal devm_regulator_enable() operating
> on a regulator?

Nothing has changed here.

--cUF0P50pg6+6H6Lf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYFtHcACgkQJNaLcl1U
h9B0aQf9GhSPMJsemBBQsnirWqzi3QaGUE29Rt78hmG7hRYC5m9vngooWRxd8hO5
n0JQPednZleR4Sv9xLb6kXcNskt+l4KyvRc7wL1xJ2M1CjTshtxSEscQs22KTbag
wvoakMhfgWdqb+Rz9KI2XnTEUJHB5ZrKh1iygy656jIu2+RiRN94upSZWv09gtKT
zW0jUaUPKe6gO/wod5bKYVhbmPYEyOZ7Ya8ZvuZNQoYUqbii4oYBpb1EAT27p8u2
3k2eKUYu64XwASkizaqo6Vn0xu2LTBtaUg9tYYyCyhD0V9Suju3H41F42PgLfrWo
Q55X+JAPty/mqfVn+05geMu2OBjk9g==
=9vNv
-----END PGP SIGNATURE-----

--cUF0P50pg6+6H6Lf--

