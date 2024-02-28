Return-Path: <linux-kernel+bounces-85348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F71186B48D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40D821C22D97
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A44715DBBC;
	Wed, 28 Feb 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZmZYn/w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960196EEF4;
	Wed, 28 Feb 2024 16:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137011; cv=none; b=NmbFf20wgQcGJEn1iNEJ8GDCcJU5XdDnVXaYuCimJet6aYqj1BzU2v+ZOLXMOjpNLt1eDScprFOJY7M+AVbVyXKppqwUByCwInqZlaS0TH6WjgH64EsTePYZhZjJMrBLk01EpAxZ0mYV74LDUPQAOYXdPcmkI4zGQ/W8WPuIdZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137011; c=relaxed/simple;
	bh=fErWKInGULVeVxqgQI2zMH4IGVMKKtYkJXd20L7xtH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mTbuFPdZrU6nNumVDV3sd8YngDPSV+5smjWYDAIbRkOrppNvd2/8iOlK22M9B5s8Lc17mCuhYJZPnuTAO8iCVl8NjISJIRLczI+Fc+2ZdBdoRFIkJhF1mcJ3EFqej6ukpPL4/+WiuTap/5n0RZTNZpmdNoR8Azc7G/Fx/mxncho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZmZYn/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB65FC433C7;
	Wed, 28 Feb 2024 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709137011;
	bh=fErWKInGULVeVxqgQI2zMH4IGVMKKtYkJXd20L7xtH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sZmZYn/wQtnIX3Ao7DScrIzuZTZ3OmuPwAm6201EzNpKwrM7pobEvjOs+wRU2Rk/f
	 NYhJ69FIupcA1l5fjn3ecGzgrtRyNeFj2bPjLMHFsrXnNUlO+ifepw73K5DWTBVwiS
	 /8ltKWfS6D7ubOtpSSG06ul0hV/Jekp8/X2T0UTM8hCgiOLmRRLKIQII2ZbMPQkHwq
	 WVD7NzgaXHzXS4SfcgoP8RiknLVnNzZ+B+/ZqRBuHgbNNtwtYj775EGgo7PkmEN5pw
	 ykI0fXySHnqeNMg+b7D/GX3TQYIXLmf3yjvgnZOtfpEepUFYWLCkU0s64SjBCmPPRq
	 0/Rl4/cJstcDQ==
Date: Wed, 28 Feb 2024 17:16:48 +0100
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
Message-ID: <20240228-nifty-flashy-shrew-905edc@houat>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-29-8f4af575fce2@kernel.org>
 <244fe6b9-f295-4c85-908a-014ada0033fa@igalia.com>
 <y7mxj2i56h7bcnonywjdf2eirdqil66k32drw3wb3z7juqr3ph@4u24mlrvxslc>
 <2693770c-0d27-4186-87e1-e55a0a5f17a5@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bzsukvurqrxvmgmq"
Content-Disposition: inline
In-Reply-To: <2693770c-0d27-4186-87e1-e55a0a5f17a5@igalia.com>


--bzsukvurqrxvmgmq
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 07:45:01PM -0300, Ma=EDra Canal wrote:
> Hi Maxime,
>=20
> On 2/27/24 10:02, Maxime Ripard wrote:
> > Hi Ma=EDra,
> >=20
> > Thanks for you reviews!
> >=20
> > On Mon, Feb 26, 2024 at 09:29:32AM -0300, Ma=EDra Canal wrote:
> > > On 2/22/24 15:14, Maxime Ripard wrote:
> > > > The vc4_dummy_plane structure is an exact equivalent to vc4_plane, =
so we
> > >=20
> > > Maybe I understood incorrectly, but isn't the vc4_dummy_plane structu=
re
> > > equivalent to drm_plane?
> >=20
> > Both statements are true :)
> >=20
> > vc4 itself uses vc4_plane to holds its plane-related content, but it
> > turns out that there's nothing in that structure anymore and vc4_plane
> > =3D=3D drm_plane.
> >=20
> > In our mock driver, we have another structure meant to store the
> > mock-plane-related content which doesn't have anything in it anymore,
> > and is thus equivalent to vc4_plane.
> >=20
> > So, basically, vc4_dummy_plane =3D=3D vc4_plane =3D=3D drm_plane.
> >=20
> > This patch is only about getting rid of vc4_dummy_plane though.
> >=20
> > Is it clearer?
> >=20
>=20
> Yeah, with that pointed out, you can add my:

I'll rephrase for the next version then

> Reviewed-by: Ma=EDra Canal <mcanal@igalia.com>

Thanks!
Maxime

--bzsukvurqrxvmgmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd9ccAAKCRDj7w1vZxhR
xQ/aAQDzU4vVfau883o71TzEeE+lysJ38XPUbtp9Q818fxbvSAD/TfNo9QsQjVLO
TjOhPuL8arGdUmexXtTS6jTunClBzAA=
=6H0O
-----END PGP SIGNATURE-----

--bzsukvurqrxvmgmq--

