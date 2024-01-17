Return-Path: <linux-kernel+bounces-29150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5C58309A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:22:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3CF3282E2C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CC210F4;
	Wed, 17 Jan 2024 15:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW9TIUFP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E510C2136A;
	Wed, 17 Jan 2024 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705504965; cv=none; b=ayF1EyXI7e3gNqt6Awsgiilf1uQL0c1YZwGTGLeKK5Nk+fvFts6kjLvSAnBwUK4hEXwBf+kBHThQ0P5o0hyg1lfKQvsUvllpoRF9LO2pH20CNg2qrA1pHrpX04AZsbO3YQqomRYIT1OG+Fnzv3xEnzSw7nhSb5oNP7Ojfhp1W1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705504965; c=relaxed/simple;
	bh=6UDS8FkhexYyc0wVvVp2lu16oGdbc3OgmsT1Ttvx59s=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=ePWkRrX+rIHx7a8SvlhebTHG3CEslX/WXMh4HP/4GUEpZdR7AJ+dqOF93kxy8I7MZBwnE4dLdhI2prp48zyRhhd4y5HpKXj6WMnsJA26DrvFd7kNZ0pv1vDmFLFD3stsdeuJp1NKyKK5sdO1J0MTwDyEqSuRVpBV6oudlHtwqUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW9TIUFP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 537DBC433C7;
	Wed, 17 Jan 2024 15:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705504964;
	bh=6UDS8FkhexYyc0wVvVp2lu16oGdbc3OgmsT1Ttvx59s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW9TIUFP9KDG4Ij8h3pVU6tXgCy10WhUVNamkwrhWjcgaEdGH3EpulWFFa/O8r/aQ
	 eXT/7OeVf84d98rPS5CIspPkHFAv9SPdbUqDJOF+8xWH/vIrFK/z3zTde+4/8Uw07G
	 tAwd5DVPLPEAo0E+eKb9W3RMkC4zBgyTdEA2CzGOrwFXP0FeH2rbcQXIumEmu6kdRx
	 mfAMwkgM78p1+i25aPvFZIJdtS0zMWxeEGYMiaZ9itMlb3iCHBGsybrkDyM+X+sJol
	 sFGcpFK51Kvo9AauRdxRm2QvHVkJHhm9vbMI1DtpGr4QGd3aw/Tmuu/UaBTZLm16vi
	 dyEWqwxH3mDcw==
Date: Wed, 17 Jan 2024 15:22:39 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] ASoC: codecs: wcd938x: handle deferred probe
Message-ID: <8c30a417-20fb-4d61-b5e5-deb5cd579e50@sirena.org.uk>
References: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QFFyemF5MjRQpF88"
Content-Disposition: inline
In-Reply-To: <20240117151208.1219755-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Nostalgia isn't what it used to be.


--QFFyemF5MjRQpF88
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 17, 2024 at 04:12:06PM +0100, Krzysztof Kozlowski wrote:

>  	if (ret) {
>  		dev_err(dev, "%s: Fail to obtain platform data\n", __func__);
> -		return -EINVAL;
> +		return ret;

Should this be a dev_err_probe() as well?

--QFFyemF5MjRQpF88
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWn8L4ACgkQJNaLcl1U
h9D0ywf/ZnguSawFPSvLSmZVVE26qF0aj2D0OQ7gHQ8FtL2H9VCflICbGytH79B4
2RSVIuvM5MNinmoWSanljMuwBI4feZeS10CmQJKnrqvGVhOnpvlmJew0W6KeJbIb
46fOJDk52PGNpkMtXDpuhXy1/SsrH3WLQhEKhDHPtJRl7uCS2qS/8QE8y6eZ8drW
+JlONFb5emSDvHvz2U0hPSZ0X6uEDI+M4xw4xlTbtBFCTdoj6Lmal/BWuIq5R474
iIdPpur9UKzxXTkQWo0lFiZw5vIjaU91o5tczCZDAkhW/Y5Yrk/a9BqcgF1W1t2E
Pnfa/E1hImH6vtUIPE3npI7IAhN7zw==
=sotV
-----END PGP SIGNATURE-----

--QFFyemF5MjRQpF88--

