Return-Path: <linux-kernel+bounces-61919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2D85186B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA2C28253A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3428F3CF69;
	Mon, 12 Feb 2024 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqHcer/r"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A433CF4C;
	Mon, 12 Feb 2024 15:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752983; cv=none; b=Loh2nwP4xi8wFt8PcoY5dETwOx6YLnek4vlmgeWS0EL65r2W2XZ7lydo/uX5ZjML7Xj0/Lbh/b4eJbQQnvs0Uz2cMlylOtu8QEsZ8kEv4yxreyJMMLEkOsAbQYVRaWhT8jx/fSuVjtuM1g4IHKQJ6CAfElGS9QOF+z+kO8RCUv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752983; c=relaxed/simple;
	bh=RaXsYzelOZvoa5TGyCbteu+6xy/YY/Aun1Nfajjsacg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HLfrSYGpX8uzRdfSK2e4WZMNNPTPpJGy9ywMPGnh0xky0nxBXHkUwXBoKNFddwV0t/GUgE6NppqeoOEyKEF4s5lR2z+Z4rpdqOXlAmtQ47vl9gPYB/ZJd20hu6TqUb5NfzY/0S8ven3t5Z8quZQYIdWleIpk+AYoP2Xz5JZQMBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqHcer/r; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707752982; x=1739288982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RaXsYzelOZvoa5TGyCbteu+6xy/YY/Aun1Nfajjsacg=;
  b=IqHcer/rhQbI3jE9pk0HNclSvXd1+WkzQJuInfZk74hQ4NXffibKBtyF
   eY+dyHqfY6Z6WY5bJa7Q34WIuIX7BJZtHIf9/QUNwymyscWgyfvMzkTY+
   POcgRZ2AZI3Z31rOvVc3D8v0NwneDy0x8yRSQYnphAf+n1fVIoE/+Ggi2
   CcAx2LFN5POd0iDeOTpaRz8HXxyAY9GbomJez+Dfex5bzpf7HJWC1TT0x
   d4ctc/jgOUeGb4tjapS89Ck/Z3k7aGPhvkz8cZK/1XZEsIoFIwSaebd5k
   pdU89HupPg91VZhLffeSvL0orKiJ8b3pt9ZueCQcZ865re9bGpYGdZzZj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="24202747"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="24202747"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 07:49:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="825840546"
X-IronPort-AV: E=Sophos;i="6.06,264,1705392000"; 
   d="scan'208";a="825840546"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 12 Feb 2024 07:49:34 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 12 Feb 2024 17:49:33 +0200
Date: Mon, 12 Feb 2024 17:49:33 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Sebastian Wick <sebastian.wick@redhat.com>,
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
Subject: Re: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add
 Broadcast RGB property
Message-ID: <Zco-DQaXqae7B1jt@intel.com>
References: <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
X-Patchwork-Hint: comment

On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> > On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrjälä wrote:
> > > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > > > >  /**
> > > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > > >   *
> > > > > > > > > > + * Broadcast RGB
> > > > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > > > > + *
> > > > > > > > > > + *      The value of this property can be one of the following:
> > > > > > > > > > + *
> > > > > > > > > > + *      Automatic:
> > > > > > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > > + *
> > > > > > > > > > + *      Full:
> > > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > > + *
> > > > > > > > > > + *      Limited 16:235:
> > > > > > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > > > > > + *              this works for any number of bits-per-component.
> > > > > > > > > > + *
> > > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > > > + *
> > > > > > > > > 
> > > > > > > > > This is a good time to document this in more detail. There might be two
> > > > > > > > > different things being affected:
> > > > > > > > > 
> > > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > > 2. The color pipeline processing
> > > > > > > > > 
> > > > > > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > > > > > 
> > > > > > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > > > 
> > > > > > > > > When full or limited is selected and the monitor doesn't support the
> > > > > > > > > signalling, what happens?
> > > > > > > > 
> > > > > > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > > > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > > > > > YCbCr?
> > > > > > > 
> > > > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > > > > > we're using a YCbCr format, i915 will always use a limited range while
> > > > > > > vc4 will follow the value of the property.
> > > > > > 
> > > > > > The property is literally called "Broadcast *RGB*".
> > > > > > That should explain why it's only affecting RGB.
> > > > > 
> > > > > Right. And the limited range option is called "Limited 16:235" despite
> > > > > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > > > > to make names inconsistent too, that's fine and not an argument in
> > > > > itself.
> > > > > 
> > > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > > to enable it.
> > > > > 
> > > > > vc4 supports it.
> > > > 
> > > > Someone implemented it incorrectly then.
> > > 
> > > Incorrectly according to what documentation / specification? I'm sorry,
> > > but I find it super ironic that i915 gets to do its own thing, not
> > > document any of it, and when people try to clean things up they get told
> > > that we got it all wrong.
> > 
> > FWIW, this was an i915 property and if another driver uses the same
> > property name it must have the same behavior. Yes, it isn't standardized
> > and yes, it's not documented (hence this effort here) but it's still on
> > vc4 to make the property compatible.
> 
> How is it not compatible? It's a superset of what i915 provides, but
> it's strictly compatible with it.

No it is not. Eg. what happens if you set the thing to full range for
RGB (which you must on many broken monitors), and then the kernel
automagically switches to YCbCr (for whatever reason) but the monitor
doesn't support full range YCbCr? Answer: you get crap output.

> 
> I would argue that i915 is the broken one since userspace could force a
> full range output, but since the driver takes the YUV vs RGB decision
> itself and only supports limited range for YUV, the driver would
> effectively ignore that user-space property, without the user-space
> being able to tell it was ignored in the first place.
> 
> > Trying to make the property handle YCbCr is very much in the "let's try
> > to fix the property" territory that I want to avoid, so I'm in favor of
> > adjusting vc4.
> 
> Breaking the ABI in the process. For something that is explicitly
> supported by the spec, the driver, and the hardware. On a property that
> never said it wasn't meant to be used that way, and with semantics based
> on a driver that never provided a way to check those restrictions in the
> first place.
> 
> And it's not like i915 is going to use that code anyway.
> 
> Maxime



-- 
Ville Syrjälä
Intel

