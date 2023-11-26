Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA0B7F932D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 15:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbjKZOsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 09:48:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZOsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 09:48:20 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C61A9B;
        Sun, 26 Nov 2023 06:48:25 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5AD08DFB;
        Sun, 26 Nov 2023 15:47:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701010068;
        bh=GQvB1f29NRf7rmMw9fRPA8EvVRG6R7HLoJtF8Uydx4M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SnQQJzu/xnKa9GVoLKabAOkivHtignn9mASO6t/O0BYT1o/wjkem+6R4jy+ECalQZ
         chJddEKLkT7DwEdv492DFhs96iv3uOy2LlP0VTFFADqsgQ13fD6sLrhFTcokTwV8DJ
         vQpCBAbmjmhKxZJFTgWCLLQbR3RekMfFkw+tkqx0=
Date:   Sun, 26 Nov 2023 16:48:28 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: use subdev active state
Message-ID: <20231126144828.GA12891@pendragon.ideasonboard.com>
References: <20231126103401.2617585-1-tomm.merciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231126103401.2617585-1-tomm.merciai@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tommaso,

Thank you for the patch.

On Sun, Nov 26, 2023 at 11:34:01AM +0100, Tommaso Merciai wrote:
> Port the ov5640 sensor driver to use the subdev active state.
> 
> After the ov5640 configurations steps call v4l2_subdev_init_finalize
> that finalizes the initialization of the subdevice.
> From now we use subdevice active state to simplify format handling and
> locking
> 
> References:
>  - https://patchwork.kernel.org/project/linux-media/patch/20230710155203.92366-6-jacopo.mondi@ideasonboard.com/
>  - https://linuxtv.org/downloads/v4l-dvb-apis/driver-api/v4l2-subdev.html#c.v4l2_subdev_cleanup
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---
>  drivers/media/i2c/ov5640.c | 89 ++++++++++----------------------------
>  1 file changed, 24 insertions(+), 65 deletions(-)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index 3f79a3b77044..44a073d3df64 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -446,9 +446,6 @@ struct ov5640_dev {
>  	struct gpio_desc *pwdn_gpio;
>  	bool   upside_down;
>  
> -	/* lock to protect all members below */
> -	struct mutex lock;
> -
>  	struct v4l2_mbus_framefmt fmt;

This field should go too. The point of using the subdev active state is
to move state information from the device-specific structure to the
subdev state.

Ideally the pending_fmt_change, current_mode, last_mode, current_fr,
frame_interval and pending_mode_change fields should go too. That's more
work and it's probably OK if we keep some of those fields for the time
being.

One low(er) hanging fruit is current_fr and frame_interval, which would
be nice to address soon. Removing them completely will require the "[RFC
PATCH v1 0/4] media: v4l2-subdev: Improve frame interval handling" patch
series ([1]), for which I plan to send a v2 soon. You can submit a v2 of
this patch, dropping the fmt field, without waiting for the improved
frame interval handling. It should however be fairly to merge the
current_fr and frame_interval fields (dropping the ov5640_frame_rate
enum as a result), it would be nice to see that as a patch already.

[1] https://lore.kernel.org/linux-media/20231024005130.28026-1-laurent.pinchart@ideasonboard.com

