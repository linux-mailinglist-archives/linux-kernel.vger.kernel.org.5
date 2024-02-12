Return-Path: <linux-kernel+bounces-61265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4883085101C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4851C21F26
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38CC18643;
	Mon, 12 Feb 2024 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFNq4/4I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376C0182A3;
	Mon, 12 Feb 2024 09:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707731735; cv=none; b=uWMjiPMuzDksesfVFsiz2Gjmm9BjbGqsa9aC4VngeNh/1LLE6nhsZC75Vge+szBWGU/Cx/W/nY/64kDtvmjJFcvCo7Um0UFqvWxA/6caMa9w81LWU0WRW+kaZzuITgTAVnNR5JKOjlRjXIYbfZN49IfHW26EW3dPVHPFCqi4Cww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707731735; c=relaxed/simple;
	bh=HK3iN31Pdycw3MOndavpvQN/41z5gCD2Ck3qqfmyiTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIwi9eBe3FNvTrWyNI7vYN2+7rVAFbZJ9iSXQjy76yOmXxfuzShgnWyN0thWqI93BZ86ICWc2B3d/Xsa74UmTX17aO8UvxNzh8hWnEdhdImEuvrao8UfCMnQA9viq+WTuDsyDzCV2zli97A5J2rn7v5JVlZzS2ewz9vPZJPlnK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFNq4/4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596F5C43390;
	Mon, 12 Feb 2024 09:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707731734;
	bh=HK3iN31Pdycw3MOndavpvQN/41z5gCD2Ck3qqfmyiTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pFNq4/4IdY9eJyoHNAwY5F9Id/Ux8i6kjVF+JRKTg6rQknYC8wuz2aFCFY+hK4ZZ6
	 njuc8tqL2aDz3mWhZzl1w65nMHCnez1weC5BUMOmNmU88ZDqQoek6wNSTwGAWFsqKF
	 QwDyl3+WfEAOPKih8vspHwOsxGX873v/QJWwqoSH2FRgARQa4/D3vMmmiK423muhQl
	 7Uyas/g7GVxrnyEVbKKS8cpGKbqlSooxsjmop/L0AbjHqQ0PSnFn/mclIUKw8eA+xL
	 OZ3oSB4BbVMzmbpapZljzKSU18kT6Rk7iHRc20M4BpNfRQOON1gQLiQICaRK2PsxIP
	 I3XJ1K8595Lfw==
Date: Mon, 12 Feb 2024 10:55:32 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <uplclresnokchsgutsd27ihv4422sob77reobw6ygx3c3cqnti@hjmrhut7l5r5>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <niqn7eql5neyfp5ficdfisdpmlwrprovqn5g7lgcfwoe74ds23@7fr4yv2miqe7>
 <20240209203046.GA996172@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="la6nsuu6qrx5qt32"
Content-Disposition: inline
In-Reply-To: <20240209203046.GA996172@toolbox>


--la6nsuu6qrx5qt32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:30:46PM +0100, Sebastian Wick wrote:
> On Fri, Feb 02, 2024 at 04:49:04PM +0100, Maxime Ripard wrote:
> > Hi Sebastian,
> >=20
> > On Mon, Jan 15, 2024 at 03:33:08PM +0100, Sebastian Wick wrote:
> > > >  /**
> > > >   * DOC: HDMI connector properties
> > > >   *
> > > > + * Broadcast RGB
> > > > + *      Indicates the RGB Quantization Range (Full vs Limited) use=
d.
> > > > + *      Infoframes will be generated according to that value.
> > > > + *
> > > > + *      The value of this property can be one of the following:
> > > > + *
> > > > + *      Automatic:
> > > > + *              RGB Range is selected automatically based on the m=
ode
> > > > + *              according to the HDMI specifications.
> > > > + *
> > > > + *      Full:
> > > > + *              Full RGB Range is forced.
> > > > + *
> > > > + *      Limited 16:235:
> > > > + *              Limited RGB Range is forced. Unlike the name sugge=
sts,
> > > > + *              this works for any number of bits-per-component.
> > > > + *
> > > > + *      Drivers can set up this property by calling
> > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > + *
> > >=20
> > > This is a good time to document this in more detail. There might be t=
wo
> > > different things being affected:
> > >=20
> > > 1. The signalling (InfoFrame/SDP/...)
> > > 2. The color pipeline processing
> > >=20
> > > All values of Broadcast RGB always affect the color pipeline processi=
ng
> > > such that a full-range input to the CRTC is converted to either full-=
 or
> > > limited-range, depending on what the monitor is supposed to accept.
> > >=20
> > > When automatic is selected, does that mean that there is no signallin=
g,
> > > or that the signalling matches what the monitor is supposed to accept
> > > according to the spec? Also, is this really HDMI specific?
> > >=20
> > > When full or limited is selected and the monitor doesn't support the
> > > signalling, what happens?
> >=20
> > Leaving the YCbCr vs RGB discussion aside, would this be better ?
>=20
> Yes, it is. Thanks.

Great, it'll be in the next version.

> We do have to resolve the YCbCr vs RGB issue though.
>=20
> >  * Broadcast RGB (HDMI specific)
> >  *      Indicates the Quantization Range (Full vs Limited) used. The co=
lor
> >  *      processing pipeline will be adjusted to match the value of the
>=20
> Ah, another thing no note here is that the CRTC as configured by user
> space must always produce full range pixels.

Added too

Thanks

--la6nsuu6qrx5qt32
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcnrEwAKCRDj7w1vZxhR
xdDpAQCDVmx87SVGeVycmXmU4sk+7XyYR3FCEEqCdeOHZuh2qQD/YieE0hT/nf54
5ulv0+EGxYyUNUob/q6HmPUhR3V7pQ8=
=P7ka
-----END PGP SIGNATURE-----

--la6nsuu6qrx5qt32--

