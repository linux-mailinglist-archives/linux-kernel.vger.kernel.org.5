Return-Path: <linux-kernel+bounces-140301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FE38A126F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA650282EC4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 11:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77D91474BE;
	Thu, 11 Apr 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Ai0UYLub"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDD613BACD;
	Thu, 11 Apr 2024 11:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712833335; cv=none; b=t/cf5Fjs/tpA+MnLC3vhG80H97Zi2A1z7eJ54Hyx9EpweUm0hUjyf6kZKL8hIRp+fUuKvIaRQD94tkeeAgNvPjnuWY8DEwVIfdE8SJ3nD91feCo9TPEp6Kr/vhPLrAduT0X4T/jEIFdcv0Rvhbx8biZ6F8vTeF9WU8t4DjObbSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712833335; c=relaxed/simple;
	bh=49RGkbUbh1ZYJfCd93/Msh6F3LL9akBjASXKS2hiCV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaX2oBOkxzqzrR2vuyeNybxabWTDPj5CJrBQWtNEvYFRwl1XYctDwWCgphXvEO6VpHxG+M0MRi7u7oHgTghhwHi0bCk5LrzzNpdnSH2kc2i9ihAUTCv7cqV0GZcm5Ss0hk3T1KbRzwa+v1J5eO+e9yq/GwL6YbRAyzyyQLNtF3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=Ai0UYLub; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.1.105] (unknown [103.251.226.65])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA39623F;
	Thu, 11 Apr 2024 13:01:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712833287;
	bh=49RGkbUbh1ZYJfCd93/Msh6F3LL9akBjASXKS2hiCV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ai0UYLubZKVuDdcrlGQsndJH1ozFBihThmVG+5Hzor9HAwucFGsXaswN6kgqsbS15
	 6hb6YCSXUVxmosZJqtn8P79o0J5Te4LQTJGPLti/zXnsRRkowtfWTOp6wlnLTYvWnB
	 sgtfi5MPmm+6y029mwc1ZW1xnvuCOVOZt69NcvhI=
Message-ID: <f8e293b7-6a06-4477-9c7e-d1b83163f8e1@ideasonboard.com>
Date: Thu, 11 Apr 2024 16:32:02 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil
 <hverkuil@xs4all.nl>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410-enable-streams-impro-v3-0-e5e7a5da7420@ideasonboard.com>
 <20240410-enable-streams-impro-v3-9-e5e7a5da7420@ideasonboard.com>
Content-Language: en-US
From: Umang Jain <umang.jain@ideasonboard.com>
In-Reply-To: <20240410-enable-streams-impro-v3-9-e5e7a5da7420@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Tomi,

On 10/04/24 6:05 pm, Tomi Valkeinen wrote:
> At the moment the v4l2_subdev_enable/disable_streams() functions call
> fallback helpers to handle the case where the subdev only implements
> .s_stream(), and the main function handles the case where the subdev
> implements streams (V4L2_SUBDEV_FL_STREAMS, which implies
> .enable/disable_streams()).
>
> What is missing is support for subdevs which do not implement streams
> support, but do implement .enable/disable_streams(). Example cases of
> these subdevices are single-stream cameras, where using
> .enable/disable_streams() is not required but helps us remove the users
> of the legacy .s_stream(), and subdevices with multiple source pads (but
> single stream per pad), where .enable/disable_streams() allows the
> subdevice to control the enable/disable state per pad.
>
> The two single-streams cases (.s_stream() and .enable/disable_streams())
> are very similar, and with small changes we can change the
> v4l2_subdev_enable/disable_streams() functions to support all three
> cases, without needing separate fallback functions.
>
> A few potentially problematic details, though:

Does this mean the patch needs to be worked upon more ?

I quickly tested the series by applying it locally with my use case of 
IMX283 .enable/disable streams and s_stream as the helper function and 
it seems I am still seeing the same behaviour as before (i.e. not being 
streamed) and have to carry the workaround as mentioned in [1] **NOTE**

[1] 
https://lore.kernel.org/linux-media/20240313070705.91140-1-umang.jain@ideasonboard.com/

