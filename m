Return-Path: <linux-kernel+bounces-94283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17718873C76
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7F284AD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC8F137925;
	Wed,  6 Mar 2024 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuIZTf/D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F8EF9EB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 16:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709743337; cv=none; b=oIm9l88VFUGUmoCUVGi4urxOcwt3gRgWmm8BqLi8wnFex1dwwxXhiMTZXr381fC0BlWJ/JxD7T09HRDjCc59h9Iek9A1Uz23B1on4+37z2eR1EWIaxbedzXOH2KwHUv6uOgZqh0oidpogVB7w8r7GkrtY9SFp+gvAft6b+4HRkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709743337; c=relaxed/simple;
	bh=g8/7BLljzk9T1pqoXvHUVS4HHFDjTxTexs1XFJMZSFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VP5nw6iHFL2qr7Sz3h3FKF6XuwzRZMMQD+wstyzkcVclIjaUN/ahpV5Yy5/7pf7Y2N7mwOQYzEvNnAvxBI04UPzwN1wGhrYnCMkrRJ/WCUVhLVO6e6TKns+TAx/A8Y30p3ZH2ph1AAxZpkEsmS8v28RkzuZy6LD1el89EgmQxTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EuIZTf/D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709743334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XOnfHZ/CYWbvpHfKXEjkt5DY20w7GYdEJtPq6ODzSwM=;
	b=EuIZTf/DHIjCveXLty5qat1vlxX3dqEqSGoNTd2wcLN+3PTJlPDUHfnlg6JdPhExj0TYnl
	ZHEi/iLcsEg7A8iiOXry0vl/j4UtEaZ27GsTAaRLyk2Vnx9SkbFiiZy6YPVEp+MThSJq/F
	ah4icEnOugNd66+dd7XHjV0rz/Rd27A=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-s9jgkvQJPgmApo8o2oVdZw-1; Wed, 06 Mar 2024 11:42:13 -0500
X-MC-Unique: s9jgkvQJPgmApo8o2oVdZw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-412f6ba3c6aso4310825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 08:42:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709743332; x=1710348132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOnfHZ/CYWbvpHfKXEjkt5DY20w7GYdEJtPq6ODzSwM=;
        b=TQMTejq4sDhnYvRi1/L9+VsXZoP7wxSdcJxNJnebb/mNJAlax+eqARgWkq3Fj/eZlf
         DfCEo0nANEM175hM/tcdJgprSOlsexdpDvlEFl+kwjvNcU/hRknVCqhX4QZ2lJK2VmoQ
         eiH9wQj5D1tziiZMljngIB4Et8bI5rDjWvgnNH/FtSfkR+SxXfl925KH0wVjSD/Mwii3
         dHiYXqtiKSFbvLxo24sNqEJ56Q2s4YTRtSbDJqLECtm5sy5hTAKxaaG42yhAynS9+/5V
         1r89TxQpQLxIKIl1YLEZm445zY7IyA4HB8wqw+BQpKa5ZfaD0ETT2IrRVLwySEHwUWlB
         0Nlw==
X-Forwarded-Encrypted: i=1; AJvYcCVrZKUQrbwPpJtjDb8ORekkRZJVA14OIqYS1PGqFB3JKQc7jNvrgeGQMJi6l6m4f4Ztj7iC+zEWHlIwhVmU82yAxyvNsnjkGHTOfMvj
X-Gm-Message-State: AOJu0Yw1ddOARPDhUEWy5oRQ2ouNf4Iljwz7DKsX3fSubT0TmTw5C7Qn
	3khdjGKRmNQN+C/Alpxhq7Hrk+E/Unra5610k1uInaq5vpXM2lDzR9j1rybIv09S+i23DcESNQn
	CwuZJl3DKabtmWhfx432CPq6zaXYj4NNlUBQQPdiOo/4BiNnBgQKYm40uVw0Vuw==
X-Received: by 2002:a05:600c:4fd3:b0:412:f8e4:78cf with SMTP id o19-20020a05600c4fd300b00412f8e478cfmr1743734wmq.5.1709743331868;
        Wed, 06 Mar 2024 08:42:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8qyc9Qj4DIiRbo3ZG/X5cZ/V6KRAWNYAqX2pIF65DvpGlQjT2qW3qQIf1TkalTKiwhTTk5Q==
X-Received: by 2002:a05:600c:4fd3:b0:412:f8e4:78cf with SMTP id o19-20020a05600c4fd300b00412f8e478cfmr1743710wmq.5.1709743331443;
        Wed, 06 Mar 2024 08:42:11 -0800 (PST)
