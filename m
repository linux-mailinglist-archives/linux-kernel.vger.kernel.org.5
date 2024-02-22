Return-Path: <linux-kernel+bounces-76552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD585F90C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD0FE1F24DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA7E12DD82;
	Thu, 22 Feb 2024 12:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a/rciQcN"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EE0605DE;
	Thu, 22 Feb 2024 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606736; cv=none; b=UEWTAAg8nZJcw/jOlnYeIJxYxlE6ok17wPNZ4VQTnLey3Hd3BKlI22uR2Ei8VSN66VbDMZEVAJbwQEsSFoy+pwAheKFV/bJZMqc+LoCiAUy0yq51gez+RRDeqCBXFOZbHrRf7U7JRtc+HmGsu1al5aLk3tdh2qsylcfZVtKolt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606736; c=relaxed/simple;
	bh=JLuc1Jnxsxw+U4ER0Rl4lWt2pmSMVhIz7T8Bf6moZAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwBDz3w8wppotHghVlQuHBEnucnslZhJPWKTUNctEnCTs55kTrdg/Udvd9FdDfMmkHqmXg5sunX1BruBN0MQ49dwM8MYz5T2ugw4zaHYDl+9zH/Pb71GO+G7tAojplUyeVTjKVERgP4ybV613fA+nvjgXWwhLf/CTGYu9c2KY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a/rciQcN; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708606735; x=1740142735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JLuc1Jnxsxw+U4ER0Rl4lWt2pmSMVhIz7T8Bf6moZAM=;
  b=a/rciQcNohokVTzgs5/g2ndxs3RWC/KNr+06lHIbCC4MMezS8ffs0r9l
   M3asGeH8PKziCOXhaqCh8i5r4nw0kNbHjB/lqzgyjGgKmTBhAT5Owozi+
   t37/1UBCPNCDw75c+u2AeRqu3QNvxa92LoBypvq++phWVkKqMWNz0K1tt
   q5C4VCvd2Gb3VCYnsLJdpvuIMkNMsr3jxMn7iCZJRB2EKY5PfXfXsPRbu
   GD/I3UMzIPi6W0w84YV91R0sWNSlEK/yXMiXJZGCJes2jHCGR330jtmWY
   G7m+o8URZ4HNRz4LMLiTjhIxzpfYmhc8C4WvaH0jVhlGx5pkbY/yFtYn/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13449825"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13449825"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:58:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="827546623"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="827546623"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 22 Feb 2024 04:58:46 -0800
Received: by stinkbox (sSMTP sendmail emulation); Thu, 22 Feb 2024 14:58:45 +0200
Date: Thu, 22 Feb 2024 14:58:45 +0200
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
Subject: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <ZddFBe4A-galsO91@intel.com>
References: <Zb0aYAapkxQ2kopt@intel.com>
 <zml6j27skvjmbrfyz7agy5waxajv4p4asbemeexelm3wuv4o7j@xkd2wvnxhbuc>
 <20240209203435.GB996172@toolbox>
 <ahfl6f72lpgpsbnrbgvbsh4db4npr2hh36kua2c6krh544hv5r@dndw4hz2mu2g>
 <Zco-DQaXqae7B1jt@intel.com>
 <yx2t7xltxxgsngdsxamsfq6y7dze3wzegxcqwmsb5yrxen73x6@u3vilqhpci4w>
 <20240212170618.GA1372043@toolbox>
 <2mih3humepuedtli7ge52ncom4uffkqravdpalncgfyucmwdzc@bp5o7i3ky77a>
 <20240219140144.GB1956149@toolbox>
 <euaujtp4jyyoud3ccg5qhyvixyq2p6vir4ojlzoky6kep754rj@wruidyfxssry>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <euaujtp4jyyoud3ccg5qhyvixyq2p6vir4ojlzoky6kep754rj@wruidyfxssry>
X-Patchwork-Hint: comment

