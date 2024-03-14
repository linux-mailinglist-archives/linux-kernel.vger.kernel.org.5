Return-Path: <linux-kernel+bounces-103422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A7387BF2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876851C210AE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E170CD7;
	Thu, 14 Mar 2024 14:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/F+lDGS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5045D756;
	Thu, 14 Mar 2024 14:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427347; cv=none; b=jIkapjRFRUQj1Mp8iz6RqJF69JqwunoBuzmnW3FTCvAmo9cBPg0qoXQ11xNJP9EP+bTxhJ7K6YBazEQFFpS3YaMhxoWkRbIvEHmymwKAEZNW8QAKKubp5bTccffFptETenqyQSgobCiS7dYugWyeEv01DWH2A3mQPNZRDkO+Yow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427347; c=relaxed/simple;
	bh=t15/fUG8eEoCH9k/jfp6Z2u74HuUtlgqyLfEcx09Zp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9KUlO8kvmyWiaX7atqKzF54erh5xaoAa0DckbcwP7TBICcXWV1+g0Mjv0kpNrCEBv07XEbzHpqjEg+pUdLpfLLHr9wvrCqQIEZ+dLtKq76bPVO4Onfk5h9DYD0vTwoD5hmjx+dEqYNMipxkYsccR2Qri2c2gNRXOr7E2S1bkg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/F+lDGS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA74DC433C7;
	Thu, 14 Mar 2024 14:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427347;
	bh=t15/fUG8eEoCH9k/jfp6Z2u74HuUtlgqyLfEcx09Zp4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I/F+lDGS2y5xE5a5YA7GzDQLaThIZmXKLcUXFYPQFaGsCyeslKqQd7z1bZgb+ttps
	 p5mDSY9dX7k5N4dsQUhv1iOtQsRWuHo8AEQwqNHtJvj8iWE+28xfJ6cLUgkfpw5Dy6
	 FbdjrkPuMlr12cVAvOmggmYlSPsWGdjjeyY6KKSz6ONecqBDXb7gNac7Wp4FoC3dLc
	 6ZNoHDmv98FB+bCPD3Uy/z4vuqh9rh69Qy3RDzDbAMxENPSBF4hFT2fC09ubBRpWbv
	 ZDZoRRNkfMhzvDAdhzqCrY2AYJmjVfor08S+wsnhihdijuUoj0jTst4SswmtBSPxBn
	 G4RFR8dxu6BwA==
Date: Thu, 14 Mar 2024 15:42:24 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	Icenowy Zheng <uwu@icenowy.me>, Ondrej Jirman <x@xnux.eu>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: tcon: Support keeping dclk rate upon ancestor
 clock changes
Message-ID: <20240314-careful-silky-bear-8ee43f@houat>
References: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nskffof7joxt6vlb"
Content-Disposition: inline
In-Reply-To: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>


--nskffof7joxt6vlb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Mar 10, 2024 at 02:32:29PM +0100, Frank Oltmanns wrote:
> Allow the dclk to reset its rate when a rate change is initiated from an
> ancestor clock. This makes it possible to no longer to get an exclusive
> lock. As a consequence, it is now possible to set new rates if
> necessary, e.g. when an external display is connected.
>=20
> The first user of this functionality is the A64 because PLL-VIDEO0 is an
> ancestor for both HDMI and TCON0. This allows to select an optimal rate
> for TCON0 as long as there is no external HDMI connection. Once a change
> in PLL-VIDEO0 is performed when an HDMI connection is established, TCON0
> can react gracefully and select an optimal rate based on this the new
> constraint.
>=20
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
> I would like to make the Allwinner A64's data-clock keep its rate
> when its ancestor's (pll-video0) rate changes. Keeping data-clock's rate
> is required, to let the A64 drive both an LCD and HDMI display at the
> same time, because both have pll-video0 as an ancestor.
>=20
> TCONs that use this flag store the ideal rate for their data-clock and
> subscribe to be notified when data-clock changes. When rate setting has
> finished (indicated by a POST_RATE_CHANGE event) the call back function
> schedules delayed work to set the data-clock's rate to the initial value
> after 100 ms. Using delayed work maks sure that the clock setting is
> finished.
>=20
> I've implemented this functionality as a quirk, so that it is possible
> to use it only for the A64.
>=20
> This patch supersedes [1].
>=20
> This work is inspired by an out-of-tree patchset [2] [3] [4].
> Unfortunately, the patchset uses clk_set_rate() directly in a notifier
> callback, which the following comment on clk_notifier_register()
> forbids: "The callbacks associated with the notifier must not re-enter
> into the clk framework by calling any top-level clk APIs." [5]
> Furthermore, that out-of-tree patchset no longer works since 6.6,
> because setting pll-mipi is now also resetting pll-video0 and therefore
> causes a race condition.

Workqueues don't have an upper boundary on when they execute. As we
discussed multiple times, this should be solved in the clock framework
itself, not bypassing it.

Maxime

--nskffof7joxt6vlb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfMMzwAKCRDj7w1vZxhR
xQ1CAQDtICAPI7t6iHcGTsvHtbMc/Xou8mIobymUHWIa2ywO5QEAyvQlO/lPQtZc
I6gmabMvtrOKzIunluaotAq5NsaVYQY=
=IRk2
-----END PGP SIGNATURE-----

--nskffof7joxt6vlb--