Received: from toolbox ([2001:9e8:89a4:b300:8654:3fb5:7140:1e06])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c500600b00412ee8e2f2asm5119679wmr.9.2024.03.06.08.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 08:42:11 -0800 (PST)
Date: Wed, 6 Mar 2024 17:42:09 +0100
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
Message-ID: <20240306164209.GA11561@toolbox>
References: <20240305135155.231687-1-sebastian.wick@redhat.com>
 <20240306102721.3c9c3785.pekka.paalanen@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306102721.3c9c3785.pekka.paalanen@collabora.com>

On Wed, Mar 06, 2024 at 10:27:21AM +0200, Pekka Paalanen wrote:
> On Tue,  5 Mar 2024 14:51:49 +0100
> Sebastian Wick <sebastian.wick@redhat.com> wrote:
> 
> > The initial idea of the Colorspace prop was that this maps 1:1 to
> > InfoFrames/SDP but KMS does not give user space enough information nor
> > control over the output format to figure out which variants can be used
> > for a given KMS commit. At the same time, properties like Broadcast RGB
> > expect full range quantization range being produced by user space from
> > the CRTC and drivers to convert to the range expected by the sink for
> > the chosen output format, mode, InfoFrames, etc.
> > 
> > This change documents the reality of the Colorspace property. The
> > Default variant unfortunately is very much driver specific and not
> > reflected by the EDID. The BT2020 variants are in active use by generic
> > compositors which have expectations from the driver about the
> > conversions it has to do when selecting certain output formats.
> > 
> > Everything else is also marked as undefined. Coming up with valid
> > behavior that makes it usable from user space and consistent with other
> > KMS properties for those variants is left as an exercise for whoever
> > wants to use them.
> > 
> > v2:
> >  * Talk about "pixel operation properties" that user space configures
> >  * Mention that user space is responsible for checking the EDID for sink
> >    support
> >  * Make it clear that drivers can choose between RGB and YCbCr on their
> >    own
> > 
> > Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
> > ---
> >  drivers/gpu/drm/drm_connector.c | 79 +++++++++++++++++++++++++--------
> >  include/drm/drm_connector.h     |  8 ----
> >  2 files changed, 61 insertions(+), 26 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> > index b0516505f7ae..65cdcc7d22db 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -2147,24 +2147,67 @@ EXPORT_SYMBOL(drm_mode_create_aspect_ratio_property);
> >   * DOC: standard connector properties
> >   *
> >   * Colorspace:
> > - *     This property helps select a suitable colorspace based on the sink
> > - *     capability. Modern sink devices support wider gamut like BT2020.
> > - *     This helps switch to BT2020 mode if the BT2020 encoded video stream
> > - *     is being played by the user, same for any other colorspace. Thereby
> > - *     giving a good visual experience to users.
> > - *
> > - *     The expectation from userspace is that it should parse the EDID
> > - *     and get supported colorspaces. Use this property and switch to the
> > - *     one supported. Sink supported colorspaces should be retrieved by
> > - *     userspace from EDID and driver will not explicitly expose them.
> > - *
> > - *     Basically the expectation from userspace is:
> > - *      - Set up CRTC DEGAMMA/CTM/GAMMA to convert to some sink
> > - *        colorspace
> > - *      - Set this new property to let the sink know what it
> > - *        converted the CRTC output to.
> > - *      - This property is just to inform sink what colorspace
> > - *        source is trying to drive.
> > + *	This property is used to inform the driver about the color encoding
> > + *	user space configured the pixel operation properties to produce.
> > + *	The variants set the colorimetry, transfer characteristics, and which
> > + *	YCbCr conversion should be used when necessary.
> > + *	The transfer characteristics from HDR_OUTPUT_METADATA takes precedence
> > + *	over this property.
> > + *	User space always configures the pixel operation properties to produce
> > + *	full quantization range data (see the Broadcast RGB property).
> > + *
> > + *	Drivers inform the sink about what colorimetry, transfer
> > + *	characteristics, YCbCr conversion, and quantization range to expect
> > + *	(this can depend on the output mode, output format and other
> > + *	properties). Drivers also convert the user space provided data to what
> > + *	the sink expects.
> 
> Hi Sebastian,
> 
> should it be more explicit that drivers are allowed to do only
> RGB->YCbCr and quantization range conversions, but not TF nor gamut
> conversions?
> 
> That is, if the driver cannot pick the TF implied by "Colorspace"
> property for the sink, then it cannot pick another TF for the sink and
> silently convert. It think this should apply to all options including
> the undefined ones. Or is that too much to guess?

