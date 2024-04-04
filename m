Return-Path: <linux-kernel+bounces-131488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BEB589888C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7902B1F21DCE
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F5A1272A3;
	Thu,  4 Apr 2024 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="wg0RCMmS"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB40176023;
	Thu,  4 Apr 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236107; cv=none; b=ZNet7DUYTr5nL3kpvk4FbGA7Ob/hHJqd9o1WJgk//k3gCG7r3PW87DLav0Ccy1apCuKZpdiY2LsM9LckG9PTzESRXotRCAt4CP+kpmDYxBLW3vqdi1bIxjFOL/+4BhJPWkZJ2oRHag9Th73ffokkUJY6TlJTiWtbRxzNbNzUobg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236107; c=relaxed/simple;
	bh=Fxw7izMZBHINInFBgMvZnrK2OVj3Y/wr0ErIjKC0nvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAHl43/QvY3SSdFibvk7Ukxqairf4vvzr74Ft5yp3Byp9FQhuPNsdOBQ7tgL4GZE0QxZPrkBlPLp1jXa3XaVduDVtRt/7lWPbCz0eAn5jscTgJnB/lB/YLFHKa7iKLpxkZh31J25UryUh2HLSDC5joLOB//bi3nYAc2M+4Dn6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=wg0RCMmS; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (81-175-209-231.bb.dnainternet.fi [81.175.209.231])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A3DE512D;
	Thu,  4 Apr 2024 15:07:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712236066;
	bh=Fxw7izMZBHINInFBgMvZnrK2OVj3Y/wr0ErIjKC0nvo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wg0RCMmSGzGy42++9MreJcE1+RdUF33ET6uMQWDOfbRicf0EaughZCGdHdt7/QJTe
	 PL3noLqsf399zictyeETjVZiBNxk5KIetapP8192JAEPkBdMzrq6afRAABIcOag6+w
	 16VlFRh7IVY18Z1L+CUX/jR15J9dS61BThSFv+TA=
Date: Thu, 4 Apr 2024 16:08:13 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] media: subdev: Support enable/disable_streams for
 non-streams subdevs
Message-ID: <20240404130813.GS23803@pendragon.ideasonboard.com>
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-4-1017a35bbe07@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240404-enable-streams-impro-v1-4-1017a35bbe07@ideasonboard.com>

Hi Tomi,

Thank you for the patch.

On Thu, Apr 04, 2024 at 01:50:03PM +0300, Tomi Valkeinen wrote:
> Currently a subdevice without streams support (V4L2_SUBDEV_FL_STREAMS),
> e.g. a sensor subdevice with a single source pad, must use the
> v4l2_subdev_video_ops.s_stream op, instead of
> v4l2_subdev_pad_ops.enable/disable_streams. This is because the
> enable/disable_streams machinery requires a routing table which a subdev
> cannot have with a single pad.
> 
> Implement enable/disable_streams support for subdevs without streams
> support. As they don't support multiple streams, each pad must contain a
> single stream, with stream ID 0, and rather than tracking enabled
> streams, we can track enabled pads similarly to the
> enable/disable_streams_fallback by using the sd->enabled_pads field.

Could you explain in the commit message why this is desired ?

> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> ---
>  drivers/media/v4l2-core/v4l2-subdev.c | 86 +++++++++++++++++++++++------------
>  1 file changed, 58 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
> index 91298bb84e6b..d86f930be2c4 100644
> --- a/drivers/media/v4l2-core/v4l2-subdev.c
> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> @@ -2158,21 +2158,32 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	 * Verify that the requested streams exist and that they are not
>  	 * already enabled.
>  	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>  
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
> +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> +				continue;
>  
> -		found_streams |= BIT_ULL(cfg->stream);
> +			found_streams |= BIT_ULL(cfg->stream);
>  
> -		if (cfg->enabled) {
> -			dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> +			if (cfg->enabled) {
> +				dev_dbg(dev, "stream %u already enabled on %s:%u\n",
> +					cfg->stream, sd->entity.name, pad);
> +				ret = -EALREADY;
> +				goto done;
> +			}
> +		}
> +	} else {
> +		if (sd->enabled_pads & BIT_ULL(pad)) {
> +			dev_dbg(dev, "stream 0 already enabled on %s:%u\n",
> +				sd->entity.name, pad);
>  			ret = -EALREADY;
>  			goto done;
>  		}
> +
> +		found_streams = BIT_ULL(0);
>  	}
>  
>  	if (found_streams != streams_mask) {
> @@ -2194,12 +2205,16 @@ int v4l2_subdev_enable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  	/* Mark the streams as enabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>  
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = true;
> +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +				cfg->enabled = true;
> +		}
> +	} else {
> +		sd->enabled_pads |= BIT_ULL(pad);
>  	}
>  
>  done:
> @@ -2281,21 +2296,32 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	 * Verify that the requested streams exist and that they are not
>  	 * already disabled.
>  	 */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>  
> -		if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> -			continue;
> +			if (cfg->pad != pad || !(streams_mask & BIT_ULL(cfg->stream)))
> +				continue;
>  
> -		found_streams |= BIT_ULL(cfg->stream);
> +			found_streams |= BIT_ULL(cfg->stream);
>  
> -		if (!cfg->enabled) {
> -			dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> -				cfg->stream, sd->entity.name, pad);
> +			if (!cfg->enabled) {
> +				dev_dbg(dev, "stream %u already disabled on %s:%u\n",
> +					cfg->stream, sd->entity.name, pad);
> +				ret = -EALREADY;
> +				goto done;
> +			}
> +		}
> +	} else {
> +		if (!(sd->enabled_pads & BIT_ULL(pad))) {
> +			dev_dbg(dev, "stream 0 already disabled on %s:%u\n",
> +				sd->entity.name, pad);
>  			ret = -EALREADY;
>  			goto done;
>  		}
> +
> +		found_streams = BIT_ULL(0);
>  	}
>  
>  	if (found_streams != streams_mask) {
> @@ -2317,12 +2343,16 @@ int v4l2_subdev_disable_streams(struct v4l2_subdev *sd, u32 pad,
>  	}
>  
>  	/* Mark the streams as disabled. */
> -	for (i = 0; i < state->stream_configs.num_configs; ++i) {
> -		struct v4l2_subdev_stream_config *cfg =
> -			&state->stream_configs.configs[i];
> +	if (sd->flags & V4L2_SUBDEV_FL_STREAMS) {
> +		for (i = 0; i < state->stream_configs.num_configs; ++i) {
> +			struct v4l2_subdev_stream_config *cfg =
> +				&state->stream_configs.configs[i];
>  
> -		if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> -			cfg->enabled = false;
> +			if (cfg->pad == pad && (streams_mask & BIT_ULL(cfg->stream)))
> +				cfg->enabled = false;
> +		}
> +	} else {
> +		sd->enabled_pads &= ~BIT_ULL(pad);
>  	}
>  
>  done:

-- 
Regards,

Laurent Pinchart

