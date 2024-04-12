Return-Path: <linux-kernel+bounces-143225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF5E8A35EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 20:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8ECBB21256
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9154414F9E3;
	Fri, 12 Apr 2024 18:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gZSvfnsH"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96814EC60;
	Fri, 12 Apr 2024 18:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712947541; cv=none; b=vDj4yeVqd4SxaUbHs9D04Uonq90SQuHh9tWmdo+nTCUs6BJlPA11tNqun2RHOERYago39nCbVwlmUjyBSBQPOWt+c/RcTpghCdShnVqa51Dwlfpc9nE2d6oCyw3JzlQupuTc2Cx/7vQ+zYaRQEK5pZyxNIWvCaLItOppp25bmsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712947541; c=relaxed/simple;
	bh=hM5Bar2U2SbNUBgeHwCsRu6FWTaanDGZpoF5JZ0mjKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUhYIuPvgYNXG1jOi1RqWOTo6pH/nFTaUxmODcEo3nFqmrd+/XyA/dPNSOD71Z5+h7SvAHq8SaZHtXwcU2CuzEgOJ0Ik9FFP3NBVGenzRAw0D57N84Xq49yW40OPuRSZeh4huBZu7c3NJis4FeivrSYRhrdTPntpLJeQ91YLfz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gZSvfnsH; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (85-76-65-73-nat.elisa-mobile.fi [85.76.65.73])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id C9FB39D5;
	Fri, 12 Apr 2024 20:44:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712947494;
	bh=hM5Bar2U2SbNUBgeHwCsRu6FWTaanDGZpoF5JZ0mjKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gZSvfnsHkRha8KZvhjoj6aKwQyKzQUCTfrap+U1rbqUjUic+IgvdhBCrGVlKvdWIG
	 BQec0NAZE0rEJgfAnQvhQaO9PdQekEsuuCM2yE0VKjv76frtKlpCJYUCAFHRjjMIEb
	 VTuBPihgKryNFjXazlxVvGhOIEF5Awmmwhvh6+MU=
Date: Fri, 12 Apr 2024 21:45:28 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 8/9] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Message-ID: <20240412184528.GK31122@pendragon.ideasonboard.com>
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-8-e5e7a5da7420@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240410-enable-streams-impro-v3-8-e5e7a5da7420@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Wed, Apr 10, 2024 at 03:35:55PM +0300, Tomi Valkeinen wrote:
> Add two internal helper functions, v4l2_subdev_collect_streams() and
> v4l2_subdev_set_streams_enabled(), which allows us to refactor
> v4l2_subdev_enable/disable_streams() functions.
> 
> This (I think) makes the code a bit easier to read, and lets us more
> easily add new functionality in the helper functions in the following
> patch.
> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index f44aaa4e1fab..0d376d72ecc7 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2100,6 +2100,42 @@ int v4l2_subdev_routing_validate(struct v4l2_subdev *sd,
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
> +		const struct v4l2_subdev_stream_config *cfg =
> +			&state->stream_configs.configs[i];
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
> +		struct v4l2_subdev_stream_config *cfg =
> +			&state->stream_configs.configs[i];
> +
> +		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +			cfg->enabled = enabled;
> +	}
> +}
> +
>  static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>  					       u64 streams_mask)
>  {
> @@ -2151,8 +2187,8 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
> @@ -2173,22 +2209,9 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
> @@ -2197,6 +2220,13 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
> @@ -2211,13 +2241,7 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
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
>  	if (!already_streaming)
>  		v4l2_subdev_enable_privacy_led(sd);
> @@ -2279,8 +2303,8 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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
> @@ -2301,22 +2325,9 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	 * Verify that the requested streams exist and that they are not
>  	 * already disabled.
>  	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> -
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
>  
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
> @@ -2325,6 +2336,13 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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
> @@ -2336,14 +2354,7 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
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
Regards,

Laurent Pinchart

