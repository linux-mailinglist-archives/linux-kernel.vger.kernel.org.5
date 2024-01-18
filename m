Return-Path: <linux-kernel+bounces-30572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5292D8320D1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9941F23D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A48B31732;
	Thu, 18 Jan 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9+2zTIP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336762EAE6
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 21:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612875; cv=none; b=tkHMSCLkaIP0ONWBQBee+cWQo8kBIuk/Zh9uChfR2qtNl30lDZXHDRkCzK292EE9sARCno5kPWLJbIHucsthF0/49Lp+W+Zz+d9TBl5d9P9HU6tHiuCDVoP+lk6FCcp77lOGI4keHg4KMbp94AL2kYgGckK91ND2Qz2i2Nwgsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612875; c=relaxed/simple;
	bh=D2v9kjg29KrNflvmoqwSf7FSU3tVTEXEJL9yrS99Ea8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JceRyUsw4kM/iglgl1wtXXo9aQi45qT7VdEtL7T2N2Xu6A4iV2voUKS8A/scJqqDFjx1+KQNYuEPYcursRzl99So2d1M4eCilRmedvN2HjkZ7Ox++PatdaMYJ9Bfk7BRp4IZ0XIEw3ofej0k0VArIJYMxGWNoCPkOnB/U9SKYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I9+2zTIP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705612872;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l/RFuMwXFGgnLzX+gQ+7Eyl0Fns+nyjhizUJ9hMdtGQ=;
	b=I9+2zTIPB7i7He7C7RPM3D4xI/OH1WlBKVYQ8uhQh5ilFQFmhHVFv+xYFMAosMm//X4QpW
	uQAB0a/IGB2wvdVjKoI5zKyn6Z4oRaW3Tiu+AMM2LColniAwhQu/au2OJRf5jxKRP3piCT
	kmlieOaEkiKLErNpe/FMIRGwy1q5F1s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-eVr5x84yPPi2isUsZee_lA-1; Thu, 18 Jan 2024 16:21:09 -0500
X-MC-Unique: eVr5x84yPPi2isUsZee_lA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40e4f70af99so571675e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 13:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705612868; x=1706217668;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l/RFuMwXFGgnLzX+gQ+7Eyl0Fns+nyjhizUJ9hMdtGQ=;
        b=qW5ZtZ+N9f4LmaPfUnuiG14nOjl5GKLiaJqmE0hB3TrPqodGaPiNz04nbMwrbb/f80
         eoGSAa6PWbNxuUWBcYinn6rXtfTGQqzL4q2dTeYTsu+9sq66hTyMuJIf8cNgGGWlUMSh
         Z3uYuZGSdKUy15g59FOr5laB3B7J4pzxPiokxypDdTij/C47uYL0FZlNZ42xFKXesmx6
         4xvoiQWCQsMHhIBN14d+DEOhNfaXXMT8CFpGc6kvqQG+7vv8mxT3NXTlpnh1ArNnzpcV
         ldbYZYq4ghoZpokrW7v+0EQz7klk6XQ3nH3tKim4VfE9lAr76UmpDjqURZ/ASnpfq1LF
         2svg==
X-Gm-Message-State: AOJu0YxhLxA4OtoYNxN0S177vI4bma80vu6+AAlG6I1PCao5e3+I7iPu
	MOVhvS1ONlWQHywdsEEqEqq40qKDRZka3TbTu3s8tZw+i271rCL3/CoHD4tszeV5CeQYREUN3YC
	KTZt2zfrwyfGjEr6cmTjAGat9kaKLg1LOSVuo8IriWUai2tfz26QjhoOC9rYDvA==
X-Received: by 2002:a05:600c:4fd0:b0:40e:7485:daee with SMTP id o16-20020a05600c4fd000b0040e7485daeemr889524wmq.90.1705612868219;
        Thu, 18 Jan 2024 13:21:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEbMdqyiktrO4MfePrGAzXbNxUb85rIEKPcPE1jD7jmO2KFaepfrTeZH0nCka73fDv9zyB9iQ==
