Return-Path: <linux-kernel+bounces-40086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EAFD83DA01
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 13:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74B11F2630D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC3118AF4;
	Fri, 26 Jan 2024 12:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQ/qzxE5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FD3E1805E;
	Fri, 26 Jan 2024 12:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706271314; cv=none; b=Rl+vDvZzrTGRo0bYOi65qHNnTectnP/LJLprNdc1qMo4Ust526vMUEMdsvuPXDcvJ74BAeSDX7dJdhSQ2/QQDce4eXtH3TpY3KcYksuZH/t1L2s5L/9nAitMiO28SqYUjinxJJss8hyH90kGmLHxPuoBVeCLIhOWkAHXOBSOlrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706271314; c=relaxed/simple;
	bh=HJOduO1JjpKeSMWHdo7UhDLFHAL2ERhNtFLf9tTl7/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VzeuBVn96FWoekAveXvDelEf0CneIBEw5EcV4CsTP6ijpSDAUl9AH/D75ja2H5mhojwrp/4BuHDAlkqeEz+EBkODZZ7OVtq1C9f/rDgJO0pbinikXCIghS9CtJANHbcTCHRq4EFRP1r7sVyMJ2wrwPprEYGpe4sMHc8LPYWk3/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQ/qzxE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C1CC43390;
	Fri, 26 Jan 2024 12:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706271313;
	bh=HJOduO1JjpKeSMWHdo7UhDLFHAL2ERhNtFLf9tTl7/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQ/qzxE5wGewrakIg8oLGEkwJ54mnPdktyre3AdnzZTooJ62cM2wyo/1c2eQ52CMd
	 5v8345kQSl3s0+GH9MuiP1gFKCALyPqldWAX4Ye6aYB49AnY9r0nl1cBXjLTncedWR
	 xkZL4H9TIHmW7Sa5aJX9M+YIeBeR3NDIw4rQ1+9jJGtie+lImWVD7uZk4HVP7cKSCB
	 vs74U+EZsVGbSXX4DfbYu0vs9zpuTrrmwWchH393i8gJCfxt8O0dbMwDlmKN5M0v/4
	 URpRWrM0l71BkDwt4rB3mbQYdvhL5k50VuzWZW0gtl6B9TTUs5mACbQ78Wv5Byo9Jn
	 j72HbCOhq6M/g==
Date: Fri, 26 Jan 2024 13:15:10 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Devarsh Thakkar <devarsht@ti.com>
Cc: jyri.sarha@iki.fi, tomi.valkeinen@ideasonboard.com, airlied@gmail.com, 
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, tzimmermann@suse.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, kristo@kernel.org, praneeth@ti.com, 
	a-bhatia1@ti.com, j-luthra@ti.com
Subject: Re: [RFC PATCH 2/3] drm/tidss: Add support for display sharing
Message-ID: <vgfzhamtiwkpdyk5ndagsb63subclinotoe6tsi3wu6z7454ec@igxfzjc5gyqm>
References: <20240116134142.2092483-1-devarsht@ti.com>
 <20240116134142.2092483-3-devarsht@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eefocgpe5td6sveu"
Content-Disposition: inline
In-Reply-To: <20240116134142.2092483-3-devarsht@ti.com>


--eefocgpe5td6sveu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Thanks a lot for working on that.

On Tue, Jan 16, 2024 at 07:11:41PM +0530, Devarsh Thakkar wrote:
> Display subsystem present in TI Keystone family of devices supports shari=
ng
> of display between multiple hosts as it provides separate register space
> (common* region) for each host to programming display controller and also=
 a
> unique interrupt line for each host.
>=20
> This adds support for display sharing, by allowing partitioning of
> resources either at video port level or at video plane level as
> described below :
>=20
> 1) Linux can own (i.e have write access) completely one or more of video
> ports along with corresponding resources (viz. overlay managers,
> video planes) used by Linux in context of those video ports.
> Even if Linux is owning
> these video ports it can still share this video port with a remote core
> which can own one or more video planes associated with this video port.
>=20
> 2) Linux owns one or more of the video planes with video port
> (along with corresponding overlay manager) associated with these planes
> being owned and controlled by a remote core. Linux still has read-only
> access to the associated video port and overlay managers so that it can
> parse the settings made by remote core.

So, just to make sure we're on the same page. 1) means Linux drives the
whole display engine, but can lend planes to the R5? How does that work,
is Linux aware of the workload being there (plane size, format, etc) ?

And 2) would mean that the display engine is under the R5 control and
Linux only gets to fill the plane and let the firmware know of what it
wants?

If so, do we even need the tidss driver in the second case? We could
just write a fwkms driver of some sorts that could be used by multiple
implementations of the same "defer to firmware" logic.

> For both the cases, the resources used in context of processing core
> running Linux along with ownership information are exposed by user as
> part of device-tree blob and driver uses an updated feature list tailored
> for this shared mode accordingly. The driver also auto-populates
> matching overlay managers and output types from shared video
> port list provided in device-tree blob.
> In dispc_feature struct remove const access specfier for output_type
> array as it is required to be updated dynamically in run-time for shared
> mode.

I'm also not entirely sure that the device tree is the right path there.
Surely the firmware capabilities will evolve over time, while the device
tree won't. Is there some way to make it discoverable at probe time by
the driver?

Maxime

--eefocgpe5td6sveu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbOiTgAKCRDj7w1vZxhR
xUZHAQC9UEm2aY+VJZIu3cY6lpRxt2+gjm/F09tvTETL6uyTGwD/YkQWVcLu/vz4
MgJdyfGZKivewFLe/q0RCkDicEbLcQI=
=YUl/
-----END PGP SIGNATURE-----

--eefocgpe5td6sveu--

