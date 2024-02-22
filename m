Return-Path: <linux-kernel+bounces-77280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0356B86035F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 686B4B285CB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 19:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 734D56AF8B;
	Thu, 22 Feb 2024 19:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RL1TsQWi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE914B83B;
	Thu, 22 Feb 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708631368; cv=none; b=VJpKxMA3JURPSEMVh8DL3fBM4z0UErIVJs2tmKuHbEaUxepE2lYfOHMOyXz/V6ZXHSK6RZ6mi/qLzvswnjLXTusa0hV0NYwDGABt4OJsYktle8wCUAofJrRl7QeaQBMkosj6JsEFfLwJ9fiGJ+l2NpNcpREtJnv95aWQkzbbDtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708631368; c=relaxed/simple;
	bh=/biIcgNJEP7ZYJvfwCxGBQX0PKEdb1APj1B3+4z4jGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jq2OxCfMHy/nwElYHV0l/maPxHHGvK2bvD297vhtloomxCAJYshftyb8pQqJvd0UWN1RkKowdgAYrrm/qqKv6iFKzaSEAIO5sw+MBOCb/7NYlBxwuybohWiiWVViYLVebNo9MxfyHEYXZ4y7EwBSWoPxbkLL/RCbT3asWeq/fLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RL1TsQWi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C85C433C7;
	Thu, 22 Feb 2024 19:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708631368;
	bh=/biIcgNJEP7ZYJvfwCxGBQX0PKEdb1APj1B3+4z4jGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RL1TsQWi5zLiVHME7COnSIm7aEWD8sYvD5440/Bytbd6H+G6yqDboC3Yu/A027Mt4
	 sN3YRz4h0cwJeRZd6bVXL4+dZAdDS9DKmbkxDQ20617oHXC+s8OiYBbLNrM7iuyr41
	 PzmAb5fryB41hQSPt1aJz66rD8PaOV3RsbfT8rew5QEDckmMcgz3pKT8HPu78gzBU0
	 r9PGXvK+RLbvhBeVb0zwUaSlTZMpusogfU9plTUoZgRb9f9S9rsL1/YEm0egsViat9
	 +65YURcbcbbnUf/+ZVnPxK4qD/PGaFKzRwCcUS0+15vPxG3li214z9NY3oF78n7L3N
	 Do01hRalwESFw==
Date: Thu, 22 Feb 2024 19:49:23 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v3 2/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Message-ID: <cd300d58-bb6b-4fc5-9170-66b5df89b9b5@sirena.org.uk>
References: <20240129143534.109196-1-krzysztof.kozlowski@linaro.org>
 <20240129143534.109196-3-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EWbHII0jzV3QWW/B"
Content-Disposition: inline
In-Reply-To: <20240129143534.109196-3-krzysztof.kozlowski@linaro.org>
X-Cookie: Don't vote -- it only encourages them!


--EWbHII0jzV3QWW/B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 29, 2024 at 03:35:34PM +0100, Krzysztof Kozlowski wrote:
> Starting with Qualcomm SM8350 SoC, so Low Power Audio SubSystem (LPASS)
> block version v9.2, the register responsible for TX SMIC MUXn muxes is
> different.  In earlier LPASS versions this mux had bit fields for
> analogue (ADCn) and digital (SWR_DMICn) MICs.  Choice of ADCn was
> selecting the analogue path in CDC_TX_TOP_CSR_SWR_DMICn_CTL register.

This doesn't apply against current code, please check and resend.

--EWbHII0jzV3QWW/B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXpUIACgkQJNaLcl1U
h9D1Zgf/RcMhNetO2ATzqWBDmwci8+KCJqNljcildSvTVmLjLeJDddwfFFNIeC2e
4wcYVVXcf4+Or3oref1uYZZl2azhRSeZ59ZM8DBEq6r5w9jxLcSVf/dNQXgg8E5r
DLh+STU0FrGHTcJAw1wtf1UpV4XQMUHBwT4nmc3mCfZt5AyJ4gDI42xYR9u32Cfs
dEbYWH06O/7uplxQxEPYCRt/g9BB9nl6xrO8F35bTUF+6iC6o/MIbPEXVJw3pFJU
+xM/TUDbYb2mEwHmYFffBqDfVRMbm+XPe/vvlfsQRpQTMH3vpNpDQdDJ8HGpoaKD
jwf849zak/JTRbxfypp61rHNd3QgHw==
=lyOj
-----END PGP SIGNATURE-----

--EWbHII0jzV3QWW/B--

