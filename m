Return-Path: <linux-kernel+bounces-46548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FCB844135
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA5261F27671
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18BB881AA5;
	Wed, 31 Jan 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q6039tBd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827380BFC;
	Wed, 31 Jan 2024 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709594; cv=none; b=RsG3n0mqIMp/dTtwW2PHkLLi5rBKlJgdsfk3k2BaIWmFjRshSBYrpzMHME8UygUdpc1o2AgORwfDjBNFBnWfflYr9rO6i2SxLurnZQltSD01g+/+dcOTzy2elu63gecUarR8NXfOJQceyhPXYNy/6jEFReliEyar8fZKhx5yprI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709594; c=relaxed/simple;
	bh=kx7++Nl+g8gUP4P8BUkEMWIMMN6PTKxchtxN+CPVmLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fY6zbtKWwmAnDHqUDojE5iIt/zaL8BkYYB+Rb7h7p9n/dZTGpnCkw3lk+1G0ZSccy8UXx7Rui/am3bJ5J632kAo8G4vMOmU/Z80YY1QubL5t1XWrR1UlFnV/7Hniui2qf2y6b/0qkpYyEuoPsWAzhTrDgf0Gh3TB0NWU/mlSdbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q6039tBd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AE4C433F1;
	Wed, 31 Jan 2024 13:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706709593;
	bh=kx7++Nl+g8gUP4P8BUkEMWIMMN6PTKxchtxN+CPVmLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q6039tBd6g6aaJ08HMT328HRmGQ9/vDdtmfqgRCXxQae1xNri1Php+xPYYolOYXO2
	 jQ4rYZ626C0Eie0xX/22fJCSp75S7+YumvXSITEt2RXClBqXjVqGbPTas2PiIg4cr6
	 dhYqZP3xXnKjvnC+oSdKuzDFhvBEXZxQejtNbN36vChso2CXRwSqEBa9d8xn22ngjo
	 jbgR6foNn4IeIdsd0qqCXgf1X3AwGl3Otrpk2/3ofgUQKye7lym1S66RUqkGx4ZxtM
	 BAndsyZ1MsY12LGTmckU1x67wBdBjxp9YSwuQStPGxEXudQG5P+1UgvkyMU9VP6wR3
	 zEs1DYzSNuIag==
Date: Wed, 31 Jan 2024 13:59:45 +0000
From: Mark Brown <broonie@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	Chris Packham <chris.packham@alliedtelesis.co.nz>,
	Sean Anderson <sean.anderson@seco.com>
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
Message-ID: <e693398e-fb18-43c3-83dd-4b517c29fafd@sirena.org.uk>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
 <CACRpkdYf4HUaV-Pjr81WjLbzy9zdAnyFWs9gPayPC6-3OjHQwA@mail.gmail.com>
 <CAMRc=Mc1SGLeUOWmKg=fvCdM+RR6FSu2QkFuR17s7L99eRMGug@mail.gmail.com>
 <CACRpkdbaxqTzwL9L02vCpMMdBYsubNP1VkNuJ8mXB_=4E3Kjaw@mail.gmail.com>
 <5ef64082-0b44-4bb2-bd4c-654c96f4a9bb@linaro.org>
 <CACRpkdYa0nj6PK1FecBpQfOfkXhetwRmAyDgWNjJxcf4xgExMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aUBo2xsR6S0y35Fl"
Content-Disposition: inline
In-Reply-To: <CACRpkdYa0nj6PK1FecBpQfOfkXhetwRmAyDgWNjJxcf4xgExMA@mail.gmail.com>
X-Cookie: I will never lie to you.


--aUBo2xsR6S0y35Fl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 31, 2024 at 02:42:17PM +0100, Linus Walleij wrote:

> I guess it may be an issue that regulators are not using Device Tree
> exclusively, but also has to deal with a slew of platform_devices:s :/
> IIRC that was one of the reasons why it looks as it does.

Also ACPI, and this is a long standing binding so we can't change the
ABI for DT.  We could potentially use a refcounting mechanism provided
by the GPIO core but we'd need to know when the refcount changes from 0
to 1 and back, we need to take other actions (inserting delays and
generating notifications) when it does so I'm not sure how exciting it
is to factor out the refcount.  I think part of the decision making with
the current design was that there was likely going to need to be some
higher level stuff like that in the users so it wasn't clear that trying
to abstract the reference count away in gpiolib was buying us much.

--aUBo2xsR6S0y35Fl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmW6UlEACgkQJNaLcl1U
h9A+fwf/Uk2jUjqxQFPM7xcqmHsrA9v2ugLGTMHO8Maq0EYtg3qC8iqG/GpGJUfs
fFgiBMZMuFYRWuVZrFqaDVfH2SjrzVuTwRnzdcc248yp4VxcIw+/6zv7MN5I7+Mz
drrk+SOW8LQ1/zFdYFCZJ6nTpNpz3gbw6dfYHSsOsXwKXw1uXrjVpsr883NKtWhR
T7booZIhNa/o4N0KWRG6F3uJtDXp6adazB05Ub4s1FU3bNdajYiU/bXbG2hp01Me
YNMz64ezvnOBwrVEtGF/CzVUjFy3AesEUbq/RASerWiFsB0OatwnMeNG3/Fn/mLU
Qna+Cm3/fdqDG1oWpox48rOY47Hy0A==
=3gvm
-----END PGP SIGNATURE-----

--aUBo2xsR6S0y35Fl--

