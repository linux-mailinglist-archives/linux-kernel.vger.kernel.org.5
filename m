Return-Path: <linux-kernel+bounces-83364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41586869563
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEA728B3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50825143C6E;
	Tue, 27 Feb 2024 14:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p33FKrEl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682191420A2;
	Tue, 27 Feb 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042489; cv=none; b=htDEhn9S0f4HN93qWv0UfHNsytj56i4ftwU2xTi2BnS2UMr1IkgnUV1nAFcgu6rORN7zqfKm9w7L/5Lnj/oiYKDE/w6PoQE6l7Kof3g2VBQddAjLI7yVt5AaGR17jJ23SAxYXCsZo1WzNwx5b7sayExC6NpqdEzn0XGx6d723G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042489; c=relaxed/simple;
	bh=xCkbRrGm9KUzkhAwbM6To2Tg2wmXxpHrMpykco6RiTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFn20vHxjNKmRDcc8u54VE20fof4oLA0MyYSfKPcwULKmQIzwQFPBrWpbRfGXCi5iCJtEj/wyoxVg7xFCye5Nfm0RnGIKTfl4wdSAYeEdHIurDmBOz1eSxncjC5SFe1/tmZzRwgCx/KJB+amDOACq6Ukt9d5R68P9pyK4Rb870E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p33FKrEl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63BFC433A6;
	Tue, 27 Feb 2024 14:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709042489;
	bh=xCkbRrGm9KUzkhAwbM6To2Tg2wmXxpHrMpykco6RiTk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p33FKrElIhnO0+GzW7v95ecGNxi2xlWdfACIJ9+rCODu23YXF1i/U0loqeowLj84C
	 qE6SLxpSV9oNwcGsiNZFQ1KKLRLf4YVyPfa7O8VkLxx5+QHXAgW0qJQhI6gFt6Ge+D
	 lq4RhnOMlMc9FgPDkmsEo8IDRRGU6fUj7EMQxtBStiDAYmla5WXJ/TR5Sxj34h5M4q
	 Cl6BpbMd0j+dw/8bgmrqiFRXIGt9LqPZcMTCh+n/OpI2oQIE9X/8ACIXU+CMXLEk24
	 Z+CtdpBqZacoDkMufgdizq5qXbaPf/SVe3ShBuwFdeTffz1kc5436fwY+HOQXAPPRx
	 OUhjcEXEF+prA==
Date: Tue, 27 Feb 2024 15:01:26 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
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
Subject: Re: [PATCH v7 19/36] drm/connector: hdmi: Compute bpc and format
 automatically
Message-ID: <vsetubfn5uvdczjrhyu6jprefdqqglpkgyw6ejbxbjypxqaxrs@u6g7cwbawrih>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-19-8f4af575fce2@kernel.org>
 <67e9fbc5-ed7f-48b9-ae2a-e07c5fbd2218@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nj3gdbp5aimebgk5"
Content-Disposition: inline
In-Reply-To: <67e9fbc5-ed7f-48b9-ae2a-e07c5fbd2218@gmail.com>


