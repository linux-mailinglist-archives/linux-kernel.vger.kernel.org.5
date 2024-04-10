Return-Path: <linux-kernel+bounces-138311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF82289EFA5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AE7B22922
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7B0158D60;
	Wed, 10 Apr 2024 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aRcu97lE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF15C1553B7;
	Wed, 10 Apr 2024 10:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712743994; cv=none; b=qxr26Zic8HiEoE2o+vGyfSlwplNsYuMetR+mfQawlyOCcx3kiK47Ob0SFA1e/hnC6IrhfoO/7EutsZZpLJI/5lj2erZNUTCYkqePC/L5lcnkPGwLr9C8IT7qv+aFPKb8eRgh5Ka8IeHfy4cV7FnnPZbYcdmm+BhbNpKso84QysE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712743994; c=relaxed/simple;
	bh=Fm/vsQdK2f/ltSg8PL9DqXonhPLc+qGLPRsT23RtPAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CMekbeIIH+2TYMclVzzsbm0l2DQOyUauE1U2L+YKE8GLiCW4dKmbsi6T2AZT05uYiO0Nofg84+PyD/n4AJY7QRA/MY/BWxka3W5ew5HUnjb9PoRDktXic9EW6khc49sFlfx+QJ+JOkJjmlBMV5NBlCP6KBexdn5FI6Q4k9Cf3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aRcu97lE; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712743993; x=1744279993;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fm/vsQdK2f/ltSg8PL9DqXonhPLc+qGLPRsT23RtPAc=;
  b=aRcu97lEUE38PB0hpVMmwGSU8Qh7TP0AYMrv2LpbrFCs+BPmTJ13D696
   iWep+pKD8J6Z5V7AN+qYKA+QSsO0EarVxXSiaelU57VfhGb+a6+5dk81f
   7vlH0l8101brHGXYK4krEQL9Gt6W5kqZu+K10YA/KzpahGO/uZPbCWi9H
   AiLYs9nnsH/8SH/NdJ/lr9pr9d8Y3ntpd50uvb4z+yZLaj3tvKX0jeKNb
   2x3Xc8kbPkDJFqlXdJey1tS0UdFtGRXo5WSwhUkmqr1Q+tYT+qA/RWPwh
   KnrB+1wXyVlk40GbeIWru+FuTkbQ5fkUr6tpkXI2juqyuxJ/09foRJgXs
   g==;
X-CSE-ConnectionGUID: ywDcd/O0Qvu4T6bBQ3MhTg==
X-CSE-MsgGUID: DLMYrwDqRMyEqmnBVac1rg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="11889127"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="11889127"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:13:12 -0700
X-CSE-ConnectionGUID: HU9HBfqDTe+kCgZJrpMofg==
X-CSE-MsgGUID: gWJh9my8TFyL8oPHnXrjRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="25197692"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 03:13:11 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
	by kekkonen.fi.intel.com (Postfix) with SMTP id 3FDE311FC46;
	Wed, 10 Apr 2024 13:13:08 +0300 (EEST)
Date: Wed, 10 Apr 2024 10:13:08 +0000
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Message-ID: <ZhZmNC4hQv1leL-y@kekkonen.localdomain>
References: <20240405-enable-streams-impro-v2-0-22bca967665d@ideasonboard.com>
 <20240405-enable-streams-impro-v2-8-22bca967665d@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405-enable-streams-impro-v2-8-22bca967665d@ideasonboard.com>

Moi,

Thank you for working on this.

