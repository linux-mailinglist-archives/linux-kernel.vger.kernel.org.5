Return-Path: <linux-kernel+bounces-76334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0942A85F5BE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B270C1F293F0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29D3B79E;
	Thu, 22 Feb 2024 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GLpeCnbB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862A118657;
	Thu, 22 Feb 2024 10:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597794; cv=none; b=NZEIvIqEeNmxnln9Lf1RkrxYmrPbaGfjry+nRXlm+glMciteVa6VNK8JEP/woB5zstmV/xxcJllEDEwjbePXjL7PC4PhxIN4loR2rY0okG+VvrUpzmDhVUprqYazEIiWuXnp0w6q9vTSgxvKr0u7JUQlVbs+haRWzvNR7OgXpDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597794; c=relaxed/simple;
	bh=Wzsp+43YqM+LlxN0cpsEdEREeR6hPbCyLnqKwXy8YPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YicjJGAARkMssK75v+eKJ7/HNVyMBHxbKASrrKMg/APAi5OTV2EkFRr3u4fWK6BjWxroJbYMa1Ihzw1CK2q9ROSfRpXQ6EU1RQix1YZ4WadJOAvGiFkrkm43hAV9awydBHRbg5Wsomy3ZiBTnX9RcO4t2Bq3TOzcSqRI4ix/MGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GLpeCnbB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86506C433F1;
	Thu, 22 Feb 2024 10:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597794;
	bh=Wzsp+43YqM+LlxN0cpsEdEREeR6hPbCyLnqKwXy8YPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GLpeCnbBnu29hs6MZNOozG2jG6b1fFuTJVhE3nvd7tjl6OJrs/6etqCnvwC1gydFc
	 fZaiIs07i5pfwnXJ+lyW5Irfyo1A4zz85pj1wabeJ7hHUqk2KOdpUel/X2TixStzQz
	 V58Kw1xhT+bVoCZNonvGZgNysqVEW/SraW2A6pjK7nU1YpFwSWACfR/7CkFRkFf7mE
	 OPikCWYMo91ZsmfU/RQ/POBakSS1xVnR7T2/P/ZpO+odkg+uBRfP4f62sytseG05jY
	 P0L90QvV7eZlk0m9ZoDBIDUf8lS9dwxaWtHQuXvP5xb8VBZaX1IWZFRjlm6KMap4uX
	 Ng7/DDdFyaRkg==
Date: Thu, 22 Feb 2024 11:29:51 +0100
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
Message-ID: <ia7e7gqozltl5wkfdvwtf2rw2ko2dt67qxtuqbavsroyv4ifys@x4mbulqhhri5>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
 <poua4bzyciiwt65sqjf2whqfdumvoe4h3bkjpf64px2vwgumrf@sai73byg2iju>
 <87sf1zxb0s.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bml6dpjoov3orz5g"
Content-Disposition: inline
In-Reply-To: <87sf1zxb0s.fsf@oltmanns.dev>


--bml6dpjoov3orz5g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 04:42:43PM +0100, Frank Oltmanns wrote:
>=20
> On 2024-02-08 at 20:05:08 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > Hi Frank,
> >
> > On Mon, Feb 05, 2024 at 04:22:28PM +0100, Frank Oltmanns wrote:
> >> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
> >> The SOC requires pll-mipi to run at more than 500 MHz.
> >>
> >> This is the relevant clock tree:
> >>  pll-mipi
> >>     tcon0
> >>        tcon-data-clock
> >>
> >> tcon-data-clock has to run at 1/4 the DSI per-lane bit rate. The XBD599
> >> has 24 bpp and 4 lanes. Therefore, the resulting requested
> >> tcon-data-clock rate is:
> >>     crtc_clock * 1000 * (24 / 4) / 4
> >>
> >> tcon-data-clock runs at tcon0 / 4 (fixed divisor), so it requests a
> >> parent rate of
> >>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
> >>
> >> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mip=
i.
> >>
> >> pll-mipi's constraint to run at 500MHz or higher forces us to have a
> >> crtc_clock >=3D 83333 kHz if we want a 60 Hz vertical refresh rate.
> >>
> >> Change [hv]sync_(start|end) so that we reach a clock rate of 83502 kHz
> >> so that it is high enough to align with pll-pipi limits.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >
> > That commit log is great, but it's kind of off-topic. It's a panel
> > driver, it can be used on any MIPI-DSI controller, the only relevant
> > information there should be the panel timings required in the datasheet.
> >
> > The PLL setup is something for the MIPI-DSI driver to adjust, not for
> > the panel to care for.
> >
>=20
> I absolutely agree. It even was the reason for my submission of a
> sunxi-ng patch series last year that was accepted, to make pll-mipi more
> flexible. :)
>=20
> The only remaining option I currently see for adjusting the sunxi-ng
> driver to further accomodate the panel, is trying to use a higher
> divisor than 4 for calculating tcon-data-clock from tcon0. I remember
> reading a discussion about this, but as far as I remember that proposal
> was rejected (by you, IIRC).
>=20
> While I appreciate other suggestion as well, I'll look into options for
> using a different divisor than 4.

Like I said, I'm not against the patch at all, it looks great to me on
principle. I just think you should completely rephrase the commit log
using the datasheet as the only reliable source of the display timings.
Whether sun4i can work around the panel requirements is something
completely orthogonal to the discussion, and thus the commit log.

Maxime

--bml6dpjoov3orz5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdciHgAKCRDj7w1vZxhR
xfJ1APsGJxlhH6N9Zf5Bg18E9npao1trsNfER/3ulA49l/e3zQEArlyYygxuPvKn
3nkhyF0YeukoDf5065tfHAeU7wy1JQA=
=mdeZ
-----END PGP SIGNATURE-----

--bml6dpjoov3orz5g--

