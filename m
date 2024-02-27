Return-Path: <linux-kernel+bounces-83279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6D5869139
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F64B237F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C80AE13B28E;
	Tue, 27 Feb 2024 13:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpmbbDRj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0989113B285;
	Tue, 27 Feb 2024 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038976; cv=none; b=sJhe9cN2i7ORzDd9mOYO4GJuF1s3IOSBA5w0r9X6FnxtX8JpYQrOXu3ka9ZMBRslsNTcIsDwpTlFsrGJ9iEea1/nSd+aZ9CAkuuPZ3gdAWzaFONlxUNAwPEm5JaGx4GnJ5JESW7dJaco4mCWmttoU4NoPb1sBn+fFyLwJhJzlsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038976; c=relaxed/simple;
	bh=K8zljY/jOjHfxijTuYAHOGluUedQxnvvUsTqJTxkXzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lheQu2czqLTSeP4NK3mxt33Edb02KQjVy/vzbIwpmyC2cAXBhCnrSl0FIm+7M1+sjkkEwlaM63ZbXKCV2Jimg0wpyMUp6Fd3RdxGX+4rgSXmfY8r82rnPJZbRJepHBQ9PV5w9WFMgOKSQqs1ULqTgiwnSrJragLaGUDaH71vYSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpmbbDRj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFF9C433C7;
	Tue, 27 Feb 2024 13:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709038975;
	bh=K8zljY/jOjHfxijTuYAHOGluUedQxnvvUsTqJTxkXzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HpmbbDRj7DsgN7C+l0Nsac1JlsRLWmqQFqIGFCkbGxKteJFERSFF+sy5GSXwIUKOl
	 1kkVc2T/o/MNqrMmzbg17m2eYF6giueFjm/iXh9pf2CTrYHd47O+0DLs4CEziLmag8
	 lqW9T5vGj5jb4I/IQrlatzFgMDOEdJ/eRHcrhERUkTuHuE8WE+FOtIFVQzNJgQI/lj
	 OFaxV54oZfzgTYDOWj2C6vzyr4cJuzXRtb/dJdW0m/t2DP1h4rYOn8Igyw+lT1MbkT
	 /xuvt7TFgTDGlZKwg3dCxaPdPdNMiNJuceUy7f/c67/fGV4PZe0iHlh4EjMBSjdirU
	 qpD4wU3U97/2A==
Date: Tue, 27 Feb 2024 14:02:52 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Wick <sebastian.wick@redhat.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 29/36] drm/vc4: tests: Remove vc4_dummy_plane structure
Message-ID: <y7mxj2i56h7bcnonywjdf2eirdqil66k32drw3wb3z7juqr3ph@4u24mlrvxslc>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-29-8f4af575fce2@kernel.org>
 <244fe6b9-f295-4c85-908a-014ada0033fa@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cwsjmzyidxiy2r5i"
Content-Disposition: inline
In-Reply-To: <244fe6b9-f295-4c85-908a-014ada0033fa@igalia.com>


--cwsjmzyidxiy2r5i
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ma=EDra,

Thanks for you reviews!

On Mon, Feb 26, 2024 at 09:29:32AM -0300, Ma=EDra Canal wrote:
> On 2/22/24 15:14, Maxime Ripard wrote:
> > The vc4_dummy_plane structure is an exact equivalent to vc4_plane, so we
>=20
> Maybe I understood incorrectly, but isn't the vc4_dummy_plane structure
> equivalent to drm_plane?

Both statements are true :)

vc4 itself uses vc4_plane to holds its plane-related content, but it
turns out that there's nothing in that structure anymore and vc4_plane
=3D=3D drm_plane.

In our mock driver, we have another structure meant to store the
mock-plane-related content which doesn't have anything in it anymore,
and is thus equivalent to vc4_plane.

So, basically, vc4_dummy_plane =3D=3D vc4_plane =3D=3D drm_plane.

This patch is only about getting rid of vc4_dummy_plane though.

Is it clearer?

Maxime

--cwsjmzyidxiy2r5i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd3dfAAKCRDj7w1vZxhR
xQB3AQCM6yIbUIAvcz/rSyKw6mmw6G4nrZh7GPft2T1APOLu4wEAylXMYpdYV8KH
P8oZ7t3+gt3/8m9lr6IwSflU4vD4bwI=
=qSeA
-----END PGP SIGNATURE-----

--cwsjmzyidxiy2r5i--

