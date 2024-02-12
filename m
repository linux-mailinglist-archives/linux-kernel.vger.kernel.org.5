Return-Path: <linux-kernel+bounces-61276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 922E885103B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22892289319
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A44418036;
	Mon, 12 Feb 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vRdcfGdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524A05244;
	Mon, 12 Feb 2024 10:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732070; cv=none; b=RHo4JKsS12kA7Rx+FWwZUwvXZaiFUD37VD7XhXBfqUnJ0wsHqu6wiTlkzg5TozZwyUsnxKq0amWx03ysyQA2pnIi4Jr62Woi29SljbsGydyf7sfrnFRHFVQGEKQKcGXzfPyrFbiehzhgREjd3dkdJ8mrDSjaGFUoIDU9XCKGP1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732070; c=relaxed/simple;
	bh=ZV4pECgPYcbYpTFYE/HHDZCGaJXwRLM519uxPcGBl0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKSuZrig1GVtHjpM6uqtZY8wBSkBw3q0hEPwC+TGxjHRqOoo4RibGAVvMggxICaXNhLiLkKCcOku8kLtVgRCNerQ3YNG1qiXC2/LNeOv37VSjcAFStQXba2jx/cY9RB7a44XzR5Gi+GaUuZDYg3NbcorZLl2IFIok7y5Pnd8CEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vRdcfGdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76253C433F1;
	Mon, 12 Feb 2024 10:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707732069;
	bh=ZV4pECgPYcbYpTFYE/HHDZCGaJXwRLM519uxPcGBl0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vRdcfGdNCOnmnB8/dcuM1aTGBkhnZCU+s8sdi2HDhKo1bAM9sweGpXpaiAluc56DU
	 6M+uTI+N44afTG92KjSZS06Cfpa3OKXGNfTgQHDL2jFuLI3Rng7DXh+ZJI3cWNlsJS
	 BrKiT9j7VQH3iQOQrybjasLvm2WVuEaU0eflNduPT/sjhtKqTrydzL3flueiwkwNlu
	 f/aJmEAyfDnbIhycldNE2lW71I6zwId6r2BydT7BXebgkkBpsQreTcUL1iJlcsiVx/
	 1f3nRZU3Jb4tGQY9zd4Z/FxH4FKFD7uYhtz7fG5gF60eK1onGRgp31xxYoRYOP9X6S
	 MgypK9eU7VjMA==
Date: Mon, 12 Feb 2024 11:01:07 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sebastian Wick <sebastian.wick@redhat.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, 
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Hans Verkuil <hverkuil@xs4all.nl>, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add
 Broadcast RGB property
Message-ID: <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jve3saefgwx6cqdm"
Content-Disposition: inline
In-Reply-To: <20240209203435.GB996172@toolbox>


--jve3saefgwx6cqdm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrj=E4l=E4 wrote:
> > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrj=E4l=E4 wrote:
> > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > Hi,
> > > > > >=20
> > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > > >  /**
> > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > >   *
> > > > > > > > > + * Broadcast RGB
> > > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Li=
mited) used.
> > > > > > > > > + *      Infoframes will be generated according to that v=
alue.
> > > > > > > > > + *
> > > > > > > > > + *      The value of this property can be one of the fol=
lowing:
> > > > > > > > > + *
> > > > > > > > > + *      Automatic:
> > > > > > > > > + *              RGB Range is selected automatically base=
d on the mode
> > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > + *
> > > > > > > > > + *      Full:
> > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > + *
> > > > > > > > > + *      Limited 16:235:
> > > > > > > > > + *              Limited RGB Range is forced. Unlike the =
name suggests,
> > > > > > > > > + *              this works for any number of bits-per-co=
mponent.
> > > > > > > > > + *
> > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > > + *
> > > > > > > >=20
> > > > > > > > This is a good time to document this in more detail. There =
might be two
> > > > > > > > different things being affected:
> > > > > > > >=20
> > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > 2. The color pipeline processing
> > > > > > > >=20
> > > > > > > > All values of Broadcast RGB always affect the color pipelin=
e processing
> > > > > > > > such that a full-range input to the CRTC is converted to ei=
ther full- or
> > > > > > > > limited-range, depending on what the monitor is supposed to=
 accept.
> > > > > > > >=20
> > > > > > > > When automatic is selected, does that mean that there is no=
 signalling,
> > > > > > > > or that the signalling matches what the monitor is supposed=
 to accept
> > > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > >=20
> > > > > > > > When full or limited is selected and the monitor doesn't su=
pport the
> > > > > > > > signalling, what happens?
> > > > > > >=20
> > > > > > > Forgot to mention: user-space still has no control over RGB v=
s YCbCr on
> > > > > > > the cable, so is this only affecting RGB? If not, how does it=
 affect
> > > > > > > YCbCr?
> > > > > >=20
> > > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks=
 like if
> > > > > > we're using a YCbCr format, i915 will always use a limited rang=
e while
> > > > > > vc4 will follow the value of the property.
> > > > >=20
> > > > > The property is literally called "Broadcast *RGB*".
> > > > > That should explain why it's only affecting RGB.
> > > >=20
> > > > Right. And the limited range option is called "Limited 16:235" desp=
ite
> > > > being usable on bpc > 8 bits. Naming errors occurs, and history hap=
pens
> > > > to make names inconsistent too, that's fine and not an argument in
> > > > itself.
> > > >=20
> > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > to enable it.
> > > >=20
> > > > vc4 supports it.
> > >=20
> > > Someone implemented it incorrectly then.
> >=20
> > Incorrectly according to what documentation / specification? I'm sorry,
> > but I find it super ironic that i915 gets to do its own thing, not
> > document any of it, and when people try to clean things up they get told
> > that we got it all wrong.
>=20
> FWIW, this was an i915 property and if another driver uses the same
> property name it must have the same behavior. Yes, it isn't standardized
> and yes, it's not documented (hence this effort here) but it's still on
> vc4 to make the property compatible.

How is it not compatible? It's a superset of what i915 provides, but
it's strictly compatible with it.

I would argue that i915 is the broken one since userspace could force a
full range output, but since the driver takes the YUV vs RGB decision
itself and only supports limited range for YUV, the driver would
effectively ignore that user-space property, without the user-space
being able to tell it was ignored in the first place.

> Trying to make the property handle YCbCr is very much in the "let's try
> to fix the property" territory that I want to avoid, so I'm in favor of
> adjusting vc4.

Breaking the ABI in the process. For something that is explicitly
supported by the spec, the driver, and the hardware. On a property that
never said it wasn't meant to be used that way, and with semantics based
on a driver that never provided a way to check those restrictions in the
first place.

And it's not like i915 is going to use that code anyway.

Maxime

--jve3saefgwx6cqdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZcnsYgAKCRDj7w1vZxhR
xbXvAQCwcVIa0ZIBiFB60+Djxs5Q9r6KT+VmRcFEid+4vu5kmAD/SoSSxALs4Fec
o0UKGT8WuF+A9QWBqCkljcQ1i+X1aAA=
=q4Ag
-----END PGP SIGNATURE-----

--jve3saefgwx6cqdm--