>
> - For the single-streams cases we use sd->enabled_pads field, which
>    limits the number of pads for the subdevice to 64. For simplicity I
>    added the check for this limitation to the beginning of the function,
>    and it also applies to the streams case.
>
> - The fallback functions only allowed the target pad to be a source pad.
>    It is not very clear to me why this check was needed, but it was not
>    needed in the streams case. However, I doubt the
>    v4l2_subdev_enable/disable_streams() code has ever been tested with
>    sink pads, so to be on the safe side, I added the same check
>    to the v4l2_subdev_enable/disable_streams() functions.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>   drivers/media/v4l2-core/v4l2-subdev.c | 187 ++++++++++++++--------------------
>   1 file changed, 79 insertions(+), 108 deletions(-)
>
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 0d376d72ecc7..4a73886741f9 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
>   					u64 *found_streams,
>   					u64 *enabled_streams)
>   {
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
> +		*found_streams = BIT_ULL(0);
> +		if (sd->enabled_pads & BIT_ULL(pad))
> +			*enabled_streams = BIT_ULL(0);
> +		return;
> +	}
> +
>   	*found_streams = 0;
>   	*enabled_streams = 0;
>   
> @@ -2127,6 +2134,14 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>   					    u32 pad, u64 streams_mask,
>   					    bool enabled)
>   {
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
> +		if (enabled)
> +			sd->enabled_pads |= BIT_ULL(pad);
> +		else
> +			sd->enabled_pads &= ~BIT_ULL(pad);
> +		return;
> +	}
> +
>   	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
>   		struct v4l2_subdev_stream_config *cfg =
>   			&state->stream_configs.configs[i];
> @@ -2136,51 +2151,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>   	}
>   }
>   
> -static int v4l2_subdev_enable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
> -					       u64 streams_mask)
> -{
> -	struct device *dev = sd->entity.graph_obj.mdev->dev;
> -	int ret;
> -
> -	/*
> -	 * The subdev doesn't implement pad-based stream enable, fall back
> -	 * to the .s_stream() operation.
> -	 */
> -	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
> -		return -EOPNOTSUPP;
> -
> -	/*
> -	 * .s_stream() means there is no streams support, so only allowed stream
> -	 * is the implicit stream 0.
> -	 */
> -	if (streams_mask != BIT_ULL(0))
> -		return -EOPNOTSUPP;
> -
> -	/*
> -	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> -	 * with 64 pads or less can be supported.
> -	 */
> -	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
> -		return -EOPNOTSUPP;
> -
> -	if (sd->enabled_pads & BIT_ULL(pad)) {
> -		dev_dbg(dev, "pad %u already enabled on %s\n",
> -			pad, sd->entity.name);
> -		return -EALREADY;
> -	}
> -
> -	/* Start streaming when the first pad is enabled. */
> -	if (!sd->enabled_pads) {
> -		ret = v4l2_subdev_call(sd, video, s_stream, 1);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	sd->enabled_pads |= BIT_ULL(pad);
> -
> -	return 0;
> -}
> -
>   int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   			       u64 streams_mask)
>   {
> @@ -2189,21 +2159,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   	bool already_streaming;
>   	u64 enabled_streams;
>   	u64 found_streams;
> +	bool use_s_stream;
>   	int ret;
>   
>   	/* A few basic sanity checks first. */
>   	if (pad >= sd->entity.num_pads)
>   		return -EINVAL;
>   
> +	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
> +		return -EOPNOTSUPP;
> +
> +	/*
> +	 * We use a 64-bit bitmask for tracking enabled pads, so only subdevices
> +	 * with 64 pads or less can be supported.
> +	 */
> +	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
> +		return -EOPNOTSUPP;
> +
>   	if (!streams_mask)
>   		return 0;
>   
>   	/* Fallback on .s_stream() if .enable_streams() isn't available. */
> -	if (!v4l2_subdev_has_op(sd, pad, enable_streams))
> -		return v4l2_subdev_enable_streams_fallback(sd, pad,
> -							   streams_mask);
> +	use_s_stream = !v4l2_subdev_has_op(sd, pad, enable_streams);
>   
> -	state = v4l2_subdev_lock_and_get_active_state(sd);
> +	if (!use_s_stream)
> +		state = v4l2_subdev_lock_and_get_active_state(sd);
> +	else
> +		state = NULL;
>   
>   	/*
>   	 * Verify that the requested streams exist and that they are not
> @@ -2231,9 +2213,18 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   
>   	already_streaming = v4l2_subdev_is_streaming(sd);
>   
> -	/* Call the .enable_streams() operation. */
> -	ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
> -			       streams_mask);
> +	if (!use_s_stream) {
> +		/* Call the .enable_streams() operation. */
> +		ret = v4l2_subdev_call(sd, pad, enable_streams, state, pad,
> +				       streams_mask);
> +	} else {
> +		/* Start streaming when the first pad is enabled. */
> +		if (!already_streaming)
> +			ret = v4l2_subdev_call(sd, video, s_stream, 1);
> +		else
> +			ret = 0;
> +	}
> +
>   	if (ret) {
>   		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
>   			streams_mask, ret);
> @@ -2243,34 +2234,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>   	/* Mark the streams as enabled. */
>   	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);
>   
> -	if (!already_streaming)
> +	if (!use_s_stream && !already_streaming)
>   		v4l2_subdev_enable_privacy_led(sd);
>   
>   done:
> -	v4l2_subdev_unlock_state(state);
> +	if (!use_s_stream)
> +		v4l2_subdev_unlock_state(state);
>   
>   	return ret;
>   }
>   EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
>   
> -static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
> -						u64 streams_mask)
> +int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> +				u64 streams_mask)
>   {
>   	struct device *dev = sd->entity.graph_obj.mdev->dev;
> +	struct v4l2_subdev_state *state;
> +	u64 enabled_streams;
> +	u64 found_streams;
> +	bool use_s_stream;
>   	int ret;
>   
> -	/*
> -	 * If the subdev doesn't implement pad-based stream enable, fall back
> -	 * to the .s_stream() operation.
> -	 */
> -	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
> -		return -EOPNOTSUPP;
> +	/* A few basic sanity checks first. */
> +	if (pad >= sd->entity.num_pads)
> +		return -EINVAL;
>   
> -	/*
> -	 * .s_stream() means there is no streams support, so only allowed stream
> -	 * is the implicit stream 0.
> -	 */
> -	if (streams_mask != BIT_ULL(0))
> +	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>   		return -EOPNOTSUPP;
>   
>   	/*
> @@ -2280,46 +2269,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>   	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>   		return -EOPNOTSUPP;
>   
> -	if (!(sd->enabled_pads & BIT_ULL(pad))) {
> -		dev_dbg(dev, "pad %u already disabled on %s\n",
> -			pad, sd->entity.name);
> -		return -EALREADY;
> -	}
> -
> -	/* Stop streaming when the last streams are disabled. */
> -	if (!(sd->enabled_pads & ~BIT_ULL(pad))) {
> -		ret = v4l2_subdev_call(sd, video, s_stream, 0);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	sd->enabled_pads &= ~BIT_ULL(pad);
> -
> -	return 0;
> -}
> -
> -int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> -				u64 streams_mask)
> -{
> -	struct device *dev = sd->entity.graph_obj.mdev->dev;
> -	struct v4l2_subdev_state *state;
> -	u64 enabled_streams;
> -	u64 found_streams;
> -	int ret;
> -
> -	/* A few basic sanity checks first. */
> -	if (pad >= sd->entity.num_pads)
> -		return -EINVAL;
> -
>   	if (!streams_mask)
>   		return 0;
>   
>   	/* Fallback on .s_stream() if .disable_streams() isn't available. */
> -	if (!v4l2_subdev_has_op(sd, pad, disable_streams))
> -		return v4l2_subdev_disable_streams_fallback(sd, pad,
> -							    streams_mask);
> +	use_s_stream = !v4l2_subdev_has_op(sd, pad, disable_streams);
>   
> -	state = v4l2_subdev_lock_and_get_active_state(sd);
> +	if (!use_s_stream)
> +		state = v4l2_subdev_lock_and_get_active_state(sd);
> +	else
> +		state = NULL;
>   
>   	/*
>   	 * Verify that the requested streams exist and that they are not
> @@ -2345,9 +2304,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   
>   	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
>   
> -	/* Call the .disable_streams() operation. */
> -	ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
> -			       streams_mask);
> +	if (!use_s_stream) {
> +		/* Call the .disable_streams() operation. */
> +		ret = v4l2_subdev_call(sd, pad, disable_streams, state, pad,
> +				       streams_mask);
> +	} else {
> +		/* Stop streaming when the last streams are disabled. */
> +
> +		if (!(sd->enabled_pads & ~BIT_ULL(pad)))
> +			ret = v4l2_subdev_call(sd, video, s_stream, 0);
> +		else
> +			ret = 0;
> +	}
> +
>   	if (ret) {
>   		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
>   			streams_mask, ret);
> @@ -2357,10 +2326,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>   	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
>   
>   done:
> -	if (!v4l2_subdev_is_streaming(sd))
> -		v4l2_subdev_disable_privacy_led(sd);
> +	if (!use_s_stream) {
> +		if (!v4l2_subdev_is_streaming(sd))
> +			v4l2_subdev_disable_privacy_led(sd);
>   
> -	v4l2_subdev_unlock_state(state);
> +		v4l2_subdev_unlock_state(state);
> +	}
>   
>   	return ret;
>   }
>


