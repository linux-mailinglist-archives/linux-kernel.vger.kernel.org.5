Return-Path: <linux-kernel+bounces-156562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C75598B0493
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 847202898EE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A621581EB;
	Wed, 24 Apr 2024 08:41:49 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A244B1D52B;
	Wed, 24 Apr 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713948108; cv=none; b=jhsd0IhIaj1KSku+qGwim28J+gWA4xaB2g/xnRHTSxbm4gvFzQtXcLXnCTSUeG2muHqkAmifsrszQ+5fPW42xi6D+CNS5ZaZV7T6K9jalnOdZJas037r9Mi9lKC3cj1QFy37YC+CLyOTQVwMAJ/pRh3vt6tHyawbZhvatIcDrdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713948108; c=relaxed/simple;
	bh=rnfcxFypierq0lQ1vTsy1yxFN2kU/Ca4cKe2Ld2G4KQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Krtwrzx/XxLWYDjVaH9i2BYUc37LQMVd0cenD+CV/OpSHC5xg4z6/nGwOWOdYaSZWI+gaVAyMWaoVdjFKz4Rx4sE3akFvSvoBXqUvSuIvz5wmV+yP2lKnH3+KQ6V2xiwgzrwwXsLu6Z0ysXySgzbd5vmE1YK46JSnAa+y5Xpwls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DBDDC113CE;
	Wed, 24 Apr 2024 08:41:46 +0000 (UTC)
Message-ID: <7483a57b-b499-49bb-bd10-cdcf311a8470@xs4all.nl>
Date: Wed, 24 Apr 2024 10:41:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/10] media: subdev: Refactor
 v4l2_subdev_enable/disable_streams()
Content-Language: en-US, nl
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240416-enable-streams-impro-v5-0-bd5fcea49388@ideasonboard.com>
 <20240416-enable-streams-impro-v5-8-bd5fcea49388@ideasonboard.com>
