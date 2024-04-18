Return-Path: <linux-kernel+bounces-150496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D7C8AA026
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B589728657A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CC36171E47;
	Thu, 18 Apr 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmzhN8RY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693711494B2;
	Thu, 18 Apr 2024 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713458037; cv=none; b=Rrp5ZABkFOwsfUL+57W6fUzxeDb8Y2etzWEBqe7YWh8GNZjpbCRb/tCb4DcCQLhsdpskinmz53okxzu1teVubZWuim7m9G5rA+kr3sb5Y4WfKqu9x6vw8pAGBHgHq7xjgME1+Y6yUUkbEoEiitA7sx4UiJ7CjENbxQthpGBZXbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713458037; c=relaxed/simple;
	bh=lArloNKVKGEPKb6sLd3btLeNdS79IuMsK6F6Ge4DTP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxOGdD0Z1OIA4GumObY5RTcEZsnlZ4iQMEl0jKZZkUyCFfe/zAl1BJy6z88J5n1+HUaaFYIJBnwVJchisYK1wvkiE56N5s1OI9bVDzMWn1o28YYGooNDSS3lszzdyppNgTRgODieuvpSRE6uToMNq6SizQAC1yE4Tec+jEeN/Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmzhN8RY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A046BC113CC;
	Thu, 18 Apr 2024 16:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713458037;
	bh=lArloNKVKGEPKb6sLd3btLeNdS79IuMsK6F6Ge4DTP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SmzhN8RYacSUvgmQeoSoei5bqe+spnwnlZfh3M/5/2LphAsoTy3X4yDNKUr+kZjOP
	 nI0GUpxnlrDcVtXz+2C2GDMRMcaYoupRC+vwqbixVNYW4O5NZRoV9ROmQp6WigP2Fl
	 t9vpZxB85aIoGbE8IH878QDLPSg7WdqjGxSQKAsQmNervesyvQvVJdtcVT92gND8Hp
	 OrEs566wYq0tBLwzGRcI7M9vwdTElQ+NWCqgQTLv19g7AafiALvoigjgN73I3vj8eC
	 5h8fooNygIBvJ6jTi9EYpXgRpuQDti2BMJsvmDnne0PGqJSFdCPbNGETCdelbl4o+J
	 /I4Qof48Leebw==
Date: Thu, 18 Apr 2024 18:33:54 +0200
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
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v11 09/28] drm/display: hdmi: Add HDMI compute clock
 helper
Message-ID: <20240418-spiritual-loyal-hornet-2fbbfd@houat>
References: <20240326-kms-hdmi-connector-state-v11-0-c5680ffcf261@kernel.org>
 <20240326-kms-hdmi-connector-state-v11-9-c5680ffcf261@kernel.org>
 <Zh6Ars8z1ESz-LQO@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="wahmhb7ukfwggb5k"
Content-Disposition: inline
In-Reply-To: <Zh6Ars8z1ESz-LQO@intel.com>


