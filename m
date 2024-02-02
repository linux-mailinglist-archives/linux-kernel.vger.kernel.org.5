Return-Path: <linux-kernel+bounces-50149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E08474F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36401C26C34
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA259148FEB;
	Fri,  2 Feb 2024 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ivRJUm1s"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E73B1474BD;
	Fri,  2 Feb 2024 16:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706891716; cv=none; b=intWkq4yAcDScWWcX5vBBep/OJgVxV+yZuh6Ro6HoSdWGiBhQeicNrz0oCLJbpORctMYlIRnlIKE1ZSVFyJ4YsiLeTBB0f+qeW5FJgkHq523vZP469ERZULBudqZVWXX8y5bpJN8eBxuy2u6VJ+bOHoH+h1FOZ3qEVDQgg3Vjvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706891716; c=relaxed/simple;
	bh=1lLd48O5ySvz7PNZFF6ltqKVz+fi3YrSX8Kst1Luccw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hL++vFH28dS46QXf8GHE/2yQl/6Ag4w/+SvW3kU4EC2OL+n2j8BRsZKIbQe2jLDf39pq8A4UBkOwuGUdkgE7ahsRQqkV6ejX9e4gRn+loe6czw/LoEPhirQPfKipv3BPLxWW6XOcrZ2LRNEdfQa1gi+hOpgb15ABSub+Lwfg0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ivRJUm1s; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706891715; x=1738427715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1lLd48O5ySvz7PNZFF6ltqKVz+fi3YrSX8Kst1Luccw=;
  b=ivRJUm1sVTVzYilHwwtUQlpnCtQx5B6h0JIMuvuK+X+B3qKdu1nTle4B
   9oF8RfB2g4Q1wH6hwG0kMvtoCxx2qhvCXkGiVySFVIrgjMrNy9T4aNnDu
   8wJMFKQ/O90LsJSIBpp6Aa/48goxFZbtyTDNDj5/Gd7e8D5b+Te6f2bzW
   SKubOlplqe6xf1yH1pNrKehwTdLVbCvngmlyMWgHqIyh580ytDzRfLjkf
   gFFN4b0GCWtD18eq+IuMXPKFfvPld+XOV4ICmDwNiGvB94/rI50QPBaCt
   FhgXT4lStAmmAlPusJQKOfNObILY5Ssqwju0f4aWnAkMQhh7TqgWDylLv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="354667"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="354667"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 08:35:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="823251099"
X-IronPort-AV: E=Sophos;i="6.05,238,1701158400"; 
   d="scan'208";a="823251099"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 02 Feb 2024 08:35:07 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 02 Feb 2024 18:35:06 +0200
Date: Fri, 2 Feb 2024 18:35:06 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Hans Verkuil <hverkuil@xs4all.nl>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
	Sebastian Wick <sebastian.wick@redhat.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Emma Anholt <emma@anholt.net>, Jonathan Corbet <corbet@lwn.net>,
	linux-kernel@vger.kernel.org, Samuel Holland <samuel@sholland.org>,
	Sandy Huang <hjc@rock-chips.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	linux-doc@vger.kernel.org, linux-rockchip@lists.infradead.org,
	Chen-Yu Tsai <wens@csie.org>, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, David Airlie <airlied@gmail.com>,
	linux-sunxi@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 08/44] drm/connector: hdmi: Add Broadcast RGB property
Message-ID: <Zb0ZujO9E_WH8Pm3@intel.com>
References: <20231207-kms-hdmi-connector-state-v5-0-6538e19d634d@kernel.org>
 <20231207-kms-hdmi-connector-state-v5-8-6538e19d634d@kernel.org>
 <20240115143308.GA159345@toolbox>
 <874jerf7ot.fsf@intel.com>
 <c37e9225-3890-4f4d-b45c-919b907b184b@xs4all.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c37e9225-3890-4f4d-b45c-919b907b184b@xs4all.nl>
X-Patchwork-Hint: comment

