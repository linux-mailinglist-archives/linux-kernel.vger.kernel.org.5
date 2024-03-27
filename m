Return-Path: <linux-kernel+bounces-120358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C7CF88D63D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD5E1F29833
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3433D1BF31;
	Wed, 27 Mar 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Zfwc85G0"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1CB1A26E;
	Wed, 27 Mar 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711519846; cv=none; b=euhAjSLYUIHunyTHgbnubP3YYL7EH4vZUD6ZgY/aiSuzWRlIXJ3RYVV8Iig3f2nVpC9unOew+nAqmgn6R4Y+2ruUCSfkse6jUa9Qr/Dvkd7/LOVanav+88DMqEDWkZamR3epQ76n91t6qyvsAp+uJIAwGzZY61U8eeYion1BGj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711519846; c=relaxed/simple;
	bh=O8rRDAk7PaBI24fHYKlFYkN82sVrZXfYp+Zis2R0ZSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KGMvA8QYy0fLgOnbKOyL+4LP3MREN9JofYsGdDw9lYzujZgREpCRe3bRPYv3BA8EGoj5luCPkF2C16jttiOfSmRdIKqtK9I7hlMrP074U8Sq4+cGJryUNn3w95XUShzES40VGEHYLgfNm4DOXorS0UsmniCbaLReTR3FthEnFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Zfwc85G0; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.53])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 46C48231;
	Wed, 27 Mar 2024 07:10:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1711519810;
	bh=O8rRDAk7PaBI24fHYKlFYkN82sVrZXfYp+Zis2R0ZSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Zfwc85G0HOIZmZuOwrMHueTJjXjmWBmsN2808Zlj7PalT0gQZkllSN/Z6kkocJRUr
	 fyeU4QB+wxelwhW8nX8vUz7AKIbNTJv61fkPTRxun33kyRRSutF/enULV1gAsY6V91
	 P4qmuiQ4EZVco4OGP5YQt9n5XhC2/bwLE+pOT37g=
Message-ID: <f463dbb0-611d-4d86-b35d-bc19410c436a@ideasonboard.com>
Date: Wed, 27 Mar 2024 11:40:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: v4l2-subdev: Support enable/disable_streams for
 single-pad subdevs
Content-Language: en-US
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240325-single-pad-enable-streams-v1-1-142e19896a72@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

On 25/03/24 6:13 pm, Tomi Valkeinen wrote:
> Currently a subdevice with a single pad, e.g. a sensor subdevice, must
> use the v4l2_subdev_video_ops.s_stream op, instead of
> v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> enable/disable_streams machinery requires a routing table which a subdev
> cannot have with a single pad.
>
> Implement enable/disable_streams support for these single-pad subdevices
> by assuming an implicit stream 0 when the subdevice has only one pad.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

fwiw,

Tested-by: Umang Jain <umang.jain@ideasonboard.com>

with [1]

