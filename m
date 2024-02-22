Return-Path: <linux-kernel+bounces-76565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B4C85F93F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E9E81C20E98
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922C41350CA;
	Thu, 22 Feb 2024 13:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSQffAGU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAB7608ED
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708607538; cv=none; b=NbmKOehGJQyOSlCDHlknqpvLYudoEYP2VNeqNE68247x4K3zSgaAVpnTQcFkxw1yhlCPWS8keqJEfJn1LTEb31NLaiU9DXn/Tg3TgSOLASF0wPVlOc/x+tIu/IH4StXKhB1poLrmQuEnLqwN8ZpkDrrasARFHpajh9cX7hx3uHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708607538; c=relaxed/simple;
	bh=/1e0rKmP6T+IZrsC2QM6ifGfG3RYGvNYfMn6/DWKoIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyGu6VjxTfzBYN/Q3r2dHX03rQuXpur7OhW8QK6G2V3DlQoayAwutjPN6rz5/4GOu48bJeF8rCzTYDwSy86CyIZHf9jqPJlPg6pYwBbt6Bjw+GuKy84eyUnAkzYuzmKiJ5XysmvtkAlw6IczNtnDDd5KCNmjwFAufCco0bmbB+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSQffAGU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708607535;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/rZwXlN3+rt9lmwvddhJ6lNaAg1yTingK5zSV78YIBs=;
	b=dSQffAGUeBlMGTEr10JkuNhivrCosOcdMYyxHyCspHwghjVc2atHpoiY8rqtluahOHl8cQ
	cxAQgReUpmjxIpRcygAR4s3Z249ImbTLz800mAkbESwmfVJhow1WJwJGgGRE15ZmYYRVto
	iDEjheYvpk1Rg2EOOP1nJAoGtnuFtCU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-Wz4C-K1nPKexS9REsFYsFA-1; Thu, 22 Feb 2024 08:12:14 -0500
X-MC-Unique: Wz4C-K1nPKexS9REsFYsFA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41082621642so41350615e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 05:12:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708607533; x=1709212333;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rZwXlN3+rt9lmwvddhJ6lNaAg1yTingK5zSV78YIBs=;
        b=mLXm4OsEobUhcaa1ODu+UEjpghcHVy/mbVzPpd5PiiXOFSXn23OGOEo0HbkMDQq8x0
         DuO4hU0X2QI61u5IWhy50fCiRH1zVWSmCss9HIGEoofygPmdiGZ1gpXIzhoecMHXdiYF
         kNKE1eTAeTZ1qFtjqCvSt++WGiRnLm8vGuNWyTLz0hdQdI4Tt5SuGElD0NTj2MC9n8Rh
         pRXcusEo/AfJRj/AcdJTpYSATAnyGVDQdIDhJ536bk6foOMsTKZ2ESAcgj4tcsPjQ3Vy
         1e0MGREWVBGI5z0qp2R0nS4C4mDfDNNtmjAgepW2Wt9BOYUc++SxOI/iXFGBny55P3Tb
         WwNg==
X-Forwarded-Encrypted: i=1; AJvYcCVMC5fk0iDT1CNAE35i7x1EEcMpt0ruIr1MUBT3D2WTo9rIK1c4Uc78TWIDrmDnz7n5pMwPU0xytUA7Bz7sDVY4vSjtN4mFBQk7pdBs
X-Gm-Message-State: AOJu0Yx56HWZrRPGMP32ghjOpWBOqmziVMH1V3zRmVrf0SfaYqzqPu05
	gDbHCwWass7jF4Y/spZ2uWtkNXpSL0zB9Nf5jHeKFxwrk+Pvkc68w7VgDOu/yKpu/GA6D/OslSM
	lgSBoFXC8lRHikUzUbkGDNcp2+SR1Qw5w0y/IsZ8Nmntngo7N4gW5bUBjpx46Sw==
