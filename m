Return-Path: <linux-kernel+bounces-99183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1005287849A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46368B2160C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EC247A76;
	Mon, 11 Mar 2024 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Asl7qjzC"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70CF44393
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173213; cv=none; b=uQNEk7hfXg4Dy1qEmfRckY2dytjPKsDTbO9gFyGOnuIQj8YfxY7p5cYFTjjUY+TwEEty5Aoz+hnNKDT2j+v7MVZE+R2gdYGTszz3EQzlGmHa2rghAahpS92rjbQ7aOucWa9qLHn8AxFxRMu5Sa/yl5sxBI72bPccqgEb8okKzq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173213; c=relaxed/simple;
	bh=dXKDmpIAhlhGm+9bZxqCyqj+Xcxx+ntMNMiDn/Y+5ms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oQUHsTBwajCxped15yG56akwkJfKdMawLsCWvOGGxFu6f1alBUV65UwNef9JwKNeexzbO9EkcGkrX9ycd7wXNwuPRJnMH1UERcXnZo+rLig1RJXXmzWeJhBmXMPTHmFaTxfcahOwLcdXSg+OZabEABSWVyrunneLqGRzTTNytww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Asl7qjzC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710173209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QNJHLR0yNjNcJydH+HbGTVl6vOCkvHLtHR5rRbxrvfo=;
	b=Asl7qjzCsc95g6iLe8JzrS4OMn3063yAhJSq5tEStD3amWJL5qLH841aX2/oH2xQy6WxuW
	gR/IZI6UhmJ82Sa/rSXS9zb22DIEFfixrxT6qKfdESz62I5GrSy9OvcMoint4fgnwt8biQ
	R+n2ZZoT4y+VCPEt45SqMAavY8rjNPM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-132-0OMSACYXPKKGWYYijRgUMQ-1; Mon, 11 Mar 2024 12:06:38 -0400
X-MC-Unique: 0OMSACYXPKKGWYYijRgUMQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33e67c6b7bdso2239092f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:06:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173197; x=1710777997;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNJHLR0yNjNcJydH+HbGTVl6vOCkvHLtHR5rRbxrvfo=;
        b=dW1wtAeqXbDjzGyHFW3TadkXfSMj/Wuv35EVZJitgD/AOnoKdpuDV5p8Q5AlyxVjIZ
         ithcPIlQZAqmB+6JavAZBp+LzdbQ90M+uJowZQlI097Y1itB4MlS0IHm1SMF4DupH+gT
         +y16Sl1v0rAY9xxrS4Y42zERdUhlg3JWXWQ/9PIKmTdP+CQtnZTDGpn4gkYndfCmkrSs
         /QxFNsY40UUzhmxBr3mcYy6Rh3WIOcAP/taSe9Xo+pDYwQUHL5g/kOqY+5k5W6ijE7Bi
         /Retdphljg04JV389P9DR6x/MxnhKAWWiqKpuQG8tVNStsNVxtfn4Zwp5ZhPUHeoWCsI
         UZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWeLfJH4DTMDbMBIh1MBoxSNceg6/TOx1tD1FqFxel/prK3h5mNYu8XgZuV5dXX6tkOxcIjrHd15HZxPejmtDA8eNrCsbRkMVW8rb2C
X-Gm-Message-State: AOJu0YypS3FBskaQmkznoX5MpdlBTaH4oSZzpE5VpL8D+au+MhTY4C/p
	WKplTRtZ28TNlsMhCub6NpZOw3lqjWSQLfc72+Vkiq3T5pHrMVf6Mvy5M7cwBCuvLwCz6s1zvWd
	A8aRCqWB+zczOksnnmf63cG3bY1L+2dv381ltGQKzwRq4VnGgaT79nJ3fyou+yw==
