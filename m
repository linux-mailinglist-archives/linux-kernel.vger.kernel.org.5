Return-Path: <linux-kernel+bounces-90375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 091EE86FE5D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D761F224F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D4A224E6;
	Mon,  4 Mar 2024 10:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pww2daha"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97452208A;
	Mon,  4 Mar 2024 10:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546802; cv=none; b=Eaf2q6fyVkUyKWEliy761kqG/85oqXS0LqVJWwzDW+qiv786vyV66nsvMzCDM1SzcrmpK93HI6XOrFq5P8sq2CGZmMjAXZqUhL/wNvH/FdrS3GStv2SHaJAeLimjO2JLk+j9F3c/9rO042HwHYzUNNU+I+0pFw5KuADJI1JlHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546802; c=relaxed/simple;
	bh=ql2YE9dLy7/HqksxFsL3EMa70qfrq6G0Ss3uyxIAfU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fZoTFFMh32rIdVTHLNSgZNTNpITE7oBUZNWGWJoNLCgRTxmsLOON0c/5Ftd1cjQX+AliqQ0ep/oe1rz5QtXIvEbuMY0NK6Qlr32ByClNWHNg3eBR7jIupZMU9Ohep1mgMXXatacYHSLZoBlwaxJxg5vRtJsNXJ+k5OnvnkEDX5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pww2daha; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E61C433C7;
	Mon,  4 Mar 2024 10:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709546801;
	bh=ql2YE9dLy7/HqksxFsL3EMa70qfrq6G0Ss3uyxIAfU8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pww2dahaYktpZw8zT+GAeiG3eZOnqVJMgGXYa9jEHCUPuvpwexEgiwYHLp8oIPWV1
	 p9Nfs2tLGMtfRtk/61TvqOxv6B/o8bdnNnoNv4fmtMezl9QEk1KTwDhwsXfJQhjb0R
	 S8h/M2BjnZsTX1daFrf3PHgFHyPx/I/hW2Bd7Tg7nKt2GEvzlbv3awpzmXs8VmBuEz
	 YAzCR9rxIfj0eY9MHL/Hs6xaKa1v/WiUM4kjerG4w5F0PtzOvRZsegSxW7fevoo+Wl
	 L6UHJUJs6JB0QPzhTtfH3TutaU8TBxfoCo5iNyFvwFfdBp+I8psu0Q8zPKUB5ig+iD
	 mpOFS/TxydkMA==
Date: Mon, 4 Mar 2024 11:06:38 +0100
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
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/5] clk: sunxi-ng: common: Support minimum and
 maximum rate
Message-ID: <20240304-satisfied-terrier-of-refinement-af48cd@houat>
References: <20240304-pinephone-pll-fixes-v3-0-94ab828f269a@oltmanns.dev>
 <20240304-pinephone-pll-fixes-v3-1-94ab828f269a@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="66d2eote3zmcdjtu"
Content-Disposition: inline
In-Reply-To: <20240304-pinephone-pll-fixes-v3-1-94ab828f269a@oltmanns.dev>


--66d2eote3zmcdjtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 08:29:17AM +0100, Frank Oltmanns wrote:
> The Allwinner SoC's typically have an upper and lower limit for their
> clocks' rates. Up until now, support for that has been implemented
> separately for each clock type.
>=20
> Implement that functionality in the sunxi-ng's common part making use of
> the CCF rate liming capabilities, so that it is available for all clock
> types.
>=20
> Suggested-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> Cc: stable@vger.kernel.org
> ---
>  drivers/clk/sunxi-ng/ccu_common.c | 15 +++++++++++++++
>  drivers/clk/sunxi-ng/ccu_common.h |  3 +++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu_common.c b/drivers/clk/sunxi-ng/ccu=
_common.c
> index 8babce55302f..2152063eee16 100644
> --- a/drivers/clk/sunxi-ng/ccu_common.c
> +++ b/drivers/clk/sunxi-ng/ccu_common.c
> @@ -44,6 +44,12 @@ bool ccu_is_better_rate(struct ccu_common *common,
>  			unsigned long current_rate,
>  			unsigned long best_rate)
>  {
> +	if (common->max_rate && current_rate > common->max_rate)
> +		return false;
> +
> +	if (common->min_rate && current_rate < common->min_rate)
> +		return false;
> +

We should use clk_hw_get_rate_range() here, there might be some
additional constraints to the rate range than the hardware ones (ie,
calls to clk_set_rate_range()).

>  	if (common->features & CCU_FEATURE_CLOSEST_RATE)
>  		return abs(current_rate - target_rate) < abs(best_rate - target_rate);
> =20
> @@ -122,7 +128,10 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, st=
ruct device *dev,
> =20
>  	for (i =3D 0; i < desc->hw_clks->num ; i++) {
>  		struct clk_hw *hw =3D desc->hw_clks->hws[i];
> +		struct ccu_common *common =3D hw_to_ccu_common(hw);
>  		const char *name;
> +		unsigned long min_rate =3D 0;
> +		unsigned long max_rate =3D ULONG_MAX;
> =20
>  		if (!hw)
>  			continue;
> @@ -136,6 +145,12 @@ static int sunxi_ccu_probe(struct sunxi_ccu *ccu, st=
ruct device *dev,
>  			pr_err("Couldn't register clock %d - %s\n", i, name);
>  			goto err_clk_unreg;
>  		}
> +
> +		if (common->min_rate)
> +			min_rate =3D common->min_rate;
> +		if (common->max_rate)
> +			max_rate =3D common->max_rate;

max_rate should always be set to ULONG_MAX. I would drop the tests for
both here, and warn if max_rate is set to 0.

Maxime

--66d2eote3zmcdjtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZeWdLgAKCRDj7w1vZxhR
xb2SAP9ET0NeahIoRnvn18FEj694GWHVCshWmVdZSbx52ubyUQEAquQE3UNMNiFK
TI7im2BmnlMaX7gl9ElohBH6qB5TBgE=
=/sgn
-----END PGP SIGNATURE-----

--66d2eote3zmcdjtu--