On Fri, Feb 02, 2024 at 12:20:21PM +0100, Hans Verkuil wrote:
> On 02/02/2024 12:04, Jani Nikula wrote:
> > On Mon, 15 Jan 2024, Sebastian Wick <sebastian.wick@redhat.com> wrote:
> >> On Thu, Dec 07, 2023 at 04:49:31PM +0100, Maxime Ripard wrote:
> >>> The i915 driver has a property to force the RGB range of an HDMI output.
> >>> The vc4 driver then implemented the same property with the same
> >>> semantics. KWin has support for it, and a PR for mutter is also there to
> >>> support it.
> >>>
> >>> Both drivers implementing the same property with the same semantics,
> >>> plus the userspace having support for it, is proof enough that it's
> >>> pretty much a de-facto standard now and we can provide helpers for it.
> >>>
> >>> Let's plumb it into the newly created HDMI connector.
> >>>
> >>> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > 
> > [snip]
> > 
> >>> @@ -1655,6 +1678,26 @@ EXPORT_SYMBOL(drm_connector_attach_dp_subconnector_property);
> >>>  /**
> >>>   * DOC: HDMI connector properties
> >>>   *
> >>> + * Broadcast RGB
> >>> + *      Indicates the RGB Quantization Range (Full vs Limited) used.
> >>> + *      Infoframes will be generated according to that value.
> >>> + *
> >>> + *      The value of this property can be one of the following:
> >>> + *
> >>> + *      Automatic:
> >>> + *              RGB Range is selected automatically based on the mode
> >>> + *              according to the HDMI specifications.
> >>> + *
> >>> + *      Full:
> >>> + *              Full RGB Range is forced.
> >>> + *
> >>> + *      Limited 16:235:
> >>> + *              Limited RGB Range is forced. Unlike the name suggests,
> >>> + *              this works for any number of bits-per-component.
> >>> + *
> >>> + *      Drivers can set up this property by calling
> >>> + *      drm_connector_attach_broadcast_rgb_property().
> >>> + *
> >>
> >> This is a good time to document this in more detail. There might be two
> >> different things being affected:
> >>
> >> 1. The signalling (InfoFrame/SDP/...)
> >> 2. The color pipeline processing
> >>
> >> All values of Broadcast RGB always affect the color pipeline processing
> >> such that a full-range input to the CRTC is converted to either full- or
> >> limited-range, depending on what the monitor is supposed to accept.
> >>
> >> When automatic is selected, does that mean that there is no signalling,
> >> or that the signalling matches what the monitor is supposed to accept
> >> according to the spec? Also, is this really HDMI specific?
> > 
> > Automatic is based on the mode as described in the specs
> > below. Basically certain modes are expected to be broadcast range, and
> > others full range.
> > 
> > I don't remember why we don't use the full range if the display
> > indicates it supports selectable quantization range in Video
> > Capabilities Data Block. It's quite possible there are displays that
> > declare support but don't. Cc: Ville.
> 
> I have not seen such displays. Enabling RGB Selectable Quantization Range
> is something that a vendor has to do explicitly, so it is reasonable to
> expect that it works, otherwise there would be no point to that flag!
> 
> Transmitting full range if possible gives a better picture quality and
> so is recommended.
> 
> > 
> > - HDMI 1.4b section 6.6 Video Quantization Ranges
> > 
> > - HDMI 2.1 section 7.3 Video Quantization Ranges
> > 
> > - DP 2.1 (and earlier) section 5.1.1.1 Video Colorimetry
> > 
> > - CTA-861-H (and earlier) section 5.1 Default Encoding Parameters and
> >   section 6.4.3 Quantization Range
> 
> Note that CTA-861-H deprecated the use of Default Range in the AVI
> InfoFrame, instead the source should always signal limited or full range
> in the Q field.

Only because the QS=1 is now mandatory IIRC.
We do always set Q bit explicitly when QS==1.

But yeah, I guess we could always go for full range
by default when QS==1. Or maybe we even did that at
some point in the past and it broke some things?
Can't recall anymore.

Anyways, QS=1 being mandatory is a clear improvement
in CTA-861, but some other CTA-861 rule updates are
more or less pointless as you can't in general detect
which version of the spec the sink claims to implement.

Eg. we already had cases where following the new CTA-861-F
rules for the YQ bit when transmitting RGB broke some
displays. And we are now forced to use the presence of
HDMI 2.0+ capabilities as a heuristic to detect CTA-851-F+.
(see drm_hdmi_avi_infoframe_quant_range()). It's pretty
nasty.

And I think there is some other infoframe related issue
(something to do with VICs IIRC) where we'd need to derive
the CTA-861 version eg. from the set of advertised VICs
in the EDID. I might have even written some code for that
at some point but never finished it. So it's still
broken in the current code. Can't recall the specific
details right now unfortunately.

-- 
Ville Syrjälä
Intel

