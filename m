Return-Path: <linux-kernel+bounces-33653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7926C836CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 316CB28752E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 387F864AB6;
	Mon, 22 Jan 2024 16:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaE233g5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714834D594;
	Mon, 22 Jan 2024 16:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939543; cv=none; b=fMXX+gc8wN7hkOTqQ6o8hZWmtOUF5sdodctIPfyvk4nBv7IIiMq0IhBcCQu8+eP0lTnAl90XtZjD3k0Gd5VZvJs9ldupIiAEqoY3Pk4XhNa8h/0veL+EJd4CB2EFkwEi0exoW8qs7BPY6yDmveLydHIW7fJovLru97tfm1zs7lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939543; c=relaxed/simple;
	bh=1eEXVVdWTxV8z4waWaHTl3I6KXQypu95DXHvSvRdIHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uZNlLMjf2XjI5fUptP2wEQbkqsBIGPX5FMHx+veqWCLqojMkiOwWfaV0GOmK7P0VJ9BI/wkRemAX6PmYLQRyOJVl8LWBnFP/7A9VVNmAU9rf8av4pxDj76RJ55zy8iDp4bQTRJuCVnmV0nfeRKL2wadLhFWoJvuPCRLAGpp1XHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaE233g5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9638CC433C7;
	Mon, 22 Jan 2024 16:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705939542;
	bh=1eEXVVdWTxV8z4waWaHTl3I6KXQypu95DXHvSvRdIHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HaE233g598PTRgikgKOs0OlamkpWc2K8+qqvyMr5yECHnFkRXLHBVd8n1YLmmP9Tf
	 ISU6bGw0CwPUbfzi3h0Jzvfb8UzIcTuVaJTnRYO47UCDLIIYyHC6xP/HGwpCc5b7DV
	 dZ+t7u9n93sPwykg6VBtD+lepTKcek9ZrBHV0EylXMaS6maq/v3qezUSWWaGew031B
	 4ZwX7ykVqUD5LIrz7ZNbEE4gARFKbKFlyekx5JHVdSdyRcJhYYXNUW8ao8UtCS52s3
	 DcchBjDXtJ1iE0DBabpPfSSKqzxCIBQiAJVKZHvIYAzqnqGf+qkHeodKZTH1zjZp/Q
	 N543OSbMlzpsQ==
Date: Mon, 22 Jan 2024 16:05:37 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4 2/4] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <aca2b125-acf8-4791-a3eb-ea19826d3ee4@sirena.org.uk>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
 <20240119112420.7446-3-johan+linaro@kernel.org>
 <d54d3640-49bf-4a2f-903b-4beeb0ebd56c@sirena.org.uk>
 <Za4cR90XoAaATq8X@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pJm5Y4ijPdHAqAYt"
Content-Disposition: inline
In-Reply-To: <Za4cR90XoAaATq8X@hovoldconsulting.com>
X-Cookie: Nice guys don't finish nice.


--pJm5Y4ijPdHAqAYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 22, 2024 at 08:41:59AM +0100, Johan Hovold wrote:
> On Mon, Jan 22, 2024 at 12:03:55AM +0000, Mark Brown wrote:

> > This doesn't apply against current code, please check and resend.

> These patches are based on Linus's tree after merging the sound updates
> and I just verified that they apply cleanly to 6.8-rc1.

> I couldn't find anything related in either linux-next or your ASoC tree
> that should interfere.

> Could you please try again or let me know which branch to rebase on?

I was applying it against v6.8-rc1.

--pJm5Y4ijPdHAqAYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWuklAACgkQJNaLcl1U
h9AfJwf/VeyDwDQeh8AWh4NRdjUo5Pk5BLZ6jqdmO7SqBALZpLh5xFy5FGfLXf8N
UwJ6NHQih/rY3GI/hGT89cfC2I4UYOezJpjgdFxT9BG69bBIPHBoLcyMWFXXcMXz
47xHUGVsLK6ouYeyZpupNV7RuMeR6AyuPwltxzzcKwC6/wx9dC+hDM5AMmG6XCb/
yYOFjXRigXNlCVJVPMfwszrp0YhsRcIOR/mpEAazDmgNQGLnWuwAFMsDHt8HRT9b
tJhHaJpT8qdb9uS77JM/1Z7Fah2bh0g95qKTBT0TC3sr37ciK84kmUGP9bDVShxi
ba/11nuFNGeE381eTYk1OqblnnGwZw==
=it3K
-----END PGP SIGNATURE-----

--pJm5Y4ijPdHAqAYt--