On Fri, Apr 05, 2024 at 12:14:26PM +0300, Tomi Valkeinen wrote:
> Add two internal helper functions, v4l2_subdev_collect_streams() and
> v4l2_subdev_set_streams_enabled(), which allows us to refactor
> v4l2_subdev_enable/disable_streams() functions.
> 
> This (I think) makes the code a bit easier to read, and lets us more
> easily add new functionality in the helper functions in the following
> patch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 111 +++++++++++++++++++---------------
>  1 file changed, 62 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 015f2fb423c9..6c3c9069f1e2 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2099,6 +2099,44 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
>  }
>  EXPORT_SYMBOL_GPL(v4l2_subdev_routing_validate);
>  
> +static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
> +					struct v4l2_subdev_state *state,
> +					u32 pad, u64 streams_mask,
> +					u64 *found_streams,
> +					u64 *enabled_streams)
> +{
> +	*found_streams = 0;
> +	*enabled_streams = 0;
> +
> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
> +		const struct v4l2_subdev_stream_config *cfg;
> +
> +		cfg = &state->stream_configs.configs[i];

You can do the assignment in declaration.

Same for streams_enabled() below.

> +
> +		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> +			continue;
> +
> +		*found_streams |= BIT_ULL(cfg->stream);
> +		if (cfg->enabled)
> +			*enabled_streams |= BIT_ULL(cfg->stream);
> +	}
> +}
> +
> +static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
> +					    struct v4l2_subdev_state *state,
> +					    u32 pad, u64 streams_mask,
> +					    bool enabled)
> +{
> +	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
> +		struct v4l2_subdev_stream_config *cfg;
> +
> +		cfg = &state->stream_configs.configs[i];
> +
> +		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +			cfg->enabled = enabled;
> +	}
> +}
> +
>  static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>  					       u64 streams_mask)
>  {
> @@ -2150,8 +2188,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
>  	struct v4l2_subdev_state *state;
>  	bool already_streaming;
> -	u64 found_streams = 0;
> -	unsigned int i;
> +	u64 enabled_streams;
> +	u64 found_streams;
>  	int ret;
>  
>  	/* A few basic sanity checks first. */
> @@ -2172,22 +2210,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	 * Verify that the requested streams exist and that they are not
>  	 * already enabled.
>  	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
>  
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
> -
> -		found_streams |= BIT_ULL(cfg->stream);
> -
> -		if (cfg->enabled) {
> -			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> -			ret = -EALREADY;
> -			goto done;
> -		}
> -	}
> +	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
> +				    &found_streams, &enabled_streams);
>  
>  	if (found_streams != streams_mask) {
>  		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
> @@ -2196,6 +2221,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  		goto done;
>  	}
>  
> +	if (enabled_streams) {
> +		dev_dbg(dev, "streams 0x%llx already enabled on %s:%u\n",
> +			enabled_streams, sd->entity.name, pad);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
>  	dev_dbg(dev, "enable streams %u:%#llx\n", pad, streams_mask);
>  
>  	already_streaming = v4l2_subdev_is_streaming(sd);
> @@ -2213,13 +2245,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  	/* Mark the streams as enabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> -
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = true;
> -	}
> +	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
>  
>  done:
>  	if (ret && !already_streaming)
> @@ -2281,8 +2307,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
>  	struct v4l2_subdev_state *state;
> -	u64 found_streams = 0;
> -	unsigned int i;
> +	u64 enabled_streams;
> +	u64 found_streams;
>  	int ret;
>  
>  	/* A few basic sanity checks first. */
> @@ -2303,22 +2329,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	 * Verify that the requested streams exist and that they are not
>  	 * already disabled.
>  	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
>  
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
> -
> -		found_streams |= BIT_ULL(cfg->stream);
> -
> -		if (!cfg->enabled) {
> -			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> -			ret = -EALREADY;
> -			goto done;
> -		}
> -	}
> +	v4l2_subdev_collect_streams(sd, state, pad, streams_mask,
> +				    &found_streams, &enabled_streams);
>  
>  	if (found_streams != streams_mask) {
>  		dev_dbg(dev, "streams 0x%llx not found on %s:%u\n",
> @@ -2327,6 +2340,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  		goto done;
>  	}
>  
> +	if (enabled_streams != streams_mask) {
> +		dev_dbg(dev, "streams 0x%llx already disabled on %s:%u\n",
> +			streams_mask & ~enabled_streams, sd->entity.name, pad);
> +		ret = -EINVAL;
> +		goto done;
> +	}
> +
>  	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
>  
>  	/* Call the .disable_streams() operation. */
> @@ -2338,14 +2358,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  		goto done;
>  	}
>  
> -	/* Mark the streams as disabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> -
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = false;
> -	}
> +	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
>  
>  done:
>  	if (!v4l2_subdev_is_streaming(sd))
> 

-- 
Terveisin,

Sakari Ailus

