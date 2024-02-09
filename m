Return-Path: <linux-kernel+bounces-59943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAA184FDA5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FCA51C220D2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DFF96112;
	Fri,  9 Feb 2024 20:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FKT/vGg/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A682A53A9
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707510884; cv=none; b=pH9SOF1B+EHv2wV05RtMaCmQrVMaLirM4Wh4CymnIqTnGGg5s6LZT8gfxOdPXeerCZpX/qKPDwrAtdOfNfHbZM1tcv6BcAf/ql59XOyuIGnzJt+qVeDuPhLbhJJlPWZ1ZoGxW82kdIWbi5qQpD+r3oOJpquISH+mQGJIxxzvzcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707510884; c=relaxed/simple;
	bh=T/OOwcQ1xR9qJ8cy0QMkAgwIKFttYq+EPHy71IqMHDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U1ZkYIuqBWLg2lckJqATF/LKRD351M04eyundhv/oTQhiJNPGY3iMz0nKICCeuwgqZ6KMqnL4Pz/kxPjapftEDkPHlUCMkySSprCff7pQBNBP58iMlWpCmbNcamDbclH2UkSpEvKSKHrUC8QqniNK/jpDMi71zCPrZC2uT18iP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FKT/vGg/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707510881;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j2wWnG4c9flOTNWJ6O8wnfxhMZrHV7GwnwMrXW3f8A8=;
	b=FKT/vGg/rvac8YEYuzlRNfhZpY13eRxUHpVNDCyxQOwx6qI1Vei2KcWDxY/xZaPyK0OMie
	EJ8SPGTRS7na6AwdR8zIzoy5bQ9Blyl4VVRIHcgG0+/7/nfptPKqtbwbNUdBDGZ6RRDPSS
	D2vQIQpf7mGauLZwX2dH/n11PUQthZU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-p7a1Lf3MPKmhfWu9HjkrVg-1; Fri, 09 Feb 2024 15:34:39 -0500
X-MC-Unique: p7a1Lf3MPKmhfWu9HjkrVg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4107802453dso4637175e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 12:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707510878; x=1708115678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j2wWnG4c9flOTNWJ6O8wnfxhMZrHV7GwnwMrXW3f8A8=;
        b=wIxfeI7+qqg5333ysg5KVakS9Pp6trhOZzeMbOveQmGzkVSHdj6fgqPFmDDd/l0YI4
         0pRzfu7Nl2siRiQEZUgjzY3gbPzYv2yEvduqQ2WX0z/QWlYDWMtu0YUNyVVYxpUIb67u
         +AW4a2pDVWVD6LFsyYTzKaxT1/lwQiamjlm6Bua/NccF9kAA9hlWvQTl/EGc/jDXZUnr
         OhunXEqP8jzrboEPShc/CFJjEmIksZCFFkKGwvsGg/X9z3RIp87b1cbQ1GkzDLQQ8muB
         h2yg9wgmzCrL1lNFO4Nem3MqGQGgO+BK25/dF7f76c5ndKkKZoAMQ8CykC2vQoV6MMPl
         kIwg==
X-Forwarded-Encrypted: i=1; AJvYcCXaqyIxYtGq+f47NsLKWAZRsFvE1XUfT1yHNt7QJgWM+WsJq7L6zy9yMBjqDiu9JHFphLjyUCckvhIrx5+DiQyaivJAWqUCXr4WBenV
X-Gm-Message-State: AOJu0YyN6Dyuf0PvxkjefLq7WnuZOWYp1x9VifzgRbKMNotQeO6x+nc2
	xcsl0q9gHcRhsJ7bYuEzQ5zZacRIpuTP00MumQt4XtmKy9R3vbPH7BupXO14mksGCuskPFVar8g
	zLmDyRix6aJNXzLv0khJXt0Gtly11MoKxCCrWkqdGmQow1wTjSMPOuBvaUyB3/w==
X-Received: by 2002:a05:600c:1da0:b0:410:67c7:4aec with SMTP id p32-20020a05600c1da000b0041067c74aecmr360330wms.2.1707510878045;
        Fri, 09 Feb 2024 12:34:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF13pfF52uklm5dhWcBcvNdikZJOPXaH04X4IAFneBMKzMG8gczhKEBhOer9kGWxz4bpMboiA==
