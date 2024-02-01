Return-Path: <linux-kernel+bounces-48162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB51684581E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC80E1C238F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40121DFF3;
	Thu,  1 Feb 2024 12:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VG2TeXqv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8186645;
	Thu,  1 Feb 2024 12:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791879; cv=none; b=NEbKthR7KDB36Dsm1MXCL1aH/OW0nYpJCXhE6EOvMxQI6oBgaoePOfB9F+cl215C/5kEtv7Jh9Vv+wmClKATK6a4iepx42+Ii/dIa9b/UfTIQT44lmqS6AXIo8uJR9iYSYkz4szi/eeDxJVLE2+kSzw8NYVbSfXXoGJazFB0atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791879; c=relaxed/simple;
	bh=iO+Eo8pPglcxEzFGDR/NbmaGU1weyDXreVR1dhmvHfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BU6Uilh/3Bu4lu1s94Sps9ggfaww2gGJeozR5fFbi8InMUe8JdAHqPzpb3kFhlwRpXGBP7OA98xrjtTBmJFhbyHdA1DeEMRF7QjskXqEg31nZc7d2CD9aWzPhA2nHiMWYDLLeqh6WxlU4/MGmvonuIgoLzfcEHWo1ssRjas4qys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VG2TeXqv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C37FC433C7;
	Thu,  1 Feb 2024 12:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706791878;
	bh=iO+Eo8pPglcxEzFGDR/NbmaGU1weyDXreVR1dhmvHfA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VG2TeXqvjxGcRv1tIL7nOyafkaL7z3CCvzIcS+2JApyFPDRQM0dhUM3PKC9rui9W7
	 opOWXzX3wf+INRuwos5WuH4cf3M6JbqJJyg+LLI0aU/Mjafxp/zI/6LLOjymUIwDoC
	 VDSk9ZulqP9mhOGNO91YqNdrN/xj0ITM+fgsH8po+qhjWD78Oni1Q/PDRrpA8716mK
	 q7pVitaQP60mvxztWefD4GBlghOrGBUOghPd2F99j+OOahvR6F8gTncbv1qJZI/FBz
	 m1WAK/Vazl7vTC3aR4c4aWHK20XFT2GuwJVRCjUR6Z4saoYMDPtpDx3hv0SXZYc5LH
	 BbV/B+1mMlIrg==
Date: Thu, 1 Feb 2024 13:51:15 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Hans Verkuil <hverkuil@xs4all.nl>, 
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: Re: [PATCH v5 15/44] drm/connector: hdmi: Compute bpc and format
 automatically
Message-ID: <jlkoofv7nszj2uqmo2672yo4wjd3yjqarge2l2hxofixcchu6a@j72pa4iybitd>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-15-6538e19d634d@kernel.org>
 <CAPY8ntBQ+qY9441-rMzq_JAoYAaY_r+E-ADv7Wry0tJNTzKpwg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vqybhtpmawkwvb6z"
Content-Disposition: inline
In-Reply-To: <CAPY8ntBQ+qY9441-rMzq_JAoYAaY_r+E-ADv7Wry0tJNTzKpwg@mail.gmail.com>


