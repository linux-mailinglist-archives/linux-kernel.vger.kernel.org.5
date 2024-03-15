Return-Path: <linux-kernel+bounces-104482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2E587CE85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 15:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9B9C1F22956
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F857374F0;
	Fri, 15 Mar 2024 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rn+/dkIg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEFC381A8;
	Fri, 15 Mar 2024 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710511796; cv=none; b=ODZ86ojcMP6g3pmZfjF4UpnIMTHKJyB2q/EmF+gPbnvvuiPhpqrgB3SU1UhWOBp+hDVGTkivRnmCkIhIVc1t/T4u+O0fxdnFS6gRJXDw867P+iNK7AoQ3WS+J+q34d0gjv/JmkmhBj/bZc7Hq+L1kEaDv+QAhb8PwvnbIzxZ9NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710511796; c=relaxed/simple;
	bh=txB3VCSUE8GHPntsFBv+qFgsatTpyjpzFZFx1kEapAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bNuxpPTxpWG98rCv1nNvw1PNgEbpxnUsjF5Nwkinau0/dc/OB5YK7t1T63TDr7ci/VotQW24ru87+yjlWlAb0Wa0dSVK2hPaqgIXYNMtKcYDYL6YF9jWBrGwBW/Nc/ZlRKBN8WFnph60/9DnAmfO8AcQt24BL+lbsNptpWVVj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rn+/dkIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A617C43390;
	Fri, 15 Mar 2024 14:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710511795;
	bh=txB3VCSUE8GHPntsFBv+qFgsatTpyjpzFZFx1kEapAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rn+/dkIgs1K6Q0NulNzVY3euoVPQwoIlTLJNZFo7PN0iZR+s5sQWqILQKjSUg9YsV
	 AkKJCEQoldsT0M3kMn5MRKQjPdMGU0pA2DF3eu03GOfZXJfh/rpbZN0JA0YPb+XJJ7
	 GiAFBhPwVYJFsd41zM66DO4mcccVeZsHKAiLCxDe8aVQMpKy6qnnhekGOCrzBkQKOt
	 cCeAcxDEgjc9+zWtM51XftSyrj2CW8txwiF40mfy3IN9fV92oREtdjc12OkquEEATS
	 Qev2aNdhADqylUSdyOLI0LQ9HCQcgA4tTD3xU46tf2rhBdsWDaxUcvheifIh++dk86
	 /GXuKLUdsShTA==
Date: Fri, 15 Mar 2024 14:09:50 +0000
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
Subject: Re: [PATCH 09/13] ASoC: ti: davinci-i2s: Enable unexpected frame
 pulses detection
Message-ID: <51866f62-460d-4035-bcf1-b9f03cf9be0b@sirena.org.uk>
References: <20240315112745.63230-1-bastien.curutchet@bootlin.com>
 <20240315112745.63230-10-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zczSzXQ+ZeeLvl4t"
Content-Disposition: inline
In-Reply-To: <20240315112745.63230-10-bastien.curutchet@bootlin.com>
X-Cookie: A well-known friend is a treasure.


--zczSzXQ+ZeeLvl4t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 15, 2024 at 12:27:41PM +0100, Bastien Curutchet wrote:

> McBSP can generate an SYNCERR when unexpected frame pulses are
> detected. The driver always disables this feature and ignore the
> unexpected frame pulses.

What does "unexpected" mean?

> Enable the generation of SYNCERR by the McBSP according to the
> 'ti,enable-sync-err' device-tree property.

Why would this be optional, and how is this reported - I'm not seeing
any interrupt handling updates?

--zczSzXQ+ZeeLvl4t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmX0Vq0ACgkQJNaLcl1U
h9B6ogf9Gt1HwXN03wT222z3x2b/bwF19rqWov52RR4WPVcua6711ND9cDqiIcOW
Oy2GTXmHEQmrDvT+GOcsjbOMpoYBoZi+7MZqRdv9/LYCZbFq/2H4AI2O/qmfF5kO
f68g6bzryQdac8ZmG5edevGy+eDWm/s22EkLSqhBhHDJF+UuEFc+QHgl4UZC1bSG
kxV38qN+cN6V2FzuXSuDdKlFytfkuGNF1ue5g+HADs3yRCjsgNeyJ/wx7MSUKq+s
OW9uP6jkKDP39+SwFYgo8TFQIjZJKw1XteEEZuVQhP5XQNcNtK0Y8kkTsDzIa6Qu
6P+cbhbwS1pcZxG521EwHYdEnIKmnQ==
=Il8y
-----END PGP SIGNATURE-----

--zczSzXQ+ZeeLvl4t--