[1]: 
https://lore.kernel.org/linux-media/4bb01eb0-bf53-43f2-a488-7959aadacc3b@ideasonboard.com/
> ---
> Even though I did send this patch, I'm not sure if this is necessary.
> s_stream works fine for the subdevs with a single pad. With the upcoming
> internal pads, adding an internal pad to the subdev will create a
> routing table, and enable/disable_streams would get "fixed" that way.
>
> So perhaps the question is, do we want to support single-pad subdevs in
> the future, in which case something like this patch is necessary, or
> will all modern source subdev drivers have internal pads, in which
> case this is not needed...
> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 105 ++++++++++++++++++++++------------
>   include/media/v4l2-subdev.h           |   4 +-
>   2 files changed, 72 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 4c6198c48dd6..ddc7ed69421c 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2129,21 +2129,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   	 * Verify that the requested streams exist and that they are not
>   	 * already enabled.
>   	 */
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
> +	if (sd->entity.num_pads == 1) {
> +		if (sd->enabled_streams) {
>   			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> +				0, sd->entity.name, pad);
>   			ret = -EALREADY;
>   			goto done;
>   		}
> +
> +		found_streams = BIT_ULL(0);
> +	} else {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
> +
> +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> +				continue;
> +
> +			found_streams |= BIT_ULL(cfg->stream);
> +
> +			if (cfg->enabled) {
> +				dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> +					cfg->stream, sd->entity.name, pad);
> +				ret = -EALREADY;
> +				goto done;
> +			}
> +		}
>   	}
>   
>   	if (found_streams != streams_mask) {
> @@ -2164,13 +2176,17 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   		goto done;
>   	}
>   
> -	/* Mark the streams as enabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->entity.num_pads == 1) {
> +		sd->enabled_streams |= streams_mask;
> +	} else {
> +		/* Mark the streams as enabled. */
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>   
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = true;
> +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +				cfg->enabled = true;
> +		}
>   	}
>   
>   done:
> @@ -2246,21 +2262,32 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   	 * Verify that the requested streams exist and that they are not
>   	 * already disabled.
>   	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> -
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
> -
> -		found_streams |= BIT_ULL(cfg->stream);
> -
> -		if (!cfg->enabled) {
> +	if (sd->entity.num_pads == 1) {
> +		if (!sd->enabled_streams) {
>   			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> +				0, sd->entity.name, pad);
>   			ret = -EALREADY;
>   			goto done;
>   		}
> +
> +		found_streams = BIT_ULL(0);
> +	} else {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
> +
> +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> +				continue;
> +
> +			found_streams |= BIT_ULL(cfg->stream);
> +
> +			if (!cfg->enabled) {
> +				dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> +					cfg->stream, sd->entity.name, pad);
> +				ret = -EALREADY;
> +				goto done;
> +			}
> +		}
>   	}
>   
>   	if (found_streams != streams_mask) {
> @@ -2281,13 +2308,17 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   		goto done;
>   	}
>   
> -	/* Mark the streams as disabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->entity.num_pads == 1) {
> +		sd->enabled_streams &= ~streams_mask;
> +	} else {
> +		/* Mark the streams as disabled. */
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>   
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = false;
> +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +				cfg->enabled = false;
> +		}
>   	}
>   
>   done:
> @@ -2325,8 +2356,12 @@ int v4l2_subdev_s_stream_helper(struct v4l2_subdev *sd, int enable)
>   	 */
>   	state = v4l2_subdev_lock_and_get_active_state(sd);
>   
> -	for_each_active_route(&state->routing, route)
> -		source_mask |= BIT_ULL(route->source_stream);
> +	if (sd->entity.num_pads == 1) {
> +		source_mask = BIT_ULL(0);
> +	} else {
> +		for_each_active_route(&state->routing, route)
> +			source_mask |= BIT_ULL(route->source_stream);
> +	}
>   
>   	v4l2_subdev_unlock_state(state);
>   
> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
> index a9e6b8146279..39b230f7b3c8 100644
> --- a/include/media/v4l2-subdev.h
> +++ b/include/media/v4l2-subdev.h
> @@ -1041,8 +1041,8 @@ struct v4l2_subdev_platform_data {
>    *		  v4l2_subdev_init_finalize().
>    * @enabled_streams: Bitmask of enabled streams used by
>    *		     v4l2_subdev_enable_streams() and
> - *		     v4l2_subdev_disable_streams() helper functions for fallback
> - *		     cases.
> + *		     v4l2_subdev_disable_streams() helper functions. This is
> + *		     for fallback cases and for subdevs with single pads.
>    *
>    * Each instance of a subdev driver should create this struct, either
>    * stand-alone or embedded in a larger struct.
>
> ---
> base-commit: e8f897f4afef0031fe618a8e94127a0934896aba
> change-id: 20240325-single-pad-enable-streams-32a9a746ac5b
>
> Best regards,