--vqybhtpmawkwvb6z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 03:10:43PM +0000, Dave Stevenson wrote:
> > +static bool
> > +sink_supports_format_bpc(const struct drm_connector *connector,
> > +                        const struct drm_display_info *info,
> > +                        const struct drm_display_mode *mode,
> > +                        unsigned int format, unsigned int bpc)
> > +{
> > +       struct drm_device *dev =3D connector->dev;
> > +       u8 vic =3D drm_match_cea_mode(mode);
> > +
> > +       if (vic =3D=3D 1 && bpc !=3D 8) {
> > +               drm_dbg(dev, "VIC1 requires a bpc of 8, got %u\n", bpc);
> > +               return false;
> > +       }
> > +
> > +       if (!info->is_hdmi &&
> > +           (format !=3D HDMI_COLORSPACE_RGB || bpc !=3D 8)) {
> > +               drm_dbg(dev, "DVI Monitors require an RGB output at 8 b=
pc\n");
> > +               return false;
> > +       }
> > +
> > +       if (!(connector->hdmi.supported_formats & BIT(format))) {
> > +               drm_dbg(dev, "%s format unsupported by the connector.\n=
",
> > +                       drm_hdmi_connector_get_output_format_name(forma=
t));
> > +               return false;
> > +       }
> > +
> > +       switch (format) {
> > +       case HDMI_COLORSPACE_RGB:
> > +               drm_dbg(dev, "RGB Format, checking the constraints.\n");
> > +
> > +               if (!(info->color_formats & DRM_COLOR_FORMAT_RGB444))
> > +                       return false;
>=20
> We've dropped this check from vc4 in our downstream kernel as it stops
> you using the prebaked EDIDs (eg drm.edid_firmware=3Dedid/1024x768.bin),
> or any other EDID that is defined as an analog monitor.
> The EDID parsing bombs out at [1], so info->color_formats gets left at 0.

Right, but it only does so if the display isn't defined as a digital displa=
y...

> RGB is mandatory for both DVI and HDMI, so rejecting it seems overly fuss=
y.

=2E.. which is required for both DVI and HDMI.

And sure enough, if we decode that EDID:

edid-decode (hex):

00 ff ff ff ff ff ff 00 31 d8 00 00 00 00 00 00
05 16 01 03 6d 23 1a 78 ea 5e c0 a4 59 4a 98 25
20 50 54 00 08 00 61 40 01 01 01 01 01 01 01 01
01 01 01 01 01 01 64 19 00 40 41 00 26 30 08 90
36 00 63 0a 11 00 00 18 00 00 00 ff 00 4c 69 6e
75 78 20 23 30 0a 20 20 20 20 00 00 00 fd 00 3b
3d 2f 31 07 00 0a 20 20 20 20 20 20 00 00 00 fc
00 4c 69 6e 75 78 20 58 47 41 0a 20 20 20 00 55

----------------

Block 0, Base EDID:
  EDID Structure Version & Revision: 1.3
  Vendor & Product Identification:
    Manufacturer: LNX
    Model: 0
    Made in: week 5 of 2012
  Basic Display Parameters & Features:
    Analog display
    Signal Level Standard: 0.700 : 0.000 : 0.700 V p-p
    Blank level equals black level
    Sync: Separate Composite Serration
    Maximum image size: 35 cm x 26 cm
    Gamma: 2.20
    DPMS levels: Standby Suspend Off
    RGB color display
    First detailed timing is the preferred timing
  Color Characteristics:
    Red  : 0.6416, 0.3486
    Green: 0.2919, 0.5957
    Blue : 0.1474, 0.1250
    White: 0.3125, 0.3281
  Established Timings I & II:
    DMT 0x10:  1024x768    60.003840 Hz   4:3     48.363 kHz     65.000000 =
MHz
  Standard Timings:
    DMT 0x10:  1024x768    60.003840 Hz   4:3     48.363 kHz     65.000000 =
MHz
  Detailed Timing Descriptors:
    DTD 1:  1024x768    60.003840 Hz   4:3     48.363 kHz     65.000000 MHz=
 (355 mm x 266 mm)
                 Hfront    8 Hsync 144 Hback  168 Hpol N
                 Vfront    3 Vsync   6 Vback   29 Vpol N
    Display Product Serial Number: 'Linux #0'
    Display Range Limits:
      Monitor ranges (GTF): 59-61 Hz V, 47-49 kHz H, max dotclock 70 MHz
    Display Product Name: 'Linux XGA'
Checksum: 0x55

----------------

Warnings:

Block 0, Base EDID:
  Detailed Timing Descriptor #1: DTD is similar but not identical to DMT 0x=
10.

EDID conformity: PASS

So, if anything, it's the EDID that needs to be updated, not the code there.
Maxime

--vqybhtpmawkwvb6z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZbuTwwAKCRDj7w1vZxhR
xStzAQDYM7L7UXag4iNuhrqdZjT3FFQPKQRkvAlVCUNanR6aCQEAkg4xQyzE9/jz
b81DQAxlvCB4Ne7NX/cfiEPrXcR93Q0=
=Fb2U
-----END PGP SIGNATURE-----

--vqybhtpmawkwvb6z--

