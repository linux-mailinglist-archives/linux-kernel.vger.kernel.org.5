Return-Path: <linux-kernel+bounces-151683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84E338AB200
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBA92837BD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676CF12FF86;
	Fri, 19 Apr 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="NznjbOOm"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434EE12FB16;
	Fri, 19 Apr 2024 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713540975; cv=none; b=OkpwM0xUs9mjAZ65z6NorxBNeEsedqJVg8Bd8dr6+v9WpCuTtipdfpZ9UQNrEhHqaym9ju1NOWL4z8ddHV0TCFcpkxx5fld0OcvYP4JF+fEDzskIeIXAoAAN4jqRhQ339frxzGYkrp3sNZ3ESxzm9xiIF062W8pLQRdaHf2kg8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713540975; c=relaxed/simple;
	bh=TGD8yubgvPLgNdh8+oQrQRqsnHoI2UW4XTv9nluRE30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YdnBuvcd3yWYW0hSa6YQBvRJfqN8bKgaGOUJLgUSkqXvEzjUM500+U2rkroPo0gJs0KY7MC6inU4Z5gRcFtOswprzjinJr08HZ53Yjz534dJlERKwhjtFpsBzDUKSFKJsJ+H7jWrm+ktzZNk/4hs/VYEYDiYxdQQDBh4L2bPF90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=NznjbOOm; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id DFA7563B;
	Fri, 19 Apr 2024 17:35:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713540923;
	bh=TGD8yubgvPLgNdh8+oQrQRqsnHoI2UW4XTv9nluRE30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NznjbOOmkDjaWbwmJEOfyVj6fdMP3ya9ON9psKpxoYC6F/QnD6nifcle5VqGAy6K2
	 uT5HBx/phR5u31lbc31e59NuRgv/cLOf/9bfsyTRCCpy2pfm6CzQf5it0XyiAKF3no
	 vQlzPttj7e6oC11LQu+W5rSiv8bmoIcY1XI64y3s=
Date: Fri, 19 Apr 2024 18:36:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 09/10] media: subdev: Support single-stream case in
 v4l2_subdev_enable/disable_streams()
Message-ID: <20240419153603.GE12651@pendragon.ideasonboard.com>
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
 <20240416-enable-streams-impro-v5-9-bd5fcea49388@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240416-enable-streams-impro-v5-9-bd5fcea49388@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Tue, Apr 16, 2024 at 04:55:12PM +0300, Tomi Valkeinen wrote:
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
> 
> - For the single-streams cases we use sd->enabled_pads field, which
>   limits the number of pads for the subdevice to 64. For simplicity I
>   added the check for this limitation to the beginning of the function,
>   and it also applies to the streams case.
> 
> - The fallback functions only allowed the target pad to be a source pad.
>   It is not very clear to me why this check was needed, but it was not
>   needed in the streams case. However, I doubt the
>   v4l2_subdev_enable/disable_streams() code has ever been tested with
>   sink pads, so to be on the safe side, I added the same check
>   to the v4l2_subdev_enable/disable_streams() functions.
> 

Now that v4l2_subdev_enable_streams() is usable by (almost) every
driver, should we update documentation to indicate that manual calls to
s_stream() should be avoided ?

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 187 ++++++++++++++--------------------
>  1 file changed, 79 insertions(+), 108 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index e45fd42da1e3..10406acfb9d0 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2106,6 +2106,13 @@ static void v4l2_subdev_collect_streams(struct v4l2_subdev *sd,
>  					u64 *found_streams,
>  					u64 *enabled_streams)
>  {
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
> +		*found_streams = BIT_ULL(0);
> +		*enabled_streams =
> +			(sd->enabled_pads & BIT_ULL(pad)) ? BIT_ULL(0) : 0;
> +		return;
> +	}
> +
>  	*found_streams = 0;
>  	*enabled_streams = 0;
>  
> @@ -2127,6 +2134,14 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>  					    u32 pad, u64 streams_mask,
>  					    bool enabled)
>  {
> +	if (!(sd->flags & V4L2_SUBDEV_FL_STREAMS)) {
> +		if (enabled)
> +			sd->enabled_pads |= BIT_ULL(pad);
> +		else
> +			sd->enabled_pads &= ~BIT_ULL(pad);
> +		return;
> +	}
> +
>  	for (unsigned int i = 0; i < state->stream_configs.num_configs; ++i) {
>  		struct v4l2_subdev_stream_config *cfg =
>  			&state->stream_configs.configs[i];
> @@ -2136,51 +2151,6 @@ static void v4l2_subdev_set_streams_enabled(struct v4l2_subdev *sd,
>  	}
>  }
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
> -	 * .s_stream() means there is no streams support, so the only allowed
> -	 * stream is the implicit stream 0.
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
>  int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  			       u64 streams_mask)
>  {
> @@ -2189,21 +2159,33 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	bool already_streaming;
>  	u64 enabled_streams;
>  	u64 found_streams;
> +	bool use_s_stream;
>  	int ret;
>  
>  	/* A few basic sanity checks first. */
>  	if (pad >= sd->entity.num_pads)
>  		return -EINVAL;
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
>  	if (!streams_mask)
>  		return 0;
>  
>  	/* Fallback on .s_stream() if .enable_streams() isn't available. */
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
>  	/*
>  	 * Verify that the requested streams exist and that they are not
> @@ -2231,9 +2213,18 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  
>  	already_streaming = v4l2_subdev_is_streaming(sd);
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
>  	if (ret) {
>  		dev_dbg(dev, "enable streams %u:%#llx failed: %d\n", pad,
>  			streams_mask, ret);
> @@ -2243,34 +2234,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	/* Mark the streams as enabled. */
>  	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, true);