--wahmhb7ukfwggb5k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 04:44:14PM +0300, Ville Syrj=E4l=E4 wrote:
> On Tue, Mar 26, 2024 at 04:40:13PM +0100, Maxime Ripard wrote:
> > A lot of HDMI drivers have some variation of the formula to calculate
> > the TMDS character rate from a mode, but few of them actually take all
> > parameters into account.
> >=20
> > Let's create a helper to provide that rate taking all parameters into
> > account.
> >=20
> > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  drivers/gpu/drm/display/drm_hdmi_helper.c | 70 +++++++++++++++++++++++=
++++++++
> >  include/drm/display/drm_hdmi_helper.h     |  4 ++
> >  2 files changed, 74 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/display/drm_hdmi_helper.c b/drivers/gpu/dr=
m/display/drm_hdmi_helper.c
> > index faf5e9efa7d3..2518dd1a07e7 100644
> > --- a/drivers/gpu/drm/display/drm_hdmi_helper.c
> > +++ b/drivers/gpu/drm/display/drm_hdmi_helper.c
> > @@ -193,5 +193,75 @@ void drm_hdmi_avi_infoframe_content_type(struct hd=
mi_avi_infoframe *frame,
> >  	}
> > =20
> >  	frame->itc =3D conn_state->content_type !=3D DRM_MODE_CONTENT_TYPE_NO=
_DATA;
> >  }
> >  EXPORT_SYMBOL(drm_hdmi_avi_infoframe_content_type);
> > +
> > +/**
> > + * drm_hdmi_compute_mode_clock() - Computes the TMDS Character Rate
> > + * @mode: Display mode to compute the clock for
> > + * @bpc: Bits per character
> > + * @fmt: Output Pixel Format used
> > + *
> > + * Returns the TMDS Character Rate for a given mode, bpc count and out=
put format.
> > + *
> > + * RETURNS:
> > + * The TMDS Character Rate, in Hertz, or 0 on error.
>=20
> Everything generally uses kHz. Sticking to common units
> would be better.

Not everything, no. The clock framework is using Hz for example, and on
drm-misc drivers it's usually going to be the consumer of that field.

And there's almost 200 hits on mode->clock * 1000 in drivers/gpu/drm as
of today, including some in i915. This is a bit less than a third of all
the mode->clock usage, including the one that are unit-neutral (like
comparisons between two mode->clock fields).

Given how the rest of the DRM code is structured, yes, there's going to
be some impedance mismatch, but it's really not as clear cut as you make
it to be.

> > + */
> > +unsigned long long
> > +drm_hdmi_compute_mode_clock(const struct drm_display_mode *mode,
> > +			    unsigned int bpc, enum hdmi_colorspace fmt)
> > +{
> > +	unsigned long long clock =3D mode->clock * 1000ULL;
> > +	unsigned int vic =3D drm_match_cea_mode(mode);
> > +
> > +	/*
> > +	 * CTA-861-G Spec, section 5.4 - Color Coding and Quantization
> > +	 * mandates that VIC 1 always uses 8 bpc.
> > +	 */
> > +	if (vic =3D=3D 1 && bpc !=3D 8)
> > +		return 0;
> > +
> > +	/*
> > +	 * HDMI 2.0 Spec, section 7.1 - YCbCr 4:2:0 Pixel Encoding
> > +	 * specifies that YUV420 encoding is only available for those
> > +	 * VICs.
> > +	 */
> > +	if (fmt =3D=3D HDMI_COLORSPACE_YUV420 &&
> > +	    !(vic =3D=3D 96 || vic =3D=3D 97 || vic =3D=3D 101 ||
> > +	      vic =3D=3D 102 || vic =3D=3D 106 || vic =3D=3D 107))
> > +		return 0;
>=20
> I believe that is already outdated. I would just rip this out since the=
=20
> sink is anyway required to declare for which timings it will support
> 4:2:0 via the Y420CMDB/VDB data blocks (see
> drm_mode_is_420_{only,also}().

Should we use drm_mode_is_420() then or rip it out entirely?

> > +
> > +	if (fmt =3D=3D HDMI_COLORSPACE_YUV422) {
> > +		/*
> > +		 * HDMI 1.4b Spec, section 6.2.3 - Pixel Encoding Requirements
> > +		 * specifies that YUV422 is 36-bit only.
> > +		 */
> > +		if (bpc !=3D 12)
> > +			return 0;
> > +
> > +		/*
> > +		 * HDMI 1.0 Spec, section 6.5 - Pixel Encoding
> > +		 * specifies that YUV422 requires two 12-bits components per
> > +		 * pixel clock, which is equivalent in our calculation to three
> > +		 * 8-bits components
> > +		 */
> > +		bpc =3D 8;
> > +	}
> > +
> > +	/*
> > +	 * HDMI 2.0 Spec, Section 7.1 - YCbCr 4:2:0 Pixel Encoding
> > +	 * specifies that YUV420 encoding is carried at a TMDS Character Rate
> > +	 * equal to half the pixel clock rate.
> > +	 */
> > +	if (fmt =3D=3D HDMI_COLORSPACE_YUV420)
> > +		clock =3D clock / 2;
> > +
> > +	if (mode->flags & DRM_MODE_FLAG_DBLCLK)
> > +		clock =3D clock * 2;
> > +
> > +	clock =3D clock * bpc;
> > +	do_div(clock, 8);
>=20
> IMO one shouldn't use bare do_div(). There are
> more sensible wrappers for it.
>=20
> In this case I would use DIV_ROUND_CLOSEST_ULL().

Ack.

Thanks!
Maxime


--wahmhb7ukfwggb5k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCZiFLagAKCRAnX84Zoj2+
dlldAX9qCzh/RA7mK7FqSsjMey+9M1jDrHEO4/u17NwCJ+/AYaHi+wppWxmtK+K+
sLdIITcBgOE4oCoHKzJp+1JalYFdUKenCg0IWTcdxL0i3zyaXi9LePr+JzQS6ptm
EHgy3onxJA==
=/Ryj
-----END PGP SIGNATURE-----

--wahmhb7ukfwggb5k--