From: Hans Verkuil <hverkuil@xs4all.nl>
Autocrypt: addr=hverkuil@xs4all.nl; keydata=
 xsFNBFQ84W0BEAC7EF1iL4s3tY8cRTVkJT/297h0Hz0ypA+ByVM4CdU9sN6ua/YoFlr9k0K4
 BFUlg7JzJoUuRbKxkYb8mmqOe722j7N3HO8+ofnio5cAP5W0WwDpM0kM84BeHU0aPSTsWiGR
 yw55SOK2JBSq7hueotWLfJLobMWhQii0Zd83hGT9SIt9uHaHjgwmtTH7MSTIiaY6N14nw2Ud
 C6Uykc1va0Wqqc2ov5ihgk/2k2SKa02ookQI3e79laOrbZl5BOXNKR9LguuOZdX4XYR3Zi6/
 BsJ7pVCK9xkiVf8svlEl94IHb+sa1KrlgGv3fn5xgzDw8Z222TfFceDL/2EzUyTdWc4GaPMC
 E/c1B4UOle6ZHg02+I8tZicjzj5+yffv1lB5A1btG+AmoZrgf0X2O1B96fqgHx8w9PIpVERN
 YsmkfxvhfP3MO3oHh8UY1OLKdlKamMneCLk2up1Zlli347KMjHAVjBAiy8qOguKF9k7HOjif
 JCLYTkggrRiEiE1xg4tblBNj8WGyKH+u/hwwwBqCd/Px2HvhAsJQ7DwuuB3vBAp845BJYUU3
 06kRihFqbO0vEt4QmcQDcbWINeZ2zX5TK7QQ91ldHdqJn6MhXulPKcM8tCkdD8YNXXKyKqNl
 UVqXnarz8m2JCbHgjEkUlAJCNd6m3pfESLZwSWsLYL49R5yxIwARAQABzSFIYW5zIFZlcmt1
 aWwgPGh2ZXJrdWlsQHhzNGFsbC5ubD7CwZUEEwECACgFAlQ84W0CGwMFCRLMAwAGCwkIBwMC
 BhUIAgkKCwQWAgMBAh4BAheAACEJEL0tYUhmFDtMFiEEBSzee8IVBTtonxvKvS1hSGYUO0wT
 7w//frEmPBAwu3OdvAk9VDkH7X+7RcFpiuUcJxs3Xl6jpaA+SdwtZra6W1uMrs2RW8eXXiq/
 80HXJtYnal1Y8MKUBoUVhT/+5+KcMyfVQK3VFRHnNxCmC9HZV+qdyxAGwIscUd4hSlweuU6L
 6tI7Dls6NzKRSTFbbGNZCRgl8OrF01TBH+CZrcFIoDgpcJA5Pw84mxo+wd2BZjPA4TNyq1od
 +slSRbDqFug1EqQaMVtUOdgaUgdlmjV0+GfBHoyCGedDE0knv+tRb8v5gNgv7M3hJO3Nrl+O
 OJVoiW0G6OWVyq92NNCKJeDy8XCB1yHCKpBd4evO2bkJNV9xcgHtLrVqozqxZAiCRKN1elWF
 1fyG8KNquqItYedUr+wZZacqW+uzpVr9pZmUqpVCk9s92fzTzDZcGAxnyqkaO2QTgdhPJT2m
 wpG2UwIKzzi13tmwakY7OAbXm76bGWVZCO3QTHVnNV8ku9wgeMc/ZGSLUT8hMDZlwEsW7u/D
 qt+NlTKiOIQsSW7u7h3SFm7sMQo03X/taK9PJhS2BhhgnXg8mOa6U+yNaJy+eU0Lf5hEUiDC
 vDOI5x++LD3pdrJVr/6ZB0Qg3/YzZ0dk+phQ+KlP6HyeO4LG662toMbFbeLcBjcC/ceEclII
 90QNEFSZKM6NVloM+NaZRYVO3ApxWkFu+1mrVTXOwU0EVDzhbQEQANzLiI6gHkIhBQKeQaYs
 p2SSqF9c++9LOy5x6nbQ4s0X3oTKaMGfBZuiKkkU6NnHCSa0Az5ScRWLaRGu1PzjgcVwzl5O
 sDawR1BtOG/XoPRNB2351PRp++W8TWo2viYYY0uJHKFHML+ku9q0P+NkdTzFGJLP+hn7x0RT
 DMbhKTHO3H2xJz5TXNE9zTJuIfGAz3ShDpijvzYieY330BzZYfpgvCllDVM5E4XgfF4F/N90
 wWKu50fMA01ufwu+99GEwTFVG2az5T9SXd7vfSgRSkzXy7hcnxj4IhOfM6Ts85/BjMeIpeqy
 TDdsuetBgX9DMMWxMWl7BLeiMzMGrfkJ4tvlof0sVjurXibTibZyfyGR2ricg8iTbHyFaAzX
 2uFVoZaPxrp7udDfQ96sfz0hesF9Zi8d7NnNnMYbUmUtaS083L/l2EDKvCIkhSjd48XF+aO8
 VhrCfbXWpGRaLcY/gxi2TXRYG9xCa7PINgz9SyO34sL6TeFPSZn4bPQV5O1j85Dj4jBecB1k
 z2arzwlWWKMZUbR04HTeAuuvYvCKEMnfW3ABzdonh70QdqJbpQGfAF2p4/iCETKWuqefiOYn
 pR8PqoQA1DYv3t7y9DIN5Jw/8Oj5wOeEybw6vTMB0rrnx+JaXvxeHSlFzHiD6il/ChDDkJ9J
 /ejCHUQIl40wLSDRABEBAAHCwXwEGAECAA8FAlQ84W0CGwwFCRLMAwAAIQkQvS1hSGYUO0wW
 IQQFLN57whUFO2ifG8q9LWFIZhQ7TA1WD/9yxJvQrpf6LcNrr8uMlQWCg2iz2q1LGt1Itkuu
 KaavEF9nqHmoqhSfZeAIKAPn6xuYbGxXDrpN7dXCOH92fscLodZqZtK5FtbLvO572EPfxneY
 UT7JzDc/5LT9cFFugTMOhq1BG62vUm/F6V91+unyp4dRlyryAeqEuISykhvjZCVHk/woaMZv
 c1Dm4Uvkv0Ilelt3Pb9J7zhcx6sm5T7v16VceF96jG61bnJ2GFS+QZerZp3PY27XgtPxRxYj
 AmFUeF486PHx/2Yi4u1rQpIpC5inPxIgR1+ZFvQrAV36SvLFfuMhyCAxV6WBlQc85ArOiQZB
 Wm7L0repwr7zEJFEkdy8C81WRhMdPvHkAIh3RoY1SGcdB7rB3wCzfYkAuCBqaF7Zgfw8xkad
 KEiQTexRbM1sc/I8ACpla3N26SfQwrfg6V7TIoweP0RwDrcf5PVvwSWsRQp2LxFCkwnCXOra
 gYmkrmv0duG1FStpY+IIQn1TOkuXrciTVfZY1cZD0aVxwlxXBnUNZZNslldvXFtndxR0SFat
 sflovhDxKyhFwXOP0Rv8H378/+14TaykknRBIKEc0+lcr+EMOSUR5eg4aURb8Gc3Uc7fgQ6q
 UssTXzHPyj1hAyDpfu8DzAwlh4kKFTodxSsKAjI45SLjadSc94/5Gy8645Y1KgBzBPTH7Q==
In-Reply-To: <20240416-enable-streams-impro-v5-8-bd5fcea49388@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 15:55, Tomi Valkeinen wrote:
> Add two internal helper functions, v4l2_subdev_collect_streams() and
> v4l2_subdev_set_streams_enabled(), which allows us to refactor
> v4l2_subdev_enable/disable_streams() functions.
> 
> This (I think) makes the code a bit easier to read, and lets us more
> easily add new functionality in the helper functions in the following
> patch.
> 
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 109 +++++++++++++++++++---------------
>  1 file changed, 60 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 38388b223564..e45fd42da1e3 100644
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

This used to return -EALREADY...

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

..but now it returns -EINVAL.

Is that intentional?

I prefer EINVAL to be honest, but I was just wondering about this change.

It looks like the next patch removes the last of the EALREADY error returns
as well.

Regards,

	Hans

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