X-Received: by 2002:a5d:4088:0:b0:33e:7a10:4d6e with SMTP id o8-20020a5d4088000000b0033e7a104d6emr4220091wrp.32.1710173197128;
        Mon, 11 Mar 2024 09:06:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIHQ4IsSr7/EQIzMSsVUeLFmRLgG/+RHWPw63nSJAHInZRyoeJJPvp9gsj1QT60M0fJVsTgg==
X-Received: by 2002:a5d:4088:0:b0:33e:7a10:4d6e with SMTP id o8-20020a5d4088000000b0033e7a104d6emr4220075wrp.32.1710173196698;
        Mon, 11 Mar 2024 09:06:36 -0700 (PDT)
Received: from toolbox ([2001:9e8:89a8:bc00:4f1a:435e:d5a8:5d5a])
        by smtp.gmail.com with ESMTPSA id c17-20020a5d5291000000b0033d2ae84fafsm6757931wrv.52.2024.03.11.09.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 09:06:36 -0700 (PDT)
Date: Mon, 11 Mar 2024 17:06:34 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/drm_connector: Document Colorspace property
 variants
Message-ID: <20240311160634.GA323822@toolbox>
References: <20240305135155.231687-1-sebastian.wick@redhat.com>
 <20240306102721.3c9c3785.pekka.paalanen@collabora.com>
 <20240306164209.GA11561@toolbox>
 <20240307102922.0f3701cb.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307102922.0f3701cb.pekka.paalanen@collabora.com>