state gets set to a non-null value above if the subdev has an
enable_streams operation, while in v4l2_subdev_set_streams_enabled(),
you use it if the V4L2_SUBDEV_FL_STREAMS flag is set. The second
condition is a subset of the first one, so it should be safe now, but I
wonder if we're at risk of crashes in the future when reworking the
code. I'm probably worrying needlessly.

>  
> -	if (!already_streaming)
> +	if (!use_s_stream && !already_streaming)
>  		v4l2_subdev_enable_privacy_led(sd);

Once everybody switches to v4l2_subdev_enable_streams() (am I dreaming?)
we should move LED handling from the .s_stream() wrapper to here for the
fallback case too. How about a TODO comment ?

>  
>  done:
> -	v4l2_subdev_unlock_state(state);
> +	if (!use_s_stream)

	if (state)

would be better I think.

> +		v4l2_subdev_unlock_state(state);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(v4l2_subdev_enable_streams);
>  
> -static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
> -						u64 streams_mask)
> +int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
> +				u64 streams_mask)
>  {
>  	struct device *dev = sd->entity.graph_obj.mdev->dev;
> +	struct v4l2_subdev_state *state;
> +	u64 enabled_streams;
> +	u64 found_streams;
> +	bool use_s_stream;
>  	int ret;
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
> -	 * .s_stream() means there is no streams support, so the only allowed
> -	 * stream is the implicit stream 0.
> -	 */
> -	if (streams_mask != BIT_ULL(0))
> +	if (!(sd->entity.pads[pad].flags & MEDIA_PAD_FL_SOURCE))
>  		return -EOPNOTSUPP;
>  
>  	/*
> @@ -2280,46 +2269,16 @@ static int v4l2_subdev_disable_streams_fallback(struct v4l2_subdev *sd, u32 pad,
>  	if (pad >= sizeof(sd->enabled_pads) * BITS_PER_BYTE)
>  		return -EOPNOTSUPP;
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
>  	if (!streams_mask)
>  		return 0;
>  
>  	/* Fallback on .s_stream() if .disable_streams() isn't available. */
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
>  	/*
>  	 * Verify that the requested streams exist and that they are not
> @@ -2345,9 +2304,19 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  
>  	dev_dbg(dev, "disable streams %u:%#llx\n", pad, streams_mask);
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
>  	if (ret) {
>  		dev_dbg(dev, "disable streams %u:%#llx failed: %d\n", pad,
>  			streams_mask, ret);
> @@ -2357,10 +2326,12 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	v4l2_subdev_set_streams_enabled(sd, state, pad, streams_mask, false);
>  
>  done:
> -	if (!v4l2_subdev_is_streaming(sd))
> -		v4l2_subdev_disable_privacy_led(sd);
> +	if (!use_s_stream) {
> +		if (!v4l2_subdev_is_streaming(sd))
> +			v4l2_subdev_disable_privacy_led(sd);

Do we want to disable the privacy LED on failure in all cases, in
particular when the .s_stream() or .disable_streams() operations are not
even called ?

And now that I wrote that, I realize the !v4l2_subdev_is_streaming()
condition will not be true if the operations failed, so it should be
fine.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  
> -	v4l2_subdev_unlock_state(state);
> +		v4l2_subdev_unlock_state(state);
> +	}
>  
>  	return ret;
>  }
> 

-- 
Regards,

Laurent Pinchart