That's a really good point. I'll add it in the next revision.

> > + *
> > + *	User space has to check if the sink supports all of the possible
> > + *	colorimetries that the driver is allowed to pick by parsing the EDID.
> 
> All? Rather than at least one?
> 
> Is this how it has been implemented for BT2020, that userspace picked
> colorimetry and driver picked color model and quantization are
> completely independent, and drivers do not check the combination
> against EDID?

AFAIK the driver exposes all Colorspace variants that it can support in
the driver, independent of the sink. That means user space has to make
sure that the sink supports all colorimetry variants the driver can
pick.

Would be good to get a confirmation from Harry and Ville.

> If so, "all" it is. Would be good to explain this in the commit message.

Will do.

> > + *
> > + *	For historical reasons this property exposes a number of variants which
> > + *	result in undefined behavior.
> > + *
> > + *	Default:
> > + *		The behavior is driver-specific.
> > + *	BT2020_RGB:
> > + *	BT2020_YCC:
> > + *		User space configures the pixel operation properties to produce
> > + *		RGB content with Rec. ITU-R BT.2020 colorimetry, Rec.
> > + *		ITU-R BT.2020 (Table 4, RGB) transfer characteristics and full
> > + *		quantization range.
> > + *		User space can use the HDR_OUTPUT_METADATA property to set the
> > + *		transfer characteristics to PQ (Rec. ITU-R BT.2100 Table 4) or
> > + *		HLG (Rec. ITU-R BT.2100 Table 5) in which case, user space
> > + *		configures pixel operation properties to produce content with
> > + *		the respective transfer characteristics.
> > + *		User space has to make sure the sink supports Rec.
> > + *		ITU-R BT.2020 R'G'B' and Rec. ITU-R BT.2020 Y'C'BC'R
> > + *		colorimetry.
> > + *		Drivers can configure the sink to use an RGB format, tell the
> > + *		sink to expect Rec. ITU-R BT.2020 R'G'B' colorimetry and convert
> > + *		to the appropriate quantization range.
> > + *		Drivers can configure the sink to use a YCbCr format, tell the
> > + *		sink to expect Rec. ITU-R BT.2020 Y'C'BC'R colorimetry, convert
> > + *		to YCbCr using the Rec. ITU-R BT.2020 non-constant luminance
> > + *		conversion matrix and convert to the appropriate quantization
> > + *		range.
> > + *		The variants BT2020_RGB and BT2020_YCC are equivalent and the
> > + *		driver chooses between RGB and YCbCr on its own.
> > + *	SMPTE_170M_YCC:
> > + *	BT709_YCC:
> > + *	XVYCC_601:
> > + *	XVYCC_709:
> > + *	SYCC_601:
> > + *	opYCC_601:
> > + *	opRGB:
> > + *	BT2020_CYCC:
> > + *	DCI-P3_RGB_D65:
> > + *	DCI-P3_RGB_Theater:
> > + *	RGB_WIDE_FIXED:
> > + *	RGB_WIDE_FLOAT:
> > + *	BT601_YCC:
> > + *		The behavior is undefined.
> >   *
> >   * Because between HDMI and DP have different colorspaces,
> >   * drm_mode_create_hdmi_colorspace_property() is used for HDMI connector and
> > diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> > index fe88d7fc6b8f..02c42b01a3a7 100644
> > --- a/include/drm/drm_connector.h
> > +++ b/include/drm/drm_connector.h
> > @@ -437,14 +437,6 @@ enum drm_privacy_screen_status {
> >   *
> >   * DP definitions come from the DP v2.0 spec
> >   * HDMI definitions come from the CTA-861-H spec
> > - *
> > - * A note on YCC and RGB variants:
> > - *
> > - * Since userspace is not aware of the encoding on the wire
> > - * (RGB or YCbCr), drivers are free to pick the appropriate
> > - * variant, regardless of what userspace selects. E.g., if
> > - * BT2020_RGB is selected by userspace a driver will pick
> > - * BT2020_YCC if the encoding on the wire is YUV444 or YUV420.
> >    *
> >   * @DRM_MODE_COLORIMETRY_DEFAULT:
> >   *   Driver specific behavior.
> 
> This looks really good. This also makes me need to revisit the Weston
> series I've been brewing that adds "Colorspace" KMS support.
> 
> I think the two questions I had may be slightly too much in the
> direction of improving rather than just documenting this property, so
> I'll already give
> 
> Reviewed-by: Pekka Paalanen <pekka.paalanen@collabora.com>

Thanks.

> 
> Thanks,
> pq