X-Received: by 2002:a05:600c:1da0:b0:410:67c7:4aec with SMTP id p32-20020a05600c1da000b0041067c74aecmr360309wms.2.1707510877712;
        Fri, 09 Feb 2024 12:34:37 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUTFIpsyOPGLuOIRqyqojYZLXShV7fMVG8lKMKh8RWmrfILG4wVCf8gLUYnmxYZ6GojncTWgKEfP5koXhwu+L8mW7OdvkwtZN0qrjcaqiHaZqA7TU3roMpuu6JlMFFn+4qCBNlcejLlIfxt7yTqAQw44eq+2Gt3YvBKnODhx8UY004UIxjjJmMD1qB8k6iA5fh1kaHrSuUy+P8HziuYc5LiaFqmAu6pVpkvLeEb2evFtiqUaryp00KXCh/C+JzQZfr8YsNSQzKLSVIflmMGGpSXjhNZz7cEqPFNSPjqXXehfees138vEzAxsGDxWT/4m4Kb+BvL/VwHZf7h55cfdzPilGIWTQfjIlqsRLmTFjyNer9tvYV+fHP5NIvBrWkMuwK4zw081lC9wBo9G6v4Lqk9xFPzRi8ziXvrhzNkJGbvi8TR/Z2Bgw/uoru6FUJCpZZJRqb7Ak7PPwX2n1rGOXJPLjAI40lx4ryIIzK0+gPD5GtLOxedGKUhcKBzmmJYY3EPUoCscwHprrNUxAOqFjsFt9Dfx9HtZzehHYRn9fzQ/33OGqc6nEBUZ8In8El5X3dvcPBxG9zUrq9xbcPP0dphQoN8skR0FjYoQt0mIrjjraq/ahk149YTxa6askU6srquoL4TIMYWmij5nI37tV9iVNaet/SQt/58ZLbUrl60mQ==
Received: from toolbox ([2001:9e8:898e:7200:1f00:29c:19b0:2997])
        by smtp.gmail.com with ESMTPSA id r2-20020a056000014200b0033b4acb999dsm115375wrx.98.2024.02.09.12.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 12:34:37 -0800 (PST)
Date: Fri, 9 Feb 2024 21:34:35 +0100
From: Sebastian Wick <sebastian.wick@redhat.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
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
Subject: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast
 RGB property
Message-ID: <20240209203435.GB996172@toolbox>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>

On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrjälä wrote:
> > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > Hi,
> > > > > 
> > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > >  /**
> > > > > > > >   * DOC: HDMI connector properties
> > > > > > > >   *
> > > > > > > > + * Broadcast RGB
> > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > > + *
> > > > > > > > + *      The value of this property can be one of the following:
> > > > > > > > + *
> > > > > > > > + *      Automatic:
> > > > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > + *
> > > > > > > > + *      Full:
> > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > + *
> > > > > > > > + *      Limited 16:235:
> > > > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > > > + *              this works for any number of bits-per-component.
> > > > > > > > + *
> > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > + *
> > > > > > > 
> > > > > > > This is a good time to document this in more detail. There might be two
> > > > > > > different things being affected:
> > > > > > > 
> > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > 2. The color pipeline processing
> > > > > > > 
> > > > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > > > 
> > > > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > 
> > > > > > > When full or limited is selected and the monitor doesn't support the
> > > > > > > signalling, what happens?
> > > > > > 
> > > > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > > > YCbCr?
> > > > > 
> > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > > > we're using a YCbCr format, i915 will always use a limited range while
> > > > > vc4 will follow the value of the property.
> > > > 
> > > > The property is literally called "Broadcast *RGB*".
> > > > That should explain why it's only affecting RGB.
> > > 
> > > Right. And the limited range option is called "Limited 16:235" despite
> > > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > > to make names inconsistent too, that's fine and not an argument in
> > > itself.
> > > 
> > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > to enable it.
> > > 
> > > vc4 supports it.
> > 
> > Someone implemented it incorrectly then.
> 
> Incorrectly according to what documentation / specification? I'm sorry,
> but I find it super ironic that i915 gets to do its own thing, not
> document any of it, and when people try to clean things up they get told
> that we got it all wrong.

FWIW, this was an i915 property and if another driver uses the same
property name it must have the same behavior. Yes, it isn't standardized
and yes, it's not documented (hence this effort here) but it's still on
vc4 to make the property compatible.

Trying to make the property handle YCbCr is very much in the "let's try
to fix the property" territory that I want to avoid, so I'm in favor of
adjusting vc4.

> > > > Eg. with DP it only became possible with the introduction of the VSC
> > > > SDP (and I don't recall if there's additional capability checks that
> > > > are also required). With DP MSA signalling full range YCbCr is not
> > > > possible at all.
> > > 
> > > This is for HDMI only.
> > > 
> > > > I don't recall right now what the HDMI requirements are.
> > > 
> > > HDMI has supported it for a while, and it's defined (for example) in the
> > > HDMI 1.4 spec in Section 6.6 - Video Quantization Ranges. It supports
> > > limited and full range on both RGB and YCbCr, as long as the EDIDs state
> > > so and the Infoframes signal it.
> > 
> > I think a good reason for not using a simple boolean like this 
> > YCbCr is that it doesn't cover the color encoding part at all,
> > which is probably more important than the quantization range.
> > So we need a new property anyway.
> 
> This isn't what is being discussed here, and as I've shown you, is
> completely orthogonal as far as HDMI is concerned.
> 
> Maxime