>  	bool pending_fmt_change;
>  
> @@ -2784,30 +2781,6 @@ static int ov5640_try_frame_interval(struct ov5640_dev *sensor,
>  	return mode ? rate : -EINVAL;
>  }
>  
> -static int ov5640_get_fmt(struct v4l2_subdev *sd,
> -			  struct v4l2_subdev_state *sd_state,
> -			  struct v4l2_subdev_format *format)
> -{
> -	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> -	struct v4l2_mbus_framefmt *fmt;
> -
> -	if (format->pad != 0)
> -		return -EINVAL;
> -
> -	mutex_lock(&sensor->lock);
> -
> -	if (format->which == V4L2_SUBDEV_FORMAT_TRY)
> -		fmt = v4l2_subdev_state_get_format(sd_state, format->pad);
> -	else
> -		fmt = &sensor->fmt;
> -
> -	format->format = *fmt;
> -
> -	mutex_unlock(&sensor->lock);
> -
> -	return 0;
> -}
> -
>  static int ov5640_try_fmt_internal(struct v4l2_subdev *sd,
>  				   struct v4l2_mbus_framefmt *fmt,
>  				   const struct ov5640_mode_info **new_mode)
> @@ -2958,21 +2931,14 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
>  	if (format->pad != 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&sensor->lock);
> -
> -	if (sensor->streaming) {
> -		ret = -EBUSY;
> -		goto out;
> -	}
> +	if (sensor->streaming)
> +		return -EBUSY;
>  
>  	ret = ov5640_try_fmt_internal(sd, mbus_fmt, &new_mode);
>  	if (ret)
> -		goto out;
> +		return ret;
>  
> -	if (format->which == V4L2_SUBDEV_FORMAT_TRY) {
> -		*v4l2_subdev_state_get_format(sd_state, 0) = *mbus_fmt;
> -		goto out;
> -	}
> +	*v4l2_subdev_state_get_format(sd_state, 0) = *mbus_fmt;
>  
>  	if (new_mode != sensor->current_mode) {
>  		sensor->current_fr = new_mode->def_fps;
> @@ -2987,26 +2953,16 @@ static int ov5640_set_fmt(struct v4l2_subdev *sd,
>  
>  	ov5640_update_pixel_rate(sensor);
>  
> -out:
> -	mutex_unlock(&sensor->lock);
> -	return ret;
> +	return 0;
>  }
>  
>  static int ov5640_get_selection(struct v4l2_subdev *sd,
>  				struct v4l2_subdev_state *sd_state,
>  				struct v4l2_subdev_selection *sel)
>  {
> -	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> -	const struct ov5640_mode_info *mode = sensor->current_mode;
> -	const struct ov5640_timings *timings;
> -
>  	switch (sel->target) {
>  	case V4L2_SEL_TGT_CROP: {
> -		mutex_lock(&sensor->lock);
> -		timings = ov5640_timings(sensor, mode);
> -		sel->r = timings->analog_crop;
> -		mutex_unlock(&sensor->lock);
> -
> +		sel->r = *v4l2_subdev_state_get_crop(sd_state, 0);
>  		return 0;
>  	}
>  
> @@ -3441,9 +3397,6 @@ static int ov5640_init_controls(struct ov5640_dev *sensor)
>  
>  	v4l2_ctrl_handler_init(hdl, 32);
>  
> -	/* we can use our own mutex for the ctrl lock */
> -	hdl->lock = &sensor->lock;
> -
>  	/* Clock related controls */
>  	ctrls->pixel_rate = v4l2_ctrl_new_std(hdl, ops, V4L2_CID_PIXEL_RATE,
>  			      ov5640_pixel_rates[OV5640_NUM_PIXEL_RATES - 1],
> @@ -3609,9 +3562,7 @@ static int ov5640_g_frame_interval(struct v4l2_subdev *sd,
>  {
>  	struct ov5640_dev *sensor = to_ov5640_dev(sd);
>  
> -	mutex_lock(&sensor->lock);
>  	fi->interval = sensor->frame_interval;
> -	mutex_unlock(&sensor->lock);
>  
>  	return 0;
>  }
> @@ -3620,13 +3571,14 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
>  				   struct v4l2_subdev_frame_interval *fi)
>  {
>  	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +	struct v4l2_subdev_state *state;
>  	const struct ov5640_mode_info *mode;
>  	int frame_rate, ret = 0;
>  
>  	if (fi->pad != 0)
>  		return -EINVAL;
>  
> -	mutex_lock(&sensor->lock);
> +	state = v4l2_subdev_lock_and_get_active_state(sd);
>  
>  	if (sensor->streaming) {
>  		ret = -EBUSY;
> @@ -3663,7 +3615,7 @@ static int ov5640_s_frame_interval(struct v4l2_subdev *sd,
>  		ov5640_update_pixel_rate(sensor);
>  	}
>  out:
> -	mutex_unlock(&sensor->lock);
> +	v4l2_subdev_unlock_state(state);
>  	return ret;
>  }
>  
> @@ -3694,6 +3646,7 @@ static int ov5640_enum_mbus_code(struct v4l2_subdev *sd,
>  static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>  {
>  	struct ov5640_dev *sensor = to_ov5640_dev(sd);
> +	struct v4l2_subdev_state *state;
>  	int ret = 0;
>  
>  	if (enable) {
> @@ -3708,7 +3661,7 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>  		}
>  	}
>  
> -	mutex_lock(&sensor->lock);
> +	state = v4l2_subdev_lock_and_get_active_state(sd);
>  
>  	if (sensor->streaming == !enable) {
>  		if (enable && sensor->pending_mode_change) {
> @@ -3734,7 +3687,7 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>  	}
>  
>  out:
> -	mutex_unlock(&sensor->lock);
> +	v4l2_subdev_unlock_state(state);
>  
>  	if (!enable || ret) {
>  		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> @@ -3778,7 +3731,7 @@ static const struct v4l2_subdev_video_ops ov5640_video_ops = {
>  static const struct v4l2_subdev_pad_ops ov5640_pad_ops = {
>  	.init_cfg = ov5640_init_cfg,
>  	.enum_mbus_code = ov5640_enum_mbus_code,
> -	.get_fmt = ov5640_get_fmt,
> +	.get_fmt = v4l2_subdev_get_fmt,
>  	.set_fmt = ov5640_set_fmt,
>  	.get_selection = ov5640_get_selection,
>  	.enum_frame_size = ov5640_enum_frame_size,
> @@ -3918,8 +3871,6 @@ static int ov5640_probe(struct i2c_client *client)
>  	if (ret)
>  		goto entity_cleanup;
>  
> -	mutex_init(&sensor->lock);
> -
>  	ret = ov5640_init_controls(sensor);
>  	if (ret)
>  		goto entity_cleanup;
> @@ -3938,9 +3889,16 @@ static int ov5640_probe(struct i2c_client *client)
>  	if (ret)
>  		goto err_pm_runtime;
>  
> +	sensor->sd.state_lock = sensor->ctrls.handler.lock;
> +	ret = v4l2_subdev_init_finalize(&sensor->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "subdev init error: %d\n", ret);
> +		goto err_pm_runtime;
> +	}
> +
>  	ret = v4l2_async_register_subdev_sensor(&sensor->sd);
>  	if (ret)
> -		goto err_pm_runtime;
> +		goto subdev_cleanup;
>  
>  	pm_runtime_set_autosuspend_delay(dev, 1000);
>  	pm_runtime_use_autosuspend(dev);
> @@ -3949,6 +3907,8 @@ static int ov5640_probe(struct i2c_client *client)
>  
>  	return 0;
>  
> +subdev_cleanup:
> +	v4l2_subdev_cleanup(&sensor->sd);
>  err_pm_runtime:
>  	pm_runtime_put_noidle(dev);
>  	pm_runtime_disable(dev);
> @@ -3957,7 +3917,6 @@ static int ov5640_probe(struct i2c_client *client)
>  	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
>  entity_cleanup:
>  	media_entity_cleanup(&sensor->sd.entity);
> -	mutex_destroy(&sensor->lock);
>  	return ret;
>  }
>  
> @@ -3973,9 +3932,9 @@ static void ov5640_remove(struct i2c_client *client)
>  	pm_runtime_set_suspended(dev);
>  
>  	v4l2_async_unregister_subdev(&sensor->sd);
> +	v4l2_subdev_cleanup(sd);
>  	media_entity_cleanup(&sensor->sd.entity);
>  	v4l2_ctrl_handler_free(&sensor->ctrls.handler);
> -	mutex_destroy(&sensor->lock);
>  }
>  
>  static const struct dev_pm_ops ov5640_pm_ops = {

-- 
Regards,

Laurent Pinchart
