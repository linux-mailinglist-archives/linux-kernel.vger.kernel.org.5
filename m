Return-Path: <linux-kernel+bounces-117080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEDA88A6C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035681F6240C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F64129E95;
	Mon, 25 Mar 2024 13:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gD+0sPYU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3A445023;
	Mon, 25 Mar 2024 13:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371735; cv=none; b=gz028qzm+Y1xqdv3udQFgkb7gM/4rT4nu+6bnSP58fPnVP5CwyBrt8xCJMH7E1qa7m6VWx0EBQN9E4bANpBQEhQifUxzbwGiEz6iz98RFb4P6ih53Xi6tjUWgn+RMiDUzX2BPI21joXpQulcbK5Y9SUvyuG64J1bRDEOsnMT20k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371735; c=relaxed/simple;
	bh=j9Ny9HDnJILYPm2d9hjYKfvirSHTkmO7Ebt7GQ5GDrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A7xXf1h0ZDUGptQGwmexuCHWjZs5FkCkTpbf+4PdpyjB+uPtB7OhXIImV9HnCWqnQvViZWYnKczeDEOTwjb6LoWPdH+/xMy4uvwoNb03fkXYmzvp+YN0T7EnGebl6MXMbTBEcVFNXfcv+MJch8+i5vNtfPJNaK4cCEfbU6eFqdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gD+0sPYU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711371734; x=1742907734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j9Ny9HDnJILYPm2d9hjYKfvirSHTkmO7Ebt7GQ5GDrA=;
  b=gD+0sPYULLWtUioObL/oobFJSjQ09w5Cz1DKFjO15XorEQyQ9KAF4o3r
   PHquSnEePSbxafKJNk7DzPPMDM8bUJX62NxZJea+e/8F2P+Z/ixdBU5Wh
   vQAe5jehk8BLCbFcFVJg0KITymtVzhFLiC+aZ1I+Owuw1RNDVjKk+QAJq
   OXmMcY7soBBfIXTedqTXtj7+8V+tsZMkM13hy/2ULariEgadnhY9fsBBP
   ArGtjib7jy6iusBdN+fLajcaM7C9YV16rceRjFVmPiVkTq2diAPWqTwC+
   5nbMXCO4eXkK384hrfnr06DqGLvb7a84PnHLZV/eYz5yNpZbuuhxtGZPm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="28845931"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="28845931"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:02:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15662363"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:02:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 7993511FB81;
	Mon, 25 Mar 2024 15:02:08 +0200 (EET)
Date: Mon, 25 Mar 2024 13:02:08 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Message-ID: <ZgF10EVLrfF7cl57@kekkonen.localdomain>
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
 <20240325125055.GC23988@pendragon.ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325125055.GC23988@pendragon.ideasonboard.com>

Moi,

Thanks for the patch.

On Mon, Mar 25, 2024 at 02:50:55PM +0200, Laurent Pinchart wrote:
> Hi Tomi,
> 
> On Mon, Mar 25, 2024 at 02:43:23PM +0200, Tomi Valkeinen wrote:
> > Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> > use the v4l2_subdev_video_ops.s_stream op, instead of
> > v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> > enable/disable_streams machinery requires a routing table which a subdev
> > cannot have with a single pad.
> > 
> > Implement enable/disable_streams support for these single-pad subdevices
> > by assuming an implicit stream 0 when the subdevice has only one pad.
> > 
> > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > ---
> > Even though I did send this patch, I'm not sure if this is necessary.
> > s_stream works fine for the subdevs with a single pad. With the upcoming
> > internal pads, adding an internal pad to the subdev will create a
> > routing table, and enable/disable_streams would get "fixed" that way.

I'd like to get rid of a redundant way to control streaming.

> > 
> > So perhaps the question is, do we want to support single-pad subdevs in
> > the future, in which case something like this patch is necessary, or
> > will all modern source subdev drivers have internal pads, in which
> > case this is not needed...
> 
> I think the latter would be best. I however can't guarantee we won't
> have valid use cases for (enable|disable)_streams on single-pad subdevs
> though, so you patch could still be interesting.

Instead of the number of pads, could we use instead the
V4L2_SUBDEV_FL_STREAMS flag or whether g_routing op is supported to
determine the need for this?

