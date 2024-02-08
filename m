Return-Path: <linux-kernel+bounces-58595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8CF84E8A6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 20:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DABC82853BA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948E825620;
	Thu,  8 Feb 2024 19:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CS+rhKX+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A602555F;
	Thu,  8 Feb 2024 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707419111; cv=none; b=IdIQontj8aq+h8DP4yMOjncajvQqIA69x9xHf+kyaTkEWcwGpD1UCgQcekfC5ViDLE6BQd7NiGTmKMngDkFC5M3+SWtZu452GbGsQpd2YQHtY6GKi/8TPAlZSZGJI6kppj9Y3OI5fLcm4SETpthIDB1CSH6us8rYqmJgU9hfsPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707419111; c=relaxed/simple;
	bh=2qlm0ODvAMoRIMtaJwc8hZTrxizT0hsAuAgTKH9Ac6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4GUz/z6p0LCEYYs3h9b8FbnFuF9nwOP3HBja+fKVi3+Kq2A7fW7Rao07kxsxk85ASDu7fhTxb20qMVFbZuEt2j+8s5b8iLZX6Pz6jEs6DAj1N5QQoARjsTJi0xQaNK9mBpDWFdYIjreFK5sn3OF+Q44XZbNYc7v/UL4ehrkk+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CS+rhKX+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FA8C433C7;
	Thu,  8 Feb 2024 19:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707419111;
	bh=2qlm0ODvAMoRIMtaJwc8hZTrxizT0hsAuAgTKH9Ac6E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CS+rhKX+zDJN3T7gIg8okrFgf1lLcVxRZ5Cz2/LEoMRiSQxKhS1AYIReNBGBrTVOa
	 yGqJm+psHTpyryvSVn48tarXkW32jPdhOsJuUilGnCn5RyDnnW1xE+F3m6ufGOSxpY
	 6dgpYCNtVr0JoPVCUH1dwTJp7pwPM6zLkXbZGLRjdHQgqfLmr/SiIpq6wlLl9xK8SP
	 m+jk10SQh1NBroTiSMleSL7a5iOztf6nOKR5PJnZ5FJHfSitqkdlzKZcTSAANynisw
	 OMLtJJ5En7QH+SIapHuil/lYGb3Kq2NHrOGS5iEHl/Vggqzzd8k1Hoc3o+w4i15teY
	 gx/zycT4wEFVg==
Date: Thu, 8 Feb 2024 20:05:08 +0100
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
Subject: Re: [PATCH v2 5/6] drm/panel: st7703: Drive XBD599 panel at higher
 clock rate
Message-ID: <poua4bzyciiwt65sqjf2whqfdumvoe4h3bkjpf64px2vwgumrf@sai73byg2iju>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fpufhrhdecowdrbb"
Content-Disposition: inline
In-Reply-To: <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>


--fpufhrhdecowdrbb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Frank,

On Mon, Feb 05, 2024 at 04:22:28PM +0100, Frank Oltmanns wrote:
> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
> The SOC requires pll-mipi to run at more than 500 MHz.
>=20
> This is the relevant clock tree:
>  pll-mipi
>     tcon0
>        tcon-data-clock
>=20
> tcon-data-clock has to run at 1/4 the DSI per-lane bit rate. The XBD599
> has 24 bpp and 4 lanes. Therefore, the resulting requested
> tcon-data-clock rate is:
>     crtc_clock * 1000 * (24 / 4) / 4
>=20
> tcon-data-clock runs at tcon0 / 4 (fixed divisor), so it requests a
> parent rate of
>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>=20
> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>=20
> pll-mipi's constraint to run at 500MHz or higher forces us to have a
> crtc_clock >=3D 83333 kHz if we want a 60 Hz vertical refresh rate.
>=20
> Change [hv]sync_(start|end) so that we reach a clock rate of 83502 kHz
> so that it is high enough to align with pll-pipi limits.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

That commit log is great, but it's kind of off-topic. It's a panel
driver, it can be used on any MIPI-DSI controller, the only relevant
information there should be the panel timings required in the datasheet.

The PLL setup is something for the MIPI-DSI driver to adjust, not for
the panel to care for.

Maxime

--fpufhrhdecowdrbb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcUl4wAKCRDj7w1vZxhR
xTm0AQDNC/Tab28G6xBV/FvvVOHHELD/uZcAMloaia6Nu7yTjQD/bu1heOYZp8J7
/+vAKLYzF/jNMgEObqQ/VnHSFbOX+Ag=
=CNG5
-----END PGP SIGNATURE-----

--fpufhrhdecowdrbb--

