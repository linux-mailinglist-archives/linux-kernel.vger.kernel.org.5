Return-Path: <linux-kernel+bounces-106172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2561387EA33
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9296C1F22D6B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6D64879B;
	Mon, 18 Mar 2024 13:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="My2kqKgz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F24249EB;
	Mon, 18 Mar 2024 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710769035; cv=none; b=U0oK0LOk6CsnVgA0gcpRzxQyRB5Bt8BpCHyY7lohzGYKPTZSSfKcjzgn/5JYO2HFr1PcloV/TmRgN5B1P5aHq8qxlV7W5vYjcY7Hi/Qz5rYTj6AWh4kUOUKHK6X7nV6VWOA09AJxsEiZP/3F3YW4WYZG9F8x+bJUgrUK/XWlfj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710769035; c=relaxed/simple;
	bh=u82l/MBNpObPyrd/rtRsi0HOp2zPMN16KTaVMbMuxec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IidW6vmMreQBLmlS2H7cLrzNPbUB/bOETcu9xQ5Y+VDFU5FBsljsJ+3Ch1O0oCqEUOJMeNp+Vx6KqsLfawjGzCZlAq/WpxnwCYc+0Uq9LiMQ5o7iHeg7sZNMu94jBx8oB2UPnSKiWiT+YUGCr5SipiaXNMTwyc0nV9bkTChACKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=My2kqKgz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710769033; x=1742305033;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=u82l/MBNpObPyrd/rtRsi0HOp2zPMN16KTaVMbMuxec=;
  b=My2kqKgzCby75PAglA0ekpm/4P/BvPQa+JWj8bg0RY2SrMo1JhEtgwf6
   edj2rLD82aDKLfXvURsIVX82mfYSorzHvgnuy6aiQE30+1vD6dINk+KX/
   +7odyFkjYWggJwFAunpKJPii96roj8DAvnqyrpSgPYeQc2yDCpCiD/SR7
   4IWKA+WhizlGr4uiFRDVVOJirE+VR3gOz2Ah7brafR+BAfsZWWyy82a3w
   ImwbohvLcoPHnxdsXABayGgAlT8ZjbiwdOzqkmXlEiSprH0oRFtOlkKmp
   GO0o0woBJ9xSN5bKUtXJkfZgOObQ1L5YHwc04jB2siRoGsPfiensOzLXv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5765138"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5765138"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="827781787"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="827781787"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 18 Mar 2024 06:37:05 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 18 Mar 2024 15:37:05 +0200
Date: Mon, 18 Mar 2024 15:37:05 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
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
	Sebastian Wick <sebastian.wick@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v9 14/27] drm/connector: hdmi: Compute bpc and format
 automatically
Message-ID: <ZfhDgRcC6sdGmcmH@intel.com>
References: <20240311-kms-hdmi-connector-state-v9-0-d45890323344@kernel.org>
 <20240311-kms-hdmi-connector-state-v9-14-d45890323344@kernel.org>
 <ZfQBPHoAvI1dquEY@intel.com>
 <20240318-organic-debonair-beetle-b2817b@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318-organic-debonair-beetle-b2817b@houat>
X-Patchwork-Hint: comment

