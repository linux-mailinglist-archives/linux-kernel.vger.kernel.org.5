Return-Path: <linux-kernel+bounces-151446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 197988AAF0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAAEF283F37
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B99129E80;
	Fri, 19 Apr 2024 13:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ptQj5J08"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142FF4F214;
	Fri, 19 Apr 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713531673; cv=none; b=JF/gq5iTu+KE8brYJkrISikpkLKWcovB4UYpIC3IvapUBDJoduZWH03NjLlDZRLCI0CT2mKK2MRfXt931CYimo5fiwnHsmF7madLcuLUIqoCN0y+SedSbozQwlcoGFT1l3Ryb9/tcpi4VF9RUGI5DwsJc9KJQaZMnyWwYP42fek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713531673; c=relaxed/simple;
	bh=EfEgmbr1ktf8i8gBDSOo61C9Hr8ROwzxRco0v2/O6p0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Khfy07OHzcUd0wRuKafRVDQIR4kFbHRMbJEb03/ugrCdqXd1DW4EmfPeKKomHZFg4QqjnU/NgkzkNjEK+VCXvt3ASx4NbSHIIdnU+IehG+XU43aF1PRVL4pxtsS4PQE7XZrlbb+e19dOX/MetFjBS+7hw88apXlywZrKltqqOTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ptQj5J08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E96C3277B;
	Fri, 19 Apr 2024 13:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713531672;
	bh=EfEgmbr1ktf8i8gBDSOo61C9Hr8ROwzxRco0v2/O6p0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ptQj5J08aVwRnk47dfnXt/VPP/OEroo0Ee3+LnY69c9iZQT0W4DMNG9ylpWGszuZB
	 gEu3xNS/DD8Gqoid0m2dxfvDVwpDFkfD0hY6j8cWwrVepuhzb7rXz4nWuc36LeAdKu
	 OLnbmOYR91KYbBuPRyF9z6RpmQJeWmQO0ZhrGIFP/dZDNdUuafj8uN/QEEaYInB95u
	 s5okAtlwaotbluwnSOh4f/zLc7tkY5q2lGgKSGSYWOVA1RlpeHbdyu0i02voCfwRGg
	 5uLLK/yQ374jR5e/ncIen4j1LbZTQ8eAx1GfgHVV5em2SudjN0fSJEjkML8EcUJH3U
	 1hXX1OTWS/04g==
Date: Fri, 19 Apr 2024 15:01:10 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Wick <sebastian.wick@redhat.com>, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v11 15/28] drm/connector: hdmi: Compute bpc and format
 automatically
Message-ID: <20240419-illegal-rose-heron-e2ff64@houat>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
 <20240326-kms-hdmi-connector-state-v11-15-c5680ffcf261@kernel.org>
 <Zh6CQhD-2Yl5LUVb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="27joxh4slrq34bs4"
Content-Disposition: inline
In-Reply-To: <Zh6CQhD-2Yl5LUVb@intel.com>