X-Received: by 2002:a05:600c:4fd0:b0:40e:7485:daee with SMTP id o16-20020a05600c4fd000b0040e7485daeemr889513wmq.90.1705612867823;
        Thu, 18 Jan 2024 13:21:07 -0800 (PST)
Received: from toolbox ([2001:9e8:89aa:f00:af88:d221:94de:a009])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c1d8900b0040e95632357sm2223810wms.26.2024.01.18.13.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:21:07 -0800 (PST)
Date: Thu, 18 Jan 2024 22:21:05 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>, Emma Anholt <emma@anholt.net>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	Samuel Holland <samuel@sholland.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-doc@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>,
	linux-rockchip@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
	David Airlie <airlied@gmail.com>, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <20240118212105.GA30589@toolbox>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <jpcov2bvhpabws36ueywr4xjfnbmwjsd42b4tpcicyi66qkjs2@3xn5mdl4zyus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jpcov2bvhpabws36ueywr4xjfnbmwjsd42b4tpcicyi66qkjs2@3xn5mdl4zyus>

On Mon, Jan 15, 2024 at 04:25:41PM +0100, Maxime Ripard wrote:
> On Mon, Jan 15, 2024 at 03:33:08PM +0100, Sebastian Wick wrote:
> > On Thu, Dec 07, 2023 at 04:49:31PM +0100, Maxime Ripard wrote:
> > > The i915 driver has a property to force the RGB range of an HDMI output.
> > > The vc4 driver then implemented the same property with the same
> > > semantics. KWin has support for it, and a PR for mutter is also there to
> > > support it.
> > > 
> > > Both drivers implementing the same property with the same semantics,
> > > plus the userspace having support for it, is proof enough that it's
> > > pretty much a de-facto standard now and we can provide helpers for it.
> > > 
> > > Let's plumb it into the newly created HDMI connector.
> > > 
> > > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > > ---
> > >  Documentation/gpu/kms-properties.csv               |   1 -
> > >  drivers/gpu/drm/drm_atomic.c                       |   5 +
> > >  drivers/gpu/drm/drm_atomic_state_helper.c          |  17 +
> > >  drivers/gpu/drm/drm_atomic_uapi.c                  |   4 +
> > >  drivers/gpu/drm/drm_connector.c                    |  76 +++++
> > >  drivers/gpu/drm/tests/Makefile                     |   1 +
> > >  .../gpu/drm/tests/drm_atomic_state_helper_test.c   | 376 +++++++++++++++++++++
> > >  drivers/gpu/drm/tests/drm_connector_test.c         | 117 ++++++-
> > >  drivers/gpu/drm/tests/drm_kunit_edid.h             | 106 ++++++
> > >  include/drm/drm_connector.h                        |  36 ++
> > >  10 files changed, 737 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/gpu/kms-properties.csv b/Documentation/gpu/kms-properties.csv
> > > index 0f9590834829..caef14c532d4 100644
> > > --- a/Documentation/gpu/kms-properties.csv
> > > +++ b/Documentation/gpu/kms-properties.csv
> > > @@ -17,7 +17,6 @@ Owner Module/Drivers,Group,Property Name,Type,Property Values,Object attached,De
> > >  ,Virtual GPU,“suggested X”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an X offset for a connector
> > >  ,,“suggested Y”,RANGE,"Min=0, Max=0xffffffff",Connector,property to suggest an Y offset for a connector
> > >  ,Optional,"""aspect ratio""",ENUM,"{ ""None"", ""4:3"", ""16:9"" }",Connector,TDB
> > > -i915,Generic,"""Broadcast RGB""",ENUM,"{ ""Automatic"", ""Full"", ""Limited 16:235"" }",Connector,"When this property is set to Limited 16:235 and CTM is set, the hardware will be programmed with the result of the multiplication of CTM by the limited range matrix to ensure the pixels normally in the range 0..1.0 are remapped to the range 16/255..235/255."
> > >  ,,“audio”,ENUM,"{ ""force-dvi"", ""off"", ""auto"", ""on"" }",Connector,TBD
> > >  ,SDVO-TV,“mode”,ENUM,"{ ""NTSC_M"", ""NTSC_J"", ""NTSC_443"", ""PAL_B"" } etc.",Connector,TBD
> > >  ,,"""left_margin""",RANGE,"Min=0, Max= SDVO dependent",Connector,TBD
> > > diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> > > index c31fc0b48c31..1465a7f09a0b 100644
> > > --- a/drivers/gpu/drm/drm_atomic.c
> > > +++ b/drivers/gpu/drm/drm_atomic.c
> > > @@ -1142,6 +1142,11 @@ static void drm_atomic_connector_print_state(struct drm_printer *p,
> > >  	drm_printf(p, "\tmax_requested_bpc=%d\n", state->max_requested_bpc);
> > >  	drm_printf(p, "\tcolorspace=%s\n", drm_get_colorspace_name(state->colorspace));
> > >  
> > > +	if (connector->connector_type == DRM_MODE_CONNECTOR_HDMIA ||
> > > +	    connector->connector_type == DRM_MODE_CONNECTOR_HDMIB)
> > > +		drm_printf(p, "\tbroadcast_rgb=%s\n",
> > > +			   drm_hdmi_connector_get_broadcast_rgb_name(state->hdmi.broadcast_rgb));
> > > +
> > >  	if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
> > >  		if (state->writeback_job && state->writeback_job->fb)
> > >  			drm_printf(p, "\tfb=%d\n", state->writeback_job->fb->base.id);
> > > diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
> > > index e69c0cc1c6da..10d98620a358 100644
> > > --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> > > +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> > > @@ -583,6 +583,7 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_tv_reset);
> > >  void __drm_atomic_helper_connector_hdmi_reset(struct drm_connector *connector,
> > >  					      struct drm_connector_state *new_state)
> > >  {
> > > +	new_state->hdmi.broadcast_rgb = DRM_HDMI_BROADCAST_RGB_AUTO;
> > >  }
> > >  EXPORT_SYMBOL(__drm_atomic_helper_connector_hdmi_reset);
> > >  
> > > @@ -650,6 +651,22 @@ EXPORT_SYMBOL(drm_atomic_helper_connector_tv_check);
> > >  int drm_atomic_helper_connector_hdmi_check(struct drm_connector *connector,
> > >  					   struct drm_atomic_state *state)
> > >  {
> > > +	struct drm_connector_state *old_state =
> > > +		drm_atomic_get_old_connector_state(state, connector);
> > > +	struct drm_connector_state *new_state =
> > > +		drm_atomic_get_new_connector_state(state, connector);
> > > +
> > > +	if (old_state->hdmi.broadcast_rgb != new_state->hdmi.broadcast_rgb) {
> > > +		struct drm_crtc *crtc = new_state->crtc;
> > > +		struct drm_crtc_state *crtc_state;
> > > +
> > > +		crtc_state = drm_atomic_get_crtc_state(state, crtc);
> > > +		if (IS_ERR(crtc_state))
> > > +			return PTR_ERR(crtc_state);
> > > +
> > > +		crtc_state->mode_changed = true;
> > > +	}
> > > +
> > >  	return 0;
> > >  }
> > >  EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_check);
> > > diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> > > index aee4a65d4959..3eb4f4bc8b71 100644
> > > --- a/drivers/gpu/drm/drm_atomic_uapi.c
> > > +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> > > @@ -818,6 +818,8 @@ static int drm_atomic_connector_set_property(struct drm_connector *connector,
> > >  		state->max_requested_bpc = val;
> > >  	} else if (property == connector->privacy_screen_sw_state_property) {
> > >  		state->privacy_screen_sw_state = val;
> > > +	} else if (property == connector->broadcast_rgb_property) {
> > > +		state->hdmi.broadcast_rgb = val;
> > >  	} else if (connector->funcs->atomic_set_property) {
> > >  		return connector->funcs->atomic_set_property(connector,
> > >  				state, property, val);
> > > @@ -901,6 +903,8 @@ drm_atomic_connector_get_property(struct drm_connector *connector,
> > >  		*val = state->max_requested_bpc;
> > >  	} else if (property == connector->privacy_screen_sw_state_property) {
> > >  		*val = state->privacy_screen_sw_state;
> > > +	} else if (property == connector->broadcast_rgb_property) {
> > > +		*val = state->hdmi.broadcast_rgb;
> > >  	} else if (connector->funcs->atomic_get_property) {
> > >  		return connector->funcs->atomic_get_property(connector,
> > >  				state, property, val);
> > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > > index d9961cce8245..929b0a911f62 100644
> > > --- a/drivers/gpu/drm/drm_connector.c
> > > +++ b/drivers/gpu/drm/drm_connector.c
> > > @@ -1183,6 +1183,29 @@ static const u32 dp_colorspaces =
> > >  	BIT(DRM_MODE_COLORIMETRY_BT2020_CYCC) |
> > >  	BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
> > >  
> > > +static const struct drm_prop_enum_list broadcast_rgb_names[] = {
> > > +	{ DRM_HDMI_BROADCAST_RGB_AUTO, "Automatic" },
> > > +	{ DRM_HDMI_BROADCAST_RGB_FULL, "Full" },
> > > +	{ DRM_HDMI_BROADCAST_RGB_LIMITED, "Limited 16:235" },
> > > +};
> > > +
> > > +/*
> > > + * drm_hdmi_connector_get_broadcast_rgb_name - Return a string for HDMI connector RGB broadcast selection
> > > + * @broadcast_rgb: Broadcast RGB selection to compute name of
> > > + *
> > > + * Returns: the name of the Broadcast RGB selection, or NULL if the type
> > > + * is not valid.
> > > + */
> > > +const char *
> > > +drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb broadcast_rgb)
> > > +{
> > > +	if (broadcast_rgb > DRM_HDMI_BROADCAST_RGB_LIMITED)
> > > +		return NULL;
> > > +
> > > +	return broadcast_rgb_names[broadcast_rgb].name;
> > > +}
> > > +EXPORT_SYMBOL(drm_hdmi_connector_get_broadcast_rgb_name);
> > > +
> > >  /**
> > >   * DOC: standard connector properties
> > >   *
> > > @@ -1655,6 +1678,26 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
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
> > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > + *              this works for any number of bits-per-component.
> > > + *
> > > + *      Drivers can set up this property by calling
> > > + *      drm_connector_attach_broadcast_rgb_property().
> > > + *
> > 
> > This is a good time to document this in more detail.
> 
> I have the feeling that it already is documented in more detail. But
> anyway, last time we discussed it the answer was basically to not bother
> and just merge the thing. So I'm getting some mixed signals here.

I'm all for merging and not trying to improve the property but
documenting it in more detail is definitely something I want to see.

> > There might be two different things being affected:
> > 
> > 1. The signalling (InfoFrame/SDP/...)
> > 2. The color pipeline processing
> > 
> > All values of Broadcast RGB always affect the color pipeline processing
> > such that a full-range input to the CRTC is converted to either full- or
> > limited-range, depending on what the monitor is supposed to accept.
> > 
> > When automatic is selected, does that mean that there is no signalling,
> > or that the signalling matches what the monitor is supposed to accept
> > according to the spec?
> 
> The doc states that "Infoframes will be generated according to that
> value". Is it ambiguous?
> 
> > Also, is this really HDMI specific?
> 
> Probably not, but it can easily be expanded to other connector types
> when needs be.
> 
> > When full or limited is selected and the monitor doesn't support the
> > signalling, what happens?
> 
> I would expect colors to be off
> 
> Maxime



