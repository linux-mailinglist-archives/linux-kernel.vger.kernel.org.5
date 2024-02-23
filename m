Return-Path: <linux-kernel+bounces-78216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A1086105B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76A471C21E76
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B1C778697;
	Fri, 23 Feb 2024 11:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="vu33y28q"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D687E5C911;
	Fri, 23 Feb 2024 11:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708687719; cv=none; b=KGyEyVtf9l/0ynU1X8gveDI0S+dK3/ADaDoovgSK3R+5h0aHitqeFbfgAPojb7JY5rZoHgRRKVIX45rMOSaThbSPSocCuzKfIUVSir0vY8bp8Q65+nAiUB0TX9UKnnx2MByq0qUTNWLOuofZngBzhveK74G13+jE27jTHrmlKdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708687719; c=relaxed/simple;
	bh=S4SZBOtb0NpsITkjiCbJF7qK7jEfZsU9vO1S/fV1e7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDhnOTEKQ+w3/krtyz+m550CV7B85KcmIxvPWUfX83qdRtcod5mgCMTTOkoXefo7tNtXTAAV2s8ms9kgJFI6s4n3ZMMz/bglPERYocFO5SVGLbmdE2BAAGHpt0eH8iMv/oCX9YlsACuK4sTtvOLAA726AOuMVN03HreaTRymDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=vu33y28q; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (89-27-53-110.bb.dnainternet.fi [89.27.53.110])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D8B8B2E7;
	Fri, 23 Feb 2024 12:28:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1708687707;
	bh=S4SZBOtb0NpsITkjiCbJF7qK7jEfZsU9vO1S/fV1e7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vu33y28qj9A4buvFVX9JvdMZyghVH6SeE5TntFiMkZlAqUcai3IzQzD3YXDbF/63g
	 XyN9Qco/YbQza/vNOFbhWpQqVKuVtr3hCLt6xibkGp/fUbkmcV/BjspVLZsN9tgUs9
	 U/oyP28EGShqGCo64LEdJi4XmD90yfzEuSq84XDI=
Date: Fri, 23 Feb 2024 13:28:39 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Mikhail Rudenko <mike.rudenko@gmail.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: Re: [PATCH v2 07/20] media: i2c: ov4689: Use sub-device active state
Message-ID: <20240223112839.GO31348@pendragon.ideasonboard.com>
References: <20231218174042.794012-1-mike.rudenko@gmail.com>
 <20231218174042.794012-8-mike.rudenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231218174042.794012-8-mike.rudenko@gmail.com>

Hi Mikhail,

Thank you for the patch.

