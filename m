Return-Path: <linux-kernel+bounces-49875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D13AD8470C8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 711241F27965
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFA0182CA;
	Fri,  2 Feb 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk52/yef"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D24210E8;
	Fri,  2 Feb 2024 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878902; cv=none; b=VRR2+LPcxFlXO1kW4EqX5IgIErfs4cuGnkhpRL/qpwt0DM1aZ3AISdfRONjNywEUKKNuiHKMbDaOrnF4almRqAOIoInjzLkZabNwQp+2tmb+fEiOdz78xDoKzHURb10n5s15GGqHs8OfT+oaVrc5x1l4lj+wicBa9If//RNI25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878902; c=relaxed/simple;
	bh=ZjGVUgcdYqjFELWbtS5Tz+gafK6SLtjIYXwEYo18YXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lwlp1bbvGXNxCG5EyyNWbPK2jEUYH4sQ0NzWw4iAzSYmSNsmHVQCzCl/77Sw6WYsphX0FoPfmoYLeE6KDnfI3chh9fXGiP95J1HatK71nYtfJEXHlgDUelD6CnkcJ/BzBGP5simandsmv/c20WStXX+hMmXcSSQwGKPEkiR4KDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk52/yef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E34C433F1;
	Fri,  2 Feb 2024 13:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706878902;
	bh=ZjGVUgcdYqjFELWbtS5Tz+gafK6SLtjIYXwEYo18YXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rk52/yefcJ7xC9MuTUP9sVCJC4n6DX/+ofLVOsiOkeAH60dIBnk2fZXv9ByUydBSm
	 DtqxnIWw/Mom3yYSOahogiwlITZbO6GPKqH6MT9Kdr8LoJYR+meY7ea3x86U/vmdK4
	 jRDsbJiXrCZxHBdA/8os4Npi7r/i1RsmqZO0HydLSMRy0rWgj6ua7CH416PSWMz9pG
	 0eAtdr7brPlRIP4fC1N9uM9JlSNyxx5dHaPSkw9vVrEL5j6Xw4EmSZSGqLZYN6CIUl
	 apPnlO5ZVBPs/+JA5YylF5MM9Ainw7YQkJYQDn356jUppnedKDWil6gE6ptW+ae8v4
	 30Y4ACuH/ziuw==
Date: Fri, 2 Feb 2024 14:01:39 +0100
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
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6dznigm7bfdw265q"
Content-Disposition: inline
In-Reply-To: <20240115143720.GA160656@toolbox>


--6dznigm7bfdw265q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > >  /**
> > >   * DOC: HDMI connector properties
> > >   *
> > > + * Broadcast RGB
> > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > + *      Infoframes will be generated according to that value.
> > > + *
> > > + *      The value of this property can be one of the following:
> > > + *
> > > + *      Automatic:
> > > + *              RGB Range is selected automatically based on the mode
> > > + *              according to the HDMI specifications.
> > > + *
> > > + *      Full:
> > > + *              Full RGB Range is forced.
> > > + *
> > > + *      Limited 16:235:
> > > + *              Limited RGB Range is forced. Unlike the name suggest=
s,
> > > + *              this works for any number of bits-per-component.
> > > + *
> > > + *      Drivers can set up this property by calling
> > > + *      drm_connector_attach_broadcast_rgb_property().
> > > + *
> >=20
> > This is a good time to document this in more detail. There might be two
> > different things being affected:
> >=20
> > 1. The signalling (InfoFrame/SDP/...)
> > 2. The color pipeline processing
> >=20
> > All values of Broadcast RGB always affect the color pipeline processing
> > such that a full-range input to the CRTC is converted to either full- or
> > limited-range, depending on what the monitor is supposed to accept.
> >=20
> > When automatic is selected, does that mean that there is no signalling,
> > or that the signalling matches what the monitor is supposed to accept
> > according to the spec? Also, is this really HDMI specific?
> >=20
> > When full or limited is selected and the monitor doesn't support the
> > signalling, what happens?
>=20
> Forgot to mention: user-space still has no control over RGB vs YCbCr on
> the cable, so is this only affecting RGB? If not, how does it affect
> YCbCr?

So I dug a bit into both the i915 and vc4 drivers, and it looks like if
we're using a YCbCr format, i915 will always use a limited range while
vc4 will follow the value of the property.

I guess the best way to reconcile that would be to state that it also
controls the YCbCr range, and i915 can choose to reject/adjust the
configurations it can't support.

Does that make sense?

Maxime

--6dznigm7bfdw265q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbznsgAKCRDj7w1vZxhR
xY65AP4thN3Jypd+NMHjCI2DGcLcaa/6C19RZkReczuElu+gZwEA4x7ld5E6OIjM
5nF1e+nTxH1f21uOqX5xJzdswy85Rw8=
=NO9C
-----END PGP SIGNATURE-----

--6dznigm7bfdw265q--