On Thu, Mar 07, 2024 at 10:29:22AM +0200, Pekka Paalanen wrote:
> On Wed, 6 Mar 2024 17:42:09 +0100
> Sebastian Wick <sebastian.wick@redhat.com> wrote:
> 
> > On Wed, Mar 06, 2024 at 10:27:21AM +0200, Pekka Paalanen wrote:
> > > On Tue,  5 Mar 2024 14:51:49 +0100
> > > Sebastian Wick <sebastian.wick@redhat.com> wrote:
> > >   
> > > > The initial idea of the Colorspace prop was that this maps 1:1 to
> > > > InfoFrames/SDP but KMS does not give user space enough information nor
> > > > control over the output format to figure out which variants can be used
> > > > for a given KMS commit. At the same time, properties like Broadcast RGB
> > > > expect full range quantization range being produced by user space from
> > > > the CRTC and drivers to convert to the range expected by the sink for
> > > > the chosen output format, mode, InfoFrames, etc.
> > > > 
> > > > This change documents the reality of the Colorspace property. The
> > > > Default variant unfortunately is very much driver specific and not
> > > > reflected by the EDID. The BT2020 variants are in active use by generic
> > > > compositors which have expectations from the driver about the
> > > > conversions it has to do when selecting certain output formats.
> > > > 
> > > > Everything else is also marked as undefined. Coming up with valid
> > > > behavior that makes it usable from user space and consistent with other
> > > > KMS properties for those variants is left as an exercise for whoever
> > > > wants to use them.
> > > > 
> > > > v2:
> > > >  * Talk about "pixel operation properties" that user space configures
> > > >  * Mention that user space is responsible for checking the EDID for sink
> > > >    support
> > > >  * Make it clear that drivers can choose between RGB and YCbCr on their
> > > >    own
> > > > 
> > > > Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_connector.c | 79 +++++++++++++++++++++++++--------
> > > >  include/drm/drm_connector.h     |  8 ----
> > > >  2 files changed, 61 insertions(+), 26 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > > > index b0516505f7ae..65cdcc7d22db 100644
> > > > --- a/drivers/gpu/drm/drm_connector.c
> > > > +++ b/drivers/gpu/drm/drm_connector.c
> > > > @@ -2147,24 +2147,67 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
> > > >   * DOC: standard connector properties
> > > >   *
> > > >   * Colorspace:
> > > > - *     This property helps select a suitable colorspace based on the sink
> > > > - *     capability. Modern sink devices support wider gamut like BT2020.
> > > > - *     This helps switch to BT2020 mode if the BT2020 encoded video stream
> > > > - *     is being played by the user, same for any other colorspace. Thereby
> > > > - *     giving a good visual experience to users.
> > > > - *
> > > > - *     The expectation from userspace is that it should parse the EDID
> > > > - *     and get supported colorspaces. Use this property and switch to the
> > > > - *     one supported. Sink supported colorspaces should be retrieved by
> > > > - *     userspace from EDID and driver will not explicitly expose them.
> > > > - *
> > > > - *     Basically the expectation from userspace is:
> > > > - *      - Set up CRTC DEGAMMA/CTM/GAMMA to convert to some sink
> > > > - *        colorspace
> > > > - *      - Set this new property to let the sink know what it
> > > > - *        converted the CRTC output to.
> > > > - *      - This property is just to inform sink what colorspace
> > > > - *        source is trying to drive.
> > > > + *	This property is used to inform the driver about the color encoding
> > > > + *	user space configured the pixel operation properties to produce.
> > > > + *	The variants set the colorimetry, transfer characteristics, and which
> > > > + *	YCbCr conversion should be used when necessary.
> > > > + *	The transfer characteristics from HDR_OUTPUT_METADATA takes precedence
> > > > + *	over this property.
> > > > + *	User space always configures the pixel operation properties to produce
> > > > + *	full quantization range data (see the Broadcast RGB property).
> > > > + *
> > > > + *	Drivers inform the sink about what colorimetry, transfer
> > > > + *	characteristics, YCbCr conversion, and quantization range to expect
> > > > + *	(this can depend on the output mode, output format and other
> > > > + *	properties). Drivers also convert the user space provided data to what
> > > > + *	the sink expects.  
> > > 
> > > Hi Sebastian,
> > > 
> > > should it be more explicit that drivers are allowed to do only
> > > RGB->YCbCr and quantization range conversions, but not TF nor gamut
> > > conversions?
> > > 
> > > That is, if the driver cannot pick the TF implied by "Colorspace"
> > > property for the sink, then it cannot pick another TF for the sink and
> > > silently convert. It think this should apply to all options including
> > > the undefined ones. Or is that too much to guess?  
> > 
> > That's a really good point. I'll add it in the next revision.
> > 
> > > > + *
> > > > + *	User space has to check if the sink supports all of the possible
> > > > + *	colorimetries that the driver is allowed to pick by parsing the EDID.  
> > > 
> > > All? Rather than at least one?
> > > 
> > > Is this how it has been implemented for BT2020, that userspace picked
> > > colorimetry and driver picked color model and quantization are
> > > completely independent, and drivers do not check the combination
> > > against EDID?  
> > 
> > AFAIK the driver exposes all Colorspace variants that it can support in
> > the driver, independent of the sink. That means user space has to make
> > sure that the sink supports all colorimetry variants the driver can
> > pick.
> 
> I didn't mean exposing but the driver could reject the atomic commit
> that would lead to a combination not advertised as supported in EDID.
> If drivers reject, then userspace does not need to check for all
> driver-choosable variants, just one would be enough. Theoretically not
> needing all might allow some cases to work that don't support all.
> "Colorspace" property value could direct the driver's choice based on
> what EDID claims to support.

Right, this could be possible and is probably even better than what I
wrote down but...

> Of course, if drivers don't do that already, then "all" it must be.

..unfortunately that seems to be the case. Maybe we can get away with
changing it though?

