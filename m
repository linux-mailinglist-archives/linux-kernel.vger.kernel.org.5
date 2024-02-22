Return-Path: <linux-kernel+bounces-76321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC685F59E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:26:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE0CA1C23CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BA23D0BA;
	Thu, 22 Feb 2024 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxttw6OI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3193C481;
	Thu, 22 Feb 2024 10:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597566; cv=none; b=mDgJFf9t9QJXo2MYwew5grWbe8S/MJXcF7irBRVCDIOLLHW3m9TI0QoDoG+1E98VSheC9orbv4UPJwRMStfles/Q+aYGNhHTmzDFOavABtQmzQ0rAdXSjpmW6tunF62ZZGIHJ6B4arRWF254bEDAYECfVPj9hVzEd0YU0YSQKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597566; c=relaxed/simple;
	bh=C5DPs1TcjLjs6ZDKjoVkY+BUT+jRjaN7GiNU8pWZYA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jj+mcBhM6Lg4XlTnBIdFMRsNJDjrJiTJGNICH39NQjifw6oiLKMvD//0wf2KHZYGYaMkUC2BsD6ebhd0vhCAUeHu1vxK0hCrpkWQ7O+iBGKOz9b+ij2urgFW5SFUjpKBiQUspbsq/CSP3uDuwIBuWTzTem3j/V0gflUOe8Sjcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxttw6OI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C466C433F1;
	Thu, 22 Feb 2024 10:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597566;
	bh=C5DPs1TcjLjs6ZDKjoVkY+BUT+jRjaN7GiNU8pWZYA8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kxttw6OIm01Rb9mT8fkBwjc3CFksX9rBo3NfSD0JjTxVvmXKbzkVXMXnUHdRLcg0C
	 +C6uGjnlieQizZfaY6+hyS0UfsuQssNpvGUcDdPKTkaTr54xN/BA8iCfXP4VGwLqvK
	 dl/edARIVtGsLb011Jg4+PPYrrGn+m5ntYqVRs1Ta2adzPiBZI5vMLuFQxAJrfuX+5
	 5tq9nUYKJap7Y3PM7rnJOVG5GXkYCB+28YMHAbt2IuxYXuT4PLNEV69qaMtpTV7uDf
	 u3QDCcJjm2h3sPGv0mVwXdbdYmgQG5D8PhsWciunNQg9GPUcTXfzbGPdpidBC79z6X
	 al629d1dgQlJw==
Date: Thu, 22 Feb 2024 11:26:03 +0100
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
Message-ID: <3kbqdgbfn2nioch3gvofvj7pzx7f5gkuwx77u5nkgxao6qo654@3nvjifkrxcjb>
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
 <exb2lvjcozak5fayrgyenrd3ntii4jfxgvqork4klyz5pky2aq@dj2zyw5su6pv>
 <874je6b2g4.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5tmnnujq4ct6ko4m"
Content-Disposition: inline
In-Reply-To: <874je6b2g4.fsf@oltmanns.dev>


--5tmnnujq4ct6ko4m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Feb 18, 2024 at 09:29:15AM +0100, Frank Oltmanns wrote:
> Hi Maxime,
>=20
> On 2024-02-08 at 13:16:27 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> > [[PGP Signed Part:Undecided]]
> > On Mon, Feb 05, 2024 at 04:22:26PM +0100, Frank Oltmanns wrote:
> >> According to the Allwinner User Manual, the Allwinner A64 requires
> >> PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.
> >>
> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> >> ---
> >>  drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
> >>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
> >>  2 files changed, 15 insertions(+)
> >>
> >> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu=
_nkm.c
> >> index 1168d894d636..7d135908d6e0 100644
> >> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> >> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> >> @@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct cc=
u_mux_internal *mux,
> >>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
> >>  		rate *=3D nkm->fixed_post_div;
> >>
> >> +	if (nkm->min_rate && rate < nkm->min_rate)
> >> +		rate =3D nkm->min_rate;
> >> +
> >> +	if (nkm->max_rate && rate > nkm->max_rate)
> >> +		rate =3D nkm->max_rate;
> >> +
> >
> > This is provided by the clock range already. If you call
> > clk_hw_set_rate_range, it should work just fine.
>=20
> I have to admit, that I don't know that much about sunxi-ng or the CCF
> and therefore humbly request some guidance.
>=20
> I've looked at other examples of clk_hw_set_rate_range() usage and it
> seems there is not a lot of adoption for this functionality even though
> it was already introduced mid-2015. This makes me wonder, why that is.

There's no reason, really. I would expect a big part of it to be "if it
works don't fix it" :)

> Anyhow, it seems in all examples I found, clk_hw_set_rate_range() is
> called immediately after registering the clk_hw. So, in the case of
> sunxi-ng, we'd need to do that in sunxi_ccu_probe, which is a common
> function for all sunxi-ng clock types. Correct?

Yup.

> If so, surely, you don't want me to introduce clock type specific code
> to a common function, so I assume you want min_rate and max_rate to
> become members of struct ccu_common. Correct?

Yes, that would be reasonable indeed.

> If so, since there already are some clock types in sunxi-ng that support
> having a minimum and maximum rate, these clocks should be refactored
> eventually. Correct?

I guess. I don't consider it to be a pre-requisite to your patch though.

> Finally, in sunxi-ng there is a feature of having a fixed_post_div (see,
> e.g., the first to lines of the diff above). It seems to me that CCF
> cannot know about these post_divs, so we'd also need to transfer the
> fixed_post_div to ccu_common and use that when calling
> clk_hw_set_rate_range. Correct?

Not really, no. The fixed post divider is an additional divider that
needs to be considered for the clock rate.

See the A64's periph0 PLL for example. Its fixed post divider is 2, and
its rate is 24MHz * N * K / 2. The rate should be bounded by its minimal
and maximal rate taking the post divider into account. The CCF doesn't
have to know about it.

Maxime

--5tmnnujq4ct6ko4m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdchOgAKCRDj7w1vZxhR
xeYcAQD8kfuph/bvW3AkRtRhUQiaaX8I5NZXLMQKI8xcnhEbcAD+Ld8/FcBSyHu3
/mny/ZO6Y0sXVbHPtYWYHq9nH0sHGA8=
=noRe
-----END PGP SIGNATURE-----

--5tmnnujq4ct6ko4m--

