Return-Path: <linux-kernel+bounces-63130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4265B852B50
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:39:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAF11B209E2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF921AAD0;
	Tue, 13 Feb 2024 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nq+FAIFG"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E985318026;
	Tue, 13 Feb 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707813546; cv=none; b=MhQ2f/JsYWLSWtDp+3bU6FobzO0dscvGpCQozwMMOj+aqezwwj+v6onr2ZvNyW5+A8syGf79OQn0u855smNcsqvOjDhUACUfTXLR4TCJLShucgYzKJHfv3d9nIDddfPgwGx/RgrirJ5YZQqAuFWAYTjPMO/ZBTrZlDSTm8jQCxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707813546; c=relaxed/simple;
	bh=EW4hyg6ywuwUU3ETBIP6P9hAzw5rF+JafXM/qqClrws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=avs1y9JDav9cQD5zsRLTMUBxkDPAOs3zyUFHxzAUysHsG58QlO3JT1W3zWdul7qKmur+MMBSWvetj32PgkP4gXv6MYO/e2vqimmpdvxkOdMMVWRpOxkhZRcNvwhlp71RDGMjEbbAJGcW6Q+jg5D8w75ntp1nf76l9hMonwTQimI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nq+FAIFG; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707813545; x=1739349545;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EW4hyg6ywuwUU3ETBIP6P9hAzw5rF+JafXM/qqClrws=;
  b=Nq+FAIFGZ+vbGpaspxZZQWfqyNugROV6PtXFRLG/ecZM05I1/hnl5Pch
   1RfZ+UCB4q1eY0D1957NvXPYbXm1dN0/NHh1y3Na4VTGMVkqeZ4GUQSNQ
   FzuqXLKQ+CmnNYP2uFwgegqjOUA1fH/lfeM38NOhD0qF92noIQkCoigF8
   28JL7YE2j7XLam03dRHI4NiiDeWnBPpAq5j3bOjFZ/GHAQuTkzs0ucVTT
   IayjMpdrHnakqd9B6+uKfNjOLjOvrVsK7KWA/U/Jt1jBfJbAxL5oUxWnW
   03GgYBbZTd3mldytNV4biVsnNmBs4ohpCeBeqKIsUhk2qGofs3scxjyxR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5629257"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="5629257"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 00:39:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="826052613"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="826052613"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 13 Feb 2024 00:38:57 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 13 Feb 2024 10:38:56 +0200
Date: Tue, 13 Feb 2024 10:38:56 +0200
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
Subject: Re: Re: Re: Re: Re: Re: [PATCH v5 08/44] drm/connector: hdmi: Add
 Broadcast RGB property
Message-ID: <ZcsqoPCJDjA5PJUF@intel.com>
References: <20240115143720.GA160656@toolbox>
 <73peztbeeikb3fg6coxu3punxllgtyrmgco34tnxkojtsjbr3s@26bud3sjbcez>
 <Zb0M_2093UwPXK8y@intel.com>
 <hez2m57ogqx3yyqk45tzdkvxvhrbdepgm244i4m2aty2xhf5b5@acqgvmxhmmvr>
 <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
 <Zco-DQaXqae7B1jt@intel.com>
 <yx2t7xltxxgsngdsxamsfq6y7dze3wzegxcqwmsb5yrxen73x6@u3vilqhpci4w>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yx2t7xltxxgsngdsxamsfq6y7dze3wzegxcqwmsb5yrxen73x6@u3vilqhpci4w>
X-Patchwork-Hint: comment

On Mon, Feb 12, 2024 at 05:53:48PM +0100, Maxime Ripard wrote:
> On Mon, Feb 12, 2024 at 05:49:33PM +0200, Ville Syrjälä wrote:
> > On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> > > On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> > > > On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > > > > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrjälä wrote:
> > > > > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > > > > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > > > > > >  /**
> > > > > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > > > > >   *
> > > > > > > > > > > > + * Broadcast RGB
> > > > > > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > > > > > > + *
> > > > > > > > > > > > + *      The value of this property can be one of the following:
> > > > > > > > > > > > + *
> > > > > > > > > > > > + *      Automatic:
> > > > > > > > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > > > > + *
> > > > > > > > > > > > + *      Full:
> > > > > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > > > > + *
> > > > > > > > > > > > + *      Limited 16:235:
> > > > > > > > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > > > > > > > + *              this works for any number of bits-per-component.
> > > > > > > > > > > > + *
> > > > > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > > > > > + *
> > > > > > > > > > > 
> > > > > > > > > > > This is a good time to document this in more detail. There might be two
> > > > > > > > > > > different things being affected:
> > > > > > > > > > > 
> > > > > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > > > > 2. The color pipeline processing
> > > > > > > > > > > 
> > > > > > > > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > > > > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > > > > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > > > > > > > 
> > > > > > > > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > > > > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > > > > > 
> > > > > > > > > > > When full or limited is selected and the monitor doesn't support the
> > > > > > > > > > > signalling, what happens?
> > > > > > > > > > 
> > > > > > > > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > > > > > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > > > > > > > YCbCr?
> > > > > > > > > 
> > > > > > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > > > > > > > we're using a YCbCr format, i915 will always use a limited range while
> > > > > > > > > vc4 will follow the value of the property.
> > > > > > > > 
> > > > > > > > The property is literally called "Broadcast *RGB*".
> > > > > > > > That should explain why it's only affecting RGB.
> > > > > > > 
> > > > > > > Right. And the limited range option is called "Limited 16:235" despite
> > > > > > > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > > > > > > to make names inconsistent too, that's fine and not an argument in
> > > > > > > itself.
> > > > > > > 
> > > > > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > > > > to enable it.
> > > > > > > 
> > > > > > > vc4 supports it.
> > > > > > 
> > > > > > Someone implemented it incorrectly then.
> > > > > 
> > > > > Incorrectly according to what documentation / specification? I'm sorry,
> > > > > but I find it super ironic that i915 gets to do its own thing, not
> > > > > document any of it, and when people try to clean things up they get told
> > > > > that we got it all wrong.
> > > > 
> > > > FWIW, this was an i915 property and if another driver uses the same
> > > > property name it must have the same behavior. Yes, it isn't standardized
> > > > and yes, it's not documented (hence this effort here) but it's still on
> > > > vc4 to make the property compatible.
> > > 
> > > How is it not compatible? It's a superset of what i915 provides, but
> > > it's strictly compatible with it.
> > 
> > No it is not.
> 
> The property is compatible with i915 interpretation of it, whether you
> like it or not. And that's what Sebastian was referring to.
> 
> > Eg. what happens if you set the thing to full range for RGB (which you
> > must on many broken monitors), and then the kernel automagically
> > switches to YCbCr (for whatever reason) but the monitor doesn't
> > support full range YCbCr? Answer: you get crap output.
> 
> And that part is just moving goalposts.

No. Allowing users to get correct colors with broken displays
is the sole reason why this property even exists.

-- 
Ville Syrjälä
Intel