X-Received: by 2002:a05:600c:310e:b0:412:7218:bda4 with SMTP id g14-20020a05600c310e00b004127218bda4mr4380823wmo.19.1708607533228;
        Thu, 22 Feb 2024 05:12:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5XqSURveOjbO1VkGnuWlZrU2nGzUGAvm+K3BM/xVrrJRRrntfTjTe48FJywj6JtVook8iJA==
X-Received: by 2002:a05:600c:310e:b0:412:7218:bda4 with SMTP id g14-20020a05600c310e00b004127218bda4mr4380794wmo.19.1708607532795;
        Thu, 22 Feb 2024 05:12:12 -0800 (PST)
Received: from toolbox ([2001:9e8:89bc:5400:b148:5c28:6821:6aa5])
        by smtp.gmail.com with ESMTPSA id m12-20020a5d4a0c000000b0033b60bad2fcsm20208517wrq.113.2024.02.22.05.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 05:12:12 -0800 (PST)
Date: Thu, 22 Feb 2024 14:12:10 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>,
	Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Hans Verkuil <hverkuil@xs4all.nl>,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <20240222131210.GA2405678@toolbox>
References: <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
 <Zco-DQaXqae7B1jt@intel.com>
 <yx2t7xltxxgsngdsxamsfq6y7dze3wzegxcqwmsb5yrxen73x6@u3vilqhpci4w>
 <20240212170618.GA1372043@toolbox>
 <2mih3humepuedtli7ge52ncom4uffkqravdpalncgfyucmwdzc@bp5o7i3ky77a>
 <20240219140144.GB1956149@toolbox>
 <euaujtp4jyyoud3ccg5qhyvixyq2p6vir4ojlzoky6kep754rj@wruidyfxssry>
 <ZddFBe4A-galsO91@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZddFBe4A-galsO91@intel.com>