> 
> Thanks,
> pq
> 
> > Would be good to get a confirmation from Harry and Ville.
> > 
> > > If so, "all" it is. Would be good to explain this in the commit message.  
> > 
> > Will do.
> > 
> > > > + *
> > > > + *	For historical reasons this property exposes a number of variants which
> > > > + *	result in undefined behavior.
> > > > + *
> > > > + *	Default:
> > > > + *		The behavior is driver-specific.
> > > > + *	BT2020_RGB:
> > > > + *	BT2020_YCC:
> > > > + *		User space configures the pixel operation properties to produce
> > > > + *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
> > > > + *		ITU-R BT.2020 (Table 4, RGB) transfer characteristics and full
> > > > + *		quantization range.
> > > > + *		User space can use the HDR_OUTPUT_METADATA property to set the
> > > > + *		transfer characteristics to PQ (Rec. ITU-R BT.2100 Table 4) or
> > > > + *		HLG (Rec. ITU-R BT.2100 Table 5) in which case, user space
> > > > + *		configures pixel operation properties to produce content with
> > > > + *		the respective transfer characteristics.
> > > > + *		User space has to make sure the sink supports Rec.
> > > > + *		ITU-R BT.2020 R'G'B' and Rec. ITU-R BT.2020 Y'C'BC'R
> > > > + *		colorimetry.
> > > > + *		Drivers can configure the sink to use an RGB format, tell the
> > > > + *		sink to expect Rec. ITU-R BT.2020 R'G'B' colorimetry and convert
> > > > + *		to the appropriate quantization range.
> > > > + *		Drivers can configure the sink to use a YCbCr format, tell the
> > > > + *		sink to expect Rec. ITU-R BT.2020 Y'C'BC'R colorimetry, convert
> > > > + *		to YCbCr using the Rec. ITU-R BT.2020 non-constant luminance
> > > > + *		conversion matrix and convert to the appropriate quantization
> > > > + *		range.
> > > > + *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
> > > > + *		driver chooses between RGB and YCbCr on its own.
> > > > + *	SMPTE_170M_YCC:
> > > > + *	BT709_YCC:
> > > > + *	XVYCC_601:
> > > > + *	XVYCC_709:
> > > > + *	SYCC_601:
> > > > + *	opYCC_601:
> > > > + *	opRGB:
> > > > + *	BT2020_CYCC:
> > > > + *	DCI-P3_RGB_D65:
> > > > + *	DCI-P3_RGB_Theater:
> > > > + *	RGB_WIDE_FIXED:
> > > > + *	RGB_WIDE_FLOAT:
> > > > + *	BT601_YCC:
> > > > + *		The behavior is undefined.
> > > >   *
> > > >   * Because between HDMI and DP have different colorspaces,
> > > >   * drm_mode_create_hdmi_colorspace_property() is used for HDMI connector and
> > > > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > > > index fe88d7fc6b8f..02c42b01a3a7 100644
> > > > --- a/include/drm/drm_connector.h
> > > > +++ b/include/drm/drm_connector.h
> > > > @@ -437,14 +437,6 @@ enum drm_privacy_screen_status {
> > > >   *
> > > >   * DP definitions come from the DP v2.0 spec
> > > >   * HDMI definitions come from the CTA-861-H spec
> > > > - *
> > > > - * A note on YCC and RGB variants:
> > > > - *
> > > > - * Since userspace is not aware of the encoding on the wire
> > > > - * (RGB or YCbCr), drivers are free to pick the appropriate
> > > > - * variant, regardless of what userspace selects. E.g., if
> > > > - * BT2020_RGB is selected by userspace a driver will pick
> > > > - * BT2020_YCC if the encoding on the wire is YUV444 or YUV420.
> > > >    *
> > > >   * @DRM_MODE_COLORIMETRY_DEFAULT:
> > > >   *   Driver specific behavior.  
> > > 
> > > This looks really good. This also makes me need to revisit the Weston
> > > series I've been brewing that adds "Colorspace" KMS support.
> > > 
> > > I think the two questions I had may be slightly too much in the
> > > direction of improving rather than just documenting this property, so
> > > I'll already give
> > > 
> > > Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>  
> > 
> > Thanks.
> > 
> > > 
> > > Thanks,
> > > pq  
> > 
> > 
> 