On Thu, Feb 22, 2024 at 11:54:04AM +0100, Maxime Ripard wrote:
> On Mon, Feb 19, 2024 at 03:01:44PM +0100, Sebastian Wick wrote:
> > On Thu, Feb 15, 2024 at 12:00:01PM +0100, Maxime Ripard wrote:
> > > On Mon, Feb 12, 2024 at 06:06:18PM +0100, Sebastian Wick wrote:
> > > > On Mon, Feb 12, 2024 at 05:53:48PM +0100, Maxime Ripard wrote:
> > > > > On Mon, Feb 12, 2024 at 05:49:33PM +0200, Ville Syrjälä wrote:
> > > > > > On Mon, Feb 12, 2024 at 11:01:07AM +0100, Maxime Ripard wrote:
> > > > > > > On Fri, Feb 09, 2024 at 09:34:35PM +0100, Sebastian Wick wrote:
> > > > > > > > On Mon, Feb 05, 2024 at 10:39:38AM +0100, Maxime Ripard wrote:
> > > > > > > > > On Fri, Feb 02, 2024 at 06:37:52PM +0200, Ville Syrjälä wrote:
> > > > > > > > > > On Fri, Feb 02, 2024 at 04:59:30PM +0100, Maxime Ripard wrote:
> > > > > > > > > > > On Fri, Feb 02, 2024 at 05:40:47PM +0200, Ville Syrjälä wrote:
> > > > > > > > > > > > On Fri, Feb 02, 2024 at 02:01:39PM +0100, Maxime Ripard wrote:
> > > > > > > > > > > > > Hi,
> > > > > > > > > > > > > 
> > > > > > > > > > > > > On Mon, Jan 15, 2024 at 03:37:20PM +0100, Sebastian Wick wrote:
> > > > > > > > > > > > > > > >  /**
> > > > > > > > > > > > > > > >   * DOC: HDMI connector properties
> > > > > > > > > > > > > > > >   *
> > > > > > > > > > > > > > > > + * Broadcast RGB
> > > > > > > > > > > > > > > > + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> > > > > > > > > > > > > > > > + *      Infoframes will be generated according to that value.
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > + *      The value of this property can be one of the following:
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > + *      Automatic:
> > > > > > > > > > > > > > > > + *              RGB Range is selected automatically based on the mode
> > > > > > > > > > > > > > > > + *              according to the HDMI specifications.
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > + *      Full:
> > > > > > > > > > > > > > > > + *              Full RGB Range is forced.
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > + *      Limited 16:235:
> > > > > > > > > > > > > > > > + *              Limited RGB Range is forced. Unlike the name suggests,
> > > > > > > > > > > > > > > > + *              this works for any number of bits-per-component.
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > > + *      Drivers can set up this property by calling
> > > > > > > > > > > > > > > > + *      drm_connector_attach_broadcast_rgb_property().
> > > > > > > > > > > > > > > > + *
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > This is a good time to document this in more detail. There might be two
> > > > > > > > > > > > > > > different things being affected:
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > 1. The signalling (InfoFrame/SDP/...)
> > > > > > > > > > > > > > > 2. The color pipeline processing
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > All values of Broadcast RGB always affect the color pipeline processing
> > > > > > > > > > > > > > > such that a full-range input to the CRTC is converted to either full- or
> > > > > > > > > > > > > > > limited-range, depending on what the monitor is supposed to accept.
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > When automatic is selected, does that mean that there is no signalling,
> > > > > > > > > > > > > > > or that the signalling matches what the monitor is supposed to accept
> > > > > > > > > > > > > > > according to the spec? Also, is this really HDMI specific?
> > > > > > > > > > > > > > > 
> > > > > > > > > > > > > > > When full or limited is selected and the monitor doesn't support the
> > > > > > > > > > > > > > > signalling, what happens?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > > Forgot to mention: user-space still has no control over RGB vs YCbCr on
> > > > > > > > > > > > > > the cable, so is this only affecting RGB? If not, how does it affect
> > > > > > > > > > > > > > YCbCr?
> > > > > > > > > > > > > 
> > > > > > > > > > > > > So I dug a bit into both the i915 and vc4 drivers, and it looks like if
> > > > > > > > > > > > > we're using a YCbCr format, i915 will always use a limited range while
> > > > > > > > > > > > > vc4 will follow the value of the property.
> > > > > > > > > > > > 
> > > > > > > > > > > > The property is literally called "Broadcast *RGB*".
> > > > > > > > > > > > That should explain why it's only affecting RGB.
> > > > > > > > > > > 
> > > > > > > > > > > Right. And the limited range option is called "Limited 16:235" despite
> > > > > > > > > > > being usable on bpc > 8 bits. Naming errors occurs, and history happens
> > > > > > > > > > > to make names inconsistent too, that's fine and not an argument in
> > > > > > > > > > > itself.
> > > > > > > > > > > 
> > > > > > > > > > > > Full range YCbCr is a much rarer beast so we've never bothered
> > > > > > > > > > > > to enable it.
> > > > > > > > > > > 
> > > > > > > > > > > vc4 supports it.
> > > > > > > > > > 
> > > > > > > > > > Someone implemented it incorrectly then.
> > > > > > > > > 
> > > > > > > > > Incorrectly according to what documentation / specification? I'm sorry,
> > > > > > > > > but I find it super ironic that i915 gets to do its own thing, not
> > > > > > > > > document any of it, and when people try to clean things up they get told
> > > > > > > > > that we got it all wrong.
> > > > > > > > 
> > > > > > > > FWIW, this was an i915 property and if another driver uses the same
> > > > > > > > property name it must have the same behavior. Yes, it isn't standardized
> > > > > > > > and yes, it's not documented (hence this effort here) but it's still on
> > > > > > > > vc4 to make the property compatible.
> > > > > > > 
> > > > > > > How is it not compatible? It's a superset of what i915 provides, but
> > > > > > > it's strictly compatible with it.
> > > > > > 
> > > > > > No it is not.
> > > > > 
> > > > > The property is compatible with i915 interpretation of it, whether you
> > > > > like it or not. And that's what Sebastian was referring to.
> > > > > 
> > > > > > Eg. what happens if you set the thing to full range for RGB (which you
> > > > > > must on many broken monitors), and then the kernel automagically
> > > > > > switches to YCbCr (for whatever reason) but the monitor doesn't
> > > > > > support full range YCbCr? Answer: you get crap output.
> > > > > 
> > > > > And that part is just moving goalposts.
> > > > 
> > > > But it's really not.
> > > 
> > > It really is. This whole discussion started by "well it would be nice if
> > > we made that property handled by the core", and we're now at the "we
> > > need to deal with broken YCbCr displays and i915 opinion about them"
> > > stage. After creating documentation, unit tests, etc. It's the textbook
> > > definition of moving goalposts. And while i915 won't be affected by all
> > > that work.
> > 
> > Sorry, but what you're saying is just not true.
> > 
> > The Broadcast RGB property is an Intel specific property.
> 
> No, it's not. vc4 has been using it for a year now.
> 
> > It lacked documentation but the user space contract exists and it
> > based on how i915 implemented it. By changing the semantics you're
> > breaking user space. The documentation has to document the current
> > contract between i915 and user space, not whatever you want the
> > property to be like.
> > 
> > I get that you're frustrated that you have to do work while i915 doesn't
> > but none of that is relevant for what the property is and how user space
> > expects it to work.
> 
> That's not it, really. I don't mind doing the work. I do mind losing
> functionalities on something that was working fine. And getting the
> blame for something that is, at best, just as much of an documentation
> issue on i915 devs.

We've had a couple of these cases recently where people have taken
some old property implemented by i915 and implemented it differently
in some other driver. Dunno if the reason was that people didn't try
to understand what i915 is doing and why, or they misundestood it,
or they understood it but decided to ignore it anyway.

Unfortunately having undocumented corners in the uapi is simply
a fact of life when dealing with a >15 year old legacy codebase.
Also there were basically no rules regarding properties in the
past, so everyone just added random properties whenever they 
felt like it.

I think going forward we should probably lay down some extra
ground rules; if an old undocumented uapi is being extended
to cover more than one driver we must first figure out what
the de facto semantics are, and document things properly
before anything else gets done.

-- 
Ville Syrjälä
Intel

