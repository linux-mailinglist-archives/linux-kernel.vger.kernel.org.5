Return-Path: <linux-kernel+bounces-50035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F193847381
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FC001C22D71
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96600146913;
	Fri,  2 Feb 2024 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ABhSRxiy"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C2C1798F;
	Fri,  2 Feb 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888457; cv=none; b=FU9IDYRq/uE86eAGZruJ0L4Mby1zghccM7uNUYNrac78v78RebUloDj/Roe2V5b1ReBWxIAN6S0+swHSbqWneS9AQOoqHY3uzuTQ1y93PELAk5iXjOD4yYxAbLSp3yHznIaXf/2GZKKJp1Peg3NUmtLxyyLa7m4mr8xlu3fLw6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888457; c=relaxed/simple;
	bh=Wzt2OKA98oRZpOPKfSYMaxS0U0E4dZGMDfd4SSadYFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHTolzLbzp2nwLpBOClcOH5A0Lrtez72tUtTKoaAdrTMqNjREyJdAuV1VDdHpLui9MYgkwsNnWeJcRpnE4CNV7T+BYmSk0gb1Umz9zJTeo679RarQctdt2jMIKtLFgBY3QaU7ABxipF/u2QSMvRkA/QoBcKJFST0oKhb1Gj6zCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ABhSRxiy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706888457; x=1738424457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Wzt2OKA98oRZpOPKfSYMaxS0U0E4dZGMDfd4SSadYFo=;
  b=ABhSRxiyJy8zTBa61YNqripqMeQNC2WejO5F4DjWpUM4wmERjFmDyeEG
   +WnOUflOM+Y2QTfYKjoSfhVu2KedSe9sryc9IQmoXyLfFXTo7uwYdNUqa
   vSj2grjgCZIbjFAxX+SSHq7cZ8pUoax/gdxwgztVak7lCnqH8Lz+9TjxF
   oOtFAzz+bA6ly+hnraBu4lREf2/+5M917LiwgJzXFlbEZpFZkjYYnw7yL
   lJ7+5Oi9JCnF/E5tytoGL4Z99op6j6VsuGvnUcBtkSrLuXEJjyl0X2Ah5
   1l0xInrbgnsaW31qv8D6E8kv1WyicqIffyPkkv3zH9m62oWcUrF1v267t
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="356367"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="356367"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 07:40:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823240563"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823240563"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 02 Feb 2024 07:40:48 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 02 Feb 2024 17:40:47 +0200
Date: Fri, 2 Feb 2024 17:40:47 +0200
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
Subject: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <Zb0M_2093UwPXK8y@intel.com>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
X-Patchwork-Hint: comment

On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > >  /**
> > > >   * DOC: HDMI connector properties
> > > >   *
> > > > + * Broadcast RGB
> > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > + *      Infoframes will be generated according to that value.
> > > > + *
> > > > + *      The value of this property can be one of the following:
> > > > + *
> > > > + *      Automatic:
> > > > + *              RGB Range is selected automatically based on the mode
> > > > + *              according to the HDMI specifications.
> > > > + *
> > > > + *      Full:
> > > > + *              Full RGB Range is forced.
> > > > + *
> > > > + *      Limited 16:235:
> > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > + *              this works for any number of bits-per-component.
> > > > + *
> > > > + *      Drivers can set up this property by calling
> > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > + *
> > > 
> > > This is a good time to document this in more detail. There might be two
> > > different things being affected:
> > > 
> > > 1. The signalling (InfoFrame/SDP/...)
> > > 2. The color pipeline processing
> > > 
> > > All values of Broadcast RGB always affect the color pipeline processing
> > > such that a full-range input to the CRTC is converted to either full- or
> > > limited-range, depending on what the monitor is supposed to accept.
> > > 
> > > When automatic is selected, does that mean that there is no signalling,
> > > or that the signalling matches what the monitor is supposed to accept
> > > according to the spec? Also, is this really HDMI specific?
> > > 
> > > When full or limited is selected and the monitor doesn't support the
> > > signalling, what happens?
> > 
> > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > the cable, so is this only affecting RGB? If not, how does it affect
> > YCbCr?
> 
> So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> we're using a YCbCr format, i915 will always use a limited range while
> vc4 will follow the value of the property.

The property is literally called "Broadcast *RGB*".
That should explain why it's only affecting RGB.

Full range YCbCr is a much rarer beast so we've never bothered
to enable it. Eg. with DP it only became possible with the
introduction of the VSC SDP (and I don't recall if there's
additional capability checks that are also required). With
DP MSA signalling full range YCbCr is not possible at all.
I don't recall right now what the HDMI requirements are.

-- 
Ville Syrjälä
Intel

