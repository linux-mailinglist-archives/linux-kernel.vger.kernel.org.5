Return-Path: <linux-kernel+bounces-30415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A82831E5F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E3C1F21940
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7AA2C85B;
	Thu, 18 Jan 2024 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/wR20Ik"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645A02C84B;
	Thu, 18 Jan 2024 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705598663; cv=none; b=F5/4LPORlRObvk8Uc6e7vBNIjDLDrZ83tU6s7OF8Yos0N5TO8MYNo94lIBy4jAogx6nXjPWWcwc0aLNsl8ln02QXv/yNFHnvPIjQLx4y0UC272nOvnhENH57Yp5D2kXa0/pXhfJuX48OWJqpaDt4kYa5luK/C8q3GYWWf5qlMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705598663; c=relaxed/simple;
	bh=fwjbGDSFIjc8qlO4WD/Kh7B3ZcBVJBmaJHRvtZrLsQA=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Cookie; b=gkk9z1ucXBe+Mas0F35YAuOQMydXAkGVM9iGBHs6lzm/QJf6vZ7BOyA5pk2p35n7KAVuH9rFkKfzD1+HqnBQB9KvpS7t9fd6mgBDuBx/JzTTsX0L7BMC6eaOS80p2F0epht0b56EyH882Md8igzwcyB+YYSbhgIok9l/qyJcSVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/wR20Ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80269C433C7;
	Thu, 18 Jan 2024 17:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705598661;
	bh=fwjbGDSFIjc8qlO4WD/Kh7B3ZcBVJBmaJHRvtZrLsQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/wR20IkdFKEa6etry0nq9xG/nHA6/iN+lCrnxbPsqLCqSxt+JloUKnAkZTwEtm2L
	 rN0YE18lsRlwry23wNjsqN3FVeNhPGEdQomhbXJdmfZ2DCDM1cL/S5BmpdFfTr5CCw
	 RCrPu+FA+uyaO9Bg10TPMbr3KJA0TE0l5epsNE7ar1S48lsgm3Q4KkNa6fnXO6G3og
	 4e+JVM7jlBBitrbR52ybBsKc6SICKubRk17Qpr0I0/vnurvxjcvEP5qCbahNA9mMtS
	 VDbsSGBcdxYWOWNhbM64BpzRhCq9rwXmuxiAVEscG6RT8cEdhd8RbMJ2Z1K2iP73eG
	 KZyRGikvIWLLQ==
Date: Thu, 18 Jan 2024 17:24:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] ASoC: codecs: wsa883x: fix PA volume control
Message-ID: <a9e1f3b8-9597-454e-b68d-4014e923ee61@sirena.org.uk>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-2-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uU07sBcsXDNnOMTd"
Content-Disposition: inline
In-Reply-To: <20240118165811.13672-2-johan+linaro@kernel.org>
X-Cookie: FEELINGS are cascading over me!!!


--uU07sBcsXDNnOMTd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 05:58:07PM +0100, Johan Hovold wrote:
> The PA gain can be set in steps of 1.5 dB from -3 dB to 18 dB, that is,
> in fifteen levels.
>=20
> Fix the range of the PA volume control to avoid having the first
> sixteen levels all map to -3 dB.
>=20
> Note that level 0 (-3 dB) does not mute the PA so the mute flag should
> also not be set.
>=20
> Fixes: cdb09e623143 ("ASoC: codecs: wsa883x: add control, dapm widgets an=
d map")
> Cc: stable@vger.kernel.org      # 6.0

This will mean that any configuration saved with alsactl store will
change effect, it might be better to just fix the TLV description and
live with the unfortunate UX...

--uU07sBcsXDNnOMTd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWpXr8ACgkQJNaLcl1U
h9Dj7Qf/RUbEhZL9xGzztZhdMbhnvQx3zBa7jW2Du147E9JDgc8KtkPj7Vkk4Uf3
3FmSoDvBaUI0PGj6+Tno9DunZpJatVosXbxfSECDIKQAfq7MMO03jdQSvVM8jW9J
QXu/yx8ZS1JTm3RioGwhZLfrqz2NqiidN75JdRwMHEIMOp+sMjqJMtExzCWxYs2O
QDkeI1nR5sZvFmIajm+FfcvbUVRn6g43gzAodZv7T/jsqjCd/9id10UV0Z48wEzG
Xt968j4d6CJ/D5YZpat/7RuGEmqde4l7ILaDXnrJyjCdvZ7vLVuLYH0T1YpfzCbD
2VmGNoDs1sLPwPR+Og3WQ+PuTozqIQ==
=QGG2
-----END PGP SIGNATURE-----

--uU07sBcsXDNnOMTd--

