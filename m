Return-Path: <linux-kernel+bounces-81445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6E686760C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A6228A36E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DB5D80053;
	Mon, 26 Feb 2024 13:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4MQPSVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EF5B7A73D;
	Mon, 26 Feb 2024 13:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952926; cv=none; b=MrcjM/vEt7LxJegoQHOZmbBClxjbOlDCVlhK9wGNmg64Flagi689YWooiITdR+IA0WBm3dYV01CQyQW+TXs75c3WzDqnvBZufCdZ76pNMjAGLUCHqiqEqVNG08TwB9XojcbyDxuCS6W3+3z0bqmaNTrePt0FHE2vl79B/4lqqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952926; c=relaxed/simple;
	bh=4I3RhXtBZX5OMS1orfIVhwSdCHuuX6f8mq6Wj0gtZnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIJrAMB1suNvHcJQ6ptvDslyRxfpCnxKRJ/dvtVMY20hg/1BolvD5gFVL0LVaxtnJE25jXZhXJuEcudjU0R4KRXTQsThlm0R5+Vt2CV32OlNXAWwfo7zXEN7coL0OUVojsknBGxq8iDZNRtcfJR+PL8ZmmMMauARysecF/X94Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4MQPSVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52256C433F1;
	Mon, 26 Feb 2024 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708952926;
	bh=4I3RhXtBZX5OMS1orfIVhwSdCHuuX6f8mq6Wj0gtZnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i4MQPSVw3XtdgHB96J2XPs1a5xP8BWaggsHWOVzkgLdhJ9jDEorKezr0o5zkC1rlU
	 YwfUj/FgqO79fQ4FaPOCWrh44rEAaNMQ8fBCCRGFeoXkk7Q5y28TqLuVZdm3nmRfMn
	 tFOXbboHD+2rjZcToXXaGO2h79+E5NtEEsEX9o2/gJIBVkstkmgJIbh2yYhIP4m+NP
	 bHgSAmkRmraDvGw1k+Z+8YfhsIN2M6tsDQAxPWzfFrcEt3Uj5fXKpilhCgXntGdTNA
	 /GGqwNOtotzSKRpNXWP/EXLqQyh4QztiOkGYrEs4f+Wy8XcsxsW450G3thi8UVedet
	 9bGMiGH20dMag==
Date: Mon, 26 Feb 2024 13:08:41 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 0/2] ASoC: codecs: tx-macro: correct TX SMIC MUXn
 widgets on SM8350+
Message-ID: <ba3d3695-cde9-4aac-83ac-ee8aa949d57e@sirena.org.uk>
References: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="I5r0FAbl9DxiaVsF"
Content-Disposition: inline
In-Reply-To: <20240226115925.53953-1-krzysztof.kozlowski@linaro.org>
X-Cookie: Walk softly and carry a BFG-9000.


--I5r0FAbl9DxiaVsF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 26, 2024 at 12:59:23PM +0100, Krzysztof Kozlowski wrote:
> Hi,
>=20
> Changelog in individual patches.

When sending a cover letter please write something in that cover letter
describing what the series is.

--I5r0FAbl9DxiaVsF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXcjVgACgkQJNaLcl1U
h9Covwf+NRfuyXK8kzRR1j16coiFwpz6tb4kpW28h/xI4oxMxLg+7Fo36uOmi5pY
fxGsJqk8KWby7nw0SLcxsvRRBZ+fkHyotIrDcLjS+hgUMMA76vZcxafKEUmu2QVu
NJnJAwFwMd5ghEmMhCy0K3ca6uilnO26t/FF1o2UsCErxCmpw7UuRkkajluFZfdA
uyYhYC4D9YBAlbZCYbgpohAY4+QvnLjlYaP7t4nylBP1cXGBK973g7J96n2xBaE1
AecjWOfjyg2Y7BkjpNWN+4akAH6y/bxUMnW7PpXbW/QTVIF05ZK11zfMW1ju8fhB
46uWNSN3NH++6KUaF61n/rSwKJdxDw==
=fq70
-----END PGP SIGNATURE-----

--I5r0FAbl9DxiaVsF--