On Mon, Dec 18, 2023 at 08:40:28PM +0300, Mikhail Rudenko wrote:
> Use sub-device active state. Employ control handler lock to
> synchronize access to the active state and s_stream.
> 
> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> ---
>  drivers/media/i2c/ov4689.c | 75 ++++++++++++++++----------------------
>  1 file changed, 32 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
> index d42f5d1a1ba8..501901aad4ae 100644
> --- a/drivers/media/i2c/ov4689.c
> +++ b/drivers/media/i2c/ov4689.c
> @@ -86,7 +86,6 @@ struct ov4689 {
>  
>  	u32 clock_rate;
>  
> -	struct mutex mutex; /* lock to protect ctrls and cur_mode */
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	struct v4l2_ctrl *exposure;
>  
> @@ -319,19 +318,6 @@ static int ov4689_set_fmt(struct v4l2_subdev *sd,
>  	return 0;
>  }
>  
> -static int ov4689_get_fmt(struct v4l2_subdev *sd,
> -			  struct v4l2_subdev_state *sd_state,
> -			  struct v4l2_subdev_format *fmt)
> -{
> -	struct v4l2_mbus_framefmt *mbus_fmt = &fmt->format;
> -	struct ov4689 *ov4689 = to_ov4689(sd);
> -
> -	/* only one mode supported for now */
> -	ov4689_fill_fmt(ov4689->cur_mode, mbus_fmt);
> -
> -	return 0;
> -}
> -
>  static int ov4689_enum_mbus_code(struct v4l2_subdev *sd,
>  				 struct v4l2_subdev_state *sd_state,
>  				 struct v4l2_subdev_mbus_code_enum *code)
> @@ -405,10 +391,11 @@ static int ov4689_get_selection(struct v4l2_subdev *sd,
>  static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  {
>  	struct ov4689 *ov4689 = to_ov4689(sd);
> +	struct v4l2_subdev_state *sd_state;
>  	struct device *dev = ov4689->dev;
>  	int ret = 0;
>  
> -	mutex_lock(&ov4689->mutex);
> +	sd_state = v4l2_subdev_lock_and_get_active_state(&ov4689->subdev);
>  
>  	if (on) {
>  		ret = pm_runtime_resume_and_get(dev);
> @@ -443,7 +430,7 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
>  	}
>  
>  unlock_and_return:
> -	mutex_unlock(&ov4689->mutex);
> +	v4l2_subdev_unlock_state(sd_state);
>  
>  	return ret;
>  }
> @@ -506,18 +493,13 @@ static int __maybe_unused ov4689_power_off(struct device *dev)
>  	return 0;
>  }
>  
> -static int ov4689_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
> +static int ov4689_init_state(struct v4l2_subdev *sd,
> +			     struct v4l2_subdev_state *sd_state)
>  {
> -	struct ov4689 *ov4689 = to_ov4689(sd);
> -	struct v4l2_mbus_framefmt *try_fmt;
> -
> -	mutex_lock(&ov4689->mutex);
> -
> -	try_fmt = v4l2_subdev_state_get_format(fh->state, 0);
> -	/* Initialize try_fmt */
> -	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], try_fmt);
> +	struct v4l2_mbus_framefmt *fmt =
> +		v4l2_subdev_state_get_format(sd_state, 0);
>  
> -	mutex_unlock(&ov4689->mutex);
> +	ov4689_fill_fmt(&supported_modes[OV4689_MODE_2688_1520], fmt);
>  
>  	return 0;
>  }
> @@ -526,10 +508,6 @@ static const struct dev_pm_ops ov4689_pm_ops = {
>  	SET_RUNTIME_PM_OPS(ov4689_power_off, ov4689_power_on, NULL)
>  };
>  
> -static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
> -	.open = ov4689_open,
> -};
> -
>  static const struct v4l2_subdev_video_ops ov4689_video_ops = {
>  	.s_stream = ov4689_s_stream,
>  };
> @@ -537,11 +515,15 @@ static const struct v4l2_subdev_video_ops ov4689_video_ops = {
>  static const struct v4l2_subdev_pad_ops ov4689_pad_ops = {
>  	.enum_mbus_code = ov4689_enum_mbus_code,
>  	.enum_frame_size = ov4689_enum_frame_sizes,
> -	.get_fmt = ov4689_get_fmt,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = ov4689_set_fmt,
>  	.get_selection = ov4689_get_selection,
>  };
>  
> +static const struct v4l2_subdev_internal_ops ov4689_internal_ops = {
> +	.init_state = ov4689_init_state,
> +};
> +
>  static const struct v4l2_subdev_ops ov4689_subdev_ops = {
>  	.video = &ov4689_video_ops,
>  	.pad = &ov4689_pad_ops,
> @@ -648,7 +630,6 @@ static int ov4689_initialize_controls(struct ov4689 *ov4689)
>  	ret = v4l2_ctrl_handler_init(handler, 10);
>  	if (ret)
>  		return ret;
> -	handler->lock = &ov4689->mutex;
>  
>  	ctrl = v4l2_ctrl_new_int_menu(handler, NULL, V4L2_CID_LINK_FREQ, 0, 0,
>  				      link_freq_menu_items);
> @@ -861,13 +842,15 @@ static int ov4689_probe(struct i2c_client *client)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to get power regulators\n");
>  
> -	mutex_init(&ov4689->mutex);
> -
>  	sd = &ov4689->subdev;
>  	v4l2_i2c_subdev_init(sd, client, &ov4689_subdev_ops);
> +	sd->internal_ops = &ov4689_internal_ops;
> +
>  	ret = ov4689_initialize_controls(ov4689);
> -	if (ret)
> -		goto err_destroy_mutex;
> +	if (ret) {
> +		dev_err(dev, "Failed to initialize controls\n");
> +		return ret;
> +	}
>  
>  	ret = ov4689_power_on(dev);
>  	if (ret)
> @@ -877,19 +860,26 @@ static int ov4689_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_power_off;
>  
> -	sd->internal_ops = &ov4689_internal_ops;
>  	sd->flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;

I would move this line above, just before calling
ov4689_initialize_controls(), to group all subdev initialization code.

> +	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  
>  	ov4689->pad.flags = MEDIA_PAD_FL_SOURCE;
> -	sd->entity.function = MEDIA_ENT_F_CAM_SENSOR;
>  	ret = media_entity_pads_init(&sd->entity, 1, &ov4689->pad);
>  	if (ret < 0)
>  		goto err_power_off;
>  
> +	sd->state_lock = ov4689->ctrl_handler.lock;
> +	ret = v4l2_subdev_init_finalize(sd);
> +

No need for a blank line.

With these small changes,

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> +	if (ret) {
> +		dev_err(dev, "Could not register v4l2 device\n");
> +		goto err_clean_entity;
> +	}
> +
>  	ret = v4l2_async_register_subdev_sensor(sd);
>  	if (ret) {
>  		dev_err(dev, "v4l2 async register subdev failed\n");
> -		goto err_clean_entity;
> +		goto err_clean_subdev;
>  	}
>  
>  	pm_runtime_set_active(dev);
> @@ -898,14 +888,14 @@ static int ov4689_probe(struct i2c_client *client)
>  
>  	return 0;
>  
> +err_clean_subdev:
> +	v4l2_subdev_cleanup(sd);
>  err_clean_entity:
>  	media_entity_cleanup(&sd->entity);
>  err_power_off:
>  	ov4689_power_off(dev);
>  err_free_handler:
>  	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
> -err_destroy_mutex:
> -	mutex_destroy(&ov4689->mutex);
>  
>  	return ret;
>  }
> @@ -917,9 +907,8 @@ static void ov4689_remove(struct i2c_client *client)
>  
>  	v4l2_async_unregister_subdev(sd);
>  	media_entity_cleanup(&sd->entity);
> -
> +	v4l2_subdev_cleanup(sd);
>  	v4l2_ctrl_handler_free(&ov4689->ctrl_handler);
> -	mutex_destroy(&ov4689->mutex);
>  
>  	pm_runtime_disable(&client->dev);
>  	if (!pm_runtime_status_suspended(&client->dev))

-- 
Regards,

Laurent Pinchart