> 
> > ---
> >  drivers/media/v4l2-core/v4l2-subdev.c | 105 ++++++++++++++++++++++------------
> >  include/media/v4l2-subdev.h           |   4 +-
> >  2 files changed, 72 insertions(+), 37 deletions(-)
> > 
> > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> > index 4c6198c48dd6..ddc7ed69421c 100644
> > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > @@ -2129,21 +2129,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
> >  	 * Verify that the requested streams exist and that they are not
> >  	 * already enabled.
> >  	 */
> > -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > -		struct v4l2_subdev_stream_config *cfg =
> > -			&state->stream_configs.configs[i];
> >  
> > -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> > -			continue;
> > -
> > -		found_streams |= BIT_ULL(cfg->stream);
> > -
> > -		if (cfg->enabled) {
> > +	if (sd->entity.num_pads == 1) {
> > +		if (sd->enabled_streams) {
> >  			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> > -				cfg->stream, sd->entity.name, pad);
> > +				0, sd->entity.name, pad);
> >  			ret = -EALREADY;
> >  			goto done;
> >  		}
> > +
> > +		found_streams = BIT_ULL(0);
> > +	} else {
> > +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > +			struct v4l2_subdev_stream_config *cfg =
> > +				&state->stream_configs.configs[i];
> > +
> > +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> > +				continue;
> > +
> > +			found_streams |= BIT_ULL(cfg->stream);
> > +
> > +			if (cfg->enabled) {
> > +				dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> > +					cfg->stream, sd->entity.name, pad);
> > +				ret = -EALREADY;
> > +				goto done;
> > +			}
> > +		}
> >  	}
> >  
> >  	if (found_streams != streams_mask) {
> > @@ -2164,13 +2176,17 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
> >  		goto done;
> >  	}
> >  
> > -	/* Mark the streams as enabled. */
> > -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > -		struct v4l2_subdev_stream_config *cfg =
> > -			&state->stream_configs.configs[i];
> > +	if (sd->entity.num_pads == 1) {
> > +		sd->enabled_streams |= streams_mask;
> > +	} else {
> > +		/* Mark the streams as enabled. */
> > +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > +			struct v4l2_subdev_stream_config *cfg =
> > +				&state->stream_configs.configs[i];
> >  
> > -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> > -			cfg->enabled = true;
> > +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> > +				cfg->enabled = true;
> > +		}
> >  	}
> >  
> >  done:
> > @@ -2246,21 +2262,32 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> >  	 * Verify that the requested streams exist and that they are not
> >  	 * already disabled.
> >  	 */
> > -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > -		struct v4l2_subdev_stream_config *cfg =
> > -			&state->stream_configs.configs[i];
> > -
> > -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> > -			continue;
> > -
> > -		found_streams |= BIT_ULL(cfg->stream);
> > -
> > -		if (!cfg->enabled) {
> > +	if (sd->entity.num_pads == 1) {
> > +		if (!sd->enabled_streams) {
> >  			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> > -				cfg->stream, sd->entity.name, pad);
> > +				0, sd->entity.name, pad);
> >  			ret = -EALREADY;
> >  			goto done;
> >  		}
> > +
> > +		found_streams = BIT_ULL(0);
> > +	} else {
> > +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > +			struct v4l2_subdev_stream_config *cfg =
> > +				&state->stream_configs.configs[i];
> > +
> > +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> > +				continue;
> > +
> > +			found_streams |= BIT_ULL(cfg->stream);
> > +
> > +			if (!cfg->enabled) {
> > +				dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> > +					cfg->stream, sd->entity.name, pad);
> > +				ret = -EALREADY;
> > +				goto done;
> > +			}
> > +		}
> >  	}
> >  
> >  	if (found_streams != streams_mask) {
> > @@ -2281,13 +2308,17 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> >  		goto done;
> >  	}
> >  
> > -	/* Mark the streams as disabled. */
> > -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > -		struct v4l2_subdev_stream_config *cfg =
> > -			&state->stream_configs.configs[i];
> > +	if (sd->entity.num_pads == 1) {
> > +		sd->enabled_streams &= ~streams_mask;
> > +	} else {
> > +		/* Mark the streams as disabled. */
> > +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> > +			struct v4l2_subdev_stream_config *cfg =
> > +				&state->stream_configs.configs[i];
> >  
> > -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> > -			cfg->enabled = false;
> > +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> > +				cfg->enabled = false;
> > +		}
> >  	}
> >  
> >  done:
> > @@ -2325,8 +2356,12 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
> >  	 */
> >  	state = v4l2_subdev_lock_and_get_active_state(sd);
> >  
> > -	for_each_active_route(&state->routing, route)
> > -		source_mask |= BIT_ULL(route->source_stream);
> > +	if (sd->entity.num_pads == 1) {
> > +		source_mask = BIT_ULL(0);
> > +	} else {
> > +		for_each_active_route(&state->routing, route)
> > +			source_mask |= BIT_ULL(route->source_stream);
> > +	}
> >  
> >  	v4l2_subdev_unlock_state(state);
> >  
> > diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> > index a9e6b8146279..39b230f7b3c8 100644
> > --- a/include/media/v4l2-subdev.h
> > +++ b/include/media/v4l2-subdev.h
> > @@ -1041,8 +1041,8 @@ struct v4l2_subdev_platform_data {
> >   *		  v4l2_subdev_init_finalize().
> >   * @enabled_streams: Bitmask of enabled streams used by
> >   *		     v4l2_subdev_enable_streams() and
> > - *		     v4l2_subdev_disable_streams() helper functions for fallback
> > - *		     cases.
> > + *		     v4l2_subdev_disable_streams() helper functions. This is
> > + *		     for fallback cases and for subdevs with single pads.
> >   *
> >   * Each instance of a subdev driver should create this struct, either
> >   * stand-alone or embedded in a larger struct.
> > 
> > ---
> > base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> > change-id: 20240325-single-pad-enable-streams-32a9a746ac5b
> 

-- 
Terveisin,

Sakari Ailus

