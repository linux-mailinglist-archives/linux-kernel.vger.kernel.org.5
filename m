Return-Path: <linux-kernel+bounces-88343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908B086E044
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 490B22881FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF8B6CDBD;
	Fri,  1 Mar 2024 11:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZEufbuFz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563E56BFD4
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709292590; cv=none; b=ez7NROlmZRsXA4Yg1q1ULXJD8D6NvSXtF/iPredTBbxJoNdS/irzVofur0Z0Q3iKoYFM/VDgIoWka2VcJtLWGAPp/i6wtcOfhoOgW+vZ72A60Lokmea0ow6bceNwSHgoRrSh715hpFuNnmoFWwWt6qSwvl8fCymlMkhtX4rzY7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709292590; c=relaxed/simple;
	bh=zog0qIVMaTlG1ASknli4b3SB8p1aLaDCqtbud0WxAu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2OzDBnbWNKdYwkj58p0gRZW8RLpO702eDBheVcOmvG45yI+QsbEbBLnS38VUIUwjD9oczltWuZt0rc5h8r92pJnsh/KRHI8Fb981OsMcihA/GAn+dzvv/XaBYxj66j3R7nIHkYqUbDRvm29GSz5fy0WI/7LG+jZzzjhxWILesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZEufbuFz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709292588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qRUqDJ3Iv/k5nE0Cga6hqzTdj9gEhtnN2QTBMasCuKc=;
	b=ZEufbuFzUmsxRs1JzqLkGCMOKg3YlKE5F/gSri1oNi3kvUN+NOZ5pAjrEz/sSKVBe3MWG7
	3FSuNLgiEaMdZpSDWLbF9ZpTXw4HpOGyYOyBteAyYl/3t3z77RSK4zZhGxQBRT5YDFHxfs
	Sh8z8j5CW7ECe1wtktDortp2kmvyRVo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-Y5aj_OwXMPG36iQ_Yn8-Vg-1; Fri, 01 Mar 2024 06:29:45 -0500
X-MC-Unique: Y5aj_OwXMPG36iQ_Yn8-Vg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-412aae6022bso9596685e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 03:29:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709292584; x=1709897384;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRUqDJ3Iv/k5nE0Cga6hqzTdj9gEhtnN2QTBMasCuKc=;
        b=tS7Eyf+06hg9hhwGo+mJN90ITt9dGawer1LgZsMfrJ2oPxnJqYC5rjuSLyb4CJoVXM
         iuVJU3BFroSHdkb+rS6g9MK4ZeD46phS2NEn9nhmZ4U5skcL3bwTv8h7a11oIIDJ9XAJ
         VivYRqgxTVtab0Op8JV8OcMqA/nhsLabAItdWhgGvx1zc0qTHwcXuiseG6f1TbsU+ARK
         dUACEELPfr47TKwdhOusvbQl0XGRq8kzNXeeBAqEq2joiE6ftOITbedMTJH0/N2yH7GL
         8L7PHnKNsiLV5NxoJjYtAtmpueK0NC+JRJMfdvLjUz2exdfBGgvqF9oTUewvcEIv3AyD
         aWnA==
X-Forwarded-Encrypted: i=1; AJvYcCViS/8f+NM6yVosuc3QclDgCLYfH8p9aIbXEzJTEyRPtAy3YaBXxphVw5hdYrBmg8qgNPD9cHKWAaTxHR5moDMPbe86lejD1Uz0Qe/W
X-Gm-Message-State: AOJu0YydfiucQESYrz3fKioPOubPws34d6JZhOQAHJhNGparC9MC/ir9
	aTw/KxuLeLPz7B2ElBwmEsbtpbxzzYny93Y5L2P98ubhzzPYzt1nK7fr9VmB6hDFAMuCnIZH08X
	yUvH7V3YXdx/iDbz1Ika9qE+8UZ1IV/y38YwMF9IW0X6MAqQHnvsIiSQMa4J1tg==
X-Received: by 2002:a05:600c:4fc4:b0:412:c8c9:c844 with SMTP id o4-20020a05600c4fc400b00412c8c9c844mr988483wmq.26.1709292584013;
        Fri, 01 Mar 2024 03:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKqlwQ+JstuXu5h4wbg4ZOpZ/dkea6nQ1ibG6iOdPso+qOIY2FCKYMPY6GH4tsyMvb9w+yJg==
X-Received: by 2002:a05:600c:4fc4:b0:412:c8c9:c844 with SMTP id o4-20020a05600c4fc400b00412c8c9c844mr988453wmq.26.1709292583675;
        Fri, 01 Mar 2024 03:29:43 -0800 (PST)
Received: from toolbox ([2001:9e8:89a0:c500:c65:1f3a:8c08:2a1d])
        by smtp.gmail.com with ESMTPSA id bi19-20020a05600c3d9300b00412ca030252sm1036720wmb.30.2024.03.01.03.29.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:29:43 -0800 (PST)
Date: Fri, 1 Mar 2024 12:29:41 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>, Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v7 21/36] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <20240301112941.GE166694@toolbox>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-21-8f4af575fce2@kernel.org>
 <20240229194726.GB166694@toolbox>
 <20240301-light-impressive-grasshopper-adabeb@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301-light-impressive-grasshopper-adabeb@houat>

On Fri, Mar 01, 2024 at 11:30:56AM +0100, Maxime Ripard wrote:
> On Thu, Feb 29, 2024 at 08:47:26PM +0100, Sebastian Wick wrote:
> > > @@ -1708,6 +1731,39 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
> > >  /**
> > >   * DOC: HDMI connector properties
> > >   *
> > > + * Broadcast RGB (HDMI specific)
> > > + *      Indicates the Quantization Range (Full vs Limited) used. The color
> > > + *      processing pipeline will be adjusted to match the value of the
> > > + *      property, and the Infoframes will be generated and sent accordingly.
> > > + *
> > > + *      This property is only relevant if the HDMI output format is RGB. If
> > > + *      it's one of the YCbCr variant, it will be ignored and the output will
> > > + *      use a limited quantization range.
> > 
> > Uh, maybe just say that the quantization range is selected automatically
> > in case a YCbCr output format is in use. I'm not sure every YCbCr
> > variant requires limited and even if it does, new formats could change
> > this.
> 
> I documented what i915 is doing:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/i915/display/intel_hdmi.c#L2143

Sure, this is one valid strategy for the automatic behavior of YCbCr.
Drivers could also always send an InfoFrame to ensure full range where
possible. The point here is that this property shall not affect YCbCr
output formats!

Maybe it's even better to say "driver specific" instead of "automatic".

> Maxime
> 


