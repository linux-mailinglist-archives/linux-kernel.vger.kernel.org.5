Return-Path: <linux-kernel+bounces-104480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF0587CE80
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C715A28317E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D641E374EC;
	Fri, 15 Mar 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrE85+Fu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A37B36AF1;
	Fri, 15 Mar 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511640; cv=none; b=uK7/eC4Crrl68ueKKvaF1Oya/GeFF3MDIdHJbvtoSvjCKAh+xLbJKtLBOt0fOouxbM9guw4erusGbAqth0mJgVfE44cd8+qwXJTnwCqDr778Yspnbd5xiL4NEM6eGWn9nTX5hDWyBkFayHStleAdZbGckTF6DU+z0oxwGgrbzJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511640; c=relaxed/simple;
	bh=WdUX4lu8bXJIZPkoiQQkUmr5EbLf/TIHgfd0F51z534=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5tKCjCRBCis0NJO77HBgb5SgQX9IjCc6ue7qmYWCWKgeri22pc6NbEU0DOVY52FsnNaW9d/pp1+07UuoKlb52oG6VQiokPh+x6qqDW4YaK8NQJTHYq61cDoXh0IgIdGIVH7nmgR3CWTR6phnE7+7ChimpdaZ2CXSIfXiQj2An4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrE85+Fu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C524C433C7;
	Fri, 15 Mar 2024 14:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511639;
	bh=WdUX4lu8bXJIZPkoiQQkUmr5EbLf/TIHgfd0F51z534=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VrE85+Fu6T6PEiwbvP4kB2o7DTAVBxOF0HfvAXbb73daAwwJd6neO5BO8FodeKgeb
	 D23zAIUVn22HBgwLKWdIzRSSe+AXB+rqGooc/TX9fAk6kaD+H6I9qNXvAEORrl3InK
	 Z2f3Ym8ISoMMzQUDaE+rlLe2NHijhxsQQOGpJdpbKSKDT4/w6AZOHZ8/QNEcPMuDZa
	 i07Z5m3471yM7r4D4bYvowbotVgl0+13LY/MR49TyJd87cRB4vxFR41RyI4hBjh9oJ
	 CRq4AdsRq2pHv/NLYr2JOSWbKcH7OZlVT7t60oMNPXIP8+zlDzPeM5ZuZE0MNNdh9B
	 EqyQ2noi/G/Nw==
Date: Fri, 15 Mar 2024 14:07:13 +0000
From: Mark Brown <broonie@kernel.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 04/13] ASoC: ti: davinci-i2s: Replace dev_err with
 dev_err_probe
Message-ID: <6102130b-b496-4e75-9b9f-f960484848fb@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-5-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3GytGuMeU5fQLL4f"
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-5-bastien.curutchet@bootlin.com>
X-Cookie: A well-known friend is a treasure.


--3GytGuMeU5fQLL4f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 12:27:36PM +0100, Bastien Curutchet wrote:

> -			dev_err(&pdev->dev, "no mem resource?\n");
> -			return -ENODEV;
> +			return dev_err_probe(&pdev->dev, -ENODEV, "no mem resource?\n");
>  		}

dev_err_probe() with a fixed error code doesn't seem to make much sense,
the whole point is to handle deferral but for a straight lookup like
this that can't happen.

--3GytGuMeU5fQLL4f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0VhEACgkQJNaLcl1U
h9DoVQf6AqSdqdzoCg7bciF4ooMQTN5zUTk3BOK75rX557NTNOzssKXfOkq3P6IK
UPIgAGVmjLPycIsFR4/8r0Cbnh+/2WCn+5PB8u165TR6JaHq9LdBNqYI74E93Bxa
F1BYs3h1+OwhReXF7bVNlWX5vpkeM7GXuP4kqmgiVv1jKGCHOJhbBMCN5qB8kGov
6SCNIqh10yRWnjD8L68EtFgTxbF/Cx6Ohfm8nQalK6QC9BKc1t2JgsQuhm3xZLZX
A+OfFqvzRN1Ct0w5TjA8YrFfS3NYydlCuyO8mRdAycIi4gaoarJGRm9PGwpAS3E9
F4ppJpwm/ht2TzJDmVckcCGGihyOdg==
=IT+L
-----END PGP SIGNATURE-----

--3GytGuMeU5fQLL4f--

