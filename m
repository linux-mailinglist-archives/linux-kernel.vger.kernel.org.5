Return-Path: <linux-kernel+bounces-58035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D4484E07F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934681C22D7A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B8C71B4F;
	Thu,  8 Feb 2024 12:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSnsdIyB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC06F531;
	Thu,  8 Feb 2024 12:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394591; cv=none; b=B+kSOoFYep52Pt5OgWktHttS5wsAs5Mprv9VcEolQuzFYkjIbT6pvt94n/411BMzls31dHN+fo5zcZ8x+TsXKsVigUFRE2C6+XeZtSL5wGBdl5hXLv1YZoBgRpv/l5uXHlHzBBRbN9eprwyrz4CaRFTBDt8pD+1+uuU5ic4z9Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394591; c=relaxed/simple;
	bh=USkxMo00wu+oAG8dbi0UUhcAygROpPKwwkXbpptKPw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0JakIhWGeXUojq+zflFb26cwJxskQQPSgEQpCfH2BzkMv0QmrB0TPBP9Z8XyGZ2A48s4TPrQLn8hku3zZOwHmlEJcs6+MyTuGCIiFgcAL5LfXckzZ1rykfONpOtRWxPZBQCyuXAeHLcvn1sLZ2lyyYvmSwSgZRtEwYjFKXNpwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSnsdIyB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64826C433F1;
	Thu,  8 Feb 2024 12:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707394590;
	bh=USkxMo00wu+oAG8dbi0UUhcAygROpPKwwkXbpptKPw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSnsdIyBgjtrpmx4IO6IAxNTOBoAYUpwNNlSLkBDFRnlYsNjH6LMU1HMJ9mrpFb75
	 /2cZcLMxIxfdsFyq3dzzxkFBVmCZj8wEvJO5olQyLjIDdYyI7cJ8GP555tVOQNl6uD
	 TXMtm9Nafx5RjDeopn5SJdGpdshEIZ+wmtBNcJU0Q1xYd/hS5eawcY2mjSd3siFvEg
	 kJC7o74B+5/K5POXR5b0Tsbt7roheh+iUaNazrmA+c/NYYEX3MgYRRnswxeMiycbfZ
	 tQt3o5/vBBmHR8FNOTEz+GFJEhpvcn7aYFZ1/ByDQB9Vk9B9nmyFYa+7Vui4p/HIBh
	 RLqvn9ug3AY/Q==
Date: Thu, 8 Feb 2024 13:16:27 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum
 rate
Message-ID: <exb2lvjcozak5fayrgyenrd3ntii4jfxgvqork4klyz5pky2aq@dj2zyw5su6pv>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g5pwkiip3azj2ftk"
Content-Disposition: inline
In-Reply-To: <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>


--g5pwkiip3azj2ftk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 05, 2024 at 04:22:26PM +0100, Frank Oltmanns wrote:
> According to the Allwinner User Manual, the Allwinner A64 requires
> PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nk=
m.c
> index 1168d894d636..7d135908d6e0 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct ccu_m=
ux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *=3D nkm->fixed_post_div;
> =20
> +	if (nkm->min_rate && rate < nkm->min_rate)
> +		rate =3D nkm->min_rate;
> +
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		rate =3D nkm->max_rate;
> +

This is provided by the clock range already. If you call
clk_hw_set_rate_range, it should work just fine.

Maxime

--g5pwkiip3azj2ftk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcTGGwAKCRDj7w1vZxhR
xfpFAQDl1iMbvaT5VL0H8/WZy4Wj8WN7EQPe6yGsH1gHJm+SJwEA2hmsuOH5dUHZ
3CUtUEMx4fGkAxCIbucEMa+tx6gRUgI=
=MjMG
-----END PGP SIGNATURE-----

--g5pwkiip3azj2ftk--