On Thu, Feb 22, 2024 at 02:58:45PM +0200, Ville Syrjälä wrote:
> On Thu, Feb 22, 2024 at 11:54:04AM +0100, Maxime Ripard wrote:
> > On Mon, Feb 19, 2024 at 03:01:44PM +0100, Sebastian Wick wrote:
> > > On Thu, Feb 15, 2024 at 12:00:01PM +0100, Maxime Ripard wrote:
> > > > On Mon, Feb 12, 2024 at 06:06:18PM +0100, Sebastian Wick wrote:
> > > > > On Mon, Feb 12, 2024 at 05:53:48PM +0100, Maxime Ripard wrote:
> > > > > > On Mon, Feb 12, 2024 at 05:49:33PM +0200, Ville Syrjälä wrote:
> > > > > > > On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> > > > > > > > On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> > > > > > > > > On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > > > > > > > > > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrjälä wrote:
> > > > > > > > > > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > > > > > > > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > > > > > > > > > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > > > > > > > > > > >  /**
> > > > > > > > > > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > > > > > > > > > >   *
> > > > > > > > > > > > > > > > > + * Broadcast RGB
> > > > > > > > > > > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > > > > > > > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > > + *      The value of this property can be one of the following:
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > > + *      Automatic:
> > > > > > > > > > > > > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > > > > > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > > + *      Full:
> > > > > > > > > > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > > + *      Limited 16:235:
> > > > > > > > > > > > > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > > > > > > > > > > > > + *              this works for any number of bits-per-component.
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > This is a good time to document this in more detail. There might be two
> > > > > > > > > > > > > > > > different things being affected:
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > > > > > > > > > 2. The color pipeline processing
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > > > > > > > > > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > > > > > > > > > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > > > > > > > > > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > > > > > > > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > > When full or limited is selected and the monitor doesn't support the
> > > > > > > > > > > > > > > > signalling, what happens?
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > > > > > > > > > > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > > > > > > > > > > > > YCbCr?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > > > > > > > > > > > > we're using a YCbCr format, i915 will always use a limited range while
> > > > > > > > > > > > > > vc4 will follow the value of the property.
> > > > > > > > > > > > > 
> > > > > > > > > > > > > The property is literally called "Broadcast *RGB*".
> > > > > > > > > > > > > That should explain why it's only affecting RGB.
> > > > > > > > > > > > 
> > > > > > > > > > > > Right. And the limited range option is called "Limited 16:235" despite
> > > > > > > > > > > > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > > > > > > > > > > > to make names inconsistent too, that's fine and not an argument in
> > > > > > > > > > > > itself.
> > > > > > > > > > > > 
> > > > > > > > > > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > > > > > > > > > to enable it.
> > > > > > > > > > > > 
> > > > > > > > > > > > vc4 supports it.
> > > > > > > > > > > 
> > > > > > > > > > > Someone implemented it incorrectly then.
> > > > > > > > > > 
> > > > > > > > > > Incorrectly according to what documentation / specification? I'm sorry,
> > > > > > > > > > but I find it super ironic that i915 gets to do its own thing, not
> > > > > > > > > > document any of it, and when people try to clean things up they get told
> > > > > > > > > > that we got it all wrong.
> > > > > > > > > 
> > > > > > > > > FWIW, this was an i915 property and if another driver uses the same
> > > > > > > > > property name it must have the same behavior. Yes, it isn't standardized
> > > > > > > > > and yes, it's not documented (hence this effort here) but it's still on
> > > > > > > > > vc4 to make the property compatible.
> > > > > > > > 
> > > > > > > > How is it not compatible? It's a superset of what i915 provides, but
> > > > > > > > it's strictly compatible with it.
> > > > > > > 
> > > > > > > No it is not.
> > > > > > 
> > > > > > The property is compatible with i915 interpretation of it, whether you
> > > > > > like it or not. And that's what Sebastian was referring to.
> > > > > > 
> > > > > > > Eg. what happens if you set the thing to full range for RGB (which you
> > > > > > > must on many broken monitors), and then the kernel automagically
> > > > > > > switches to YCbCr (for whatever reason) but the monitor doesn't
> > > > > > > support full range YCbCr? Answer: you get crap output.
> > > > > > 
> > > > > > And that part is just moving goalposts.
> > > > > 
> > > > > But it's really not.
> > > > 
> > > > It really is. This whole discussion started by "well it would be nice if
> > > > we made that property handled by the core", and we're now at the "we
> > > > need to deal with broken YCbCr displays and i915 opinion about them"
> > > > stage. After creating documentation, unit tests, etc. It's the textbook
> > > > definition of moving goalposts. And while i915 won't be affected by all
> > > > that work.
> > > 
> > > Sorry, but what you're saying is just not true.
> > > 
> > > The Broadcast RGB property is an Intel specific property.
> > 
> > No, it's not. vc4 has been using it for a year now.
> > 
> > > It lacked documentation but the user space contract exists and it
> > > based on how i915 implemented it. By changing the semantics you're
> > > breaking user space. The documentation has to document the current
> > > contract between i915 and user space, not whatever you want the
> > > property to be like.
> > > 
> > > I get that you're frustrated that you have to do work while i915 doesn't
> > > but none of that is relevant for what the property is and how user space
> > > expects it to work.
> > 
> > That's not it, really. I don't mind doing the work. I do mind losing
> > functionalities on something that was working fine. And getting the
> > blame for something that is, at best, just as much of an documentation
> > issue on i915 devs.
> 
> We've had a couple of these cases recently where people have taken
> some old property implemented by i915 and implemented it differently
> in some other driver. Dunno if the reason was that people didn't try
> to understand what i915 is doing and why, or they misundestood it,
> or they understood it but decided to ignore it anyway.
> 
> Unfortunately having undocumented corners in the uapi is simply
> a fact of life when dealing with a >15 year old legacy codebase.
> Also there were basically no rules regarding properties in the
> past, so everyone just added random properties whenever they 
> felt like it.
> 
> I think going forward we should probably lay down some extra
> ground rules; if an old undocumented uapi is being extended
> to cover more than one driver we must first figure out what
> the de facto semantics are, and document things properly
> before anything else gets done.

That would be great. The documentation already has requirements for new
properties. Adding the requirement for extending driver-specific
properties to more drivers there would be great and make it "official".

> 
> -- 
> Ville Syrjälä
> Intel
> 