--nj3gdbp5aimebgk5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Sun, Feb 25, 2024 at 02:56:02PM +0100, Alex Bee wrote:
> Am 22.02.24 um 19:14 schrieb Maxime Ripard:
> > Now that we have all the infrastructure needed, we can add some code
> > that will, for a given connector state and mode, compute the best output
> > format and bpc.
> >=20
> > The algorithm is equivalent to the one already found in i915 and vc4.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/drm_atomic_state_helper.c          | 184 ++++++++++++=
++++++++-
> >   .../gpu/drm/tests/drm_atomic_state_helper_test.c   |  25 ++-
> >   2 files changed, 197 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/dr=
m/drm_atomic_state_helper.c
> > index 448b4a73d1c8..9f517599f117 100644
> > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > @@ -31,6 +31,7 @@
> >   #include <drm/drm_connector.h>
> >   #include <drm/drm_crtc.h>
> >   #include <drm/drm_device.h>
> > +#include <drm/drm_edid.h>
> >   #include <drm/drm_framebuffer.h>
> >   #include <drm/drm_plane.h>
> >   #include <drm/drm_print.h>
> > @@ -662,6 +663,96 @@ connector_state_get_mode(const struct drm_connecto=
r_state *conn_state)
> >   	return &crtc_state->mode;
> >   }
> > +static bool
> > +sink_supports_format_bpc(const struct drm_connector *connector,
> > +			 const struct drm_display_info *info,
> > +			 const struct drm_display_mode *mode,
> > +			 unsigned int format, unsigned int bpc)
> > +{
> > +	struct drm_device *dev =3D connector->dev;
> > +	u8 vic =3D drm_match_cea_mode(mode);
> > +
> > +	if (vic =3D=3D 1 && bpc !=3D 8) {
> > +		drm_dbg(dev, "VIC1 requires a bpc of 8, got %u\n", bpc);
> > +		return false;
> > +	}
> > +
> > +	if (!info->is_hdmi &&
> > +	    (format !=3D HDMI_COLORSPACE_RGB || bpc !=3D 8)) {
> > +		drm_dbg(dev, "DVI Monitors require an RGB output at 8 bpc\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(connector->hdmi.supported_formats & BIT(format))) {
> > +		drm_dbg(dev, "%s format unsupported by the connector.\n",
> > +			drm_hdmi_connector_get_output_format_name(format));
> > +		return false;
> > +	}
> > +
> > +	switch (format) {
> > +	case HDMI_COLORSPACE_RGB:
> > +		drm_dbg(dev, "RGB Format, checking the constraints.\n");
> > +
> > +		if (!(info->color_formats & DRM_COLOR_FORMAT_RGB444))
> > +			return false;
> > +
> > +		if (bpc =3D=3D 10 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HD=
MI_DC_30)) {
> > +			drm_dbg(dev, "10 BPC but sink doesn't support Deep Color 30.\n");
> > +			return false;
> > +		}
> > +
> > +		if (bpc =3D=3D 12 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HD=
MI_DC_36)) {
> > +			drm_dbg(dev, "12 BPC but sink doesn't support Deep Color 36.\n");
> > +			return false;
> > +		}
> > +
> > +		drm_dbg(dev, "RGB format supported in that configuration.\n");
> > +
> > +		return true;
> > +
> > +	case HDMI_COLORSPACE_YUV422:
> > +		drm_dbg(dev, "YUV422 format, checking the constraints.\n");
> > +
> > +		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR422)) {
> > +			drm_dbg(dev, "Sink doesn't support YUV422.\n");
> > +			return false;
> > +		}
> > +
> > +		if (bpc !=3D 12) {
> > +			drm_dbg(dev, "YUV422 only supports 12 bpc.\n");
> > +			return false;
> > +		}
> > +
> I'm not sure this check is really necessary/helpful.
> In [0] you are quoting HDMI specs which are saying that YUV422 is just
> always 12 bpc - which I guess is correct. The problem I'm seeing here:
> There are HDMI 1.4 controllers, like Rockchip Inno HDMI, that support
> YUV422 but do not support any other color depth than 8 bpc for RGB or
> YUV444. In drmm_connector_hdmi_init you are expecting to give the max bpc
> as parameter and (if I'm getting it correctly) I'd had to set it to 12 to
> also get YUV422 modes, but I'd also get RGB/YUV444 with bpc > 8 modes whi=
ch
> are not supported by this controller. I guess the same applies to other
> HDMI 1.4 controllers that support YUV422. Or would I have to filter it out
> myself?
> So I guess the easiest way around is to drop the above check since it is
> just always 12 bpc for YUV422 and there is no need to filter out anything.
> (Same applies to the similar check in [0]).

So, let's tackle drm_connector_hdmi_compute_mode_clock() first, and then
I'll try to answer most of your question there.

If drm_connector_hdmi_compute_mode_clock() is called with the YCbCr422
format and a bpc !=3D 12, what should we return if not an error?

It's the only bpc count allowed by the spec and for which we have a
formula for. I just can't return the character rate of YCbCr422 with 8
bpc, I have no idea what it should be.

And now pivoting to the block of code you commented on, there's two
things to consider here. Eventually, the userspace is in charge of
limiting the bpc count, and we have to take it into account.

If the userspace limits us to below 12bpc, we fall back to the
discussion above: we simply have no way to tell how it works out for
YCbCr422, and RGB is the only solution we have.

In your particular case, what you actually want is to prevent RGB 10 and
12bpc to be used. I guess we could create a new driver hook or extend
the one that checks for the code you pointed out to check whether the
driver supports it (possibly turned into a helper), but there's no other
way around it I think.

Maxime

--nj3gdbp5aimebgk5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd3rNQAKCRDj7w1vZxhR
xSMeAQCznapx1KyjndzP2EVcJy12qE1B9F+D8X9w5siGsAvSoQD+M22Fg/bWZcFS
1T5GE+QJEPAzWkUzJT1TOEwa3EPalAM=
=YL5c
-----END PGP SIGNATURE-----

--nj3gdbp5aimebgk5--