--27joxh4slrq34bs4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 04:50:58PM +0300, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 26, 2024 at 04:40:19PM +0100, Maxime Ripard wrote:
> > Now that we have all the infrastructure needed, we can add some code
> > that will, for a given connector state and mode, compute the best output
> > format and bpc.
> >=20
> > The algorithm is equivalent to the one already found in i915 and vc4.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_state_helper.c    | 197 +++++++++++++=
+++++++-
> >  drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |  25 ++-
> >  2 files changed, 210 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/=
gpu/drm/display/drm_hdmi_state_helper.c
> > index 063421835dba..b9bc0fb027ea 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> > @@ -1,9 +1,11 @@
> >  // SPDX-License-Identifier: MIT
> > =20
> >  #include <drm/drm_atomic.h>
> >  #include <drm/drm_connector.h>
> > +#include <drm/drm_edid.h>
> > +#include <drm/drm_print.h>
> > =20
> >  #include <drm/display/drm_hdmi_helper.h>
> >  #include <drm/display/drm_hdmi_state_helper.h>
> > =20
> >  /**
> > @@ -46,10 +48,110 @@ connector_state_get_mode(const struct drm_connecto=
r_state *conn_state)
> >  		return NULL;
> > =20
> >  	return &crtc_state->mode;
> >  }
> > =20
> > +static bool
> > +sink_supports_format_bpc(const struct drm_connector *connector,
> > +			 const struct drm_display_info *info,
> > +			 const struct drm_display_mode *mode,
> > +			 unsigned int format, unsigned int bpc)
> > +{
> > +	struct drm_device *dev =3D connector->dev;
> > +	u8 vic =3D drm_match_cea_mode(mode);
> > +
> > +	/*
> > +	 * CTA-861-F, section 5.4 - Color Coding & Quantization states
> > +	 * that the bpc must be 8, 10, 12 or 16 except for the default
> > +	 * 640x480 VIC1 where the value must be 8.
> > +	 *
> > +	 * The definition of default here is ambiguous but the spec
> > +	 * refers to VIC1 being the default timing in several occasions
> > +	 * so our understanding is that for the default timing (ie,
> > +	 * VIC1), the bpc must be 8.
> > +	 */
> > +	if (vic =3D=3D 1 && bpc !=3D 8) {
> > +		drm_dbg_kms(dev, "VIC1 requires a bpc of 8, got %u\n", bpc);
> > +		return false;
> > +	}
> > +
> > +	if (!info->is_hdmi &&
> > +	    (format !=3D HDMI_COLORSPACE_RGB || bpc !=3D 8)) {
> > +		drm_dbg_kms(dev, "DVI Monitors require an RGB output at 8 bpc\n");
> > +		return false;
> > +	}
> > +
> > +	if (!(connector->hdmi.supported_formats & BIT(format))) {
>=20
> These are the capabilities of the souce I take it?
>
> > +		drm_dbg_kms(dev, "%s format unsupported by the connector.\n",
> > +			    drm_hdmi_connector_get_output_format_name(format));
> > +		return false;
> > +	}
> > +
> > +	switch (format) {
> > +	case HDMI_COLORSPACE_RGB:
> > +		drm_dbg_kms(dev, "RGB Format, checking the constraints.\n");
> > +
> > +		if (!(info->color_formats & DRM_COLOR_FORMAT_RGB444))
> > +			return false;
>=20
> and this is the sink.
>
> Maybe we should use the same bits for both? Anyways, that seems like
> material for a followup series.

Ack

> > +
> > +		if (bpc =3D=3D 10 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HD=
MI_DC_30)) {
> > +			drm_dbg_kms(dev, "10 BPC but sink doesn't support Deep Color 30.\n"=
);
> > +			return false;
> > +		}
> > +
> > +		if (bpc =3D=3D 12 && !(info->edid_hdmi_rgb444_dc_modes & DRM_EDID_HD=
MI_DC_36)) {
> > +			drm_dbg_kms(dev, "12 BPC but sink doesn't support Deep Color 36.\n"=
);
> > +			return false;
> > +		}
> > +
> > +		drm_dbg_kms(dev, "RGB format supported in that configuration.\n");
> > +
> > +		return true;
> > +
> > +	case HDMI_COLORSPACE_YUV422:
> > +		drm_dbg_kms(dev, "YUV422 format, checking the constraints.\n");
> > +
> > +		if (!(info->color_formats & DRM_COLOR_FORMAT_YCBCR422)) {
> > +			drm_dbg_kms(dev, "Sink doesn't support YUV422.\n");
> > +			return false;
> > +		}
> > +
> > +		if (bpc !=3D 12) {
> > +			drm_dbg_kms(dev, "YUV422 only supports 12 bpc.\n");
> > +			return false;
> > +		}
>=20
> Did something change around here from the last time?

The format selection code now prefers to select a lower bpc rather than
another format, which is what you asked for in the previous version.


--27joxh4slrq34bs4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZiJrFQAKCRAnX84Zoj2+
dm//AYDBcbHF1j+MBygRYjzArO/7IC8ROQ0TnbdGU1QgBsuY7d6sseYpeJlG6wy4
nb4N4n8BgNUIdF8BxMB0oSpFmbipxEdz7fBTk7U7cq968A6gd9ZS3VCDFSZ+M67f
FOZCYGxFQQ==
=tQ9L
-----END PGP SIGNATURE-----

--27joxh4slrq34bs4--

