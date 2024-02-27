Return-Path: <linux-kernel+bounces-83259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A138690E8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C7371C263D2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B51D13A883;
	Tue, 27 Feb 2024 12:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTJHD0ws"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771E135A5C;
	Tue, 27 Feb 2024 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038221; cv=none; b=h8Ua3nQW90vSp3DtW5k9C1Qx+JgsCJPDzekcTOUP+xrfD32Q+DiQV43j6Vcur0VHOj4wzQMCLpJGswjpvNfOcUXaiMcDhUwgCFxBn7sa95yb31vI9901DLzr25cQxf+MQpmuiLDYpc5ld0vDoun8uFaE8wVi0TnE58kXX+krXiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038221; c=relaxed/simple;
	bh=Zhxbx7duNjFtsU8C8YK99MgZoIQeeL7kpOUt9GKMLUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDDug46XAyL+1dQEmt+dd/oXKP0lvQHHKSWXrO9r/lLnZlkCoDLMJNXyZejO8jvj0yfizvze+v4njAdwrmt8wn0v2PdgX46OQ6+9x+wL6JAnVL9EBFtpy3hB5Kso0QbMJr2kNtIABivhsIDOPOm8ggQ7FkGKrKA3EPI5FDxa6RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTJHD0ws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D52C433F1;
	Tue, 27 Feb 2024 12:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709038220;
	bh=Zhxbx7duNjFtsU8C8YK99MgZoIQeeL7kpOUt9GKMLUU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTJHD0wsAgcoIW/uHXp3nQWXqI7GNzvWN9H7kkAqR8VCUu3R4Pug5eDEq5QG+kZEB
	 3aPG/VmwraVimyWx8OLVHIauqiE6MNRfl35Ct0/XllAMO1tn9QX6R142vXh12R6aFi
	 Hy/UA7LgeRKFxY0Bh6IHu8rjqCUZc0KJlDsJA45ABFAjeKDJlZYIeqEO4FiSZTKEx/
	 EyVrqP1hiX6+SiAiXUp3X0utDO4mOwl/f53YZ5HLOFEz7JoMHMeoQaGbeD070oo+S8
	 gam/Oxmiqeob57QSBySQtr6nKh28Gsv9Q3GPWKmO1HeMik/7gSi8/9vXagzA2Di2IX
	 Qr3Nf+TgRhB2Q==
Date: Tue, 27 Feb 2024 12:50:15 +0000
From: Mark Brown <broonie@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, kernel test robot <lkp@intel.com>,
	Stephen Warren <swarren@wwwdotorg.org>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	H Hartley Sweeten <hsweeten@visionengravers.com>,
	kernel@pengutronix.de,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/3] spi: ppc4xx: Fix fallout from rename in struct
 spi_bitbang
Message-ID: <76fcc5ec-0180-4f75-aaac-5ae74f2f687a@sirena.org.uk>
References: <20240210164006.208149-5-u.kleine-koenig@pengutronix.de>
 <20240210164006.208149-7-u.kleine-koenig@pengutronix.de>
 <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3Lb+SU4G2F3AXgps"
Content-Disposition: inline
In-Reply-To: <y2my7hxrpnwg72ols6a5w7n6zqz2yaxtswq4zlv6xpguiyaunm@tguc7ua3ypa5>
X-Cookie: Please go away.


--3Lb+SU4G2F3AXgps
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 08:23:06AM +0100, Uwe Kleine-K=F6nig wrote:

> Assuming we don't want to have this problem in v6.8, I suggest to revert
> de4af897ddf2 and reapply it on top of your next branch.

BTW the issue here is that you sent this without comment in the middle
of a series of fixes the other two of which *do* apply to mainline,
ideally it would have just been sent separately since it needs to go
separately but if you *are* going to send a single series like this
things that are -next only should go after any fixes that are for
mainline.  My automation does look at where fixes are targeted this
catches it out.

--3Lb+SU4G2F3AXgps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXd2ocACgkQJNaLcl1U
h9AZKgf/ZrkCzZjo1DZFBjTWSNJ7yhirrWXmutciLFiJnkfbMEtL9WjnGGYPMRvp
R4hebOsiHDlKj4sp8uecP34jCzEoiENNp0jwCTWiijlP/OANnSwFTdR1Y2Q6LdB9
DKejbC+lFAsSSkTSVVSSBay2bwhOnjUPGt3fh7THxcKR5m97nzw1m29SXHdsWdfj
JAbHjMwdxwOt4sKiIWaazNhTJiaDnDPWbfEgmGA95kPosTg1fUgE7UKh2N1v8fz2
/VaIRsG4QEiZnrywnb0gXkknozuUQndaEQEl5XU7vtyu0Imyr68QPNodoGx+6ljG
mR7uxcDgBbF9iDdYPqeDK3kZBZLSTg==
=sreQ
-----END PGP SIGNATURE-----

--3Lb+SU4G2F3AXgps--