On Mon, Mar 18, 2024 at 01:05:22PM +0100, Maxime Ripard wrote:
> Hi Ville,
> 
> Thanks for your review !
> 
> On Fri, Mar 15, 2024 at 10:05:16AM +0200, Ville Syrjälä wrote:
> > On Mon, Mar 11, 2024 at 03:49:42PM +0100, Maxime Ripard wrote:
> > > +static bool
> > > +sink_supports_format_bpc(const struct drm_connector *connector,
> > > +			 const struct drm_display_info *info,
> > > +			 const struct drm_display_mode *mode,
> > > +			 unsigned int format, unsigned int bpc)
> > > +{
> > > +	struct drm_device *dev = connector->dev;
> > > +	u8 vic = drm_match_cea_mode(mode);
> > > +
> > > +	if (vic == 1 && bpc != 8) {
> > > +		drm_dbg(dev, "VIC1 requires a bpc of 8, got %u\n", bpc);
> > 
> > Use of drm_dbg() for kms stuff is surprising.
> > 
> > > +		return false;
> > > +	}
> > 
> > I don't think we have this in i915. My original impression was that you
> > can use higher color depth if you can determine the sink capabilities,
> > but all sinks are required to accept 640x480@8bpc as a fallback.
> > 
> > but CTA-861-H says:
> > "5.4 Color Coding & Quantization
> >  Component Depth: The coding shall be N-bit, where N = 8, 10, 12, or 16
> >  bits/component — except in the case of the default 640x480 Video Timing 1,
> >  where the value of N shall be 8."
> > 
> > So that does seem to imply that you're supposed to use exactly 8bpc.
> > Though the word "default" in there is confusing. Are they specifically
> > using that to indicate that this is about the fallback behaviour, or
> > is it just indicating that it is a "default mode that always has to
> > be supported". Dunno. I guess no real harm in forcing 8bpc for 640x480
> > since no one is likely to use that for any high fidelity stuff.
> 
> My understanding was that CTA-861 mandates that 640x480@60Hz is
> supported, and mentions it being the default timing on a few occurences,
> like in section 4 - Video Formats and Waveform Timings that states "This
> section describes the default IT 640x480 Video Timing as well as all of
> the standard CE Video Timings.", or Section 6.2 - Describing Video
> Formats in EDID "The 640x480@60Hz flag, in the Established Timings area,
> shall always be set, since the 640x480p format is a mandatory default
> timing."
> 
> So my understanding is that default here applies to the timing itself,
> and not the bpc, and is thus the second interpretation you suggested.
> 
> I'll add a comment to make it clearer.
> 
> > > +static int
> > > +hdmi_compute_format(const struct drm_connector *connector,
> > > +		    struct drm_connector_state *state,
> > > +		    const struct drm_display_mode *mode,
> > > +		    unsigned int bpc)
> > > +{
> > > +	struct drm_device *dev = connector->dev;
> > > +
> > > +	if (hdmi_try_format_bpc(connector, state, mode, bpc, HDMI_COLORSPACE_RGB)) {
> > > +		state->hdmi.output_format = HDMI_COLORSPACE_RGB;
> > > +		return 0;
> > > +	}
> > > +
> > > +	if (hdmi_try_format_bpc(connector, state, mode, bpc, HDMI_COLORSPACE_YUV422)) {
> > > +		state->hdmi.output_format = HDMI_COLORSPACE_YUV422;
> > > +		return 0;
> > > +	}
> > 
> > Looks like you're preferring YCbCr 4:2:2 over RGB 8bpc. Not sure
> > if that's a good tradeoff to make.
> 
> Yeah, indeed. I guess it's a judgement call on whether we prioritise
> lowering the bpc over selecting YUV422, but I guess I can try all
> available RGB bpc before falling back to YUV422.
> 
> > In i915 we don't currently expose 4:2:2 at all because it doesn't
> > help in getting a working display, and we have no uapi for the
> > user to force it if they really want 4:2:2 over RGB.
> 
> I guess if the priority is given to lowering bpc, then it indeed doesn't
> make sense to support YUV422, since the limiting factor is likely to be
> the TMDS char rate and YUV422 12 bpc is equivalent to RGB 8bpc there.
> 
> dw-hdmi on the other hand will always put YUV422 and YUV444 before RGB
> for a given bpc, which is weird to me:
> https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2696
> 
> What is even weirder to me is that YUV422 is explicitly stated to be
> 12bpc only, so there's some invalid configurations there (8 and 10 bpc).
> 
> And given that it's order by decreasing order of preference, I'm pretty
> sure it'll never actually pick any YUV or RGB > 8bpc format since RGB
> 8bpc is super likely to be always available and thus picked first.

8bpc RGB is in fact mandatory.

> 
> If we want to converge, I think we should amend this code to support
> YUV420 for YUV420-only modes first, and then the RGB options like i915
> is doing. And then if someone is interested in more, we can always
> expand it to other formats.
> 
> > > +
> > > +	drm_dbg(dev, "Failed. No Format Supported for that bpc count.\n");
> > > +
> > > +	return -EINVAL;
> > > +}
> > > +
> > > +static int
> > > +hdmi_compute_config(const struct drm_connector *connector,
> > > +		    struct drm_connector_state *state,
> > > +		    const struct drm_display_mode *mode)
> > > +{
> > > +	struct drm_device *dev = connector->dev;
> > > +	unsigned int max_bpc = clamp_t(unsigned int,
> > > +				       state->max_bpc,
> > > +				       8, connector->max_bpc);
> > > +	unsigned int bpc;
> > > +	int ret;
> > > +
> > > +	for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
> > > +		drm_dbg(dev, "Trying with a %d bpc output\n", bpc);
> > > +
> > > +		ret = hdmi_compute_format(connector, state, mode, bpc);
> > 
> > Hmm. Actually I'm not sure your 4:2:2 stuff even works since you 
> > check for bpc==12 in there and only call this based on the max_bpc.
> > I'm not convinced max_bpc would actually be 12 for a sink that
> > supports YCbCr 4:2:2 but not 12bpc RGB.
> 
> It's another discussion we had in an earlier version, but yeah we lack
> the infrastructure to support those for now. I still believe it would
> require an increased max_bpc to select YUV422, otherwise things would be
> pretty inconsistent with other YUV formats.

Ideally I'd like to know the actual color depth of the panel
independently of the supported signal color depths. Unfortunately
I don't think EDID gives us that. Can't recall if DisplayID might
have something a bit more sensible.

Given how info->bpc works right now, I suppose it would make sense
to bump it up to 12 when 4:2:2 is supported. But I've not thought
through the actual implications such a change.

> But yeah, we need to provide a hook to report we don't support RGB >
> 8bpc for HDMI 1.4 devices. Which goes back to the previous question
> actually, I believe it would still provide value to support YUV422 on
> those devices, with something like:
> 
> for (bpc = max_bpc; bpc >= 8; bpc -= 2) {
>     if (!connector->hdmi->funcs->validate_config(mode, RGB, bpc))
>        continue;
> 
>     // Select RGB with bpc
>     ...
> }
> 
> if (connector->hdmi->funcs->validate_config(mode, YUV) &&
>     hdmi_try_format_bpc(..., mode, 12, YUV422) {
>    // Select YUV422, 12 bpc
>    ...
> }
> 
> What do you think?

Since 8bpc RGB must always be supported this looks
like dead code to me.

-- 
Ville Syrjälä
Intel

